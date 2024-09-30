Return-Path: <stable+bounces-78278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41098A774
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E0C2839E1
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34AC192B69;
	Mon, 30 Sep 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qdvd3xfn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B1C192B60;
	Mon, 30 Sep 2024 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707350; cv=none; b=Sav0bzyJwiBnSDbZpErdJ0j4MaXTpiV1649ThD7w5eBMosCuZGzBl/DQMiWoxeFlrDH8KYItqmb8MZcHSTannHwXpkpcKVz1tC96imGpRUxgF0FYFCYNeJqk0XUQvXkN+28JBSDt0D9uT9s6li1yLy0pQstsUK56TNlw69PfWy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707350; c=relaxed/simple;
	bh=fTQfgxIi1K9D5/Z1H7l5RvIne5CDIpiirZTJU7r3Rfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TTPH1RyhHhWoiYVYZrd7j9ZJSg8/AsOqXb0Fxlqr+nS94+WMCOSCUVyFxGo0UFsM0wfrlfyxbMHGnc++3Zq1tn190XhyTzOtHWUDitEIEZ44Y/EX2kCvRyqGoSCJXKUvYgNf/zMlUL/bZA5oaJWWvuGZUYMqH+kAtPc4RAu9F2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qdvd3xfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30536C4CEC7;
	Mon, 30 Sep 2024 14:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727707349;
	bh=fTQfgxIi1K9D5/Z1H7l5RvIne5CDIpiirZTJU7r3Rfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qdvd3xfnB0uF/XCUM12ZAv5RT1kHJwY06FQ/9sHIzQCtQmUNdAlS5dz9qkStwxPzJ
	 KJ5yQKhuNuTa76fIa2jNznfGOKl4F3NT9iNXwvQdHjhsyvFM2RuXcfRofRjzBM+QOV
	 AeW/or8wErgw1kMrVpmS38QZedIhfV7TjvHVuyi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.10.12
Date: Mon, 30 Sep 2024 16:42:17 +0200
Message-ID: <2024093016-improper-brethren-62f9@gregkh>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <2024093015-imaging-drainer-82ac@gregkh>
References: <2024093015-imaging-drainer-82ac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 447856c43b32..175d7f27ea32 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 10
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/loongarch/include/asm/hw_irq.h b/arch/loongarch/include/asm/hw_irq.h
index af4f4e8fbd85..8156ffb67415 100644
--- a/arch/loongarch/include/asm/hw_irq.h
+++ b/arch/loongarch/include/asm/hw_irq.h
@@ -9,6 +9,8 @@
 
 extern atomic_t irq_err_count;
 
+#define ARCH_IRQ_INIT_FLAGS	IRQ_NOPROBE
+
 /*
  * interrupt-retrigger: NOP for now. This may not be appropriate for all
  * machines, we'll see ...
diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index 590a92cb5416..d741c3e9933a 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -76,7 +76,6 @@ static inline void kvm_restore_lasx(struct loongarch_fpu *fpu) { }
 #endif
 
 void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
-void kvm_reset_timer(struct kvm_vcpu *vcpu);
 void kvm_save_timer(struct kvm_vcpu *vcpu);
 void kvm_restore_timer(struct kvm_vcpu *vcpu);
 
diff --git a/arch/loongarch/kernel/irq.c b/arch/loongarch/kernel/irq.c
index f4991c03514f..adac8fcbb2ac 100644
--- a/arch/loongarch/kernel/irq.c
+++ b/arch/loongarch/kernel/irq.c
@@ -102,9 +102,6 @@ void __init init_IRQ(void)
 	mp_ops.init_ipi();
 #endif
 
-	for (i = 0; i < NR_IRQS; i++)
-		irq_set_noprobe(i);
-
 	for_each_possible_cpu(i) {
 		page = alloc_pages_node(cpu_to_node(i), GFP_KERNEL, order);
 
diff --git a/arch/loongarch/kvm/timer.c b/arch/loongarch/kvm/timer.c
index bcc6b6d063d9..74a4b5c272d6 100644
--- a/arch/loongarch/kvm/timer.c
+++ b/arch/loongarch/kvm/timer.c
@@ -188,10 +188,3 @@ void kvm_save_timer(struct kvm_vcpu *vcpu)
 	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_ESTAT);
 	preempt_enable();
 }
-
-void kvm_reset_timer(struct kvm_vcpu *vcpu)
-{
-	write_gcsr_timercfg(0);
-	kvm_write_sw_gcsr(vcpu->arch.csr, LOONGARCH_CSR_TCFG, 0);
-	hrtimer_cancel(&vcpu->arch.swtimer);
-}
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 9e8030d45129..0b53f4d9fddf 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -572,7 +572,7 @@ static int kvm_set_one_reg(struct kvm_vcpu *vcpu,
 				vcpu->kvm->arch.time_offset = (signed long)(v - drdtime());
 			break;
 		case KVM_REG_LOONGARCH_VCPU_RESET:
-			kvm_reset_timer(vcpu);
+			vcpu->arch.st.guest_addr = 0;
 			memset(&vcpu->arch.irq_pending, 0, sizeof(vcpu->arch.irq_pending));
 			memset(&vcpu->arch.irq_clear, 0, sizeof(vcpu->arch.irq_clear));
 			break;
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 3827dc76edd8..4520c5741579 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -193,11 +193,6 @@ asmlinkage void __init mmu_init(void)
 {
 	unsigned int kstart, ksize;
 
-	if (!memblock.reserved.cnt) {
-		pr_emerg("Error memory count\n");
-		machine_restart(NULL);
-	}
-
 	if ((u32) memblock.memory.regions[0].size < 0x400000) {
 		pr_emerg("Memory must be greater than 4MB\n");
 		machine_restart(NULL);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 41632fb57796..ead967479fa6 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -424,6 +424,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
index 16c3edb8c46e..aa826033b0ce 100644
--- a/drivers/accel/drm_accel.c
+++ b/drivers/accel/drm_accel.c
@@ -8,7 +8,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
-#include <linux/idr.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
 #include <drm/drm_auth.h>
@@ -18,8 +18,7 @@
 #include <drm/drm_ioctl.h>
 #include <drm/drm_print.h>
 
-static DEFINE_SPINLOCK(accel_minor_lock);
-static struct idr accel_minors_idr;
+DEFINE_XARRAY_ALLOC(accel_minors_xa);
 
 static struct dentry *accel_debugfs_root;
 
@@ -117,99 +116,6 @@ void accel_set_device_instance_params(struct device *kdev, int index)
 	kdev->type = &accel_sysfs_device_minor;
 }
 
-/**
- * accel_minor_alloc() - Allocates a new accel minor
- *
- * This function access the accel minors idr and allocates from it
- * a new id to represent a new accel minor
- *
- * Return: A new id on success or error code in case idr_alloc failed
- */
-int accel_minor_alloc(void)
-{
-	unsigned long flags;
-	int r;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	r = idr_alloc(&accel_minors_idr, NULL, 0, ACCEL_MAX_MINORS, GFP_NOWAIT);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-
-	return r;
-}
-
-/**
- * accel_minor_remove() - Remove an accel minor
- * @index: The minor id to remove.
- *
- * This function access the accel minors idr and removes from
- * it the member with the id that is passed to this function.
- */
-void accel_minor_remove(int index)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	idr_remove(&accel_minors_idr, index);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-}
-
-/**
- * accel_minor_replace() - Replace minor pointer in accel minors idr.
- * @minor: Pointer to the new minor.
- * @index: The minor id to replace.
- *
- * This function access the accel minors idr structure and replaces the pointer
- * that is associated with an existing id. Because the minor pointer can be
- * NULL, we need to explicitly pass the index.
- *
- * Return: 0 for success, negative value for error
- */
-void accel_minor_replace(struct drm_minor *minor, int index)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	idr_replace(&accel_minors_idr, minor, index);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-}
-
-/*
- * Looks up the given minor-ID and returns the respective DRM-minor object. The
- * refence-count of the underlying device is increased so you must release this
- * object with accel_minor_release().
- *
- * The object can be only a drm_minor that represents an accel device.
- *
- * As long as you hold this minor, it is guaranteed that the object and the
- * minor->dev pointer will stay valid! However, the device may get unplugged and
- * unregistered while you hold the minor.
- */
-static struct drm_minor *accel_minor_acquire(unsigned int minor_id)
-{
-	struct drm_minor *minor;
-	unsigned long flags;
-
-	spin_lock_irqsave(&accel_minor_lock, flags);
-	minor = idr_find(&accel_minors_idr, minor_id);
-	if (minor)
-		drm_dev_get(minor->dev);
-	spin_unlock_irqrestore(&accel_minor_lock, flags);
-
-	if (!minor) {
-		return ERR_PTR(-ENODEV);
-	} else if (drm_dev_is_unplugged(minor->dev)) {
-		drm_dev_put(minor->dev);
-		return ERR_PTR(-ENODEV);
-	}
-
-	return minor;
-}
-
-static void accel_minor_release(struct drm_minor *minor)
-{
-	drm_dev_put(minor->dev);
-}
-
 /**
  * accel_open - open method for ACCEL file
  * @inode: device inode
@@ -227,7 +133,7 @@ int accel_open(struct inode *inode, struct file *filp)
 	struct drm_minor *minor;
 	int retcode;
 
-	minor = accel_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&accel_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
@@ -246,7 +152,7 @@ int accel_open(struct inode *inode, struct file *filp)
 
 err_undo:
 	atomic_dec(&dev->open_count);
-	accel_minor_release(minor);
+	drm_minor_release(minor);
 	return retcode;
 }
 EXPORT_SYMBOL_GPL(accel_open);
@@ -257,7 +163,7 @@ static int accel_stub_open(struct inode *inode, struct file *filp)
 	struct drm_minor *minor;
 	int err;
 
-	minor = accel_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&accel_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
@@ -274,7 +180,7 @@ static int accel_stub_open(struct inode *inode, struct file *filp)
 		err = 0;
 
 out:
-	accel_minor_release(minor);
+	drm_minor_release(minor);
 
 	return err;
 }
@@ -290,15 +196,13 @@ void accel_core_exit(void)
 	unregister_chrdev(ACCEL_MAJOR, "accel");
 	debugfs_remove(accel_debugfs_root);
 	accel_sysfs_destroy();
-	idr_destroy(&accel_minors_idr);
+	WARN_ON(!xa_empty(&accel_minors_xa));
 }
 
 int __init accel_core_init(void)
 {
 	int ret;
 
-	idr_init(&accel_minors_idr);
-
 	ret = accel_sysfs_init();
 	if (ret < 0) {
 		DRM_ERROR("Cannot create ACCEL class: %d\n", ret);
diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 1fd3b7073ab9..b5bfe12a97e1 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1208,7 +1208,7 @@ static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data)
 	int err;
 	struct hci_dev *hdev;
 
-	hdev = hci_alloc_dev();
+	hdev = hci_alloc_dev_priv(sizeof(struct btintel_data));
 	if (!hdev)
 		return -ENOMEM;
 
diff --git a/drivers/clk/qcom/gcc-sm8650.c b/drivers/clk/qcom/gcc-sm8650.c
index 9d1cbdf860fb..10834c3141d0 100644
--- a/drivers/clk/qcom/gcc-sm8650.c
+++ b/drivers/clk/qcom/gcc-sm8650.c
@@ -713,7 +713,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s0_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -728,7 +728,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s1_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -743,7 +743,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s2_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -758,7 +758,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s3_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -773,7 +773,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s4_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -788,7 +788,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s5_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -803,7 +803,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s6_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -818,7 +818,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s7_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -833,7 +833,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s8_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -848,7 +848,7 @@ static struct clk_rcg2 gcc_qupv3_i2c_s9_clk_src = {
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -863,7 +863,7 @@ static struct clk_init_data gcc_qupv3_wrap1_qspi_ref_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_qspi_ref_clk_src = {
@@ -899,7 +899,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
@@ -916,7 +916,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
@@ -948,7 +948,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
@@ -980,7 +980,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
@@ -997,7 +997,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
@@ -1014,7 +1014,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
@@ -1031,7 +1031,7 @@ static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
@@ -1059,7 +1059,7 @@ static struct clk_rcg2 gcc_qupv3_wrap2_ibi_ctrl_0_clk_src = {
 		.parent_data = gcc_parent_data_2,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_shared_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
@@ -1068,7 +1068,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s0_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
@@ -1085,7 +1085,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s1_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
@@ -1102,7 +1102,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s2_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
@@ -1119,7 +1119,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s3_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
@@ -1136,7 +1136,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s4_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
@@ -1153,7 +1153,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s5_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s5_clk_src = {
@@ -1186,7 +1186,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s6_clk_src_init = {
 	.parent_data = gcc_parent_data_10,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_10),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s6_clk_src = {
@@ -1203,7 +1203,7 @@ static struct clk_init_data gcc_qupv3_wrap2_s7_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
@@ -1226,7 +1226,7 @@ static struct clk_init_data gcc_qupv3_wrap3_qspi_ref_clk_src_init = {
 	.parent_data = gcc_parent_data_0,
 	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
 	.flags = CLK_SET_RATE_PARENT,
-	.ops = &clk_rcg2_shared_ops,
+	.ops = &clk_rcg2_ops,
 };
 
 static struct clk_rcg2 gcc_qupv3_wrap3_qspi_ref_clk_src = {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 06b65159f7b4..33c7740dd50a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -672,6 +672,9 @@ static int smu_v14_0_2_set_default_dpm_table(struct smu_context *smu)
 		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
 					skutable->LclkFreq[link_level];
 		pcie_table->num_of_link_levels++;
+
+		if (link_level == 0)
+			link_level++;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index fe46b0ebefea..e5eb5d672bcd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -160,6 +160,7 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 	struct drm_plane *plane;
 	struct list_head zorder_list;
 	int order = 0, err;
+	u32 slave_zpos = 0;
 
 	DRM_DEBUG_ATOMIC("[CRTC:%d:%s] calculating normalized zpos values\n",
 			 crtc->base.id, crtc->name);
@@ -199,10 +200,13 @@ static int komeda_crtc_normalize_zpos(struct drm_crtc *crtc,
 				 plane_st->zpos, plane_st->normalized_zpos);
 
 		/* calculate max slave zorder */
