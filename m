Return-Path: <stable+bounces-160285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F5AFA3E5
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78EA917E37F
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 09:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3341FCD1F;
	Sun,  6 Jul 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k4Eogy7w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6211F460B;
	Sun,  6 Jul 2025 09:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793231; cv=none; b=CBeBjaY2ZpAdp8cOqDb/mVGqHNtjOhJ9QgrpHK/V+EWDBnJlpSMQYuOekxg9zuf/cLO38YMgG0WnMZHPdvdrtj0Kfntl+44OdPsrNvNeFoycF8v0hUkNly3V8r/1aePIvYeIMNQzd3/wmvg1QPBqkKiOgnOXR6AuJy2tlhAPgxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793231; c=relaxed/simple;
	bh=tQYSVd8mSH4ArqZMHlyjWRcbILvJ6VpkcTlvZDXDgfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hW4cyQJNpsTBMCkZy9pAVol+tYbNN/3Z12KV0GTf6aCqs9jUBo4IoY6cX8ZAKWCnu/JzFcu2kKHZdveKtQOpPprspcOh/+IfULaUnaTEvegk2NH7K8x20ZmUfiUFGo5Ff5p8MXtnMY6KZzJEcXoMtO7W4o8jrDu+KbbHEXoCbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k4Eogy7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0E5C4CEED;
	Sun,  6 Jul 2025 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751793230;
	bh=tQYSVd8mSH4ArqZMHlyjWRcbILvJ6VpkcTlvZDXDgfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4Eogy7wEXpLZAT4DH9/SZL5KNRrR01dKk5RK8K8Ikkw4s/NeNg8rJjFvDQ+AiNxe
	 MGSROct9RYuanj6xlREh99AX5ulgvFQ4KHnHQXOtBYfVamFOTIIGbsc34w15f0yxAY
	 gugiZ4PJ18JUYoTYXtc5HzM9UepH145Y8mFEaiYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.36
Date: Sun,  6 Jul 2025 11:13:38 +0200
Message-ID: <2025070638-equation-negate-3e2b@gregkh>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025070638-embark-sanitary-05ae@gregkh>
References: <2025070638-embark-sanitary-05ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd..6ba0325039be 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -45,7 +45,7 @@ allOf:
                   - ns16550
                   - ns16550a
     then:
-      anyOf:
+      oneOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
 
diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index c5579a5412fc..043f205bc1ae 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -227,7 +227,7 @@ definitions:
         type: u8
         doc: log(P_max / (qth-max - qth-min))
       -
-        name: Scell_log
+        name: Scell-log
         type: u8
         doc: cell size for idle damping
       -
@@ -248,7 +248,7 @@ definitions:
         name: DPs
         type: u32
       -
-        name: def_DP
+        name: def-DP
         type: u32
       -
         name: grio
diff --git a/Makefile b/Makefile
index 535df76f6f78..7012820523ff 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 35
+SUBLEVEL = 36
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 11d99d8b34a2..66d010a9e8c3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -227,6 +227,16 @@ vcc5v0_usb: vcc5v0-usb {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	vcca_0v9: vcca-0v9 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcca_0v9";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
+
 	vdd_log: vdd-log {
 		compatible = "pwm-regulator";
 		pwms = <&pwm2 0 25000 1>;
@@ -312,6 +322,8 @@ &gmac {
 };
 
 &hdmi {
+	avdd-0v9-supply = <&vcca_0v9>;
+	avdd-1v8-supply = <&vcc1v8_dvp>;
 	ddc-i2c-bus = <&i2c3>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&hdmi_cec>;
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ebbce134917c..6efa95ad033a 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -169,7 +169,7 @@
 		break;							\
 	case 4:								\
 		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
-				__ret, __ptr, (long), __old, __new);	\
+				__ret, __ptr, (long)(int)(long), __old, __new);	\
 		break;							\
 	case 8:								\
 		__arch_cmpxchg(".d", ".d" sc_sfx, prepend, append,	\
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 479550cdb440..03881122506a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -916,7 +916,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
-#define TASK_SIZE_MAX	LONG_MAX
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 36ac96eac9c9..d14bfc23e315 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -429,7 +429,7 @@ int handle_misaligned_load(struct pt_regs *regs)
 
 	val.data_u64 = 0;
 	if (user_mode(regs)) {
-		if (copy_from_user_nofault(&val, (u8 __user *)addr, len))
+		if (copy_from_user(&val, (u8 __user *)addr, len))
 			return -1;
 	} else {
 		memcpy(&val, (u8 *)addr, len);
@@ -530,7 +530,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 		return -EOPNOTSUPP;
 
 	if (user_mode(regs)) {
-		if (copy_to_user_nofault((u8 __user *)addr, &val, len))
+		if (copy_to_user((u8 __user *)addr, &val, len))
 			return -1;
 	} else {
 		memcpy((u8 *)addr, &val, len);
diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index b81672729887..b2e4b81763f8 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -24,7 +24,20 @@ void flush_icache_all(void)
 
 	if (num_online_cpus() < 2)
 		return;
-	else if (riscv_use_sbi_for_rfence())
+
+	/*
+	 * Make sure all previous writes to the D$ are ordered before making
+	 * the IPI. The RISC-V spec states that a hart must execute a data fence
+	 * before triggering a remote fence.i in order to make the modification
+	 * visable for remote harts.
+	 *
+	 * IPIs on RISC-V are triggered by MMIO writes to either CLINT or
+	 * S-IMSIC, so the fence ensures previous data writes "happen before"
+	 * the MMIO.
+	 */
+	RISCV_FENCE(w, o);
+
+	if (riscv_use_sbi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index b4f8b8e60564..592b899820d6 100644
--- a/arch/um/drivers/ubd_user.c
+++ b/arch/um/drivers/ubd_user.c
@@ -41,7 +41,7 @@ int start_io_thread(unsigned long sp, int *fd_out)
 	*fd_out = fds[1];
 
 	err = os_set_fd_block(*fd_out, 0);
-	err = os_set_fd_block(kernel_fd, 0);
+	err |= os_set_fd_block(kernel_fd, 0);
 	if (err) {
 		printk("start_io_thread - failed to set nonblocking I/O.\n");
 		goto out_close;
diff --git a/arch/um/include/asm/asm-prototypes.h b/arch/um/include/asm/asm-prototypes.h
index 5898a26daa0d..408b31d59127 100644
--- a/arch/um/include/asm/asm-prototypes.h
+++ b/arch/um/include/asm/asm-prototypes.h
@@ -1 +1,6 @@
 #include <asm-generic/asm-prototypes.h>
+#include <asm/checksum.h>
+
+#ifdef CONFIG_UML_X86
+extern void cmpxchg8b_emu(void);
+#endif
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 97c8df9c4401..9077bdb26cc3 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -17,6 +17,122 @@
 #include <os.h>
 #include <skas.h>
 
+/*
+ * NOTE: UML does not have exception tables. As such, this is almost a copy
+ * of the code in mm/memory.c, only adjusting the logic to simply check whether
+ * we are coming from the kernel instead of doing an additional lookup in the
+ * exception table.
+ * We can do this simplification because we never get here if the exception was
+ * fixable.
+ */
+static inline bool get_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
+{
+	if (likely(mmap_read_trylock(mm)))
+		return true;
+
+	if (!is_user)
+		return false;
+
+	return !mmap_read_lock_killable(mm);
+}
+
+static inline bool mmap_upgrade_trylock(struct mm_struct *mm)
+{
+	/*
+	 * We don't have this operation yet.
+	 *
+	 * It should be easy enough to do: it's basically a
+	 *    atomic_long_try_cmpxchg_acquire()
+	 * from RWSEM_READER_BIAS -> RWSEM_WRITER_LOCKED, but
+	 * it also needs the proper lockdep magic etc.
+	 */
+	return false;
+}
+
+static inline bool upgrade_mmap_lock_carefully(struct mm_struct *mm, bool is_user)
+{
+	mmap_read_unlock(mm);
+	if (!is_user)
+		return false;
+
+	return !mmap_write_lock_killable(mm);
+}
+
+/*
+ * Helper for page fault handling.
+ *
+ * This is kind of equivalend to "mmap_read_lock()" followed
+ * by "find_extend_vma()", except it's a lot more careful about
+ * the locking (and will drop the lock on failure).
+ *
+ * For example, if we have a kernel bug that causes a page
+ * fault, we don't want to just use mmap_read_lock() to get
+ * the mm lock, because that would deadlock if the bug were
+ * to happen while we're holding the mm lock for writing.
+ *
+ * So this checks the exception tables on kernel faults in
+ * order to only do this all for instructions that are actually
+ * expected to fault.
+ *
+ * We can also actually take the mm lock for writing if we
+ * need to extend the vma, which helps the VM layer a lot.
+ */
+static struct vm_area_struct *
+um_lock_mm_and_find_vma(struct mm_struct *mm,
+			unsigned long addr, bool is_user)
+{
+	struct vm_area_struct *vma;
+
+	if (!get_mmap_lock_carefully(mm, is_user))
+		return NULL;
+
+	vma = find_vma(mm, addr);
+	if (likely(vma && (vma->vm_start <= addr)))
+		return vma;
+
+	/*
+	 * Well, dang. We might still be successful, but only
+	 * if we can extend a vma to do so.
+	 */
+	if (!vma || !(vma->vm_flags & VM_GROWSDOWN)) {
+		mmap_read_unlock(mm);
+		return NULL;
+	}
+
+	/*
+	 * We can try to upgrade the mmap lock atomically,
+	 * in which case we can continue to use the vma
+	 * we already looked up.
+	 *
+	 * Otherwise we'll have to drop the mmap lock and
+	 * re-take it, and also look up the vma again,
+	 * re-checking it.
+	 */
+	if (!mmap_upgrade_trylock(mm)) {
+		if (!upgrade_mmap_lock_carefully(mm, is_user))
+			return NULL;
+
+		vma = find_vma(mm, addr);
+		if (!vma)
+			goto fail;
+		if (vma->vm_start <= addr)
+			goto success;
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto fail;
+	}
+
+	if (expand_stack_locked(vma, addr))
+		goto fail;
+
+success:
+	mmap_write_downgrade(mm);
+	return vma;
+
+fail:
+	mmap_write_unlock(mm);
+	return NULL;
+}
+
 /*
  * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
  * segv().
@@ -43,21 +159,10 @@ int handle_page_fault(unsigned long address, unsigned long ip,
 	if (is_user)
 		flags |= FAULT_FLAG_USER;
 retry:
-	mmap_read_lock(mm);
-	vma = find_vma(mm, address);
-	if (!vma)
-		goto out;
-	if (vma->vm_start <= address)
-		goto good_area;
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto out;
-	if (is_user && !ARCH_IS_STACKGROW(address))
-		goto out;
-	vma = expand_stack(mm, address);
+	vma = um_lock_mm_and_find_vma(mm, address, is_user);
 	if (!vma)
 		goto out_nosemaphore;
 
-good_area:
 	*code_out = SEGV_ACCERR;
 	if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
diff --git a/arch/x86/include/uapi/asm/debugreg.h b/arch/x86/include/uapi/asm/debugreg.h
index 0007ba077c0c..41da492dfb01 100644
--- a/arch/x86/include/uapi/asm/debugreg.h
+++ b/arch/x86/include/uapi/asm/debugreg.h
@@ -15,7 +15,26 @@
    which debugging register was responsible for the trap.  The other bits
    are either reserved or not of interest to us. */
 
-/* Define reserved bits in DR6 which are always set to 1 */
+/*
+ * Define bits in DR6 which are set to 1 by default.
+ *
+ * This is also the DR6 architectural value following Power-up, Reset or INIT.
+ *
+ * Note, with the introduction of Bus Lock Detection (BLD) and Restricted
+ * Transactional Memory (RTM), the DR6 register has been modified:
+ *
+ * 1) BLD flag (bit 11) is no longer reserved to 1 if the CPU supports
+ *    Bus Lock Detection.  The assertion of a bus lock could clear it.
+ *
+ * 2) RTM flag (bit 16) is no longer reserved to 1 if the CPU supports
+ *    restricted transactional memory.  #DB occurred inside an RTM region
+ *    could clear it.
+ *
+ * Apparently, DR6.BLD and DR6.RTM are active low bits.
+ *
+ * As a result, DR6_RESERVED is an incorrect name now, but it is kept for
+ * compatibility.
+ */
 #define DR6_RESERVED	(0xFFFF0FF0)
 
 #define DR_TRAP0	(0x1)		/* db0 */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b48775445523..a11c61fd7d52 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2145,20 +2145,16 @@ EXPORT_PER_CPU_SYMBOL(__stack_chk_guard);
 
 #endif	/* CONFIG_X86_64 */
 
-/*
- * Clear all 6 debug registers:
- */
-static void clear_all_debug_regs(void)
+static void initialize_debug_regs(void)
 {
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		/* Ignore db4, db5 */
-		if ((i == 4) || (i == 5))
-			continue;
-
-		set_debugreg(0, i);
-	}
+	/* Control register first -- to make sure everything is disabled. */
+	set_debugreg(0, 7);
+	set_debugreg(DR6_RESERVED, 6);
+	/* dr5 and dr4 don't exist */
+	set_debugreg(0, 3);
+	set_debugreg(0, 2);
+	set_debugreg(0, 1);
+	set_debugreg(0, 0);
 }
 
 #ifdef CONFIG_KGDB
@@ -2319,7 +2315,7 @@ void cpu_init(void)
 
 	load_mm_ldt(&init_mm);
 
-	clear_all_debug_regs();
+	initialize_debug_regs();
 	dbg_restore_debug_regs();
 
 	doublefault_init_cpu_tss();
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 8f62e0666dea..8abe60919e2f 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -119,7 +119,6 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 {
 	struct xregs_state __user *x = buf;
 	struct _fpx_sw_bytes sw_bytes = {};
-	u32 xfeatures;
 	int err;
 
 	/* Setup the bytes not touched by the [f]xsave and reserved for SW. */
@@ -132,12 +131,6 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	err |= __put_user(FP_XSTATE_MAGIC2,
 			  (__u32 __user *)(buf + fpstate->user_size));
 
-	/*
-	 * Read the xfeatures which we copied (directly from the cpu or
-	 * from the state in task struct) to the user buffers.
-	 */
-	err |= __get_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
-
 	/*
 	 * For legacy compatible, we always set FP/SSE bits in the bit
 	 * vector while saving the state to the user context. This will
@@ -149,9 +142,7 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	 * header as well as change any contents in the memory layout.
 	 * xrestore as part of sigreturn will capture all the changes.
 	 */
-	xfeatures |= XFEATURE_MASK_FPSSE;
-
-	err |= __put_user(xfeatures, (__u32 __user *)&x->header.xfeatures);
+	err |= set_xfeature_in_sigframe(x, XFEATURE_MASK_FPSSE);
 
 	return !err;
 }
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index aa16f1a1bbcf..f7d8f3d73599 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -69,21 +69,31 @@ static inline u64 xfeatures_mask_independent(void)
 	return fpu_kernel_cfg.independent_features;
 }
 
+static inline int set_xfeature_in_sigframe(struct xregs_state __user *xbuf, u64 mask)
+{
+	u64 xfeatures;
+	int err;
+
+	/* Read the xfeatures value already saved in the user buffer */
+	err  = __get_user(xfeatures, &xbuf->header.xfeatures);
+	xfeatures |= mask;
+	err |= __put_user(xfeatures, &xbuf->header.xfeatures);
+
+	return err;
+}
+
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 mask, u32 pkru)
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	u64 xstate_bv;
 	int err;
 
 	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
 		return 0;
 
 	/* Mark PKRU as in-use so that it is restored correctly. */
-	xstate_bv = (mask & xfeatures_in_use()) | XFEATURE_MASK_PKRU;
-
-	err =  __put_user(xstate_bv, &buf->header.xfeatures);
+	err = set_xfeature_in_sigframe(buf, XFEATURE_MASK_PKRU);
 	if (err)
 		return err;
 
@@ -304,7 +314,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkr
 	clac();
 
 	if (!err)
-		err = update_pkru_in_sigframe(buf, mask, pkru);
+		err = update_pkru_in_sigframe(buf, pkru);
 
 	return err;
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index b18fc7539b8d..243f3bc9b4dc 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -977,24 +977,32 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
 #endif
 }
 
-static __always_inline unsigned long debug_read_clear_dr6(void)
+static __always_inline unsigned long debug_read_reset_dr6(void)
 {
 	unsigned long dr6;
 
+	get_debugreg(dr6, 6);
+	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
+
 	/*
 	 * The Intel SDM says:
 	 *
-	 *   Certain debug exceptions may clear bits 0-3. The remaining
-	 *   contents of the DR6 register are never cleared by the
-	 *   processor. To avoid confusion in identifying debug
-	 *   exceptions, debug handlers should clear the register before
-	 *   returning to the interrupted task.
+	 *   Certain debug exceptions may clear bits 0-3 of DR6.
+	 *
+	 *   BLD induced #DB clears DR6.BLD and any other debug
+	 *   exception doesn't modify DR6.BLD.
 	 *
-	 * Keep it simple: clear DR6 immediately.
+	 *   RTM induced #DB clears DR6.RTM and any other debug
+	 *   exception sets DR6.RTM.
+	 *
+	 *   To avoid confusion in identifying debug exceptions,
+	 *   debug handlers should set DR6.BLD and DR6.RTM, and
+	 *   clear other DR6 bits before returning.
+	 *
+	 * Keep it simple: write DR6 with its architectural reset
+	 * value 0xFFFF0FF0, defined as DR6_RESERVED, immediately.
 	 */
-	get_debugreg(dr6, 6);
 	set_debugreg(DR6_RESERVED, 6);
-	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
 	return dr6;
 }
@@ -1194,13 +1202,13 @@ static noinstr void exc_debug_user(struct pt_regs *regs, unsigned long dr6)
 /* IST stack entry */
 DEFINE_IDTENTRY_DEBUG(exc_debug)
 {
-	exc_debug_kernel(regs, debug_read_clear_dr6());
+	exc_debug_kernel(regs, debug_read_reset_dr6());
 }
 
 /* User entry, runs on regular task stack */
 DEFINE_IDTENTRY_DEBUG_USER(exc_debug)
 {
-	exc_debug_user(regs, debug_read_clear_dr6());
+	exc_debug_user(regs, debug_read_reset_dr6());
 }
 
 #ifdef CONFIG_X86_FRED
@@ -1219,7 +1227,7 @@ DEFINE_FREDENTRY_DEBUG(exc_debug)
 {
 	/*
 	 * FRED #DB stores DR6 on the stack in the format which
-	 * debug_read_clear_dr6() returns for the IDT entry points.
+	 * debug_read_reset_dr6() returns for the IDT entry points.
 	 */
 	unsigned long dr6 = fred_event_data(regs);
 
@@ -1234,7 +1242,7 @@ DEFINE_FREDENTRY_DEBUG(exc_debug)
 /* 32 bit does not have separate entry points. */
 DEFINE_IDTENTRY_RAW(exc_debug)
 {
-	unsigned long dr6 = debug_read_clear_dr6();
+	unsigned long dr6 = debug_read_reset_dr6();
 
 	if (user_mode(regs))
 		exc_debug_user(regs, dr6);
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index b07824500363..ddc144657efa 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -20,6 +20,9 @@
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
+/* Do not call this directly. Declared for export type visibility. */
+extern __visible __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
+
 /**
  * csum_fold - Fold and invert a 32bit checksum.
  * sum: 32bit unfolded sum
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index 05a0d99ce95c..1edf6e564402 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -423,6 +423,88 @@ static int dct_active_set(void *data, u64 active_percent)
 
 DEFINE_DEBUGFS_ATTRIBUTE(ivpu_dct_fops, dct_active_get, dct_active_set, "%llu\n");
 
+static int priority_bands_show(struct seq_file *s, void *v)
+{
+	struct ivpu_device *vdev = s->private;
+	struct ivpu_hw_info *hw = vdev->hw;
+
+	for (int band = VPU_JOB_SCHEDULING_PRIORITY_BAND_IDLE;
+	     band < VPU_JOB_SCHEDULING_PRIORITY_BAND_COUNT; band++) {
+		switch (band) {
+		case VPU_JOB_SCHEDULING_PRIORITY_BAND_IDLE:
+			seq_puts(s, "Idle:     ");
+			break;
+
+		case VPU_JOB_SCHEDULING_PRIORITY_BAND_NORMAL:
+			seq_puts(s, "Normal:   ");
+			break;
+
+		case VPU_JOB_SCHEDULING_PRIORITY_BAND_FOCUS:
+			seq_puts(s, "Focus:    ");
+			break;
+
+		case VPU_JOB_SCHEDULING_PRIORITY_BAND_REALTIME:
+			seq_puts(s, "Realtime: ");
+			break;
+		}
+
+		seq_printf(s, "grace_period %9u process_grace_period %9u process_quantum %9u\n",
+			   hw->hws.grace_period[band], hw->hws.process_grace_period[band],
+			   hw->hws.process_quantum[band]);
+	}
+
+	return 0;
+}
+
+static int priority_bands_fops_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, priority_bands_show, inode->i_private);
+}
+
+static ssize_t
+priority_bands_fops_write(struct file *file, const char __user *user_buf, size_t size, loff_t *pos)
+{
+	struct seq_file *s = file->private_data;
+	struct ivpu_device *vdev = s->private;
+	char buf[64];
+	u32 grace_period;
+	u32 process_grace_period;
+	u32 process_quantum;
+	u32 band;
+	int ret;
+
+	if (size >= sizeof(buf))
+		return -EINVAL;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, pos, user_buf, size);
+	if (ret < 0)
+		return ret;
+
+	buf[size] = '\0';
+	ret = sscanf(buf, "%u %u %u %u", &band, &grace_period, &process_grace_period,
+		     &process_quantum);
+	if (ret != 4)
+		return -EINVAL;
+
+	if (band >= VPU_JOB_SCHEDULING_PRIORITY_BAND_COUNT)
+		return -EINVAL;
+
+	vdev->hw->hws.grace_period[band] = grace_period;
+	vdev->hw->hws.process_grace_period[band] = process_grace_period;
+	vdev->hw->hws.process_quantum[band] = process_quantum;
+
+	return size;
+}
+
+static const struct file_operations ivpu_hws_priority_bands_fops = {
+	.owner = THIS_MODULE,
+	.open = priority_bands_fops_open,
+	.write = priority_bands_fops_write,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 void ivpu_debugfs_init(struct ivpu_device *vdev)
 {
 	struct dentry *debugfs_root = vdev->drm.debugfs_root;
@@ -445,6 +527,8 @@ void ivpu_debugfs_init(struct ivpu_device *vdev)
 			    &fw_trace_hw_comp_mask_fops);
 	debugfs_create_file("fw_trace_level", 0200, debugfs_root, vdev,
 			    &fw_trace_level_fops);
+	debugfs_create_file("hws_priority_bands", 0200, debugfs_root, vdev,
+			    &ivpu_hws_priority_bands_fops);
 
 	debugfs_create_file("reset_engine", 0200, debugfs_root, vdev,
 			    &ivpu_reset_engine_fops);
diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 67d56a944d54..00208c4a6580 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -102,6 +102,8 @@ static void file_priv_release(struct kref *ref)
 	pm_runtime_get_sync(vdev->drm.dev);
 	mutex_lock(&vdev->context_list_lock);
 	file_priv_unbind(vdev, file_priv);
+	drm_WARN_ON(&vdev->drm, !xa_empty(&file_priv->cmdq_xa));
+	xa_destroy(&file_priv->cmdq_xa);
 	mutex_unlock(&vdev->context_list_lock);
 	pm_runtime_put_autosuspend(vdev->drm.dev);
 
@@ -261,6 +263,10 @@ static int ivpu_open(struct drm_device *dev, struct drm_file *file)
 	file_priv->job_limit.min = FIELD_PREP(IVPU_JOB_ID_CONTEXT_MASK, (file_priv->ctx.id - 1));
 	file_priv->job_limit.max = file_priv->job_limit.min | IVPU_JOB_ID_JOB_MASK;
 
+	xa_init_flags(&file_priv->cmdq_xa, XA_FLAGS_ALLOC1);
+	file_priv->cmdq_limit.min = IVPU_CMDQ_MIN_ID;
+	file_priv->cmdq_limit.max = IVPU_CMDQ_MAX_ID;
+
 	mutex_unlock(&vdev->context_list_lock);
 	drm_dev_exit(idx);
 
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 1fe6a3bd4e36..f2ba3ed8b3fc 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -50,11 +50,11 @@
 #define IVPU_JOB_ID_JOB_MASK		GENMASK(7, 0)
 #define IVPU_JOB_ID_CONTEXT_MASK	GENMASK(31, 8)
 
-#define IVPU_NUM_ENGINES       2
 #define IVPU_NUM_PRIORITIES    4
-#define IVPU_NUM_CMDQS_PER_CTX (IVPU_NUM_ENGINES * IVPU_NUM_PRIORITIES)
+#define IVPU_NUM_CMDQS_PER_CTX (IVPU_NUM_PRIORITIES)
 
-#define IVPU_CMDQ_INDEX(engine, priority) ((engine) * IVPU_NUM_PRIORITIES + (priority))
+#define IVPU_CMDQ_MIN_ID 1
+#define IVPU_CMDQ_MAX_ID 255
 
 #define IVPU_PLATFORM_SILICON 0
 #define IVPU_PLATFORM_SIMICS  2
@@ -174,13 +174,15 @@ struct ivpu_file_priv {
 	struct kref ref;
 	struct ivpu_device *vdev;
 	struct mutex lock; /* Protects cmdq */
-	struct ivpu_cmdq *cmdq[IVPU_NUM_CMDQS_PER_CTX];
+	struct xarray cmdq_xa;
 	struct ivpu_mmu_context ctx;
 	struct mutex ms_lock; /* Protects ms_instance_list, ms_info_bo */
 	struct list_head ms_instance_list;
 	struct ivpu_bo *ms_info_bo;
 	struct xa_limit job_limit;
 	u32 job_id_next;
+	struct xa_limit cmdq_limit;
+	u32 cmdq_id_next;
 	bool has_mmu_faults;
 	bool bound;
 	bool aborted;
diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
index 1214f155afa1..37ef8ce64210 100644
--- a/drivers/accel/ivpu/ivpu_hw.c
+++ b/drivers/accel/ivpu/ivpu_hw.c
@@ -110,6 +110,26 @@ static void timeouts_init(struct ivpu_device *vdev)
 	}
 }
 
+static void priority_bands_init(struct ivpu_device *vdev)
+{
+	/* Idle */
+	vdev->hw->hws.grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_IDLE] = 0;
+	vdev->hw->hws.process_grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_IDLE] = 50000;
+	vdev->hw->hws.process_quantum[VPU_JOB_SCHEDULING_PRIORITY_BAND_IDLE] = 160000;
+	/* Normal */
+	vdev->hw->hws.grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_NORMAL] = 50000;
+	vdev->hw->hws.process_grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_NORMAL] = 50000;
+	vdev->hw->hws.process_quantum[VPU_JOB_SCHEDULING_PRIORITY_BAND_NORMAL] = 300000;
+	/* Focus */
+	vdev->hw->hws.grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_FOCUS] = 50000;
+	vdev->hw->hws.process_grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_FOCUS] = 50000;
+	vdev->hw->hws.process_quantum[VPU_JOB_SCHEDULING_PRIORITY_BAND_FOCUS] = 200000;
+	/* Realtime */
+	vdev->hw->hws.grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_REALTIME] = 0;
+	vdev->hw->hws.process_grace_period[VPU_JOB_SCHEDULING_PRIORITY_BAND_REALTIME] = 50000;
+	vdev->hw->hws.process_quantum[VPU_JOB_SCHEDULING_PRIORITY_BAND_REALTIME] = 200000;
+}
+
 static void memory_ranges_init(struct ivpu_device *vdev)
 {
 	if (ivpu_hw_ip_gen(vdev) == IVPU_HW_IP_37XX) {
@@ -248,6 +268,7 @@ int ivpu_hw_init(struct ivpu_device *vdev)
 {
 	ivpu_hw_btrs_info_init(vdev);
 	ivpu_hw_btrs_freq_ratios_init(vdev);
+	priority_bands_init(vdev);
 	memory_ranges_init(vdev);
 	platform_init(vdev);
 	wa_init(vdev);
diff --git a/drivers/accel/ivpu/ivpu_hw.h b/drivers/accel/ivpu/ivpu_hw.h
index 1e85306bcd06..1c016b99a0fd 100644
--- a/drivers/accel/ivpu/ivpu_hw.h
+++ b/drivers/accel/ivpu/ivpu_hw.h
@@ -45,6 +45,11 @@ struct ivpu_hw_info {
 		u8 pn_ratio;
 		u32 profiling_freq;
 	} pll;
+	struct {
+		u32 grace_period[VPU_HWS_NUM_PRIORITY_BANDS];
+		u32 process_quantum[VPU_HWS_NUM_PRIORITY_BANDS];
+		u32 process_grace_period[VPU_HWS_NUM_PRIORITY_BANDS];
+	} hws;
 	u32 tile_fuse;
 	u32 sku;
 	u16 config;
diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index 27121c66e48f..e631098718b1 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -60,6 +60,7 @@ static int ivpu_preemption_buffers_create(struct ivpu_device *vdev,
 
 err_free_primary:
 	ivpu_bo_free(cmdq->primary_preempt_buf);
+	cmdq->primary_preempt_buf = NULL;
 	return -ENOMEM;
 }
 
@@ -69,10 +70,10 @@ static void ivpu_preemption_buffers_free(struct ivpu_device *vdev,
 	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		return;
 
-	drm_WARN_ON(&vdev->drm, !cmdq->primary_preempt_buf);
-	drm_WARN_ON(&vdev->drm, !cmdq->secondary_preempt_buf);
-	ivpu_bo_free(cmdq->primary_preempt_buf);
-	ivpu_bo_free(cmdq->secondary_preempt_buf);
+	if (cmdq->primary_preempt_buf)
+		ivpu_bo_free(cmdq->primary_preempt_buf);
+	if (cmdq->secondary_preempt_buf)
+		ivpu_bo_free(cmdq->secondary_preempt_buf);
 }
 
 static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
@@ -85,27 +86,16 @@ static struct ivpu_cmdq *ivpu_cmdq_alloc(struct ivpu_file_priv *file_priv)
 	if (!cmdq)
 		return NULL;
 
-	ret = xa_alloc_cyclic(&vdev->db_xa, &cmdq->db_id, NULL, vdev->db_limit, &vdev->db_next,
-			      GFP_KERNEL);
-	if (ret < 0) {
-		ivpu_err(vdev, "Failed to allocate doorbell id: %d\n", ret);
-		goto err_free_cmdq;
-	}
-
 	cmdq->mem = ivpu_bo_create_global(vdev, SZ_4K, DRM_IVPU_BO_WC | DRM_IVPU_BO_MAPPABLE);
 	if (!cmdq->mem)
-		goto err_erase_xa;
+		goto err_free_cmdq;
 
 	ret = ivpu_preemption_buffers_create(vdev, file_priv, cmdq);
 	if (ret)
-		goto err_free_cmdq_mem;
+		ivpu_warn(vdev, "Failed to allocate preemption buffers, preemption limited\n");
 
 	return cmdq;
 
-err_free_cmdq_mem:
-	ivpu_bo_free(cmdq->mem);
-err_erase_xa:
-	xa_erase(&vdev->db_xa, cmdq->db_id);
 err_free_cmdq:
 	kfree(cmdq);
 	return NULL;
@@ -128,13 +118,13 @@ static int ivpu_hws_cmdq_init(struct ivpu_file_priv *file_priv, struct ivpu_cmdq
 	struct ivpu_device *vdev = file_priv->vdev;
 	int ret;
 
-	ret = ivpu_jsm_hws_create_cmdq(vdev, file_priv->ctx.id, file_priv->ctx.id, cmdq->db_id,
+	ret = ivpu_jsm_hws_create_cmdq(vdev, file_priv->ctx.id, file_priv->ctx.id, cmdq->id,
 				       task_pid_nr(current), engine,
 				       cmdq->mem->vpu_addr, ivpu_bo_size(cmdq->mem));
 	if (ret)
 		return ret;
 
-	ret = ivpu_jsm_hws_set_context_sched_properties(vdev, file_priv->ctx.id, cmdq->db_id,
+	ret = ivpu_jsm_hws_set_context_sched_properties(vdev, file_priv->ctx.id, cmdq->id,
 							priority);
 	if (ret)
 		return ret;
@@ -148,20 +138,21 @@ static int ivpu_register_db(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *
 	int ret;
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
-		ret = ivpu_jsm_hws_register_db(vdev, file_priv->ctx.id, cmdq->db_id, cmdq->db_id,
+		ret = ivpu_jsm_hws_register_db(vdev, file_priv->ctx.id, cmdq->id, cmdq->db_id,
 					       cmdq->mem->vpu_addr, ivpu_bo_size(cmdq->mem));
 	else
 		ret = ivpu_jsm_register_db(vdev, file_priv->ctx.id, cmdq->db_id,
 					   cmdq->mem->vpu_addr, ivpu_bo_size(cmdq->mem));
 
 	if (!ret)
-		ivpu_dbg(vdev, JOB, "DB %d registered to ctx %d\n", cmdq->db_id, file_priv->ctx.id);
+		ivpu_dbg(vdev, JOB, "DB %d registered to cmdq %d ctx %d\n",
+			 cmdq->db_id, cmdq->id, file_priv->ctx.id);
 
 	return ret;
 }
 
 static int
-ivpu_cmdq_init(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq, u16 engine, u8 priority)
+ivpu_cmdq_init(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq, u8 priority)
 {
 	struct ivpu_device *vdev = file_priv->vdev;
 	struct vpu_job_queue_header *jobq_header;
@@ -177,13 +168,13 @@ ivpu_cmdq_init(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cmdq, u16 eng
 
 	cmdq->jobq = (struct vpu_job_queue *)ivpu_bo_vaddr(cmdq->mem);
 	jobq_header = &cmdq->jobq->header;
-	jobq_header->engine_idx = engine;
+	jobq_header->engine_idx = VPU_ENGINE_COMPUTE;
 	jobq_header->head = 0;
 	jobq_header->tail = 0;
 	wmb(); /* Flush WC buffer for jobq->header */
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW) {
-		ret = ivpu_hws_cmdq_init(file_priv, cmdq, engine, priority);
+		ret = ivpu_hws_cmdq_init(file_priv, cmdq, VPU_ENGINE_COMPUTE, priority);
 		if (ret)
 			return ret;
 	}
@@ -210,9 +201,9 @@ static int ivpu_cmdq_fini(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cm
 	cmdq->db_registered = false;
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW) {
-		ret = ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->db_id);
+		ret = ivpu_jsm_hws_destroy_cmdq(vdev, file_priv->ctx.id, cmdq->id);
 		if (!ret)
-			ivpu_dbg(vdev, JOB, "Command queue %d destroyed\n", cmdq->db_id);
+			ivpu_dbg(vdev, JOB, "Command queue %d destroyed\n", cmdq->id);
 	}
 
 	ret = ivpu_jsm_unregister_db(vdev, cmdq->db_id);
@@ -222,55 +213,104 @@ static int ivpu_cmdq_fini(struct ivpu_file_priv *file_priv, struct ivpu_cmdq *cm
 	return 0;
 }
 
-static struct ivpu_cmdq *ivpu_cmdq_acquire(struct ivpu_file_priv *file_priv, u16 engine,
-					   u8 priority)
+static int ivpu_db_id_alloc(struct ivpu_device *vdev, u32 *db_id)
+{
+	int ret;
+	u32 id;
+
+	ret = xa_alloc_cyclic(&vdev->db_xa, &id, NULL, vdev->db_limit, &vdev->db_next, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	*db_id = id;
+	return 0;
+}
+
+static int ivpu_cmdq_id_alloc(struct ivpu_file_priv *file_priv, u32 *cmdq_id)
 {
-	int cmdq_idx = IVPU_CMDQ_INDEX(engine, priority);
-	struct ivpu_cmdq *cmdq = file_priv->cmdq[cmdq_idx];
+	int ret;
+	u32 id;
+
+	ret = xa_alloc_cyclic(&file_priv->cmdq_xa, &id, NULL, file_priv->cmdq_limit,
+			      &file_priv->cmdq_id_next, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	*cmdq_id = id;
+	return 0;
+}
+
+static struct ivpu_cmdq *ivpu_cmdq_acquire(struct ivpu_file_priv *file_priv, u8 priority)
+{
+	struct ivpu_device *vdev = file_priv->vdev;
+	struct ivpu_cmdq *cmdq;
+	unsigned long id;
 	int ret;
 
 	lockdep_assert_held(&file_priv->lock);
 
+	xa_for_each(&file_priv->cmdq_xa, id, cmdq)
+		if (cmdq->priority == priority)
+			break;
+
 	if (!cmdq) {
 		cmdq = ivpu_cmdq_alloc(file_priv);
-		if (!cmdq)
+		if (!cmdq) {
+			ivpu_err(vdev, "Failed to allocate command queue\n");
 			return NULL;
-		file_priv->cmdq[cmdq_idx] = cmdq;
+		}
+
+		ret = ivpu_db_id_alloc(vdev, &cmdq->db_id);
+		if (ret) {
+			ivpu_err(file_priv->vdev, "Failed to allocate doorbell ID: %d\n", ret);
+			goto err_free_cmdq;
+		}
+
+		ret = ivpu_cmdq_id_alloc(file_priv, &cmdq->id);
+		if (ret) {
+			ivpu_err(vdev, "Failed to allocate command queue ID: %d\n", ret);
+			goto err_erase_db_id;
+		}
+
+		cmdq->priority = priority;
+		ret = xa_err(xa_store(&file_priv->cmdq_xa, cmdq->id, cmdq, GFP_KERNEL));
+		if (ret) {
+			ivpu_err(vdev, "Failed to store command queue in cmdq_xa: %d\n", ret);
+			goto err_erase_cmdq_id;
+		}
 	}
 
-	ret = ivpu_cmdq_init(file_priv, cmdq, engine, priority);
-	if (ret)
-		return NULL;
+	ret = ivpu_cmdq_init(file_priv, cmdq, priority);
+	if (ret) {
+		ivpu_err(vdev, "Failed to initialize command queue: %d\n", ret);
+		goto err_free_cmdq;
+	}
 
 	return cmdq;
+
+err_erase_cmdq_id:
+	xa_erase(&file_priv->cmdq_xa, cmdq->id);
+err_erase_db_id:
+	xa_erase(&vdev->db_xa, cmdq->db_id);
+err_free_cmdq:
+	ivpu_cmdq_free(file_priv, cmdq);
+	return NULL;
 }
 
-static void ivpu_cmdq_release_locked(struct ivpu_file_priv *file_priv, u16 engine, u8 priority)
+void ivpu_cmdq_release_all_locked(struct ivpu_file_priv *file_priv)
 {
-	int cmdq_idx = IVPU_CMDQ_INDEX(engine, priority);
-	struct ivpu_cmdq *cmdq = file_priv->cmdq[cmdq_idx];
+	struct ivpu_cmdq *cmdq;
+	unsigned long cmdq_id;
 
 	lockdep_assert_held(&file_priv->lock);
 
-	if (cmdq) {
-		file_priv->cmdq[cmdq_idx] = NULL;
+	xa_for_each(&file_priv->cmdq_xa, cmdq_id, cmdq) {
+		xa_erase(&file_priv->cmdq_xa, cmdq_id);
 		ivpu_cmdq_fini(file_priv, cmdq);
 		ivpu_cmdq_free(file_priv, cmdq);
 	}
 }
 
-void ivpu_cmdq_release_all_locked(struct ivpu_file_priv *file_priv)
-{
-	u16 engine;
-	u8 priority;
-
-	lockdep_assert_held(&file_priv->lock);
-
-	for (engine = 0; engine < IVPU_NUM_ENGINES; engine++)
-		for (priority = 0; priority < IVPU_NUM_PRIORITIES; priority++)
-			ivpu_cmdq_release_locked(file_priv, engine, priority);
-}
-
 /*
  * Mark the doorbell as unregistered
  * This function needs to be called when the VPU hardware is restarted
@@ -279,20 +319,13 @@ void ivpu_cmdq_release_all_locked(struct ivpu_file_priv *file_priv)
  */
 static void ivpu_cmdq_reset(struct ivpu_file_priv *file_priv)
 {
-	u16 engine;
-	u8 priority;
+	struct ivpu_cmdq *cmdq;
+	unsigned long cmdq_id;
 
 	mutex_lock(&file_priv->lock);
 
-	for (engine = 0; engine < IVPU_NUM_ENGINES; engine++) {
-		for (priority = 0; priority < IVPU_NUM_PRIORITIES; priority++) {
-			int cmdq_idx = IVPU_CMDQ_INDEX(engine, priority);
-			struct ivpu_cmdq *cmdq = file_priv->cmdq[cmdq_idx];
-
-			if (cmdq)
-				cmdq->db_registered = false;
-		}
-	}
+	xa_for_each(&file_priv->cmdq_xa, cmdq_id, cmdq)
+		cmdq->db_registered = false;
 
 	mutex_unlock(&file_priv->lock);
 }
@@ -312,17 +345,11 @@ void ivpu_cmdq_reset_all_contexts(struct ivpu_device *vdev)
 
 static void ivpu_cmdq_fini_all(struct ivpu_file_priv *file_priv)
 {
-	u16 engine;
-	u8 priority;
-
-	for (engine = 0; engine < IVPU_NUM_ENGINES; engine++) {
-		for (priority = 0; priority < IVPU_NUM_PRIORITIES; priority++) {
-			int cmdq_idx = IVPU_CMDQ_INDEX(engine, priority);
+	struct ivpu_cmdq *cmdq;
+	unsigned long cmdq_id;
 
-			if (file_priv->cmdq[cmdq_idx])
-				ivpu_cmdq_fini(file_priv, file_priv->cmdq[cmdq_idx]);
-		}
-	}
+	xa_for_each(&file_priv->cmdq_xa, cmdq_id, cmdq)
+		ivpu_cmdq_fini(file_priv, cmdq);
 }
 
 void ivpu_context_abort_locked(struct ivpu_file_priv *file_priv)
@@ -349,8 +376,8 @@ static int ivpu_cmdq_push_job(struct ivpu_cmdq *cmdq, struct ivpu_job *job)
 
 	/* Check if there is space left in job queue */
 	if (next_entry == header->head) {
-		ivpu_dbg(vdev, JOB, "Job queue full: ctx %d engine %d db %d head %d tail %d\n",
-			 job->file_priv->ctx.id, job->engine_idx, cmdq->db_id, header->head, tail);
+		ivpu_dbg(vdev, JOB, "Job queue full: ctx %d cmdq %d db %d head %d tail %d\n",
+			 job->file_priv->ctx.id, cmdq->id, cmdq->db_id, header->head, tail);
 		return -EBUSY;
 	}
 
@@ -363,10 +390,16 @@ static int ivpu_cmdq_push_job(struct ivpu_cmdq *cmdq, struct ivpu_job *job)
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW &&
 	    (unlikely(!(ivpu_test_mode & IVPU_TEST_MODE_PREEMPTION_DISABLE)))) {
-		entry->primary_preempt_buf_addr = cmdq->primary_preempt_buf->vpu_addr;
-		entry->primary_preempt_buf_size = ivpu_bo_size(cmdq->primary_preempt_buf);
-		entry->secondary_preempt_buf_addr = cmdq->secondary_preempt_buf->vpu_addr;
-		entry->secondary_preempt_buf_size = ivpu_bo_size(cmdq->secondary_preempt_buf);
+		if (cmdq->primary_preempt_buf) {
+			entry->primary_preempt_buf_addr = cmdq->primary_preempt_buf->vpu_addr;
+			entry->primary_preempt_buf_size = ivpu_bo_size(cmdq->primary_preempt_buf);
+		}
+
+		if (cmdq->secondary_preempt_buf) {
+			entry->secondary_preempt_buf_addr = cmdq->secondary_preempt_buf->vpu_addr;
+			entry->secondary_preempt_buf_size =
+				ivpu_bo_size(cmdq->secondary_preempt_buf);
+		}
 	}
 
 	wmb(); /* Ensure that tail is updated after filling entry */
@@ -558,7 +591,7 @@ static int ivpu_job_submit(struct ivpu_job *job, u8 priority)
 	mutex_lock(&vdev->submitted_jobs_lock);
 	mutex_lock(&file_priv->lock);
 
-	cmdq = ivpu_cmdq_acquire(file_priv, job->engine_idx, priority);
+	cmdq = ivpu_cmdq_acquire(file_priv, priority);
 	if (!cmdq) {
 		ivpu_warn_ratelimited(vdev, "Failed to get job queue, ctx %d engine %d prio %d\n",
 				      file_priv->ctx.id, job->engine_idx, priority);
@@ -698,7 +731,7 @@ int ivpu_submit_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	int idx, ret;
 	u8 priority;
 
-	if (params->engine > DRM_IVPU_ENGINE_COPY)
+	if (params->engine != DRM_IVPU_ENGINE_COMPUTE)
 		return -EINVAL;
 
 	if (params->priority > DRM_IVPU_JOB_PRIORITY_REALTIME)
@@ -816,7 +849,8 @@ void ivpu_context_abort_thread_handler(struct work_struct *work)
 	unsigned long id;
 
 	if (vdev->fw->sched_mode == VPU_SCHEDULING_MODE_HW)
-		ivpu_jsm_reset_engine(vdev, 0);
+		if (ivpu_jsm_reset_engine(vdev, 0))
+			return;
 
 	mutex_lock(&vdev->context_list_lock);
 	xa_for_each(&vdev->context_xa, ctx_id, file_priv) {
@@ -832,7 +866,8 @@ void ivpu_context_abort_thread_handler(struct work_struct *work)
 	if (vdev->fw->sched_mode != VPU_SCHEDULING_MODE_HW)
 		return;
 
-	ivpu_jsm_hws_resume_engine(vdev, 0);
+	if (ivpu_jsm_hws_resume_engine(vdev, 0))
+		return;
 	/*
 	 * In hardware scheduling mode NPU already has stopped processing jobs
 	 * and won't send us any further notifications, thus we have to free job related resources
diff --git a/drivers/accel/ivpu/ivpu_job.h b/drivers/accel/ivpu/ivpu_job.h
index 0ae77f0638fa..af1ed039569c 100644
--- a/drivers/accel/ivpu/ivpu_job.h
+++ b/drivers/accel/ivpu/ivpu_job.h
@@ -28,8 +28,10 @@ struct ivpu_cmdq {
 	struct ivpu_bo *secondary_preempt_buf;
 	struct ivpu_bo *mem;
 	u32 entry_count;
+	u32 id;
 	u32 db_id;
 	bool db_registered;
+	u8 priority;
 };
 
 /**
diff --git a/drivers/accel/ivpu/ivpu_jsm_msg.c b/drivers/accel/ivpu/ivpu_jsm_msg.c
index ae91ad24d10d..7c08308d5725 100644
--- a/drivers/accel/ivpu/ivpu_jsm_msg.c
+++ b/drivers/accel/ivpu/ivpu_jsm_msg.c
@@ -7,6 +7,8 @@
 #include "ivpu_hw.h"
 #include "ivpu_ipc.h"
 #include "ivpu_jsm_msg.h"
+#include "ivpu_pm.h"
+#include "vpu_jsm_api.h"
 
 const char *ivpu_jsm_msg_type_to_str(enum vpu_ipc_msg_type type)
 {
@@ -132,7 +134,7 @@ int ivpu_jsm_get_heartbeat(struct ivpu_device *vdev, u32 engine, u64 *heartbeat)
 	struct vpu_jsm_msg resp;
 	int ret;
 
-	if (engine > VPU_ENGINE_COPY)
+	if (engine != VPU_ENGINE_COMPUTE)
 		return -EINVAL;
 
 	req.payload.query_engine_hb.engine_idx = engine;
@@ -155,15 +157,17 @@ int ivpu_jsm_reset_engine(struct ivpu_device *vdev, u32 engine)
 	struct vpu_jsm_msg resp;
 	int ret;
 
-	if (engine > VPU_ENGINE_COPY)
+	if (engine != VPU_ENGINE_COMPUTE)
 		return -EINVAL;
 
 	req.payload.engine_reset.engine_idx = engine;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_ENGINE_RESET_DONE, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
-	if (ret)
+	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to reset engine %d: %d\n", engine, ret);
+		ivpu_pm_trigger_recovery(vdev, "Engine reset failed");
+	}
 
 	return ret;
 }
@@ -174,7 +178,7 @@ int ivpu_jsm_preempt_engine(struct ivpu_device *vdev, u32 engine, u32 preempt_id
 	struct vpu_jsm_msg resp;
 	int ret;
 
-	if (engine > VPU_ENGINE_COPY)
+	if (engine != VPU_ENGINE_COMPUTE)
 		return -EINVAL;
 
 	req.payload.engine_preempt.engine_idx = engine;
@@ -346,15 +350,17 @@ int ivpu_jsm_hws_resume_engine(struct ivpu_device *vdev, u32 engine)
 	struct vpu_jsm_msg resp;
 	int ret;
 
-	if (engine >= VPU_ENGINE_NB)
+	if (engine != VPU_ENGINE_COMPUTE)
 		return -EINVAL;
 
 	req.payload.hws_resume_engine.engine_idx = engine;
 
 	ret = ivpu_ipc_send_receive(vdev, &req, VPU_JSM_MSG_HWS_RESUME_ENGINE_DONE, &resp,
 				    VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
-	if (ret)
+	if (ret) {
 		ivpu_err_ratelimited(vdev, "Failed to resume engine %d: %d\n", engine, ret);
+		ivpu_pm_trigger_recovery(vdev, "Engine resume failed");
+	}
 
 	return ret;
 }
@@ -409,26 +415,18 @@ int ivpu_jsm_hws_setup_priority_bands(struct ivpu_device *vdev)
 {
 	struct vpu_jsm_msg req = { .type = VPU_JSM_MSG_SET_PRIORITY_BAND_SETUP };
 	struct vpu_jsm_msg resp;
+	struct ivpu_hw_info *hw = vdev->hw;
+	struct vpu_ipc_msg_payload_hws_priority_band_setup *setup =
+		&req.payload.hws_priority_band_setup;
 	int ret;
 
-	/* Idle */
-	req.payload.hws_priority_band_setup.grace_period[0] = 0;
-	req.payload.hws_priority_band_setup.process_grace_period[0] = 50000;
-	req.payload.hws_priority_band_setup.process_quantum[0] = 160000;
-	/* Normal */
-	req.payload.hws_priority_band_setup.grace_period[1] = 50000;
-	req.payload.hws_priority_band_setup.process_grace_period[1] = 50000;
-	req.payload.hws_priority_band_setup.process_quantum[1] = 300000;
-	/* Focus */
-	req.payload.hws_priority_band_setup.grace_period[2] = 50000;
-	req.payload.hws_priority_band_setup.process_grace_period[2] = 50000;
-	req.payload.hws_priority_band_setup.process_quantum[2] = 200000;
-	/* Realtime */
-	req.payload.hws_priority_band_setup.grace_period[3] = 0;
-	req.payload.hws_priority_band_setup.process_grace_period[3] = 50000;
-	req.payload.hws_priority_band_setup.process_quantum[3] = 200000;
-
-	req.payload.hws_priority_band_setup.normal_band_percentage = 10;
+	for (int band = VPU_JOB_SCHEDULING_PRIORITY_BAND_IDLE;
+	     band < VPU_JOB_SCHEDULING_PRIORITY_BAND_COUNT; band++) {
+		setup->grace_period[band] = hw->hws.grace_period[band];
+		setup->process_grace_period[band] = hw->hws.process_grace_period[band];
+		setup->process_quantum[band] = hw->hws.process_quantum[band];
+	}
+	setup->normal_band_percentage = 10;
 
 	ret = ivpu_ipc_send_receive_internal(vdev, &req, VPU_JSM_MSG_SET_PRIORITY_BAND_SETUP_RSP,
 					     &resp, VPU_IPC_CHAN_ASYNC_CMD, vdev->timeout.jsm);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 395240cb3666..a6a66d794763 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1456,7 +1456,7 @@ static bool ahci_broken_lpm(struct pci_dev *pdev)
 		{
 			.matches = {
 				DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-				DMI_MATCH(DMI_PRODUCT_VERSION, "ASUSPRO D840MB_M840SA"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "ASUSPRO D840MB_M840SA"),
 			},
 			/* 320 is broken, there is no known good version. */
 		},
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a0d6e8d7f42c..f5429666822f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1781,6 +1781,13 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 	}
 	put_device(dev);
 
+	if (rc)
+		dev_err(port->uport_dev,
+			"failed to find %s:%s in target list of %s\n",
+			dev_name(&port->dev),
+			dev_name(port->parent_dport->dport_dev),
+			dev_name(&cxlsd->cxld.dev));
+
 	return rc;
 }
 
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 19a58c4ecef3..8b27bd545685 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -354,7 +354,9 @@ static void idxd_cdev_evl_drain_pasid(struct idxd_wq *wq, u32 pasid)
 			set_bit(h, evl->bmap);
 		h = (h + 1) % size;
 	}
-	drain_workqueue(wq->wq);
+	if (wq->wq)
+		drain_workqueue(wq->wq);
+
 	mutex_unlock(&evl->lock);
 }
 
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 5eb51ae93e89..aa59b62cd83f 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2906,6 +2906,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		return -EINVAL;
 	}
 
+	xdev->common.directions |= chan->direction;
+
 	/* Request the interrupt */
 	chan->irq = of_irq_get(node, chan->tdest);
 	if (chan->irq < 0)
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c0a8f9c8d4f0..322ba16b31bf 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1208,7 +1208,9 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	if (csrow_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_PRIMARY;
 
-	/* Asymmetric dual-rank DIMM support. */
+	if (csrow_sec_enabled(2 * dimm, ctrl, pvt))
+		cs_mode |= CS_EVEN_SECONDARY;
+
 	if (csrow_sec_enabled(2 * dimm + 1, ctrl, pvt))
 		cs_mode |= CS_ODD_SECONDARY;
 
@@ -1229,12 +1231,13 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
 }
 
-static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
-				  int csrow_nr, int dimm)
+static int calculate_cs_size(u32 mask, unsigned int cs_mode)
 {
-	u32 msb, weight, num_zero_bits;
-	u32 addr_mask_deinterleaved;
-	int size = 0;
+	int msb, weight, num_zero_bits;
+	u32 deinterleaved_mask;
+
+	if (!mask)
+		return 0;
 
 	/*
 	 * The number of zero bits in the mask is equal to the number of bits
@@ -1247,19 +1250,30 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
 	 * without swapping with the most significant bit. This can be handled
 	 * by keeping the MSB where it is and ignoring the single zero bit.
 	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
+	msb = fls(mask) - 1;
+	weight = hweight_long(mask);
 	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
 
 	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+	deinterleaved_mask = GENMASK(msb - num_zero_bits, 1);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", deinterleaved_mask);
+
+	return (deinterleaved_mask >> 2) + 1;
+}
+
+static int __addr_mask_to_cs_size(u32 addr_mask, u32 addr_mask_sec,
+				  unsigned int cs_mode, int csrow_nr, int dimm)
+{
+	int size;
 
 	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+	edac_dbg(1, "  Primary AddrMask: 0x%x\n", addr_mask);
 
 	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
+	size = calculate_cs_size(addr_mask, cs_mode);
+
+	edac_dbg(1, "  Secondary AddrMask: 0x%x\n", addr_mask_sec);
+	size += calculate_cs_size(addr_mask_sec, cs_mode);
 
 	/* Return size in MBs. */
 	return size >> 10;
@@ -1268,8 +1282,8 @@ static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
 static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
+	u32 addr_mask = 0, addr_mask_sec = 0;
 	int cs_mask_nr = csrow_nr;
-	u32 addr_mask_orig;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -1307,13 +1321,13 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	if (!pvt->flags.zn_regs_v2)
 		cs_mask_nr >>= 1;
 
-	/* Asymmetric dual-rank DIMM support. */
-	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
-		addr_mask_orig = pvt->csels[umc].csmasks_sec[cs_mask_nr];
-	else
-		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
+	if (cs_mode & (CS_EVEN_PRIMARY | CS_ODD_PRIMARY))
+		addr_mask = pvt->csels[umc].csmasks[cs_mask_nr];
+
+	if (cs_mode & (CS_EVEN_SECONDARY | CS_ODD_SECONDARY))
+		addr_mask_sec = pvt->csels[umc].csmasks_sec[cs_mask_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, dimm);
 }
 
 static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
@@ -3515,9 +3529,10 @@ static void gpu_get_err_info(struct mce *m, struct err_info *err)
 static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask		= pvt->csels[umc].csmasks[csrow_nr];
+	u32 addr_mask_sec	= pvt->csels[umc].csmasks_sec[csrow_nr];
 
-	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
+	return __addr_mask_to_cs_size(addr_mask, addr_mask_sec, cs_mode, csrow_nr, csrow_nr >> 1);
 }
 
 static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 9da4414de617..81f16e4447f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 			continue;
 		}
 		job = to_amdgpu_job(s_job);
-		if (preempted && (&job->hw_fence) == fence)
+		if (preempted && (&job->hw_fence.base) == fence)
 			/* mark the job as preempted */
 			job->preemption_status |= AMDGPU_IB_PREEMPTED;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ca0411c9500e..a55e611605fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5861,7 +5861,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	 *
 	 * job->base holds a reference to parent fence
 	 */
-	if (job && dma_fence_is_signaled(&job->hw_fence)) {
+	if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
 		job_signaled = true;
 		dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
 		goto skip_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 018240a2ab96..34d41e3ce347 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -301,10 +301,12 @@ static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
 	const struct firmware *fw;
 	int r;
 
-	r = request_firmware(&fw, fw_name, adev->dev);
+	r = firmware_request_nowarn(&fw, fw_name, adev->dev);
 	if (r) {
-		dev_err(adev->dev, "can't load firmware \"%s\"\n",
-			fw_name);
+		if (amdgpu_discovery == 2)
+			dev_err(adev->dev, "can't load firmware \"%s\"\n", fw_name);
+		else
+			drm_info(&adev->ddev, "Optional firmware \"%s\" was not found\n", fw_name);
 		return r;
 	}
 
@@ -419,16 +421,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	/* Read from file if it is the preferred option */
 	fw_name = amdgpu_discovery_get_fw_name(adev);
 	if (fw_name != NULL) {
-		dev_info(adev->dev, "use ip discovery information from file");
+		drm_dbg(&adev->ddev, "use ip discovery information from file");
 		r = amdgpu_discovery_read_binary_from_file(adev, adev->mman.discovery_bin, fw_name);
-
-		if (r) {
-			dev_err(adev->dev, "failed to read ip discovery binary from file\n");
-			r = -EINVAL;
+		if (r)
 			goto out;
-		}
-
 	} else {
+		drm_dbg(&adev->ddev, "use ip discovery information from memory");
 		r = amdgpu_discovery_read_binary_from_mem(
 			adev, adev->mman.discovery_bin);
 		if (r)
@@ -1286,10 +1284,8 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	int r;
 
 	r = amdgpu_discovery_init(adev);
-	if (r) {
-		DRM_ERROR("amdgpu_discovery_init failed\n");
+	if (r)
 		return r;
-	}
 
 	adev->gfx.xcc_mask = 0;
 	adev->sdma.sdma_mask = 0;
@@ -2429,6 +2425,40 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
 
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_VEGA12:
+	case CHIP_RAVEN:
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
+		/* this is not fatal.  We have a fallback below
+		 * if the new firmwares are not present. some of
+		 * this will be overridden below to keep things
+		 * consistent with the current behavior.
+		 */
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (!r) {
+			amdgpu_discovery_harvest_ip(adev);
+			amdgpu_discovery_get_gfx_info(adev);
+			amdgpu_discovery_get_mall_info(adev);
+			amdgpu_discovery_get_vcn_info(adev);
+		}
+		break;
+	default:
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (r) {
+			drm_err(&adev->ddev, "discovery failed: %d\n", r);
+			return r;
+		}
+
+		amdgpu_discovery_harvest_ip(adev);
+		amdgpu_discovery_get_gfx_info(adev);
+		amdgpu_discovery_get_mall_info(adev);
+		amdgpu_discovery_get_vcn_info(adev);
+		break;
+	}
+
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 		vega10_reg_base_init(adev);
@@ -2591,14 +2621,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
 		break;
 	default:
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (r)
-			return -EINVAL;
-
-		amdgpu_discovery_harvest_ip(adev);
-		amdgpu_discovery_get_gfx_info(adev);
-		amdgpu_discovery_get_mall_info(adev);
-		amdgpu_discovery_get_vcn_info(adev);
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2f24a6aa13bf..569e0e537392 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -41,22 +41,6 @@
 #include "amdgpu_trace.h"
 #include "amdgpu_reset.h"
 
-/*
- * Fences mark an event in the GPUs pipeline and are used
- * for GPU/CPU synchronization.  When the fence is written,
- * it is expected that all buffers associated with that fence
- * are no longer in use by the associated ring on the GPU and
- * that the relevant GPU caches have been flushed.
- */
-
-struct amdgpu_fence {
-	struct dma_fence base;
-
-	/* RB, DMA, etc. */
-	struct amdgpu_ring		*ring;
-	ktime_t				start_timestamp;
-};
-
 static struct kmem_cache *amdgpu_fence_slab;
 
 int amdgpu_fence_slab_init(void)
@@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
 		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
 		if (am_fence == NULL)
 			return -ENOMEM;
-		fence = &am_fence->base;
-		am_fence->ring = ring;
 	} else {
 		/* take use of job-embedded fence */
-		fence = &job->hw_fence;
+		am_fence = &job->hw_fence;
 	}
+	fence = &am_fence->base;
+	am_fence->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
 	if (job && job->job_run_counter) {
@@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
 			 * it right here or we won't be able to track them in fence_drv
 			 * and they will remain unsignaled during sa_bo free.
 			 */
-			job = container_of(old, struct amdgpu_job, hw_fence);
+			job = container_of(old, struct amdgpu_job, hw_fence.base);
 			if (!job->base.s_fence && !dma_fence_is_signaled(old))
 				dma_fence_signal(old);
 			RCU_INIT_POINTER(*ptr, NULL);
@@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 
 static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
 {
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
 
 	return (const char *)to_amdgpu_ring(job->base.sched)->name;
 }
@@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
  */
 static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
 {
-	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
+	struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
 
 	if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
 		amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
@@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rcu)
 	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
 
 	/* free job if fence has a parent job */
-	kfree(container_of(f, struct amdgpu_job, hw_fence));
+	kfree(container_of(f, struct amdgpu_job, hw_fence.base));
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1ce20a19be8b..7e6057a6e7f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -259,8 +259,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 	/* Check if any fences where initialized */
 	if (job->base.s_fence && job->base.s_fence->finished.ops)
 		f = &job->base.s_fence->finished;
-	else if (job->hw_fence.ops)
-		f = &job->hw_fence;
+	else if (job->hw_fence.base.ops)
+		f = &job->hw_fence.base;
 	else
 		f = NULL;
 
@@ -277,10 +277,10 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 	amdgpu_sync_free(&job->explicit_sync);
 
 	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.ops)
+	if (!job->hw_fence.base.ops)
 		kfree(job);
 	else
-		dma_fence_put(&job->hw_fence);
+		dma_fence_put(&job->hw_fence.base);
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -309,10 +309,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
 	if (job->gang_submit != &job->base.s_fence->scheduled)
 		dma_fence_put(job->gang_submit);
 
-	if (!job->hw_fence.ops)
+	if (!job->hw_fence.base.ops)
 		kfree(job);
 	else
-		dma_fence_put(&job->hw_fence);
+		dma_fence_put(&job->hw_fence.base);
 }
 
 struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index ce6b9ba967ff..4fe033d8f356 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -48,7 +48,7 @@ struct amdgpu_job {
 	struct drm_sched_job    base;
 	struct amdgpu_vm	*vm;
 	struct amdgpu_sync	explicit_sync;
-	struct dma_fence	hw_fence;
+	struct amdgpu_fence	hw_fence;
 	struct dma_fence	*gang_submit;
 	uint32_t		preamble_status;
 	uint32_t                preemption_status;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index f93f51002201..9af2cda676ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -126,6 +126,22 @@ struct amdgpu_fence_driver {
 	struct dma_fence		**fences;
 };
 
+/*
+ * Fences mark an event in the GPUs pipeline and are used
+ * for GPU/CPU synchronization.  When the fence is written,
+ * it is expected that all buffers associated with that fence
+ * are no longer in use by the associated ring on the GPU and
+ * that the relevant GPU caches have been flushed.
+ */
+
+struct amdgpu_fence {
+	struct dma_fence base;
+
+	/* RB, DMA, etc. */
+	struct amdgpu_ring		*ring;
+	ktime_t				start_timestamp;
+};
+
 extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index e22cb2b5cd92..dba8051b8c14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -133,7 +133,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
 
 	vm = &fpriv->vm;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 4c7b53648a50..eb83d7c1f784 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -30,6 +30,10 @@
 
 #define AMDGPU_UCODE_NAME_MAX		(128)
 
+static const struct kicker_device kicker_device_list[] = {
+	{0x744B, 0x00},
+};
+
 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
 {
 	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
@@ -1383,6 +1387,19 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
 	return NULL;
 }
 
+bool amdgpu_is_kicker_fw(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(kicker_device_list); i++) {
+		if (adev->pdev->device == kicker_device_list[i].device &&
+			adev->pdev->revision == kicker_device_list[i].revision)
+		return true;
+	}
+
+	return false;
+}
+
 void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type, char *ucode_prefix, int len)
 {
 	int maj, min, rev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4e23419b92d4..fd08b015b2a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -595,6 +595,11 @@ struct amdgpu_firmware {
 	uint64_t fw_buf_mc;
 };
 
+struct kicker_device{
+	unsigned short device;
+	u8 revision;
+};
+
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr);
@@ -622,5 +627,6 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type);
 const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id);
 
 void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type, char *ucode_prefix, int len);
+bool amdgpu_is_kicker_fw(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index ff5e52025266..8f58ec6f1400 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	int r;
 
 	lpfn = (u64)place->lpfn << PAGE_SHIFT;
-	if (!lpfn)
+	if (!lpfn || lpfn > man->size)
 		lpfn = man->size;
 
 	fpfn = (u64)place->fpfn << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4dd86c682ee6..1e4ce06f5f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -485,7 +485,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 {
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 doorbell_offset, doorbell;
-	u32 rb_cntl, ib_cntl;
+	u32 rb_cntl, ib_cntl, sdma_cntl;
 	int i;
 
 	for_each_inst(i, inst_mask) {
@@ -497,6 +497,9 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 		ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
 		WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
+		sdma_cntl = RREG32_SDMA(i, regSDMA_CNTL);
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_ENABLE, 0);
+		WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
 
 		if (sdma[i]->use_doorbell) {
 			doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
@@ -953,6 +956,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
+		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
 			/* enable context empty interrupt during initialization */
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 7062f12b5b75..6c8c9935a0f2 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -3640,7 +3640,7 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
 };
 
 static const uint32_t cwsr_trap_gfx12_hex[] = {
-	0xbfa00001, 0xbfa0024b,
+	0xbfa00001, 0xbfa002a2,
 	0xb0804009, 0xb8f8f804,
 	0x9178ff78, 0x00008c00,
 	0xb8fbf811, 0x8b6eff78,
@@ -3714,7 +3714,15 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x00011677, 0xd7610000,
 	0x00011a79, 0xd7610000,
 	0x00011c7e, 0xd7610000,
-	0x00011e7f, 0xbefe00ff,
+	0x00011e7f, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xbefe00ff,
 	0x00003fff, 0xbeff0080,
 	0xee0a407a, 0x000c0000,
 	0x00004000, 0xd760007a,
@@ -3751,38 +3759,46 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0x00000200, 0xbef600ff,
 	0x01000000, 0x7e000280,
 	0x7e020280, 0x7e040280,
-	0xbefd0080, 0xbe804ec2,
-	0xbf94fffe, 0xb8faf804,
-	0x8b7a847a, 0x91788478,
-	0x8c787a78, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xd7610002, 0x0000fa6c,
-	0x807d817d, 0x917aff6d,
-	0x80000000, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
-	0xd7610002, 0x0000fa6e,
-	0x807d817d, 0xd7610002,
-	0x0000fa6f, 0x807d817d,
-	0xd7610002, 0x0000fa78,
-	0x807d817d, 0xb8faf811,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xd7610002,
-	0x0000fa7b, 0x807d817d,
-	0xb8f1f801, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f814, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f815, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f812, 0xd7610002,
-	0x0000fa71, 0x807d817d,
-	0xb8f1f813, 0xd7610002,
-	0x0000fa71, 0x807d817d,
+	0xbe804ec2, 0xbf94fffe,
+	0xb8faf804, 0x8b7a847a,
+	0x91788478, 0x8c787a78,
+	0x917aff6d, 0x80000000,
+	0xd7610002, 0x00010071,
+	0xd7610002, 0x0001026c,
+	0xd7610002, 0x0001047a,
+	0xd7610002, 0x0001066e,
+	0xd7610002, 0x0001086f,
+	0xd7610002, 0x00010a78,
+	0xd7610002, 0x00010e7b,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xd8500000, 0x00000000,
+	0xb8faf811, 0xd7610002,
+	0x00010c7a, 0xb8faf801,
+	0xd7610002, 0x0001107a,
+	0xb8faf814, 0xd7610002,
+	0x0001127a, 0xb8faf815,
+	0xd7610002, 0x0001147a,
+	0xb8faf812, 0xd7610002,
+	0x0001167a, 0xb8faf813,
+	0xd7610002, 0x0001187a,
 	0xb8faf802, 0xd7610002,
-	0x0000fa7a, 0x807d817d,
-	0xbefa50c1, 0xbfc70000,
-	0xd7610002, 0x0000fa7a,
-	0x807d817d, 0xbefe00ff,
+	0x00011a7a, 0xbefa50c1,
+	0xbfc70000, 0xd7610002,
+	0x00011c7a, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xbefe00ff,
 	0x0000ffff, 0xbeff0080,
 	0xc4068070, 0x008ce802,
 	0x00000000, 0xbefe00c1,
@@ -3797,329 +3813,356 @@ static const uint32_t cwsr_trap_gfx12_hex[] = {
 	0xbe824102, 0xbe844104,
 	0xbe864106, 0xbe884108,
 	0xbe8a410a, 0xbe8c410c,
-	0xbe8e410e, 0xd7610002,
-	0x0000f200, 0x80798179,
-	0xd7610002, 0x0000f201,
-	0x80798179, 0xd7610002,
-	0x0000f202, 0x80798179,
-	0xd7610002, 0x0000f203,
-	0x80798179, 0xd7610002,
-	0x0000f204, 0x80798179,
-	0xd7610002, 0x0000f205,
-	0x80798179, 0xd7610002,
-	0x0000f206, 0x80798179,
-	0xd7610002, 0x0000f207,
-	0x80798179, 0xd7610002,
-	0x0000f208, 0x80798179,
-	0xd7610002, 0x0000f209,
-	0x80798179, 0xd7610002,
-	0x0000f20a, 0x80798179,
-	0xd7610002, 0x0000f20b,
-	0x80798179, 0xd7610002,
-	0x0000f20c, 0x80798179,
-	0xd7610002, 0x0000f20d,
-	0x80798179, 0xd7610002,
-	0x0000f20e, 0x80798179,
-	0xd7610002, 0x0000f20f,
-	0x80798179, 0xbf06a079,
-	0xbfa10007, 0xc4068070,
+	0xbe8e410e, 0xbf068079,
+	0xbfa10032, 0xd7610002,
+	0x00010000, 0xd7610002,
+	0x00010201, 0xd7610002,
+	0x00010402, 0xd7610002,
+	0x00010603, 0xd7610002,
+	0x00010804, 0xd7610002,
+	0x00010a05, 0xd7610002,
+	0x00010c06, 0xd7610002,
+	0x00010e07, 0xd7610002,
+	0x00011008, 0xd7610002,
+	0x00011209, 0xd7610002,
+	0x0001140a, 0xd7610002,
+	0x0001160b, 0xd7610002,
+	0x0001180c, 0xd7610002,
+	0x00011a0d, 0xd7610002,
+	0x00011c0e, 0xd7610002,
+	0x00011e0f, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80799079,
+	0xbfa00038, 0xd7610002,
+	0x00012000, 0xd7610002,
+	0x00012201, 0xd7610002,
+	0x00012402, 0xd7610002,
+	0x00012603, 0xd7610002,
+	0x00012804, 0xd7610002,
+	0x00012a05, 0xd7610002,
+	0x00012c06, 0xd7610002,
+	0x00012e07, 0xd7610002,
+	0x00013008, 0xd7610002,
+	0x00013209, 0xd7610002,
+	0x0001340a, 0xd7610002,
+	0x0001360b, 0xd7610002,
+	0x0001380c, 0xd7610002,
+	0x00013a0d, 0xd7610002,
+	0x00013c0e, 0xd7610002,
+	0x00013e0f, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0x80799079,
+	0xc4068070, 0x008ce802,
+	0x00000000, 0x8070ff70,
+	0x00000080, 0xbef90080,
+	0x7e040280, 0x807d907d,
+	0xbf0aff7d, 0x00000060,
+	0xbfa2ff88, 0xbe804100,
+	0xbe824102, 0xbe844104,
+	0xbe864106, 0xbe884108,
+	0xbe8a410a, 0xd7610002,
+	0x00010000, 0xd7610002,
+	0x00010201, 0xd7610002,
+	0x00010402, 0xd7610002,
+	0x00010603, 0xd7610002,
+	0x00010804, 0xd7610002,
+	0x00010a05, 0xd7610002,
+	0x00010c06, 0xd7610002,
+	0x00010e07, 0xd7610002,
+	0x00011008, 0xd7610002,
+	0x00011209, 0xd7610002,
+	0x0001140a, 0xd7610002,
+	0x0001160b, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xd8500000,
+	0x00000000, 0xc4068070,
 	0x008ce802, 0x00000000,
+	0xbefe00c1, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8fb4306, 0x8b7bc17b,
+	0xbfa10044, 0x8b7aff6d,
+	0x80000000, 0xbfa10041,
+	0x847b897b, 0xbef6007b,
+	0xb8f03b05, 0x80708170,
+	0xbf0d9973, 0xbfa20002,
+	0x84708970, 0xbfa00001,
+	0x84708a70, 0xb8fa1e06,
+	0x847a8a7a, 0x80707a70,
+	0x8070ff70, 0x00000200,
 	0x8070ff70, 0x00000080,
-	0xbef90080, 0x7e040280,
-	0x807d907d, 0xbf0aff7d,
-	0x00000060, 0xbfa2ffbb,
-	0xbe804100, 0xbe824102,
-	0xbe844104, 0xbe864106,
-	0xbe884108, 0xbe8a410a,
-	0xd7610002, 0x0000f200,
-	0x80798179, 0xd7610002,
-	0x0000f201, 0x80798179,
-	0xd7610002, 0x0000f202,
-	0x80798179, 0xd7610002,
-	0x0000f203, 0x80798179,
-	0xd7610002, 0x0000f204,
-	0x80798179, 0xd7610002,
-	0x0000f205, 0x80798179,
-	0xd7610002, 0x0000f206,
-	0x80798179, 0xd7610002,
-	0x0000f207, 0x80798179,
-	0xd7610002, 0x0000f208,
-	0x80798179, 0xd7610002,
-	0x0000f209, 0x80798179,
-	0xd7610002, 0x0000f20a,
-	0x80798179, 0xd7610002,
-	0x0000f20b, 0x80798179,
-	0xc4068070, 0x008ce802,
-	0x00000000, 0xbefe00c1,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8fb4306,
-	0x8b7bc17b, 0xbfa10044,
-	0x8b7aff6d, 0x80000000,
-	0xbfa10041, 0x847b897b,
-	0xbef6007b, 0xb8f03b05,
-	0x80708170, 0xbf0d9973,
-	0xbfa20002, 0x84708970,
-	0xbfa00001, 0x84708a70,
-	0xb8fa1e06, 0x847a8a7a,
-	0x80707a70, 0x8070ff70,
-	0x00000200, 0x8070ff70,
-	0x00000080, 0xbef600ff,
-	0x01000000, 0xd71f0000,
-	0x000100c1, 0xd7200000,
-	0x000200c1, 0x16000084,
-	0x857d9973, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xbfa20013, 0xbe8300ff,
-	0x00000080, 0xbf800000,
-	0xbf800000, 0xbf800000,
-	0xd8d80000, 0x01000000,
-	0xbf8a0000, 0xc4068070,
-	0x008ce801, 0x00000000,
-	0x807d037d, 0x80700370,
-	0xd5250000, 0x0001ff00,
-	0x00000080, 0xbf0a7b7d,
-	0xbfa2fff3, 0xbfa00012,
-	0xbe8300ff, 0x00000100,
+	0xbef600ff, 0x01000000,
+	0xd71f0000, 0x000100c1,
+	0xd7200000, 0x000200c1,
+	0x16000084, 0x857d9973,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa20013,
+	0xbe8300ff, 0x00000080,
 	0xbf800000, 0xbf800000,
 	0xbf800000, 0xd8d80000,
 	0x01000000, 0xbf8a0000,
 	0xc4068070, 0x008ce801,
 	0x00000000, 0x807d037d,
 	0x80700370, 0xd5250000,
-	0x0001ff00, 0x00000100,
+	0x0001ff00, 0x00000080,
 	0xbf0a7b7d, 0xbfa2fff3,
-	0xbefe00c1, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa20004, 0xbef000ff,
-	0x00000200, 0xbeff0080,
-	0xbfa00003, 0xbef000ff,
-	0x00000400, 0xbeff00c1,
-	0xb8fb3b05, 0x807b817b,
-	0x847b827b, 0x857d9973,
-	0x8b7d817d, 0xbf06817d,
-	0xbfa2001b, 0xbef600ff,
-	0x01000000, 0xbefd0084,
-	0xbf0a7b7d, 0xbfa10040,
-	0x7e008700, 0x7e028701,
-	0x7e048702, 0x7e068703,
-	0xc4068070, 0x008ce800,
-	0x00000000, 0xc4068070,
-	0x008ce801, 0x00008000,
-	0xc4068070, 0x008ce802,
-	0x00010000, 0xc4068070,
-	0x008ce803, 0x00018000,
-	0x807d847d, 0x8070ff70,
-	0x00000200, 0xbf0a7b7d,
-	0xbfa2ffeb, 0xbfa0002a,
+	0xbfa00012, 0xbe8300ff,
+	0x00000100, 0xbf800000,
+	0xbf800000, 0xbf800000,
+	0xd8d80000, 0x01000000,
+	0xbf8a0000, 0xc4068070,
+	0x008ce801, 0x00000000,
+	0x807d037d, 0x80700370,
+	0xd5250000, 0x0001ff00,
+	0x00000100, 0xbf0a7b7d,
+	0xbfa2fff3, 0xbefe00c1,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa20004,
+	0xbef000ff, 0x00000200,
+	0xbeff0080, 0xbfa00003,
+	0xbef000ff, 0x00000400,
+	0xbeff00c1, 0xb8fb3b05,
+	0x807b817b, 0x847b827b,
+	0x857d9973, 0x8b7d817d,
+	0xbf06817d, 0xbfa2001b,
 	0xbef600ff, 0x01000000,
 	0xbefd0084, 0xbf0a7b7d,
-	0xbfa10015, 0x7e008700,
+	0xbfa10040, 0x7e008700,
 	0x7e028701, 0x7e048702,
 	0x7e068703, 0xc4068070,
 	0x008ce800, 0x00000000,
 	0xc4068070, 0x008ce801,
-	0x00010000, 0xc4068070,
-	0x008ce802, 0x00020000,
+	0x00008000, 0xc4068070,
+	0x008ce802, 0x00010000,
 	0xc4068070, 0x008ce803,
-	0x00030000, 0x807d847d,
-	0x8070ff70, 0x00000400,
+	0x00018000, 0x807d847d,
+	0x8070ff70, 0x00000200,
 	0xbf0a7b7d, 0xbfa2ffeb,
-	0xb8fb1e06, 0x8b7bc17b,
-	0xbfa1000d, 0x847b837b,
-	0x807b7d7b, 0xbefe00c1,
-	0xbeff0080, 0x7e008700,
+	0xbfa0002a, 0xbef600ff,
+	0x01000000, 0xbefd0084,
+	0xbf0a7b7d, 0xbfa10015,
+	0x7e008700, 0x7e028701,
+	0x7e048702, 0x7e068703,
 	0xc4068070, 0x008ce800,
-	0x00000000, 0x807d817d,
-	0x8070ff70, 0x00000080,
-	0xbf0a7b7d, 0xbfa2fff7,
-	0xbfa0016e, 0xbef4007e,
-	0x8b75ff7f, 0x0000ffff,
-	0x8c75ff75, 0x00040000,
-	0xbef60080, 0xbef700ff,
-	0x10807fac, 0xbef1007f,
-	0xb8f20742, 0x84729972,
-	0x8b6eff7f, 0x04000000,
-	0xbfa1003b, 0xbefe00c1,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef4306,
-	0x8b6fc16f, 0xbfa10030,
-	0x846f896f, 0xbef6006f,
+	0x00000000, 0xc4068070,
+	0x008ce801, 0x00010000,
+	0xc4068070, 0x008ce802,
+	0x00020000, 0xc4068070,
+	0x008ce803, 0x00030000,
+	0x807d847d, 0x8070ff70,
+	0x00000400, 0xbf0a7b7d,
+	0xbfa2ffeb, 0xb8fb1e06,
+	0x8b7bc17b, 0xbfa1000d,
+	0x847b837b, 0x807b7d7b,
+	0xbefe00c1, 0xbeff0080,
+	0x7e008700, 0xc4068070,
+	0x008ce800, 0x00000000,
+	0x807d817d, 0x8070ff70,
+	0x00000080, 0xbf0a7b7d,
+	0xbfa2fff7, 0xbfa0016e,
+	0xbef4007e, 0x8b75ff7f,
+	0x0000ffff, 0x8c75ff75,
+	0x00040000, 0xbef60080,
+	0xbef700ff, 0x10807fac,
+	0xbef1007f, 0xb8f20742,
+	0x84729972, 0x8b6eff7f,
+	0x04000000, 0xbfa1003b,
+	0xbefe00c1, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8ef4306, 0x8b6fc16f,
+	0xbfa10030, 0x846f896f,
+	0xbef6006f, 0xb8f83b05,
+	0x80788178, 0xbf0d9972,
+	0xbfa20002, 0x84788978,
+	0xbfa00001, 0x84788a78,
+	0xb8ee1e06, 0x846e8a6e,
+	0x80786e78, 0x8078ff78,
+	0x00000200, 0x8078ff78,
+	0x00000080, 0xbef600ff,
+	0x01000000, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbefd0080, 0xbfa2000d,
+	0xc4050078, 0x0080e800,
+	0x00000000, 0xbf8a0000,
+	0xdac00000, 0x00000000,
+	0x807dff7d, 0x00000080,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7d, 0xbfa2fff4,
+	0xbfa0000c, 0xc4050078,
+	0x0080e800, 0x00000000,
+	0xbf8a0000, 0xdac00000,
+	0x00000000, 0x807dff7d,
+	0x00000100, 0x8078ff78,
+	0x00000100, 0xbf0a6f7d,
+	0xbfa2fff4, 0xbef80080,
+	0xbefe00c1, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa20002, 0xbeff0080,
+	0xbfa00001, 0xbeff00c1,
+	0xb8ef3b05, 0x806f816f,
+	0x846f826f, 0x857d9972,
+	0x8b7d817d, 0xbf06817d,
+	0xbfa2002c, 0xbef600ff,
+	0x01000000, 0xbeee0078,
+	0x8078ff78, 0x00000200,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10061, 0xc4050078,
+	0x008ce800, 0x00000000,
+	0xc4050078, 0x008ce801,
+	0x00008000, 0xc4050078,
+	0x008ce802, 0x00010000,
+	0xc4050078, 0x008ce803,
+	0x00018000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000200, 0xbf0a6f7d,
+	0xbfa2ffea, 0xc405006e,
+	0x008ce800, 0x00000000,
+	0xc405006e, 0x008ce801,
+	0x00008000, 0xc405006e,
+	0x008ce802, 0x00010000,
+	0xc405006e, 0x008ce803,
+	0x00018000, 0xbf8a0000,
+	0xbfa0003d, 0xbef600ff,
+	0x01000000, 0xbeee0078,
+	0x8078ff78, 0x00000400,
+	0xbefd0084, 0xbf0a6f7d,
+	0xbfa10016, 0xc4050078,
+	0x008ce800, 0x00000000,
+	0xc4050078, 0x008ce801,
+	0x00010000, 0xc4050078,
+	0x008ce802, 0x00020000,
+	0xc4050078, 0x008ce803,
+	0x00030000, 0xbf8a0000,
+	0x7e008500, 0x7e028501,
+	0x7e048502, 0x7e068503,
+	0x807d847d, 0x8078ff78,
+	0x00000400, 0xbf0a6f7d,
+	0xbfa2ffea, 0xb8ef1e06,
+	0x8b6fc16f, 0xbfa1000f,
+	0x846f836f, 0x806f7d6f,
+	0xbefe00c1, 0xbeff0080,
+	0xc4050078, 0x008ce800,
+	0x00000000, 0xbf8a0000,
+	0x7e008500, 0x807d817d,
+	0x8078ff78, 0x00000080,
+	0xbf0a6f7d, 0xbfa2fff6,
+	0xbeff00c1, 0xc405006e,
+	0x008ce800, 0x00000000,
+	0xc405006e, 0x008ce801,
+	0x00010000, 0xc405006e,
+	0x008ce802, 0x00020000,
+	0xc405006e, 0x008ce803,
+	0x00030000, 0xbf8a0000,
 	0xb8f83b05, 0x80788178,
 	0xbf0d9972, 0xbfa20002,
 	0x84788978, 0xbfa00001,
 	0x84788a78, 0xb8ee1e06,
 	0x846e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0x8078ff78, 0x00000080,
-	0xbef600ff, 0x01000000,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbefd0080,
-	0xbfa2000d, 0xc4050078,
-	0x0080e800, 0x00000000,
-	0xbf8a0000, 0xdac00000,
-	0x00000000, 0x807dff7d,
-	0x00000080, 0x8078ff78,
-	0x00000080, 0xbf0a6f7d,
-	0xbfa2fff4, 0xbfa0000c,
-	0xc4050078, 0x0080e800,
-	0x00000000, 0xbf8a0000,
-	0xdac00000, 0x00000000,
-	0x807dff7d, 0x00000100,
-	0x8078ff78, 0x00000100,
-	0xbf0a6f7d, 0xbfa2fff4,
-	0xbef80080, 0xbefe00c1,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa20002,
-	0xbeff0080, 0xbfa00001,
-	0xbeff00c1, 0xb8ef3b05,
-	0x806f816f, 0x846f826f,
-	0x857d9972, 0x8b7d817d,
-	0xbf06817d, 0xbfa2002c,
+	0x80f8ff78, 0x00000050,
 	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000200, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10061,
-	0xc4050078, 0x008ce800,
-	0x00000000, 0xc4050078,
-	0x008ce801, 0x00008000,
-	0xc4050078, 0x008ce802,
-	0x00010000, 0xc4050078,
-	0x008ce803, 0x00018000,
-	0xbf8a0000, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
+	0xbefd00ff, 0x0000006c,
+	0x80f89078, 0xf462403a,
+	0xf0000000, 0xbf8a0000,
+	0x80fd847d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0x80f8a078, 0xf462603a,
+	0xf0000000, 0xbf8a0000,
+	0x80fd887d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0x80f8c078, 0xf462803a,
+	0xf0000000, 0xbf8a0000,
+	0x80fd907d, 0xbf800000,
+	0xbe804300, 0xbe824302,
+	0xbe844304, 0xbe864306,
+	0xbe884308, 0xbe8a430a,
+	0xbe8c430c, 0xbe8e430e,
+	0xbf06807d, 0xbfa1fff0,
+	0xb980f801, 0x00000000,
+	0xb8f83b05, 0x80788178,
+	0xbf0d9972, 0xbfa20002,
+	0x84788978, 0xbfa00001,
+	0x84788a78, 0xb8ee1e06,
+	0x846e8a6e, 0x80786e78,
 	0x8078ff78, 0x00000200,
-	0xbf0a6f7d, 0xbfa2ffea,
-	0xc405006e, 0x008ce800,
-	0x00000000, 0xc405006e,
-	0x008ce801, 0x00008000,
-	0xc405006e, 0x008ce802,
-	0x00010000, 0xc405006e,
-	0x008ce803, 0x00018000,
-	0xbf8a0000, 0xbfa0003d,
 	0xbef600ff, 0x01000000,
-	0xbeee0078, 0x8078ff78,
-	0x00000400, 0xbefd0084,
-	0xbf0a6f7d, 0xbfa10016,
-	0xc4050078, 0x008ce800,
-	0x00000000, 0xc4050078,
-	0x008ce801, 0x00010000,
-	0xc4050078, 0x008ce802,
-	0x00020000, 0xc4050078,
-	0x008ce803, 0x00030000,
-	0xbf8a0000, 0x7e008500,
-	0x7e028501, 0x7e048502,
-	0x7e068503, 0x807d847d,
-	0x8078ff78, 0x00000400,
-	0xbf0a6f7d, 0xbfa2ffea,
-	0xb8ef1e06, 0x8b6fc16f,
-	0xbfa1000f, 0x846f836f,
-	0x806f7d6f, 0xbefe00c1,
-	0xbeff0080, 0xc4050078,
-	0x008ce800, 0x00000000,
-	0xbf8a0000, 0x7e008500,
-	0x807d817d, 0x8078ff78,
-	0x00000080, 0xbf0a6f7d,
-	0xbfa2fff6, 0xbeff00c1,
-	0xc405006e, 0x008ce800,
-	0x00000000, 0xc405006e,
-	0x008ce801, 0x00010000,
-	0xc405006e, 0x008ce802,
-	0x00020000, 0xc405006e,
-	0x008ce803, 0x00030000,
-	0xbf8a0000, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0xb8ee1e06, 0x846e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0x80f8ff78,
-	0x00000050, 0xbef600ff,
-	0x01000000, 0xbefd00ff,
-	0x0000006c, 0x80f89078,
-	0xf462403a, 0xf0000000,
-	0xbf8a0000, 0x80fd847d,
-	0xbf800000, 0xbe804300,
-	0xbe824302, 0x80f8a078,
-	0xf462603a, 0xf0000000,
-	0xbf8a0000, 0x80fd887d,
-	0xbf800000, 0xbe804300,
-	0xbe824302, 0xbe844304,
-	0xbe864306, 0x80f8c078,
-	0xf462803a, 0xf0000000,
-	0xbf8a0000, 0x80fd907d,
-	0xbf800000, 0xbe804300,
-	0xbe824302, 0xbe844304,
-	0xbe864306, 0xbe884308,
-	0xbe8a430a, 0xbe8c430c,
-	0xbe8e430e, 0xbf06807d,
-	0xbfa1fff0, 0xb980f801,
-	0x00000000, 0xb8f83b05,
-	0x80788178, 0xbf0d9972,
-	0xbfa20002, 0x84788978,
-	0xbfa00001, 0x84788a78,
-	0xb8ee1e06, 0x846e8a6e,
-	0x80786e78, 0x8078ff78,
-	0x00000200, 0xbef600ff,
-	0x01000000, 0xbeff0071,
-	0xf4621bfa, 0xf0000000,
-	0x80788478, 0xf4621b3a,
+	0xbeff0071, 0xf4621bfa,
 	0xf0000000, 0x80788478,
-	0xf4621b7a, 0xf0000000,
-	0x80788478, 0xf4621c3a,
+	0xf4621b3a, 0xf0000000,
+	0x80788478, 0xf4621b7a,
 	0xf0000000, 0x80788478,
-	0xf4621c7a, 0xf0000000,
-	0x80788478, 0xf4621eba,
+	0xf4621c3a, 0xf0000000,
+	0x80788478, 0xf4621c7a,
 	0xf0000000, 0x80788478,
-	0xf4621efa, 0xf0000000,
-	0x80788478, 0xf4621e7a,
+	0xf4621eba, 0xf0000000,
+	0x80788478, 0xf4621efa,
 	0xf0000000, 0x80788478,
-	0xf4621cfa, 0xf0000000,
-	0x80788478, 0xf4621bba,
+	0xf4621e7a, 0xf0000000,
+	0x80788478, 0xf4621cfa,
 	0xf0000000, 0x80788478,
-	0xbf8a0000, 0xb96ef814,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf8a0000,
-	0xb96ef815, 0xf4621bba,
+	0xb96ef814, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf8a0000, 0xb96ef812,
+	0xbf8a0000, 0xb96ef815,
 	0xf4621bba, 0xf0000000,
 	0x80788478, 0xbf8a0000,
-	0xb96ef813, 0x8b6eff7f,
-	0x04000000, 0xbfa1000d,
-	0x80788478, 0xf4621bba,
+	0xb96ef812, 0xf4621bba,
 	0xf0000000, 0x80788478,
-	0xbf8a0000, 0xbf0d806e,
-	0xbfa10006, 0x856e906e,
-	0x8b6e6e6e, 0xbfa10003,
-	0xbe804ec1, 0x816ec16e,
-	0xbfa0fffb, 0xbefd006f,
-	0xbefe0070, 0xbeff0071,
-	0xb97b2011, 0x857b867b,
-	0xb97b0191, 0x857b827b,
-	0xb97bba11, 0xb973f801,
-	0xb8ee3b05, 0x806e816e,
-	0xbf0d9972, 0xbfa20002,
-	0x846e896e, 0xbfa00001,
-	0x846e8a6e, 0xb8ef1e06,
-	0x846f8a6f, 0x806e6f6e,
-	0x806eff6e, 0x00000200,
-	0x806e746e, 0x826f8075,
-	0x8b6fff6f, 0x0000ffff,
-	0xf4605c37, 0xf8000050,
-	0xf4605d37, 0xf8000060,
-	0xf4601e77, 0xf8000074,
-	0xbf8a0000, 0x8b6dff6d,
-	0x0000ffff, 0x8bfe7e7e,
-	0x8bea6a6a, 0xb97af804,
+	0xbf8a0000, 0xb96ef813,
+	0x8b6eff7f, 0x04000000,
+	0xbfa1000d, 0x80788478,
+	0xf4621bba, 0xf0000000,
+	0x80788478, 0xbf8a0000,
+	0xbf0d806e, 0xbfa10006,
+	0x856e906e, 0x8b6e6e6e,
+	0xbfa10003, 0xbe804ec1,
+	0x816ec16e, 0xbfa0fffb,
+	0xbefd006f, 0xbefe0070,
+	0xbeff0071, 0xb97b2011,
+	0x857b867b, 0xb97b0191,
+	0x857b827b, 0xb97bba11,
+	0xb973f801, 0xb8ee3b05,
+	0x806e816e, 0xbf0d9972,
+	0xbfa20002, 0x846e896e,
+	0xbfa00001, 0x846e8a6e,
+	0xb8ef1e06, 0x846f8a6f,
+	0x806e6f6e, 0x806eff6e,
+	0x00000200, 0x806e746e,
+	0x826f8075, 0x8b6fff6f,
+	0x0000ffff, 0xf4605c37,
+	0xf8000050, 0xf4605d37,
+	0xf8000060, 0xf4601e77,
+	0xf8000074, 0xbf8a0000,
+	0x8b6dff6d, 0x0000ffff,
+	0x8bfe7e7e, 0x8bea6a6a,
+	0xb97af804, 0xbe804ec2,
+	0xbf94fffe, 0xbe804a6c,
 	0xbe804ec2, 0xbf94fffe,
-	0xbe804a6c, 0xbe804ec2,
-	0xbf94fffe, 0xbfb10000,
+	0xbfb10000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
 	0xbf9f0000, 0xbf9f0000,
-	0xbf9f0000, 0x00000000,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index 7b9d36e5fa43..5a1a1b1f897f 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -30,6 +30,7 @@
 #define CHIP_GFX12 37
 
 #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
+#define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
 
 var SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK	= 0x4
 var SQ_WAVE_STATE_PRIV_SCC_SHIFT		= 9
@@ -351,6 +352,7 @@ L_HAVE_VGPRS:
 	v_writelane_b32	v0, ttmp13, 0xD
 	v_writelane_b32	v0, exec_lo, 0xE
 	v_writelane_b32	v0, exec_hi, 0xF
+	valu_sgpr_hazard()
 
 	s_mov_b32	exec_lo, 0x3FFF
 	s_mov_b32	exec_hi, 0x0
@@ -417,7 +419,6 @@ L_SAVE_HWREG:
 	v_mov_b32	v0, 0x0							//Offset[31:0] from buffer resource
 	v_mov_b32	v1, 0x0							//Offset[63:32] from buffer resource
 	v_mov_b32	v2, 0x0							//Set of SGPRs for TCP store
-	s_mov_b32	m0, 0x0							//Next lane of v2 to write to
 
 	// Ensure no further changes to barrier or LDS state.
 	// STATE_PRIV.BARRIER_COMPLETE may change up to this point.
@@ -430,40 +431,41 @@ L_SAVE_HWREG:
 	s_andn2_b32	s_save_state_priv, s_save_state_priv, SQ_WAVE_STATE_PRIV_BARRIER_COMPLETE_MASK
 	s_or_b32	s_save_state_priv, s_save_state_priv, s_save_tmp
 
-	write_hwreg_to_v2(s_save_m0)
-	write_hwreg_to_v2(s_save_pc_lo)
 	s_andn2_b32	s_save_tmp, s_save_pc_hi, S_SAVE_PC_HI_FIRST_WAVE_MASK
-	write_hwreg_to_v2(s_save_tmp)
-	write_hwreg_to_v2(s_save_exec_lo)
-	write_hwreg_to_v2(s_save_exec_hi)
-	write_hwreg_to_v2(s_save_state_priv)
+	v_writelane_b32	v2, s_save_m0, 0x0
+	v_writelane_b32	v2, s_save_pc_lo, 0x1
+	v_writelane_b32	v2, s_save_tmp, 0x2
+	v_writelane_b32	v2, s_save_exec_lo, 0x3
+	v_writelane_b32	v2, s_save_exec_hi, 0x4
+	v_writelane_b32	v2, s_save_state_priv, 0x5
+	v_writelane_b32	v2, s_save_xnack_mask, 0x7
+	valu_sgpr_hazard()
 
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
-	write_hwreg_to_v2(s_save_tmp)
+	v_writelane_b32	v2, s_save_tmp, 0x6
 
-	write_hwreg_to_v2(s_save_xnack_mask)
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_MODE)
+	v_writelane_b32	v2, s_save_tmp, 0x8
 
-	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_MODE)
-	write_hwreg_to_v2(s_save_m0)
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
+	v_writelane_b32	v2, s_save_tmp, 0x9
 
-	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_LO)
-	write_hwreg_to_v2(s_save_m0)
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
+	v_writelane_b32	v2, s_save_tmp, 0xA
 
-	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_SCRATCH_BASE_HI)
-	write_hwreg_to_v2(s_save_m0)
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
+	v_writelane_b32	v2, s_save_tmp, 0xB
 
-	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_EXCP_FLAG_USER)
-	write_hwreg_to_v2(s_save_m0)
-
-	s_getreg_b32	s_save_m0, hwreg(HW_REG_WAVE_TRAP_CTRL)
-	write_hwreg_to_v2(s_save_m0)
+	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_TRAP_CTRL)
+	v_writelane_b32	v2, s_save_tmp, 0xC
 
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_STATUS)
-	write_hwreg_to_v2(s_save_tmp)
+	v_writelane_b32	v2, s_save_tmp, 0xD
 
 	s_get_barrier_state s_save_tmp, -1
 	s_wait_kmcnt (0)
-	write_hwreg_to_v2(s_save_tmp)
+	v_writelane_b32	v2, s_save_tmp, 0xE
+	valu_sgpr_hazard()
 
 	// Write HWREGs with 16 VGPR lanes. TTMPs occupy space after this.
 	s_mov_b32       exec_lo, 0xFFFF
@@ -497,10 +499,12 @@ L_SAVE_SGPR_LOOP:
 	s_movrels_b64	s12, s12						//s12 = s[12+m0], s13 = s[13+m0]
 	s_movrels_b64	s14, s14						//s14 = s[14+m0], s15 = s[15+m0]
 
-	write_16sgpr_to_v2(s0)
-
-	s_cmp_eq_u32	ttmp13, 0x20						//have 32 VGPR lanes filled?
-	s_cbranch_scc0	L_SAVE_SGPR_SKIP_TCP_STORE
+	s_cmp_eq_u32	ttmp13, 0x0
+	s_cbranch_scc0	L_WRITE_V2_SECOND_HALF
+	write_16sgpr_to_v2(s0, 0x0)
+	s_branch	L_SAVE_SGPR_SKIP_TCP_STORE
+L_WRITE_V2_SECOND_HALF:
+	write_16sgpr_to_v2(s0, 0x10)
 
 	buffer_store_dword	v2, v0, s_save_buf_rsrc0, s_save_mem_offset scope:SCOPE_SYS
 	s_add_u32	s_save_mem_offset, s_save_mem_offset, 0x80
@@ -1056,27 +1060,21 @@ L_END_PGM:
 	s_endpgm_saved
 end
 
-function write_hwreg_to_v2(s)
-	// Copy into VGPR for later TCP store.
-	v_writelane_b32	v2, s, m0
-	s_add_u32	m0, m0, 0x1
-end
-
-
-function write_16sgpr_to_v2(s)
+function write_16sgpr_to_v2(s, lane_offset)
 	// Copy into VGPR for later TCP store.
 	for var sgpr_idx = 0; sgpr_idx < 16; sgpr_idx ++
-		v_writelane_b32	v2, s[sgpr_idx], ttmp13
-		s_add_u32	ttmp13, ttmp13, 0x1
+		v_writelane_b32	v2, s[sgpr_idx], sgpr_idx + lane_offset
 	end
+	valu_sgpr_hazard()
+	s_add_u32	ttmp13, ttmp13, 0x10
 end
 
 function write_12sgpr_to_v2(s)
 	// Copy into VGPR for later TCP store.
 	for var sgpr_idx = 0; sgpr_idx < 12; sgpr_idx ++
-		v_writelane_b32	v2, s[sgpr_idx], ttmp13
-		s_add_u32	ttmp13, ttmp13, 0x1
+		v_writelane_b32	v2, s[sgpr_idx], sgpr_idx
 	end
+	valu_sgpr_hazard()
 end
 
 function read_hwreg_from_mem(s, s_rsrc, s_mem_offset)
@@ -1128,3 +1126,11 @@ function get_wave_size2(s_reg)
 	s_getreg_b32	s_reg, hwreg(HW_REG_WAVE_STATUS,SQ_WAVE_STATUS_WAVE64_SHIFT,SQ_WAVE_STATUS_WAVE64_SIZE)
 	s_lshl_b32	s_reg, s_reg, S_WAVE_SIZE
 end
+
+function valu_sgpr_hazard
+#if HAVE_VALU_SGPR_HAZARD
+	for var rep = 0; rep < 8; rep ++
+		ds_nop
+	end
+#endif
+end
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9186ef0bd2a3..07eadab4c1c4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -537,7 +537,8 @@ static void kfd_cwsr_init(struct kfd_dev *kfd)
 			kfd->cwsr_isa = cwsr_trap_gfx11_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx11_hex);
 		} else {
-			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex) > PAGE_SIZE);
+			BUILD_BUG_ON(sizeof(cwsr_trap_gfx12_hex)
+					     > KFD_CWSR_TMA_OFFSET);
 			kfd->cwsr_isa = cwsr_trap_gfx12_hex;
 			kfd->cwsr_isa_size = sizeof(cwsr_trap_gfx12_hex);
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ea3792249209..6798510c4a70 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1315,6 +1315,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
 	if (unlikely(user_gpu_id == -EINVAL)) {
 		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
+		kfd_unref_process(p);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 1f9f5bfeaf86..d87b895660c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -237,7 +237,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 
 	packet->bitfields2.engine_sel =
 		engine_sel__mes_map_queues__compute_vi;
-	packet->bitfields2.gws_control_queue = q->gws ? 1 : 0;
+	packet->bitfields2.gws_control_queue = q->properties.is_gws ? 1 : 0;
 	packet->bitfields2.extended_engine_sel =
 		extended_engine_sel__mes_map_queues__legacy_engine_sel;
 	packet->bitfields2.queue_type =
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 7e3d506bb79b..f3aa93ddbf9c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -762,6 +762,7 @@ static void populate_dml21_plane_config_from_plane_state(struct dml2_context *dm
 		plane->pixel_format = dml2_420_10;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
 		plane->pixel_format = dml2_444_64;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 0090b7bc232b..157903115f3b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4651,7 +4651,10 @@ static void calculate_tdlut_setting(
 	//the tdlut is fetched during the 2 row times of prefetch.
 	if (p->setup_for_tdlut) {
 		*p->tdlut_groups_per_2row_ub = (unsigned int)math_ceil2((double) *p->tdlut_bytes_per_frame / *p->tdlut_bytes_per_group, 1);
-		*p->tdlut_opt_time = (*p->tdlut_bytes_per_frame - p->cursor_buffer_size * 1024) / tdlut_drain_rate;
+		if (*p->tdlut_bytes_per_frame > p->cursor_buffer_size * 1024)
+			*p->tdlut_opt_time = (*p->tdlut_bytes_per_frame - p->cursor_buffer_size * 1024) / tdlut_drain_rate;
+		else
+			*p->tdlut_opt_time = 0;
 		*p->tdlut_drain_time = p->cursor_buffer_size * 1024 / tdlut_drain_rate;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 92a3fff1e261..405aefd14d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -909,6 +909,7 @@ static void populate_dml_surface_cfg_from_plane_state(enum dml_project_id dml2_p
 		out->SourcePixelFormat[location] = dml_420_10;
 		break;
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
+	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
 	case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616F:
 	case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616F:
 		out->SourcePixelFormat[location] = dml_444_64;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 59457ca24e1d..03b22e9115ea 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -951,8 +951,8 @@ void dce110_edp_backlight_control(
 	struct dc_context *ctx = link->ctx;
 	struct bp_transmitter_control cntl = { 0 };
 	uint8_t pwrseq_instance = 0;
-	unsigned int pre_T11_delay = OLED_PRE_T11_DELAY;
-	unsigned int post_T7_delay = OLED_POST_T7_DELAY;
+	unsigned int pre_T11_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_PRE_T11_DELAY : 0);
+	unsigned int post_T7_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_POST_T7_DELAY : 0);
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
 		!= CONNECTOR_ID_EDP) {
@@ -1067,7 +1067,8 @@ void dce110_edp_backlight_control(
 	if (!enable) {
 		/*follow oem panel config's requirement*/
 		pre_T11_delay += link->panel_config.pps.extra_pre_t11_ms;
-		msleep(pre_T11_delay);
+		if (pre_T11_delay)
+			msleep(pre_T11_delay);
 	}
 }
 
@@ -1216,7 +1217,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (!link->skip_implict_edp_power_control)
+		if (!link->skip_implict_edp_power_control && hws)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index 8c137d7c032e..e58e7b93810b 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -368,6 +368,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_enable_encryption(struct mod_hdcp *hdcp)
 	struct mod_hdcp_display *display = get_first_active_display(hdcp);
 	enum mod_hdcp_status status = MOD_HDCP_STATUS_SUCCESS;
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	mutex_lock(&psp->hdcp_context.mutex);
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 	memset(hdcp_cmd, 0, sizeof(struct ta_hdcp_shared_memory));
diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
index 24ed1cd3caf1..162dc0698f4a 100644
--- a/drivers/gpu/drm/ast/ast_mode.c
+++ b/drivers/gpu/drm/ast/ast_mode.c
@@ -1319,9 +1319,9 @@ static void ast_mode_config_helper_atomic_commit_tail(struct drm_atomic_state *s
 
 	/*
 	 * Concurrent operations could possibly trigger a call to
-	 * drm_connector_helper_funcs.get_modes by trying to read the
-	 * display modes. Protect access to I/O registers by acquiring
-	 * the I/O-register lock. Released in atomic_flush().
+	 * drm_connector_helper_funcs.get_modes by reading the display
+	 * modes. Protect access to registers by acquiring the modeset
+	 * lock.
 	 */
 	mutex_lock(&ast->modeset_lock);
 	drm_atomic_helper_commit_tail(state);
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 7457d38622b0..89eed0668bfb 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -568,15 +568,18 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long dsi_hss_hsa_hse_hbp;
 	unsigned int nlanes = output->dev->lanes;
+	int mode_clock = (mode_valid_check ? mode->clock : mode->crtc_clock);
 	int ret;
 
 	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg, mode_valid_check);
 	if (ret)
 		return ret;
 
-	phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
-					 mipi_dsi_pixel_format_to_bpp(output->dev->format),
-					 nlanes, phy_cfg);
+	ret = phy_mipi_dphy_get_default_config(mode_clock * 1000,
+					       mipi_dsi_pixel_format_to_bpp(output->dev->format),
+					       nlanes, phy_cfg);
+	if (ret)
+		return ret;
 
 	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode, mode_valid_check);
 	if (ret)
@@ -680,6 +683,11 @@ static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 
+	dsi->phy_initialized = false;
+	dsi->link_initialized = false;
+	phy_power_off(dsi->dphy);
+	phy_exit(dsi->dphy);
+
 	pm_runtime_put(dsi->base.dev);
 }
 
@@ -761,7 +769,7 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
-	u32 tmp, reg_wakeup, div;
+	u32 tmp, reg_wakeup, div, status;
 	int nlanes;
 
 	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
@@ -778,6 +786,19 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	cdns_dsi_hs_init(dsi);
 	cdns_dsi_init_link(dsi);
 
+	/*
+	 * Now that the DSI Link and DSI Phy are initialized,
+	 * wait for the CLK and Data Lanes to be ready.
+	 */
+	tmp = CLK_LANE_RDY;
+	for (int i = 0; i < nlanes; i++)
+		tmp |= DATA_LANE_RDY(i);
+
+	if (readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
+			       (tmp == (status & tmp)), 100, 500000))
+		dev_err(dsi->base.dev,
+			"Timed Out: DSI-DPhy Clock and Data Lanes not ready.\n");
+
 	writel(HBP_LEN(dsi_cfg.hbp) | HSA_LEN(dsi_cfg.hsa),
 	       dsi->regs + VID_HSIZE1);
 	writel(HFP_LEN(dsi_cfg.hfp) | HACT_LEN(dsi_cfg.hact),
@@ -952,7 +973,7 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_DSI);
 	} else {
-		bridge = of_drm_find_bridge(dev->dev.of_node);
+		bridge = of_drm_find_bridge(np);
 		if (!bridge)
 			bridge = ERR_PTR(-EINVAL);
 	}
@@ -1152,7 +1173,6 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	clk_disable_unprepare(dsi->dsi_sys_clk);
 	clk_disable_unprepare(dsi->dsi_p_clk);
 	reset_control_assert(dsi->dsi_p_rst);
-	dsi->link_initialized = false;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 95ce50ed53ac..5500767cda7e 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -331,12 +331,18 @@ static void ti_sn65dsi86_enable_comms(struct ti_sn65dsi86 *pdata)
 	 * 200 ms.  We'll assume that the panel driver will have the hardcoded
 	 * delay in its prepare and always disable HPD.
 	 *
-	 * If HPD somehow makes sense on some future panel we'll have to
-	 * change this to be conditional on someone specifying that HPD should
-	 * be used.
+	 * For DisplayPort bridge type, we need HPD. So we use the bridge type
+	 * to conditionally disable HPD.
+	 * NOTE: The bridge type is set in ti_sn_bridge_probe() but enable_comms()
+	 * can be called before. So for DisplayPort, HPD will be enabled once
+	 * bridge type is set. We are using bridge type instead of "no-hpd"
+	 * property because it is not used properly in devicetree description
+	 * and hence is unreliable.
 	 */
-	regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG, HPD_DISABLE,
-			   HPD_DISABLE);
+
+	if (pdata->bridge.type != DRM_MODE_CONNECTOR_DisplayPort)
+		regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG, HPD_DISABLE,
+				   HPD_DISABLE);
 
 	pdata->comms_enabled = true;
 
@@ -424,36 +430,8 @@ static int status_show(struct seq_file *s, void *data)
 
 	return 0;
 }
-
 DEFINE_SHOW_ATTRIBUTE(status);
 
-static void ti_sn65dsi86_debugfs_remove(void *data)
-{
-	debugfs_remove_recursive(data);
-}
-
-static void ti_sn65dsi86_debugfs_init(struct ti_sn65dsi86 *pdata)
-{
-	struct device *dev = pdata->dev;
-	struct dentry *debugfs;
-	int ret;
-
-	debugfs = debugfs_create_dir(dev_name(dev), NULL);
-
-	/*
-	 * We might get an error back if debugfs wasn't enabled in the kernel
-	 * so let's just silently return upon failure.
-	 */
-	if (IS_ERR_OR_NULL(debugfs))
-		return;
-
-	ret = devm_add_action_or_reset(dev, ti_sn65dsi86_debugfs_remove, debugfs);
-	if (ret)
-		return;
-
-	debugfs_create_file("status", 0600, debugfs, pdata, &status_fops);
-}
-
 /* -----------------------------------------------------------------------------
  * Auxiliary Devices (*not* AUX)
  */
@@ -1201,9 +1179,14 @@ static enum drm_connector_status ti_sn_bridge_detect(struct drm_bridge *bridge)
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
 	int val = 0;
 
-	pm_runtime_get_sync(pdata->dev);
+	/*
+	 * Runtime reference is grabbed in ti_sn_bridge_hpd_enable()
+	 * as the chip won't report HPD just after being powered on.
+	 * HPD_DEBOUNCED_STATE reflects correct state only after the
+	 * debounce time (~100-400 ms).
+	 */
+
 	regmap_read(pdata->regmap, SN_HPD_DISABLE_REG, &val);
-	pm_runtime_put_autosuspend(pdata->dev);
 
 	return val & HPD_DEBOUNCED_STATE ? connector_status_connected
 					 : connector_status_disconnected;
@@ -1217,6 +1200,35 @@ static const struct drm_edid *ti_sn_bridge_edid_read(struct drm_bridge *bridge,
 	return drm_edid_read_ddc(connector, &pdata->aux.ddc);
 }
 
+static void ti_sn65dsi86_debugfs_init(struct drm_bridge *bridge, struct dentry *root)
+{
+	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+	struct dentry *debugfs;
+
+	debugfs = debugfs_create_dir(dev_name(pdata->dev), root);
+	debugfs_create_file("status", 0600, debugfs, pdata, &status_fops);
+}
+
+static void ti_sn_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+
+	/*
+	 * Device needs to be powered on before reading the HPD state
+	 * for reliable hpd detection in ti_sn_bridge_detect() due to
+	 * the high debounce time.
+	 */
+
+	pm_runtime_get_sync(pdata->dev);
+}
+
+static void ti_sn_bridge_hpd_disable(struct drm_bridge *bridge)
+{
+	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
+
+	pm_runtime_put_autosuspend(pdata->dev);
+}
+
 static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
 	.attach = ti_sn_bridge_attach,
 	.detach = ti_sn_bridge_detach,
@@ -1230,6 +1242,9 @@ static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.debugfs_init = ti_sn65dsi86_debugfs_init,
+	.hpd_enable = ti_sn_bridge_hpd_enable,
+	.hpd_disable = ti_sn_bridge_hpd_disable,
 };
 
 static void ti_sn_bridge_parse_lanes(struct ti_sn65dsi86 *pdata,
@@ -1318,8 +1333,26 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
 	pdata->bridge.type = pdata->next_bridge->type == DRM_MODE_CONNECTOR_DisplayPort
 			   ? DRM_MODE_CONNECTOR_DisplayPort : DRM_MODE_CONNECTOR_eDP;
 
-	if (pdata->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
-		pdata->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
+	if (pdata->bridge.type == DRM_MODE_CONNECTOR_DisplayPort) {
+		pdata->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT |
+				    DRM_BRIDGE_OP_HPD;
+		/*
+		 * If comms were already enabled they would have been enabled
+		 * with the wrong value of HPD_DISABLE. Update it now. Comms
+		 * could be enabled if anyone is holding a pm_runtime reference
+		 * (like if a GPIO is in use). Note that in most cases nobody
+		 * is doing AUX channel xfers before the bridge is added so
+		 * HPD doesn't _really_ matter then. The only exception is in
+		 * the eDP case where the panel wants to read the EDID before
+		 * the bridge is added. We always consistently have HPD disabled
+		 * for eDP.
+		 */
+		mutex_lock(&pdata->comms_mutex);
+		if (pdata->comms_enabled)
+			regmap_update_bits(pdata->regmap, SN_HPD_DISABLE_REG,
+					   HPD_DISABLE, 0);
+		mutex_unlock(&pdata->comms_mutex);
+	};
 
 	drm_bridge_add(&pdata->bridge);
 
@@ -1938,8 +1971,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ti_sn65dsi86_debugfs_init(pdata);
-
 	/*
 	 * Break ourselves up into a collection of aux devices. The only real
 	 * motiviation here is to solve the chicken-and-egg problem of probe
diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index 7c8287c18e38..6fcf2a8bf676 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: MIT
 
 #include <linux/fb.h>
+#include <linux/vmalloc.h>
 
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_drv.h>
@@ -72,43 +73,108 @@ static const struct fb_ops drm_fbdev_dma_fb_ops = {
 	.fb_destroy = drm_fbdev_dma_fb_destroy,
 };
 
-FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(drm_fbdev_dma,
+FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS(drm_fbdev_dma_shadowed,
 				   drm_fb_helper_damage_range,
 				   drm_fb_helper_damage_area);
 
-static int drm_fbdev_dma_deferred_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
+static void drm_fbdev_dma_shadowed_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *fb_helper = info->par;
-	struct drm_framebuffer *fb = fb_helper->fb;
-	struct drm_gem_dma_object *dma = drm_fb_dma_get_gem_obj(fb, 0);
+	void *shadow = info->screen_buffer;
+
+	if (!fb_helper->dev)
+		return;
 
-	if (!dma->map_noncoherent)
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	if (info->fbdefio)
+		fb_deferred_io_cleanup(info);
+	drm_fb_helper_fini(fb_helper);
+	vfree(shadow);
 
-	return fb_deferred_io_mmap(info, vma);
+	drm_client_buffer_vunmap(fb_helper->buffer);
+	drm_client_framebuffer_delete(fb_helper->buffer);
+	drm_client_release(&fb_helper->client);
+	drm_fb_helper_unprepare(fb_helper);
+	kfree(fb_helper);
 }
 
-static const struct fb_ops drm_fbdev_dma_deferred_fb_ops = {
+static const struct fb_ops drm_fbdev_dma_shadowed_fb_ops = {
 	.owner = THIS_MODULE,
 	.fb_open = drm_fbdev_dma_fb_open,
 	.fb_release = drm_fbdev_dma_fb_release,
-	__FB_DEFAULT_DEFERRED_OPS_RDWR(drm_fbdev_dma),
+	FB_DEFAULT_DEFERRED_OPS(drm_fbdev_dma_shadowed),
 	DRM_FB_HELPER_DEFAULT_OPS,
-	__FB_DEFAULT_DEFERRED_OPS_DRAW(drm_fbdev_dma),
-	.fb_mmap = drm_fbdev_dma_deferred_fb_mmap,
-	.fb_destroy = drm_fbdev_dma_fb_destroy,
+	.fb_destroy = drm_fbdev_dma_shadowed_fb_destroy,
 };
 
 /*
  * struct drm_fb_helper
  */
 
+static void drm_fbdev_dma_damage_blit_real(struct drm_fb_helper *fb_helper,
+					   struct drm_clip_rect *clip,
+					   struct iosys_map *dst)
+{
+	struct drm_framebuffer *fb = fb_helper->fb;
+	size_t offset = clip->y1 * fb->pitches[0];
+	size_t len = clip->x2 - clip->x1;
+	unsigned int y;
+	void *src;
+
+	switch (drm_format_info_bpp(fb->format, 0)) {
+	case 1:
+		offset += clip->x1 / 8;
+		len = DIV_ROUND_UP(len + clip->x1 % 8, 8);
+		break;
+	case 2:
+		offset += clip->x1 / 4;
+		len = DIV_ROUND_UP(len + clip->x1 % 4, 4);
+		break;
+	case 4:
+		offset += clip->x1 / 2;
+		len = DIV_ROUND_UP(len + clip->x1 % 2, 2);
+		break;
+	default:
+		offset += clip->x1 * fb->format->cpp[0];
+		len *= fb->format->cpp[0];
+		break;
+	}
+
+	src = fb_helper->info->screen_buffer + offset;
+	iosys_map_incr(dst, offset); /* go to first pixel within clip rect */
+
+	for (y = clip->y1; y < clip->y2; y++) {
+		iosys_map_memcpy_to(dst, 0, src, len);
+		iosys_map_incr(dst, fb->pitches[0]);
+		src += fb->pitches[0];
+	}
+}
+
+static int drm_fbdev_dma_damage_blit(struct drm_fb_helper *fb_helper,
+				     struct drm_clip_rect *clip)
+{
+	struct drm_client_buffer *buffer = fb_helper->buffer;
+	struct iosys_map dst;
+
+	/*
+	 * For fbdev emulation, we only have to protect against fbdev modeset
+	 * operations. Nothing else will involve the client buffer's BO. So it
+	 * is sufficient to acquire struct drm_fb_helper.lock here.
+	 */
+	mutex_lock(&fb_helper->lock);
+
+	dst = buffer->map;
+	drm_fbdev_dma_damage_blit_real(fb_helper, clip, &dst);
+
+	mutex_unlock(&fb_helper->lock);
+
+	return 0;
+}
+
 static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 					 struct drm_fb_helper_surface_size *sizes)
 {
 	return drm_fbdev_dma_driver_fbdev_probe(fb_helper, sizes);
 }
-
 static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
 					 struct drm_clip_rect *clip)
 {
@@ -120,6 +186,10 @@ static int drm_fbdev_dma_helper_fb_dirty(struct drm_fb_helper *helper,
 		return 0;
 
 	if (helper->fb->funcs->dirty) {
+		ret = drm_fbdev_dma_damage_blit(helper, clip);
+		if (drm_WARN_ONCE(dev, ret, "Damage blitter failed: ret=%d\n", ret))
+			return ret;
+
 		ret = helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
 		if (drm_WARN_ONCE(dev, ret, "Dirty helper failed: ret=%d\n", ret))
 			return ret;
@@ -137,14 +207,80 @@ static const struct drm_fb_helper_funcs drm_fbdev_dma_helper_funcs = {
  * struct drm_fb_helper
  */
 
+static int drm_fbdev_dma_driver_fbdev_probe_tail(struct drm_fb_helper *fb_helper,
+						 struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_device *dev = fb_helper->dev;
+	struct drm_client_buffer *buffer = fb_helper->buffer;
+	struct drm_gem_dma_object *dma_obj = to_drm_gem_dma_obj(buffer->gem);
+	struct drm_framebuffer *fb = fb_helper->fb;
+	struct fb_info *info = fb_helper->info;
+	struct iosys_map map = buffer->map;
+
+	info->fbops = &drm_fbdev_dma_fb_ops;
+
+	/* screen */
+	info->flags |= FBINFO_VIRTFB; /* system memory */
+	if (dma_obj->map_noncoherent)
+		info->flags |= FBINFO_READS_FAST; /* signal caching */
+	info->screen_size = sizes->surface_height * fb->pitches[0];
+	info->screen_buffer = map.vaddr;
+	if (!(info->flags & FBINFO_HIDE_SMEM_START)) {
+		if (!drm_WARN_ON(dev, is_vmalloc_addr(info->screen_buffer)))
+			info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
+	}
+	info->fix.smem_len = info->screen_size;
+
+	return 0;
+}
+
+static int drm_fbdev_dma_driver_fbdev_probe_tail_shadowed(struct drm_fb_helper *fb_helper,
+							  struct drm_fb_helper_surface_size *sizes)
+{
+	struct drm_client_buffer *buffer = fb_helper->buffer;
+	struct fb_info *info = fb_helper->info;
+	size_t screen_size = buffer->gem->size;
+	void *screen_buffer;
+	int ret;
+
+	/*
+	 * Deferred I/O requires struct page for framebuffer memory,
+	 * which is not guaranteed for all DMA ranges. We thus create
+	 * a shadow buffer in system memory.
+	 */
+	screen_buffer = vzalloc(screen_size);
+	if (!screen_buffer)
+		return -ENOMEM;
+
+	info->fbops = &drm_fbdev_dma_shadowed_fb_ops;
+
+	/* screen */
+	info->flags |= FBINFO_VIRTFB; /* system memory */
+	info->flags |= FBINFO_READS_FAST; /* signal caching */
+	info->screen_buffer = screen_buffer;
+	info->fix.smem_len = screen_size;
+
+	fb_helper->fbdefio.delay = HZ / 20;
+	fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
+
+	info->fbdefio = &fb_helper->fbdefio;
+	ret = fb_deferred_io_init(info);
+	if (ret)
+		goto err_vfree;
+
+	return 0;
+
+err_vfree:
+	vfree(screen_buffer);
+	return ret;
+}
+
 int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 				     struct drm_fb_helper_surface_size *sizes)
 {
 	struct drm_client_dev *client = &fb_helper->client;
 	struct drm_device *dev = fb_helper->dev;
-	bool use_deferred_io = false;
 	struct drm_client_buffer *buffer;
-	struct drm_gem_dma_object *dma_obj;
 	struct drm_framebuffer *fb;
 	struct fb_info *info;
 	u32 format;
@@ -161,19 +297,9 @@ int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 					       sizes->surface_height, format);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
-	dma_obj = to_drm_gem_dma_obj(buffer->gem);
 
 	fb = buffer->fb;
 
-	/*
-	 * Deferred I/O requires struct page for framebuffer memory,
-	 * which is not guaranteed for all DMA ranges. We thus only
-	 * install deferred I/O if we have a framebuffer that requires
-	 * it.
-	 */
-	if (fb->funcs->dirty)
-		use_deferred_io = true;
-
 	ret = drm_client_buffer_vmap(buffer, &map);
 	if (ret) {
 		goto err_drm_client_buffer_delete;
@@ -194,45 +320,12 @@ int drm_fbdev_dma_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 
 	drm_fb_helper_fill_info(info, fb_helper, sizes);
 
-	if (use_deferred_io)
-		info->fbops = &drm_fbdev_dma_deferred_fb_ops;
+	if (fb->funcs->dirty)
+		ret = drm_fbdev_dma_driver_fbdev_probe_tail_shadowed(fb_helper, sizes);
 	else
-		info->fbops = &drm_fbdev_dma_fb_ops;
-
-	/* screen */
-	info->flags |= FBINFO_VIRTFB; /* system memory */
-	if (dma_obj->map_noncoherent)
-		info->flags |= FBINFO_READS_FAST; /* signal caching */
-	info->screen_size = sizes->surface_height * fb->pitches[0];
-	info->screen_buffer = map.vaddr;
-	if (!(info->flags & FBINFO_HIDE_SMEM_START)) {
-		if (!drm_WARN_ON(dev, is_vmalloc_addr(info->screen_buffer)))
-			info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
-	}
-	info->fix.smem_len = info->screen_size;
-
-	/*
-	 * Only set up deferred I/O if the screen buffer supports
-	 * it. If this disagrees with the previous test for ->dirty,
-	 * mmap on the /dev/fb file might not work correctly.
-	 */
-	if (!is_vmalloc_addr(info->screen_buffer) && info->fix.smem_start) {
-		unsigned long pfn = info->fix.smem_start >> PAGE_SHIFT;
-
-		if (drm_WARN_ON(dev, !pfn_to_page(pfn)))
-			use_deferred_io = false;
-	}
-
-	/* deferred I/O */
-	if (use_deferred_io) {
-		fb_helper->fbdefio.delay = HZ / 20;
-		fb_helper->fbdefio.deferred_io = drm_fb_helper_deferred_io;
-
-		info->fbdefio = &fb_helper->fbdefio;
-		ret = fb_deferred_io_init(info);
-		if (ret)
-			goto err_drm_fb_helper_release_info;
-	}
+		ret = drm_fbdev_dma_driver_fbdev_probe_tail(fb_helper, sizes);
+	if (ret)
+		goto err_drm_fb_helper_release_info;
 
 	return 0;
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index ab9ca4824b62..e60288af3502 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
@@ -34,6 +34,7 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 							  *sched_job)
 {
 	struct etnaviv_gem_submit *submit = to_etnaviv_submit(sched_job);
+	struct drm_gpu_scheduler *sched = sched_job->sched;
 	struct etnaviv_gpu *gpu = submit->gpu;
 	u32 dma_addr;
 	int change;
@@ -76,7 +77,9 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 
 out_no_timeout:
-	list_add(&sched_job->list, &sched_job->sched->pending_list);
+	spin_lock(&sched->job_list_lock);
+	list_add(&sched_job->list, &sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index d21f3fb39706..3c7789ca6207 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1059,7 +1059,7 @@ static void bxt_dsi_get_pipe_config(struct intel_encoder *encoder,
 				              BXT_MIPI_TRANS_VACTIVE(port));
 	adjusted_mode->crtc_vtotal =
 				intel_de_read(display,
-				              BXT_MIPI_TRANS_VTOTAL(port));
+				              BXT_MIPI_TRANS_VTOTAL(port)) + 1;
 
 	hactive = adjusted_mode->crtc_hdisplay;
 	hfp = intel_de_read(display, MIPI_HFP_COUNT(display, port));
@@ -1264,7 +1264,7 @@ static void set_dsi_timings(struct intel_encoder *encoder,
 			intel_de_write(display, BXT_MIPI_TRANS_VACTIVE(port),
 				       adjusted_mode->crtc_vdisplay);
 			intel_de_write(display, BXT_MIPI_TRANS_VTOTAL(port),
-				       adjusted_mode->crtc_vtotal);
+				       adjusted_mode->crtc_vtotal - 1);
 		}
 
 		intel_de_write(display, MIPI_HACTIVE_AREA_COUNT(display, port),
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index c43223916a1b..5cc302ad13e1 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -111,7 +111,7 @@ static unsigned int config_bit(const u64 config)
 		return other_bit(config);
 }
 
-static u32 config_mask(const u64 config)
+static __always_inline u32 config_mask(const u64 config)
 {
 	unsigned int bit = config_bit(config);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e1228fb093ee..a5c1534eafdb 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -928,16 +928,17 @@ enum drm_mode_status dp_bridge_mode_valid(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (mode->clock > DP_MAX_PIXEL_CLK_KHZ)
-		return MODE_CLOCK_HIGH;
-
 	dp_display = container_of(dp, struct dp_display_private, dp_display);
 	link_info = &dp_display->panel->link_info;
 
-	if (drm_mode_is_420_only(&dp->connector->display_info, mode) &&
-	    dp_display->panel->vsc_sdp_supported)
+	if ((drm_mode_is_420_only(&dp->connector->display_info, mode) &&
+	     dp_display->panel->vsc_sdp_supported) ||
+	     msm_dp_wide_bus_available(dp))
 		mode_pclk_khz /= 2;
 
+	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)
+		return MODE_CLOCK_HIGH;
+
 	mode_bpp = dp->connector->display_info.bpc * num_components;
 	if (!mode_bpp)
 		mode_bpp = default_bpp;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 1b9be5bd97f1..da0176eae3fe 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -257,7 +257,10 @@ static enum drm_mode_status edp_bridge_mode_valid(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (mode->clock > DP_MAX_PIXEL_CLK_KHZ)
+	if (msm_dp_wide_bus_available(dp))
+		mode_pclk_khz /= 2;
+
+	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)
 		return MODE_CLOCK_HIGH;
 
 	/*
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 6970b0f7f457..2e1d5c343272 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -156,6 +156,7 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 	priv->gpu_devfreq_config.downdifferential = 10;
 
 	mutex_init(&df->lock);
+	df->suspended = true;
 
 	ret = dev_pm_qos_add_request(&gpu->pdev->dev, &df->boost_freq,
 				     DEV_PM_QOS_MIN_FREQUENCY, 0);
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 002057be0d84..c9c50e3b18a2 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -189,6 +189,7 @@ static void drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
 {
 	struct drm_sched_job *job = container_of(wrk, typeof(*job), work);
 
+	drm_sched_fence_scheduled(job->s_fence, NULL);
 	drm_sched_fence_finished(job->s_fence, -ESRCH);
 	WARN_ON(job->s_fence->parent);
 	job->sched->ops->free_job(job);
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index be61c9d1a4f0..51ca78551b57 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1320,10 +1320,16 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
 		if (wgrp->dc == dc->pipe) {
 			for (j = 0; j < wgrp->num_windows; j++) {
 				unsigned int index = wgrp->windows[j];
+				enum drm_plane_type type;
+
+				if (primary)
+					type = DRM_PLANE_TYPE_OVERLAY;
+				else
+					type = DRM_PLANE_TYPE_PRIMARY;
 
 				plane = tegra_shared_plane_create(drm, dc,
 								  wgrp->index,
-								  index);
+								  index, type);
 				if (IS_ERR(plane))
 					return plane;
 
@@ -1331,10 +1337,8 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
 				 * Choose the first shared plane owned by this
 				 * head as the primary plane.
 				 */
-				if (!primary) {
-					plane->type = DRM_PLANE_TYPE_PRIMARY;
+				if (!primary)
 					primary = plane;
-				}
 			}
 		}
 	}
@@ -1388,7 +1392,10 @@ static void tegra_crtc_reset(struct drm_crtc *crtc)
 	if (crtc->state)
 		tegra_crtc_atomic_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (state)
+		__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 static struct drm_crtc_state *
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index e0c2019a591b..3507dd6e9023 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -755,9 +755,9 @@ static const struct drm_plane_helper_funcs tegra_shared_plane_helper_funcs = {
 struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    struct tegra_dc *dc,
 					    unsigned int wgrp,
-					    unsigned int index)
+					    unsigned int index,
+					    enum drm_plane_type type)
 {
-	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
 	struct tegra_drm *tegra = drm->dev_private;
 	struct tegra_display_hub *hub = tegra->hub;
 	struct tegra_shared_plane *plane;
diff --git a/drivers/gpu/drm/tegra/hub.h b/drivers/gpu/drm/tegra/hub.h
index 23c4b2115ed1..a66f18c4facc 100644
--- a/drivers/gpu/drm/tegra/hub.h
+++ b/drivers/gpu/drm/tegra/hub.h
@@ -80,7 +80,8 @@ void tegra_display_hub_cleanup(struct tegra_display_hub *hub);
 struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
 					    struct tegra_dc *dc,
 					    unsigned int wgrp,
-					    unsigned int index);
+					    unsigned int index,
+					    enum drm_plane_type type);
 
 int tegra_display_hub_atomic_check(struct drm_device *drm,
 				   struct drm_atomic_state *state);
diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 751326e3d9c3..c7e81f2610f8 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -318,7 +318,6 @@ static void cirrus_pitch_set(struct cirrus_device *cirrus, unsigned int pitch)
 	/* Enable extended blanking and pitch bits, and enable full memory */
 	cr1b = 0x22;
 	cr1b |= (pitch >> 7) & 0x10;
-	cr1b |= (pitch >> 6) & 0x40;
 	wreg_crt(cirrus, 0x1b, cr1b);
 
 	cirrus_set_start_address(cirrus, 0);
diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 280a09a6e2ad..0f712eb685ba 100644
--- a/drivers/gpu/drm/udl/udl_drv.c
+++ b/drivers/gpu/drm/udl/udl_drv.c
@@ -126,9 +126,9 @@ static void udl_usb_disconnect(struct usb_interface *interface)
 {
 	struct drm_device *dev = usb_get_intfdata(interface);
 
+	drm_dev_unplug(dev);
 	drm_kms_helper_poll_fini(dev);
 	udl_drop_usb(dev);
-	drm_dev_unplug(dev);
 }
 
 /*
diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index a1928cedc7dd..e164e2d71e11 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -96,6 +96,8 @@ int xe_display_create(struct xe_device *xe)
 	spin_lock_init(&xe->display.fb_tracking.lock);
 
 	xe->display.hotplug.dp_wq = alloc_ordered_workqueue("xe-dp", 0);
+	if (!xe->display.hotplug.dp_wq)
+		return -ENOMEM;
 
 	return drmm_add_action_or_reset(&xe->drm, display_destroy, NULL);
 }
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index ff19eca5d358..e9820126feb9 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -198,6 +198,13 @@ static const struct xe_ggtt_pt_ops xelpg_pt_wa_ops = {
 	.ggtt_set_pte = xe_ggtt_set_pte_and_flush,
 };
 
+static void dev_fini_ggtt(void *arg)
+{
+	struct xe_ggtt *ggtt = arg;
+
+	drain_workqueue(ggtt->wq);
+}
+
 /**
  * xe_ggtt_init_early - Early GGTT initialization
  * @ggtt: the &xe_ggtt to be initialized
@@ -254,6 +261,10 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	if (err)
 		return err;
 
+	err = devm_add_action_or_reset(xe->drm.dev, dev_fini_ggtt, ggtt);
+	if (err)
+		return err;
+
 	if (IS_SRIOV_VF(xe)) {
 		err = xe_gt_sriov_vf_prepare_ggtt(xe_tile_get_gt(ggtt->tile, 0));
 		if (err)
diff --git a/drivers/gpu/drm/xe/xe_gpu_scheduler.h b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
index 64b2ae6839db..400b2e9e89ab 100644
--- a/drivers/gpu/drm/xe/xe_gpu_scheduler.h
+++ b/drivers/gpu/drm/xe/xe_gpu_scheduler.h
@@ -51,7 +51,15 @@ static inline void xe_sched_tdr_queue_imm(struct xe_gpu_scheduler *sched)
 
 static inline void xe_sched_resubmit_jobs(struct xe_gpu_scheduler *sched)
 {
-	drm_sched_resubmit_jobs(&sched->base);
+	struct drm_sched_job *s_job;
+
+	list_for_each_entry(s_job, &sched->base.pending_list, list) {
+		struct drm_sched_fence *s_fence = s_job->s_fence;
+		struct dma_fence *hw_fence = s_fence->parent;
+
+		if (hw_fence && !dma_fence_is_signaled(hw_fence))
+			sched->base.ops->run_job(s_job);
+	}
 }
 
 static inline bool
diff --git a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
index 3155825fa46a..9deb9b44c3c3 100644
--- a/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
+++ b/drivers/gpu/drm/xe/xe_gt_tlb_invalidation.c
@@ -137,6 +137,14 @@ void xe_gt_tlb_invalidation_reset(struct xe_gt *gt)
 	struct xe_gt_tlb_invalidation_fence *fence, *next;
 	int pending_seqno;
 
+	/*
+	 * we can get here before the CTs are even initialized if we're wedging
+	 * very early, in which case there are not going to be any pending
+	 * fences so we can bail immediately.
+	 */
+	if (!xe_guc_ct_initialized(&gt->uc.guc.ct))
+		return;
+
 	/*
 	 * CT channel is already disabled at this point. No new TLB requests can
 	 * appear.
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index cd6a5f09d631..1f74f6bd50f3 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -454,6 +454,9 @@ void xe_guc_ct_disable(struct xe_guc_ct *ct)
  */
 void xe_guc_ct_stop(struct xe_guc_ct *ct)
 {
+	if (!xe_guc_ct_initialized(ct))
+		return;
+
 	xe_guc_ct_set_state(ct, XE_GUC_CT_STATE_STOPPED);
 	stop_g2h_handler(ct);
 }
@@ -638,7 +641,7 @@ static int __guc_ct_send_locked(struct xe_guc_ct *ct, const u32 *action,
 	u16 seqno;
 	int ret;
 
-	xe_gt_assert(gt, ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED);
+	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
 	xe_gt_assert(gt, !g2h_len || !g2h_fence);
 	xe_gt_assert(gt, !num_g2h || !g2h_fence);
 	xe_gt_assert(gt, !g2h_len || num_g2h);
@@ -1209,7 +1212,7 @@ static int g2h_read(struct xe_guc_ct *ct, u32 *msg, bool fast_path)
 	u32 action;
 	u32 *hxg;
 
-	xe_gt_assert(gt, ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED);
+	xe_gt_assert(gt, xe_guc_ct_initialized(ct));
 	lockdep_assert_held(&ct->fast_lock);
 
 	if (ct->state == XE_GUC_CT_STATE_DISABLED)
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
index 190202fce2d0..13e316668e90 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.h
+++ b/drivers/gpu/drm/xe/xe_guc_ct.h
@@ -23,6 +23,11 @@ void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
 void xe_guc_ct_snapshot_free(struct xe_guc_ct_snapshot *snapshot);
 void xe_guc_ct_print(struct xe_guc_ct *ct, struct drm_printer *p, bool atomic);
 
+static inline bool xe_guc_ct_initialized(struct xe_guc_ct *ct)
+{
+	return ct->state != XE_GUC_CT_STATE_NOT_INITIALIZED;
+}
+
 static inline bool xe_guc_ct_enabled(struct xe_guc_ct *ct)
 {
 	return ct->state == XE_GUC_CT_STATE_ENABLED;
diff --git a/drivers/gpu/drm/xe/xe_guc_pc.c b/drivers/gpu/drm/xe/xe_guc_pc.c
index 034b29984d5e..f978da8be35c 100644
--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -975,7 +975,7 @@ int xe_guc_pc_start(struct xe_guc_pc *pc)
 		goto out;
 	}
 
-	memset(pc->bo->vmap.vaddr, 0, size);
+	xe_map_memset(xe, &pc->bo->vmap, 0, 0, size);
 	slpc_shared_data_write(pc, header.size, size);
 
 	ret = pc_action_reset(pc);
diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 20d05efdd406..0e17820a35e2 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -227,6 +227,17 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 static void guc_submit_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
+	struct xe_device *xe = guc_to_xe(guc);
+	struct xe_gt *gt = guc_to_gt(guc);
+	int ret;
+
+	ret = wait_event_timeout(guc->submission_state.fini_wq,
+				 xa_empty(&guc->submission_state.exec_queue_lookup),
+				 HZ * 5);
+
+	drain_workqueue(xe->destroy_wq);
+
+	xe_gt_assert(gt, ret);
 
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
 }
@@ -298,6 +309,8 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
 
 	primelockdep(guc);
 
+	guc->submission_state.initialized = true;
+
 	return drmm_add_action_or_reset(&xe->drm, guc_submit_fini, guc);
 }
 
@@ -826,6 +839,13 @@ void xe_guc_submit_wedge(struct xe_guc *guc)
 
 	xe_gt_assert(guc_to_gt(guc), guc_to_xe(guc)->wedged.mode);
 
+	/*
+	 * If device is being wedged even before submission_state is
+	 * initialized, there's nothing to do here.
+	 */
+	if (!guc->submission_state.initialized)
+		return;
+
 	err = devm_add_action_or_reset(guc_to_xe(guc)->drm.dev,
 				       guc_submit_wedged_fini, guc);
 	if (err) {
@@ -1702,6 +1722,9 @@ int xe_guc_submit_reset_prepare(struct xe_guc *guc)
 {
 	int ret;
 
+	if (!guc->submission_state.initialized)
+		return 0;
+
 	/*
 	 * Using an atomic here rather than submission_state.lock as this
 	 * function can be called while holding the CT lock (engine reset
diff --git a/drivers/gpu/drm/xe/xe_guc_types.h b/drivers/gpu/drm/xe/xe_guc_types.h
index ed150fc09ad0..7842b71e68be 100644
--- a/drivers/gpu/drm/xe/xe_guc_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_types.h
@@ -74,6 +74,11 @@ struct xe_guc {
 		struct mutex lock;
 		/** @submission_state.enabled: submission is enabled */
 		bool enabled;
+		/**
+		 * @submission_state.initialized: mark when submission state is
+		 * even initialized - before that not even the lock is valid
+		 */
+		bool initialized;
 		/** @submission_state.fini_wq: submit fini wait queue */
 		wait_queue_head_t fini_wq;
 	} submission_state;
diff --git a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
index ef84fa757b26..34e38bb167ba 100644
--- a/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_stolen_mgr.c
@@ -57,12 +57,35 @@ bool xe_ttm_stolen_cpu_access_needs_ggtt(struct xe_device *xe)
 	return GRAPHICS_VERx100(xe) < 1270 && !IS_DGFX(xe);
 }
 
+static u32 get_wopcm_size(struct xe_device *xe)
+{
+	u32 wopcm_size;
+	u64 val;
+
+	val = xe_mmio_read64_2x32(xe_root_mmio_gt(xe), STOLEN_RESERVED);
+	val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
+
+	switch (val) {
+	case 0x5 ... 0x6:
+		val--;
+		fallthrough;
+	case 0x0 ... 0x3:
+		wopcm_size = (1U << val) * SZ_1M;
+		break;
+	default:
+		WARN(1, "Missing case wopcm_size=%llx\n", val);
+		wopcm_size = 0;
+	}
+
+	return wopcm_size;
+}
+
 static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 {
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_gt *mmio = xe_root_mmio_gt(xe);
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
-	u64 stolen_size;
+	u64 stolen_size, wopcm_size;
 	u64 tile_offset;
 	u64 tile_size;
 
@@ -74,7 +97,13 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 	if (drm_WARN_ON(&xe->drm, tile_size < mgr->stolen_base))
 		return 0;
 
+	/* Carve out the top of DSM as it contains the reserved WOPCM region */
+	wopcm_size = get_wopcm_size(xe);
+	if (drm_WARN_ON(&xe->drm, !wopcm_size))
+		return 0;
+
 	stolen_size = tile_size - mgr->stolen_base;
+	stolen_size -= wopcm_size;
 
 	/* Verify usage fits in the actual resource available */
 	if (mgr->stolen_base + stolen_size <= pci_resource_len(pdev, LMEM_BAR))
@@ -89,29 +118,6 @@ static s64 detect_bar2_dgfx(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 	return ALIGN_DOWN(stolen_size, SZ_1M);
 }
 
-static u32 get_wopcm_size(struct xe_device *xe)
-{
-	u32 wopcm_size;
-	u64 val;
-
-	val = xe_mmio_read64_2x32(xe_root_mmio_gt(xe), STOLEN_RESERVED);
-	val = REG_FIELD_GET64(WOPCM_SIZE_MASK, val);
-
-	switch (val) {
-	case 0x5 ... 0x6:
-		val--;
-		fallthrough;
-	case 0x0 ... 0x3:
-		wopcm_size = (1U << val) * SZ_1M;
-		break;
-	default:
-		WARN(1, "Missing case wopcm_size=%llx\n", val);
-		wopcm_size = 0;
-	}
-
-	return wopcm_size;
-}
-
 static u32 detect_bar2_integrated(struct xe_device *xe, struct xe_ttm_stolen_mgr *mgr)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index de257a032225..15fd497c920c 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1477,8 +1477,10 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags)
 	 * scheduler drops all the references of it, hence protecting the VM
 	 * for this case is necessary.
 	 */
-	if (flags & XE_VM_FLAG_LR_MODE)
+	if (flags & XE_VM_FLAG_LR_MODE) {
+		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
 		xe_pm_runtime_get_noresume(xe);
+	}
 
 	vm_resv_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
 	if (!vm_resv_obj) {
@@ -1523,10 +1525,8 @@ struct xe_vm *xe_vm_create(struct xe_device *xe, u32 flags)
 		vm->batch_invalidate_tlb = true;
 	}
 
-	if (vm->flags & XE_VM_FLAG_LR_MODE) {
-		INIT_WORK(&vm->preempt.rebind_work, preempt_rebind_work_func);
+	if (vm->flags & XE_VM_FLAG_LR_MODE)
 		vm->batch_invalidate_tlb = false;
-	}
 
 	/* Fill pt_root after allocating scratch tables */
 	for_each_tile(tile, xe, id) {
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index f66194fde891..56e530860cae 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -529,11 +529,14 @@ static void lenovo_features_set_cptkbd(struct hid_device *hdev)
 
 	/*
 	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
-	 * regular keys
+	 * regular keys (Compact only)
 	 */
-	ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
-	if (ret)
-		hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
+	if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD ||
+	    hdev->product == USB_DEVICE_ID_LENOVO_CBTKBD) {
+		ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
+		if (ret)
+			hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
+	}
 
 	/* Switch middle button to native mode */
 	ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 34428349fa31..1b1112772777 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2021,14 +2021,18 @@ static int wacom_initialize_remotes(struct wacom *wacom)
 
 	remote->remote_dir = kobject_create_and_add("wacom_remote",
 						    &wacom->hdev->dev.kobj);
-	if (!remote->remote_dir)
+	if (!remote->remote_dir) {
+		kfifo_free(&remote->remote_fifo);
 		return -ENOMEM;
+	}
 
 	error = sysfs_create_files(remote->remote_dir, remote_unpair_attrs);
 
 	if (error) {
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
+		kfifo_free(&remote->remote_fifo);
+		kobject_put(remote->remote_dir);
 		return error;
 	}
 
@@ -2874,6 +2878,7 @@ static void wacom_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 
 	cancel_delayed_work_sync(&wacom->init_work);
+	cancel_delayed_work_sync(&wacom->aes_battery_work);
 	cancel_work_sync(&wacom->wireless_work);
 	cancel_work_sync(&wacom->battery_work);
 	cancel_work_sync(&wacom->remote_work);
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index fe7f6b1b0985..e14be8ebaad3 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -34,16 +34,21 @@ enum chips { max34440, max34441, max34446, max34451, max34460, max34461 };
 /*
  * The whole max344* family have IOUT_OC_WARN_LIMIT and IOUT_OC_FAULT_LIMIT
  * swapped from the standard pmbus spec addresses.
+ * For max34451, version MAX34451ETNA6+ and later has this issue fixed.
  */
 #define MAX34440_IOUT_OC_WARN_LIMIT	0x46
 #define MAX34440_IOUT_OC_FAULT_LIMIT	0x4A
 
+#define MAX34451ETNA6_MFR_REV		0x0012
+
 #define MAX34451_MFR_CHANNEL_CONFIG	0xe4
 #define MAX34451_MFR_CHANNEL_CONFIG_SEL_MASK	0x3f
 
 struct max34440_data {
 	int id;
 	struct pmbus_driver_info info;
+	u8 iout_oc_warn_limit;
+	u8 iout_oc_fault_limit;
 };
 
 #define to_max34440_data(x)  container_of(x, struct max34440_data, info)
@@ -60,11 +65,11 @@ static int max34440_read_word_data(struct i2c_client *client, int page,
 	switch (reg) {
 	case PMBUS_IOUT_OC_FAULT_LIMIT:
 		ret = pmbus_read_word_data(client, page, phase,
-					   MAX34440_IOUT_OC_FAULT_LIMIT);
+					   data->iout_oc_fault_limit);
 		break;
 	case PMBUS_IOUT_OC_WARN_LIMIT:
 		ret = pmbus_read_word_data(client, page, phase,
-					   MAX34440_IOUT_OC_WARN_LIMIT);
+					   data->iout_oc_warn_limit);
 		break;
 	case PMBUS_VIRT_READ_VOUT_MIN:
 		ret = pmbus_read_word_data(client, page, phase,
@@ -133,11 +138,11 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
 
 	switch (reg) {
 	case PMBUS_IOUT_OC_FAULT_LIMIT:
-		ret = pmbus_write_word_data(client, page, MAX34440_IOUT_OC_FAULT_LIMIT,
+		ret = pmbus_write_word_data(client, page, data->iout_oc_fault_limit,
 					    word);
 		break;
 	case PMBUS_IOUT_OC_WARN_LIMIT:
-		ret = pmbus_write_word_data(client, page, MAX34440_IOUT_OC_WARN_LIMIT,
+		ret = pmbus_write_word_data(client, page, data->iout_oc_warn_limit,
 					    word);
 		break;
 	case PMBUS_VIRT_RESET_POUT_HISTORY:
@@ -235,6 +240,25 @@ static int max34451_set_supported_funcs(struct i2c_client *client,
 	 */
 
 	int page, rv;
+	bool max34451_na6 = false;
+
+	rv = i2c_smbus_read_word_data(client, PMBUS_MFR_REVISION);
+	if (rv < 0)
+		return rv;
+
+	if (rv >= MAX34451ETNA6_MFR_REV) {
+		max34451_na6 = true;
+		data->info.format[PSC_VOLTAGE_IN] = direct;
+		data->info.format[PSC_CURRENT_IN] = direct;
+		data->info.m[PSC_VOLTAGE_IN] = 1;
+		data->info.b[PSC_VOLTAGE_IN] = 0;
+		data->info.R[PSC_VOLTAGE_IN] = 3;
+		data->info.m[PSC_CURRENT_IN] = 1;
+		data->info.b[PSC_CURRENT_IN] = 0;
+		data->info.R[PSC_CURRENT_IN] = 2;
+		data->iout_oc_fault_limit = PMBUS_IOUT_OC_FAULT_LIMIT;
+		data->iout_oc_warn_limit = PMBUS_IOUT_OC_WARN_LIMIT;
+	}
 
 	for (page = 0; page < 16; page++) {
 		rv = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
@@ -251,16 +275,30 @@ static int max34451_set_supported_funcs(struct i2c_client *client,
 		case 0x20:
 			data->info.func[page] = PMBUS_HAVE_VOUT |
 				PMBUS_HAVE_STATUS_VOUT;
+
+			if (max34451_na6)
+				data->info.func[page] |= PMBUS_HAVE_VIN |
+					PMBUS_HAVE_STATUS_INPUT;
 			break;
 		case 0x21:
 			data->info.func[page] = PMBUS_HAVE_VOUT;
+
+			if (max34451_na6)
+				data->info.func[page] |= PMBUS_HAVE_VIN;
 			break;
 		case 0x22:
 			data->info.func[page] = PMBUS_HAVE_IOUT |
 				PMBUS_HAVE_STATUS_IOUT;
+
+			if (max34451_na6)
+				data->info.func[page] |= PMBUS_HAVE_IIN |
+					PMBUS_HAVE_STATUS_INPUT;
 			break;
 		case 0x23:
 			data->info.func[page] = PMBUS_HAVE_IOUT;
+
+			if (max34451_na6)
+				data->info.func[page] |= PMBUS_HAVE_IIN;
 			break;
 		default:
 			break;
@@ -494,6 +532,8 @@ static int max34440_probe(struct i2c_client *client)
 		return -ENOMEM;
 	data->id = i2c_match_id(max34440_id, client)->driver_data;
 	data->info = max34440_info[data->id];
+	data->iout_oc_fault_limit = MAX34440_IOUT_OC_FAULT_LIMIT;
+	data->iout_oc_warn_limit = MAX34440_IOUT_OC_WARN_LIMIT;
 
 	if (data->id == max34451) {
 		rv = max34451_set_supported_funcs(client, data);
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index c7e35a431ab0..b7941d8abbfe 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -97,7 +97,8 @@ coresight_find_out_connection(struct coresight_device *src_dev,
 
 static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
 {
-	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
+	return FIELD_GET(CORESIGHT_CLAIM_MASK,
+			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
 }
 
 static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 05f891ca6b5c..cc7ff1e36ef4 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -35,6 +35,7 @@ extern const struct device_type coresight_dev_type[];
  * Coresight device CLAIM protocol.
  * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
  */
+#define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
 #define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
 
 #define TIMEOUT_US		100
diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 80d45079b763..e0a76fb5bc31 100644
--- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
+++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
@@ -111,6 +111,11 @@ static u32 osif_func(struct i2c_adapter *adapter)
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
+/* prevent invalid 0-length usb_control_msg */
+static const struct i2c_adapter_quirks osif_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 static const struct i2c_algorithm osif_algorithm = {
 	.xfer = osif_xfer,
 	.functionality = osif_func,
@@ -143,6 +148,7 @@ static int osif_probe(struct usb_interface *interface,
 
 	priv->adapter.owner = THIS_MODULE;
 	priv->adapter.class = I2C_CLASS_HWMON;
+	priv->adapter.quirks = &osif_quirks;
 	priv->adapter.algo = &osif_algorithm;
 	priv->adapter.algo_data = priv;
 	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 0f2ed181b266..0cc7c0a816fc 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -138,6 +138,11 @@ static u32 usb_func(struct i2c_adapter *adapter)
 	return ret;
 }
 
+/* prevent invalid 0-length usb_control_msg */
+static const struct i2c_adapter_quirks usb_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 /* This is the actual algorithm we define */
 static const struct i2c_algorithm usb_algorithm = {
 	.xfer = usb_xfer,
@@ -246,6 +251,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	/* setup i2c adapter description */
 	dev->adapter.owner = THIS_MODULE;
 	dev->adapter.class = I2C_CLASS_HWMON;
+	dev->adapter.quirks = &usb_quirks;
 	dev->adapter.algo = &usb_algorithm;
 	dev->adapter.algo_data = dev;
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ea4aabd3960a..3df1d4f6bc95 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -477,6 +477,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		 * byte set to zero. */
 		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
 		break;
+
+	default:
+		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
+		goto irq_handled;
 	}
 
 	/*
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2cf148f16306..56a125f56284 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -4,7 +4,7 @@
 #
 
 # When adding new entries keep the list in alphabetical order
-obj-$(CONFIG_AD3552R) += ad3552r.o
+obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
 obj-$(CONFIG_AD5360) += ad5360.o
 obj-$(CONFIG_AD5380) += ad5380.o
 obj-$(CONFIG_AD5421) += ad5421.o
diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
new file mode 100644
index 000000000000..94869ad15c27
--- /dev/null
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (c) 2010-2024 Analog Devices Inc.
+// Copyright (c) 2024 Baylibre, SAS
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#include "ad3552r.h"
+
+const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2] = {
+	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
+	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
+	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
+	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
+	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= { -10000, 10000 }
+};
+EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, IIO_AD3552R);
+
+const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
+	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
+	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
+	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
+	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 }
+};
+EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, IIO_AD3552R);
+
+/* Gain * AD3552R_GAIN_SCALE */
+static const s32 gains_scaling_table[] = {
+	[AD3552R_CH_GAIN_SCALING_1]		= 1000,
+	[AD3552R_CH_GAIN_SCALING_0_5]		= 500,
+	[AD3552R_CH_GAIN_SCALING_0_25]		= 250,
+	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
+};
+
+u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
+{
+	return FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1) |
+	       FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p) |
+	       FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n) |
+	       FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs(goffs)) |
+	       FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, goffs < 0);
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_calc_custom_gain, IIO_AD3552R);
+
+static void ad3552r_get_custom_range(struct ad3552r_ch_data *ch_data,
+				     s32 *v_min, s32 *v_max)
+{
+	s64 vref, tmp, common, offset, gn, gp;
+	/*
+	 * From datasheet formula (In Volts):
+	 *	Vmin = 2.5 + [(GainN + Offset / 1024) * 2.5 * Rfb * 1.03]
+	 *	Vmax = 2.5 - [(GainP + Offset / 1024) * 2.5 * Rfb * 1.03]
+	 * Calculus are converted to milivolts
+	 */
+	vref = 2500;
+	/* 2.5 * 1.03 * 1000 (To mV) */
+	common = 2575 * ch_data->rfb;
+	offset = ch_data->gain_offset;
+
+	gn = gains_scaling_table[ch_data->n];
+	tmp = (1024 * gn + AD3552R_GAIN_SCALE * offset) * common;
+	tmp = div_s64(tmp, 1024  * AD3552R_GAIN_SCALE);
+	*v_max = vref + tmp;
+
+	gp = gains_scaling_table[ch_data->p];
+	tmp = (1024 * gp - AD3552R_GAIN_SCALE * offset) * common;
+	tmp = div_s64(tmp, 1024 * AD3552R_GAIN_SCALE);
+	*v_min = vref - tmp;
+}
+
+void ad3552r_calc_gain_and_offset(struct ad3552r_ch_data *ch_data,
+				  const struct ad3552r_model_data *model_data)
+{
+	s32 idx, v_max, v_min, span, rem;
+	s64 tmp;
+
+	if (ch_data->range_override) {
+		ad3552r_get_custom_range(ch_data, &v_min, &v_max);
+	} else {
+		/* Normal range */
+		idx = ch_data->range;
+		v_min = model_data->ranges_table[idx][0];
+		v_max = model_data->ranges_table[idx][1];
+	}
+
+	/*
+	 * From datasheet formula:
+	 *	Vout = Span * (D / 65536) + Vmin
+	 * Converted to scale and offset:
+	 *	Scale = Span / 65536
+	 *	Offset = 65536 * Vmin / Span
+	 *
+	 * Reminders are in micros in order to be printed as
+	 * IIO_VAL_INT_PLUS_MICRO
+	 */
+	span = v_max - v_min;
+	ch_data->scale_int = div_s64_rem(span, 65536, &rem);
+	/* Do operations in microvolts */
+	ch_data->scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000, 65536);
+
+	ch_data->offset_int = div_s64_rem(v_min * 65536, span, &rem);
+	tmp = (s64)rem * 1000000;
+	ch_data->offset_dec = div_s64(tmp, span);
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_calc_gain_and_offset, IIO_AD3552R);
+
+int ad3552r_get_ref_voltage(struct device *dev, u32 *val)
+{
+	int voltage;
+	int delta = 100000;
+
+	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (voltage < 0 && voltage != -ENODEV)
+		return dev_err_probe(dev, voltage,
+				     "Error getting vref voltage\n");
+
+	if (voltage == -ENODEV) {
+		if (device_property_read_bool(dev, "adi,vref-out-en"))
+			*val = AD3552R_INTERNAL_VREF_PIN_2P5V;
+		else
+			*val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
+
+		return 0;
+	}
+
+	if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
+		dev_warn(dev, "vref-supply must be 2.5V");
+		return -EINVAL;
+	}
+
+	*val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_ref_voltage, IIO_AD3552R);
+
+int ad3552r_get_drive_strength(struct device *dev, u32 *val)
+{
+	int err;
+	u32 drive_strength;
+
+	err = device_property_read_u32(dev, "adi,sdo-drive-strength",
+				       &drive_strength);
+	if (err)
+		return err;
+
+	if (drive_strength > 3) {
+		dev_err_probe(dev, -EINVAL,
+			      "adi,sdo-drive-strength must be less than 4\n");
+		return -EINVAL;
+	}
+
+	*val = drive_strength;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_drive_strength, IIO_AD3552R);
+
+int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
+			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs)
+{
+	int err;
+	u32 val;
+	struct fwnode_handle *gain_child __free(fwnode_handle) =
+		fwnode_get_named_child_node(child,
+					    "custom-output-range-config");
+
+	if (!gain_child)
+		return dev_err_probe(dev, -EINVAL,
+				     "custom-output-range-config mandatory\n");
+
+	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,gain-scaling-p mandatory\n");
+	*gs_p = val;
+
+	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,gain-scaling-n property mandatory\n");
+	*gs_n = val;
+
+	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,rfb-ohms mandatory\n");
+	*rfb = val;
+
+	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
+	if (err)
+		return dev_err_probe(dev, err,
+				     "adi,gain-offset mandatory\n");
+	*goffs = val;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_custom_gain, IIO_AD3552R);
+
+static int ad3552r_find_range(const struct ad3552r_model_data *model_info,
+			      s32 *vals)
+{
+	int i;
+
+	for (i = 0; i < model_info->num_ranges; i++)
+		if (vals[0] == model_info->ranges_table[i][0] * 1000 &&
+		    vals[1] == model_info->ranges_table[i][1] * 1000)
+			return i;
+
+	return -EINVAL;
+}
+
+int ad3552r_get_output_range(struct device *dev,
+			     const struct ad3552r_model_data *model_info,
+			     struct fwnode_handle *child, u32 *val)
+{
+	int ret;
+	s32 vals[2];
+
+	/* This property is optional, so returning -ENOENT if missing */
+	if (!fwnode_property_present(child, "adi,output-range-microvolt"))
+		return -ENOENT;
+
+	ret = fwnode_property_read_u32_array(child,
+					     "adi,output-range-microvolt",
+					     vals, 2);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"invalid adi,output-range-microvolt\n");
+
+	ret = ad3552r_find_range(model_info, vals);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+			"invalid adi,output-range-microvolt value\n");
+
+	*val = ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ad3552r_get_output_range, IIO_AD3552R);
+
+MODULE_DESCRIPTION("ad3552r common functions");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 390d3fab2147..5b2ce2aa67a4 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -6,271 +6,15 @@
  * Copyright 2021 Analog Devices Inc.
  */
 #include <linux/unaligned.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
-#include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
-/* Register addresses */
-/* Primary address space */
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_A		0x00
-#define   AD3552R_MASK_SOFTWARE_RESET			(BIT(7) | BIT(0))
-#define   AD3552R_MASK_ADDR_ASCENSION			BIT(5)
-#define   AD3552R_MASK_SDO_ACTIVE			BIT(4)
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_B		0x01
-#define   AD3552R_MASK_SINGLE_INST			BIT(7)
-#define   AD3552R_MASK_SHORT_INSTRUCTION		BIT(3)
-#define AD3552R_REG_ADDR_DEVICE_CONFIG			0x02
-#define   AD3552R_MASK_DEVICE_STATUS(n)			BIT(4 + (n))
-#define   AD3552R_MASK_CUSTOM_MODES			GENMASK(3, 2)
-#define   AD3552R_MASK_OPERATING_MODES			GENMASK(1, 0)
-#define AD3552R_REG_ADDR_CHIP_TYPE			0x03
-#define   AD3552R_MASK_CLASS				GENMASK(7, 0)
-#define AD3552R_REG_ADDR_PRODUCT_ID_L			0x04
-#define AD3552R_REG_ADDR_PRODUCT_ID_H			0x05
-#define AD3552R_REG_ADDR_CHIP_GRADE			0x06
-#define   AD3552R_MASK_GRADE				GENMASK(7, 4)
-#define   AD3552R_MASK_DEVICE_REVISION			GENMASK(3, 0)
-#define AD3552R_REG_ADDR_SCRATCH_PAD			0x0A
-#define AD3552R_REG_ADDR_SPI_REVISION			0x0B
-#define AD3552R_REG_ADDR_VENDOR_L			0x0C
-#define AD3552R_REG_ADDR_VENDOR_H			0x0D
-#define AD3552R_REG_ADDR_STREAM_MODE			0x0E
-#define   AD3552R_MASK_LENGTH				GENMASK(7, 0)
-#define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
-#define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7, 6)
-#define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
-#define   AD3552R_MASK_CRC_ENABLE			(GENMASK(7, 6) |\
-							 GENMASK(1, 0))
-#define   AD3552R_MASK_STRICT_REGISTER_ACCESS		BIT(5)
-#define AD3552R_REG_ADDR_INTERFACE_STATUS_A		0x11
-#define   AD3552R_MASK_INTERFACE_NOT_READY		BIT(7)
-#define   AD3552R_MASK_CLOCK_COUNTING_ERROR		BIT(5)
-#define   AD3552R_MASK_INVALID_OR_NO_CRC		BIT(3)
-#define   AD3552R_MASK_WRITE_TO_READ_ONLY_REGISTER	BIT(2)
-#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS		BIT(1)
-#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID		BIT(0)
-#define AD3552R_REG_ADDR_INTERFACE_CONFIG_D		0x14
-#define   AD3552R_MASK_ALERT_ENABLE_PULLUP		BIT(6)
-#define   AD3552R_MASK_MEM_CRC_EN			BIT(4)
-#define   AD3552R_MASK_SDO_DRIVE_STRENGTH		GENMASK(3, 2)
-#define   AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN		BIT(1)
-#define   AD3552R_MASK_SPI_CONFIG_DDR			BIT(0)
-#define AD3552R_REG_ADDR_SH_REFERENCE_CONFIG		0x15
-#define   AD3552R_MASK_IDUMP_FAST_MODE			BIT(6)
-#define   AD3552R_MASK_SAMPLE_HOLD_DIFFERENTIAL_USER_EN	BIT(5)
-#define   AD3552R_MASK_SAMPLE_HOLD_USER_TRIM		GENMASK(4, 3)
-#define   AD3552R_MASK_SAMPLE_HOLD_USER_ENABLE		BIT(2)
-#define   AD3552R_MASK_REFERENCE_VOLTAGE_SEL		GENMASK(1, 0)
-#define AD3552R_REG_ADDR_ERR_ALARM_MASK			0x16
-#define   AD3552R_MASK_REF_RANGE_ALARM			BIT(6)
-#define   AD3552R_MASK_CLOCK_COUNT_ERR_ALARM		BIT(5)
-#define   AD3552R_MASK_MEM_CRC_ERR_ALARM		BIT(4)
-#define   AD3552R_MASK_SPI_CRC_ERR_ALARM		BIT(3)
-#define   AD3552R_MASK_WRITE_TO_READ_ONLY_ALARM		BIT(2)
-#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS_ALARM	BIT(1)
-#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID_ALARM	BIT(0)
-#define AD3552R_REG_ADDR_ERR_STATUS			0x17
-#define   AD3552R_MASK_REF_RANGE_ERR_STATUS			BIT(6)
-#define   AD3552R_MASK_DUAL_SPI_STREAM_EXCEEDS_DAC_ERR_STATUS	BIT(5)
-#define   AD3552R_MASK_MEM_CRC_ERR_STATUS			BIT(4)
-#define   AD3552R_MASK_RESET_STATUS				BIT(0)
-#define AD3552R_REG_ADDR_POWERDOWN_CONFIG		0x18
-#define   AD3552R_MASK_CH_DAC_POWERDOWN(ch)		BIT(4 + (ch))
-#define   AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch)	BIT(ch)
-#define AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE		0x19
-#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch)		((ch) ? GENMASK(7, 4) :\
-							 GENMASK(3, 0))
-#define AD3552R_REG_ADDR_CH_OFFSET(ch)			(0x1B + (ch) * 2)
-#define   AD3552R_MASK_CH_OFFSET_BITS_0_7		GENMASK(7, 0)
-#define AD3552R_REG_ADDR_CH_GAIN(ch)			(0x1C + (ch) * 2)
-#define   AD3552R_MASK_CH_RANGE_OVERRIDE		BIT(7)
-#define   AD3552R_MASK_CH_GAIN_SCALING_N		GENMASK(6, 5)
-#define   AD3552R_MASK_CH_GAIN_SCALING_P		GENMASK(4, 3)
-#define   AD3552R_MASK_CH_OFFSET_POLARITY		BIT(2)
-#define   AD3552R_MASK_CH_OFFSET_BIT_8			BIT(0)
-/*
- * Secondary region
- * For multibyte registers specify the highest address because the access is
- * done in descending order
- */
-#define AD3552R_SECONDARY_REGION_START			0x28
-#define AD3552R_REG_ADDR_HW_LDAC_16B			0x28
-#define AD3552R_REG_ADDR_CH_DAC_16B(ch)			(0x2C - (1 - ch) * 2)
-#define AD3552R_REG_ADDR_DAC_PAGE_MASK_16B		0x2E
-#define AD3552R_REG_ADDR_CH_SELECT_16B			0x2F
-#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_16B		0x31
-#define AD3552R_REG_ADDR_SW_LDAC_16B			0x32
-#define AD3552R_REG_ADDR_CH_INPUT_16B(ch)		(0x36 - (1 - ch) * 2)
-/* 3 bytes registers */
-#define AD3552R_REG_START_24B				0x37
-#define AD3552R_REG_ADDR_HW_LDAC_24B			0x37
-#define AD3552R_REG_ADDR_CH_DAC_24B(ch)			(0x3D - (1 - ch) * 3)
-#define AD3552R_REG_ADDR_DAC_PAGE_MASK_24B		0x40
-#define AD3552R_REG_ADDR_CH_SELECT_24B			0x41
-#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B		0x44
-#define AD3552R_REG_ADDR_SW_LDAC_24B			0x45
-#define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 - ch) * 3)
-
-/* Useful defines */
-#define AD3552R_MAX_CH					2
-#define AD3552R_MASK_CH(ch)				BIT(ch)
-#define AD3552R_MASK_ALL_CH				GENMASK(1, 0)
-#define AD3552R_MAX_REG_SIZE				3
-#define AD3552R_READ_BIT				BIT(7)
-#define AD3552R_ADDR_MASK				GENMASK(6, 0)
-#define AD3552R_MASK_DAC_12B				0xFFF0
-#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
-#define AD3552R_SCRATCH_PAD_TEST_VAL1			0x34
-#define AD3552R_SCRATCH_PAD_TEST_VAL2			0xB2
-#define AD3552R_GAIN_SCALE				1000
-#define AD3552R_LDAC_PULSE_US				100
-
-enum ad3552r_ch_vref_select {
-	/* Internal source with Vref I/O floating */
-	AD3552R_INTERNAL_VREF_PIN_FLOATING,
-	/* Internal source with Vref I/O at 2.5V */
-	AD3552R_INTERNAL_VREF_PIN_2P5V,
-	/* External source with Vref I/O as input */
-	AD3552R_EXTERNAL_VREF_PIN_INPUT
-};
-
-enum ad3552r_id {
-	AD3541R_ID = 0x400b,
-	AD3542R_ID = 0x4009,
-	AD3551R_ID = 0x400a,
-	AD3552R_ID = 0x4008,
-};
-
-enum ad3552r_ch_output_range {
-	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
-	AD3552R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
-	AD3552R_CH_OUTPUT_RANGE_0__5V,
-	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
-	AD3552R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
-	AD3552R_CH_OUTPUT_RANGE_NEG_5__5V,
-	/* Range from -10 V to 10 V. Requires Rfb4x connection  */
-	AD3552R_CH_OUTPUT_RANGE_NEG_10__10V,
-};
-
-static const s32 ad3552r_ch_ranges[][2] = {
-	[AD3552R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
-	[AD3552R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
-	[AD3552R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
-	[AD3552R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000},
-	[AD3552R_CH_OUTPUT_RANGE_NEG_10__10V]	= {-10000, 10000}
-};
-
-enum ad3542r_ch_output_range {
-	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
-	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
-	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__3V,
-	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__5V,
-	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_0__10V,
-	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
-	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
-	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
-};
-
-static const s32 ad3542r_ch_ranges[][2] = {
-	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= {0, 2500},
-	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= {0, 3000},
-	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= {0, 5000},
-	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= {0, 10000},
-	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= {-2500, 7500},
-	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= {-5000, 5000}
-};
-
-enum ad3552r_ch_gain_scaling {
-	/* Gain scaling of 1 */
-	AD3552R_CH_GAIN_SCALING_1,
-	/* Gain scaling of 0.5 */
-	AD3552R_CH_GAIN_SCALING_0_5,
-	/* Gain scaling of 0.25 */
-	AD3552R_CH_GAIN_SCALING_0_25,
-	/* Gain scaling of 0.125 */
-	AD3552R_CH_GAIN_SCALING_0_125,
-};
-
-/* Gain * AD3552R_GAIN_SCALE */
-static const s32 gains_scaling_table[] = {
-	[AD3552R_CH_GAIN_SCALING_1]		= 1000,
-	[AD3552R_CH_GAIN_SCALING_0_5]		= 500,
-	[AD3552R_CH_GAIN_SCALING_0_25]		= 250,
-	[AD3552R_CH_GAIN_SCALING_0_125]		= 125
-};
-
-enum ad3552r_dev_attributes {
-	/* - Direct register values */
-	/* From 0-3 */
-	AD3552R_SDO_DRIVE_STRENGTH,
-	/*
-	 * 0 -> Internal Vref, vref_io pin floating (default)
-	 * 1 -> Internal Vref, vref_io driven by internal vref
-	 * 2 or 3 -> External Vref
-	 */
-	AD3552R_VREF_SELECT,
-	/* Read registers in ascending order if set. Else descending */
-	AD3552R_ADDR_ASCENSION,
-};
-
-enum ad3552r_ch_attributes {
-	/* DAC powerdown */
-	AD3552R_CH_DAC_POWERDOWN,
-	/* DAC amplifier powerdown */
-	AD3552R_CH_AMPLIFIER_POWERDOWN,
-	/* Select the output range. Select from enum ad3552r_ch_output_range */
-	AD3552R_CH_OUTPUT_RANGE_SEL,
-	/*
-	 * Over-rider the range selector in order to manually set the output
-	 * voltage range
-	 */
-	AD3552R_CH_RANGE_OVERRIDE,
-	/* Manually set the offset voltage */
-	AD3552R_CH_GAIN_OFFSET,
-	/* Sets the polarity of the offset. */
-	AD3552R_CH_GAIN_OFFSET_POLARITY,
-	/* PDAC gain scaling */
-	AD3552R_CH_GAIN_SCALING_P,
-	/* NDAC gain scaling */
-	AD3552R_CH_GAIN_SCALING_N,
-	/* Rfb value */
-	AD3552R_CH_RFB,
-	/* Channel select. When set allow Input -> DAC and Mask -> DAC */
-	AD3552R_CH_SELECT,
-};
-
-struct ad3552r_ch_data {
-	s32	scale_int;
-	s32	scale_dec;
-	s32	offset_int;
-	s32	offset_dec;
-	s16	gain_offset;
-	u16	rfb;
-	u8	n;
-	u8	p;
-	u8	range;
-	bool	range_override;
-};
-
-struct ad3552r_model_data {
-	const char *model_name;
-	enum ad3552r_id chip_id;
-	unsigned int num_hw_channels;
-	const s32 (*ranges_table)[2];
-	int num_ranges;
-	bool requires_output_range;
-};
+#include "ad3552r.h"
 
 struct ad3552r_desc {
 	const struct ad3552r_model_data *model_data;
@@ -285,45 +29,6 @@ struct ad3552r_desc {
 	unsigned int		num_ch;
 };
 
-static const u16 addr_mask_map[][2] = {
-	[AD3552R_ADDR_ASCENSION] = {
-			AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
-			AD3552R_MASK_ADDR_ASCENSION
-	},
-	[AD3552R_SDO_DRIVE_STRENGTH] = {
-			AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
-			AD3552R_MASK_SDO_DRIVE_STRENGTH
-	},
-	[AD3552R_VREF_SELECT] = {
-			AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
-			AD3552R_MASK_REFERENCE_VOLTAGE_SEL
-	},
-};
-
-/* 0 -> reg addr, 1->ch0 mask, 2->ch1 mask */
-static const u16 addr_mask_map_ch[][3] = {
-	[AD3552R_CH_DAC_POWERDOWN] = {
-			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
-			AD3552R_MASK_CH_DAC_POWERDOWN(0),
-			AD3552R_MASK_CH_DAC_POWERDOWN(1)
-	},
-	[AD3552R_CH_AMPLIFIER_POWERDOWN] = {
-			AD3552R_REG_ADDR_POWERDOWN_CONFIG,
-			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0),
-			AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1)
-	},
-	[AD3552R_CH_OUTPUT_RANGE_SEL] = {
-			AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
-			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0),
-			AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1)
-	},
-	[AD3552R_CH_SELECT] = {
-			AD3552R_REG_ADDR_CH_SELECT_16B,
-			AD3552R_MASK_CH(0),
-			AD3552R_MASK_CH(1)
-	}
-};
-
 static u8 _ad3552r_reg_len(u8 addr)
 {
 	switch (addr) {
@@ -399,11 +104,6 @@ static int ad3552r_read_reg(struct ad3552r_desc *dac, u8 addr, u16 *val)
 	return 0;
 }
 
-static u16 ad3552r_field_prep(u16 val, u16 mask)
-{
-	return (val << __ffs(mask)) & mask;
-}
-
 /* Update field of a register, shift val if needed */
 static int ad3552r_update_reg_field(struct ad3552r_desc *dac, u8 addr, u16 mask,
 				    u16 val)
@@ -416,21 +116,11 @@ static int ad3552r_update_reg_field(struct ad3552r_desc *dac, u8 addr, u16 mask,
 		return ret;
 
 	reg &= ~mask;
-	reg |= ad3552r_field_prep(val, mask);
+	reg |= val;
 
 	return ad3552r_write_reg(dac, addr, reg);
 }
 
-static int ad3552r_set_ch_value(struct ad3552r_desc *dac,
-				enum ad3552r_ch_attributes attr,
-				u8 ch,
-				u16 val)
-{
-	/* Update register related to attributes in chip */
-	return ad3552r_update_reg_field(dac, addr_mask_map_ch[attr][0],
-				       addr_mask_map_ch[attr][ch + 1], val);
-}
-
 #define AD3552R_CH_DAC(_idx) ((struct iio_chan_spec) {		\
 	.type = IIO_VOLTAGE,					\
 	.output = true,						\
@@ -510,8 +200,14 @@ static int ad3552r_write_raw(struct iio_dev *indio_dev,
 					val);
 		break;
 	case IIO_CHAN_INFO_ENABLE:
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_DAC_POWERDOWN,
-					   chan->channel, !val);
+		if (chan->channel == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(0), !val);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH_DAC_POWERDOWN(1), !val);
+
+		err = ad3552r_update_reg_field(dac, AD3552R_REG_ADDR_POWERDOWN_CONFIG,
+					       AD3552R_MASK_CH_DAC_POWERDOWN(chan->channel),
+					       val);
 		break;
 	default:
 		err = -EINVAL;
@@ -721,83 +417,9 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 		return ret;
 
 	return ad3552r_update_reg_field(dac,
-					addr_mask_map[AD3552R_ADDR_ASCENSION][0],
-					addr_mask_map[AD3552R_ADDR_ASCENSION][1],
-					val);
-}
-
-static void ad3552r_get_custom_range(struct ad3552r_desc *dac, s32 i, s32 *v_min,
-				     s32 *v_max)
-{
-	s64 vref, tmp, common, offset, gn, gp;
-	/*
-	 * From datasheet formula (In Volts):
-	 *	Vmin = 2.5 + [(GainN + Offset / 1024) * 2.5 * Rfb * 1.03]
-	 *	Vmax = 2.5 - [(GainP + Offset / 1024) * 2.5 * Rfb * 1.03]
-	 * Calculus are converted to milivolts
-	 */
-	vref = 2500;
-	/* 2.5 * 1.03 * 1000 (To mV) */
-	common = 2575 * dac->ch_data[i].rfb;
-	offset = dac->ch_data[i].gain_offset;
-
-	gn = gains_scaling_table[dac->ch_data[i].n];
-	tmp = (1024 * gn + AD3552R_GAIN_SCALE * offset) * common;
-	tmp = div_s64(tmp, 1024  * AD3552R_GAIN_SCALE);
-	*v_max = vref + tmp;
-
-	gp = gains_scaling_table[dac->ch_data[i].p];
-	tmp = (1024 * gp - AD3552R_GAIN_SCALE * offset) * common;
-	tmp = div_s64(tmp, 1024 * AD3552R_GAIN_SCALE);
-	*v_min = vref - tmp;
-}
-
-static void ad3552r_calc_gain_and_offset(struct ad3552r_desc *dac, s32 ch)
-{
-	s32 idx, v_max, v_min, span, rem;
-	s64 tmp;
-
-	if (dac->ch_data[ch].range_override) {
-		ad3552r_get_custom_range(dac, ch, &v_min, &v_max);
-	} else {
-		/* Normal range */
-		idx = dac->ch_data[ch].range;
-		v_min = dac->model_data->ranges_table[idx][0];
-		v_max = dac->model_data->ranges_table[idx][1];
-	}
-
-	/*
-	 * From datasheet formula:
-	 *	Vout = Span * (D / 65536) + Vmin
-	 * Converted to scale and offset:
-	 *	Scale = Span / 65536
-	 *	Offset = 65536 * Vmin / Span
-	 *
-	 * Reminders are in micros in order to be printed as
-	 * IIO_VAL_INT_PLUS_MICRO
-	 */
-	span = v_max - v_min;
-	dac->ch_data[ch].scale_int = div_s64_rem(span, 65536, &rem);
-	/* Do operations in microvolts */
-	dac->ch_data[ch].scale_dec = DIV_ROUND_CLOSEST((s64)rem * 1000000,
-							65536);
-
-	dac->ch_data[ch].offset_int = div_s64_rem(v_min * 65536, span, &rem);
-	tmp = (s64)rem * 1000000;
-	dac->ch_data[ch].offset_dec = div_s64(tmp, span);
-}
-
-static int ad3552r_find_range(const struct ad3552r_model_data *model_data,
-			      s32 *vals)
-{
-	int i;
-
-	for (i = 0; i < model_data->num_ranges; i++)
-		if (vals[0] == model_data->ranges_table[i][0] * 1000 &&
-		    vals[1] == model_data->ranges_table[i][1] * 1000)
-			return i;
-
-	return -EINVAL;
+					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
+					AD3552R_MASK_ADDR_ASCENSION,
+					FIELD_PREP(AD3552R_MASK_ADDR_ASCENSION, val));
 }
 
 static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
@@ -805,57 +427,30 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 					 u32 ch)
 {
 	struct device *dev = &dac->spi->dev;
-	u32 val;
 	int err;
 	u8 addr;
-	u16 reg = 0, offset;
-
-	struct fwnode_handle *gain_child __free(fwnode_handle)
-		= fwnode_get_named_child_node(child,
-					      "custom-output-range-config");
-	if (!gain_child)
-		return dev_err_probe(dev, -EINVAL,
-				     "mandatory custom-output-range-config property missing\n");
-
-	dac->ch_data[ch].range_override = 1;
-	reg |= ad3552r_field_prep(1, AD3552R_MASK_CH_RANGE_OVERRIDE);
-
-	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-p", &val);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,gain-scaling-p property missing\n");
-	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_P);
-	dac->ch_data[ch].p = val;
-
-	err = fwnode_property_read_u32(gain_child, "adi,gain-scaling-n", &val);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,gain-scaling-n property missing\n");
-	reg |= ad3552r_field_prep(val, AD3552R_MASK_CH_GAIN_SCALING_N);
-	dac->ch_data[ch].n = val;
-
-	err = fwnode_property_read_u32(gain_child, "adi,rfb-ohms", &val);
-	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,rfb-ohms property missing\n");
-	dac->ch_data[ch].rfb = val;
+	u16 reg;
 
-	err = fwnode_property_read_u32(gain_child, "adi,gain-offset", &val);
+	err = ad3552r_get_custom_gain(dev, child,
+				      &dac->ch_data[ch].p,
+				      &dac->ch_data[ch].n,
+				      &dac->ch_data[ch].rfb,
+				      &dac->ch_data[ch].gain_offset);
 	if (err)
-		return dev_err_probe(dev, err,
-				     "mandatory adi,gain-offset property missing\n");
-	dac->ch_data[ch].gain_offset = val;
+		return err;
 
-	offset = abs((s32)val);
-	reg |= ad3552r_field_prep((offset >> 8), AD3552R_MASK_CH_OFFSET_BIT_8);
+	dac->ch_data[ch].range_override = 1;
 
-	reg |= ad3552r_field_prep((s32)val < 0, AD3552R_MASK_CH_OFFSET_POLARITY);
 	addr = AD3552R_REG_ADDR_CH_GAIN(ch);
 	err = ad3552r_write_reg(dac, addr,
-				offset & AD3552R_MASK_CH_OFFSET_BITS_0_7);
+				abs((s32)dac->ch_data[ch].gain_offset) &
+				AD3552R_MASK_CH_OFFSET_BITS_0_7);
 	if (err)
 		return dev_err_probe(dev, err, "Error writing register\n");
 
+	reg = ad3552r_calc_custom_gain(dac->ch_data[ch].p, dac->ch_data[ch].n,
+				       dac->ch_data[ch].gain_offset);
+
 	err = ad3552r_write_reg(dac, addr, reg);
 	if (err)
 		return dev_err_probe(dev, err, "Error writing register\n");
@@ -866,49 +461,31 @@ static int ad3552r_configure_custom_gain(struct ad3552r_desc *dac,
 static int ad3552r_configure_device(struct ad3552r_desc *dac)
 {
 	struct device *dev = &dac->spi->dev;
-	int err, cnt = 0, voltage, delta = 100000;
-	u32 vals[2], val, ch;
+	int err, cnt = 0;
+	u32 val, ch;
 
 	dac->gpio_ldac = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
 	if (IS_ERR(dac->gpio_ldac))
 		return dev_err_probe(dev, PTR_ERR(dac->gpio_ldac),
 				     "Error getting gpio ldac");
 
-	voltage = devm_regulator_get_enable_read_voltage(dev, "vref");
-	if (voltage < 0 && voltage != -ENODEV)
-		return dev_err_probe(dev, voltage, "Error getting vref voltage\n");
-
-	if (voltage == -ENODEV) {
-		if (device_property_read_bool(dev, "adi,vref-out-en"))
-			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
-		else
-			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
-	} else {
-		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
-			dev_warn(dev, "vref-supply must be 2.5V");
-			return -EINVAL;
-		}
-		val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
-	}
+	err = ad3552r_get_ref_voltage(dev, &val);
+	if (err < 0)
+		return err;
 
 	err = ad3552r_update_reg_field(dac,
-				       addr_mask_map[AD3552R_VREF_SELECT][0],
-				       addr_mask_map[AD3552R_VREF_SELECT][1],
-				       val);
+				       AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
+				       AD3552R_MASK_REFERENCE_VOLTAGE_SEL,
+				       FIELD_PREP(AD3552R_MASK_REFERENCE_VOLTAGE_SEL, val));
 	if (err)
 		return err;
 
-	err = device_property_read_u32(dev, "adi,sdo-drive-strength", &val);
+	err = ad3552r_get_drive_strength(dev, &val);
 	if (!err) {
-		if (val > 3) {
-			dev_err(dev, "adi,sdo-drive-strength must be less than 4\n");
-			return -EINVAL;
-		}
-
 		err = ad3552r_update_reg_field(dac,
-					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][0],
-					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][1],
-					       val);
+					       AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
+					       AD3552R_MASK_SDO_DRIVE_STRENGTH,
+					       FIELD_PREP(AD3552R_MASK_SDO_DRIVE_STRENGTH, val));
 		if (err)
 			return err;
 	}
@@ -929,24 +506,21 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 					     "reg must be less than %d\n",
 					     dac->model_data->num_hw_channels);
 
-		if (fwnode_property_present(child, "adi,output-range-microvolt")) {
-			err = fwnode_property_read_u32_array(child,
-							     "adi,output-range-microvolt",
-							     vals,
-							     2);
-			if (err)
-				return dev_err_probe(dev, err,
-					"adi,output-range-microvolt property could not be parsed\n");
-
-			err = ad3552r_find_range(dac->model_data, vals);
-			if (err < 0)
-				return dev_err_probe(dev, err,
-						     "Invalid adi,output-range-microvolt value\n");
-
-			val = err;
-			err = ad3552r_set_ch_value(dac,
-						   AD3552R_CH_OUTPUT_RANGE_SEL,
-						   ch, val);
+		err = ad3552r_get_output_range(dev, dac->model_data,
+					       child, &val);
+		if (err && err != -ENOENT)
+			return err;
+
+		if (!err) {
+			if (ch == 0)
+				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(0), val);
+			else
+				val = FIELD_PREP(AD3552R_MASK_CH_OUTPUT_RANGE_SEL(1), val);
+
+			err = ad3552r_update_reg_field(dac,
+						       AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE,
+						       AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch),
+						       val);
 			if (err)
 				return err;
 
@@ -961,10 +535,17 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 				return err;
 		}
 
-		ad3552r_calc_gain_and_offset(dac, ch);
+		ad3552r_calc_gain_and_offset(&dac->ch_data[ch], dac->model_data);
 		dac->enabled_ch |= BIT(ch);
 
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
+		if (ch == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH(0), 1);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH(1), 1);
+
+		err = ad3552r_update_reg_field(dac,
+					       AD3552R_REG_ADDR_CH_SELECT_16B,
+					       AD3552R_MASK_CH(ch), val);
 		if (err < 0)
 			return err;
 
@@ -976,8 +557,15 @@ static int ad3552r_configure_device(struct ad3552r_desc *dac)
 	/* Disable unused channels */
 	for_each_clear_bit(ch, &dac->enabled_ch,
 			   dac->model_data->num_hw_channels) {
-		err = ad3552r_set_ch_value(dac, AD3552R_CH_AMPLIFIER_POWERDOWN,
-					   ch, 1);
+		if (ch == 0)
+			val = FIELD_PREP(AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(0), 1);
+		else
+			val = FIELD_PREP(AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(1), 1);
+
+		err = ad3552r_update_reg_field(dac,
+					       AD3552R_REG_ADDR_POWERDOWN_CONFIG,
+					       AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch),
+					       val);
 		if (err)
 			return err;
 	}
@@ -1146,3 +734,4 @@ module_spi_driver(ad3552r_driver);
 MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
 MODULE_DESCRIPTION("Analog Device AD3552R DAC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_AD3552R);
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
new file mode 100644
index 000000000000..c20f64f80d5d
--- /dev/null
+++ b/drivers/iio/dac/ad3552r.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AD3552R Digital <-> Analog converters common header
+ *
+ * Copyright 2021-2024 Analog Devices Inc.
+ * Author: Angelo Dureghello <adureghello@baylibre.com>
+ */
+
+#ifndef __DRIVERS_IIO_DAC_AD3552R_H__
+#define __DRIVERS_IIO_DAC_AD3552R_H__
+
+/* Register addresses */
+/* Primary address space */
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_A		0x00
+#define   AD3552R_MASK_SOFTWARE_RESET			(BIT(7) | BIT(0))
+#define   AD3552R_MASK_ADDR_ASCENSION			BIT(5)
+#define   AD3552R_MASK_SDO_ACTIVE			BIT(4)
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_B		0x01
+#define   AD3552R_MASK_SINGLE_INST			BIT(7)
+#define   AD3552R_MASK_SHORT_INSTRUCTION		BIT(3)
+#define AD3552R_REG_ADDR_DEVICE_CONFIG			0x02
+#define   AD3552R_MASK_DEVICE_STATUS(n)			BIT(4 + (n))
+#define   AD3552R_MASK_CUSTOM_MODES			GENMASK(3, 2)
+#define   AD3552R_MASK_OPERATING_MODES			GENMASK(1, 0)
+#define AD3552R_REG_ADDR_CHIP_TYPE			0x03
+#define   AD3552R_MASK_CLASS				GENMASK(7, 0)
+#define AD3552R_REG_ADDR_PRODUCT_ID_L			0x04
+#define AD3552R_REG_ADDR_PRODUCT_ID_H			0x05
+#define AD3552R_REG_ADDR_CHIP_GRADE			0x06
+#define   AD3552R_MASK_GRADE				GENMASK(7, 4)
+#define   AD3552R_MASK_DEVICE_REVISION			GENMASK(3, 0)
+#define AD3552R_REG_ADDR_SCRATCH_PAD			0x0A
+#define AD3552R_REG_ADDR_SPI_REVISION			0x0B
+#define AD3552R_REG_ADDR_VENDOR_L			0x0C
+#define AD3552R_REG_ADDR_VENDOR_H			0x0D
+#define AD3552R_REG_ADDR_STREAM_MODE			0x0E
+#define   AD3552R_MASK_LENGTH				GENMASK(7, 0)
+#define AD3552R_REG_ADDR_TRANSFER_REGISTER		0x0F
+#define   AD3552R_MASK_MULTI_IO_MODE			GENMASK(7, 6)
+#define   AD3552R_MASK_STREAM_LENGTH_KEEP_VALUE		BIT(2)
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_C		0x10
+#define   AD3552R_MASK_CRC_ENABLE \
+		(GENMASK(7, 6) | GENMASK(1, 0))
+#define   AD3552R_MASK_STRICT_REGISTER_ACCESS		BIT(5)
+#define AD3552R_REG_ADDR_INTERFACE_STATUS_A		0x11
+#define   AD3552R_MASK_INTERFACE_NOT_READY		BIT(7)
+#define   AD3552R_MASK_CLOCK_COUNTING_ERROR		BIT(5)
+#define   AD3552R_MASK_INVALID_OR_NO_CRC		BIT(3)
+#define   AD3552R_MASK_WRITE_TO_READ_ONLY_REGISTER	BIT(2)
+#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS		BIT(1)
+#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID		BIT(0)
+#define AD3552R_REG_ADDR_INTERFACE_CONFIG_D		0x14
+#define   AD3552R_MASK_ALERT_ENABLE_PULLUP		BIT(6)
+#define   AD3552R_MASK_MEM_CRC_EN			BIT(4)
+#define   AD3552R_MASK_SDO_DRIVE_STRENGTH		GENMASK(3, 2)
+#define   AD3552R_MASK_DUAL_SPI_SYNCHROUNOUS_EN		BIT(1)
+#define   AD3552R_MASK_SPI_CONFIG_DDR			BIT(0)
+#define AD3552R_REG_ADDR_SH_REFERENCE_CONFIG		0x15
+#define   AD3552R_MASK_IDUMP_FAST_MODE			BIT(6)
+#define   AD3552R_MASK_SAMPLE_HOLD_DIFF_USER_EN		BIT(5)
+#define   AD3552R_MASK_SAMPLE_HOLD_USER_TRIM		GENMASK(4, 3)
+#define   AD3552R_MASK_SAMPLE_HOLD_USER_ENABLE		BIT(2)
+#define   AD3552R_MASK_REFERENCE_VOLTAGE_SEL		GENMASK(1, 0)
+#define AD3552R_REG_ADDR_ERR_ALARM_MASK			0x16
+#define   AD3552R_MASK_REF_RANGE_ALARM			BIT(6)
+#define   AD3552R_MASK_CLOCK_COUNT_ERR_ALARM		BIT(5)
+#define   AD3552R_MASK_MEM_CRC_ERR_ALARM		BIT(4)
+#define   AD3552R_MASK_SPI_CRC_ERR_ALARM		BIT(3)
+#define   AD3552R_MASK_WRITE_TO_READ_ONLY_ALARM		BIT(2)
+#define   AD3552R_MASK_PARTIAL_REGISTER_ACCESS_ALARM	BIT(1)
+#define   AD3552R_MASK_REGISTER_ADDRESS_INVALID_ALARM	BIT(0)
+#define AD3552R_REG_ADDR_ERR_STATUS			0x17
+#define   AD3552R_MASK_REF_RANGE_ERR_STATUS		BIT(6)
+#define   AD3552R_MASK_STREAM_EXCEEDS_DAC_ERR_STATUS	BIT(5)
+#define   AD3552R_MASK_MEM_CRC_ERR_STATUS		BIT(4)
+#define   AD3552R_MASK_RESET_STATUS			BIT(0)
+#define AD3552R_REG_ADDR_POWERDOWN_CONFIG		0x18
+#define   AD3552R_MASK_CH_DAC_POWERDOWN(ch)		BIT(4 + (ch))
+#define   AD3552R_MASK_CH_AMPLIFIER_POWERDOWN(ch)	BIT(ch)
+#define AD3552R_REG_ADDR_CH0_CH1_OUTPUT_RANGE		0x19
+#define   AD3552R_MASK_CH0_RANGE			GENMASK(2, 0)
+#define   AD3552R_MASK_CH1_RANGE			GENMASK(6, 4)
+#define   AD3552R_MASK_CH_OUTPUT_RANGE			GENMASK(7, 0)
+#define   AD3552R_MASK_CH_OUTPUT_RANGE_SEL(ch) \
+		((ch) ? GENMASK(7, 4) : GENMASK(3, 0))
+#define AD3552R_REG_ADDR_CH_OFFSET(ch)			(0x1B + (ch) * 2)
+#define   AD3552R_MASK_CH_OFFSET_BITS_0_7		GENMASK(7, 0)
+#define AD3552R_REG_ADDR_CH_GAIN(ch)			(0x1C + (ch) * 2)
+#define   AD3552R_MASK_CH_RANGE_OVERRIDE		BIT(7)
+#define   AD3552R_MASK_CH_GAIN_SCALING_N		GENMASK(6, 5)
+#define   AD3552R_MASK_CH_GAIN_SCALING_P		GENMASK(4, 3)
+#define   AD3552R_MASK_CH_OFFSET_POLARITY		BIT(2)
+#define   AD3552R_MASK_CH_OFFSET_BIT_8			BIT(8)
+/*
+ * Secondary region
+ * For multibyte registers specify the highest address because the access is
+ * done in descending order
+ */
+#define AD3552R_SECONDARY_REGION_START			0x28
+#define AD3552R_REG_ADDR_HW_LDAC_16B			0x28
+#define AD3552R_REG_ADDR_CH_DAC_16B(ch)			(0x2C - (1 - (ch)) * 2)
+#define AD3552R_REG_ADDR_DAC_PAGE_MASK_16B		0x2E
+#define AD3552R_REG_ADDR_CH_SELECT_16B			0x2F
+#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_16B		0x31
+#define AD3552R_REG_ADDR_SW_LDAC_16B			0x32
+#define AD3552R_REG_ADDR_CH_INPUT_16B(ch)		(0x36 - (1 - (ch)) * 2)
+/* 3 bytes registers */
+#define AD3552R_REG_START_24B				0x37
+#define AD3552R_REG_ADDR_HW_LDAC_24B			0x37
+#define AD3552R_REG_ADDR_CH_DAC_24B(ch)			(0x3D - (1 - (ch)) * 3)
+#define AD3552R_REG_ADDR_DAC_PAGE_MASK_24B		0x40
+#define AD3552R_REG_ADDR_CH_SELECT_24B			0x41
+#define AD3552R_REG_ADDR_INPUT_PAGE_MASK_24B		0x44
+#define AD3552R_REG_ADDR_SW_LDAC_24B			0x45
+#define AD3552R_REG_ADDR_CH_INPUT_24B(ch)		(0x4B - (1 - (ch)) * 3)
+
+#define AD3552R_MAX_CH					2
+#define AD3552R_MASK_CH(ch)				BIT(ch)
+#define AD3552R_MASK_ALL_CH				GENMASK(1, 0)
+#define AD3552R_MAX_REG_SIZE				3
+#define AD3552R_READ_BIT				BIT(7)
+#define AD3552R_ADDR_MASK				GENMASK(6, 0)
+#define AD3552R_MASK_DAC_12B				GENMASK(15, 4)
+#define AD3552R_DEFAULT_CONFIG_B_VALUE			0x8
+#define AD3552R_SCRATCH_PAD_TEST_VAL1			0x34
+#define AD3552R_SCRATCH_PAD_TEST_VAL2			0xB2
+#define AD3552R_GAIN_SCALE				1000
+#define AD3552R_LDAC_PULSE_US				100
+
+#define AD3552R_MAX_RANGES	5
+#define AD3542R_MAX_RANGES	5
+#define AD3552R_QUAD_SPI	2
+
+extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
+extern const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2];
+
+enum ad3552r_id {
+	AD3541R_ID = 0x400b,
+	AD3542R_ID = 0x4009,
+	AD3551R_ID = 0x400a,
+	AD3552R_ID = 0x4008,
+};
+
+struct ad3552r_model_data {
+	const char *model_name;
+	enum ad3552r_id chip_id;
+	unsigned int num_hw_channels;
+	const s32 (*ranges_table)[2];
+	int num_ranges;
+	bool requires_output_range;
+};
+
+struct ad3552r_ch_data {
+	s32	scale_int;
+	s32	scale_dec;
+	s32	offset_int;
+	s32	offset_dec;
+	s16	gain_offset;
+	u16	rfb;
+	u8	n;
+	u8	p;
+	u8	range;
+	bool	range_override;
+};
+
+enum ad3552r_ch_gain_scaling {
+	/* Gain scaling of 1 */
+	AD3552R_CH_GAIN_SCALING_1,
+	/* Gain scaling of 0.5 */
+	AD3552R_CH_GAIN_SCALING_0_5,
+	/* Gain scaling of 0.25 */
+	AD3552R_CH_GAIN_SCALING_0_25,
+	/* Gain scaling of 0.125 */
+	AD3552R_CH_GAIN_SCALING_0_125,
+};
+
+enum ad3552r_ch_vref_select {
+	/* Internal source with Vref I/O floating */
+	AD3552R_INTERNAL_VREF_PIN_FLOATING,
+	/* Internal source with Vref I/O at 2.5V */
+	AD3552R_INTERNAL_VREF_PIN_2P5V,
+	/* External source with Vref I/O as input */
+	AD3552R_EXTERNAL_VREF_PIN_INPUT
+};
+
+enum ad3542r_ch_output_range {
+	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
+	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
+	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
+	AD3542R_CH_OUTPUT_RANGE_0__5V,
+	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_0__10V,
+	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
+	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
+	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
+};
+
+enum ad3552r_ch_output_range {
+	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
+	AD3552R_CH_OUTPUT_RANGE_0__2P5V,
+	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
+	AD3552R_CH_OUTPUT_RANGE_0__5V,
+	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
+	AD3552R_CH_OUTPUT_RANGE_0__10V,
+	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
+	AD3552R_CH_OUTPUT_RANGE_NEG_5__5V,
+	/* Range from -10 V to 10 V. Requires Rfb4x connection  */
+	AD3552R_CH_OUTPUT_RANGE_NEG_10__10V,
+};
+
+int ad3552r_get_output_range(struct device *dev,
+			     const struct ad3552r_model_data *model_info,
+			     struct fwnode_handle *child, u32 *val);
+int ad3552r_get_custom_gain(struct device *dev, struct fwnode_handle *child,
+			    u8 *gs_p, u8 *gs_n, u16 *rfb, s16 *goffs);
+u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs);
+int ad3552r_get_ref_voltage(struct device *dev, u32 *val);
+int ad3552r_get_drive_strength(struct device *dev, u32 *val);
+void ad3552r_calc_gain_and_offset(struct ad3552r_ch_data *ch_data,
+				  const struct ad3552r_model_data *model_data);
+
+#endif /* __DRIVERS_IIO_DAC_AD3552R_H__ */
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index b4c6c7c47256..8fae58db1d63 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -582,7 +582,7 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	struct {
 		u32 pressure;
 		u16 temperature;
-		u64 timestamp;
+		aligned_s64 timestamp;
 	}   sample;
 	int err;
 
diff --git a/drivers/leds/led-class-multicolor.c b/drivers/leds/led-class-multicolor.c
index 30c1ecb5f361..c707be97049b 100644
--- a/drivers/leds/led-class-multicolor.c
+++ b/drivers/leds/led-class-multicolor.c
@@ -61,7 +61,8 @@ static ssize_t multi_intensity_store(struct device *dev,
 	for (i = 0; i < mcled_cdev->num_colors; i++)
 		mcled_cdev->subled_info[i].intensity = intensity_value[i];
 
-	led_set_brightness(led_cdev, led_cdev->brightness);
+	if (!test_bit(LED_BLINK_SW, &led_cdev->work_flags))
+		led_set_brightness(led_cdev, led_cdev->brightness);
 	ret = size;
 err_out:
 	mutex_unlock(&led_cdev->led_access);
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index cb174e788a96..92c2fb618c8e 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -490,8 +490,8 @@ void mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == TXDONE_BY_ACK)
 		chan->txdone_method = TXDONE_BY_POLL;
 
-	module_put(chan->mbox->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flags);
+	module_put(chan->mbox->dev->driver->owner);
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index e42f1400cea9..f5171167819b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1733,7 +1733,12 @@ static CLOSURE_CALLBACK(cache_set_flush)
 			mutex_unlock(&b->write_lock);
 		}
 
-	if (ca->alloc_thread)
+	/*
+	 * If the register_cache_set() call to bch_cache_set_alloc() failed,
+	 * ca has not been assigned a value and return error.
+	 * So we need check ca is not NULL during bch_cache_set_unregister().
+	 */
+	if (ca && ca->alloc_thread)
 		kthread_stop(ca->alloc_thread);
 
 	if (c->journal.cur) {
diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 1e0d3b9b75d6..163a5bbd485f 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2410,7 +2410,7 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
 	 */
 	sb_retrieve_failed_devices(sb, failed_devices);
 	rdev_for_each(r, mddev) {
-		if (test_bit(Journal, &rdev->flags) ||
+		if (test_bit(Journal, &r->flags) ||
 		    !r->sb_page)
 			continue;
 		sb2 = page_address(r->sb_page);
diff --git a/drivers/md/dm-vdo/indexer/volume.c b/drivers/md/dm-vdo/indexer/volume.c
index 655453bb276b..425b3a74f4db 100644
--- a/drivers/md/dm-vdo/indexer/volume.c
+++ b/drivers/md/dm-vdo/indexer/volume.c
@@ -754,10 +754,11 @@ static int get_volume_page_protected(struct volume *volume, struct uds_request *
 				     u32 physical_page, struct cached_page **page_ptr)
 {
 	struct cached_page *page;
+	unsigned int zone_number = request->zone_number;
 
 	get_page_from_cache(&volume->page_cache, physical_page, &page);
 	if (page != NULL) {
-		if (request->zone_number == 0) {
+		if (zone_number == 0) {
 			/* Only one zone is allowed to update the LRU. */
 			make_page_most_recent(&volume->page_cache, page);
 		}
@@ -767,7 +768,7 @@ static int get_volume_page_protected(struct volume *volume, struct uds_request *
 	}
 
 	/* Prepare to enqueue a read for the page. */
-	end_pending_search(&volume->page_cache, request->zone_number);
+	end_pending_search(&volume->page_cache, zone_number);
 	mutex_lock(&volume->read_threads_mutex);
 
 	/*
@@ -787,8 +788,7 @@ static int get_volume_page_protected(struct volume *volume, struct uds_request *
 		 * the order does not matter for correctness as it does below.
 		 */
 		mutex_unlock(&volume->read_threads_mutex);
-		begin_pending_search(&volume->page_cache, physical_page,
-				     request->zone_number);
+		begin_pending_search(&volume->page_cache, physical_page, zone_number);
 		return UDS_QUEUED;
 	}
 
@@ -797,7 +797,7 @@ static int get_volume_page_protected(struct volume *volume, struct uds_request *
 	 * "search pending" state in careful order so no other thread can mess with the data before
 	 * the caller gets to look at it.
 	 */
-	begin_pending_search(&volume->page_cache, physical_page, request->zone_number);
+	begin_pending_search(&volume->page_cache, physical_page, zone_number);
 	mutex_unlock(&volume->read_threads_mutex);
 	*page_ptr = page;
 	return UDS_SUCCESS;
@@ -849,6 +849,7 @@ static int search_cached_index_page(struct volume *volume, struct uds_request *r
 {
 	int result;
 	struct cached_page *page = NULL;
+	unsigned int zone_number = request->zone_number;
 	u32 physical_page = map_to_physical_page(volume->geometry, chapter,
 						 index_page_number);
 
@@ -858,18 +859,18 @@ static int search_cached_index_page(struct volume *volume, struct uds_request *r
 	 * invalidation by the reader thread, before the reader thread has noticed that the
 	 * invalidate_counter has been incremented.
 	 */
-	begin_pending_search(&volume->page_cache, physical_page, request->zone_number);
+	begin_pending_search(&volume->page_cache, physical_page, zone_number);
 
 	result = get_volume_page_protected(volume, request, physical_page, &page);
 	if (result != UDS_SUCCESS) {
-		end_pending_search(&volume->page_cache, request->zone_number);
+		end_pending_search(&volume->page_cache, zone_number);
 		return result;
 	}
 
 	result = uds_search_chapter_index_page(&page->index_page, volume->geometry,
 					       &request->record_name,
 					       record_page_number);
-	end_pending_search(&volume->page_cache, request->zone_number);
+	end_pending_search(&volume->page_cache, zone_number);
 	return result;
 }
 
@@ -882,6 +883,7 @@ int uds_search_cached_record_page(struct volume *volume, struct uds_request *req
 {
 	struct cached_page *record_page;
 	struct index_geometry *geometry = volume->geometry;
+	unsigned int zone_number = request->zone_number;
 	int result;
 	u32 physical_page, page_number;
 
@@ -905,11 +907,11 @@ int uds_search_cached_record_page(struct volume *volume, struct uds_request *req
 	 * invalidation by the reader thread, before the reader thread has noticed that the
 	 * invalidate_counter has been incremented.
 	 */
-	begin_pending_search(&volume->page_cache, physical_page, request->zone_number);
+	begin_pending_search(&volume->page_cache, physical_page, zone_number);
 
 	result = get_volume_page_protected(volume, request, physical_page, &record_page);
 	if (result != UDS_SUCCESS) {
-		end_pending_search(&volume->page_cache, request->zone_number);
+		end_pending_search(&volume->page_cache, zone_number);
 		return result;
 	}
 
@@ -917,7 +919,7 @@ int uds_search_cached_record_page(struct volume *volume, struct uds_request *req
 			       &request->record_name, geometry, &request->old_metadata))
 		*found = true;
 
-	end_pending_search(&volume->page_cache, request->zone_number);
+	end_pending_search(&volume->page_cache, zone_number);
 	return UDS_SUCCESS;
 }
 
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index fbb4f57010da..c12359fd3a42 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -787,7 +787,7 @@ static int md_bitmap_new_disk_sb(struct bitmap *bitmap)
 	 * is a good choice?  We choose COUNTER_MAX / 2 arbitrarily.
 	 */
 	write_behind = bitmap->mddev->bitmap_info.max_write_behind;
-	if (write_behind > COUNTER_MAX)
+	if (write_behind > COUNTER_MAX / 2)
 		write_behind = COUNTER_MAX / 2;
 	sb->write_behind = cpu_to_le32(write_behind);
 	bitmap->mddev->bitmap_info.max_write_behind = write_behind;
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index c70d9c24c6fb..957d620ad671 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1848,7 +1848,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1877,8 +1877,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1890,17 +1888,24 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0) {
+		if (ret < 0 && !rollback) {
 			if (err_ctrl)
 				*err_ctrl = ctrl;
-			return ret;
+			/*
+			 * If we fail to set a control, we need to rollback
+			 * the next ones.
+			 */
+			rollback = 1;
 		}
 
-		if (!rollback && handle &&
+		if (!rollback && handle && !ret &&
 		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
 			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1931,7 +1936,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -1942,17 +1948,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 				ctrls->error_idx =
 					uvc_ctrl_find_ctrl_idx(entity, ctrls,
 							       err_ctrl);
-			goto done;
+			/*
+			 * When we fail to commit an entity, we need to
+			 * restore the UVC_CTRL_DATA_BACKUP for all the
+			 * controls in the other entities, otherwise our cache
+			 * and the hardware will be out of sync.
+			 */
+			rollback = 1;
+
+			ret_out = ret;
 		} else if (ret > 0 && !rollback) {
 			uvc_ctrl_send_events(handle, entity,
 					     ctrls->controls, ctrls->count);
 		}
 	}
 
-	ret = 0;
-done:
 	mutex_unlock(&chain->ctrl_mutex);
-	return ret;
+	return ret_out;
 }
 
 int uvc_ctrl_get(struct uvc_video_chain *chain,
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 6fce79ec2dc6..7e7e8af9af22 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -456,6 +456,7 @@ static void max14577_i2c_remove(struct i2c_client *i2c)
 {
 	struct max14577 *max14577 = i2c_get_clientdata(i2c);
 
+	device_init_wakeup(max14577->dev, false);
 	mfd_remove_devices(max14577->dev);
 	regmap_del_irq_chip(max14577->irq, max14577->irq_data);
 	if (max14577->dev_type == MAXIM_DEVICE_TYPE_MAX77836)
diff --git a/drivers/misc/tps6594-pfsm.c b/drivers/misc/tps6594-pfsm.c
index 9bcca1856bfe..db3d6a21a212 100644
--- a/drivers/misc/tps6594-pfsm.c
+++ b/drivers/misc/tps6594-pfsm.c
@@ -281,6 +281,9 @@ static int tps6594_pfsm_probe(struct platform_device *pdev)
 	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
 	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
 					    tps->chip_id, tps->reg);
+	if (!pfsm->miscdev.name)
+		return -ENOMEM;
+
 	pfsm->miscdev.fops = &tps6594_pfsm_fops;
 	pfsm->miscdev.parent = dev->parent;
 	pfsm->chip_id = tps->chip_id;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 154f73f121ec..ad4aec522f4f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2871,6 +2871,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	u32 raw_cons = cpr->cp_raw_cons;
+	bool flush_xdp = false;
 	u32 cons;
 	int rx_pkts = 0;
 	u8 event = 0;
@@ -2924,6 +2925,8 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			else
 				rc = bnxt_force_rx_discard(bp, cpr, &raw_cons,
 							   &event);
+			if (event & BNXT_REDIRECT_EVENT)
+				flush_xdp = true;
 			if (likely(rc >= 0))
 				rx_pkts += rc;
 			/* Increment rx_pkts when rc is -ENOMEM to count towards
@@ -2948,7 +2951,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		}
 	}
 
-	if (event & BNXT_REDIRECT_EVENT) {
+	if (flush_xdp) {
 		xdp_do_flush();
 		event &= ~BNXT_REDIRECT_EVENT;
 	}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 1619943fb263..4e8881b479e4 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -485,7 +485,7 @@ static inline u64 _enetc_rd_reg64(void __iomem *reg)
 		tmp = ioread32(reg + 4);
 	} while (high != tmp);
 
-	return le64_to_cpu((__le64)high << 32 | low);
+	return (u64)high << 32 | low;
 }
 #endif
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 0eeda7e502db..0f5758c273c2 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -321,7 +321,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 					   len, DMA_TO_DEVICE);
 	} else /* XDP_REDIRECT */ {
 		dma_addr = ionic_tx_map_single(q, frame->data, len);
-		if (!dma_addr)
+		if (dma_addr == DMA_MAPPING_ERROR)
 			return -EIO;
 	}
 
@@ -357,7 +357,7 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 			} else {
 				dma_addr = ionic_tx_map_frag(q, frag, 0,
 							     skb_frag_size(frag));
-				if (dma_mapping_error(q->dev, dma_addr)) {
+				if (dma_addr == DMA_MAPPING_ERROR) {
 					ionic_tx_desc_unmap_bufs(q, desc_info);
 					return -EIO;
 				}
@@ -1083,7 +1083,7 @@ static dma_addr_t ionic_tx_map_single(struct ionic_queue *q,
 		net_warn_ratelimited("%s: DMA single map failed on %s!\n",
 				     dev_name(dev), q->name);
 		q_to_tx_stats(q)->dma_map_err++;
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 	return dma_addr;
 }
@@ -1100,7 +1100,7 @@ static dma_addr_t ionic_tx_map_frag(struct ionic_queue *q,
 		net_warn_ratelimited("%s: DMA frag map failed on %s!\n",
 				     dev_name(dev), q->name);
 		q_to_tx_stats(q)->dma_map_err++;
-		return 0;
+		return DMA_MAPPING_ERROR;
 	}
 	return dma_addr;
 }
@@ -1116,7 +1116,7 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	int frag_idx;
 
 	dma_addr = ionic_tx_map_single(q, skb->data, skb_headlen(skb));
-	if (!dma_addr)
+	if (dma_addr == DMA_MAPPING_ERROR)
 		return -EIO;
 	buf_info->dma_addr = dma_addr;
 	buf_info->len = skb_headlen(skb);
@@ -1126,7 +1126,7 @@ static int ionic_tx_map_skb(struct ionic_queue *q, struct sk_buff *skb,
 	nfrags = skb_shinfo(skb)->nr_frags;
 	for (frag_idx = 0; frag_idx < nfrags; frag_idx++, frag++) {
 		dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
-		if (!dma_addr)
+		if (dma_addr == DMA_MAPPING_ERROR)
 			goto dma_fail;
 		buf_info->dma_addr = dma_addr;
 		buf_info->len = skb_frag_size(frag);
diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index e2db944e6fa8..be4c9622618d 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -68,6 +68,7 @@ enum mac_version {
 	/* support for RTL_GIGA_MAC_VER_60 has been removed */
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
+	RTL_GIGA_MAC_VER_64,
 	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_NONE
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 85bb5121cd24..7b82779e4cd5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -55,6 +55,7 @@
 #define FIRMWARE_8107E_2	"rtl_nic/rtl8107e-2.fw"
 #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
+#define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 
@@ -138,6 +139,7 @@ static const struct {
 	[RTL_GIGA_MAC_VER_61] = {"RTL8125A",		FIRMWARE_8125A_3},
 	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
+	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
 	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
 	[RTL_GIGA_MAC_VER_66] = {"RTL8126A",		FIRMWARE_8126A_3},
 };
@@ -707,6 +709,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
 MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
+MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
 
@@ -2098,10 +2101,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 		tp->tx_lpi_timer = timer_val;
 		r8168_mac_ocp_write(tp, 0xe048, timer_val);
 		break;
-	case RTL_GIGA_MAC_VER_61:
-	case RTL_GIGA_MAC_VER_63:
-	case RTL_GIGA_MAC_VER_65:
-	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
 		tp->tx_lpi_timer = timer_val;
 		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
 		break;
@@ -2233,6 +2233,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_66 },
 		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_65 },
 
+		/* 8125D family. */
+		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
+
 		/* 8125B family. */
 		{ 0x7cf, 0x641,	RTL_GIGA_MAC_VER_63 },
 
@@ -2500,9 +2503,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
-	case RTL_GIGA_MAC_VER_63:
-	case RTL_GIGA_MAC_VER_65:
-	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -3840,6 +3841,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
 	rtl_hw_start_8125_common(tp);
 }
 
+static void rtl_hw_start_8125d(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+	rtl_hw_start_8125_common(tp);
+}
+
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
 	rtl_disable_zrxdc_timeout(tp);
@@ -3889,6 +3896,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
+		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
 	};
@@ -3906,6 +3914,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	/* disable interrupt coalescing */
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
+	case RTL_GIGA_MAC_VER_64:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
 		break;
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index cf29b1208482..d09b2a41cd06 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1104,6 +1104,15 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	rtl8125b_config_eee_phy(phydev);
 }
 
+static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
+				   struct phy_device *phydev)
+{
+	r8169_apply_firmware(tp);
+	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
+	rtl8125b_config_eee_phy(phydev);
+}
+
 static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
 				   struct phy_device *phydev)
 {
@@ -1160,6 +1169,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
+		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
 	};
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0250c5cb28ff..36328298dc9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3603,7 +3603,6 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	enum request_irq_err irq_err;
-	cpumask_t cpu_mask;
 	int irq_idx = 0;
 	char *int_name;
 	int ret;
@@ -3732,9 +3731,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->rx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	/* Request Tx MSI irq */
@@ -3757,9 +3755,8 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
 			irq_idx = i;
 			goto irq_error;
 		}
-		cpumask_clear(&cpu_mask);
-		cpumask_set_cpu(i % num_online_cpus(), &cpu_mask);
-		irq_set_affinity_hint(priv->tx_irq[i], &cpu_mask);
+		irq_set_affinity_hint(priv->tx_irq[i],
+				      cpumask_of(i % num_online_cpus()));
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 71c891d14fb6..d8a6fea961c0 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1336,6 +1336,7 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 	u8 tun_prot = 0;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
+csum_failed:
 		if (!(first->tx_flags & WX_TX_FLAGS_HW_VLAN) &&
 		    !(first->tx_flags & WX_TX_FLAGS_CC))
 			return;
@@ -1429,7 +1430,8 @@ static void wx_tx_csum(struct wx_ring *tx_ring, struct wx_tx_buffer *first,
 					WX_TXD_L4LEN_SHIFT;
 			break;
 		default:
-			break;
+			skb_checksum_help(skb);
+			goto csum_failed;
 		}
 
 		/* update TX checksum flag */
@@ -2425,7 +2427,7 @@ static int wx_alloc_page_pool(struct wx_ring *rx_ring)
 	struct page_pool_params pp_params = {
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.order = 0,
-		.pool_size = rx_ring->size,
+		.pool_size = rx_ring->count,
 		.nid = dev_to_node(rx_ring->dev),
 		.dev = rx_ring->dev,
 		.dma_dir = DMA_FROM_DEVICE,
diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 166f6a728373..8ce5705af69c 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -92,6 +92,7 @@
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
+#define RTL_8221B				0x001cc840
 #define RTL_8221B_VB_CG				0x001cc849
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
@@ -1040,6 +1041,23 @@ static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 	return val >= 0 && val & MDIO_PMA_SPEED_2_5G;
 }
 
+/* On internal PHY's MMD reads over C22 always return 0.
+ * Check a MMD register which is known to be non-zero.
+ */
+static bool rtlgen_supports_mmd(struct phy_device *phydev)
+{
+	int val;
+
+	phy_lock_mdio_bus(phydev);
+	__phy_write(phydev, MII_MMD_CTRL, MDIO_MMD_PCS);
+	__phy_write(phydev, MII_MMD_DATA, MDIO_PCS_EEE_ABLE);
+	__phy_write(phydev, MII_MMD_CTRL, MDIO_MMD_PCS | MII_MMD_CTRL_NOINCR);
+	val = __phy_read(phydev, MII_MMD_DATA);
+	phy_unlock_mdio_bus(phydev);
+
+	return val > 0;
+}
+
 static int rtlgen_match_phy_device(struct phy_device *phydev)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
@@ -1049,7 +1067,8 @@ static int rtlgen_match_phy_device(struct phy_device *phydev)
 static int rtl8226_match_phy_device(struct phy_device *phydev)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
-	       rtlgen_supports_2_5gbps(phydev);
+	       rtlgen_supports_2_5gbps(phydev) &&
+	       rtlgen_supports_mmd(phydev);
 }
 
 static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
@@ -1061,6 +1080,11 @@ static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
 		return !is_c45 && (id == phydev->phy_id);
 }
 
+static int rtl8221b_match_phy_device(struct phy_device *phydev)
+{
+	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
+}
+
 static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
@@ -1081,9 +1105,22 @@ static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev)
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
 }
 
-static int rtl8251b_c22_match_phy_device(struct phy_device *phydev)
+static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8251B, false);
+	if (phydev->is_c45)
+		return false;
+
+	switch (phydev->phy_id) {
+	case RTL_GENERIC_PHYID:
+	case RTL_8221B:
+	case RTL_8251B:
+	case 0x001cc841:
+		break;
+	default:
+		return false;
+	}
+
+	return rtlgen_supports_2_5gbps(phydev) && !rtlgen_supports_mmd(phydev);
 }
 
 static int rtl8251b_c45_match_phy_device(struct phy_device *phydev)
@@ -1345,10 +1382,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc840),
+		.match_phy_device = rtl8221b_match_phy_device,
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
@@ -1359,8 +1394,6 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
@@ -1438,8 +1471,9 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		.match_phy_device = rtl8251b_c22_match_phy_device,
-		.name           = "RTL8126A-internal 5Gbps PHY",
+		.match_phy_device = rtl_internal_nbaset_match_phy_device,
+		.name           = "Realtek Internal NBASE-T PHY",
+		.flags		= PHY_IS_INTERNAL,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4cc72be28c73..25e486e6e805 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -453,7 +453,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
 			return NULL;
 	}
 
-	list_del(&req->entry);
+	list_del_init(&req->entry);
+	init_llist_node(&req->lentry);
 	return req;
 }
 
@@ -561,6 +562,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	req->queue = queue;
 	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	nvme_req(rq)->cmd = &pdu->cmd;
+	init_llist_node(&req->lentry);
+	INIT_LIST_HEAD(&req->entry);
 
 	return 0;
 }
@@ -765,6 +768,14 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
+	if (llist_on_list(&req->lentry) ||
+	    !list_empty(&req->entry)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t while processing request\n",
+			rq->tag);
+		return -EPROTO;
+	}
+
 	req->pdu_len = 0;
 	req->h2cdata_left = r2t_length;
 	req->h2cdata_offset = r2t_offset;
@@ -1349,7 +1360,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
 	queue->nr_cqe = 0;
 	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
 	release_sock(sk);
-	return consumed;
+	return consumed == -EAGAIN ? 0 : consumed;
 }
 
 static void nvme_tcp_io_work(struct work_struct *w)
@@ -1377,6 +1388,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
+		/* did we get some space after spending time in recv? */
+		if (nvme_tcp_queue_has_pending(queue) &&
+		    sk_stream_is_writeable(queue->sock->sk))
+			pending = true;
+
 		if (!pending || !queue->rd_enabled)
 			return;
 
@@ -2594,6 +2610,8 @@ static void nvme_tcp_submit_async_event(struct nvme_ctrl *arg)
 	ctrl->async_req.offset = 0;
 	ctrl->async_req.curr_bio = NULL;
 	ctrl->async_req.data_len = 0;
+	init_llist_node(&ctrl->async_req.lentry);
+	INIT_LIST_HEAD(&ctrl->async_req.entry);
 
 	nvme_tcp_queue_request(&ctrl->async_req, true, true);
 }
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ad3028b755d1..3b24fed3177d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -206,6 +208,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
+	 * Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..d40afe74ddd1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -752,22 +752,19 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 	/* Set link width speed control register */
 	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 	switch (num_lanes) {
 	case 1:
 		plc |= PORT_LINK_MODE_1_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
 	case 2:
 		plc |= PORT_LINK_MODE_2_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_2_LANES;
 		break;
 	case 4:
 		plc |= PORT_LINK_MODE_4_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_4_LANES;
 		break;
 	case 8:
 		plc |= PORT_LINK_MODE_8_LANES;
-		lwsc |= PORT_LOGIC_LINK_WIDTH_8_LANES;
 		break;
 	default:
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index ddc65368e77d..16725f9536f6 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -585,6 +585,9 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	list_add_tail(&port->entry, &pcie->ports);
 	init_completion(&pcie->event);
 
+	/* In the success path, we keep a reference to np around */
+	of_node_get(np);
+
 	ret = apple_pcie_port_register_irqs(port);
 	WARN_ON(ret);
 
@@ -764,7 +767,6 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *platform = to_platform_device(dev);
-	struct device_node *of_port;
 	struct apple_pcie *pcie;
 	int ret;
 
@@ -787,11 +789,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	if (ret)
 		return ret;
 
-	for_each_child_of_node(dev->of_node, of_port) {
+	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
 			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
-			of_node_put(of_port);
 			return ret;
 		}
 	}
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 3a39e167bdbf..d62fea0fbdfc 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -85,7 +85,7 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
 }
 
 static int pkey_ioctl_genseck(struct pkey_genseck __user *ugs)
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 21f22e913cd0..8a44e01ebf9b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5910,7 +5910,11 @@ megasas_set_high_iops_queue_affinity_and_hint(struct megasas_instance *instance)
 	const struct cpumask *mask;
 
 	if (instance->perf_mode == MR_BALANCED_PERF_MODE) {
-		mask = cpumask_of_node(dev_to_node(&instance->pdev->dev));
+		int nid = dev_to_node(&instance->pdev->dev);
+
+		if (nid == NUMA_NO_NODE)
+			nid = 0;
+		mask = cpumask_of_node(nid);
 
 		for (i = 0; i < instance->low_latency_index_start; i++) {
 			irq = pci_irq_vector(instance->pdev, i);
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index f9463f263fba..12f8073cb596 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1929,10 +1929,10 @@ static int cqspi_probe(struct platform_device *pdev)
 			goto probe_setup_failed;
 	}
 
-	ret = devm_pm_runtime_enable(dev);
-	if (ret) {
-		if (cqspi->rx_chan)
-			dma_release_channel(cqspi->rx_chan);
+	pm_runtime_enable(dev);
+
+	if (cqspi->rx_chan) {
+		dma_release_channel(cqspi->rx_chan);
 		goto probe_setup_failed;
 	}
 
@@ -1952,6 +1952,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	return 0;
 probe_setup_failed:
 	cqspi_controller_enable(cqspi, 0);
+	pm_runtime_disable(dev);
 probe_reset_failed:
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
@@ -1970,7 +1971,8 @@ static void cqspi_remove(struct platform_device *pdev)
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	clk_disable_unprepare(cqspi->clk);
+	if (pm_runtime_get_sync(&pdev->dev) >= 0)
+		clk_disable(cqspi->clk);
 
 	if (cqspi->is_jh7110)
 		cqspi_jh7110_disable_clk(pdev, cqspi);
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79bac30e79af..21e357966d2a 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -839,6 +839,19 @@ static const struct spi_controller_mem_ops fsl_qspi_mem_ops = {
 	.get_name = fsl_qspi_get_name,
 };
 
+static void fsl_qspi_cleanup(void *data)
+{
+	struct fsl_qspi *q = data;
+
+	/* disable the hardware */
+	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
+	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
+
+	fsl_qspi_clk_disable_unprep(q);
+
+	mutex_destroy(&q->lock);
+}
+
 static int fsl_qspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -928,15 +941,16 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
+	ret = devm_add_action_or_reset(dev, fsl_qspi_cleanup, q);
+	if (ret)
+		goto err_put_ctrl;
+
 	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret)
-		goto err_destroy_mutex;
+		goto err_put_ctrl;
 
 	return 0;
 
-err_destroy_mutex:
-	mutex_destroy(&q->lock);
-
 err_disable_clk:
 	fsl_qspi_clk_disable_unprep(q);
 
@@ -947,19 +961,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static void fsl_qspi_remove(struct platform_device *pdev)
-{
-	struct fsl_qspi *q = platform_get_drvdata(pdev);
-
-	/* disable the hardware */
-	qspi_writel(q, QUADSPI_MCR_MDIS_MASK, q->iobase + QUADSPI_MCR);
-	qspi_writel(q, 0x0, q->iobase + QUADSPI_RSER);
-
-	fsl_qspi_clk_disable_unprep(q);
-
-	mutex_destroy(&q->lock);
-}
-
 static int fsl_qspi_suspend(struct device *dev)
 {
 	return 0;
@@ -997,7 +998,6 @@ static struct platform_driver fsl_qspi_driver = {
 		.pm =   &fsl_qspi_pm_ops,
 	},
 	.probe          = fsl_qspi_probe,
-	.remove_new	= fsl_qspi_remove,
 };
 module_platform_driver(fsl_qspi_driver);
 
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 1e9eff01b1aa..e9f382c280d9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -868,29 +868,21 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
 		num_blocks, payload_index;
 
 	u8 pn_vector[6];
-	u8 mic_iv[16];
-	u8 mic_header1[16];
-	u8 mic_header2[16];
-	u8 ctr_preload[16];
+	u8 mic_iv[16] = {};
+	u8 mic_header1[16] = {};
+	u8 mic_header2[16] = {};
+	u8 ctr_preload[16] = {};
 
 	/* Intermediate Buffers */
-	u8 chain_buffer[16];
-	u8 aes_out[16];
-	u8 padded_buffer[16];
+	u8 chain_buffer[16] = {};
+	u8 aes_out[16] = {};
+	u8 padded_buffer[16] = {};
 	u8 mic[8];
 	uint	frtype  = GetFrameType(pframe);
 	uint	frsubtype  = GetFrameSubType(pframe);
 
 	frsubtype = frsubtype>>4;
 
-	memset((void *)mic_iv, 0, 16);
-	memset((void *)mic_header1, 0, 16);
-	memset((void *)mic_header2, 0, 16);
-	memset((void *)ctr_preload, 0, 16);
-	memset((void *)chain_buffer, 0, 16);
-	memset((void *)aes_out, 0, 16);
-	memset((void *)padded_buffer, 0, 16);
-
 	if ((hdrlen == WLAN_HDR_A3_LEN) || (hdrlen ==  WLAN_HDR_A3_QOS_LEN))
 		a4_exists = 0;
 	else
@@ -1080,15 +1072,15 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 			num_blocks, payload_index;
 	signed int res = _SUCCESS;
 	u8 pn_vector[6];
-	u8 mic_iv[16];
-	u8 mic_header1[16];
-	u8 mic_header2[16];
-	u8 ctr_preload[16];
+	u8 mic_iv[16] = {};
+	u8 mic_header1[16] = {};
+	u8 mic_header2[16] = {};
+	u8 ctr_preload[16] = {};
 
 		/* Intermediate Buffers */
-	u8 chain_buffer[16];
-	u8 aes_out[16];
-	u8 padded_buffer[16];
+	u8 chain_buffer[16] = {};
+	u8 aes_out[16] = {};
+	u8 padded_buffer[16] = {};
 	u8 mic[8];
 
 	uint frtype  = GetFrameType(pframe);
@@ -1096,14 +1088,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
 	frsubtype = frsubtype>>4;
 
-	memset((void *)mic_iv, 0, 16);
-	memset((void *)mic_header1, 0, 16);
-	memset((void *)mic_header2, 0, 16);
-	memset((void *)ctr_preload, 0, 16);
-	memset((void *)chain_buffer, 0, 16);
-	memset((void *)aes_out, 0, 16);
-	memset((void *)padded_buffer, 0, 16);
-
 	/* start to decrypt the payload */
 
 	num_blocks = (plen-8) / 16; /* plen including LLC, payload_length and mic) */
diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index f462b3d1c104..d6b01e015a96 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -115,6 +115,7 @@
 
 #define UART_RESET_REG				0x94
 #define UART_RESET_D3_RESET_DISABLE		BIT(16)
+#define UART_RESET_HOT_RESET_DISABLE		BIT(17)
 
 #define UART_BURST_STATUS_REG			0x9C
 #define UART_TX_BURST_FIFO			0xA0
@@ -620,6 +621,10 @@ static int pci1xxxx_suspend(struct device *dev)
 	}
 
 	data = readl(p + UART_RESET_REG);
+
+	if (priv->dev_rev >= 0xC0)
+		data |= UART_RESET_HOT_RESET_DISABLE;
+
 	writel(data | UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
 
 	if (wakeup)
@@ -647,7 +652,12 @@ static int pci1xxxx_resume(struct device *dev)
 	}
 
 	data = readl(p + UART_RESET_REG);
+
+	if (priv->dev_rev >= 0xC0)
+		data &= ~UART_RESET_HOT_RESET_DISABLE;
+
 	writel(data & ~UART_RESET_D3_RESET_DISABLE, p + UART_RESET_REG);
+
 	iounmap(p);
 
 	for (i = 0; i < priv->nr; i++) {
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8e3b15534bc7..deb9635cb48d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -233,6 +233,7 @@ struct imx_port {
 	enum imx_tx_state	tx_state;
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
+	unsigned int		rxtl;
 };
 
 struct imx_port_ucrs {
@@ -1328,6 +1329,7 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
 
 #define TXTL_DEFAULT 8
 #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
+#define RXTL_CONSOLE_DEFAULT 1
 #define TXTL_DMA 8 /* DMA burst setting */
 #define RXTL_DMA 9 /* DMA burst setting */
 
@@ -1445,7 +1447,7 @@ static void imx_uart_disable_dma(struct imx_port *sport)
 	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	sport->dma_is_enabled = 0;
 }
@@ -1470,7 +1472,12 @@ static int imx_uart_startup(struct uart_port *port)
 		return retval;
 	}
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	if (uart_console(&sport->port))
+		sport->rxtl = RXTL_CONSOLE_DEFAULT;
+	else
+		sport->rxtl = RXTL_DEFAULT;
+
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	/* disable the DREN bit (Data Ready interrupt enable) before
 	 * requesting IRQs
@@ -1936,7 +1943,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 	if (retval)
 		clk_disable_unprepare(sport->clk_ipg);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	uart_port_lock_irqsave(&sport->port, &flags);
 
@@ -2028,7 +2035,7 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 		/* If the receiver trigger is 0, set it to a default value */
 		ufcr = imx_uart_readl(sport, UFCR);
 		if ((ufcr & UFCR_RXTL_MASK) == 0)
-			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 		imx_uart_start_rx(port);
 	}
 
@@ -2213,7 +2220,7 @@ imx_uart_console_setup(struct console *co, char *options)
 	else
 		imx_uart_console_get_options(sport, &baud, &parity, &bits);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
index 5d1677f1b651..cb3b127b06b6 100644
--- a/drivers/tty/serial/serial_base_bus.c
+++ b/drivers/tty/serial/serial_base_bus.c
@@ -72,6 +72,7 @@ static int serial_base_device_init(struct uart_port *port,
 	dev->parent = parent_dev;
 	dev->bus = &serial_base_bus_type;
 	dev->release = release;
+	device_set_of_node_from_dev(dev, parent_dev);
 
 	if (!serial_base_initialized) {
 		dev_dbg(port->dev, "uart_add_one_port() called before arch_initcall()?\n");
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 68357ac8ffe3..71890f3244a0 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -880,16 +880,6 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	if (!ulite_uart_driver.state) {
-		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
-		ret = uart_register_driver(&ulite_uart_driver);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
-			clk_disable_unprepare(pdata->clk);
-			return ret;
-		}
-	}
-
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
@@ -929,16 +919,25 @@ static struct platform_driver ulite_platform_driver = {
 
 static int __init ulite_init(void)
 {
+	int ret;
+
+	pr_debug("uartlite: calling uart_register_driver()\n");
+	ret = uart_register_driver(&ulite_uart_driver);
+	if (ret)
+		return ret;
 
 	pr_debug("uartlite: calling platform_driver_register()\n");
-	return platform_driver_register(&ulite_platform_driver);
+	ret = platform_driver_register(&ulite_platform_driver);
+	if (ret)
+		uart_unregister_driver(&ulite_uart_driver);
+
+	return ret;
 }
 
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	if (ulite_uart_driver.state)
-		uart_unregister_driver(&ulite_uart_driver);
+	uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 374f505fec3d..a6299cb19237 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1392,6 +1392,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba, u64 timeout_us)
 	 * make sure that there are no outstanding requests when
 	 * clock scaling is in progress
 	 */
+	mutex_lock(&hba->host->scan_mutex);
 	blk_mq_quiesce_tagset(&hba->host->tag_set);
 	mutex_lock(&hba->wb_mutex);
 	down_write(&hba->clk_scaling_lock);
@@ -1402,6 +1403,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba, u64 timeout_us)
 		up_write(&hba->clk_scaling_lock);
 		mutex_unlock(&hba->wb_mutex);
 		blk_mq_unquiesce_tagset(&hba->host->tag_set);
+		mutex_unlock(&hba->host->scan_mutex);
 		goto out;
 	}
 
@@ -1423,6 +1425,7 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, int err, bool sc
 	mutex_unlock(&hba->wb_mutex);
 
 	blk_mq_unquiesce_tagset(&hba->host->tag_set);
+	mutex_unlock(&hba->host->scan_mutex);
 	ufshcd_release(hba);
 }
 
@@ -7740,7 +7743,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, ULONG_MAX, true);
+	if (ufshcd_is_clkscaling_supported(hba))
+		ufshcd_scale_clks(hba, ULONG_MAX, true);
 
 	err = ufshcd_hba_enable(hba);
 
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 16e7fa4d488d..ecd6d1f39e49 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -92,7 +92,6 @@ struct wdm_device {
 	u16			wMaxCommand;
 	u16			wMaxPacketSize;
 	__le16			inum;
-	int			reslength;
 	int			length;
 	int			read;
 	int			count;
@@ -214,6 +213,11 @@ static void wdm_in_callback(struct urb *urb)
 	if (desc->rerr == 0 && status != -EPIPE)
 		desc->rerr = status;
 
+	if (length == 0) {
+		dev_dbg(&desc->intf->dev, "received ZLP\n");
+		goto skip_zlp;
+	}
+
 	if (length + desc->length > desc->wMaxCommand) {
 		/* The buffer would overflow */
 		set_bit(WDM_OVERFLOW, &desc->flags);
@@ -222,18 +226,18 @@ static void wdm_in_callback(struct urb *urb)
 		if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
 			memmove(desc->ubuf + desc->length, desc->inbuf, length);
 			desc->length += length;
-			desc->reslength = length;
 		}
 	}
 skip_error:
 
 	if (desc->rerr) {
 		/*
-		 * Since there was an error, userspace may decide to not read
-		 * any data after poll'ing.
+		 * If there was a ZLP or an error, userspace may decide to not
+		 * read any data after poll'ing.
 		 * We should respond to further attempts from the device to send
 		 * data, so that we can get unstuck.
 		 */
+skip_zlp:
 		schedule_work(&desc->service_outs_intr);
 	} else {
 		set_bit(WDM_READ, &desc->flags);
@@ -585,15 +589,6 @@ static ssize_t wdm_read
 			goto retry;
 		}
 
-		if (!desc->reslength) { /* zero length read */
-			dev_dbg(&desc->intf->dev, "zero length - clearing WDM_READ\n");
-			clear_bit(WDM_READ, &desc->flags);
-			rv = service_outstanding_interrupt(desc);
-			spin_unlock_irq(&desc->iuspin);
-			if (rv < 0)
-				goto err;
-			goto retry;
-		}
 		cntr = desc->length;
 		spin_unlock_irq(&desc->iuspin);
 	}
@@ -1016,7 +1011,7 @@ static void service_interrupt_work(struct work_struct *work)
 
 	spin_lock_irq(&desc->iuspin);
 	service_outstanding_interrupt(desc);
-	if (!desc->resp_count) {
+	if (!desc->resp_count && (desc->length || desc->rerr)) {
 		set_bit(WDM_READ, &desc->flags);
 		wake_up(&desc->wait);
 	}
diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 501e8bc9738e..1096a884c8d7 100644
--- a/drivers/usb/common/usb-conn-gpio.c
+++ b/drivers/usb/common/usb-conn-gpio.c
@@ -20,6 +20,9 @@
 #include <linux/power_supply.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/role.h>
+#include <linux/idr.h>
+
+static DEFINE_IDA(usb_conn_ida);
 
 #define USB_GPIO_DEB_MS		20	/* ms */
 #define USB_GPIO_DEB_US		((USB_GPIO_DEB_MS) * 1000)	/* us */
@@ -29,6 +32,7 @@
 
 struct usb_conn_info {
 	struct device *dev;
+	int conn_id; /* store the IDA-allocated ID */
 	struct usb_role_switch *role_sw;
 	enum usb_role last_role;
 	struct regulator *vbus;
@@ -160,7 +164,17 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
 		.of_node = dev->of_node,
 	};
 
-	desc->name = "usb-charger";
+	info->conn_id = ida_alloc(&usb_conn_ida, GFP_KERNEL);
+	if (info->conn_id < 0)
+		return info->conn_id;
+
+	desc->name = devm_kasprintf(dev, GFP_KERNEL, "usb-charger-%d",
+				    info->conn_id);
+	if (!desc->name) {
+		ida_free(&usb_conn_ida, info->conn_id);
+		return -ENOMEM;
+	}
+
 	desc->properties = usb_charger_properties;
 	desc->num_properties = ARRAY_SIZE(usb_charger_properties);
 	desc->get_property = usb_charger_get_property;
@@ -168,8 +182,10 @@ static int usb_conn_psy_register(struct usb_conn_info *info)
 	cfg.drv_data = info;
 
 	info->charger = devm_power_supply_register(dev, desc, &cfg);
-	if (IS_ERR(info->charger))
-		dev_err(dev, "Unable to register charger\n");
+	if (IS_ERR(info->charger)) {
+		dev_err(dev, "Unable to register charger %d\n", info->conn_id);
+		ida_free(&usb_conn_ida, info->conn_id);
+	}
 
 	return PTR_ERR_OR_ZERO(info->charger);
 }
@@ -277,6 +293,9 @@ static void usb_conn_remove(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&info->dw_det);
 
+	if (info->charger)
+		ida_free(&usb_conn_ida, info->conn_id);
+
 	if (info->last_role == USB_ROLE_HOST && info->vbus)
 		regulator_disable(info->vbus);
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0b4685aad2d5..118fa4c93a79 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -695,15 +695,16 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 		device_set_of_node_from_dev(&dev->dev, bus->sysdev);
 		dev_set_name(&dev->dev, "usb%d", bus->busnum);
 	} else {
+		int n;
+
 		/* match any labeling on the hubs; it's one-based */
 		if (parent->devpath[0] == '0') {
-			snprintf(dev->devpath, sizeof dev->devpath,
-				"%d", port1);
+			n = snprintf(dev->devpath, sizeof(dev->devpath), "%d", port1);
 			/* Root ports are not counted in route string */
 			dev->route = 0;
 		} else {
-			snprintf(dev->devpath, sizeof dev->devpath,
-				"%s.%d", parent->devpath, port1);
+			n = snprintf(dev->devpath, sizeof(dev->devpath), "%s.%d",
+				     parent->devpath, port1);
 			/* Route string assumes hubs have less than 16 ports */
 			if (port1 < 15)
 				dev->route = parent->route +
@@ -712,6 +713,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 				dev->route = parent->route +
 					(15 << ((parent->level - 1)*4));
 		}
+		if (n >= sizeof(dev->devpath)) {
+			usb_put_hcd(bus_to_hcd(bus));
+			usb_put_dev(dev);
+			return NULL;
+		}
 
 		dev->dev.parent = &parent->dev;
 		dev_set_name(&dev->dev, "%d-%s", bus->busnum, dev->devpath);
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index bd4c788f03bc..d3d0d75ab1f5 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4604,6 +4604,12 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	if (!hsotg)
 		return -ENODEV;
 
+	/* Exit clock gating when driver is stopped. */
+	if (hsotg->params.power_down == DWC2_POWER_DOWN_PARAM_NONE &&
+	    hsotg->bus_suspended && !hsotg->params.no_clock_gating) {
+		dwc2_gadget_exit_clock_gating(hsotg, 0);
+	}
+
 	/* all endpoints should be shutdown */
 	for (ep = 1; ep < hsotg->num_of_eps; ep++) {
 		if (hsotg->eps_in[ep])
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index c7a05f842745..d8bd2d82e9ec 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -75,6 +75,7 @@ struct f_hidg {
 	/* recv report */
 	spinlock_t			read_spinlock;
 	wait_queue_head_t		read_queue;
+	bool				disabled;
 	/* recv report - interrupt out only (use_out_ep == 1) */
 	struct list_head		completed_out_req;
 	unsigned int			qlen;
@@ -329,7 +330,7 @@ static ssize_t f_hidg_intout_read(struct file *file, char __user *buffer,
 
 	spin_lock_irqsave(&hidg->read_spinlock, flags);
 
-#define READ_COND_INTOUT (!list_empty(&hidg->completed_out_req))
+#define READ_COND_INTOUT (!list_empty(&hidg->completed_out_req) || hidg->disabled)
 
 	/* wait for at least one buffer to complete */
 	while (!READ_COND_INTOUT) {
@@ -343,6 +344,11 @@ static ssize_t f_hidg_intout_read(struct file *file, char __user *buffer,
 		spin_lock_irqsave(&hidg->read_spinlock, flags);
 	}
 
+	if (hidg->disabled) {
+		spin_unlock_irqrestore(&hidg->read_spinlock, flags);
+		return -ESHUTDOWN;
+	}
+
 	/* pick the first one */
 	list = list_first_entry(&hidg->completed_out_req,
 				struct f_hidg_req_list, list);
@@ -387,7 +393,7 @@ static ssize_t f_hidg_intout_read(struct file *file, char __user *buffer,
 	return count;
 }
 
-#define READ_COND_SSREPORT (hidg->set_report_buf != NULL)
+#define READ_COND_SSREPORT (hidg->set_report_buf != NULL || hidg->disabled)
 
 static ssize_t f_hidg_ssreport_read(struct file *file, char __user *buffer,
 				    size_t count, loff_t *ptr)
@@ -1012,6 +1018,11 @@ static void hidg_disable(struct usb_function *f)
 	}
 	spin_unlock_irqrestore(&hidg->get_report_spinlock, flags);
 
+	spin_lock_irqsave(&hidg->read_spinlock, flags);
+	hidg->disabled = true;
+	spin_unlock_irqrestore(&hidg->read_spinlock, flags);
+	wake_up(&hidg->read_queue);
+
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
 	if (!hidg->write_pending) {
 		free_ep_req(hidg->in_ep, hidg->req);
@@ -1097,6 +1108,10 @@ static int hidg_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 		}
 	}
 
+	spin_lock_irqsave(&hidg->read_spinlock, flags);
+	hidg->disabled = false;
+	spin_unlock_irqrestore(&hidg->read_spinlock, flags);
+
 	if (hidg->in_ep != NULL) {
 		spin_lock_irqsave(&hidg->write_spinlock, flags);
 		hidg->req = req_in;
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 7b23631f4744..6ad205046032 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1297,14 +1297,14 @@ static struct se_portal_group *usbg_make_tpg(struct se_wwn *wwn,
 	struct usbg_tport *tport = container_of(wwn, struct usbg_tport,
 			tport_wwn);
 	struct usbg_tpg *tpg;
-	unsigned long tpgt;
+	u16 tpgt;
 	int ret;
 	struct f_tcm_opts *opts;
 	unsigned i;
 
 	if (strstr(name, "tpgt_") != name)
 		return ERR_PTR(-EINVAL);
-	if (kstrtoul(name + 5, 0, &tpgt) || tpgt > UINT_MAX)
+	if (kstrtou16(name + 5, 0, &tpgt))
 		return ERR_PTR(-EINVAL);
 	ret = -ENODEV;
 	mutex_lock(&tpg_instances_lock);
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 92cc1b136120..4976a7238b28 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -393,6 +393,10 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 		break;
 	case CMDT_RSP_NAK:
 		switch (cmd) {
+		case DP_CMD_STATUS_UPDATE:
+			if (typec_altmode_exit(alt))
+				dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
+			break;
 		case DP_CMD_CONFIGURE:
 			dp->data.conf = 0;
 			ret = dp_altmode_configured(dp);
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 49926d6e72c7..182c902c42f6 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -214,7 +214,7 @@ int typec_switch_set(struct typec_switch *sw,
 		sw_dev = sw->sw_devs[i];
 
 		ret = sw_dev->set(sw_dev, orientation);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 
@@ -378,7 +378,7 @@ int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 		mux_dev = mux->mux_devs[i];
 
 		ret = mux_dev->set(mux_dev, state);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 1d8e760df483..9838a2c8c1b8 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5566,8 +5566,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB,
 						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
-		tcpm_set_state(port, hard_reset_state(port),
-			       PD_T_PS_SOURCE_OFF);
+		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_OFF);
 		break;
 	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		tcpm_enable_auto_vbus_discharge(port, true);
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index e8c22cccb5c1..7dfcc9351bce 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -427,8 +427,8 @@ struct btrfs_backref_node *btrfs_backref_alloc_node(
 struct btrfs_backref_edge *btrfs_backref_alloc_edge(
 		struct btrfs_backref_cache *cache);
 
-#define		LINK_LOWER	(1 << 0)
-#define		LINK_UPPER	(1 << 1)
+#define		LINK_LOWER	(1U << 0)
+#define		LINK_UPPER	(1U << 1)
 
 void btrfs_backref_link_edge(struct btrfs_backref_edge *edge,
 			     struct btrfs_backref_node *lower,
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index bd38df5647e3..71984d7db839 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -151,8 +151,8 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	}
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, file_extent,
-					     (1 << type) |
-					     (1 << BTRFS_ORDERED_DIRECT));
+					     (1U << type) |
+					     (1U << BTRFS_ORDERED_DIRECT));
 	if (IS_ERR(ordered)) {
 		if (em) {
 			free_extent_map(em);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 147c50ef912a..e655fa3bfd9b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2168,8 +2168,7 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		found = true;
 		root = read_tree_root_path(tree_root, path, &key);
 		if (IS_ERR(root)) {
-			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
-				ret = PTR_ERR(root);
+			ret = PTR_ERR(root);
 			break;
 		}
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
@@ -2786,6 +2785,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_init_scrub(fs_info);
 	btrfs_init_balance(fs_info);
 	btrfs_init_async_reclaim_work(fs_info);
+	btrfs_init_extent_map_shrinker_work(fs_info);
 
 	rwlock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
@@ -4335,6 +4335,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
 	cancel_work_sync(&fs_info->preempt_reclaim_work);
+	cancel_work_sync(&fs_info->extent_map_shrinker_work);
 
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index fcb60837d7dc..039a73731135 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -79,7 +79,7 @@ enum {
  *    single word in a bitmap may straddle two pages in the extent buffer.
  */
 #define BIT_BYTE(nr) ((nr) / BITS_PER_BYTE)
-#define BYTE_MASK ((1 << BITS_PER_BYTE) - 1)
+#define BYTE_MASK ((1U << BITS_PER_BYTE) - 1)
 #define BITMAP_FIRST_BYTE_MASK(start) \
 	((BYTE_MASK << ((start) & (BITS_PER_BYTE - 1))) & BYTE_MASK)
 #define BITMAP_LAST_BYTE_MASK(nbits) \
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 1d93e1202c33..36af9aa9aab1 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1128,11 +1128,14 @@ struct btrfs_em_shrink_ctx {
 
 static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_ctx *ctx)
 {
-	const u64 cur_fs_gen = btrfs_get_fs_generation(inode->root->fs_info);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u64 cur_fs_gen = btrfs_get_fs_generation(fs_info);
 	struct extent_map_tree *tree = &inode->extent_tree;
 	long nr_dropped = 0;
 	struct rb_node *node;
 
+	lockdep_assert_held_write(&tree->lock);
+
 	/*
 	 * Take the mmap lock so that we serialize with the inode logging phase
 	 * of fsync because we may need to set the full sync flag on the inode,
@@ -1144,28 +1147,12 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 	 * to find new extents, which may not be there yet because ordered
 	 * extents haven't completed yet.
 	 *
-	 * We also do a try lock because otherwise we could deadlock. This is
-	 * because the shrinker for this filesystem may be invoked while we are
-	 * in a path that is holding the mmap lock in write mode. For example in
-	 * a reflink operation while COWing an extent buffer, when allocating
-	 * pages for a new extent buffer and under memory pressure, the shrinker
-	 * may be invoked, and therefore we would deadlock by attempting to read
-	 * lock the mmap lock while we are holding already a write lock on it.
+	 * We also do a try lock because we don't want to block for too long and
+	 * we are holding the extent map tree's lock in write mode.
 	 */
 	if (!down_read_trylock(&inode->i_mmap_lock))
 		return 0;
 
-	/*
-	 * We want to be fast so if the lock is busy we don't want to spend time
-	 * waiting for it - either some task is about to do IO for the inode or
-	 * we may have another task shrinking extent maps, here in this code, so
-	 * skip this inode.
-	 */
-	if (!write_trylock(&tree->lock)) {
-		up_read(&inode->i_mmap_lock);
-		return 0;
-	}
-
 	node = rb_first(&tree->root);
 	while (node) {
 		struct rb_node *next = rb_next(node);
@@ -1201,36 +1188,89 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 		 * lock. This is to avoid slowing other tasks trying to take the
 		 * lock.
 		 */
-		if (need_resched() || rwlock_needbreak(&tree->lock))
+		if (need_resched() || rwlock_needbreak(&tree->lock) ||
+		    btrfs_fs_closing(fs_info))
 			break;
 		node = next;
 	}
-	write_unlock(&tree->lock);
 	up_read(&inode->i_mmap_lock);
 
 	return nr_dropped;
 }
 
+static struct btrfs_inode *find_first_inode_to_shrink(struct btrfs_root *root,
+						      u64 min_ino)
+{
+	struct btrfs_inode *inode;
+	unsigned long from = min_ino;
+
+	xa_lock(&root->inodes);
+	while (true) {
+		struct extent_map_tree *tree;
+
+		inode = xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);
+		if (!inode)
+			break;
+
+		tree = &inode->extent_tree;
+
+		/*
+		 * We want to be fast so if the lock is busy we don't want to
+		 * spend time waiting for it (some task is about to do IO for
+		 * the inode).
+		 */
+		if (!write_trylock(&tree->lock))
+			goto next;
+
+		/*
+		 * Skip inode if it doesn't have loaded extent maps, so we avoid
+		 * getting a reference and doing an iput later. This includes
+		 * cases like files that were opened for things like stat(2), or
+		 * files with all extent maps previously released through the
+		 * release folio callback (btrfs_release_folio()) or released in
+		 * a previous run, or directories which never have extent maps.
+		 */
+		if (RB_EMPTY_ROOT(&tree->root)) {
+			write_unlock(&tree->lock);
+			goto next;
+		}
+
+		if (igrab(&inode->vfs_inode))
+			break;
+
+		write_unlock(&tree->lock);
+next:
+		from = btrfs_ino(inode) + 1;
+		cond_resched_lock(&root->inodes.xa_lock);
+	}
+	xa_unlock(&root->inodes);
+
+	return inode;
+}
+
 static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx *ctx)
 {
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_inode *inode;
 	long nr_dropped = 0;
 	u64 min_ino = ctx->last_ino + 1;
 
-	inode = btrfs_find_first_inode(root, min_ino);
+	inode = find_first_inode_to_shrink(root, min_ino);
 	while (inode) {
 		nr_dropped += btrfs_scan_inode(inode, ctx);
+		write_unlock(&inode->extent_tree.lock);
 
 		min_ino = btrfs_ino(inode) + 1;
 		ctx->last_ino = btrfs_ino(inode);
-		btrfs_add_delayed_iput(inode);
+		iput(&inode->vfs_inode);
 
-		if (ctx->scanned >= ctx->nr_to_scan)
+		if (ctx->scanned >= ctx->nr_to_scan ||
+		    btrfs_fs_closing(fs_info))
 			break;
 
 		cond_resched();
 
-		inode = btrfs_find_first_inode(root, min_ino);
+		inode = find_first_inode_to_shrink(root, min_ino);
 	}
 
 	if (inode) {
@@ -1254,16 +1294,19 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 	return nr_dropped;
 }
 
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
 {
+	struct btrfs_fs_info *fs_info;
 	struct btrfs_em_shrink_ctx ctx;
 	u64 start_root_id;
 	u64 next_root_id;
 	bool cycled = false;
 	long nr_dropped = 0;
 
+	fs_info = container_of(work, struct btrfs_fs_info, extent_map_shrinker_work);
+
 	ctx.scanned = 0;
-	ctx.nr_to_scan = nr_to_scan;
+	ctx.nr_to_scan = atomic64_read(&fs_info->extent_map_shrinker_nr_to_scan);
 
 	/*
 	 * In case we have multiple tasks running this shrinker, make the next
@@ -1281,12 +1324,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
 		s64 nr = percpu_counter_sum_positive(&fs_info->evictable_extent_maps);
 
-		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan,
+		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx.nr_to_scan,
 							   nr, ctx.last_root,
 							   ctx.last_ino);
 	}
 
-	while (ctx.scanned < ctx.nr_to_scan) {
+	while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info)) {
 		struct btrfs_root *root;
 		unsigned long count;
 
@@ -1344,5 +1387,34 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 							  ctx.last_ino);
 	}
 
-	return nr_dropped;
+	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
+}
+
+void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+{
+	/*
+	 * Do nothing if the shrinker is already running. In case of high memory
+	 * pressure we can have a lot of tasks calling us and all passing the
+	 * same nr_to_scan value, but in reality we may need only to free
+	 * nr_to_scan extent maps (or less). In case we need to free more than
+	 * that, we will be called again by the fs shrinker, so no worries about
+	 * not doing enough work to reclaim memory from extent maps.
+	 * We can also be repeatedly called with the same nr_to_scan value
+	 * simply because the shrinker runs asynchronously and multiple calls
+	 * to this function are made before the shrinker does enough progress.
+	 *
+	 * That's why we set the atomic counter to nr_to_scan only if its
+	 * current value is zero, instead of incrementing the counter by
+	 * nr_to_scan.
+	 */
+	if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, 0, nr_to_scan) != 0)
+		return;
+
+	queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_work);
+}
+
+void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)
+{
+	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
+	INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_shrinker_worker);
 }
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 5154a8f1d26c..cd123b266b64 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -189,6 +189,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 				   struct extent_map *new_em,
 				   bool modified);
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
+void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
+void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bb822e425d7f..374843aca60d 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -639,6 +639,8 @@ struct btrfs_fs_info {
 	spinlock_t extent_map_shrinker_lock;
 	u64 extent_map_shrinker_last_root;
 	u64 extent_map_shrinker_last_ino;
+	atomic64_t extent_map_shrinker_nr_to_scan;
+	struct work_struct extent_map_shrinker_work;
 
 	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1ab5b0c1b9b7..921ec3802648 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1249,7 +1249,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-					     1 << BTRFS_ORDERED_COMPRESSED);
+					     1U << BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
@@ -1408,6 +1408,17 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
 
+	/*
+	 * We're not doing compressed IO, don't unlock the first page (which
+	 * the caller expects to stay locked), don't clear any dirty bits and
+	 * don't set any writeback bits.
+	 *
+	 * Do set the Ordered (Private2) bit so we know this page was properly
+	 * setup for writepage.
+	 */
+	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
+	page_ops |= PAGE_SET_ORDERED;
+
 	/*
 	 * Relocation relies on the relocated extents to have exactly the same
 	 * size as the original extents. Normally writeback for relocation data
@@ -1452,8 +1463,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				continue;
 			}
 			if (done_offset) {
-				*done_offset = start - 1;
-				return 0;
+				/*
+				 * Move @end to the end of the processed range,
+				 * and exit the loop to unlock the processed extents.
+				 */
+				end = start - 1;
+				ret = 0;
+				break;
 			}
 			ret = -ENOSPC;
 		}
@@ -1470,6 +1486,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		file_extent.offset = 0;
 		file_extent.compression = BTRFS_COMPRESS_NONE;
 
+		/*
+		 * Locked range will be released either during error clean up or
+		 * after the whole range is finished.
+		 */
 		lock_extent(&inode->io_tree, start, start + ram_size - 1,
 			    &cached);
 
@@ -1484,7 +1504,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		free_extent_map(em);
 
 		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-						     1 << BTRFS_ORDERED_REGULAR);
+						     1U << BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(ordered)) {
 			unlock_extent(&inode->io_tree, start,
 				      start + ram_size - 1, &cached);
@@ -1515,27 +1535,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
-		/*
-		 * We're not doing compressed IO, don't unlock the first page
-		 * (which the caller expects to stay locked), don't clear any
-		 * dirty bits and don't set any writeback bits
-		 *
-		 * Do set the Ordered (Private2) bit so we know this page was
-		 * properly setup for writepage.
-		 */
-		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
-		page_ops |= PAGE_SET_ORDERED;
-
-		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
-					     locked_folio, &cached,
-					     EXTENT_LOCKED | EXTENT_DELALLOC,
-					     page_ops);
-		if (num_bytes < cur_alloc_size)
+		if (num_bytes < ram_size)
 			num_bytes = 0;
 		else
-			num_bytes -= cur_alloc_size;
+			num_bytes -= ram_size;
 		alloc_hint = ins.objectid + ins.offset;
-		start += cur_alloc_size;
+		start += ram_size;
 		extent_reserved = false;
 
 		/*
@@ -1546,6 +1551,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
+	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC, page_ops);
 done:
 	if (done_offset)
 		*done_offset = end;
@@ -1561,40 +1568,35 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * Now, we have three regions to clean up:
 	 *
 	 * |-------(1)----|---(2)---|-------------(3)----------|
-	 * `- orig_start  `- start  `- start + cur_alloc_size  `- end
+	 * `- orig_start  `- start  `- start + ram_size  `- end
 	 *
 	 * We process each region below.
 	 */
 
-	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
-	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
-
 	/*
 	 * For the range (1). We have already instantiated the ordered extents
 	 * for this region. They are cleaned up by
 	 * btrfs_cleanup_ordered_extents() in e.g,
-	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
-	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
-	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
-	 * function.
+	 * btrfs_run_delalloc_range().
+	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
+	 * are also handled by the cleanup function.
 	 *
-	 * However, in case of @keep_locked, we still need to unlock the pages
-	 * (except @locked_folio) to ensure all the pages are unlocked.
+	 * So here we only clear EXTENT_LOCKED and EXTENT_DELALLOC flag, and
+	 * finish the writeback of the involved folios, which will be never submitted.
 	 */
-	if (keep_locked && orig_start < start) {
+	if (orig_start < start) {
+		clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC;
+		page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
+
 		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
-					     locked_folio, NULL, 0, page_ops);
+					     locked_folio, NULL, clear_bits, page_ops);
 	}
 
-	/*
-	 * At this point we're unlocked, we want to make sure we're only
-	 * clearing these flags under the extent lock, so lock the rest of the
-	 * range and clear everything up.
-	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
+	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+		     EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
+	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 
 	/*
 	 * For the range (2). If we reserved an extent for our delalloc range
@@ -1608,11 +1610,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 */
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
-					     start + cur_alloc_size - 1,
+					     start + ram_size - 1,
 					     locked_folio, &cached, clear_bits,
 					     page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
-		start += cur_alloc_size;
+		btrfs_qgroup_free_data(inode, NULL, start, ram_size, NULL);
+		start += ram_size;
 	}
 
 	/*
@@ -2055,6 +2057,63 @@ static void cleanup_dirty_folios(struct btrfs_inode *inode,
 	mapping_set_error(mapping, error);
 }
 
+static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
+			   struct extent_state **cached,
+			   struct can_nocow_file_extent_args *nocow_args,
+			   u64 file_pos, bool is_prealloc)
+{
+	struct btrfs_ordered_extent *ordered;
+	u64 len = nocow_args->file_extent.num_bytes;
+	u64 end = file_pos + len - 1;
+	int ret = 0;
+
+	lock_extent(&inode->io_tree, file_pos, end, cached);
+
+	if (is_prealloc) {
+		struct extent_map *em;
+
+		em = btrfs_create_io_em(inode, file_pos, &nocow_args->file_extent,
+					BTRFS_ORDERED_PREALLOC);
+		if (IS_ERR(em)) {
+			unlock_extent(&inode->io_tree, file_pos, end, cached);
+			return PTR_ERR(em);
+		}
+		free_extent_map(em);
+	}
+
+	ordered = btrfs_alloc_ordered_extent(inode, file_pos, &nocow_args->file_extent,
+					     is_prealloc
+					     ? (1U << BTRFS_ORDERED_PREALLOC)
+					     : (1U << BTRFS_ORDERED_NOCOW));
+	if (IS_ERR(ordered)) {
+		if (is_prealloc)
+			btrfs_drop_extent_map_range(inode, file_pos, end, false);
+		unlock_extent(&inode->io_tree, file_pos, end, cached);
+		return PTR_ERR(ordered);
+	}
+
+	if (btrfs_is_data_reloc_root(inode->root))
+		/*
+		 * Errors are handled later, as we must prevent
+		 * extent_clear_unlock_delalloc() in error handler from freeing
+		 * metadata of the created ordered extent.
+		 */
+		ret = btrfs_reloc_clone_csums(ordered);
+	btrfs_put_ordered_extent(ordered);
+
+	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC |
+				     EXTENT_CLEAR_DATA_RESV,
+				     PAGE_UNLOCK | PAGE_SET_ORDERED);
+
+	/*
+	 * btrfs_reloc_clone_csums() error, now we're OK to call error handler,
+	 * as metadata for created ordered extent will only be freed by
+	 * btrfs_finish_ordered_io().
+	 */
+	return ret;
+}
+
 /*
  * when nowcow writeback call back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
@@ -2099,15 +2158,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	while (cur_offset <= end) {
 		struct btrfs_block_group *nocow_bg = NULL;
-		struct btrfs_ordered_extent *ordered;
 		struct btrfs_key found_key;
 		struct btrfs_file_extent_item *fi;
 		struct extent_buffer *leaf;
 		struct extent_state *cached_state = NULL;
 		u64 extent_end;
-		u64 nocow_end;
 		int extent_type;
-		bool is_prealloc;
 
 		ret = btrfs_lookup_file_extent(NULL, root, path, ino,
 					       cur_offset, 0);
@@ -2242,67 +2298,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			}
 		}
 
-		nocow_end = cur_offset + nocow_args.file_extent.num_bytes - 1;
-		lock_extent(&inode->io_tree, cur_offset, nocow_end, &cached_state);
-
-		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
-		if (is_prealloc) {
-			struct extent_map *em;
-
-			em = btrfs_create_io_em(inode, cur_offset,
-						&nocow_args.file_extent,
-						BTRFS_ORDERED_PREALLOC);
-			if (IS_ERR(em)) {
-				unlock_extent(&inode->io_tree, cur_offset,
-					      nocow_end, &cached_state);
-				btrfs_dec_nocow_writers(nocow_bg);
-				ret = PTR_ERR(em);
-				goto error;
-			}
-			free_extent_map(em);
-		}
-
-		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
-				&nocow_args.file_extent,
-				is_prealloc
-				? (1 << BTRFS_ORDERED_PREALLOC)
-				: (1 << BTRFS_ORDERED_NOCOW));
+		ret = nocow_one_range(inode, locked_folio, &cached_state,
+				      &nocow_args, cur_offset,
+				      extent_type == BTRFS_FILE_EXTENT_PREALLOC);
 		btrfs_dec_nocow_writers(nocow_bg);
-		if (IS_ERR(ordered)) {
-			if (is_prealloc) {
-				btrfs_drop_extent_map_range(inode, cur_offset,
-							    nocow_end, false);
-			}
-			unlock_extent(&inode->io_tree, cur_offset,
-				      nocow_end, &cached_state);
-			ret = PTR_ERR(ordered);
+		if (ret < 0)
 			goto error;
-		}
-
-		if (btrfs_is_data_reloc_root(root))
-			/*
-			 * Error handled later, as we must prevent
-			 * extent_clear_unlock_delalloc() in error handler
-			 * from freeing metadata of created ordered extent.
-			 */
-			ret = btrfs_reloc_clone_csums(ordered);
-		btrfs_put_ordered_extent(ordered);
-
-		extent_clear_unlock_delalloc(inode, cur_offset, nocow_end,
-					     locked_folio, &cached_state,
-					     EXTENT_LOCKED | EXTENT_DELALLOC |
-					     EXTENT_CLEAR_DATA_RESV,
-					     PAGE_UNLOCK | PAGE_SET_ORDERED);
-
 		cur_offset = extent_end;
-
-		/*
-		 * btrfs_reloc_clone_csums() error, now we're OK to call error
-		 * handler, as metadata for created ordered extent will only
-		 * be freed by btrfs_finish_ordered_io().
-		 */
-		if (ret)
-			goto error;
 	}
 	btrfs_release_path(path);
 
@@ -7997,6 +7999,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	int ret;
 	int ret2;
 	bool need_abort = false;
+	bool logs_pinned = false;
 	struct fscrypt_name old_fname, new_fname;
 	struct fscrypt_str *old_name, *new_name;
 
@@ -8120,6 +8123,31 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	inode_inc_iversion(new_inode);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID &&
+	    new_ino != BTRFS_FIRST_FREE_OBJECTID) {
+		/*
+		 * If we are renaming in the same directory (and it's not for
+		 * root entries) pin the log early to prevent any concurrent
+		 * task from logging the directory after we removed the old
+		 * entries and before we add the new entries, otherwise that
+		 * task can sync a log without any entry for the inodes we are
+		 * renaming and therefore replaying that log, if a power failure
+		 * happens after syncing the log, would result in deleting the
+		 * inodes.
+		 *
+		 * If the rename affects two different directories, we want to
+		 * make sure the that there's no log commit that contains
+		 * updates for only one of the directories but not for the
+		 * other.
+		 *
+		 * If we are renaming an entry for a root, we don't care about
+		 * log updates since we called btrfs_set_log_full_commit().
+		 */
+		btrfs_pin_log_trans(root);
+		btrfs_pin_log_trans(dest);
+		logs_pinned = true;
+	}
+
 	if (old_dentry->d_parent != new_dentry->d_parent) {
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
 					BTRFS_I(old_inode), true);
@@ -8177,30 +8205,23 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 		BTRFS_I(new_inode)->dir_index = new_idx;
 
 	/*
-	 * Now pin the logs of the roots. We do it to ensure that no other task
-	 * can sync the logs while we are in progress with the rename, because
-	 * that could result in an inconsistency in case any of the inodes that
-	 * are part of this rename operation were logged before.
+	 * Do the log updates for all inodes.
+	 *
+	 * If either entry is for a root we don't need to update the logs since
+	 * we've called btrfs_set_log_full_commit() before.
 	 */
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
-		btrfs_pin_log_trans(root);
-	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
-		btrfs_pin_log_trans(dest);
-
-	/* Do the log updates for all inodes. */
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+	if (logs_pinned) {
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   old_rename_ctx.index, new_dentry->d_parent);
-	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_log_new_name(trans, new_dentry, BTRFS_I(new_dir),
 				   new_rename_ctx.index, old_dentry->d_parent);
+	}
 
-	/* Now unpin the logs. */
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+out_fail:
+	if (logs_pinned) {
 		btrfs_end_log_trans(root);
-	if (new_ino != BTRFS_FIRST_FREE_OBJECTID)
 		btrfs_end_log_trans(dest);
-out_fail:
+	}
 	ret2 = btrfs_end_transaction(trans);
 	ret = ret ? ret : ret2;
 out_notrans:
@@ -8250,6 +8271,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	int ret2;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
 	struct fscrypt_name old_fname, new_fname;
+	bool logs_pinned = false;
 
 	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
 		return -EPERM;
@@ -8384,6 +8406,29 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	inode_inc_iversion(old_inode);
 	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
 
+	if (old_ino != BTRFS_FIRST_FREE_OBJECTID) {
+		/*
+		 * If we are renaming in the same directory (and it's not a
+		 * root entry) pin the log to prevent any concurrent task from
+		 * logging the directory after we removed the old entry and
+		 * before we add the new entry, otherwise that task can sync
+		 * a log without any entry for the inode we are renaming and
+		 * therefore replaying that log, if a power failure happens
+		 * after syncing the log, would result in deleting the inode.
+		 *
+		 * If the rename affects two different directories, we want to
+		 * make sure the that there's no log commit that contains
+		 * updates for only one of the directories but not for the
+		 * other.
+		 *
+		 * If we are renaming an entry for a root, we don't care about
+		 * log updates since we called btrfs_set_log_full_commit().
+		 */
+		btrfs_pin_log_trans(root);
+		btrfs_pin_log_trans(dest);
+		logs_pinned = true;
+	}
+
 	if (old_dentry->d_parent != new_dentry->d_parent)
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
 					BTRFS_I(old_inode), true);
@@ -8432,7 +8477,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 	if (old_inode->i_nlink == 1)
 		BTRFS_I(old_inode)->dir_index = index;
 
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+	if (logs_pinned)
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   rename_ctx.index, new_dentry->d_parent);
 
@@ -8448,6 +8493,10 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 		}
 	}
 out_fail:
+	if (logs_pinned) {
+		btrfs_end_log_trans(root);
+		btrfs_end_log_trans(dest);
+	}
 	ret2 = btrfs_end_transaction(trans);
 	ret = ret ? ret : ret2;
 out_notrans:
@@ -9683,8 +9732,8 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	free_extent_map(em);
 
 	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-				       (1 << BTRFS_ORDERED_ENCODED) |
-				       (1 << BTRFS_ORDERED_COMPRESSED));
+				       (1U << BTRFS_ORDERED_ENCODED) |
+				       (1U << BTRFS_ORDERED_COMPRESSED));
 	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
 		ret = PTR_ERR(ordered);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4ed11b089ea9..880f9553d79d 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -153,9 +153,10 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	struct btrfs_ordered_extent *entry;
 	int ret;
 	u64 qgroup_rsv = 0;
+	const bool is_nocow = (flags &
+	       ((1U << BTRFS_ORDERED_NOCOW) | (1U << BTRFS_ORDERED_PREALLOC)));
 
-	if (flags &
-	    ((1 << BTRFS_ORDERED_NOCOW) | (1 << BTRFS_ORDERED_PREALLOC))) {
+	if (is_nocow) {
 		/* For nocow write, we can release the qgroup rsv right now */
 		ret = btrfs_qgroup_free_data(inode, NULL, file_offset, num_bytes, &qgroup_rsv);
 		if (ret < 0)
@@ -170,8 +171,13 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 			return ERR_PTR(ret);
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
-	if (!entry)
+	if (!entry) {
+		if (!is_nocow)
+			btrfs_qgroup_free_refroot(inode->root->fs_info,
+						  btrfs_root_id(inode->root),
+						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	entry->file_offset = file_offset;
 	entry->num_bytes = num_bytes;
@@ -253,7 +259,7 @@ static void insert_ordered_extent(struct btrfs_ordered_extent *entry)
  * @disk_bytenr:     Offset of extent on disk.
  * @disk_num_bytes:  Size of extent on disk.
  * @offset:          Offset into unencoded data where file data starts.
- * @flags:           Flags specifying type of extent (1 << BTRFS_ORDERED_*).
+ * @flags:           Flags specifying type of extent (1U << BTRFS_ORDERED_*).
  * @compress_type:   Compression algorithm used for data.
  *
  * Most of these parameters correspond to &struct btrfs_file_extent_item. The
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 39bec672df0c..8afadf994b8c 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -200,8 +200,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 	struct btrfs_stripe_hash_table *x;
 	struct btrfs_stripe_hash *cur;
 	struct btrfs_stripe_hash *h;
-	int num_entries = 1 << BTRFS_STRIPE_HASH_TABLE_BITS;
-	int i;
+	unsigned int num_entries = 1U << BTRFS_STRIPE_HASH_TABLE_BITS;
 
 	if (info->stripe_hash_table)
 		return 0;
@@ -222,7 +221,7 @@ int btrfs_alloc_stripe_hash_table(struct btrfs_fs_info *info)
 
 	h = table->table;
 
-	for (i = 0; i < num_entries; i++) {
+	for (unsigned int i = 0; i < num_entries; i++) {
 		cur = h + i;
 		INIT_LIST_HEAD(&cur->hash_list);
 		spin_lock_init(&cur->lock);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bcb8def4ade2..6119a06b0569 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -28,7 +28,6 @@
 #include <linux/btrfs.h>
 #include <linux/security.h>
 #include <linux/fs_parser.h>
-#include <linux/swap.h>
 #include "messages.h"
 #include "delayed-inode.h"
 #include "ctree.h"
@@ -2399,16 +2398,10 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	const long nr_to_scan = min_t(unsigned long, LONG_MAX, sc->nr_to_scan);
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
-	/*
-	 * We may be called from any task trying to allocate memory and we don't
-	 * want to slow it down with scanning and dropping extent maps. It would
-	 * also cause heavy lock contention if many tasks concurrently enter
-	 * here. Therefore only allow kswapd tasks to scan and drop extent maps.
-	 */
-	if (!current_is_kswapd())
-		return 0;
+	btrfs_free_extent_maps(fs_info, nr_to_scan);
 
-	return btrfs_free_extent_maps(fs_info, nr_to_scan);
+	/* The extent map shrinker runs asynchronously, so always return 0. */
+	return 0;
 }
 
 static const struct super_operations btrfs_super_ops = {
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 0a2dbfaaf49e..de226209220f 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -14,9 +14,9 @@
 #include "../disk-io.h"
 #include "../btrfs_inode.h"
 
-#define PROCESS_UNLOCK		(1 << 0)
-#define PROCESS_RELEASE		(1 << 1)
-#define PROCESS_TEST_LOCKED	(1 << 2)
+#define PROCESS_UNLOCK		(1U << 0)
+#define PROCESS_RELEASE		(1U << 1)
+#define PROCESS_TEST_LOCKED	(1U << 2)
 
 static noinline int process_page_range(struct inode *inode, u64 start, u64 end,
 				       unsigned long flags)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8e6501860001..58e0cac5779d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3268,6 +3268,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 					device->bytes_used - dev_extent_len);
 			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
 			btrfs_clear_space_info_full(fs_info);
+
+			if (list_empty(&device->post_commit_list)) {
+				list_add_tail(&device->post_commit_list,
+					      &trans->transaction->dev_update_list);
+			}
+
 			mutex_unlock(&fs_info->chunk_mutex);
 		}
 	}
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 866607fd3e58..c9ea37fabf65 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -24,7 +24,7 @@
 #include "super.h"
 
 #define ZSTD_BTRFS_MAX_WINDOWLOG 17
-#define ZSTD_BTRFS_MAX_INPUT (1 << ZSTD_BTRFS_MAX_WINDOWLOG)
+#define ZSTD_BTRFS_MAX_INPUT (1U << ZSTD_BTRFS_MAX_WINDOWLOG)
 #define ZSTD_BTRFS_DEFAULT_LEVEL 3
 #define ZSTD_BTRFS_MAX_LEVEL 15
 /* 307s to avoid pathologically clashing with transaction commit */
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 851d70200c6b..a7254cab44cc 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2616,7 +2616,7 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 	s32 stripe_unit = ci->i_layout.stripe_unit;
 	s32 stripe_count = ci->i_layout.stripe_count;
 	s32 object_size = ci->i_layout.object_size;
-	u64 object_set_size = object_size * stripe_count;
+	u64 object_set_size = (u64) object_size * stripe_count;
 	u64 nearly, t;
 
 	/* round offset up to next period boundary */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 71ddecaf771f..02f438cd6bfa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -35,6 +35,17 @@
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
+static void f2fs_zero_post_eof_page(struct inode *inode, loff_t new_size)
+{
+	loff_t old_size = i_size_read(inode);
+
+	if (old_size >= new_size)
+		return;
+
+	/* zero or drop pages only in range of [old_size, new_size] */
+	truncate_pagecache(inode, old_size);
+}
+
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
@@ -103,8 +114,13 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT);
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
+
 	folio_lock(folio);
 	if (unlikely(folio->mapping != inode->i_mapping ||
 			folio_pos(folio) > i_size_read(inode) ||
@@ -1064,6 +1080,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
+		if (attr->ia_size > old_size)
+			f2fs_zero_post_eof_page(inode, attr->ia_size);
 		truncate_setsize(inode, attr->ia_size);
 
 		if (attr->ia_size <= old_size)
@@ -1182,6 +1200,10 @@ static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len);
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
@@ -1465,6 +1487,8 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
+	f2fs_zero_post_eof_page(inode, offset + len);
+
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
 	truncate_pagecache(inode, offset);
@@ -1586,6 +1610,10 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
+	filemap_invalidate_lock(mapping);
+	f2fs_zero_post_eof_page(inode, offset + len);
+	filemap_invalidate_unlock(mapping);
+
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
@@ -1717,6 +1745,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	/* avoid gc operation during block exchange */
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(mapping);
+
+	f2fs_zero_post_eof_page(inode, offset + len);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1774,6 +1804,10 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 	if (err)
 		return err;
 
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len);
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	f2fs_balance_fs(sbi, true);
 
 	pg_start = ((unsigned long long)offset) >> PAGE_SHIFT;
@@ -4715,6 +4749,10 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	err = file_modified(file);
 	if (err)
 		return err;
+
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, iocb->ki_pos + iov_iter_count(from));
+	filemap_invalidate_unlock(inode->i_mapping);
 	return count;
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 330f89ddb5c8..f0e83ea56e38 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1787,26 +1787,32 @@ static int f2fs_statfs_project(struct super_block *sb,
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_bsoftlimit,
 					dquot->dq_dqb.dqb_bhardlimit);
-	if (limit)
-		limit >>= sb->s_blocksize_bits;
+	limit >>= sb->s_blocksize_bits;
+
+	if (limit) {
+		uint64_t remaining = 0;
 
-	if (limit && buf->f_blocks > limit) {
 		curblock = (dquot->dq_dqb.dqb_curspace +
 			    dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
-		buf->f_blocks = limit;
-		buf->f_bfree = buf->f_bavail =
-			(buf->f_blocks > curblock) ?
-			 (buf->f_blocks - curblock) : 0;
+		if (limit > curblock)
+			remaining = limit - curblock;
+
+		buf->f_blocks = min(buf->f_blocks, limit);
+		buf->f_bfree = min(buf->f_bfree, remaining);
+		buf->f_bavail = min(buf->f_bavail, remaining);
 	}
 
 	limit = min_not_zero(dquot->dq_dqb.dqb_isoftlimit,
 					dquot->dq_dqb.dqb_ihardlimit);
 
-	if (limit && buf->f_files > limit) {
-		buf->f_files = limit;
-		buf->f_ffree =
-			(buf->f_files > dquot->dq_dqb.dqb_curinodes) ?
-			 (buf->f_files - dquot->dq_dqb.dqb_curinodes) : 0;
+	if (limit) {
+		uint64_t remaining = 0;
+
+		if (limit > dquot->dq_dqb.dqb_curinodes)
+			remaining = limit - dquot->dq_dqb.dqb_curinodes;
+
+		buf->f_files = min(buf->f_files, limit);
+		buf->f_ffree = min(buf->f_ffree, remaining);
 	}
 
 	spin_unlock(&dquot->dq_dqb_lock);
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ff543dc09130..ce7324d0d9ed 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1921,6 +1921,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
+	u64 attr_version;
 
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
@@ -2005,6 +2006,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
 			inarg.valid |= FATTR_KILL_SUIDGID;
 	}
+
+	attr_version = fuse_get_attr_version(fm->fc);
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
 	err = fuse_simple_request(fm, &args);
 	if (err) {
@@ -2030,6 +2033,14 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		/* FIXME: clear I_DIRTY_SYNC? */
 	}
 
+	if (fi->attr_version > attr_version) {
+		/*
+		 * Apply attributes, for example for fsnotify_change(), but set
+		 * attribute timeout to zero.
+		 */
+		outarg.attr_valid = outarg.attr_valid_nsec = 0;
+	}
+
 	fuse_change_attributes_common(inode, &outarg.attr, NULL,
 				      ATTR_TIMEOUT(&outarg),
 				      fuse_get_cache_mask(inode));
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 0e1019382cf5..35e063c9f3a4 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -178,45 +178,30 @@ int dbMount(struct inode *ipbmap)
 	dbmp_le = (struct dbmap_disk *) mp->data;
 	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
 	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
-
 	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
-	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
-		bmp->db_l2nbperpage < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
-	if (!bmp->db_numag || bmp->db_numag > MAXAG) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_maxlevel = le32_to_cpu(dbmp_le->dn_maxlevel);
 	bmp->db_maxag = le32_to_cpu(dbmp_le->dn_maxag);
 	bmp->db_agpref = le32_to_cpu(dbmp_le->dn_agpref);
-	if (bmp->db_maxag >= MAXAG || bmp->db_maxag < 0 ||
-		bmp->db_agpref >= MAXAG || bmp->db_agpref < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
-
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
-	if (!bmp->db_agwidth) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
-	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
-	    bmp->db_agl2size < 0) {
-		err = -EINVAL;
-		goto err_release_metapage;
-	}
 
-	if (((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
+	if ((bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) ||
+	    (bmp->db_l2nbperpage < 0) ||
+	    !bmp->db_numag || (bmp->db_numag > MAXAG) ||
+	    (bmp->db_maxag >= MAXAG) || (bmp->db_maxag < 0) ||
+	    (bmp->db_agpref >= MAXAG) || (bmp->db_agpref < 0) ||
+	    (bmp->db_agheight < 0) || (bmp->db_agheight > (L2LPERCTL >> 1)) ||
+	    (bmp->db_agwidth < 1) || (bmp->db_agwidth > (LPERCTL / MAXAG)) ||
+	    (bmp->db_agwidth > (1 << (L2LPERCTL - (bmp->db_agheight << 1)))) ||
+	    (bmp->db_agstart < 0) ||
+	    (bmp->db_agstart > (CTLTREESIZE - 1 - bmp->db_agwidth * (MAXAG - 1))) ||
+	    (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG) ||
+	    (bmp->db_agl2size < 0) ||
+	    ((bmp->db_mapsize - 1) >> bmp->db_agl2size) > MAXAG) {
 		err = -EINVAL;
 		goto err_release_metapage;
 	}
diff --git a/fs/namespace.c b/fs/namespace.c
index 843bc6191f30..b5c5cf01d0c4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2521,14 +2521,14 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
 		hlist_del_init(&child->mnt_hash);
-		q = __lookup_mnt(&child->mnt_parent->mnt,
-				 child->mnt_mountpoint);
-		if (q)
-			mnt_change_mountpoint(child, smp, q);
 		/* Notice when we are propagating across user namespaces */
 		if (child->mnt_parent->mnt_ns->user_ns != user_ns)
 			lock_mnt_tree(child);
 		child->mnt.mnt_flags &= ~MNT_LOCKED;
+		q = __lookup_mnt(&child->mnt_parent->mnt,
+				 child->mnt_mountpoint);
+		if (q)
+			mnt_change_mountpoint(child, smp, q);
 		commit_tree(child);
 	}
 	put_mountpoint(smp);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 330273cf9453..16607b24ab9c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -557,6 +557,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			set_nlink(inode, fattr->nlink);
 		else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
+		else
+			set_nlink(inode, 1);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
 		else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
@@ -633,6 +635,34 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
 	}
 }
 
+static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
+{
+	unsigned int cache_flags = 0;
+
+	if (attr->ia_valid & ATTR_MTIME_SET) {
+		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
+		struct timespec64 now;
+		int updated = 0;
+
+		now = inode_set_ctime_current(inode);
+		if (!timespec64_equal(&now, &ctime))
+			updated |= S_CTIME;
+
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
+		if (!timespec64_equal(&now, &mtime))
+			updated |= S_MTIME;
+
+		inode_maybe_inc_iversion(inode, updated);
+		cache_flags |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
+	}
+	if (attr->ia_valid & ATTR_ATIME_SET) {
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+		cache_flags |= NFS_INO_INVALID_ATIME;
+	}
+	NFS_I(inode)->cache_validity &= ~cache_flags;
+}
+
 static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
 {
 	enum file_time_flags time_flags = 0;
@@ -701,14 +731,27 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
 		spin_lock(&inode->i_lock);
-		nfs_update_timestamps(inode, attr->ia_valid);
+		if (attr->ia_valid & ATTR_MTIME_SET) {
+			nfs_set_timestamps_to_ts(inode, attr);
+			attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
+						ATTR_ATIME|ATTR_ATIME_SET);
+		} else {
+			nfs_update_timestamps(inode, attr->ia_valid);
+			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
+		}
 		spin_unlock(&inode->i_lock);
-		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
 	} else if (nfs_have_delegated_atime(inode) &&
 		   attr->ia_valid & ATTR_ATIME &&
 		   !(attr->ia_valid & ATTR_MTIME)) {
-		nfs_update_delegated_atime(inode);
-		attr->ia_valid &= ~ATTR_ATIME;
+		if (attr->ia_valid & ATTR_ATIME_SET) {
+			spin_lock(&inode->i_lock);
+			nfs_set_timestamps_to_ts(inode, attr);
+			spin_unlock(&inode->i_lock);
+			attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
+		} else {
+			nfs_update_delegated_atime(inode);
+			attr->ia_valid &= ~ATTR_ATIME;
+		}
 	}
 
 	/* Optimization: if the end result is no change, don't RPC */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 57d49e874f51..77b239b10d41 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -313,14 +313,14 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 
 	if (nfs_have_delegated_mtime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
 		if (!(cache_validity & NFS_INO_INVALID_MTIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
+			dst[1] &= ~(FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_TIME_MODIFY_SET);
 		if (!(cache_validity & NFS_INO_INVALID_CTIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
+			dst[1] &= ~(FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY_SET);
 	} else if (nfs_have_delegated_atime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
 	}
 }
 
@@ -6174,6 +6174,8 @@ static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
 	struct nfs_server *server = NFS_SERVER(inode);
 	int ret;
 
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	if (!nfs4_server_supports_acls(server, type))
 		return -EOPNOTSUPP;
 	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
@@ -6248,6 +6250,9 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
 {
 	struct nfs4_exception exception = { };
 	int err;
+
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	do {
 		err = __nfs4_proc_set_acl(inode, buf, buflen, type);
 		trace_nfs4_set_acl(inode, err);
@@ -10814,7 +10819,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3;
+	ssize_t error, error2, error3, error4;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10837,8 +10842,16 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
 		return error3;
+	if (list) {
+		list += error3;
+		left -= error3;
+	}
+
+	error4 = security_inode_listsecurity(d_inode(dentry), list, left);
+	if (error4 < 0)
+		return error4;
 
-	error += error2 + error3;
+	error += error2 + error3 + error4;
 	if (size && error > size)
 		return -ERANGE;
 	return error;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 8f080046c59d..99571de665dd 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -300,7 +300,9 @@ enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path)
 
 struct dentry *ovl_dentry_upper(struct dentry *dentry)
 {
-	return ovl_upperdentry_dereference(OVL_I(d_inode(dentry)));
+	struct inode *inode = d_inode(dentry);
+
+	return inode ? ovl_upperdentry_dereference(OVL_I(inode)) : NULL;
 }
 
 struct dentry *ovl_dentry_lower(struct dentry *dentry)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 536b7dc45381..96fe904b2ac5 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2155,7 +2155,7 @@ static unsigned long pagemap_thp_category(struct pagemap_scan_private *p,
 				categories |= PAGE_IS_FILE;
 		}
 
-		if (is_zero_pfn(pmd_pfn(pmd)))
+		if (is_huge_zero_pmd(pmd))
 			categories |= PAGE_IS_PFNZERO;
 		if (pmd_soft_dirty(pmd))
 			categories |= PAGE_IS_SOFT_DIRTY;
diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
index e03c890de0a0..c0196be0e65f 100644
--- a/fs/smb/client/cifs_debug.c
+++ b/fs/smb/client/cifs_debug.c
@@ -362,6 +362,10 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 	c = 0;
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(server, &cifs_tcp_ses_list, tcp_ses_list) {
+#ifdef CONFIG_CIFS_SMB_DIRECT
+		struct smbdirect_socket_parameters *sp;
+#endif
+
 		/* channel info will be printed as a part of sessions below */
 		if (SERVER_IS_CHAN(server))
 			continue;
@@ -383,25 +387,26 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 			seq_printf(m, "\nSMBDirect transport not available");
 			goto skip_rdma;
 		}
+		sp = &server->smbd_conn->socket.parameters;
 
 		seq_printf(m, "\nSMBDirect (in hex) protocol version: %x "
 			"transport status: %x",
 			server->smbd_conn->protocol,
-			server->smbd_conn->transport_status);
+			server->smbd_conn->socket.status);
 		seq_printf(m, "\nConn receive_credit_max: %x "
 			"send_credit_target: %x max_send_size: %x",
-			server->smbd_conn->receive_credit_max,
-			server->smbd_conn->send_credit_target,
-			server->smbd_conn->max_send_size);
+			sp->recv_credit_max,
+			sp->send_credit_target,
+			sp->max_send_size);
 		seq_printf(m, "\nConn max_fragmented_recv_size: %x "
 			"max_fragmented_send_size: %x max_receive_size:%x",
-			server->smbd_conn->max_fragmented_recv_size,
-			server->smbd_conn->max_fragmented_send_size,
-			server->smbd_conn->max_receive_size);
+			sp->max_fragmented_recv_size,
+			sp->max_fragmented_send_size,
+			sp->max_recv_size);
 		seq_printf(m, "\nConn keep_alive_interval: %x "
 			"max_readwrite_size: %x rdma_readwrite_threshold: %x",
-			server->smbd_conn->keep_alive_interval,
-			server->smbd_conn->max_readwrite_size,
+			sp->keepalive_interval_msec * 1000,
+			sp->max_read_write_size,
 			server->smbd_conn->rdma_readwrite_threshold);
 		seq_printf(m, "\nDebug count_get_receive_buffer: %x "
 			"count_put_receive_buffer: %x count_send_empty: %x",
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index e0faee22be07..c66655adecb2 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -677,6 +677,7 @@ inc_rfc1001_len(void *buf, int count)
 struct TCP_Server_Info {
 	struct list_head tcp_ses_list;
 	struct list_head smb_ses_list;
+	struct list_head rlist; /* reconnect list */
 	spinlock_t srv_lock;  /* protect anything here that is not protected */
 	__u64 conn_id; /* connection identifier (useful for debugging) */
 	int srv_count; /* reference counter */
@@ -739,6 +740,7 @@ struct TCP_Server_Info {
 	char workstation_RFC1001_name[RFC1001_NAME_LEN_WITH_NULL];
 	__u32 sequence_number; /* for signing, protected by srv_mutex */
 	__u32 reconnect_instance; /* incremented on each reconnect */
+	__le32 session_key_id; /* retrieved from negotiate response and send in session setup request */
 	struct session_key session_key;
 	unsigned long lstrp; /* when we got last response from this server */
 	struct cifs_secmech secmech; /* crypto sec mech functs, descriptors */
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 28f8ca470770..688a26aeef3b 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -557,7 +557,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 MaxBufferSize;
 		__le16 MaxMpxCount;
 		__le16 VcNumber;
-		__u32 SessionKey;
+		__le32 SessionKey;
 		__le16 SecurityBlobLength;
 		__u32 Reserved;
 		__le32 Capabilities;	/* see below */
@@ -576,7 +576,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 MaxBufferSize;
 		__le16 MaxMpxCount;
 		__le16 VcNumber;
-		__u32 SessionKey;
+		__le32 SessionKey;
 		__le16 CaseInsensitivePasswordLength; /* ASCII password len */
 		__le16 CaseSensitivePasswordLength; /* Unicode password length*/
 		__u32 Reserved;	/* see below */
@@ -614,7 +614,7 @@ typedef union smb_com_session_setup_andx {
 		__le16 MaxBufferSize;
 		__le16 MaxMpxCount;
 		__le16 VcNumber;
-		__u32 SessionKey;
+		__le32 SessionKey;
 		__le16 PasswordLength;
 		__u32 Reserved; /* encrypt key len and offset */
 		__le16 ByteCount;
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index cf8d9de2298f..d6ba55d4720d 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -481,6 +481,7 @@ CIFSSMBNegotiate(const unsigned int xid,
 	server->max_rw = le32_to_cpu(pSMBr->MaxRawSize);
 	cifs_dbg(NOISY, "Max buf = %d\n", ses->server->maxBuf);
 	server->capabilities = le32_to_cpu(pSMBr->Capabilities);
+	server->session_key_id = pSMBr->SessionKey;
 	server->timeAdj = (int)(__s16)le16_to_cpu(pSMBr->ServerTimeZone);
 	server->timeAdj *= 60;
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 91f5fd818cbf..9275e0d1e2f6 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -140,6 +140,14 @@ static void smb2_query_server_interfaces(struct work_struct *work)
 			   (SMB_INTERFACE_POLL_INTERVAL * HZ));
 }
 
+#define set_need_reco(server) \
+do { \
+	spin_lock(&server->srv_lock); \
+	if (server->tcpStatus != CifsExiting) \
+		server->tcpStatus = CifsNeedReconnect; \
+	spin_unlock(&server->srv_lock); \
+} while (0)
+
 /*
  * Update the tcpStatus for the server.
  * This is used to signal the cifsd thread to call cifs_reconnect
@@ -153,39 +161,45 @@ void
 cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 				bool all_channels)
 {
-	struct TCP_Server_Info *pserver;
+	struct TCP_Server_Info *nserver;
 	struct cifs_ses *ses;
+	LIST_HEAD(reco);
 	int i;
 
-	/* If server is a channel, select the primary channel */
-	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
-
 	/* if we need to signal just this channel */
 	if (!all_channels) {
-		spin_lock(&server->srv_lock);
-		if (server->tcpStatus != CifsExiting)
-			server->tcpStatus = CifsNeedReconnect;
-		spin_unlock(&server->srv_lock);
+		set_need_reco(server);
 		return;
 	}
 
-	spin_lock(&cifs_tcp_ses_lock);
-	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
-		if (cifs_ses_exiting(ses))
-			continue;
-		spin_lock(&ses->chan_lock);
-		for (i = 0; i < ses->chan_count; i++) {
-			if (!ses->chans[i].server)
+	if (SERVER_IS_CHAN(server))
+		server = server->primary_server;
+	scoped_guard(spinlock, &cifs_tcp_ses_lock) {
+		set_need_reco(server);
+		list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+			spin_lock(&ses->ses_lock);
+			if (ses->ses_status == SES_EXITING) {
+				spin_unlock(&ses->ses_lock);
 				continue;
-
-			spin_lock(&ses->chans[i].server->srv_lock);
-			if (ses->chans[i].server->tcpStatus != CifsExiting)
-				ses->chans[i].server->tcpStatus = CifsNeedReconnect;
-			spin_unlock(&ses->chans[i].server->srv_lock);
+			}
+			spin_lock(&ses->chan_lock);
+			for (i = 1; i < ses->chan_count; i++) {
+				nserver = ses->chans[i].server;
+				if (!nserver)
+					continue;
+				nserver->srv_count++;
+				list_add(&nserver->rlist, &reco);
+			}
+			spin_unlock(&ses->chan_lock);
+			spin_unlock(&ses->ses_lock);
 		}
-		spin_unlock(&ses->chan_lock);
 	}
-	spin_unlock(&cifs_tcp_ses_lock);
+
+	list_for_each_entry_safe(server, nserver, &reco, rlist) {
+		list_del_init(&server->rlist);
+		set_need_reco(server);
+		cifs_put_tcp_session(server, 0);
+	}
 }
 
 /*
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 4373dd64b66d..5122f3895dfc 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -323,6 +323,14 @@ check_smb_hdr(struct smb_hdr *smb)
 	if (smb->Command == SMB_COM_LOCKING_ANDX)
 		return 0;
 
+	/*
+	 * Windows NT server returns error resposne (e.g. STATUS_DELETE_PENDING
+	 * or STATUS_OBJECT_NAME_NOT_FOUND or ERRDOS/ERRbadfile or any other)
+	 * for some TRANS2 requests without the RESPONSE flag set in header.
+	 */
+	if (smb->Command == SMB_COM_TRANSACTION2 && smb->Status.CifsError != 0)
+		return 0;
+
 	cifs_dbg(VFS, "Server sent request, not response. mid=%u\n",
 		 get_mid(smb));
 	return 1;
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index 10d82d0dc6a9..8be7c4d2d9d6 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -658,6 +658,7 @@ static __u32 cifs_ssetup_hdr(struct cifs_ses *ses,
 					USHRT_MAX));
 	pSMB->req.MaxMpxCount = cpu_to_le16(server->maxReq);
 	pSMB->req.VcNumber = cpu_to_le16(1);
+	pSMB->req.SessionKey = server->session_key_id;
 
 	/* Now no need to set SMBFLG_CASELESS or obsolete CANONICAL PATH */
 
@@ -1714,22 +1715,22 @@ _sess_auth_rawntlmssp_assemble_req(struct sess_data *sess_data)
 	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
 
 	capabilities = cifs_ssetup_hdr(ses, server, pSMB);
-	if ((pSMB->req.hdr.Flags2 & SMBFLG2_UNICODE) == 0) {
-		cifs_dbg(VFS, "NTLMSSP requires Unicode support\n");
-		return -ENOSYS;
-	}
-
 	pSMB->req.hdr.Flags2 |= SMBFLG2_EXT_SEC;
 	capabilities |= CAP_EXTENDED_SECURITY;
 	pSMB->req.Capabilities |= cpu_to_le32(capabilities);
 
 	bcc_ptr = sess_data->iov[2].iov_base;
-	/* unicode strings must be word aligned */
-	if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
-		*bcc_ptr = 0;
-		bcc_ptr++;
+
+	if (pSMB->req.hdr.Flags2 & SMBFLG2_UNICODE) {
+		/* unicode strings must be word aligned */
+		if (!IS_ALIGNED(sess_data->iov[0].iov_len + sess_data->iov[1].iov_len, 2)) {
+			*bcc_ptr = 0;
+			bcc_ptr++;
+		}
+		unicode_oslm_strings(&bcc_ptr, sess_data->nls_cp);
+	} else {
+		ascii_oslm_strings(&bcc_ptr, sess_data->nls_cp);
 	}
-	unicode_oslm_strings(&bcc_ptr, sess_data->nls_cp);
 
 	sess_data->iov[2].iov_len = (long) bcc_ptr -
 					(long) sess_data->iov[2].iov_base;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 74bcc51ccd32..e596bc4837b6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -504,6 +504,9 @@ smb3_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	wsize = min_t(unsigned int, wsize, server->max_write);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->rdma) {
+		struct smbdirect_socket_parameters *sp =
+			&server->smbd_conn->socket.parameters;
+
 		if (server->sign)
 			/*
 			 * Account for SMB2 data transfer packet header and
@@ -511,12 +514,12 @@ smb3_negotiate_wsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 			 */
 			wsize = min_t(unsigned int,
 				wsize,
-				server->smbd_conn->max_fragmented_send_size -
+				sp->max_fragmented_send_size -
 					SMB2_READWRITE_PDU_HEADER_SIZE -
 					sizeof(struct smb2_transform_hdr));
 		else
 			wsize = min_t(unsigned int,
-				wsize, server->smbd_conn->max_readwrite_size);
+				wsize, sp->max_read_write_size);
 	}
 #endif
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU))
@@ -552,6 +555,9 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 	rsize = min_t(unsigned int, rsize, server->max_read);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->rdma) {
+		struct smbdirect_socket_parameters *sp =
+			&server->smbd_conn->socket.parameters;
+
 		if (server->sign)
 			/*
 			 * Account for SMB2 data transfer packet header and
@@ -559,12 +565,12 @@ smb3_negotiate_rsize(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 			 */
 			rsize = min_t(unsigned int,
 				rsize,
-				server->smbd_conn->max_fragmented_recv_size -
+				sp->max_fragmented_recv_size -
 					SMB2_READWRITE_PDU_HEADER_SIZE -
 					sizeof(struct smb2_transform_hdr));
 		else
 			rsize = min_t(unsigned int,
-				rsize, server->smbd_conn->max_readwrite_size);
+				rsize, sp->max_read_write_size);
 	}
 #endif
 
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 9d8be034f103..ac06f2617f34 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/folio_queue.h>
+#include "../common/smbdirect/smbdirect_pdu.h"
 #include "smbdirect.h"
 #include "cifs_debug.h"
 #include "cifsproto.h"
@@ -50,9 +51,6 @@ struct smb_extract_to_rdma {
 static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
 					struct smb_extract_to_rdma *rdma);
 
-/* SMBD version number */
-#define SMBD_V1	0x0100
-
 /* Port numbers for SMBD transport */
 #define SMB_PORT	445
 #define SMBD_PORT	5445
@@ -165,10 +163,11 @@ static void smbd_disconnect_rdma_work(struct work_struct *work)
 {
 	struct smbd_connection *info =
 		container_of(work, struct smbd_connection, disconnect_work);
+	struct smbdirect_socket *sc = &info->socket;
 
-	if (info->transport_status == SMBD_CONNECTED) {
-		info->transport_status = SMBD_DISCONNECTING;
-		rdma_disconnect(info->id);
+	if (sc->status == SMBDIRECT_SOCKET_CONNECTED) {
+		sc->status = SMBDIRECT_SOCKET_DISCONNECTING;
+		rdma_disconnect(sc->rdma.cm_id);
 	}
 }
 
@@ -182,6 +181,7 @@ static int smbd_conn_upcall(
 		struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
 	struct smbd_connection *info = id->context;
+	struct smbdirect_socket *sc = &info->socket;
 
 	log_rdma_event(INFO, "event=%d status=%d\n",
 		event->event, event->status);
@@ -205,7 +205,7 @@ static int smbd_conn_upcall(
 
 	case RDMA_CM_EVENT_ESTABLISHED:
 		log_rdma_event(INFO, "connected event=%d\n", event->event);
-		info->transport_status = SMBD_CONNECTED;
+		sc->status = SMBDIRECT_SOCKET_CONNECTED;
 		wake_up_interruptible(&info->conn_wait);
 		break;
 
@@ -213,20 +213,20 @@ static int smbd_conn_upcall(
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_REJECTED:
 		log_rdma_event(INFO, "connecting failed event=%d\n", event->event);
-		info->transport_status = SMBD_DISCONNECTED;
+		sc->status = SMBDIRECT_SOCKET_DISCONNECTED;
 		wake_up_interruptible(&info->conn_wait);
 		break;
 
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 	case RDMA_CM_EVENT_DISCONNECTED:
 		/* This happens when we fail the negotiation */
-		if (info->transport_status == SMBD_NEGOTIATE_FAILED) {
-			info->transport_status = SMBD_DISCONNECTED;
+		if (sc->status == SMBDIRECT_SOCKET_NEGOTIATE_FAILED) {
+			sc->status = SMBDIRECT_SOCKET_DISCONNECTED;
 			wake_up(&info->conn_wait);
 			break;
 		}
 
-		info->transport_status = SMBD_DISCONNECTED;
+		sc->status = SMBDIRECT_SOCKET_DISCONNECTED;
 		wake_up_interruptible(&info->disconn_wait);
 		wake_up_interruptible(&info->wait_reassembly_queue);
 		wake_up_interruptible_all(&info->wait_send_queue);
@@ -275,6 +275,8 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	int i;
 	struct smbd_request *request =
 		container_of(wc->wr_cqe, struct smbd_request, cqe);
+	struct smbd_connection *info = request->info;
+	struct smbdirect_socket *sc = &info->socket;
 
 	log_rdma_send(INFO, "smbd_request 0x%p completed wc->status=%d\n",
 		request, wc->status);
@@ -286,7 +288,7 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	}
 
 	for (i = 0; i < request->num_sge; i++)
-		ib_dma_unmap_single(request->info->id->device,
+		ib_dma_unmap_single(sc->ib.dev,
 			request->sge[i].addr,
 			request->sge[i].length,
 			DMA_TO_DEVICE);
@@ -299,7 +301,7 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	mempool_free(request, request->info->request_mempool);
 }
 
-static void dump_smbd_negotiate_resp(struct smbd_negotiate_resp *resp)
+static void dump_smbdirect_negotiate_resp(struct smbdirect_negotiate_resp *resp)
 {
 	log_rdma_event(INFO, "resp message min_version %u max_version %u negotiated_version %u credits_requested %u credits_granted %u status %u max_readwrite_size %u preferred_send_size %u max_receive_size %u max_fragmented_size %u\n",
 		       resp->min_version, resp->max_version,
@@ -318,15 +320,17 @@ static bool process_negotiation_response(
 		struct smbd_response *response, int packet_length)
 {
 	struct smbd_connection *info = response->info;
-	struct smbd_negotiate_resp *packet = smbd_response_payload(response);
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
+	struct smbdirect_negotiate_resp *packet = smbd_response_payload(response);
 
-	if (packet_length < sizeof(struct smbd_negotiate_resp)) {
+	if (packet_length < sizeof(struct smbdirect_negotiate_resp)) {
 		log_rdma_event(ERR,
 			"error: packet_length=%d\n", packet_length);
 		return false;
 	}
 
-	if (le16_to_cpu(packet->negotiated_version) != SMBD_V1) {
+	if (le16_to_cpu(packet->negotiated_version) != SMBDIRECT_V1) {
 		log_rdma_event(ERR, "error: negotiated_version=%x\n",
 			le16_to_cpu(packet->negotiated_version));
 		return false;
@@ -347,20 +351,20 @@ static bool process_negotiation_response(
 
 	atomic_set(&info->receive_credits, 0);
 
-	if (le32_to_cpu(packet->preferred_send_size) > info->max_receive_size) {
+	if (le32_to_cpu(packet->preferred_send_size) > sp->max_recv_size) {
 		log_rdma_event(ERR, "error: preferred_send_size=%d\n",
 			le32_to_cpu(packet->preferred_send_size));
 		return false;
 	}
-	info->max_receive_size = le32_to_cpu(packet->preferred_send_size);
+	sp->max_recv_size = le32_to_cpu(packet->preferred_send_size);
 
 	if (le32_to_cpu(packet->max_receive_size) < SMBD_MIN_RECEIVE_SIZE) {
 		log_rdma_event(ERR, "error: max_receive_size=%d\n",
 			le32_to_cpu(packet->max_receive_size));
 		return false;
 	}
-	info->max_send_size = min_t(int, info->max_send_size,
-					le32_to_cpu(packet->max_receive_size));
+	sp->max_send_size = min_t(u32, sp->max_send_size,
+				  le32_to_cpu(packet->max_receive_size));
 
 	if (le32_to_cpu(packet->max_fragmented_size) <
 			SMBD_MIN_FRAGMENTED_SIZE) {
@@ -368,18 +372,18 @@ static bool process_negotiation_response(
 			le32_to_cpu(packet->max_fragmented_size));
 		return false;
 	}
-	info->max_fragmented_send_size =
+	sp->max_fragmented_send_size =
 		le32_to_cpu(packet->max_fragmented_size);
 	info->rdma_readwrite_threshold =
-		rdma_readwrite_threshold > info->max_fragmented_send_size ?
-		info->max_fragmented_send_size :
+		rdma_readwrite_threshold > sp->max_fragmented_send_size ?
+		sp->max_fragmented_send_size :
 		rdma_readwrite_threshold;
 
 
-	info->max_readwrite_size = min_t(u32,
+	sp->max_read_write_size = min_t(u32,
 			le32_to_cpu(packet->max_readwrite_size),
 			info->max_frmr_depth * PAGE_SIZE);
-	info->max_frmr_depth = info->max_readwrite_size / PAGE_SIZE;
+	info->max_frmr_depth = sp->max_read_write_size / PAGE_SIZE;
 
 	return true;
 }
@@ -393,8 +397,9 @@ static void smbd_post_send_credits(struct work_struct *work)
 	struct smbd_connection *info =
 		container_of(work, struct smbd_connection,
 			post_send_credits_work);
+	struct smbdirect_socket *sc = &info->socket;
 
-	if (info->transport_status != SMBD_CONNECTED) {
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		wake_up(&info->wait_receive_queues);
 		return;
 	}
@@ -448,7 +453,7 @@ static void smbd_post_send_credits(struct work_struct *work)
 /* Called from softirq, when recv is done */
 static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct smbd_data_transfer *data_transfer;
+	struct smbdirect_data_transfer *data_transfer;
 	struct smbd_response *response =
 		container_of(wc->wr_cqe, struct smbd_response, cqe);
 	struct smbd_connection *info = response->info;
@@ -474,7 +479,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	switch (response->type) {
 	/* SMBD negotiation response */
 	case SMBD_NEGOTIATE_RESP:
-		dump_smbd_negotiate_resp(smbd_response_payload(response));
+		dump_smbdirect_negotiate_resp(smbd_response_payload(response));
 		info->full_packet_received = true;
 		info->negotiate_done =
 			process_negotiation_response(response, wc->byte_len);
@@ -531,7 +536,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		/* Send a KEEP_ALIVE response right away if requested */
 		info->keep_alive_requested = KEEP_ALIVE_NONE;
 		if (le16_to_cpu(data_transfer->flags) &
-				SMB_DIRECT_RESPONSE_REQUESTED) {
+				SMBDIRECT_FLAG_RESPONSE_REQUESTED) {
 			info->keep_alive_requested = KEEP_ALIVE_PENDING;
 		}
 
@@ -635,32 +640,34 @@ static int smbd_ia_open(
 		struct smbd_connection *info,
 		struct sockaddr *dstaddr, int port)
 {
+	struct smbdirect_socket *sc = &info->socket;
 	int rc;
 
-	info->id = smbd_create_id(info, dstaddr, port);
-	if (IS_ERR(info->id)) {
-		rc = PTR_ERR(info->id);
+	sc->rdma.cm_id = smbd_create_id(info, dstaddr, port);
+	if (IS_ERR(sc->rdma.cm_id)) {
+		rc = PTR_ERR(sc->rdma.cm_id);
 		goto out1;
 	}
+	sc->ib.dev = sc->rdma.cm_id->device;
 
-	if (!frwr_is_supported(&info->id->device->attrs)) {
+	if (!frwr_is_supported(&sc->ib.dev->attrs)) {
 		log_rdma_event(ERR, "Fast Registration Work Requests (FRWR) is not supported\n");
 		log_rdma_event(ERR, "Device capability flags = %llx max_fast_reg_page_list_len = %u\n",
-			       info->id->device->attrs.device_cap_flags,
-			       info->id->device->attrs.max_fast_reg_page_list_len);
+			       sc->ib.dev->attrs.device_cap_flags,
+			       sc->ib.dev->attrs.max_fast_reg_page_list_len);
 		rc = -EPROTONOSUPPORT;
 		goto out2;
 	}
 	info->max_frmr_depth = min_t(int,
 		smbd_max_frmr_depth,
-		info->id->device->attrs.max_fast_reg_page_list_len);
+		sc->ib.dev->attrs.max_fast_reg_page_list_len);
 	info->mr_type = IB_MR_TYPE_MEM_REG;
-	if (info->id->device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
+	if (sc->ib.dev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
 		info->mr_type = IB_MR_TYPE_SG_GAPS;
 
-	info->pd = ib_alloc_pd(info->id->device, 0);
-	if (IS_ERR(info->pd)) {
-		rc = PTR_ERR(info->pd);
+	sc->ib.pd = ib_alloc_pd(sc->ib.dev, 0);
+	if (IS_ERR(sc->ib.pd)) {
+		rc = PTR_ERR(sc->ib.pd);
 		log_rdma_event(ERR, "ib_alloc_pd() returned %d\n", rc);
 		goto out2;
 	}
@@ -668,8 +675,8 @@ static int smbd_ia_open(
 	return 0;
 
 out2:
-	rdma_destroy_id(info->id);
-	info->id = NULL;
+	rdma_destroy_id(sc->rdma.cm_id);
+	sc->rdma.cm_id = NULL;
 
 out1:
 	return rc;
@@ -683,10 +690,12 @@ static int smbd_ia_open(
  */
 static int smbd_post_send_negotiate_req(struct smbd_connection *info)
 {
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct ib_send_wr send_wr;
 	int rc = -ENOMEM;
 	struct smbd_request *request;
-	struct smbd_negotiate_req *packet;
+	struct smbdirect_negotiate_req *packet;
 
 	request = mempool_alloc(info->request_mempool, GFP_KERNEL);
 	if (!request)
@@ -695,29 +704,29 @@ static int smbd_post_send_negotiate_req(struct smbd_connection *info)
 	request->info = info;
 
 	packet = smbd_request_payload(request);
-	packet->min_version = cpu_to_le16(SMBD_V1);
-	packet->max_version = cpu_to_le16(SMBD_V1);
+	packet->min_version = cpu_to_le16(SMBDIRECT_V1);
+	packet->max_version = cpu_to_le16(SMBDIRECT_V1);
 	packet->reserved = 0;
-	packet->credits_requested = cpu_to_le16(info->send_credit_target);
-	packet->preferred_send_size = cpu_to_le32(info->max_send_size);
-	packet->max_receive_size = cpu_to_le32(info->max_receive_size);
+	packet->credits_requested = cpu_to_le16(sp->send_credit_target);
+	packet->preferred_send_size = cpu_to_le32(sp->max_send_size);
+	packet->max_receive_size = cpu_to_le32(sp->max_recv_size);
 	packet->max_fragmented_size =
-		cpu_to_le32(info->max_fragmented_recv_size);
+		cpu_to_le32(sp->max_fragmented_recv_size);
 
 	request->num_sge = 1;
 	request->sge[0].addr = ib_dma_map_single(
-				info->id->device, (void *)packet,
+				sc->ib.dev, (void *)packet,
 				sizeof(*packet), DMA_TO_DEVICE);
-	if (ib_dma_mapping_error(info->id->device, request->sge[0].addr)) {
+	if (ib_dma_mapping_error(sc->ib.dev, request->sge[0].addr)) {
 		rc = -EIO;
 		goto dma_mapping_failed;
 	}
 
 	request->sge[0].length = sizeof(*packet);
-	request->sge[0].lkey = info->pd->local_dma_lkey;
+	request->sge[0].lkey = sc->ib.pd->local_dma_lkey;
 
 	ib_dma_sync_single_for_device(
-		info->id->device, request->sge[0].addr,
+		sc->ib.dev, request->sge[0].addr,
 		request->sge[0].length, DMA_TO_DEVICE);
 
 	request->cqe.done = send_done;
@@ -734,14 +743,14 @@ static int smbd_post_send_negotiate_req(struct smbd_connection *info)
 		request->sge[0].length, request->sge[0].lkey);
 
 	atomic_inc(&info->send_pending);
-	rc = ib_post_send(info->id->qp, &send_wr, NULL);
+	rc = ib_post_send(sc->ib.qp, &send_wr, NULL);
 	if (!rc)
 		return 0;
 
 	/* if we reach here, post send failed */
 	log_rdma_send(ERR, "ib_post_send failed rc=%d\n", rc);
 	atomic_dec(&info->send_pending);
-	ib_dma_unmap_single(info->id->device, request->sge[0].addr,
+	ib_dma_unmap_single(sc->ib.dev, request->sge[0].addr,
 		request->sge[0].length, DMA_TO_DEVICE);
 
 	smbd_disconnect_rdma_connection(info);
@@ -774,10 +783,10 @@ static int manage_credits_prior_sending(struct smbd_connection *info)
 /*
  * Check if we need to send a KEEP_ALIVE message
  * The idle connection timer triggers a KEEP_ALIVE message when expires
- * SMB_DIRECT_RESPONSE_REQUESTED is set in the message flag to have peer send
+ * SMBDIRECT_FLAG_RESPONSE_REQUESTED is set in the message flag to have peer send
  * back a response.
  * return value:
- * 1 if SMB_DIRECT_RESPONSE_REQUESTED needs to be set
+ * 1 if SMBDIRECT_FLAG_RESPONSE_REQUESTED needs to be set
  * 0: otherwise
  */
 static int manage_keep_alive_before_sending(struct smbd_connection *info)
@@ -793,6 +802,8 @@ static int manage_keep_alive_before_sending(struct smbd_connection *info)
 static int smbd_post_send(struct smbd_connection *info,
 		struct smbd_request *request)
 {
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct ib_send_wr send_wr;
 	int rc, i;
 
@@ -801,7 +812,7 @@ static int smbd_post_send(struct smbd_connection *info,
 			"rdma_request sge[%d] addr=0x%llx length=%u\n",
 			i, request->sge[i].addr, request->sge[i].length);
 		ib_dma_sync_single_for_device(
-			info->id->device,
+			sc->ib.dev,
 			request->sge[i].addr,
 			request->sge[i].length,
 			DMA_TO_DEVICE);
@@ -816,7 +827,7 @@ static int smbd_post_send(struct smbd_connection *info,
 	send_wr.opcode = IB_WR_SEND;
 	send_wr.send_flags = IB_SEND_SIGNALED;
 
-	rc = ib_post_send(info->id->qp, &send_wr, NULL);
+	rc = ib_post_send(sc->ib.qp, &send_wr, NULL);
 	if (rc) {
 		log_rdma_send(ERR, "ib_post_send failed rc=%d\n", rc);
 		smbd_disconnect_rdma_connection(info);
@@ -824,7 +835,7 @@ static int smbd_post_send(struct smbd_connection *info,
 	} else
 		/* Reset timer for idle connection after packet is sent */
 		mod_delayed_work(info->workqueue, &info->idle_timer_work,
-			info->keep_alive_interval*HZ);
+			msecs_to_jiffies(sp->keepalive_interval_msec));
 
 	return rc;
 }
@@ -833,22 +844,24 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 			       struct iov_iter *iter,
 			       int *_remaining_data_length)
 {
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	int i, rc;
 	int header_length;
 	int data_length;
 	struct smbd_request *request;
-	struct smbd_data_transfer *packet;
+	struct smbdirect_data_transfer *packet;
 	int new_credits = 0;
 
 wait_credit:
 	/* Wait for send credits. A SMBD packet needs one credit */
 	rc = wait_event_interruptible(info->wait_send_queue,
 		atomic_read(&info->send_credits) > 0 ||
-		info->transport_status != SMBD_CONNECTED);
+		sc->status != SMBDIRECT_SOCKET_CONNECTED);
 	if (rc)
 		goto err_wait_credit;
 
-	if (info->transport_status != SMBD_CONNECTED) {
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		log_outgoing(ERR, "disconnected not sending on wait_credit\n");
 		rc = -EAGAIN;
 		goto err_wait_credit;
@@ -860,17 +873,17 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 
 wait_send_queue:
 	wait_event(info->wait_post_send,
-		atomic_read(&info->send_pending) < info->send_credit_target ||
-		info->transport_status != SMBD_CONNECTED);
+		atomic_read(&info->send_pending) < sp->send_credit_target ||
+		sc->status != SMBDIRECT_SOCKET_CONNECTED);
 
-	if (info->transport_status != SMBD_CONNECTED) {
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		log_outgoing(ERR, "disconnected not sending on wait_send_queue\n");
 		rc = -EAGAIN;
 		goto err_wait_send_queue;
 	}
 
 	if (unlikely(atomic_inc_return(&info->send_pending) >
-				info->send_credit_target)) {
+				sp->send_credit_target)) {
 		atomic_dec(&info->send_pending);
 		goto wait_send_queue;
 	}
@@ -890,8 +903,8 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 			.nr_sge		= 1,
 			.max_sge	= SMBDIRECT_MAX_SEND_SGE,
 			.sge		= request->sge,
-			.device		= info->id->device,
-			.local_dma_lkey	= info->pd->local_dma_lkey,
+			.device		= sc->ib.dev,
+			.local_dma_lkey	= sc->ib.pd->local_dma_lkey,
 			.direction	= DMA_TO_DEVICE,
 		};
 
@@ -909,7 +922,7 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 
 	/* Fill in the packet header */
 	packet = smbd_request_payload(request);
-	packet->credits_requested = cpu_to_le16(info->send_credit_target);
+	packet->credits_requested = cpu_to_le16(sp->send_credit_target);
 
 	new_credits = manage_credits_prior_sending(info);
 	atomic_add(new_credits, &info->receive_credits);
@@ -919,7 +932,7 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 
 	packet->flags = 0;
 	if (manage_keep_alive_before_sending(info))
-		packet->flags |= cpu_to_le16(SMB_DIRECT_RESPONSE_REQUESTED);
+		packet->flags |= cpu_to_le16(SMBDIRECT_FLAG_RESPONSE_REQUESTED);
 
 	packet->reserved = 0;
 	if (!data_length)
@@ -938,23 +951,23 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 		     le32_to_cpu(packet->remaining_data_length));
 
 	/* Map the packet to DMA */
-	header_length = sizeof(struct smbd_data_transfer);
+	header_length = sizeof(struct smbdirect_data_transfer);
 	/* If this is a packet without payload, don't send padding */
 	if (!data_length)
-		header_length = offsetof(struct smbd_data_transfer, padding);
+		header_length = offsetof(struct smbdirect_data_transfer, padding);
 
-	request->sge[0].addr = ib_dma_map_single(info->id->device,
+	request->sge[0].addr = ib_dma_map_single(sc->ib.dev,
 						 (void *)packet,
 						 header_length,
 						 DMA_TO_DEVICE);
-	if (ib_dma_mapping_error(info->id->device, request->sge[0].addr)) {
+	if (ib_dma_mapping_error(sc->ib.dev, request->sge[0].addr)) {
 		rc = -EIO;
 		request->sge[0].addr = 0;
 		goto err_dma;
 	}
 
 	request->sge[0].length = header_length;
-	request->sge[0].lkey = info->pd->local_dma_lkey;
+	request->sge[0].lkey = sc->ib.pd->local_dma_lkey;
 
 	rc = smbd_post_send(info, request);
 	if (!rc)
@@ -963,7 +976,7 @@ static int smbd_post_send_iter(struct smbd_connection *info,
 err_dma:
 	for (i = 0; i < request->num_sge; i++)
 		if (request->sge[i].addr)
-			ib_dma_unmap_single(info->id->device,
+			ib_dma_unmap_single(sc->ib.dev,
 					    request->sge[i].addr,
 					    request->sge[i].length,
 					    DMA_TO_DEVICE);
@@ -1008,17 +1021,19 @@ static int smbd_post_send_empty(struct smbd_connection *info)
 static int smbd_post_recv(
 		struct smbd_connection *info, struct smbd_response *response)
 {
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct ib_recv_wr recv_wr;
 	int rc = -EIO;
 
 	response->sge.addr = ib_dma_map_single(
-				info->id->device, response->packet,
-				info->max_receive_size, DMA_FROM_DEVICE);
-	if (ib_dma_mapping_error(info->id->device, response->sge.addr))
+				sc->ib.dev, response->packet,
+				sp->max_recv_size, DMA_FROM_DEVICE);
+	if (ib_dma_mapping_error(sc->ib.dev, response->sge.addr))
 		return rc;
 
-	response->sge.length = info->max_receive_size;
-	response->sge.lkey = info->pd->local_dma_lkey;
+	response->sge.length = sp->max_recv_size;
+	response->sge.lkey = sc->ib.pd->local_dma_lkey;
 
 	response->cqe.done = recv_done;
 
@@ -1027,9 +1042,9 @@ static int smbd_post_recv(
 	recv_wr.sg_list = &response->sge;
 	recv_wr.num_sge = 1;
 
-	rc = ib_post_recv(info->id->qp, &recv_wr, NULL);
+	rc = ib_post_recv(sc->ib.qp, &recv_wr, NULL);
 	if (rc) {
-		ib_dma_unmap_single(info->id->device, response->sge.addr,
+		ib_dma_unmap_single(sc->ib.dev, response->sge.addr,
 				    response->sge.length, DMA_FROM_DEVICE);
 		smbd_disconnect_rdma_connection(info);
 		log_rdma_recv(ERR, "ib_post_recv failed rc=%d\n", rc);
@@ -1187,9 +1202,10 @@ static struct smbd_response *get_receive_buffer(struct smbd_connection *info)
 static void put_receive_buffer(
 	struct smbd_connection *info, struct smbd_response *response)
 {
+	struct smbdirect_socket *sc = &info->socket;
 	unsigned long flags;
 
-	ib_dma_unmap_single(info->id->device, response->sge.addr,
+	ib_dma_unmap_single(sc->ib.dev, response->sge.addr,
 		response->sge.length, DMA_FROM_DEVICE);
 
 	spin_lock_irqsave(&info->receive_queue_lock, flags);
@@ -1264,6 +1280,8 @@ static void idle_connection_timer(struct work_struct *work)
 	struct smbd_connection *info = container_of(
 					work, struct smbd_connection,
 					idle_timer_work.work);
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 
 	if (info->keep_alive_requested != KEEP_ALIVE_NONE) {
 		log_keep_alive(ERR,
@@ -1278,7 +1296,7 @@ static void idle_connection_timer(struct work_struct *work)
 
 	/* Setup the next idle timeout work */
 	queue_delayed_work(info->workqueue, &info->idle_timer_work,
-			info->keep_alive_interval*HZ);
+			msecs_to_jiffies(sp->keepalive_interval_msec));
 }
 
 /*
@@ -1289,6 +1307,8 @@ static void idle_connection_timer(struct work_struct *work)
 void smbd_destroy(struct TCP_Server_Info *server)
 {
 	struct smbd_connection *info = server->smbd_conn;
+	struct smbdirect_socket *sc;
+	struct smbdirect_socket_parameters *sp;
 	struct smbd_response *response;
 	unsigned long flags;
 
@@ -1296,19 +1316,22 @@ void smbd_destroy(struct TCP_Server_Info *server)
 		log_rdma_event(INFO, "rdma session already destroyed\n");
 		return;
 	}
+	sc = &info->socket;
+	sp = &sc->parameters;
 
 	log_rdma_event(INFO, "destroying rdma session\n");
-	if (info->transport_status != SMBD_DISCONNECTED) {
-		rdma_disconnect(server->smbd_conn->id);
+	if (sc->status != SMBDIRECT_SOCKET_DISCONNECTED) {
+		rdma_disconnect(sc->rdma.cm_id);
 		log_rdma_event(INFO, "wait for transport being disconnected\n");
 		wait_event_interruptible(
 			info->disconn_wait,
-			info->transport_status == SMBD_DISCONNECTED);
+			sc->status == SMBDIRECT_SOCKET_DISCONNECTED);
 	}
 
 	log_rdma_event(INFO, "destroying qp\n");
-	ib_drain_qp(info->id->qp);
-	rdma_destroy_qp(info->id);
+	ib_drain_qp(sc->ib.qp);
+	rdma_destroy_qp(sc->rdma.cm_id);
+	sc->ib.qp = NULL;
 
 	log_rdma_event(INFO, "cancelling idle timer\n");
 	cancel_delayed_work_sync(&info->idle_timer_work);
@@ -1336,7 +1359,7 @@ void smbd_destroy(struct TCP_Server_Info *server)
 	log_rdma_event(INFO, "free receive buffers\n");
 	wait_event(info->wait_receive_queues,
 		info->count_receive_queue + info->count_empty_packet_queue
-			== info->receive_credit_max);
+			== sp->recv_credit_max);
 	destroy_receive_buffers(info);
 
 	/*
@@ -1355,10 +1378,10 @@ void smbd_destroy(struct TCP_Server_Info *server)
 	}
 	destroy_mr_list(info);
 
-	ib_free_cq(info->send_cq);
-	ib_free_cq(info->recv_cq);
-	ib_dealloc_pd(info->pd);
-	rdma_destroy_id(info->id);
+	ib_free_cq(sc->ib.send_cq);
+	ib_free_cq(sc->ib.recv_cq);
+	ib_dealloc_pd(sc->ib.pd);
+	rdma_destroy_id(sc->rdma.cm_id);
 
 	/* free mempools */
 	mempool_destroy(info->request_mempool);
@@ -1367,7 +1390,7 @@ void smbd_destroy(struct TCP_Server_Info *server)
 	mempool_destroy(info->response_mempool);
 	kmem_cache_destroy(info->response_cache);
 
-	info->transport_status = SMBD_DESTROYED;
+	sc->status = SMBDIRECT_SOCKET_DESTROYED;
 
 	destroy_workqueue(info->workqueue);
 	log_rdma_event(INFO,  "rdma session destroyed\n");
@@ -1392,7 +1415,7 @@ int smbd_reconnect(struct TCP_Server_Info *server)
 	 * This is possible if transport is disconnected and we haven't received
 	 * notification from RDMA, but upper layer has detected timeout
 	 */
-	if (server->smbd_conn->transport_status == SMBD_CONNECTED) {
+	if (server->smbd_conn->socket.status == SMBDIRECT_SOCKET_CONNECTED) {
 		log_rdma_event(INFO, "disconnecting transport\n");
 		smbd_destroy(server);
 	}
@@ -1424,37 +1447,47 @@ static void destroy_caches_and_workqueue(struct smbd_connection *info)
 #define MAX_NAME_LEN	80
 static int allocate_caches_and_workqueue(struct smbd_connection *info)
 {
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	char name[MAX_NAME_LEN];
 	int rc;
 
+	if (WARN_ON_ONCE(sp->max_recv_size < sizeof(struct smbdirect_data_transfer)))
+		return -ENOMEM;
+
 	scnprintf(name, MAX_NAME_LEN, "smbd_request_%p", info);
 	info->request_cache =
 		kmem_cache_create(
 			name,
 			sizeof(struct smbd_request) +
-				sizeof(struct smbd_data_transfer),
+				sizeof(struct smbdirect_data_transfer),
 			0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!info->request_cache)
 		return -ENOMEM;
 
 	info->request_mempool =
-		mempool_create(info->send_credit_target, mempool_alloc_slab,
+		mempool_create(sp->send_credit_target, mempool_alloc_slab,
 			mempool_free_slab, info->request_cache);
 	if (!info->request_mempool)
 		goto out1;
 
 	scnprintf(name, MAX_NAME_LEN, "smbd_response_%p", info);
+
+	struct kmem_cache_args response_args = {
+		.align		= __alignof__(struct smbd_response),
+		.useroffset	= (offsetof(struct smbd_response, packet) +
+				   sizeof(struct smbdirect_data_transfer)),
+		.usersize	= sp->max_recv_size - sizeof(struct smbdirect_data_transfer),
+	};
 	info->response_cache =
-		kmem_cache_create(
-			name,
-			sizeof(struct smbd_response) +
-				info->max_receive_size,
-			0, SLAB_HWCACHE_ALIGN, NULL);
+		kmem_cache_create(name,
+				  sizeof(struct smbd_response) + sp->max_recv_size,
+				  &response_args, SLAB_HWCACHE_ALIGN);
 	if (!info->response_cache)
 		goto out2;
 
 	info->response_mempool =
-		mempool_create(info->receive_credit_max, mempool_alloc_slab,
+		mempool_create(sp->recv_credit_max, mempool_alloc_slab,
 		       mempool_free_slab, info->response_cache);
 	if (!info->response_mempool)
 		goto out3;
@@ -1464,7 +1497,7 @@ static int allocate_caches_and_workqueue(struct smbd_connection *info)
 	if (!info->workqueue)
 		goto out4;
 
-	rc = allocate_receive_buffers(info, info->receive_credit_max);
+	rc = allocate_receive_buffers(info, sp->recv_credit_max);
 	if (rc) {
 		log_rdma_event(ERR, "failed to allocate receive buffers\n");
 		goto out5;
@@ -1491,6 +1524,8 @@ static struct smbd_connection *_smbd_get_connection(
 {
 	int rc;
 	struct smbd_connection *info;
+	struct smbdirect_socket *sc;
+	struct smbdirect_socket_parameters *sp;
 	struct rdma_conn_param conn_param;
 	struct ib_qp_init_attr qp_attr;
 	struct sockaddr_in *addr_in = (struct sockaddr_in *) dstaddr;
@@ -1500,101 +1535,102 @@ static struct smbd_connection *_smbd_get_connection(
 	info = kzalloc(sizeof(struct smbd_connection), GFP_KERNEL);
 	if (!info)
 		return NULL;
+	sc = &info->socket;
+	sp = &sc->parameters;
 
-	info->transport_status = SMBD_CONNECTING;
+	sc->status = SMBDIRECT_SOCKET_CONNECTING;
 	rc = smbd_ia_open(info, dstaddr, port);
 	if (rc) {
 		log_rdma_event(INFO, "smbd_ia_open rc=%d\n", rc);
 		goto create_id_failed;
 	}
 
-	if (smbd_send_credit_target > info->id->device->attrs.max_cqe ||
-	    smbd_send_credit_target > info->id->device->attrs.max_qp_wr) {
+	if (smbd_send_credit_target > sc->ib.dev->attrs.max_cqe ||
+	    smbd_send_credit_target > sc->ib.dev->attrs.max_qp_wr) {
 		log_rdma_event(ERR, "consider lowering send_credit_target = %d. Possible CQE overrun, device reporting max_cqe %d max_qp_wr %d\n",
 			       smbd_send_credit_target,
-			       info->id->device->attrs.max_cqe,
-			       info->id->device->attrs.max_qp_wr);
+			       sc->ib.dev->attrs.max_cqe,
+			       sc->ib.dev->attrs.max_qp_wr);
 		goto config_failed;
 	}
 
-	if (smbd_receive_credit_max > info->id->device->attrs.max_cqe ||
-	    smbd_receive_credit_max > info->id->device->attrs.max_qp_wr) {
+	if (smbd_receive_credit_max > sc->ib.dev->attrs.max_cqe ||
+	    smbd_receive_credit_max > sc->ib.dev->attrs.max_qp_wr) {
 		log_rdma_event(ERR, "consider lowering receive_credit_max = %d. Possible CQE overrun, device reporting max_cqe %d max_qp_wr %d\n",
 			       smbd_receive_credit_max,
-			       info->id->device->attrs.max_cqe,
-			       info->id->device->attrs.max_qp_wr);
+			       sc->ib.dev->attrs.max_cqe,
+			       sc->ib.dev->attrs.max_qp_wr);
 		goto config_failed;
 	}
 
-	info->receive_credit_max = smbd_receive_credit_max;
-	info->send_credit_target = smbd_send_credit_target;
-	info->max_send_size = smbd_max_send_size;
-	info->max_fragmented_recv_size = smbd_max_fragmented_recv_size;
-	info->max_receive_size = smbd_max_receive_size;
-	info->keep_alive_interval = smbd_keep_alive_interval;
+	sp->recv_credit_max = smbd_receive_credit_max;
+	sp->send_credit_target = smbd_send_credit_target;
+	sp->max_send_size = smbd_max_send_size;
+	sp->max_fragmented_recv_size = smbd_max_fragmented_recv_size;
+	sp->max_recv_size = smbd_max_receive_size;
+	sp->keepalive_interval_msec = smbd_keep_alive_interval * 1000;
 
-	if (info->id->device->attrs.max_send_sge < SMBDIRECT_MAX_SEND_SGE ||
-	    info->id->device->attrs.max_recv_sge < SMBDIRECT_MAX_RECV_SGE) {
+	if (sc->ib.dev->attrs.max_send_sge < SMBDIRECT_MAX_SEND_SGE ||
+	    sc->ib.dev->attrs.max_recv_sge < SMBDIRECT_MAX_RECV_SGE) {
 		log_rdma_event(ERR,
 			"device %.*s max_send_sge/max_recv_sge = %d/%d too small\n",
 			IB_DEVICE_NAME_MAX,
-			info->id->device->name,
-			info->id->device->attrs.max_send_sge,
-			info->id->device->attrs.max_recv_sge);
+			sc->ib.dev->name,
+			sc->ib.dev->attrs.max_send_sge,
+			sc->ib.dev->attrs.max_recv_sge);
 		goto config_failed;
 	}
 
-	info->send_cq = NULL;
-	info->recv_cq = NULL;
-	info->send_cq =
-		ib_alloc_cq_any(info->id->device, info,
-				info->send_credit_target, IB_POLL_SOFTIRQ);
-	if (IS_ERR(info->send_cq)) {
-		info->send_cq = NULL;
+	sc->ib.send_cq =
+		ib_alloc_cq_any(sc->ib.dev, info,
+				sp->send_credit_target, IB_POLL_SOFTIRQ);
+	if (IS_ERR(sc->ib.send_cq)) {
+		sc->ib.send_cq = NULL;
 		goto alloc_cq_failed;
 	}
 
-	info->recv_cq =
-		ib_alloc_cq_any(info->id->device, info,
-				info->receive_credit_max, IB_POLL_SOFTIRQ);
-	if (IS_ERR(info->recv_cq)) {
-		info->recv_cq = NULL;
+	sc->ib.recv_cq =
+		ib_alloc_cq_any(sc->ib.dev, info,
+				sp->recv_credit_max, IB_POLL_SOFTIRQ);
+	if (IS_ERR(sc->ib.recv_cq)) {
+		sc->ib.recv_cq = NULL;
 		goto alloc_cq_failed;
 	}
 
 	memset(&qp_attr, 0, sizeof(qp_attr));
 	qp_attr.event_handler = smbd_qp_async_error_upcall;
 	qp_attr.qp_context = info;
-	qp_attr.cap.max_send_wr = info->send_credit_target;
-	qp_attr.cap.max_recv_wr = info->receive_credit_max;
+	qp_attr.cap.max_send_wr = sp->send_credit_target;
+	qp_attr.cap.max_recv_wr = sp->recv_credit_max;
 	qp_attr.cap.max_send_sge = SMBDIRECT_MAX_SEND_SGE;
 	qp_attr.cap.max_recv_sge = SMBDIRECT_MAX_RECV_SGE;
 	qp_attr.cap.max_inline_data = 0;
 	qp_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
 	qp_attr.qp_type = IB_QPT_RC;
-	qp_attr.send_cq = info->send_cq;
-	qp_attr.recv_cq = info->recv_cq;
+	qp_attr.send_cq = sc->ib.send_cq;
+	qp_attr.recv_cq = sc->ib.recv_cq;
 	qp_attr.port_num = ~0;
 
-	rc = rdma_create_qp(info->id, info->pd, &qp_attr);
+	rc = rdma_create_qp(sc->rdma.cm_id, sc->ib.pd, &qp_attr);
 	if (rc) {
 		log_rdma_event(ERR, "rdma_create_qp failed %i\n", rc);
 		goto create_qp_failed;
 	}
+	sc->ib.qp = sc->rdma.cm_id->qp;
 
 	memset(&conn_param, 0, sizeof(conn_param));
 	conn_param.initiator_depth = 0;
 
 	conn_param.responder_resources =
-		min(info->id->device->attrs.max_qp_rd_atom,
+		min(sc->ib.dev->attrs.max_qp_rd_atom,
 		    SMBD_CM_RESPONDER_RESOURCES);
 	info->responder_resources = conn_param.responder_resources;
 	log_rdma_mr(INFO, "responder_resources=%d\n",
 		info->responder_resources);
 
 	/* Need to send IRD/ORD in private data for iWARP */
-	info->id->device->ops.get_port_immutable(
-		info->id->device, info->id->port_num, &port_immutable);
+	sc->ib.dev->ops.get_port_immutable(
+		sc->ib.dev, sc->rdma.cm_id->port_num, &port_immutable);
 	if (port_immutable.core_cap_flags & RDMA_CORE_PORT_IWARP) {
 		ird_ord_hdr[0] = info->responder_resources;
 		ird_ord_hdr[1] = 1;
@@ -1615,16 +1651,16 @@ static struct smbd_connection *_smbd_get_connection(
 	init_waitqueue_head(&info->conn_wait);
 	init_waitqueue_head(&info->disconn_wait);
 	init_waitqueue_head(&info->wait_reassembly_queue);
-	rc = rdma_connect(info->id, &conn_param);
+	rc = rdma_connect(sc->rdma.cm_id, &conn_param);
 	if (rc) {
 		log_rdma_event(ERR, "rdma_connect() failed with %i\n", rc);
 		goto rdma_connect_failed;
 	}
 
 	wait_event_interruptible(
-		info->conn_wait, info->transport_status != SMBD_CONNECTING);
+		info->conn_wait, sc->status != SMBDIRECT_SOCKET_CONNECTING);
 
-	if (info->transport_status != SMBD_CONNECTED) {
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		log_rdma_event(ERR, "rdma_connect failed port=%d\n", port);
 		goto rdma_connect_failed;
 	}
@@ -1640,7 +1676,7 @@ static struct smbd_connection *_smbd_get_connection(
 	init_waitqueue_head(&info->wait_send_queue);
 	INIT_DELAYED_WORK(&info->idle_timer_work, idle_connection_timer);
 	queue_delayed_work(info->workqueue, &info->idle_timer_work,
-		info->keep_alive_interval*HZ);
+		msecs_to_jiffies(sp->keepalive_interval_msec));
 
 	init_waitqueue_head(&info->wait_send_pending);
 	atomic_set(&info->send_pending, 0);
@@ -1675,26 +1711,26 @@ static struct smbd_connection *_smbd_get_connection(
 negotiation_failed:
 	cancel_delayed_work_sync(&info->idle_timer_work);
 	destroy_caches_and_workqueue(info);
-	info->transport_status = SMBD_NEGOTIATE_FAILED;
+	sc->status = SMBDIRECT_SOCKET_NEGOTIATE_FAILED;
 	init_waitqueue_head(&info->conn_wait);
-	rdma_disconnect(info->id);
+	rdma_disconnect(sc->rdma.cm_id);
 	wait_event(info->conn_wait,
-		info->transport_status == SMBD_DISCONNECTED);
+		sc->status == SMBDIRECT_SOCKET_DISCONNECTED);
 
 allocate_cache_failed:
 rdma_connect_failed:
-	rdma_destroy_qp(info->id);
+	rdma_destroy_qp(sc->rdma.cm_id);
 
 create_qp_failed:
 alloc_cq_failed:
-	if (info->send_cq)
-		ib_free_cq(info->send_cq);
-	if (info->recv_cq)
-		ib_free_cq(info->recv_cq);
+	if (sc->ib.send_cq)
+		ib_free_cq(sc->ib.send_cq);
+	if (sc->ib.recv_cq)
+		ib_free_cq(sc->ib.recv_cq);
 
 config_failed:
-	ib_dealloc_pd(info->pd);
-	rdma_destroy_id(info->id);
+	ib_dealloc_pd(sc->ib.pd);
+	rdma_destroy_id(sc->rdma.cm_id);
 
 create_id_failed:
 	kfree(info);
@@ -1719,34 +1755,39 @@ struct smbd_connection *smbd_get_connection(
 }
 
 /*
- * Receive data from receive reassembly queue
+ * Receive data from the transport's receive reassembly queue
  * All the incoming data packets are placed in reassembly queue
- * buf: the buffer to read data into
+ * iter: the buffer to read data into
  * size: the length of data to read
  * return value: actual data read
- * Note: this implementation copies the data from reassebmly queue to receive
+ *
+ * Note: this implementation copies the data from reassembly queue to receive
  * buffers used by upper layer. This is not the optimal code path. A better way
  * to do it is to not have upper layer allocate its receive buffers but rather
  * borrow the buffer from reassembly queue, and return it after data is
  * consumed. But this will require more changes to upper layer code, and also
  * need to consider packet boundaries while they still being reassembled.
  */
-static int smbd_recv_buf(struct smbd_connection *info, char *buf,
-		unsigned int size)
+int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 {
+	struct smbdirect_socket *sc = &info->socket;
 	struct smbd_response *response;
-	struct smbd_data_transfer *data_transfer;
+	struct smbdirect_data_transfer *data_transfer;
+	size_t size = iov_iter_count(&msg->msg_iter);
 	int to_copy, to_read, data_read, offset;
 	u32 data_length, remaining_data_length, data_offset;
 	int rc;
 
+	if (WARN_ON_ONCE(iov_iter_rw(&msg->msg_iter) == WRITE))
+		return -EINVAL; /* It's a bug in upper layer to get there */
+
 again:
 	/*
 	 * No need to hold the reassembly queue lock all the time as we are
 	 * the only one reading from the front of the queue. The transport
 	 * may add more entries to the back of the queue at the same time
 	 */
-	log_read(INFO, "size=%d info->reassembly_data_length=%d\n", size,
+	log_read(INFO, "size=%zd info->reassembly_data_length=%d\n", size,
 		info->reassembly_data_length);
 	if (info->reassembly_data_length >= size) {
 		int queue_length;
@@ -1784,7 +1825,10 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 			if (response->first_segment && size == 4) {
 				unsigned int rfc1002_len =
 					data_length + remaining_data_length;
-				*((__be32 *)buf) = cpu_to_be32(rfc1002_len);
+				__be32 rfc1002_hdr = cpu_to_be32(rfc1002_len);
+				if (copy_to_iter(&rfc1002_hdr, sizeof(rfc1002_hdr),
+						 &msg->msg_iter) != sizeof(rfc1002_hdr))
+					return -EFAULT;
 				data_read = 4;
 				response->first_segment = false;
 				log_read(INFO, "returning rfc1002 length %d\n",
@@ -1793,10 +1837,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 			}
 
 			to_copy = min_t(int, data_length - offset, to_read);
-			memcpy(
-				buf + data_read,
-				(char *)data_transfer + data_offset + offset,
-				to_copy);
+			if (copy_to_iter((char *)data_transfer + data_offset + offset,
+					 to_copy, &msg->msg_iter) != to_copy)
+				return -EFAULT;
 
 			/* move on to the next buffer? */
 			if (to_copy == data_length - offset) {
@@ -1848,12 +1891,12 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 	rc = wait_event_interruptible(
 		info->wait_reassembly_queue,
 		info->reassembly_data_length >= size ||
-			info->transport_status != SMBD_CONNECTED);
+			sc->status != SMBDIRECT_SOCKET_CONNECTED);
 	/* Don't return any data if interrupted */
 	if (rc)
 		return rc;
 
-	if (info->transport_status != SMBD_CONNECTED) {
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
 		log_read(ERR, "disconnected\n");
 		return -ECONNABORTED;
 	}
@@ -1861,89 +1904,6 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 	goto again;
 }
 
-/*
- * Receive a page from receive reassembly queue
- * page: the page to read data into
- * to_read: the length of data to read
- * return value: actual data read
- */
-static int smbd_recv_page(struct smbd_connection *info,
-		struct page *page, unsigned int page_offset,
-		unsigned int to_read)
-{
-	int ret;
-	char *to_address;
-	void *page_address;
-
-	/* make sure we have the page ready for read */
-	ret = wait_event_interruptible(
-		info->wait_reassembly_queue,
-		info->reassembly_data_length >= to_read ||
-			info->transport_status != SMBD_CONNECTED);
-	if (ret)
-		return ret;
-
-	/* now we can read from reassembly queue and not sleep */
-	page_address = kmap_atomic(page);
-	to_address = (char *) page_address + page_offset;
-
-	log_read(INFO, "reading from page=%p address=%p to_read=%d\n",
-		page, to_address, to_read);
-
-	ret = smbd_recv_buf(info, to_address, to_read);
-	kunmap_atomic(page_address);
-
-	return ret;
-}
-
-/*
- * Receive data from transport
- * msg: a msghdr point to the buffer, can be ITER_KVEC or ITER_BVEC
- * return: total bytes read, or 0. SMB Direct will not do partial read.
- */
-int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
-{
-	char *buf;
-	struct page *page;
-	unsigned int to_read, page_offset;
-	int rc;
-
-	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
-			 iov_iter_rw(&msg->msg_iter));
-		rc = -EINVAL;
-		goto out;
-	}
-
-	switch (iov_iter_type(&msg->msg_iter)) {
-	case ITER_KVEC:
-		buf = msg->msg_iter.kvec->iov_base;
-		to_read = msg->msg_iter.kvec->iov_len;
-		rc = smbd_recv_buf(info, buf, to_read);
-		break;
-
-	case ITER_BVEC:
-		page = msg->msg_iter.bvec->bv_page;
-		page_offset = msg->msg_iter.bvec->bv_offset;
-		to_read = msg->msg_iter.bvec->bv_len;
-		rc = smbd_recv_page(info, page, page_offset, to_read);
-		break;
-
-	default:
-		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "Invalid msg type %d\n",
-			 iov_iter_type(&msg->msg_iter));
-		rc = -EINVAL;
-	}
-
-out:
-	/* SMBDirect will read it all or nothing */
-	if (rc > 0)
-		msg->msg_iter.count = 0;
-	return rc;
-}
-
 /*
  * Send data to transport
  * Each rqst is transported as a SMBDirect payload
@@ -1954,12 +1914,14 @@ int smbd_send(struct TCP_Server_Info *server,
 	int num_rqst, struct smb_rqst *rqst_array)
 {
 	struct smbd_connection *info = server->smbd_conn;
+	struct smbdirect_socket *sc = &info->socket;
+	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	struct smb_rqst *rqst;
 	struct iov_iter iter;
 	unsigned int remaining_data_length, klen;
 	int rc, i, rqst_idx;
 
-	if (info->transport_status != SMBD_CONNECTED)
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED)
 		return -EAGAIN;
 
 	/*
@@ -1971,10 +1933,10 @@ int smbd_send(struct TCP_Server_Info *server,
 	for (i = 0; i < num_rqst; i++)
 		remaining_data_length += smb_rqst_len(server, &rqst_array[i]);
 
-	if (unlikely(remaining_data_length > info->max_fragmented_send_size)) {
+	if (unlikely(remaining_data_length > sp->max_fragmented_send_size)) {
 		/* assertion: payload never exceeds negotiated maximum */
 		log_write(ERR, "payload size %d > max size %d\n",
-			remaining_data_length, info->max_fragmented_send_size);
+			remaining_data_length, sp->max_fragmented_send_size);
 		return -EINVAL;
 	}
 
@@ -2053,6 +2015,7 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 {
 	struct smbd_connection *info =
 		container_of(work, struct smbd_connection, mr_recovery_work);
+	struct smbdirect_socket *sc = &info->socket;
 	struct smbd_mr *smbdirect_mr;
 	int rc;
 
@@ -2070,7 +2033,7 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 			}
 
 			smbdirect_mr->mr = ib_alloc_mr(
-				info->pd, info->mr_type,
+				sc->ib.pd, info->mr_type,
 				info->max_frmr_depth);
 			if (IS_ERR(smbdirect_mr->mr)) {
 				log_rdma_mr(ERR, "ib_alloc_mr failed mr_type=%x max_frmr_depth=%x\n",
@@ -2099,12 +2062,13 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 
 static void destroy_mr_list(struct smbd_connection *info)
 {
+	struct smbdirect_socket *sc = &info->socket;
 	struct smbd_mr *mr, *tmp;
 
 	cancel_work_sync(&info->mr_recovery_work);
 	list_for_each_entry_safe(mr, tmp, &info->mr_list, list) {
 		if (mr->state == MR_INVALIDATED)
-			ib_dma_unmap_sg(info->id->device, mr->sgt.sgl,
+			ib_dma_unmap_sg(sc->ib.dev, mr->sgt.sgl,
 				mr->sgt.nents, mr->dir);
 		ib_dereg_mr(mr->mr);
 		kfree(mr->sgt.sgl);
@@ -2121,6 +2085,7 @@ static void destroy_mr_list(struct smbd_connection *info)
  */
 static int allocate_mr_list(struct smbd_connection *info)
 {
+	struct smbdirect_socket *sc = &info->socket;
 	int i;
 	struct smbd_mr *smbdirect_mr, *tmp;
 
@@ -2136,7 +2101,7 @@ static int allocate_mr_list(struct smbd_connection *info)
 		smbdirect_mr = kzalloc(sizeof(*smbdirect_mr), GFP_KERNEL);
 		if (!smbdirect_mr)
 			goto cleanup_entries;
-		smbdirect_mr->mr = ib_alloc_mr(info->pd, info->mr_type,
+		smbdirect_mr->mr = ib_alloc_mr(sc->ib.pd, info->mr_type,
 					info->max_frmr_depth);
 		if (IS_ERR(smbdirect_mr->mr)) {
 			log_rdma_mr(ERR, "ib_alloc_mr failed mr_type=%x max_frmr_depth=%x\n",
@@ -2181,20 +2146,20 @@ static int allocate_mr_list(struct smbd_connection *info)
  */
 static struct smbd_mr *get_mr(struct smbd_connection *info)
 {
+	struct smbdirect_socket *sc = &info->socket;
 	struct smbd_mr *ret;
 	int rc;
 again:
 	rc = wait_event_interruptible(info->wait_mr,
 		atomic_read(&info->mr_ready_count) ||
-		info->transport_status != SMBD_CONNECTED);
+		sc->status != SMBDIRECT_SOCKET_CONNECTED);
 	if (rc) {
 		log_rdma_mr(ERR, "wait_event_interruptible rc=%x\n", rc);
 		return NULL;
 	}
 
-	if (info->transport_status != SMBD_CONNECTED) {
-		log_rdma_mr(ERR, "info->transport_status=%x\n",
-			info->transport_status);
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
+		log_rdma_mr(ERR, "sc->status=%x\n", sc->status);
 		return NULL;
 	}
 
@@ -2247,6 +2212,7 @@ struct smbd_mr *smbd_register_mr(struct smbd_connection *info,
 				 struct iov_iter *iter,
 				 bool writing, bool need_invalidate)
 {
+	struct smbdirect_socket *sc = &info->socket;
 	struct smbd_mr *smbdirect_mr;
 	int rc, num_pages;
 	enum dma_data_direction dir;
@@ -2276,7 +2242,7 @@ struct smbd_mr *smbd_register_mr(struct smbd_connection *info,
 		    num_pages, iov_iter_count(iter), info->max_frmr_depth);
 	smbd_iter_to_mr(info, iter, &smbdirect_mr->sgt, info->max_frmr_depth);
 
-	rc = ib_dma_map_sg(info->id->device, smbdirect_mr->sgt.sgl,
+	rc = ib_dma_map_sg(sc->ib.dev, smbdirect_mr->sgt.sgl,
 			   smbdirect_mr->sgt.nents, dir);
 	if (!rc) {
 		log_rdma_mr(ERR, "ib_dma_map_sg num_pages=%x dir=%x rc=%x\n",
@@ -2312,7 +2278,7 @@ struct smbd_mr *smbd_register_mr(struct smbd_connection *info,
 	 * on IB_WR_REG_MR. Hardware enforces a barrier and order of execution
 	 * on the next ib_post_send when we actually send I/O to remote peer
 	 */
-	rc = ib_post_send(info->id->qp, &reg_wr->wr, NULL);
+	rc = ib_post_send(sc->ib.qp, &reg_wr->wr, NULL);
 	if (!rc)
 		return smbdirect_mr;
 
@@ -2321,7 +2287,7 @@ struct smbd_mr *smbd_register_mr(struct smbd_connection *info,
 
 	/* If all failed, attempt to recover this MR by setting it MR_ERROR*/
 map_mr_error:
-	ib_dma_unmap_sg(info->id->device, smbdirect_mr->sgt.sgl,
+	ib_dma_unmap_sg(sc->ib.dev, smbdirect_mr->sgt.sgl,
 			smbdirect_mr->sgt.nents, smbdirect_mr->dir);
 
 dma_map_error:
@@ -2359,6 +2325,7 @@ int smbd_deregister_mr(struct smbd_mr *smbdirect_mr)
 {
 	struct ib_send_wr *wr;
 	struct smbd_connection *info = smbdirect_mr->conn;
+	struct smbdirect_socket *sc = &info->socket;
 	int rc = 0;
 
 	if (smbdirect_mr->need_invalidate) {
@@ -2372,7 +2339,7 @@ int smbd_deregister_mr(struct smbd_mr *smbdirect_mr)
 		wr->send_flags = IB_SEND_SIGNALED;
 
 		init_completion(&smbdirect_mr->invalidate_done);
-		rc = ib_post_send(info->id->qp, wr, NULL);
+		rc = ib_post_send(sc->ib.qp, wr, NULL);
 		if (rc) {
 			log_rdma_mr(ERR, "ib_post_send failed rc=%x\n", rc);
 			smbd_disconnect_rdma_connection(info);
@@ -2389,7 +2356,7 @@ int smbd_deregister_mr(struct smbd_mr *smbdirect_mr)
 
 	if (smbdirect_mr->state == MR_INVALIDATED) {
 		ib_dma_unmap_sg(
-			info->id->device, smbdirect_mr->sgt.sgl,
+			sc->ib.dev, smbdirect_mr->sgt.sgl,
 			smbdirect_mr->sgt.nents,
 			smbdirect_mr->dir);
 		smbdirect_mr->state = MR_READY;
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index c08e3665150d..3d552ab27e0f 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -15,6 +15,9 @@
 #include <rdma/rdma_cm.h>
 #include <linux/mempool.h>
 
+#include "../common/smbdirect/smbdirect.h"
+#include "../common/smbdirect/smbdirect_socket.h"
+
 extern int rdma_readwrite_threshold;
 extern int smbd_max_frmr_depth;
 extern int smbd_keep_alive_interval;
@@ -50,14 +53,8 @@ enum smbd_connection_status {
  * 5. mempools for allocating packets
  */
 struct smbd_connection {
-	enum smbd_connection_status transport_status;
-
-	/* RDMA related */
-	struct rdma_cm_id *id;
-	struct ib_qp_init_attr qp_attr;
-	struct ib_pd *pd;
-	struct ib_cq *send_cq, *recv_cq;
-	struct ib_device_attr dev_attr;
+	struct smbdirect_socket socket;
+
 	int ri_rc;
 	struct completion ri_done;
 	wait_queue_head_t conn_wait;
@@ -72,15 +69,7 @@ struct smbd_connection {
 	spinlock_t lock_new_credits_offered;
 	int new_credits_offered;
 
-	/* Connection parameters defined in [MS-SMBD] 3.1.1.1 */
-	int receive_credit_max;
-	int send_credit_target;
-	int max_send_size;
-	int max_fragmented_recv_size;
-	int max_fragmented_send_size;
-	int max_receive_size;
-	int keep_alive_interval;
-	int max_readwrite_size;
+	/* dynamic connection parameters defined in [MS-SMBD] 3.1.1.1 */
 	enum keep_alive_status keep_alive_requested;
 	int protocol;
 	atomic_t send_credits;
@@ -177,47 +166,6 @@ enum smbd_message_type {
 	SMBD_TRANSFER_DATA,
 };
 
-#define SMB_DIRECT_RESPONSE_REQUESTED 0x0001
-
-/* SMBD negotiation request packet [MS-SMBD] 2.2.1 */
-struct smbd_negotiate_req {
-	__le16 min_version;
-	__le16 max_version;
-	__le16 reserved;
-	__le16 credits_requested;
-	__le32 preferred_send_size;
-	__le32 max_receive_size;
-	__le32 max_fragmented_size;
-} __packed;
-
-/* SMBD negotiation response packet [MS-SMBD] 2.2.2 */
-struct smbd_negotiate_resp {
-	__le16 min_version;
-	__le16 max_version;
-	__le16 negotiated_version;
-	__le16 reserved;
-	__le16 credits_requested;
-	__le16 credits_granted;
-	__le32 status;
-	__le32 max_readwrite_size;
-	__le32 preferred_send_size;
-	__le32 max_receive_size;
-	__le32 max_fragmented_size;
-} __packed;
-
-/* SMBD data transfer packet with payload [MS-SMBD] 2.2.3 */
-struct smbd_data_transfer {
-	__le16 credits_requested;
-	__le16 credits_granted;
-	__le16 flags;
-	__le16 reserved;
-	__le32 remaining_data_length;
-	__le32 data_offset;
-	__le32 data_length;
-	__le32 padding;
-	__u8 buffer[];
-} __packed;
-
 /* The packet fields for a registered RDMA buffer */
 struct smbd_buffer_descriptor_v1 {
 	__le64 offset;
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 12cbd3428a6d..9c3cc7c3300c 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -140,7 +140,7 @@ DECLARE_EVENT_CLASS(smb3_rw_err_class,
 		__entry->len = len;
 		__entry->rc = rc;
 	),
-	TP_printk("\tR=%08x[%x] xid=%u sid=0x%llx tid=0x%x fid=0x%llx offset=0x%llx len=0x%x rc=%d",
+	TP_printk("R=%08x[%x] xid=%u sid=0x%llx tid=0x%x fid=0x%llx offset=0x%llx len=0x%x rc=%d",
 		  __entry->rreq_debug_id, __entry->rreq_debug_index,
 		  __entry->xid, __entry->sesid, __entry->tid, __entry->fid,
 		  __entry->offset, __entry->len, __entry->rc)
@@ -190,7 +190,7 @@ DECLARE_EVENT_CLASS(smb3_other_err_class,
 		__entry->len = len;
 		__entry->rc = rc;
 	),
-	TP_printk("\txid=%u sid=0x%llx tid=0x%x fid=0x%llx offset=0x%llx len=0x%x rc=%d",
+	TP_printk("xid=%u sid=0x%llx tid=0x%x fid=0x%llx offset=0x%llx len=0x%x rc=%d",
 		__entry->xid, __entry->sesid, __entry->tid, __entry->fid,
 		__entry->offset, __entry->len, __entry->rc)
 )
@@ -247,7 +247,7 @@ DECLARE_EVENT_CLASS(smb3_copy_range_err_class,
 		__entry->len = len;
 		__entry->rc = rc;
 	),
-	TP_printk("\txid=%u sid=0x%llx tid=0x%x source fid=0x%llx source offset=0x%llx target fid=0x%llx target offset=0x%llx len=0x%x rc=%d",
+	TP_printk("xid=%u sid=0x%llx tid=0x%x source fid=0x%llx source offset=0x%llx target fid=0x%llx target offset=0x%llx len=0x%x rc=%d",
 		__entry->xid, __entry->sesid, __entry->tid, __entry->target_fid,
 		__entry->src_offset, __entry->target_fid, __entry->target_offset, __entry->len, __entry->rc)
 )
@@ -298,7 +298,7 @@ DECLARE_EVENT_CLASS(smb3_copy_range_done_class,
 		__entry->target_offset = target_offset;
 		__entry->len = len;
 	),
-	TP_printk("\txid=%u sid=0x%llx tid=0x%x source fid=0x%llx source offset=0x%llx target fid=0x%llx target offset=0x%llx len=0x%x",
+	TP_printk("xid=%u sid=0x%llx tid=0x%x source fid=0x%llx source offset=0x%llx target fid=0x%llx target offset=0x%llx len=0x%x",
 		__entry->xid, __entry->sesid, __entry->tid, __entry->target_fid,
 		__entry->src_offset, __entry->target_fid, __entry->target_offset, __entry->len)
 )
@@ -482,7 +482,7 @@ DECLARE_EVENT_CLASS(smb3_fd_class,
 		__entry->tid = tid;
 		__entry->sesid = sesid;
 	),
-	TP_printk("\txid=%u sid=0x%llx tid=0x%x fid=0x%llx",
+	TP_printk("xid=%u sid=0x%llx tid=0x%x fid=0x%llx",
 		__entry->xid, __entry->sesid, __entry->tid, __entry->fid)
 )
 
@@ -521,7 +521,7 @@ DECLARE_EVENT_CLASS(smb3_fd_err_class,
 		__entry->sesid = sesid;
 		__entry->rc = rc;
 	),
-	TP_printk("\txid=%u sid=0x%llx tid=0x%x fid=0x%llx rc=%d",
+	TP_printk("xid=%u sid=0x%llx tid=0x%x fid=0x%llx rc=%d",
 		__entry->xid, __entry->sesid, __entry->tid, __entry->fid,
 		__entry->rc)
 )
@@ -793,7 +793,7 @@ DECLARE_EVENT_CLASS(smb3_cmd_err_class,
 		__entry->status = status;
 		__entry->rc = rc;
 	),
-	TP_printk("\tsid=0x%llx tid=0x%x cmd=%u mid=%llu status=0x%x rc=%d",
+	TP_printk("sid=0x%llx tid=0x%x cmd=%u mid=%llu status=0x%x rc=%d",
 		__entry->sesid, __entry->tid, __entry->cmd, __entry->mid,
 		__entry->status, __entry->rc)
 )
@@ -828,7 +828,7 @@ DECLARE_EVENT_CLASS(smb3_cmd_done_class,
 		__entry->cmd = cmd;
 		__entry->mid = mid;
 	),
-	TP_printk("\tsid=0x%llx tid=0x%x cmd=%u mid=%llu",
+	TP_printk("sid=0x%llx tid=0x%x cmd=%u mid=%llu",
 		__entry->sesid, __entry->tid,
 		__entry->cmd, __entry->mid)
 )
@@ -866,7 +866,7 @@ DECLARE_EVENT_CLASS(smb3_mid_class,
 		__entry->when_sent = when_sent;
 		__entry->when_received = when_received;
 	),
-	TP_printk("\tcmd=%u mid=%llu pid=%u, when_sent=%lu when_rcv=%lu",
+	TP_printk("cmd=%u mid=%llu pid=%u, when_sent=%lu when_rcv=%lu",
 		__entry->cmd, __entry->mid, __entry->pid, __entry->when_sent,
 		__entry->when_received)
 )
@@ -897,7 +897,7 @@ DECLARE_EVENT_CLASS(smb3_exit_err_class,
 		__assign_str(func_name);
 		__entry->rc = rc;
 	),
-	TP_printk("\t%s: xid=%u rc=%d",
+	TP_printk("%s: xid=%u rc=%d",
 		__get_str(func_name), __entry->xid, __entry->rc)
 )
 
@@ -923,7 +923,7 @@ DECLARE_EVENT_CLASS(smb3_sync_err_class,
 		__entry->ino = ino;
 		__entry->rc = rc;
 	),
-	TP_printk("\tino=%lu rc=%d",
+	TP_printk("ino=%lu rc=%d",
 		__entry->ino, __entry->rc)
 )
 
@@ -949,7 +949,7 @@ DECLARE_EVENT_CLASS(smb3_enter_exit_class,
 		__entry->xid = xid;
 		__assign_str(func_name);
 	),
-	TP_printk("\t%s: xid=%u",
+	TP_printk("%s: xid=%u",
 		__get_str(func_name), __entry->xid)
 )
 
diff --git a/fs/smb/common/smbdirect/smbdirect.h b/fs/smb/common/smbdirect/smbdirect.h
new file mode 100644
index 000000000000..b9a385344ff3
--- /dev/null
+++ b/fs/smb/common/smbdirect/smbdirect.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2017, Microsoft Corporation.
+ *   Copyright (C) 2018, LG Electronics.
+ */
+
+#ifndef __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_H__
+#define __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_H__
+
+/* SMB-DIRECT buffer descriptor V1 structure [MS-SMBD] 2.2.3.1 */
+struct smbdirect_buffer_descriptor_v1 {
+	__le64 offset;
+	__le32 token;
+	__le32 length;
+} __packed;
+
+/*
+ * Connection parameters mostly from [MS-SMBD] 3.1.1.1
+ *
+ * These are setup and negotiated at the beginning of a
+ * connection and remain constant unless explicitly changed.
+ *
+ * Some values are important for the upper layer.
+ */
+struct smbdirect_socket_parameters {
+	__u16 recv_credit_max;
+	__u16 send_credit_target;
+	__u32 max_send_size;
+	__u32 max_fragmented_send_size;
+	__u32 max_recv_size;
+	__u32 max_fragmented_recv_size;
+	__u32 max_read_write_size;
+	__u32 keepalive_interval_msec;
+	__u32 keepalive_timeout_msec;
+} __packed;
+
+#endif /* __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_H__ */
diff --git a/fs/smb/common/smbdirect/smbdirect_pdu.h b/fs/smb/common/smbdirect/smbdirect_pdu.h
new file mode 100644
index 000000000000..ae9fdb05ce23
--- /dev/null
+++ b/fs/smb/common/smbdirect/smbdirect_pdu.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (c) 2017 Stefan Metzmacher
+ */
+
+#ifndef __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_PDU_H__
+#define __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_PDU_H__
+
+#define SMBDIRECT_V1 0x0100
+
+/* SMBD negotiation request packet [MS-SMBD] 2.2.1 */
+struct smbdirect_negotiate_req {
+	__le16 min_version;
+	__le16 max_version;
+	__le16 reserved;
+	__le16 credits_requested;
+	__le32 preferred_send_size;
+	__le32 max_receive_size;
+	__le32 max_fragmented_size;
+} __packed;
+
+/* SMBD negotiation response packet [MS-SMBD] 2.2.2 */
+struct smbdirect_negotiate_resp {
+	__le16 min_version;
+	__le16 max_version;
+	__le16 negotiated_version;
+	__le16 reserved;
+	__le16 credits_requested;
+	__le16 credits_granted;
+	__le32 status;
+	__le32 max_readwrite_size;
+	__le32 preferred_send_size;
+	__le32 max_receive_size;
+	__le32 max_fragmented_size;
+} __packed;
+
+#define SMBDIRECT_DATA_MIN_HDR_SIZE 0x14
+#define SMBDIRECT_DATA_OFFSET       0x18
+
+#define SMBDIRECT_FLAG_RESPONSE_REQUESTED 0x0001
+
+/* SMBD data transfer packet with payload [MS-SMBD] 2.2.3 */
+struct smbdirect_data_transfer {
+	__le16 credits_requested;
+	__le16 credits_granted;
+	__le16 flags;
+	__le16 reserved;
+	__le32 remaining_data_length;
+	__le32 data_offset;
+	__le32 data_length;
+	__le32 padding;
+	__u8 buffer[];
+} __packed;
+
+#endif /* __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_PDU_H__ */
diff --git a/fs/smb/common/smbdirect/smbdirect_socket.h b/fs/smb/common/smbdirect/smbdirect_socket.h
new file mode 100644
index 000000000000..e5b15cc44a7b
--- /dev/null
+++ b/fs/smb/common/smbdirect/smbdirect_socket.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (c) 2025 Stefan Metzmacher
+ */
+
+#ifndef __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_SOCKET_H__
+#define __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_SOCKET_H__
+
+enum smbdirect_socket_status {
+	SMBDIRECT_SOCKET_CREATED,
+	SMBDIRECT_SOCKET_CONNECTING,
+	SMBDIRECT_SOCKET_CONNECTED,
+	SMBDIRECT_SOCKET_NEGOTIATE_FAILED,
+	SMBDIRECT_SOCKET_DISCONNECTING,
+	SMBDIRECT_SOCKET_DISCONNECTED,
+	SMBDIRECT_SOCKET_DESTROYED
+};
+
+struct smbdirect_socket {
+	enum smbdirect_socket_status status;
+
+	/* RDMA related */
+	struct {
+		struct rdma_cm_id *cm_id;
+	} rdma;
+
+	/* IB verbs related */
+	struct {
+		struct ib_pd *pd;
+		struct ib_cq *send_cq;
+		struct ib_cq *recv_cq;
+
+		/*
+		 * shortcuts for rdma.cm_id->{qp,device};
+		 */
+		struct ib_qp *qp;
+		struct ib_device *dev;
+	} ib;
+
+	struct smbdirect_socket_parameters parameters;
+};
+
+#endif /* __FS_SMB_COMMON_SMBDIRECT_SMBDIRECT_SOCKET_H__ */
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 572102098c10..dd3e0e3f7bf0 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -108,6 +108,7 @@ struct ksmbd_conn {
 	__le16				signing_algorithm;
 	bool				binding;
 	atomic_t			refcnt;
+	bool				is_aapl;
 };
 
 struct ksmbd_conn_ops {
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 6537ffd2b965..5d2324c09a07 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2871,7 +2871,7 @@ int smb2_open(struct ksmbd_work *work)
 	int req_op_level = 0, open_flags = 0, may_flags = 0, file_info = 0;
 	int rc = 0;
 	int contxt_cnt = 0, query_disk_id = 0;
-	int maximal_access_ctxt = 0, posix_ctxt = 0;
+	bool maximal_access_ctxt = false, posix_ctxt = false;
 	int s_type = 0;
 	int next_off = 0;
 	char *name = NULL;
@@ -2898,6 +2898,27 @@ int smb2_open(struct ksmbd_work *work)
 		return create_smb2_pipe(work);
 	}
 
+	if (req->CreateContextsOffset && tcon->posix_extensions) {
+		context = smb2_find_context_vals(req, SMB2_CREATE_TAG_POSIX, 16);
+		if (IS_ERR(context)) {
+			rc = PTR_ERR(context);
+			goto err_out2;
+		} else if (context) {
+			struct create_posix *posix = (struct create_posix *)context;
+
+			if (le16_to_cpu(context->DataOffset) +
+				le32_to_cpu(context->DataLength) <
+			    sizeof(struct create_posix) - 4) {
+				rc = -EINVAL;
+				goto err_out2;
+			}
+			ksmbd_debug(SMB, "get posix context\n");
+
+			posix_mode = le32_to_cpu(posix->Mode);
+			posix_ctxt = true;
+		}
+	}
+
 	if (req->NameLength) {
 		name = smb2_get_name((char *)req + le16_to_cpu(req->NameOffset),
 				     le16_to_cpu(req->NameLength),
@@ -2920,9 +2941,11 @@ int smb2_open(struct ksmbd_work *work)
 				goto err_out2;
 		}
 
-		rc = ksmbd_validate_filename(name);
-		if (rc < 0)
-			goto err_out2;
+		if (posix_ctxt == false) {
+			rc = ksmbd_validate_filename(name);
+			if (rc < 0)
+				goto err_out2;
+		}
 
 		if (ksmbd_share_veto_filename(share, name)) {
 			rc = -ENOENT;
@@ -3080,28 +3103,6 @@ int smb2_open(struct ksmbd_work *work)
 			rc = -EBADF;
 			goto err_out2;
 		}
-
-		if (tcon->posix_extensions) {
-			context = smb2_find_context_vals(req,
-							 SMB2_CREATE_TAG_POSIX, 16);
-			if (IS_ERR(context)) {
-				rc = PTR_ERR(context);
-				goto err_out2;
-			} else if (context) {
-				struct create_posix *posix =
-					(struct create_posix *)context;
-				if (le16_to_cpu(context->DataOffset) +
-				    le32_to_cpu(context->DataLength) <
-				    sizeof(struct create_posix) - 4) {
-					rc = -EINVAL;
-					goto err_out2;
-				}
-				ksmbd_debug(SMB, "get posix context\n");
-
-				posix_mode = le32_to_cpu(posix->Mode);
-				posix_ctxt = 1;
-			}
-		}
 	}
 
 	if (ksmbd_override_fsids(work)) {
@@ -3534,6 +3535,15 @@ int smb2_open(struct ksmbd_work *work)
 			ksmbd_debug(SMB, "get query on disk id context\n");
 			query_disk_id = 1;
 		}
+
+		if (conn->is_aapl == false) {
+			context = smb2_find_context_vals(req, SMB2_CREATE_AAPL, 4);
+			if (IS_ERR(context)) {
+				rc = PTR_ERR(context);
+				goto err_out1;
+			} else if (context)
+				conn->is_aapl = true;
+		}
 	}
 
 	rc = ksmbd_vfs_getattr(&path, &stat);
@@ -3973,7 +3983,10 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		if (dinfo->EaSize)
 			dinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
 		dinfo->Reserved = 0;
-		dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		if (conn->is_aapl)
+			dinfo->UniqueId = 0;
+		else
+			dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
 			dinfo->ExtFileAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		memcpy(dinfo->FileName, conv_name, conv_len);
@@ -3990,7 +4003,10 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
 		if (fibdinfo->EaSize)
 			fibdinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
-		fibdinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		if (conn->is_aapl)
+			fibdinfo->UniqueId = 0;
+		else
+			fibdinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		fibdinfo->ShortNameLength = 0;
 		fibdinfo->Reserved = 0;
 		fibdinfo->Reserved2 = cpu_to_le16(0);
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 17a0b18a8406..16ae8a10490b 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -63,6 +63,9 @@ struct preauth_integrity_info {
 
 #define SMB2_SESSION_TIMEOUT		(10 * HZ)
 
+/* Apple Defined Contexts */
+#define SMB2_CREATE_AAPL		"AAPL"
+
 struct create_durable_req_v2 {
 	struct create_context_hdr ccontext;
 	__u8   Name[8];
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e9e3366d059e..730aa0245aef 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/leds.h>
 #include <linux/rculist.h>
+#include <linux/srcu.h>
 
 #include <net/bluetooth/hci.h>
 #include <net/bluetooth/hci_sync.h>
@@ -338,6 +339,7 @@ struct adv_monitor {
 
 struct hci_dev {
 	struct list_head list;
+	struct srcu_struct srcu;
 	struct mutex	lock;
 
 	struct ida	unset_handle_ida;
diff --git a/include/uapi/drm/ivpu_accel.h b/include/uapi/drm/ivpu_accel.h
index 13001da141c3..4b261eb705bc 100644
--- a/include/uapi/drm/ivpu_accel.h
+++ b/include/uapi/drm/ivpu_accel.h
@@ -261,7 +261,7 @@ struct drm_ivpu_bo_info {
 
 /* drm_ivpu_submit engines */
 #define DRM_IVPU_ENGINE_COMPUTE 0
-#define DRM_IVPU_ENGINE_COPY    1
+#define DRM_IVPU_ENGINE_COPY    1 /* Deprecated */
 
 /**
  * struct drm_ivpu_submit - Submit commands to the VPU
@@ -292,10 +292,6 @@ struct drm_ivpu_submit {
 	 * %DRM_IVPU_ENGINE_COMPUTE:
 	 *
 	 * Performs Deep Learning Neural Compute Inference Operations
-	 *
-	 * %DRM_IVPU_ENGINE_COPY:
-	 *
-	 * Performs memory copy operations to/from system memory allocated for VPU
 	 */
 	__u32 engine;
 
diff --git a/include/uapi/linux/vm_sockets.h b/include/uapi/linux/vm_sockets.h
index ed07181d4eff..e05280e41522 100644
--- a/include/uapi/linux/vm_sockets.h
+++ b/include/uapi/linux/vm_sockets.h
@@ -17,6 +17,10 @@
 #ifndef _UAPI_VM_SOCKETS_H
 #define _UAPI_VM_SOCKETS_H
 
+#ifndef __KERNEL__
+#include <sys/socket.h>        /* for struct sockaddr and sa_family_t */
+#endif
+
 #include <linux/socket.h>
 #include <linux/types.h>
 
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index c9289597522f..9bd27deeee6f 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -263,6 +263,7 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 		if (len > arg->max_len) {
 			len = arg->max_len;
 			if (!(bl->flags & IOBL_INC)) {
+				arg->partial_map = 1;
 				if (iov != arg->iovs)
 					break;
 				buf->len = len;
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 36aadfe5ac00..2586a292dfb9 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -61,6 +61,7 @@ struct buf_sel_arg {
 	size_t max_len;
 	unsigned short nr_iovs;
 	unsigned short mode;
+	unsigned short partial_map;
 };
 
 void __user *io_buffer_select(struct io_kiocb *req, size_t *len,
diff --git a/io_uring/net.c b/io_uring/net.c
index 384915d931b7..0116cfaec848 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -76,12 +76,18 @@ struct io_sr_msg {
 	/* initialised and used only by !msg send variants */
 	u16				addr_len;
 	u16				buf_group;
+	unsigned short			retry_flags;
 	void __user			*addr;
 	void __user			*msg_control;
 	/* used only for send zerocopy */
 	struct io_kiocb 		*notif;
 };
 
+enum sr_retry_flags {
+	IO_SR_MSG_RETRY		= 1,
+	IO_SR_MSG_PARTIAL_MAP	= 2,
+};
+
 /*
  * Number of times we'll try and do receives if there's more data. If we
  * exceed this limit, then add us to the back of the queue and retry from
@@ -203,6 +209,7 @@ static inline void io_mshot_prep_retry(struct io_kiocb *req,
 
 	req->flags &= ~REQ_F_BL_EMPTY;
 	sr->done_io = 0;
+	sr->retry_flags = 0;
 	sr->len = 0; /* get from the provided buffer */
 	req->buf_index = sr->buf_group;
 }
@@ -409,6 +416,7 @@ int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 
 	sr->done_io = 0;
+	sr->retry_flags = 0;
 
 	if (req->opcode == IORING_OP_SEND) {
 		if (READ_ONCE(sqe->__pad3[0]))
@@ -780,6 +788,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 
 	sr->done_io = 0;
+	sr->retry_flags = 0;
 
 	if (unlikely(sqe->file_index || sqe->addr2))
 		return -EINVAL;
@@ -828,6 +837,9 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	return io_recvmsg_prep_setup(req);
 }
 
+/* bits to clear in old and inherit in new cflags on bundle retry */
+#define CQE_F_MASK	(IORING_CQE_F_SOCK_NONEMPTY|IORING_CQE_F_MORE)
+
 /*
  * Finishes io_recv and io_recvmsg.
  *
@@ -845,11 +857,27 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 		cflags |= IORING_CQE_F_SOCK_NONEMPTY;
 
 	if (sr->flags & IORING_RECVSEND_BUNDLE) {
-		cflags |= io_put_kbufs(req, *ret, io_bundle_nbufs(kmsg, *ret),
+		size_t this_ret = *ret - sr->done_io;
+
+		cflags |= io_put_kbufs(req, this_ret, io_bundle_nbufs(kmsg, this_ret),
 				      issue_flags);
+		if (sr->retry_flags & IO_SR_MSG_RETRY)
+			cflags = req->cqe.flags | (cflags & CQE_F_MASK);
 		/* bundle with no more immediate buffers, we're done */
 		if (req->flags & REQ_F_BL_EMPTY)
 			goto finish;
+		/*
+		 * If more is available AND it was a full transfer, retry and
+		 * append to this one
+		 */
+		if (!sr->retry_flags && kmsg->msg.msg_inq > 1 && this_ret > 0 &&
+		    !iov_iter_count(&kmsg->msg.msg_iter)) {
+			req->cqe.flags = cflags & ~CQE_F_MASK;
+			sr->len = kmsg->msg.msg_inq;
+			sr->done_io += this_ret;
+			sr->retry_flags |= IO_SR_MSG_RETRY;
+			return false;
+		}
 	} else {
 		cflags |= io_put_kbuf(req, *ret, issue_flags);
 	}
@@ -1088,13 +1116,21 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 			arg.mode |= KBUF_MODE_FREE;
 		}
 
-		if (kmsg->msg.msg_inq > 0)
+		if (kmsg->msg.msg_inq > 1)
 			arg.max_len = min_not_zero(sr->len, kmsg->msg.msg_inq);
 
 		ret = io_buffers_peek(req, &arg);
 		if (unlikely(ret < 0))
 			return ret;
 
+		if (arg.iovs != &kmsg->fast_iov && arg.iovs != kmsg->free_iov) {
+			kmsg->free_iov_nr = ret;
+			kmsg->free_iov = arg.iovs;
+			req->flags |= REQ_F_NEED_CLEANUP;
+		}
+		if (arg.partial_map)
+			sr->retry_flags |= IO_SR_MSG_PARTIAL_MAP;
+
 		/* special case 1 vec, can be a fast path */
 		if (ret == 1) {
 			sr->buf = arg.iovs[0].iov_base;
@@ -1103,11 +1139,6 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 		}
 		iov_iter_init(&kmsg->msg.msg_iter, ITER_DEST, arg.iovs, ret,
 				arg.out_len);
-		if (arg.iovs != &kmsg->fast_iov && arg.iovs != kmsg->free_iov) {
-			kmsg->free_iov_nr = ret;
-			kmsg->free_iov = arg.iovs;
-			req->flags |= REQ_F_NEED_CLEANUP;
-		}
 	} else {
 		void __user *buf;
 
@@ -1228,6 +1259,7 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_kiocb *notif;
 
 	zc->done_io = 0;
+	zc->retry_flags = 0;
 	req->flags |= REQ_F_POLL_NO_LAZY;
 
 	if (unlikely(READ_ONCE(sqe->__pad2[0]) || READ_ONCE(sqe->addr3)))
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index a67bae350416..1687e35e21c9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -119,8 +119,11 @@ static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_mapped_ubuf **slo
 	if (imu != &dummy_ubuf) {
 		if (!refcount_dec_and_test(&imu->refs))
 			return;
-		for (i = 0; i < imu->nr_bvecs; i++)
-			unpin_user_page(imu->bvec[i].bv_page);
+		for (i = 0; i < imu->nr_bvecs; i++) {
+			struct folio *folio = page_folio(imu->bvec[i].bv_page);
+
+			unpin_user_folio(folio, 1);
+		}
 		if (imu->acct_pages)
 			io_unaccount_mem(ctx, imu->acct_pages);
 		kvfree(imu);
@@ -915,6 +918,7 @@ static bool io_try_coalesce_buffer(struct page ***pages, int *nr_pages,
 		return false;
 
 	data->folio_shift = folio_shift(folio);
+	data->first_folio_page_idx = folio_page_idx(folio, page_array[0]);
 	/*
 	 * Check if pages are contiguous inside a folio, and all folios have
 	 * the same page count except for the head and tail.
@@ -983,10 +987,8 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
 		goto done;
 
 	ret = io_buffer_account_pin(ctx, pages, nr_pages, imu, last_hpage);
-	if (ret) {
-		unpin_user_pages(pages, nr_pages);
+	if (ret)
 		goto done;
-	}
 
 	size = iov->iov_len;
 	/* store original address for later verification */
@@ -997,7 +999,9 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
 	if (coalesced)
 		imu->folio_shift = data.folio_shift;
 	refcount_set(&imu->refs, 1);
-	off = (unsigned long) iov->iov_base & ((1UL << imu->folio_shift) - 1);
+	off = (unsigned long)iov->iov_base & ~PAGE_MASK;
+	if (coalesced)
+		off += data.first_folio_page_idx << PAGE_SHIFT;
 	*pimu = imu;
 	ret = 0;
 
@@ -1010,8 +1014,13 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, struct iovec *iov,
 		size -= vec_len;
 	}
 done:
-	if (ret)
+	if (ret) {
 		kvfree(imu);
+		if (pages) {
+			for (i = 0; i < nr_pages; i++)
+				unpin_user_folio(page_folio(pages[i]), 1);
+		}
+	}
 	kvfree(pages);
 	return ret;
 }
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 8ed588036210..459cf4c6e856 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -56,6 +56,7 @@ struct io_imu_folio_data {
 	/* For non-head/tail folios, has to be fully included */
 	unsigned int	nr_pages_mid;
 	unsigned int	folio_shift;
+	unsigned long	first_folio_page_idx;
 };
 
 void io_rsrc_node_ref_zero(struct io_rsrc_node *node);
diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index ee272c4cefcc..18d43a406114 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -352,6 +352,9 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 	int ret = -ENOMEM;
 	struct cpumask *masks = NULL;
 
+	if (numgrps == 0)
+		return NULL;
+
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
@@ -426,8 +429,12 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 #else /* CONFIG_SMP */
 struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {
-	struct cpumask *masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
+	struct cpumask *masks;
 
+	if (numgrps == 0)
+		return NULL;
+
+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		return NULL;
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 8d73ccf66f3a..44441ec5b0af 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5542,8 +5542,9 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 	mas_wr_store_type(&wr_mas);
 	request = mas_prealloc_calc(mas, entry);
 	if (!request)
-		return ret;
+		goto set_flag;
 
+	mas->mas_flags &= ~MA_STATE_PREALLOC;
 	mas_node_count_gfp(mas, request, gfp);
 	if (mas_is_err(mas)) {
 		mas_set_alloc_req(mas, 0);
@@ -5553,6 +5554,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
 		return ret;
 	}
 
+set_flag:
 	mas->mas_flags |= MA_STATE_PREALLOC;
 	return ret;
 }
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b095457380b5..d9e01648db70 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -423,6 +423,7 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	kfree(filter->memcg_path);
 	filter->memcg_path = path;
 	return count;
 }
diff --git a/mm/gup.c b/mm/gup.c
index 90866b827b60..e323843cc5dd 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2326,13 +2326,13 @@ static void pofs_unpin(struct pages_or_folios *pofs)
 /*
  * Returns the number of collected folios. Return value is always >= 0.
  */
-static void collect_longterm_unpinnable_folios(
+static unsigned long collect_longterm_unpinnable_folios(
 		struct list_head *movable_folio_list,
 		struct pages_or_folios *pofs)
 {
+	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
-	unsigned long i;
 
 	for (i = 0; i < pofs->nr_entries; i++) {
 		struct folio *folio = pofs_get_folio(pofs, i);
@@ -2344,6 +2344,8 @@ static void collect_longterm_unpinnable_folios(
 		if (folio_is_longterm_pinnable(folio))
 			continue;
 
+		collected++;
+
 		if (folio_is_device_coherent(folio))
 			continue;
 
@@ -2365,6 +2367,8 @@ static void collect_longterm_unpinnable_folios(
 				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
 				    folio_nr_pages(folio));
 	}
+
+	return collected;
 }
 
 /*
@@ -2441,9 +2445,11 @@ static long
 check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
 {
 	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
 
-	collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
-	if (list_empty(&movable_folio_list))
+	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
+						       pofs);
+	if (!collected)
 		return 0;
 
 	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
diff --git a/mm/vma.c b/mm/vma.c
index 1d82ec4ee7bb..140f7017bb63 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -836,9 +836,6 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 		err = dup_anon_vma(next, vma, &anon_dup);
 	}
 
-	if (err)
-		goto abort;
-
 	/*
 	 * In nearly all cases, we expand vmg->vma. There is one exception -
 	 * merge_right where we partially span the VMA. In this case we shrink
@@ -846,22 +843,11 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 	 */
 	expanded = !merge_right || merge_will_delete_vma;
 
-	if (commit_merge(vmg, adjust,
-			 merge_will_delete_vma ? vma : NULL,
-			 merge_will_delete_next ? next : NULL,
-			 adj_start, expanded)) {
-		if (anon_dup)
-			unlink_anon_vmas(anon_dup);
-
-		/*
-		 * We've cleaned up any cloned anon_vma's, no VMAs have been
-		 * modified, no harm no foul if the user requests that we not
-		 * report this and just give up, leaving the VMAs unmerged.
-		 */
-		if (!vmg->give_up_on_oom)
-			vmg->state = VMA_MERGE_ERROR_NOMEM;
-		return NULL;
-	}
+	if (err || commit_merge(vmg, adjust,
+			merge_will_delete_vma ? vma : NULL,
+			merge_will_delete_next ? next : NULL,
+			adj_start, expanded))
+		goto abort;
 
 	res = merge_left ? prev : next;
 	khugepaged_enter_vma(res, vmg->flags);
@@ -873,6 +859,9 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 	vma_iter_set(vmg->vmi, start);
 	vma_iter_load(vmg->vmi);
 
+	if (anon_dup)
+		unlink_anon_vmas(anon_dup);
+
 	/*
 	 * This means we have failed to clone anon_vma's correctly, but no
 	 * actual changes to VMAs have occurred, so no harm no foul - if the
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 42b910cb4e8e..0d7744442b25 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -193,12 +193,6 @@ static void clip_push(struct atm_vcc *vcc, struct sk_buff *skb)
 
 	pr_debug("\n");
 
-	if (!clip_devs) {
-		atm_return(vcc, skb->truesize);
-		kfree_skb(skb);
-		return;
-	}
-
 	if (!skb) {
 		pr_debug("removing VCC %p\n", clip_vcc);
 		if (clip_vcc->entry)
@@ -208,6 +202,11 @@ static void clip_push(struct atm_vcc *vcc, struct sk_buff *skb)
 		return;
 	}
 	atm_return(vcc, skb->truesize);
+	if (!clip_devs) {
+		kfree_skb(skb);
+		return;
+	}
+
 	skb->dev = clip_vcc->entry ? clip_vcc->entry->neigh->dev : clip_devs;
 	/* clip_vcc->entry == NULL if we don't have an IP address yet */
 	if (!skb->dev) {
diff --git a/net/atm/resources.c b/net/atm/resources.c
index 995d29e7fb13..b19d851e1f44 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -146,11 +146,10 @@ void atm_dev_deregister(struct atm_dev *dev)
 	 */
 	mutex_lock(&atm_dev_mutex);
 	list_del(&dev->dev_list);
-	mutex_unlock(&atm_dev_mutex);
-
 	atm_dev_release_vccs(dev);
 	atm_unregister_sysfs(dev);
 	atm_proc_dev_deregister(dev);
+	mutex_unlock(&atm_dev_mutex);
 
 	atm_dev_put(dev);
 }
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0d3816c80758..b74ada809237 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -64,7 +64,7 @@ static DEFINE_IDA(hci_index_ida);
 
 /* Get HCI device by index.
  * Device is held on return. */
-struct hci_dev *hci_dev_get(int index)
+static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
 {
 	struct hci_dev *hdev = NULL, *d;
 
@@ -77,6 +77,8 @@ struct hci_dev *hci_dev_get(int index)
 	list_for_each_entry(d, &hci_dev_list, list) {
 		if (d->id == index) {
 			hdev = hci_dev_hold(d);
+			if (srcu_index)
+				*srcu_index = srcu_read_lock(&d->srcu);
 			break;
 		}
 	}
@@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
 	return hdev;
 }
 
+struct hci_dev *hci_dev_get(int index)
+{
+	return __hci_dev_get(index, NULL);
+}
+
+static struct hci_dev *hci_dev_get_srcu(int index, int *srcu_index)
+{
+	return __hci_dev_get(index, srcu_index);
+}
+
+static void hci_dev_put_srcu(struct hci_dev *hdev, int srcu_index)
+{
+	srcu_read_unlock(&hdev->srcu, srcu_index);
+	hci_dev_put(hdev);
+}
+
 /* ---- Inquiry support ---- */
 
 bool hci_discovery_active(struct hci_dev *hdev)
@@ -568,9 +586,9 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
 int hci_dev_reset(__u16 dev)
 {
 	struct hci_dev *hdev;
-	int err;
+	int err, srcu_index;
 
-	hdev = hci_dev_get(dev);
+	hdev = hci_dev_get_srcu(dev, &srcu_index);
 	if (!hdev)
 		return -ENODEV;
 
@@ -592,7 +610,7 @@ int hci_dev_reset(__u16 dev)
 	err = hci_dev_do_reset(hdev);
 
 done:
-	hci_dev_put(hdev);
+	hci_dev_put_srcu(hdev, srcu_index);
 	return err;
 }
 
@@ -2439,6 +2457,11 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	if (!hdev)
 		return NULL;
 
+	if (init_srcu_struct(&hdev->srcu)) {
+		kfree(hdev);
+		return NULL;
+	}
+
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
@@ -2684,6 +2707,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	list_del(&hdev->list);
 	write_unlock(&hci_dev_list_lock);
 
+	synchronize_srcu(&hdev->srcu);
+	cleanup_srcu_struct(&hdev->srcu);
+
 	disable_work_sync(&hdev->rx_work);
 	disable_work_sync(&hdev->cmd_work);
 	disable_work_sync(&hdev->tx_work);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a40534bf9084..0628fedc0e29 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3380,7 +3380,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
 	u8 remote_efs = 0;
-	u16 mtu = L2CAP_DEFAULT_MTU;
+	u16 mtu = 0;
 	u16 result = L2CAP_CONF_SUCCESS;
 	u16 size;
 
@@ -3485,6 +3485,13 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 		/* Configure output options and let the other side know
 		 * which ones we don't like. */
 
+		/* If MTU is not provided in configure request, use the most recently
+		 * explicitly or implicitly accepted value for the other direction,
+		 * or the default value.
+		 */
+		if (mtu == 0)
+			mtu = chan->imtu ? chan->imtu : L2CAP_DEFAULT_MTU;
+
 		if (mtu < L2CAP_DEFAULT_MIN_MTU)
 			result = L2CAP_CONF_UNACCEPT;
 		else {
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 561653f9d71d..ef27594d6a99 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -160,8 +160,9 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 	if (attr->tcp) {
-		thdr->check = ~tcp_v4_check(skb->len, ihdr->saddr,
-					    ihdr->daddr, 0);
+		int l4len = skb->len - skb_transport_offset(skb);
+
+		thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
 		skb->csum_start = skb_transport_header(skb) - skb->head;
 		skb->csum_offset = offsetof(struct tcphdr, check);
 	} else {
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index cca6d14084d2..282e8c13e2bf 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -2097,6 +2097,9 @@ void ieee80211_link_release_channel(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		return;
+
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (rcu_access_pointer(link->conf->chanctx_conf))
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index bfe0514efca3..2f017dbbcb97 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1209,6 +1209,15 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	if ((_link = wiphy_dereference((local)->hw.wiphy,		\
 				       ___sdata->link[___link_id])))
 
+#define for_each_link_data(sdata, __link)					\
+	struct ieee80211_sub_if_data *__sdata = sdata;				\
+	for (int __link_id = 0;							\
+	     __link_id < ARRAY_SIZE((__sdata)->link); __link_id++)		\
+		if ((!(__sdata)->vif.valid_links ||				\
+		     (__sdata)->vif.valid_links & BIT(__link_id)) &&		\
+		    ((__link) = sdata_dereference((__sdata)->link[__link_id],	\
+						  (__sdata))))
+
 static inline int
 ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems,
 				struct cfg80211_rnr_elems *rnr_elems,
@@ -2061,6 +2070,9 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata);
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7e1e561ef76c..209d6ffa8e42 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -494,6 +494,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			break;
 		list_del_rcu(&sdata->u.mntr.list);
 		break;
+	case NL80211_IFTYPE_AP_VLAN:
+		ieee80211_apvlan_link_clear(sdata);
+		break;
 	default:
 		break;
 	}
@@ -1268,6 +1271,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		sdata->crypto_tx_tailroom_needed_cnt +=
 			master->crypto_tx_tailroom_needed_cnt;
 
+		ieee80211_apvlan_link_setup(sdata);
+
 		break;
 		}
 	case NL80211_IFTYPE_AP:
@@ -1322,7 +1327,12 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_AP_VLAN:
 		/* no need to tell driver, but set carrier and chanctx */
 		if (sdata->bss->active) {
-			ieee80211_link_vlan_copy_chanctx(&sdata->deflink);
+			struct ieee80211_link_data *link;
+
+			for_each_link_data(sdata, link) {
+				ieee80211_link_vlan_copy_chanctx(link);
+			}
+
 			netif_carrier_on(dev);
 			ieee80211_set_vif_encap_ops(sdata);
 		} else {
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 46092fbcde90..9484449d6a34 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -12,6 +12,71 @@
 #include "key.h"
 #include "debugfs_netdev.h"
 
+static void ieee80211_update_apvlan_links(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *vlan;
+	struct ieee80211_link_data *link;
+	u16 ap_bss_links = sdata->vif.valid_links;
+	u16 new_links, vlan_links;
+	unsigned long add;
+
+	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
+		int link_id;
+
+		if (!vlan)
+			continue;
+
+		/* No support for 4addr with MLO yet */
+		if (vlan->wdev.use_4addr)
+			return;
+
+		vlan_links = vlan->vif.valid_links;
+
+		new_links = ap_bss_links;
+
+		add = new_links & ~vlan_links;
+		if (!add)
+			continue;
+
+		ieee80211_vif_set_links(vlan, add, 0);
+
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			link = sdata_dereference(vlan->link[link_id], vlan);
+			ieee80211_link_vlan_copy_chanctx(link);
+		}
+	}
+}
+
+void ieee80211_apvlan_link_setup(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_sub_if_data *ap_bss = container_of(sdata->bss,
+					    struct ieee80211_sub_if_data, u.ap);
+	u16 new_links = ap_bss->vif.valid_links;
+	unsigned long add;
+	int link_id;
+
+	if (!ap_bss->vif.valid_links)
+		return;
+
+	add = new_links;
+	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+		sdata->wdev.valid_links |= BIT(link_id);
+		ether_addr_copy(sdata->wdev.links[link_id].addr,
+				ap_bss->wdev.links[link_id].addr);
+	}
+
+	ieee80211_vif_set_links(sdata, new_links, 0);
+}
+
+void ieee80211_apvlan_link_clear(struct ieee80211_sub_if_data *sdata)
+{
+	if (!sdata->wdev.valid_links)
+		return;
+
+	sdata->wdev.valid_links = 0;
+	ieee80211_vif_clear_links(sdata);
+}
+
 void ieee80211_link_setup(struct ieee80211_link_data *link)
 {
 	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
@@ -28,8 +93,16 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	if (link_id < 0)
 		link_id = 0;
 
-	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
-	rcu_assign_pointer(sdata->link[link_id], link);
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		struct ieee80211_sub_if_data *ap_bss;
+		struct ieee80211_bss_conf *ap_bss_conf;
+
+		ap_bss = container_of(sdata->bss,
+				      struct ieee80211_sub_if_data, u.ap);
+		ap_bss_conf = sdata_dereference(ap_bss->vif.link_conf[link_id],
+						ap_bss);
+		memcpy(link_conf, ap_bss_conf, sizeof(*link_conf));
+	}
 
 	link->sdata = sdata;
 	link->link_id = link_id;
@@ -51,6 +124,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 	if (!deflink) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_AP_VLAN:
 			ether_addr_copy(link_conf->addr,
 					sdata->wdev.links[link_id].addr);
 			link_conf->bssid = link_conf->addr;
@@ -65,6 +139,9 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 
 		ieee80211_link_debugfs_add(link);
 	}
+
+	rcu_assign_pointer(sdata->vif.link_conf[link_id], link_conf);
+	rcu_assign_pointer(sdata->link[link_id], link);
 }
 
 void ieee80211_link_stop(struct ieee80211_link_data *link)
@@ -174,6 +251,7 @@ static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_AP_VLAN:
 		/* in an AP all links are always active */
 		sdata->vif.active_links = valid_links;
 
@@ -275,12 +353,16 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		ieee80211_set_vif_links_bitmaps(sdata, new_links, dormant_links);
 
 		/* tell the driver */
-		ret = drv_change_vif_links(sdata->local, sdata,
-					   old_links & old_active,
-					   new_links & sdata->vif.active_links,
-					   old);
+		if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
+			ret = drv_change_vif_links(sdata->local, sdata,
+						   old_links & old_active,
+						   new_links & sdata->vif.active_links,
+						   old);
 		if (!new_links)
 			ieee80211_debugfs_recreate_netdev(sdata, false);
+
+		if (sdata->vif.type == NL80211_IFTYPE_AP)
+			ieee80211_update_apvlan_links(sdata);
 	}
 
 	if (ret) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a98ae563613c..77638e965726 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3908,7 +3908,7 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 {
 	u64 tsf = drv_get_tsf(local, sdata);
 	u64 dtim_count = 0;
-	u16 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
+	u32 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
 	u8 dtim_period = sdata->vif.bss_conf.dtim_period;
 	struct ps_data *ps;
 	u8 bcns_from_dtim;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 17a4de75bfaf..e492655cb221 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2749,8 +2749,13 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case -EPROTONOSUPPORT:
 		goto out_err;
 	case -EACCES:
-		/* Re-encode with a fresh cred */
-		fallthrough;
+		/* possible RPCSEC_GSS out-of-sequence event (RFC2203),
+		 * reset recv state and keep waiting, don't retransmit
+		 */
+		task->tk_rqstp->rq_reply_bytes_recvd = 0;
+		task->tk_status = xprt_request_enqueue_receive(task);
+		task->tk_action = call_transmit_status;
+		return -EBADMSG;
 	default:
 		goto out_garbage;
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6b1762300443..45f8e21829ec 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -666,6 +666,11 @@ static void unix_sock_destructor(struct sock *sk)
 #endif
 }
 
+static unsigned int unix_skb_len(const struct sk_buff *skb)
+{
+	return skb->len - UNIXCB(skb).consumed;
+}
+
 static void unix_release_sock(struct sock *sk, int embrion)
 {
 	struct unix_sock *u = unix_sk(sk);
@@ -700,10 +705,16 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 	if (skpair != NULL) {
 		if (sk->sk_type == SOCK_STREAM || sk->sk_type == SOCK_SEQPACKET) {
+			struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
+
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+			if (skb && !unix_skb_len(skb))
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
+#endif
 			unix_state_lock(skpair);
 			/* No more writes */
 			WRITE_ONCE(skpair->sk_shutdown, SHUTDOWN_MASK);
-			if (!skb_queue_empty_lockless(&sk->sk_receive_queue) || embrion)
+			if (skb || embrion)
 				WRITE_ONCE(skpair->sk_err, ECONNRESET);
 			unix_state_unlock(skpair);
 			skpair->sk_state_change(skpair);
@@ -2594,11 +2605,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
 	return timeo;
 }
 
-static unsigned int unix_skb_len(const struct sk_buff *skb)
-{
-	return skb->len - UNIXCB(skb).consumed;
-}
-
 struct unix_stream_read_state {
 	int (*recv_actor)(struct sk_buff *, int, int,
 			  struct unix_stream_read_state *);
@@ -2613,11 +2619,11 @@ struct unix_stream_read_state {
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 {
+	struct sk_buff *oob_skb, *read_skb = NULL;
 	struct socket *sock = state->socket;
 	struct sock *sk = sock->sk;
 	struct unix_sock *u = unix_sk(sk);
 	int chunk = 1;
-	struct sk_buff *oob_skb;
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
@@ -2632,9 +2638,16 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	oob_skb = u->oob_skb;
 
-	if (!(state->flags & MSG_PEEK))
+	if (!(state->flags & MSG_PEEK)) {
 		WRITE_ONCE(u->oob_skb, NULL);
 
+		if (oob_skb->prev != (struct sk_buff *)&sk->sk_receive_queue &&
+		    !unix_skb_len(oob_skb->prev)) {
+			read_skb = oob_skb->prev;
+			__skb_unlink(read_skb, &sk->sk_receive_queue);
+		}
+	}
+
 	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
@@ -2645,6 +2658,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_unlock(&u->iolock);
 
+	consume_skb(read_skb);
+
 	if (chunk < 0)
 		return -EFAULT;
 
diff --git a/rust/Makefile b/rust/Makefile
index 93650b2ee7d5..b8b7f817c48e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -238,7 +238,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
-	-fzero-init-padding-bits=% \
+	-fzero-init-padding-bits=% -mno-fdpic \
 	--param=% --param asan-%
 
 # Derived from `scripts/Makefile.clang`.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index da2a18b276e0..a5ea5850e307 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -260,6 +260,7 @@ mod __module_init {{
                     #[cfg(MODULE)]
                     #[doc(hidden)]
                     #[no_mangle]
+                    #[link_section = \".exit.text\"]
                     pub extern \"C\" fn cleanup_module() {{
                         // SAFETY:
                         // - This function is inaccessible to the outside due to the double
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 90633970b59f..f8f1b1f6b138 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -44,7 +44,7 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 
 	/* ignore unsol events during shutdown */
-	if (codec->bus->shutdown)
+	if (codec->card->shutdown || codec->bus->shutdown)
 		return;
 
 	/* ignore unsol events during system suspend/resume */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1872c8b75053..d4e325b78533 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2727,6 +2727,9 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_VDEVICE(ATI, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	{ PCI_VDEVICE(ATI, 0xab40),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	/* GLENFLY */
 	{ PCI_DEVICE(PCI_VENDOR_ID_GLENFLY, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cb41cd2ba0ef..30e9e26c5b2a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10859,6 +10859,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1204, "ASUS Strix G615JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1214, "ASUS Strix G615LH_LM_LP", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1043, 0x1264, "ASUS UM5606KA", ALC294_FIXUP_BASS_SPEAKER_15),
 	SND_PCI_QUIRK(0x1043, 0x1271, "ASUS X430UN", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1290, "ASUS X441SA", ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1294, "ASUS B3405CVA", ALC245_FIXUP_CS35L41_SPI_2),
@@ -10933,6 +10934,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1df3, "ASUS UM5606WA", ALC294_FIXUP_BASS_SPEAKER_15),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1e10, "ASUS VivoBook X507UAR", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e1f, "ASUS Vivobook 15 X1504VAP", ALC2XX_FIXUP_HEADSET_MIC),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 3d9da93d22ee..b27966f82c8b 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "83J2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83J3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index f2d194e76a94..8755a63478d7 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -2085,7 +2085,7 @@ static const struct reg_sequence rt1320_vc_patch_code_write[] = {
 	{ 0x3fc2bfc0, 0x03 },
 	{ 0x0000d486, 0x43 },
 	{ SDW_SDCA_CTL(FUNC_NUM_AMP, RT1320_SDCA_ENT_PDE23, RT1320_SDCA_CTL_REQ_POWER_STATE, 0), 0x00 },
-	{ 0x1000db00, 0x04 },
+	{ 0x1000db00, 0x07 },
 	{ 0x1000db01, 0x00 },
 	{ 0x1000db02, 0x11 },
 	{ 0x1000db03, 0x00 },
@@ -2106,6 +2106,21 @@ static const struct reg_sequence rt1320_vc_patch_code_write[] = {
 	{ 0x1000db12, 0x00 },
 	{ 0x1000db13, 0x00 },
 	{ 0x1000db14, 0x45 },
+	{ 0x1000db15, 0x0d },
+	{ 0x1000db16, 0x01 },
+	{ 0x1000db17, 0x00 },
+	{ 0x1000db18, 0x00 },
+	{ 0x1000db19, 0xbf },
+	{ 0x1000db1a, 0x13 },
+	{ 0x1000db1b, 0x09 },
+	{ 0x1000db1c, 0x00 },
+	{ 0x1000db1d, 0x00 },
+	{ 0x1000db1e, 0x00 },
+	{ 0x1000db1f, 0x12 },
+	{ 0x1000db20, 0x09 },
+	{ 0x1000db21, 0x00 },
+	{ 0x1000db22, 0x00 },
+	{ 0x1000db23, 0x00 },
 	{ 0x0000d540, 0x01 },
 	{ 0x0000c081, 0xfc },
 	{ 0x0000f01e, 0x80 },
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 373a31ddccb2..1375ac571fbf 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -17,7 +17,7 @@
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 #include <sound/soc-dapm.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
 #include <sound/tlv.h>
@@ -329,8 +329,7 @@ struct wcd9335_codec {
 	int comp_enabled[COMPANDER_MAX];
 
 	int intr1;
-	int reset_gpio;
-	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
+	struct gpio_desc *reset_gpio;
 
 	unsigned int rx_port_value[WCD9335_RX_MAX];
 	unsigned int tx_port_value[WCD9335_TX_MAX];
@@ -353,6 +352,10 @@ struct wcd9335_irq {
 	char *name;
 };
 
+static const char * const wcd9335_supplies[] = {
+	"vdd-buck", "vdd-buck-sido", "vdd-tx", "vdd-rx", "vdd-io",
+};
+
 static const struct wcd9335_slim_ch wcd9335_tx_chs[WCD9335_TX_MAX] = {
 	WCD9335_SLIM_TX_CH(0),
 	WCD9335_SLIM_TX_CH(1),
@@ -4973,12 +4976,11 @@ static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
 static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 {
 	struct device *dev = wcd->dev;
-	struct device_node *np = dev->of_node;
 	int ret;
 
-	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
-	if (wcd->reset_gpio < 0)
-		return dev_err_probe(dev, wcd->reset_gpio, "Reset GPIO missing from DT\n");
+	wcd->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(wcd->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(wcd->reset_gpio), "Reset GPIO missing from DT\n");
 
 	wcd->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(wcd->mclk))
@@ -4988,30 +4990,16 @@ static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 	if (IS_ERR(wcd->native_clk))
 		return dev_err_probe(dev, PTR_ERR(wcd->native_clk), "slimbus clock not found\n");
 
-	wcd->supplies[0].supply = "vdd-buck";
-	wcd->supplies[1].supply = "vdd-buck-sido";
-	wcd->supplies[2].supply = "vdd-tx";
-	wcd->supplies[3].supply = "vdd-rx";
-	wcd->supplies[4].supply = "vdd-io";
-
-	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(wcd9335_supplies),
+					     wcd9335_supplies);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to get supplies\n");
+		return dev_err_probe(dev, ret, "Failed to get and enable supplies\n");
 
 	return 0;
 }
 
 static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
 {
-	struct device *dev = wcd->dev;
-	int ret;
-
-	ret = regulator_bulk_enable(WCD9335_MAX_SUPPLY, wcd->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
-
 	/*
 	 * For WCD9335, it takes about 600us for the Vout_A and
 	 * Vout_D to be ready after BUCK_SIDO is powered up.
@@ -5021,9 +5009,9 @@ static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
 	 */
 	usleep_range(600, 650);
 
-	gpio_direction_output(wcd->reset_gpio, 0);
+	gpiod_set_value(wcd->reset_gpio, 1);
 	msleep(20);
-	gpio_set_value(wcd->reset_gpio, 1);
+	gpiod_set_value(wcd->reset_gpio, 0);
 	msleep(20);
 
 	return 0;
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index c7387081577c..0da4ee9757c0 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2282,6 +2282,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x17aa, 0x104d, /* Lenovo ThinkStation P620 Internal Speaker + Front Headset */
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
+	DEVICE_FLG(0x17ef, 0x3083, /* Lenovo TBT3 dock */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1852, 0x5062, /* Luxman D-08u */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1852, 0x5065, /* Luxman DA-06 */
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index c1ea8844a46f..aa91d63749f2 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -987,6 +987,8 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
+	if (wLength < sizeof(cluster))
+		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)
 		return ERR_PTR(-ENOMEM);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 46cce18c8308..12306b5de3ef 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -225,6 +225,9 @@ static void btf_dump_free_names(struct hashmap *map)
 	size_t bkt;
 	struct hashmap_entry *cur;
 
+	if (!map)
+		return;
+
 	hashmap__for_each_entry(map, cur, bkt)
 		free((void *)cur->pkey);
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1290314da676..36e341b4b77b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -596,7 +596,7 @@ struct extern_desc {
 	int sym_idx;
 	int btf_id;
 	int sec_btf_id;
-	const char *name;
+	char *name;
 	char *essent_name;
 	bool is_set;
 	bool is_weak;
@@ -4223,7 +4223,9 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
 			return ext->btf_id;
 		}
 		t = btf__type_by_id(obj->btf, ext->btf_id);
-		ext->name = btf__name_by_offset(obj->btf, t->name_off);
+		ext->name = strdup(btf__name_by_offset(obj->btf, t->name_off));
+		if (!ext->name)
+			return -ENOMEM;
 		ext->sym_idx = i;
 		ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
 
@@ -9062,8 +9064,10 @@ void bpf_object__close(struct bpf_object *obj)
 	zfree(&obj->btf_custom_path);
 	zfree(&obj->kconfig);
 
-	for (i = 0; i < obj->nr_extern; i++)
+	for (i = 0; i < obj->nr_extern; i++) {
+		zfree(&obj->externs[i].name);
 		zfree(&obj->externs[i].essent_name);
+	}
 
 	zfree(&obj->externs);
 	obj->nr_extern = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
index a3f220ba7025..ee65bad0436d 100644
--- a/tools/testing/selftests/bpf/progs/test_global_map_resize.c
+++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
@@ -32,6 +32,16 @@ int my_int_last SEC(".data.array_not_last");
 
 int percpu_arr[1] SEC(".data.percpu_arr");
 
+/* at least one extern is included, to ensure that a specific
+ * regression is tested whereby resizing resulted in a free-after-use
+ * bug after type information is invalidated by the resize operation.
+ *
+ * There isn't a particularly good API to test for this specific condition,
+ * but by having externs for the resizing tests it will cover this path.
+ */
+extern int LINUX_KERNEL_VERSION __kconfig;
+long version_sink;
+
 SEC("tp/syscalls/sys_enter_getpid")
 int bss_array_sum(void *ctx)
 {
@@ -44,6 +54,9 @@ int bss_array_sum(void *ctx)
 	for (size_t i = 0; i < bss_array_len; ++i)
 		sum += array[i];
 
+	/* see above; ensure this is not optimized out */
+	version_sink = LINUX_KERNEL_VERSION;
+
 	return 0;
 }
 
@@ -59,6 +72,9 @@ int data_array_sum(void *ctx)
 	for (size_t i = 0; i < data_array_len; ++i)
 		sum += my_array[i];
 
+	/* see above; ensure this is not optimized out */
+	version_sink = LINUX_KERNEL_VERSION;
+
 	return 0;
 }
 

