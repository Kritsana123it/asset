<template>
  <div class="container mt-4 d-flex justify-content-center">
    <div class="w-100">
      <h2 class="mb-3">ตารางครุภัณฑ์</h2>

      <!-- 🔹 ปุ่มเพิ่ม + ตัวเลือกจำนวนแถว -->
      <div class="d-flex justify-content-between align-items-center mb-3">

        <div class="d-flex align-items-center">
          <label class="me-2">แสดงแถวต่อหน้า:</label>
          <select v-model.number="itemsPerPage" class="form-select w-auto">
            <option :value="5">5</option>
            <option :value="10">10</option>
            <option :value="20">20</option>
          </select>
        </div>
      </div>

      <!-- 🏷️ ปุ่มกรองหมวดหมู่ -->
      <div class="mb-3">
        <label class="fw-bold mb-2">หมวดหมู่:</label>
        <div class="d-flex flex-wrap gap-2">
          <button 
            class="btn btn-sm"
            :class="categoryFilter === '' ? 'btn-primary' : 'btn-outline-primary'"
            @click="categoryFilter = ''"
          >
            ทั้งหมด
          </button>
          <button 
            v-for="category in categories" 
            :key="category"
            class="btn btn-sm"
            :class="categoryFilter === category ? 'btn-success' : 'btn-outline-success'"
            @click="categoryFilter = category"
          >
            {{ category }}
          </button>
        </div>
      </div>

      <!-- ✅ ตารางครุภัณฑ์ -->
      <table class="table table-bordered table-striped text-center">
        <thead class="table-primary">
          <tr>
            <th>รหัส</th>
            <th>ชื่อครุภัณฑ์</th>
            <th>หมวดหมู่</th>
            <th>วันที่ซื้อ</th>
            <th>ราคา</th>
            <th>รูปภาพ</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="asset in paginatedAssets" :key="asset.asset_id">
            <td>{{ asset.asset_code }}</td>
            <td>{{ asset.asset_name }}</td>
            <td>
              <span class="badge bg-info">{{ asset.category_id }}</span>
            </td>
            <td>{{ formatDate(asset.purchase_date) }}</td>
            <td>{{ formatPrice(asset.price) }}</td>
            <td>
              <img
                v-if="asset.image"
                :src="'http://localhost:8081/homework/api_php/uploads/' + asset.image"
                width="80"
                class="rounded"
                alt="รูปครุภัณฑ์"
              />
              <span v-else class="text-muted">ไม่มีรูป</span>
            </td>
          </tr>
        </tbody>
      </table>

      <div v-if="loading" class="text-center"><p>กำลังโหลดข้อมูล...</p></div>
      <div v-if="error" class="alert alert-danger">{{ error }}</div>

      <!-- ✅ ระบบแบ่งหน้า -->
      <nav v-if="totalPages > 1" class="mt-3">
        <ul class="pagination justify-content-center">
          <li class="page-item" :class="{ disabled: currentPage === 1 }">
            <button class="page-link" @click="prevPage">ก่อนหน้า</button>
          </li>

          <li
            class="page-item"
            v-for="page in totalPages"
            :key="page"
            :class="{ active: currentPage === page }"
          >
            <button class="page-link" @click="goToPage(page)">{{ page }}</button>
          </li>

          <li class="page-item" :class="{ disabled: currentPage === totalPages }">
            <button class="page-link" @click="nextPage">ถัดไป</button>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed, watch } from "vue";

export default {
  name: "AssetList",
  setup() {
    const assets = ref([]);
    const categories = ref([
      'อุปกรณ์คอมพิวเตอร์',
      'อุปกรณ์สำนักงาน',
      'เครื่องใช้ไฟฟ้า',
      'เฟอร์นิเจอร์',
      'อื่นๆ'
    ]);
    const loading = ref(true);
    const error = ref(null);
    const isEditMode = ref(false);
    const categoryFilter = ref("");
    const editForm = ref({
      asset_id: null,
      asset_code: "",
      asset_name: "",
      category_id: "",
      purchase_date: "",
      price: "",
      image: ""
    });
    const newImageFile = ref(null);
    let modalInstance = null;

    // ✅ Pagination
    const currentPage = ref(1);
    const itemsPerPage = ref(5);

    // จัดรูปแบบวันที่
    const formatDate = (dateString) => {
      if (!dateString) return '-';
      const date = new Date(dateString);
      return date.toLocaleDateString('th-TH', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      });
    };

    // จัดรูปแบบราคา
    const formatPrice = (price) => {
      return new Intl.NumberFormat('th-TH', {
        style: 'currency',
        currency: 'THB'
      }).format(price);
    };

    // กรองตามหมวดหมู่
    const filteredAssets = computed(() => {
      if (categoryFilter.value === "") return assets.value;
      return assets.value.filter(a => a.category_id === categoryFilter.value);
    });

    const totalPages = computed(() =>
      Math.ceil(filteredAssets.value.length / itemsPerPage.value)
    );

    const paginatedAssets = computed(() => {
      const start = (currentPage.value - 1) * itemsPerPage.value;
      return filteredAssets.value.slice(start, start + itemsPerPage.value);
    });

    const goToPage = (page) => {
      currentPage.value = page;
    };

    const nextPage = () => {
      if (currentPage.value < totalPages.value) currentPage.value++;
    };

    const prevPage = () => {
      if (currentPage.value > 1) currentPage.value--;
    };

    // รีเซ็ตหน้ากลับไปหน้า 1
    watch([itemsPerPage, categoryFilter], () => {
      currentPage.value = 1;
    });

    // โหลดข้อมูล
    const fetchAssets = async () => {
      try {
        const res = await fetch("http://localhost:8081/homework/api_php/api_asset.php");
        const data = await res.json();
        assets.value = data.success ? data.data : [];
      } catch (err) {
        error.value = err.message;
      } finally {
        loading.value = false;
      }
    };

    onMounted(fetchAssets);

    return {
      assets,
      categories,
      loading,
      error,
      categoryFilter,
      formatDate,
      formatPrice,
      // Pagination
      currentPage,
      totalPages,
      paginatedAssets,
      itemsPerPage,
      goToPage,
      nextPage,
      prevPage
    };
  }
};
</script>

<style scoped>
.badge { font-size: 0.85rem; }
.rounded { border-radius: 8px; }
</style>