-		if (has_bit(drm_plane_index(plane), kcrtc->slave_planes))
+		if (has_bit(drm_plane_index(plane), kcrtc->slave_planes)) {
+			slave_zpos = plane_st->normalized_zpos;
+			if (to_kplane_st(plane_st)->layer_split)
+				slave_zpos++;
 			kcrtc_st->max_slave_zorder =
-				max(plane_st->normalized_zpos,
-				    kcrtc_st->max_slave_zorder);
+				max(slave_zpos, kcrtc_st->max_slave_zorder);
+		}
 	}
 
 	crtc_st->zpos_changed = true;
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 535b624d4c9d..928824b91945 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -34,6 +34,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
 #include <drm/drm_cache.h>
@@ -54,8 +55,7 @@ MODULE_AUTHOR("Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl");
 MODULE_DESCRIPTION("DRM shared core routines");
 MODULE_LICENSE("GPL and additional rights");
 
-static DEFINE_SPINLOCK(drm_minor_lock);
-static struct idr drm_minors_idr;
+DEFINE_XARRAY_ALLOC(drm_minors_xa);
 
 /*
  * If the drm core fails to init for whatever reason,
@@ -83,6 +83,18 @@ DEFINE_STATIC_SRCU(drm_unplug_srcu);
  * registered and unregistered dynamically according to device-state.
  */
 
