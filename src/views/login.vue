<template>
  <div class="container mt-5" style="max-width:400px;">
    <h3 class="text-center mb-4">🔐 เข้าสู่ระบบลูกค้า</h3>

    <div class="card p-4 shadow">
      <div class="mb-3">
        <label class="form-label">ชื่อผู้ใช้</label>
        <input 
          v-model="username" 
          type="text" 
          class="form-control"
          @keyup.enter="login"
          placeholder="กรอกชื่อผู้ใช้"
        />
      </div>

      <div class="mb-3">
        <label class="form-label">รหัสผ่าน</label>
        <input 
          v-model="password" 
          type="password" 
          class="form-control"
          @keyup.enter="login"
          placeholder="กรอกรหัสผ่าน"
        />
      </div>

      <button 
        @click="login" 
        class="btn btn-primary w-100"
        :disabled="loading"
      >
        {{ loading ? 'กำลังเข้าสู่ระบบ...' : 'เข้าสู่ระบบ' }}
      </button>

      <div v-if="error" class="alert alert-danger mt-3">{{ error }}</div>
      <div v-if="success" class="alert alert-success mt-3">{{ success }}</div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      username: "",
      password: "",
      error: "",
      success: "",
      loading: false
    };
  },
  methods: {
    async login() {
      // ตรวจสอบข้อมูลก่อน submit
      if (!this.username || !this.password) {
        this.error = "กรุณากรอกชื่อผู้ใช้และรหัสผ่าน";
        return;
      }

      this.error = "";
      this.success = "";
      this.loading = true;

      try {
        const res = await axios.post(
          "http://localhost:8081/homework/api_php/login.php",
          {
            username: this.username,
            password: this.password,
          }
        );

        if (res.data.success) {
          this.success = "เข้าสู่ระบบสำเร็จ!";
          
          // ✅ บันทึกข้อมูลลูกค้าใน localStorage
          localStorage.setItem("isLoggedIn", "true");
          localStorage.setItem("username", this.username);
          localStorage.setItem("customer_id", res.data.customer_id);
          localStorage.setItem("firstName", res.data.firstName);
          localStorage.setItem("lastName", res.data.lastName);

          // รอ 1 วินาทีแล้วไปหน้าอื่น
          setTimeout(() => {
            this.$router.push("/ass");
          }, 1000);
        } else {
          this.error = res.data.message;
        }
      } catch (err) {
        console.error("Login error:", err);
        this.error = "เกิดข้อผิดพลาดในการเชื่อมต่อ: " + (err.response?.data?.message || err.message);
      } finally {
        this.loading = false;
      }
    },
  },
};
</script>