+static struct xarray *drm_minor_get_xa(enum drm_minor_type type)
+{
+	if (type == DRM_MINOR_PRIMARY || type == DRM_MINOR_RENDER)
+		return &drm_minors_xa;
+#if IS_ENABLED(CONFIG_DRM_ACCEL)
+	else if (type == DRM_MINOR_ACCEL)
+		return &accel_minors_xa;
+#endif
+	else
+		return ERR_PTR(-EOPNOTSUPP);
+}
+
 static struct drm_minor **drm_minor_get_slot(struct drm_device *dev,
 					     enum drm_minor_type type)
 {
@@ -101,25 +113,31 @@ static struct drm_minor **drm_minor_get_slot(struct drm_device *dev,
 static void drm_minor_alloc_release(struct drm_device *dev, void *data)
 {
 	struct drm_minor *minor = data;
-	unsigned long flags;
 
 	WARN_ON(dev != minor->dev);
 
 	put_device(minor->kdev);
 
-	if (minor->type == DRM_MINOR_ACCEL) {
-		accel_minor_remove(minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_remove(&drm_minors_idr, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
+	xa_erase(drm_minor_get_xa(minor->type), minor->index);
 }
 
+/*
+ * DRM used to support 64 devices, for backwards compatibility we need to maintain the
+ * minor allocation scheme where minors 0-63 are primary nodes, 64-127 are control nodes,
+ * and 128-191 are render nodes.
+ * After reaching the limit, we're allocating minors dynamically - first-come, first-serve.
+ * Accel nodes are using a distinct major, so the minors are allocated in continuous 0-MAX
+ * range.
+ */
+#define DRM_MINOR_LIMIT(t) ({ \
+	typeof(t) _t = (t); \
+	_t == DRM_MINOR_ACCEL ? XA_LIMIT(0, ACCEL_MAX_MINORS) : XA_LIMIT(64 * _t, 64 * _t + 63); \
+})
+#define DRM_EXTENDED_MINOR_LIMIT XA_LIMIT(192, (1 << MINORBITS) - 1)
+
 static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 	int r;
 
 	minor = drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
@@ -129,25 +147,14 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 	minor->type = type;
 	minor->dev = dev;
 
-	idr_preload(GFP_KERNEL);
-	if (type == DRM_MINOR_ACCEL) {
-		r = accel_minor_alloc();
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		r = idr_alloc(&drm_minors_idr,
-			NULL,
-			64 * type,
-			64 * (type + 1),
-			GFP_NOWAIT);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
-	idr_preload_end();
-
+	r = xa_alloc(drm_minor_get_xa(type), &minor->index,
+		     NULL, DRM_MINOR_LIMIT(type), GFP_KERNEL);
+	if (r == -EBUSY && (type == DRM_MINOR_PRIMARY || type == DRM_MINOR_RENDER))
+		r = xa_alloc(&drm_minors_xa, &minor->index,
+			     NULL, DRM_EXTENDED_MINOR_LIMIT, GFP_KERNEL);
 	if (r < 0)
 		return r;
 
-	minor->index = r;
-
 	r = drmm_add_action_or_reset(dev, drm_minor_alloc_release, minor);
 	if (r)
 		return r;
@@ -163,7 +170,7 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
+	void *entry;
 	int ret;
 
 	DRM_DEBUG("\n");
@@ -186,13 +193,12 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 		goto err_debugfs;
 
 	/* replace NULL with @minor so lookups will succeed from now on */
-	if (minor->type == DRM_MINOR_ACCEL) {
-		accel_minor_replace(minor, minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_replace(&drm_minors_idr, minor, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
+	entry = xa_store(drm_minor_get_xa(type), minor->index, minor, GFP_KERNEL);
+	if (xa_is_err(entry)) {
+		ret = xa_err(entry);
+		goto err_debugfs;
 	}
+	WARN_ON(entry);
 
 	DRM_DEBUG("new minor registered %d\n", minor->index);
 	return 0;
@@ -205,20 +211,13 @@ static int drm_minor_register(struct drm_device *dev, enum drm_minor_type type)
 static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 
 	minor = *drm_minor_get_slot(dev, type);
 	if (!minor || !device_is_registered(minor->kdev))
 		return;
 
 	/* replace @minor with NULL so lookups will fail from now on */
-	if (minor->type == DRM_MINOR_ACCEL) {
-		accel_minor_replace(NULL, minor->index);
-	} else {
-		spin_lock_irqsave(&drm_minor_lock, flags);
-		idr_replace(&drm_minors_idr, NULL, minor->index);
-		spin_unlock_irqrestore(&drm_minor_lock, flags);
-	}
+	xa_store(drm_minor_get_xa(type), minor->index, NULL, GFP_KERNEL);
 
 	device_del(minor->kdev);
 	dev_set_drvdata(minor->kdev, NULL); /* safety belt */
@@ -234,16 +233,15 @@ static void drm_minor_unregister(struct drm_device *dev, enum drm_minor_type typ
  * minor->dev pointer will stay valid! However, the device may get unplugged and
  * unregistered while you hold the minor.
  */
-struct drm_minor *drm_minor_acquire(unsigned int minor_id)
+struct drm_minor *drm_minor_acquire(struct xarray *minor_xa, unsigned int minor_id)
 {
 	struct drm_minor *minor;
-	unsigned long flags;
 
-	spin_lock_irqsave(&drm_minor_lock, flags);
-	minor = idr_find(&drm_minors_idr, minor_id);
+	xa_lock(minor_xa);
+	minor = xa_load(minor_xa, minor_id);
 	if (minor)
 		drm_dev_get(minor->dev);
-	spin_unlock_irqrestore(&drm_minor_lock, flags);
+	xa_unlock(minor_xa);
 
 	if (!minor) {
 		return ERR_PTR(-ENODEV);
@@ -1036,7 +1034,7 @@ static int drm_stub_open(struct inode *inode, struct file *filp)
 
 	DRM_DEBUG("\n");
 
-	minor = drm_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&drm_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
@@ -1071,7 +1069,7 @@ static void drm_core_exit(void)
 	unregister_chrdev(DRM_MAJOR, "drm");
 	debugfs_remove(drm_debugfs_root);
 	drm_sysfs_destroy();
-	idr_destroy(&drm_minors_idr);
+	WARN_ON(!xa_empty(&drm_minors_xa));
 	drm_connector_ida_destroy();
 }
 
@@ -1080,7 +1078,6 @@ static int __init drm_core_init(void)
 	int ret;
 
 	drm_connector_ida_init();
-	idr_init(&drm_minors_idr);
 	drm_memcpy_init_early();
 
 	ret = drm_sysfs_init();
diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index 714e42b05108..f917b259b334 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -364,7 +364,7 @@ int drm_open(struct inode *inode, struct file *filp)
 	struct drm_minor *minor;
 	int retcode;
 
-	minor = drm_minor_acquire(iminor(inode));
+	minor = drm_minor_acquire(&drm_minors_xa, iminor(inode));
 	if (IS_ERR(minor))
 		return PTR_ERR(minor);
 
diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 690505a1f7a5..12acf44c4e24 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -81,10 +81,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
 void drm_prime_remove_buf_handle(struct drm_prime_file_private *prime_fpriv,
 				 uint32_t handle);
 
-/* drm_drv.c */
-struct drm_minor *drm_minor_acquire(unsigned int minor_id);
-void drm_minor_release(struct drm_minor *minor);
-
 /* drm_managed.c */
 void drm_managed_release(struct drm_device *dev);
 void drmm_add_final_kfree(struct drm_device *dev, void *container);
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 36f9e38000d5..3b3b8beed83a 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -412,7 +412,7 @@ static const struct ec_board_info board_info_strix_b550_i_gaming = {
 
 static const struct ec_board_info board_info_strix_x570_e_gaming = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
-		SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR |
 		SENSOR_FAN_CHIPSET | SENSOR_CURR_CPU |
 		SENSOR_IN_CPU_CORE,
 	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e4f0a382c216..ddde067f593f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2141,7 +2141,7 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static const struct ethtool_ops m_can_ethtool_ops = {
+static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
 		ETHTOOL_COALESCE_TX_USECS_IRQ |
@@ -2152,18 +2152,20 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 	.set_coalesce = m_can_set_coalesce,
 };
 
-static const struct ethtool_ops m_can_ethtool_ops_polling = {
+static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
-static int register_m_can_dev(struct net_device *dev)
+static int register_m_can_dev(struct m_can_classdev *cdev)
 {
+	struct net_device *dev = cdev->net;
+
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
-	if (dev->irq)
-		dev->ethtool_ops = &m_can_ethtool_ops;
+	if (dev->irq && cdev->is_peripheral)
+		dev->ethtool_ops = &m_can_ethtool_ops_coalescing;
 	else
-		dev->ethtool_ops = &m_can_ethtool_ops_polling;
+		dev->ethtool_ops = &m_can_ethtool_ops;
 
 	return register_candev(dev);
 }
@@ -2349,7 +2351,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	if (ret)
 		goto rx_offload_del;
 
-	ret = register_m_can_dev(cdev->net);
+	ret = register_m_can_dev(cdev);
 	if (ret) {
 		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
 			cdev->net->name, ret);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f1e6007b74ce..262c6c700286 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -744,6 +744,7 @@ static void mcp251xfd_chip_stop(struct mcp251xfd_priv *priv,
 
 	mcp251xfd_chip_interrupts_disable(priv);
 	mcp251xfd_chip_rx_int_disable(priv);
+	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_sleep(priv);
 }
 
@@ -763,6 +764,8 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 	if (err)
 		goto out_chip_stop;
 
+	mcp251xfd_timestamp_start(priv);
+
 	err = mcp251xfd_set_bittiming(priv);
 	if (err)
 		goto out_chip_stop;
@@ -791,7 +794,7 @@ static int mcp251xfd_chip_start(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_chip_stop:
+out_chip_stop:
 	mcp251xfd_dump(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 
@@ -1576,7 +1579,7 @@ static irqreturn_t mcp251xfd_irq(int irq, void *dev_id)
 		handled = IRQ_HANDLED;
 	} while (1);
 
- out_fail:
+out_fail:
 	can_rx_offload_threaded_irq_finish(&priv->offload);
 
 	netdev_err(priv->ndev, "IRQ handler returned %d (intf=0x%08x).\n",
@@ -1610,11 +1613,12 @@ static int mcp251xfd_open(struct net_device *ndev)
 	if (err)
 		goto out_mcp251xfd_ring_free;
 
+	mcp251xfd_timestamp_init(priv);
+
 	err = mcp251xfd_chip_start(priv);
 	if (err)
 		goto out_transceiver_disable;
 
-	mcp251xfd_timestamp_init(priv);
 	clear_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
 	can_rx_offload_enable(&priv->offload);
 
@@ -1641,22 +1645,21 @@ static int mcp251xfd_open(struct net_device *ndev)
 
 	return 0;
 
- out_free_irq:
+out_free_irq:
 	free_irq(spi->irq, priv);
- out_destroy_workqueue:
+out_destroy_workqueue:
 	destroy_workqueue(priv->wq);
- out_can_rx_offload_disable:
+out_can_rx_offload_disable:
 	can_rx_offload_disable(&priv->offload);
 	set_bit(MCP251XFD_FLAGS_DOWN, priv->flags);
-	mcp251xfd_timestamp_stop(priv);
- out_transceiver_disable:
+out_transceiver_disable:
 	mcp251xfd_transceiver_disable(priv);
- out_mcp251xfd_ring_free:
+out_mcp251xfd_ring_free:
 	mcp251xfd_ring_free(priv);
- out_pm_runtime_put:
+out_pm_runtime_put:
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	pm_runtime_put(ndev->dev.parent);
- out_close_candev:
+out_close_candev:
 	close_candev(ndev);
 
 	return err;
@@ -1674,7 +1677,6 @@ static int mcp251xfd_stop(struct net_device *ndev)
 	free_irq(ndev->irq, priv);
 	destroy_workqueue(priv->wq);
 	can_rx_offload_disable(&priv->offload);
-	mcp251xfd_timestamp_stop(priv);
 	mcp251xfd_chip_stop(priv, CAN_STATE_STOPPED);
 	mcp251xfd_transceiver_disable(priv);
 	mcp251xfd_ring_free(priv);
@@ -1820,9 +1822,9 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
 	*effective_speed_hz_slow = xfer[0].effective_speed_hz;
 	*effective_speed_hz_fast = xfer[1].effective_speed_hz;
 
- out_kfree_buf_tx:
+out_kfree_buf_tx:
 	kfree(buf_tx);
- out_kfree_buf_rx:
+out_kfree_buf_rx:
 	kfree(buf_rx);
 
 	return err;
@@ -1936,13 +1938,13 @@ static int mcp251xfd_register(struct mcp251xfd_priv *priv)
 
 	return 0;
 
- out_unregister_candev:
+out_unregister_candev:
 	unregister_candev(ndev);
- out_chip_sleep:
+out_chip_sleep:
 	mcp251xfd_chip_sleep(priv);
- out_runtime_disable:
+out_runtime_disable:
 	pm_runtime_disable(ndev->dev.parent);
- out_runtime_put_noidle:
+out_runtime_put_noidle:
 	pm_runtime_put_noidle(ndev->dev.parent);
 	mcp251xfd_clks_and_vdd_disable(priv);
 
@@ -2162,9 +2164,9 @@ static int mcp251xfd_probe(struct spi_device *spi)
 
 	return 0;
 
- out_can_rx_offload_del:
+out_can_rx_offload_del:
 	can_rx_offload_del(&priv->offload);
- out_free_candev:
+out_free_candev:
 	spi->max_speed_hz = priv->spi_max_speed_hz_orig;
 
 	free_candev(ndev);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
index 004eaf96262b..050321345304 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c
@@ -94,7 +94,7 @@ static void mcp251xfd_dump_registers(const struct mcp251xfd_priv *priv,
 		kfree(buf);
 	}
 
- out:
+out:
 	mcp251xfd_dump_header(iter, MCP251XFD_DUMP_OBJECT_TYPE_REG, reg);
 }
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 92b7bc7f14b9..65150e762007 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -397,7 +397,7 @@ mcp251xfd_regmap_crc_read(void *context,
 
 		return err;
 	}
- out:
+out:
 	memcpy(val_buf, buf_rx->data, val_len);
 
 	return 0;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index f72582d4d3e8..83c18035b2a2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -290,7 +290,7 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 	const struct mcp251xfd_rx_ring *rx_ring;
 	u16 base = 0, ram_used;
 	u8 fifo_nr = 1;
-	int i;
+	int err = 0, i;
 
 	netdev_reset_queue(priv->ndev);
 
@@ -386,10 +386,18 @@ int mcp251xfd_ring_init(struct mcp251xfd_priv *priv)
 		netdev_err(priv->ndev,
 			   "Error during ring configuration, using more RAM (%u bytes) than available (%u bytes).\n",
 			   ram_used, MCP251XFD_RAM_SIZE);
-		return -ENOMEM;
+		err = -ENOMEM;
 	}
 
-	return 0;
+	if (priv->tx_obj_num_coalesce_irq &&
+	    priv->tx_obj_num_coalesce_irq * 2 != priv->tx->obj_num) {
+		netdev_err(priv->ndev,
+			   "Error during ring configuration, number of TEF coalescing buffers (%u) must be half of TEF buffers (%u).\n",
+			   priv->tx_obj_num_coalesce_irq, priv->tx->obj_num);
+		err = -EINVAL;
+	}
+
+	return err;
 }
 
 void mcp251xfd_ring_free(struct mcp251xfd_priv *priv)
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 3886476a8f8e..f732556d233a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -219,7 +219,7 @@ int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv)
 		total_frame_len += frame_len;
 	}
 
- out_netif_wake_queue:
+out_netif_wake_queue:
 	len = i;	/* number of handled goods TEFs */
 	if (len) {
 		struct mcp251xfd_tef_ring *ring = priv->tef;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 1db99aabe85c..202ca0d24d03 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -48,9 +48,12 @@ void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 	cc->shift = 1;
 	cc->mult = clocksource_hz2mult(priv->can.clock.freq, cc->shift);
 
-	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
-
 	INIT_DELAYED_WORK(&priv->timestamp, mcp251xfd_timestamp_work);
+}
+
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv)
+{
+	timecounter_init(&priv->tc, &priv->cc, ktime_get_real_ns());
 	schedule_delayed_work(&priv->timestamp,
 			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 991662fbba42..dcbbd2b2fae8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -957,6 +957,7 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
+void mcp251xfd_timestamp_start(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
 void mcp251xfd_tx_obj_write_sync(struct work_struct *work);
diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index fddfd1dd5070..4c546c3aef0f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -572,7 +572,7 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	(*processed)++;
 	return true;
 
- drop:
+drop:
 	/* Clean rxdes0 (which resets own bit) */
 	rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -656,6 +656,11 @@ static bool ftgmac100_tx_complete_packet(struct ftgmac100 *priv)
 	ftgmac100_free_tx_packet(priv, pointer, skb, txdes, ctl_stat);
 	txdes->txdes0 = cpu_to_le32(ctl_stat & priv->txdes0_edotr_mask);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	priv->tx_clean_pointer = ftgmac100_next_tx_pointer(priv, pointer);
 
 	return true;
@@ -809,6 +814,11 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	dma_wmb();
 	first->txdes0 = cpu_to_le32(f_ctl_stat);
 
+	/* Ensure the descriptor config is visible before setting the tx
+	 * pointer.
+	 */
+	smp_wmb();
+
 	/* Update next TX pointer */
 	priv->tx_pointer = pointer;
 
@@ -829,7 +839,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
- dma_err:
+dma_err:
 	if (net_ratelimit())
 		netdev_err(netdev, "map tx fragment failed\n");
 
@@ -851,7 +861,7 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	 * last fragment, so we know ftgmac100_free_tx_packet()
 	 * hasn't freed the skb yet.
 	 */
- drop:
+drop:
 	/* Drop the packet */
 	dev_kfree_skb_any(skb);
 	netdev->stats.tx_dropped++;
@@ -1344,7 +1354,7 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
 	ftgmac100_init_all(priv, true);
 
 	netdev_dbg(netdev, "Reset done !\n");
- bail:
+bail:
 	if (priv->mii_bus)
 		mutex_unlock(&priv->mii_bus->mdio_lock);
 	if (netdev->phydev)
@@ -1543,15 +1553,15 @@ static int ftgmac100_open(struct net_device *netdev)
 
 	return 0;
 
- err_ncsi:
+err_ncsi:
 	napi_disable(&priv->napi);
 	netif_stop_queue(netdev);
- err_alloc:
+err_alloc:
 	ftgmac100_free_buffers(priv);
 	free_irq(netdev->irq, netdev);
- err_irq:
+err_irq:
 	netif_napi_del(&priv->napi);
- err_hw:
+err_hw:
 	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
 	ftgmac100_free_rings(priv);
 	return err;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c2ba58659347..a3ee7697edb5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2419,7 +2419,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		dev_err(ice_pf_to_dev(pf), "Failed to remove RDMA scheduler config for VSI %u, err %d\n",
 			vsi->vsi_num, err);
 
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		/* return value check can be skipped here, it always returns
 		 * 0 if reset is in progress
 		 */
@@ -2521,7 +2521,7 @@ static void ice_vsi_release_msix(struct ice_vsi *vsi)
 		for (q = 0; q < q_vector->num_ring_tx; q++) {
 			ice_write_itr(&q_vector->tx, 0);
 			wr32(hw, QINT_TQCTL(vsi->txq_map[txq]), 0);
-			if (ice_is_xdp_ena_vsi(vsi)) {
+			if (vsi->xdp_rings) {
 				u32 xdp_txq = txq + vsi->num_xdp_txq;
 
 				wr32(hw, QINT_TQCTL(vsi->txq_map[xdp_txq]), 0);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 766f9a466bc3..c82715eb5b93 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7253,7 +7253,7 @@ int ice_down(struct ice_vsi *vsi)
 	if (tx_err)
 		netdev_err(vsi->netdev, "Failed stop Tx rings, VSI %d error %d\n",
 			   vsi->vsi_num, tx_err);
-	if (!tx_err && ice_is_xdp_ena_vsi(vsi)) {
+	if (!tx_err && vsi->xdp_rings) {
 		tx_err = ice_vsi_stop_xdp_tx_rings(vsi);
 		if (tx_err)
 			netdev_err(vsi->netdev, "Failed stop XDP rings, VSI %d error %d\n",
@@ -7270,7 +7270,7 @@ int ice_down(struct ice_vsi *vsi)
 	ice_for_each_txq(vsi, i)
 		ice_clean_tx_ring(vsi->tx_rings[i]);
 
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		ice_for_each_xdp_txq(vsi, i)
 			ice_clean_tx_ring(vsi->xdp_rings[i]);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 87a5427570d7..5dee829bfc47 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -39,7 +39,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
 	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
 	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
 		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
 }
@@ -52,7 +52,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
 static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
 {
 	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
-	if (ice_is_xdp_ena_vsi(vsi))
+	if (vsi->xdp_rings)
 		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
 	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
 }
@@ -186,7 +186,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
 	if (!fail)
 		fail = err;
-	if (ice_is_xdp_ena_vsi(vsi)) {
+	if (vsi->xdp_rings) {
 		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
 
 		memset(&txq_meta, 0, sizeof(txq_meta));
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 945ffc083d25..79fffa82cfd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -3352,7 +3352,7 @@ void iwl_fw_dbg_stop_restart_recording(struct iwl_fw_runtime *fwrt,
 {
 	int ret __maybe_unused = 0;
 
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status))
+	if (!iwl_trans_fw_running(fwrt->trans))
 		return;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b93cef7b2330..4c56dccb18a9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1579,8 +1579,8 @@ static inline void iwl_trans_fw_error(struct iwl_trans *trans, bool sync)
 
 	/* prevent double restarts due to the same erroneous FW */
 	if (!test_and_set_bit(STATUS_FW_ERROR, &trans->status)) {
-		iwl_op_mode_nic_error(trans->op_mode, sync);
 		trans->state = IWL_TRANS_NO_FW;
+		iwl_op_mode_nic_error(trans->op_mode, sync);
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 259afecd1a98..83551d962a46 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5819,6 +5819,10 @@ static void iwl_mvm_flush_no_vif(struct iwl_mvm *mvm, u32 queues, bool drop)
 	int i;
 
 	if (!iwl_mvm_has_new_tx_api(mvm)) {
+		/* we can't ask the firmware anything if it is dead */
+		if (test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+			     &mvm->status))
+			return;
 		if (drop) {
 			mutex_lock(&mvm->mutex);
 			iwl_mvm_flush_tx_path(mvm,
@@ -5914,8 +5918,11 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	/* this can take a while, and we may need/want other operations
 	 * to succeed while doing this, so do it without the mutex held
+	 * If the firmware is dead, this can't work...
 	 */
-	if (!drop && !iwl_mvm_has_new_tx_api(mvm))
+	if (!drop && !iwl_mvm_has_new_tx_api(mvm) &&
+	    !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+		      &mvm->status))
 		iwl_trans_wait_tx_queues_empty(mvm->trans, msk);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 498afbe4ee6b..6375cc3c48f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1521,6 +1521,8 @@ void iwl_mvm_stop_device(struct iwl_mvm *mvm)
 
 	clear_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status);
 
+	iwl_mvm_pause_tcm(mvm, false);
+
 	iwl_fw_dbg_stop_sync(&mvm->fwrt);
 	iwl_trans_stop_device(mvm->trans);
 	iwl_free_fw_paging(&mvm->fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 7615c91a55c6..d7c276237c74 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -48,6 +48,8 @@
 /* Number of iterations on the channel for mei filtered scan */
 #define IWL_MEI_SCAN_NUM_ITER	5U
 
+#define WFA_TPC_IE_LEN	9
+
 struct iwl_mvm_scan_timing_params {
 	u32 suspend_time;
 	u32 max_out_time;
@@ -303,8 +305,8 @@ static int iwl_mvm_max_scan_ie_fw_cmd_room(struct iwl_mvm *mvm)
 
 	max_probe_len = SCAN_OFFLOAD_PROBE_REQ_SIZE;
 
-	/* we create the 802.11 header and SSID element */
-	max_probe_len -= 24 + 2;
+	/* we create the 802.11 header SSID element and WFA TPC element */
+	max_probe_len -= 24 + 2 + WFA_TPC_IE_LEN;
 
 	/* DS parameter set element is added on 2.4GHZ band if required */
 	if (iwl_mvm_rrm_scan_needed(mvm))
@@ -731,8 +733,6 @@ static u8 *iwl_mvm_copy_and_insert_ds_elem(struct iwl_mvm *mvm, const u8 *ies,
 	return newpos;
 }
 
-#define WFA_TPC_IE_LEN	9
-
 static void iwl_mvm_add_tpc_report_ie(u8 *pos)
 {
 	pos[0] = WLAN_EID_VENDOR_SPECIFIC;
@@ -837,8 +837,8 @@ static inline bool iwl_mvm_scan_fits(struct iwl_mvm *mvm, int n_ssids,
 	return ((n_ssids <= PROBE_OPTION_MAX) &&
 		(n_channels <= mvm->fw->ucode_capa.n_scan_channels) &
 		(ies->common_ie_len +
-		 ies->len[NL80211_BAND_2GHZ] +
-		 ies->len[NL80211_BAND_5GHZ] <=
+		 ies->len[NL80211_BAND_2GHZ] + ies->len[NL80211_BAND_5GHZ] +
+		 ies->len[NL80211_BAND_6GHZ] <=
 		 iwl_mvm_max_scan_ie_fw_cmd_room(mvm)));
 }
 
@@ -3179,18 +3179,16 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		params.n_channels = j;
 	}
 
-	if (non_psc_included &&
-	    !iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
-		kfree(params.channels);
-		return -ENOBUFS;
+	if (!iwl_mvm_scan_fits(mvm, req->n_ssids, ies, params.n_channels)) {
+		ret = -ENOBUFS;
+		goto out;
 	}
 
 	uid = iwl_mvm_build_scan_cmd(mvm, vif, &hcmd, &params, type);
-
-	if (non_psc_included)
-		kfree(params.channels);
-	if (uid < 0)
-		return uid;
+	if (uid < 0) {
+		ret = uid;
+		goto out;
+	}
 
 	ret = iwl_mvm_send_cmd(mvm, &hcmd);
 	if (!ret) {
@@ -3208,6 +3206,9 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 		mvm->sched_scan_pass_all = SCHED_SCAN_PASS_ALL_DISABLED;
 	}
 
+out:
+	if (non_psc_included)
+		kfree(params.channels);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index ebf11f276b20..37f0bc9e0d96 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -89,7 +89,8 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 		}
 		break;
 	default:
-		IWL_ERR(trans, "WRT: Invalid buffer destination\n");
+		IWL_DEBUG_FW(trans, "WRT: Invalid buffer destination (%d)\n",
+			     le32_to_cpu(fw_mon_cfg->buf_location));
 	}
 out:
 	if (dbg_flags)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5e66bcb34d53..ff1769172778 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -89,6 +89,11 @@ enum nvme_quirks {
 	 */
 	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
 
+	/*
+	 *  Problems seen with concurrent commands
+	 */
+	NVME_QUIRK_QDEPTH_ONE			= (1 << 6),
+
 	/*
 	 * Set MEDIUM priority on SQ creation
 	 */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 18d85575cdb4..fde4073fa418 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2528,15 +2528,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	else
 		dev->io_sqes = NVME_NVM_IOSQES;
 
-	/*
-	 * Temporary fix for the Apple controller found in the MacBook8,1 and
-	 * some MacBook7,1 to avoid controller resets and data loss.
-	 */
-	if (pdev->vendor == PCI_VENDOR_ID_APPLE && pdev->device == 0x2001) {
+	if (dev->ctrl.quirks & NVME_QUIRK_QDEPTH_ONE) {
 		dev->q_depth = 2;
-		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
-			"set queue depth=%u to work around controller resets\n",
-			dev->q_depth);
 	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
 		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
 		   NVME_CAP_MQES(dev->ctrl.cap) == 0) {
@@ -3401,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1217, 0x8760), /* O2 Micro 64GB Steam Deck */
+		.driver_data = NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(0x126f, 0x2262),	/* Silicon Motion generic */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_BOGUS_NID, },
@@ -3535,7 +3530,12 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0xcd02),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
-		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
+		/*
+		 * Fix for the Apple controller found in the MacBook8,1 and
+		 * some MacBook7,1 to avoid controller resets and data loss.
+		 */
+		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
+				NVME_QUIRK_QDEPTH_ONE },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR |
diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 5aa9d5c533c6..d7b66928a4e5 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1409,8 +1409,11 @@ static int at91_pinctrl_probe(struct platform_device *pdev)
 
 	/* We will handle a range of GPIO pins */
 	for (i = 0; i < gpio_banks; i++)
-		if (gpio_chips[i])
+		if (gpio_chips[i]) {
 			pinctrl_add_gpio_range(info->pctl, &gpio_chips[i]->range);
+			gpiochip_add_pin_range(&gpio_chips[i]->chip, dev_name(info->pctl->dev), 0,
+				gpio_chips[i]->range.pin_base, gpio_chips[i]->range.npins);
+		}
 
 	dev_info(dev, "initialized AT91 pinctrl driver\n");
 
diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 460444cda1b2..48870ca52b41 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -25,7 +25,7 @@ static const struct dmi_system_id fwbug_list[] = {
 		.ident = "ROG Zephyrus G14",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "GA403UV"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index fceffe2082ec..ed3633c5955d 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -145,6 +145,10 @@ static struct quirk_entry quirk_asus_ignore_fan = {
 	.wmi_ignore_fan = true,
 };
 
+static struct quirk_entry quirk_asus_zenbook_duo_kbd = {
+	.ignore_key_wlan = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -516,6 +520,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_ignore_fan,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS Zenbook Duo UX8406MA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX8406MA"),
+		},
+		.driver_data = &quirk_asus_zenbook_duo_kbd,
+	},
 	{},
 };
 
@@ -630,7 +643,12 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 	case 0x32: /* Volume Mute */
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
-
+		break;
+	case 0x5D: /* Wireless console Toggle */
+	case 0x5E: /* Wireless console Enable */
+	case 0x5F: /* Wireless console Disable */
+		if (quirks->ignore_key_wlan)
+			*code = ASUS_WMI_KEY_IGNORE;
 		break;
 	}
 }
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index cc30f1853847..d02f15fd3482 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -40,6 +40,7 @@ struct quirk_entry {
 	bool wmi_force_als_set;
 	bool wmi_ignore_fan;
 	bool filter_i8042_e1_extended_codes;
+	bool ignore_key_wlan;
 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
diff --git a/drivers/platform/x86/x86-android-tablets/dmi.c b/drivers/platform/x86/x86-android-tablets/dmi.c
index 141a2d25e83b..387dd092c4dd 100644
--- a/drivers/platform/x86/x86-android-tablets/dmi.c
+++ b/drivers/platform/x86/x86-android-tablets/dmi.c
@@ -140,7 +140,6 @@ const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 		/* Lenovo Yoga Tab 3 Pro YT3-X90F */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 		.driver_data = (void *)&lenovo_yt3_info,
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index aac0744011a3..8e7f4c0473ab 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1285,6 +1285,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, &rapl_defaults_amd),
+	X86_MATCH_VENDOR_FAM(AMD, 0x1A, &rapl_defaults_amd),
 	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &rapl_defaults_amd),
 	{}
 };
@@ -2128,6 +2129,21 @@ void rapl_remove_package(struct rapl_package *rp)
 }
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
+/*
+ * RAPL Package energy counter scope:
+ * 1. AMD/HYGON platforms use per-PKG package energy counter
+ * 2. For Intel platforms
+ *	2.1 CLX-AP platform has per-DIE package energy counter
+ *	2.2 Other platforms that uses MSR RAPL are single die systems so the
+ *          package energy counter can be considered as per-PKG/per-DIE,
+ *          here it is considered as per-DIE.
+ *	2.3 New platforms that use TPMI RAPL doesn't care about the
+ *	    scope because they are not MSR/CPU based.
+ */
+#define rapl_msrs_are_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 /* caller to ensure CPU hotplug lock is held */
 struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
 							 bool id_is_cpu)
@@ -2135,8 +2151,14 @@ struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_
 	struct rapl_package *rp;
 	int uid;
 
-	if (id_is_cpu)
-		uid = topology_logical_die_id(id);
+	if (id_is_cpu) {
+		uid = rapl_msrs_are_pkg_scope() ?
+		      topology_physical_package_id(id) : topology_logical_die_id(id);
+		if (uid < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return NULL;
+		}
+	}
 	else
 		uid = id;
 
@@ -2168,9 +2190,14 @@ struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *pr
 		return ERR_PTR(-ENOMEM);
 
 	if (id_is_cpu) {
-		rp->id = topology_logical_die_id(id);
+		rp->id = rapl_msrs_are_pkg_scope() ?
+			 topology_physical_package_id(id) : topology_logical_die_id(id);
+		if ((int)(rp->id) < 0) {
+			pr_err("topology_logical_(package/die)_id() returned a negative value");
+			return ERR_PTR(-EINVAL);
+		}
 		rp->lead_cpu = id;
-		if (topology_max_dies_per_package() > 1)
+		if (!rapl_msrs_are_pkg_scope() && topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 4156419c52c7..4756a3f82531 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -5410,7 +5410,7 @@ lpfc_get_cgnbuf_info(struct bsg_job *job)
 	struct get_cgnbuf_info_req *cgnbuf_req;
 	struct lpfc_cgn_info *cp;
 	uint8_t *cgn_buff;
-	int size, cinfosz;
+	size_t size, cinfosz;
 	int  rc = 0;
 
 	if (job->request_len < sizeof(struct fc_bsg_request) +
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index aac41bd05f98..2fb8d4e55c77 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -472,6 +472,7 @@ static const struct of_device_id bcm63xx_spi_of_match[] = {
 	{ .compatible = "brcm,bcm6358-spi", .data = &bcm6358_spi_reg_offsets },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, bcm63xx_spi_of_match);
 
 static int bcm63xx_spi_probe(struct platform_device *pdev)
 {
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5304728c68c2..face93a9cf20 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -702,6 +702,7 @@ static const struct class spidev_class = {
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "bh2228fv" },
 	{ .name = "dh2228fv" },
+	{ .name = "jg10309-01" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
 	{ .name = "bk4" },
@@ -731,6 +732,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 311007b1d904..c2e666e82857 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -754,7 +754,7 @@ static struct urb *usbtmc_create_urb(void)
 	if (!urb)
 		return NULL;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
+	dmabuf = kzalloc(bufsize, GFP_KERNEL);
 	if (!dmabuf) {
 		usb_free_urb(urb);
 		return NULL;
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index d93f5d584557..8e327fcb222f 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -118,6 +118,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(SMART_VENDOR_ID, SMART_PRODUCT_ID) },
 	{ USB_DEVICE(AT_VENDOR_ID, AT_VTKIT3_PRODUCT_ID) },
 	{ USB_DEVICE(IBM_VENDOR_ID, IBM_PRODUCT_ID) },
+	{ USB_DEVICE(MACROSILICON_VENDOR_ID, MACROSILICON_MS3020_PRODUCT_ID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 732f9b13ad5d..d60eda7f6eda 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -171,3 +171,7 @@
 /* Allied Telesis VT-Kit3 */
 #define AT_VENDOR_ID		0x0caa
 #define AT_VTKIT3_PRODUCT_ID	0x3001
+
+/* Macrosilicon MS3020 */
+#define MACROSILICON_VENDOR_ID		0x345f
+#define MACROSILICON_MS3020_PRODUCT_ID	0x3020
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 3b81213ed7b8..35c0cc2a51af 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1062,13 +1062,13 @@ ssize_t ocfs2_listxattr(struct dentry *dentry,
 	return i_ret + b_ret;
 }
 
-static int ocfs2_xattr_find_entry(int name_index,
+static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
 				  const char *name,
 				  struct ocfs2_xattr_search *xs)
 {
 	struct ocfs2_xattr_entry *entry;
 	size_t name_len;
-	int i, cmp = 1;
+	int i, name_offset, cmp = 1;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -1076,13 +1076,22 @@ static int ocfs2_xattr_find_entry(int name_index,
 	name_len = strlen(name);
 	entry = xs->here;
 	for (i = 0; i < le16_to_cpu(xs->header->xh_count); i++) {
+		if ((void *)entry >= xs->end) {
+			ocfs2_error(inode->i_sb, "corrupted xattr entries");
+			return -EFSCORRUPTED;
+		}
 		cmp = name_index - ocfs2_xattr_get_type(entry);
 		if (!cmp)
 			cmp = name_len - entry->xe_name_len;
-		if (!cmp)
-			cmp = memcmp(name, (xs->base +
-				     le16_to_cpu(entry->xe_name_offset)),
-				     name_len);
+		if (!cmp) {
+			name_offset = le16_to_cpu(entry->xe_name_offset);
+			if ((xs->base + name_offset + name_len) > xs->end) {
+				ocfs2_error(inode->i_sb,
+					    "corrupted xattr entries");
+				return -EFSCORRUPTED;
+			}
+			cmp = memcmp(name, (xs->base + name_offset), name_len);
+		}
 		if (cmp == 0)
 			break;
 		entry += 1;
@@ -1166,7 +1175,7 @@ static int ocfs2_xattr_ibody_get(struct inode *inode,
 	xs->base = (void *)xs->header;
 	xs->here = xs->header->xh_entries;
 
-	ret = ocfs2_xattr_find_entry(name_index, name, xs);
+	ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 	if (ret)
 		return ret;
 	size = le64_to_cpu(xs->here->xe_value_size);
@@ -2698,7 +2707,7 @@ static int ocfs2_xattr_ibody_find(struct inode *inode,
 
 	/* Find the named attribute. */
 	if (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL) {
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 		if (ret && ret != -ENODATA)
 			return ret;
 		xs->not_found = ret;
@@ -2833,7 +2842,7 @@ static int ocfs2_xattr_block_find(struct inode *inode,
 		xs->end = (void *)(blk_bh->b_data) + blk_bh->b_size;
 		xs->here = xs->header->xh_entries;
 
-		ret = ocfs2_xattr_find_entry(name_index, name, xs);
+		ret = ocfs2_xattr_find_entry(inode, name_index, name, xs);
 	} else
 		ret = ocfs2_xattr_index_block_find(inode, blk_bh,
 						   name_index,
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index d2307162a2de..e325e06357ff 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -656,6 +656,19 @@ allocate_buffers(struct TCP_Server_Info *server)
 static bool
 server_unresponsive(struct TCP_Server_Info *server)
 {
+	/*
+	 * If we're in the process of mounting a share or reconnecting a session
+	 * and the server abruptly shut down (e.g. socket wasn't closed, packet
+	 * had been ACK'ed but no SMB response), don't wait longer than 20s to
+	 * negotiate protocol.
+	 */
+	spin_lock(&server->srv_lock);
+	if (server->tcpStatus == CifsInNegotiate &&
+	    time_after(jiffies, server->lstrp + 20 * HZ)) {
+		spin_unlock(&server->srv_lock);
+		cifs_reconnect(server, false);
+		return true;
+	}
 	/*
 	 * We need to wait 3 echo intervals to make sure we handle such
 	 * situations right:
@@ -667,7 +680,6 @@ server_unresponsive(struct TCP_Server_Info *server)
 	 * 65s kernel_recvmsg times out, and we see that we haven't gotten
 	 *     a response in >60s.
 	 */
-	spin_lock(&server->srv_lock);
 	if ((server->tcpStatus == CifsGood ||
 	    server->tcpStatus == CifsNeedNegotiate) &&
 	    (!server->ops->can_echo || server->ops->can_echo(server)) &&
diff --git a/include/drm/drm_accel.h b/include/drm/drm_accel.h
index f4d3784b1dce..8867ce0be94c 100644
--- a/include/drm/drm_accel.h
+++ b/include/drm/drm_accel.h
@@ -51,11 +51,10 @@
 
 #if IS_ENABLED(CONFIG_DRM_ACCEL)
 
+extern struct xarray accel_minors_xa;
+
 void accel_core_exit(void);
 int accel_core_init(void);
-void accel_minor_remove(int index);
-int accel_minor_alloc(void);
-void accel_minor_replace(struct drm_minor *minor, int index);
 void accel_set_device_instance_params(struct device *kdev, int index);
 int accel_open(struct inode *inode, struct file *filp);
 void accel_debugfs_init(struct drm_device *dev);
@@ -73,19 +72,6 @@ static inline int __init accel_core_init(void)
 	return 0;
 }
 
-static inline void accel_minor_remove(int index)
-{
-}
-
-static inline int accel_minor_alloc(void)
-{
-	return -EOPNOTSUPP;
-}
-
-static inline void accel_minor_replace(struct drm_minor *minor, int index)
-{
-}
-
 static inline void accel_set_device_instance_params(struct device *kdev, int index)
 {
 }
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index ab230d3af138..8c0030c77308 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -45,6 +45,8 @@ struct drm_printer;
 struct device;
 struct file;
 
+extern struct xarray drm_minors_xa;
+
 /*
  * FIXME: Not sure we want to have drm_minor here in the end, but to avoid
  * header include loops we need it here for now.
@@ -434,6 +436,9 @@ static inline bool drm_is_accel_client(const struct drm_file *file_priv)
 
 void drm_file_update_pid(struct drm_file *);
 
+struct drm_minor *drm_minor_acquire(struct xarray *minors_xa, unsigned int minor_id);
+void drm_minor_release(struct drm_minor *minor);
+
 int drm_open(struct inode *inode, struct file *filp);
 int drm_open_helper(struct file *filp, struct drm_minor *minor);
 ssize_t drm_read(struct file *filp, char __user *buffer,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index edba4a31844f..bca7b341dd77 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5348,8 +5348,10 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	if (beacon->tail)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
-	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
+	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0) {
+		dev_kfree_skb(skb);
 		return NULL;
+	}
 
 	ieee80211_beacon_get_finish(hw, vif, link, offs, beacon, skb,
 				    chanctx_conf, csa_off_base);
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 765ffd6e06bc..0a8883a93e83 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -9,7 +9,8 @@
 
 struct nft_socket {
 	enum nft_socket_keys		key:8;
-	u8				level;
+	u8				level;		/* cgroupv2 level to extract */
+	u8				level_user;	/* cgroupv2 level provided by userspace */
 	u8				len;
 	union {
 		u8			dreg;
@@ -53,6 +54,28 @@ nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo
 	memcpy(dest, &cgid, sizeof(u64));
 	return true;
 }
+
+/* process context only, uses current->nsproxy. */
+static noinline int nft_socket_cgroup_subtree_level(void)
+{
+	struct cgroup *cgrp = cgroup_get_from_path("/");
+	int level;
+
+	if (IS_ERR(cgrp))
+		return PTR_ERR(cgrp);
+
+	level = cgrp->level;
+
+	cgroup_put(cgrp);
+
+	if (WARN_ON_ONCE(level > 255))
+		return -ERANGE;
+
+	if (WARN_ON_ONCE(level < 0))
+		return -EINVAL;
+
+	return level;
+}
 #endif
 
 static struct sock *nft_socket_do_lookup(const struct nft_pktinfo *pkt)
@@ -174,9 +197,10 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 	case NFT_SOCKET_MARK:
 		len = sizeof(u32);
 		break;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_SOCK_CGROUP_DATA
 	case NFT_SOCKET_CGROUPV2: {
 		unsigned int level;
+		int err;
 
 		if (!tb[NFTA_SOCKET_LEVEL])
 			return -EINVAL;
@@ -185,6 +209,17 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 		if (level > 255)
 			return -EOPNOTSUPP;
 
+		err = nft_socket_cgroup_subtree_level();
+		if (err < 0)
+			return err;
+
+		priv->level_user = level;
+
+		level += err;
+		/* Implies a giant cgroup tree */
+		if (WARN_ON_ONCE(level > 255))
+			return -EOPNOTSUPP;
+
 		priv->level = level;
 		len = sizeof(u64);
 		break;
@@ -209,7 +244,7 @@ static int nft_socket_dump(struct sk_buff *skb,
 	if (nft_dump_register(skb, NFTA_SOCKET_DREG, priv->dreg))
 		return -1;
 	if (priv->key == NFT_SOCKET_CGROUPV2 &&
-	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level)))
+	    nla_put_be32(skb, NFTA_SOCKET_LEVEL, htonl(priv->level_user)))
 		return -1;
 	return 0;
 }
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 78042ac2b71f..643e0496b093 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4639,6 +4639,7 @@ HDA_CODEC_ENTRY(0x8086281d, "Meteor Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281e, "Battlemage HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281f, "Raptor Lake P HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862820, "Lunar Lake HDMI",	patch_i915_adlp_hdmi),
+HDA_CODEC_ENTRY(0x80862822, "Panther Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0cde024d1d33..2b674691ce4b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4925,6 +4925,30 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
+static void alc_hp_mute_disable(struct hda_codec *codec, unsigned int delay)
+{
+	if (delay <= 0)
+		delay = 75;
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+	msleep(delay);
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	msleep(delay);
+}
+
+static void alc_hp_enable_unmute(struct hda_codec *codec, unsigned int delay)
+{
+	if (delay <= 0)
+		delay = 75;
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+	msleep(delay);
+	snd_hda_codec_write(codec, 0x21, 0,
+		    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+	msleep(delay);
+}
+
 static const struct coef_fw alc225_pre_hsmode[] = {
 	UPDATE_COEF(0x4a, 1<<8, 0),
 	UPDATE_COEFEX(0x57, 0x05, 1<<14, 0),
@@ -5026,6 +5050,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0236:
 	case 0x10ec0256:
 	case 0x19e58326:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, coef0256);
 		break;
 	case 0x10ec0234:
@@ -5060,6 +5085,7 @@ static void alc_headset_mode_unplugged(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
+		alc_hp_mute_disable(codec, 75);
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
 		break;
@@ -5285,6 +5311,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0255:
 		alc_process_coef_fw(codec, coef0255);
@@ -5297,6 +5324,7 @@ static void alc_headset_mode_default(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x45, 0xc089);
 		msleep(50);
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5394,6 +5422,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 	case 0x10ec0256:
 	case 0x19e58326:
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5442,6 +5471,7 @@ static void alc_headset_mode_ctia(struct hda_codec *codec)
 			alc_process_coef_fw(codec, coef0225_2);
 		else
 			alc_process_coef_fw(codec, coef0225_1);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0867:
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
@@ -5509,6 +5539,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0256:
 	case 0x19e58326:
 		alc_process_coef_fw(codec, coef0256);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5546,6 +5577,7 @@ static void alc_headset_mode_omtp(struct hda_codec *codec)
 	case 0x10ec0289:
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, coef0225);
+		alc_hp_enable_unmute(codec, 75);
 		break;
 	}
 	codec_dbg(codec, "Headset jack set to Nokia-style headset mode.\n");
@@ -5614,25 +5646,21 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 		alc_write_coef_idx(codec, 0x06, 0x6104);
 		alc_write_coefex_idx(codec, 0x57, 0x3, 0x09a3);
 
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
 		alc_process_coef_fw(codec, coef0255);
 		msleep(300);
 		val = alc_read_coef_idx(codec, 0x46);
 		is_ctia = (val & 0x0070) == 0x0070;
-
+		if (!is_ctia) {
+			alc_write_coef_idx(codec, 0x45, 0xe089);
+			msleep(100);
+			val = alc_read_coef_idx(codec, 0x46);
+			if ((val & 0x0070) == 0x0070)
+				is_ctia = false;
+			else
+				is_ctia = true;
+		}
 		alc_write_coefex_idx(codec, 0x57, 0x3, 0x0da3);
 		alc_update_coefex_idx(codec, 0x57, 0x5, 1<<14, 0);
-
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
@@ -5709,12 +5737,6 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 	case 0x10ec0295:
 	case 0x10ec0289:
 	case 0x10ec0299:
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
-
 		alc_process_coef_fw(codec, alc225_pre_hsmode);
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x1000);
 		val = alc_read_coef_idx(codec, 0x45);
@@ -5731,15 +5753,19 @@ static void alc_determine_headset_type(struct hda_codec *codec)
 			val = alc_read_coef_idx(codec, 0x46);
 			is_ctia = (val & 0x00f0) == 0x00f0;
 		}
+		if (!is_ctia) {
+			alc_update_coef_idx(codec, 0x45, 0x3f<<10, 0x38<<10);
+			alc_update_coef_idx(codec, 0x49, 3<<8, 1<<8);
+			msleep(100);
+			val = alc_read_coef_idx(codec, 0x46);
+			if ((val & 0x00f0) == 0x00f0)
+				is_ctia = false;
+			else
+				is_ctia = true;
+		}
 		alc_update_coef_idx(codec, 0x4a, 7<<6, 7<<6);
 		alc_update_coef_idx(codec, 0x4a, 3<<4, 3<<4);
 		alc_update_coef_idx(codec, 0x67, 0xf000, 0x3000);
-
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
-		msleep(80);
-		snd_hda_codec_write(codec, 0x21, 0,
-			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 		break;
 	case 0x10ec0867:
 		is_ctia = true;
diff --git a/sound/soc/amd/acp/acp-sof-mach.c b/sound/soc/amd/acp/acp-sof-mach.c
index fc59ea34e687..b3a702dcd991 100644
--- a/sound/soc/amd/acp/acp-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sof-mach.c
@@ -158,6 +158,8 @@ static const struct platform_device_id board_ids[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(platform, board_ids);
+
 static struct platform_driver acp_asoc_audio = {
 	.driver = {
 		.name = "sof_mach",
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index f6c1dbd0ebcf..248e3bcbf386 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -353,6 +353,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7VF"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 17 D7VEK"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 83a75a38705b..81abe2e18402 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
diff --git a/sound/soc/codecs/chv3-codec.c b/sound/soc/codecs/chv3-codec.c
index ab99effa6874..40020500b1fe 100644
--- a/sound/soc/codecs/chv3-codec.c
+++ b/sound/soc/codecs/chv3-codec.c
@@ -26,6 +26,7 @@ static const struct of_device_id chv3_codec_of_match[] = {
 	{ .compatible = "google,chv3-codec", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, chv3_codec_of_match);
 
 static struct platform_driver chv3_codec_platform_driver = {
 	.driver = {
diff --git a/sound/soc/codecs/tda7419.c b/sound/soc/codecs/tda7419.c
index 386b99c8023b..7d6fcba9986e 100644
--- a/sound/soc/codecs/tda7419.c
+++ b/sound/soc/codecs/tda7419.c
@@ -623,6 +623,7 @@ static const struct of_device_id tda7419_of_match[] = {
 	{ .compatible = "st,tda7419" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tda7419_of_match);
 
 static struct i2c_driver tda7419_driver = {
 	.driver = {
diff --git a/sound/soc/google/chv3-i2s.c b/sound/soc/google/chv3-i2s.c
index 08e558f24af8..0ff24653d49f 100644
--- a/sound/soc/google/chv3-i2s.c
+++ b/sound/soc/google/chv3-i2s.c
@@ -322,6 +322,7 @@ static const struct of_device_id chv3_i2s_of_match[] = {
 	{ .compatible = "google,chv3-i2s" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, chv3_i2s_of_match);
 
 static struct platform_driver chv3_i2s_driver = {
 	.probe = chv3_i2s_probe,
diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 5e2ec60e2954..e4c3492a0c28 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -84,7 +84,6 @@ static const struct dmi_system_id lenovo_yoga_tab3_x90[] = {
 		/* Lenovo Yoga Tab 3 Pro YT3-X90, codec missing from DSDT */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index 37ea2e1d2e92..aa5de167e790 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -814,6 +814,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
diff --git a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
index ccb6c1f3adc7..73e5c63aeec8 100644
--- a/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
+++ b/sound/soc/mediatek/mt8188/mt8188-afe-pcm.c
@@ -2748,6 +2748,7 @@ static bool mt8188_is_volatile_reg(struct device *dev, unsigned int reg)
 	case AFE_ASRC12_NEW_CON9:
 	case AFE_LRCK_CNT:
 	case AFE_DAC_MON0:
+	case AFE_DAC_CON0:
 	case AFE_DL2_CUR:
 	case AFE_DL3_CUR:
 	case AFE_DL6_CUR:
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
index eba6f4c445ff..08ae962afeb9 100644
--- a/sound/soc/mediatek/mt8188/mt8188-mt6359.c
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -734,6 +734,7 @@ static int mt8188_headset_codec_init(struct snd_soc_pcm_runtime *rtd)
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_jack *jack = &soc_card_data->card_data->jacks[MT8188_JACK_HEADSET];
 	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+	struct mtk_platform_card_data *card_data = soc_card_data->card_data;
 	int ret;
 
 	ret = snd_soc_dapm_new_controls(&card->dapm, mt8188_nau8825_widgets,
@@ -762,10 +763,18 @@ static int mt8188_headset_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
-	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+	if (card_data->flags & ES8326_HS_PRESENT) {
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);			
+	} else {
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+		snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);	
+	}
+	
 	ret = snd_soc_component_set_jack(component, jack, NULL);
 
 	if (ret) {
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 8d3fc167cd81..b9d4508bbb85 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -574,6 +574,9 @@ static struct snd_sof_of_mach sof_mt8195_machs[] = {
 	{
 		.compatible = "google,tomato",
 		.sof_tplg_filename = "sof-mt8195-mt6359-rt1019-rt5682.tplg"
+	}, {
+		.compatible = "google,dojo",
+		.sof_tplg_filename = "sof-mt8195-mt6359-max98390-rt5682.tplg"
 	}, {
 		.compatible = "mediatek,mt8195",
 		.sof_tplg_filename = "sof-mt8195.tplg"
diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 2e60e2c212cd..34ffcec264ab 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -52,7 +52,7 @@ $(OUTPUT)hv_fcopy_uio_daemon: $(HV_FCOPY_UIO_DAEMON_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
 
 install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(sbindir); \

