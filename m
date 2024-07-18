Return-Path: <stable+bounces-60540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D36934C68
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 13:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7611C21EB6
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD9912F5BF;
	Thu, 18 Jul 2024 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Lp3pMIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97874429;
	Thu, 18 Jul 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302017; cv=none; b=c+Cp/SHnrECVGNR/uFBN3KG6zGWodrrsnLFEyu9xFWXiPrxtSLfE8xO0oDV5BYLiLfJ0yffGXLDIAlpncrkRONycrP7g8+YgA7oNt1UrHrqHDT3ldmP9JDpjK0zcdgTrR1Cm3HaMLzP0dxtVP64w2k6qOPoiQUCuVE6fPAZ6KhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302017; c=relaxed/simple;
	bh=szx96Kj7LzwfoNELvJm6z+4Vz7HmaA+Z/lK5xlREdPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aONS0eWerVcMxsgvSRpVaGZ5BFvJSMOyuw0TjijEnDKHt0EcXwA7ihHPD7UPh1rrtqP4xtUOiYpk6ow8VNGAzMvOPBOSQeGB4WJ+fotCFhXGOqJrb5Cj8KI9dUGpP3G8xE/yscuEOKOjpDyNMSCax98hf0NPb2zuL9i5vlcinGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Lp3pMIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6559BC116B1;
	Thu, 18 Jul 2024 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721302016;
	bh=szx96Kj7LzwfoNELvJm6z+4Vz7HmaA+Z/lK5xlREdPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Lp3pMIlSkHpMwEWpPtHQOyrCRqr4K/z+DbX5bOQjQJ5AX/1Tay88O/I8zOG25gLs
	 B02o5ESWG6HMMlyOiqCV/YJYUBRi+j0UG8vanGr4T36IboTn+rA2veQw5RjTichAe5
	 WWVmjL6GvtUKYQK1dDbBJf5uuox342bJzBqxY4qk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.222
Date: Thu, 18 Jul 2024 13:26:43 +0200
Message-ID: <2024071843-fifth-sliver-d455@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024071843-stretch-residual-1c28@gregkh>
References: <2024071843-stretch-residual-1c28@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index b0e22161cd55..5b6dae61250c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 221
+SUBLEVEL = 222
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
index 323ee4e657c4..94d7d69b9db7 100644
--- a/arch/arm/mach-davinci/pm.c
+++ b/arch/arm/mach-davinci/pm.c
@@ -62,7 +62,7 @@ static void davinci_pm_suspend(void)
 
 	/* Configure sleep count in deep sleep register */
 	val = __raw_readl(pm_config.deepsleep_reg);
-	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK,
+	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK;
 	val |= pm_config.sleepcount;
 	__raw_writel(val, pm_config.deepsleep_reg);
 
diff --git a/arch/ia64/include/asm/efi.h b/arch/ia64/include/asm/efi.h
new file mode 100644
index 000000000000..6a4a50d8f19a
--- /dev/null
+++ b/arch/ia64/include/asm/efi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_EFI_H
+#define _ASM_EFI_H
+
+typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
+
+void *efi_get_pal_addr(void);
+void efi_map_pal_code(void);
+void efi_memmap_walk(efi_freemem_callback_t, void *);
+void efi_memmap_walk_uc(efi_freemem_callback_t, void *);
+void efi_gettimeofday(struct timespec64 *ts);
+
+#endif
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 33282f33466e..4707c5ee6692 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -34,6 +34,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/kregs.h>
 #include <asm/meminit.h>
diff --git a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
index efc9b568401c..af310dc8a356 100644
--- a/arch/ia64/kernel/machine_kexec.c
+++ b/arch/ia64/kernel/machine_kexec.c
@@ -16,6 +16,7 @@
 #include <linux/numa.h>
 #include <linux/mmzone.h>
 
+#include <asm/efi.h>
 #include <asm/numa.h>
 #include <asm/mmu_context.h>
 #include <asm/setup.h>
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index bd0a51dc345a..d9f51f0b33a7 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -91,6 +91,7 @@
 #include <linux/gfp.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index 0cad990385c0..d10f780c13b9 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -45,6 +45,7 @@
 #include <asm/cache.h>
 #include <asm/current.h>
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mca.h>
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index 7abc5f37bfaf..b53d4688d5a7 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -26,6 +26,7 @@
 #include <linux/sched/cputime.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/hw_irq.h>
 #include <asm/ptrace.h>
 #include <asm/sal.h>
diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 0750f367837d..51883a66aeb5 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -20,14 +20,12 @@
 #include <linux/genalloc.h>
 #include <linux/gfp.h>
 #include <linux/pgtable.h>
+#include <asm/efi.h>
 #include <asm/page.h>
 #include <asm/pal.h>
 #include <linux/atomic.h>
 #include <asm/tlbflush.h>
 
-
-extern void __init efi_memmap_walk_uc(efi_freemem_callback_t, void *);
-
 struct uncached_pool {
 	struct gen_pool *pool;
 	struct mutex add_chunk_mutex;	/* serialize adding a converted chunk */
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index c638e012ad05..11c82d4d4f7c 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -20,6 +20,7 @@
 #include <linux/nmi.h>
 #include <linux/swap.h>
 
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/sections.h>
 #include <asm/mca.h>
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index 4d0813419013..fc3c77fb2597 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -24,6 +24,7 @@
 #include <linux/efi.h>
 #include <linux/nodemask.h>
 #include <linux/slab.h>
+#include <asm/efi.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
 #include <asm/numa.h>
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index f316a833b703..85e4e9ef027a 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -27,6 +27,7 @@
 #include <linux/swiotlb.h>
 
 #include <asm/dma.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/numa.h>
 #include <asm/patch.h>
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 058d21f493fa..c6b56aa0334f 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -45,7 +45,7 @@ extern struct pci_dev *isa_bridge_pcidev;
  * define properly based on the platform
  */
 #ifndef CONFIG_PCI
-#define _IO_BASE	0
+#define _IO_BASE	POISON_POINTER_DELTA
 #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET 0
 #elif defined(CONFIG_PPC32)
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 3de2adc0a807..a2883360d07c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1249,7 +1249,7 @@ static int cpu_cmd(void)
 	unsigned long cpu, first_cpu, last_cpu;
 	int timeout;
 
-	if (!scanhex(&cpu)) {
+	if (!scanhex(&cpu) || cpu >= num_possible_cpus()) {
 		/* print cpus waiting or in xmon */
 		printf("cpus stopped:");
 		last_cpu = first_cpu = NR_CPUS;
@@ -2680,7 +2680,7 @@ static void dump_pacas(void)
 
 	termch = c;	/* Put c back, it wasn't 'a' */
 
-	if (scanhex(&num))
+	if (scanhex(&num) && num < num_possible_cpus())
 		dump_one_paca(num);
 	else
 		dump_one_paca(xmon_owner);
@@ -2777,7 +2777,7 @@ static void dump_xives(void)
 
 	termch = c;	/* Put c back, it wasn't 'a' */
 
-	if (scanhex(&num))
+	if (scanhex(&num) && num < num_possible_cpus())
 		dump_one_xive(num);
 	else
 		dump_one_xive(xmon_owner);
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 0987c3fc45f5..95ed01a3536c 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -252,8 +252,8 @@ static inline void __load_psw(psw_t psw)
  */
 static __always_inline void __load_psw_mask(unsigned long mask)
 {
+	psw_t psw __uninitialized;
 	unsigned long addr;
-	psw_t psw;
 
 	psw.mask = mask;
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ab9b047790dd..d1902213a0d6 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -105,6 +105,7 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
 /* dummy definition for alternatives */
 SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_FUNC_END(srso_alias_untrain_ret)
@@ -258,7 +259,6 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
-	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)
diff --git a/crypto/aead.c b/crypto/aead.c
index 16991095270d..c4ece86c45bc 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -35,8 +35,7 @@ static int setkey_unaligned(struct crypto_aead *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = crypto_aead_alg(tfm)->setkey(tfm, alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 }
 
diff --git a/crypto/cipher.c b/crypto/cipher.c
index fd78150deb1c..72c5606cc7f8 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -33,8 +33,7 @@ static int setkey_unaligned(struct crypto_cipher *tfm, const u8 *key,
 	alignbuffer = (u8 *)ALIGN((unsigned long)buffer, alignmask + 1);
 	memcpy(alignbuffer, key, keylen);
 	ret = cia->cia_setkey(crypto_cipher_tfm(tfm), alignbuffer, keylen);
-	memset(alignbuffer, 0, keylen);
-	kfree(buffer);
+	kfree_sensitive(buffer);
 	return ret;
 
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 6e0c0762fbab..24cfc552e6a8 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2076,15 +2076,27 @@ static void qca_serdev_shutdown(struct device *dev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 	struct hci_uart *hu = &qcadev->serdev_hu;
 	struct hci_dev *hdev = hu->hdev;
-	struct qca_data *qca = hu->priv;
 	const u8 ibs_wake_cmd[] = { 0xFD };
 	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
 
 	if (qcadev->btsoc_type == QCA_QCA6390) {
-		if (test_bit(QCA_BT_OFF, &qca->flags) ||
-		    !test_bit(HCI_RUNNING, &hdev->flags))
+		/* The purpose of sending the VSC is to reset SOC into a initial
+		 * state and the state will ensure next hdev->setup() success.
+		 * if HCI_QUIRK_NON_PERSISTENT_SETUP is set, it means that
+		 * hdev->setup() can do its job regardless of SoC state, so
+		 * don't need to send the VSC.
+		 * if HCI_SETUP is set, it means that hdev->setup() was never
+		 * invoked and the SOC is already in the initial state, so
+		 * don't also need to send the VSC.
+		 */
+		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
+		    hci_dev_test_flag(hdev, HCI_SETUP))
 			return;
 
+		/* The serdev must be in open state when conrol logic arrives
+		 * here, so also fix the use-after-free issue caused by that
+		 * the serdev is flushed or wrote after it is closed.
+		 */
 		serdev_device_write_flush(serdev);
 		ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
 					      sizeof(ibs_wake_cmd));
diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 8b55085650ad..900d1da0075e 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -304,8 +304,13 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 	if (!devp->hd_ireqfreq)
 		return -EIO;
 
-	if (count < sizeof(unsigned long))
-		return -EINVAL;
+	if (in_compat_syscall()) {
+		if (count < sizeof(compat_ulong_t))
+			return -EINVAL;
+	} else {
+		if (count < sizeof(unsigned long))
+			return -EINVAL;
+	}
 
 	add_wait_queue(&devp->hd_waitqueue, &wait);
 
@@ -329,9 +334,16 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 		schedule();
 	}
 
-	retval = put_user(data, (unsigned long __user *)buf);
-	if (!retval)
-		retval = sizeof(unsigned long);
+	if (in_compat_syscall()) {
+		retval = put_user(data, (compat_ulong_t __user *)buf);
+		if (!retval)
+			retval = sizeof(compat_ulong_t);
+	} else {
+		retval = put_user(data, (unsigned long __user *)buf);
+		if (!retval)
+			retval = sizeof(unsigned long);
+	}
+
 out:
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&devp->hd_waitqueue, &wait);
@@ -686,12 +698,24 @@ struct compat_hpet_info {
 	unsigned short hi_timer;
 };
 
+/* 32-bit types would lead to different command codes which should be
+ * translated into 64-bit ones before passed to hpet_ioctl_common
+ */
+#define COMPAT_HPET_INFO       _IOR('h', 0x03, struct compat_hpet_info)
+#define COMPAT_HPET_IRQFREQ    _IOW('h', 0x6, compat_ulong_t)
+
 static long
 hpet_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct hpet_info info;
 	int err;
 
+	if (cmd == COMPAT_HPET_INFO)
+		cmd = HPET_INFO;
+
+	if (cmd == COMPAT_HPET_IRQFREQ)
+		cmd = HPET_IRQFREQ;
+
 	mutex_lock(&hpet_mutex);
 	err = hpet_ioctl_common(file->private_data, cmd, arg, &info);
 	mutex_unlock(&hpet_mutex);
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index d51ca0428bb8..ded0878dc3b6 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -101,6 +101,17 @@ static void dmi_decode_table(u8 *buf,
 	       (data - buf + sizeof(struct dmi_header)) <= dmi_len) {
 		const struct dmi_header *dm = (const struct dmi_header *)data;
 
+		/*
+		 * If a short entry is found (less than 4 bytes), not only it
+		 * is invalid, but we cannot reliably locate the next entry.
+		 */
+		if (dm->length < sizeof(struct dmi_header)) {
+			pr_warn(FW_BUG
+				"Corrupted DMI table, offset %zd (only %d entries processed)\n",
+				data - buf, i);
+			break;
+		}
+
 		/*
 		 *  We want to know the total length (formatted area and
 		 *  strings) before decoding to make sure we won't run off the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 582055136cdb..87dcbaf540e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -413,6 +413,14 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 	int r;
 
 	entry.iv_entry = (const uint32_t *)&ih->ring[ring_index];
+
+	/*
+	 * timestamp is not supported on some legacy SOCs (cik, cz, iceland,
+	 * si and tonga), so initialize timestamp and timestamp_src to 0
+	 */
+	entry.timestamp = 0;
+	entry.timestamp_src = 0;
+
 	amdgpu_ih_decode_iv(adev, &entry);
 
 	trace_amdgpu_iv(ih - &adev->irq.ih, &entry);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f1eda1a6496d..0a13c06eea44 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1802,6 +1802,9 @@ static struct audio *find_first_free_audio(
 {
 	int i, available_audio_count;
 
+	if (id == ENGINE_ID_UNKNOWN)
+		return NULL;
+
 	available_audio_count = pool->audio_count;
 
 	for (i = 0; i < available_audio_count; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 378cc11aa047..3d8b2b127f3f 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -211,8 +211,12 @@ bool dce110_vblank_set(struct irq_service *irq_service,
 						   info->ext_id);
 	uint8_t pipe_offset = dal_irq_src - IRQ_TYPE_VBLANK;
 
-	struct timing_generator *tg =
-			dc->current_state->res_ctx.pipe_ctx[pipe_offset].stream_res.tg;
+	struct timing_generator *tg;
+
+	if (pipe_offset >= MAX_PIPES)
+		return false;
+
+	tg = dc->current_state->res_ctx.pipe_ctx[pipe_offset].stream_res.tg;
 
 	if (enable) {
 		if (!tg || !tg->funcs->arm_vert_intr(tg, 2)) {
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
index f7b5583ee609..8e9caae7c955 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_ddc.c
@@ -156,6 +156,10 @@ static enum mod_hdcp_status read(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+		return MOD_HDCP_STATUS_DDC_FAILURE;
+	}
+
 	if (is_dp_hdcp(hdcp)) {
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
@@ -215,6 +219,10 @@ static enum mod_hdcp_status write(struct mod_hdcp *hdcp,
 	uint32_t cur_size = 0;
 	uint32_t data_offset = 0;
 
+	if (msg_id == MOD_HDCP_MESSAGE_ID_INVALID) {
+		return MOD_HDCP_STATUS_DDC_FAILURE;
+	}
+
 	if (is_dp_hdcp(hdcp)) {
 		while (buf_len > 0) {
 			cur_size = MIN(buf_len, HDCP_MAX_AUX_TRANSACTION_SIZE);
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 3e526c394f6c..ce7b0763ff19 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -690,7 +690,7 @@ struct atom_gpio_pin_lut_v2_1
 {
   struct  atom_common_table_header  table_header;
   /*the real number of this included in the structure is calcualted by using the (whole structure size - the header size)/size of atom_gpio_pin_lut  */
-  struct  atom_gpio_pin_assignment  gpio_pin[8];
+  struct  atom_gpio_pin_assignment  gpio_pin[];
 };
 
 
diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 6cf46b653e81..ca3842f71984 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -324,7 +324,9 @@ int lima_gp_init(struct lima_ip *ip)
 
 void lima_gp_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 int lima_gp_pipe_init(struct lima_device *dev)
diff --git a/drivers/gpu/drm/lima/lima_mmu.c b/drivers/gpu/drm/lima/lima_mmu.c
index a1ae6c252dc2..8ca7047adbac 100644
--- a/drivers/gpu/drm/lima/lima_mmu.c
+++ b/drivers/gpu/drm/lima/lima_mmu.c
@@ -118,7 +118,12 @@ int lima_mmu_init(struct lima_ip *ip)
 
 void lima_mmu_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
+
+	if (ip->id == lima_ip_ppmmu_bcast)
+		return;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 void lima_mmu_flush_tlb(struct lima_ip *ip)
diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index 54b208a4a768..d34c9e8840f4 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -266,7 +266,9 @@ int lima_pp_init(struct lima_ip *ip)
 
 void lima_pp_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 int lima_pp_bcast_resume(struct lima_ip *ip)
@@ -299,7 +301,9 @@ int lima_pp_bcast_init(struct lima_ip *ip)
 
 void lima_pp_bcast_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 static int lima_pp_task_validate(struct lima_sched_pipe *pipe,
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index d2cefca120c4..6b8ad830c034 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -960,6 +960,9 @@ nouveau_connector_get_modes(struct drm_connector *connector)
 		struct drm_display_mode *mode;
 
 		mode = drm_mode_duplicate(dev, nv_connector->native_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		ret = 1;
 	}
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index d6b945f5b887..4baa9bce02b6 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1078,7 +1078,7 @@ static const struct pci_device_id i801_ids[] = {
 MODULE_DEVICE_TABLE(pci, i801_ids);
 
 #if defined CONFIG_X86 && defined CONFIG_DMI
-static unsigned char apanel_addr;
+static unsigned char apanel_addr __ro_after_init;
 
 /* Scan the system ROM for the signature "FJKEYINF" */
 static __init const void __iomem *bios_signature(const void __iomem *bios)
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 8c4ec7f13f5a..b6b5a65efcbb 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -15,7 +15,6 @@
 #include <linux/ioport.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
-#include <linux/timer.h>
 #include <linux/completion.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -32,7 +31,6 @@ struct i2c_pnx_mif {
 	int			ret;		/* Return value */
 	int			mode;		/* Interface mode */
 	struct completion	complete;	/* I/O completion */
-	struct timer_list	timer;		/* Timeout */
 	u8 *			buf;		/* Data buffer */
 	int			len;		/* Length of data buffer */
 	int			order;		/* RX Bytes to order via TX */
@@ -117,24 +115,6 @@ static inline int wait_reset(struct i2c_pnx_algo_data *data)
 	return (timeout <= 0);
 }
 
-static inline void i2c_pnx_arm_timer(struct i2c_pnx_algo_data *alg_data)
-{
-	struct timer_list *timer = &alg_data->mif.timer;
-	unsigned long expires = msecs_to_jiffies(alg_data->timeout);
-
-	if (expires <= 1)
-		expires = 2;
-
-	del_timer_sync(timer);
-
-	dev_dbg(&alg_data->adapter.dev, "Timer armed at %lu plus %lu jiffies.\n",
-		jiffies, expires);
-
-	timer->expires = jiffies + expires;
-
-	add_timer(timer);
-}
-
 /**
  * i2c_pnx_start - start a device
  * @slave_addr:		slave address
@@ -259,8 +239,6 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 				~(mcntrl_afie | mcntrl_naie | mcntrl_drmie),
 				  I2C_REG_CTL(alg_data));
 
-			del_timer_sync(&alg_data->mif.timer);
-
 			dev_dbg(&alg_data->adapter.dev,
 				"%s(): Waking up xfer routine.\n",
 				__func__);
@@ -276,8 +254,6 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 			~(mcntrl_afie | mcntrl_naie | mcntrl_drmie),
 			  I2C_REG_CTL(alg_data));
 
-		/* Stop timer. */
-		del_timer_sync(&alg_data->mif.timer);
 		dev_dbg(&alg_data->adapter.dev,
 			"%s(): Waking up xfer routine after zero-xfer.\n",
 			__func__);
@@ -364,8 +340,6 @@ static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
 				 mcntrl_drmie | mcntrl_daie);
 			iowrite32(ctl, I2C_REG_CTL(alg_data));
 
-			/* Kill timer. */
-			del_timer_sync(&alg_data->mif.timer);
 			complete(&alg_data->mif.complete);
 		}
 	}
@@ -400,8 +374,6 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 			 mcntrl_drmie);
 		iowrite32(ctl, I2C_REG_CTL(alg_data));
 
-		/* Stop timer, to prevent timeout. */
-		del_timer_sync(&alg_data->mif.timer);
 		complete(&alg_data->mif.complete);
 	} else if (stat & mstatus_nai) {
 		/* Slave did not acknowledge, generate a STOP */
@@ -419,8 +391,6 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 		/* Our return value. */
 		alg_data->mif.ret = -EIO;
 
-		/* Stop timer, to prevent timeout. */
-		del_timer_sync(&alg_data->mif.timer);
 		complete(&alg_data->mif.complete);
 	} else {
 		/*
@@ -453,9 +423,8 @@ static irqreturn_t i2c_pnx_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void i2c_pnx_timeout(struct timer_list *t)
+static void i2c_pnx_timeout(struct i2c_pnx_algo_data *alg_data)
 {
-	struct i2c_pnx_algo_data *alg_data = from_timer(alg_data, t, mif.timer);
 	u32 ctl;
 
 	dev_err(&alg_data->adapter.dev,
@@ -472,7 +441,6 @@ static void i2c_pnx_timeout(struct timer_list *t)
 	iowrite32(ctl, I2C_REG_CTL(alg_data));
 	wait_reset(alg_data);
 	alg_data->mif.ret = -EIO;
-	complete(&alg_data->mif.complete);
 }
 
 static inline void bus_reset_if_active(struct i2c_pnx_algo_data *alg_data)
@@ -514,6 +482,7 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct i2c_msg *pmsg;
 	int rc = 0, completed = 0, i;
 	struct i2c_pnx_algo_data *alg_data = adap->algo_data;
+	unsigned long time_left;
 	u32 stat;
 
 	dev_dbg(&alg_data->adapter.dev,
@@ -548,7 +517,6 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		dev_dbg(&alg_data->adapter.dev, "%s(): mode %d, %d bytes\n",
 			__func__, alg_data->mif.mode, alg_data->mif.len);
 
-		i2c_pnx_arm_timer(alg_data);
 
 		/* initialize the completion var */
 		init_completion(&alg_data->mif.complete);
@@ -564,7 +532,10 @@ i2c_pnx_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			break;
 
 		/* Wait for completion */
-		wait_for_completion(&alg_data->mif.complete);
+		time_left = wait_for_completion_timeout(&alg_data->mif.complete,
+							alg_data->timeout);
+		if (time_left == 0)
+			i2c_pnx_timeout(alg_data);
 
 		if (!(rc = alg_data->mif.ret))
 			completed++;
@@ -657,7 +628,10 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	alg_data->adapter.algo_data = alg_data;
 	alg_data->adapter.nr = pdev->id;
 
-	alg_data->timeout = I2C_PNX_TIMEOUT_DEFAULT;
+	alg_data->timeout = msecs_to_jiffies(I2C_PNX_TIMEOUT_DEFAULT);
+	if (alg_data->timeout <= 1)
+		alg_data->timeout = 2;
+
 #ifdef CONFIG_OF
 	alg_data->adapter.dev.of_node = of_node_get(pdev->dev.of_node);
 	if (pdev->dev.of_node) {
@@ -677,8 +651,6 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	if (IS_ERR(alg_data->clk))
 		return PTR_ERR(alg_data->clk);
 
-	timer_setup(&alg_data->mif.timer, i2c_pnx_timeout, 0);
-
 	snprintf(alg_data->adapter.name, sizeof(alg_data->adapter.name),
 		 "%s", pdev->name);
 
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 6a7a7a074a97..7a6bae9df568 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -116,6 +116,7 @@ enum rcar_i2c_type {
 	I2C_RCAR_GEN1,
 	I2C_RCAR_GEN2,
 	I2C_RCAR_GEN3,
+	I2C_RCAR_GEN4,
 };
 
 struct rcar_i2c_priv {
@@ -220,6 +221,14 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 
 }
 
+static void rcar_i2c_reset_slave(struct rcar_i2c_priv *priv)
+{
+	rcar_i2c_write(priv, ICSIER, 0);
+	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_write(priv, ICSCR, SDBS);
+	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+}
+
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 {
 	int ret;
@@ -372,8 +381,8 @@ static void rcar_i2c_dma_unmap(struct rcar_i2c_priv *priv)
 	dma_unmap_single(chan->device->dev, sg_dma_address(&priv->sg),
 			 sg_dma_len(&priv->sg), priv->dma_direction);
 
-	/* Gen3 can only do one RXDMA per transfer and we just completed it */
-	if (priv->devtype == I2C_RCAR_GEN3 &&
+	/* Gen3+ can only do one RXDMA per transfer and we just completed it */
+	if (priv->devtype >= I2C_RCAR_GEN3 &&
 	    priv->dma_direction == DMA_FROM_DEVICE)
 		priv->flags |= ID_P_NO_RXDMA;
 
@@ -787,6 +796,10 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
 {
 	int ret;
 
+	/* Don't reset if a slave instance is currently running */
+	if (priv->slave)
+		return -EISCONN;
+
 	ret = reset_control_reset(priv->rstc);
 	if (ret)
 		return ret;
@@ -811,14 +824,12 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 	if (ret < 0)
 		goto out;
 
-	/* Gen3 needs a reset before allowing RXDMA once */
-	if (priv->devtype == I2C_RCAR_GEN3) {
-		priv->flags |= ID_P_NO_RXDMA;
-		if (!IS_ERR(priv->rstc)) {
-			ret = rcar_i2c_do_reset(priv);
-			if (ret == 0)
-				priv->flags &= ~ID_P_NO_RXDMA;
-		}
+	/* Gen3+ needs a reset. That also allows RXDMA once */
+	if (priv->devtype >= I2C_RCAR_GEN3) {
+		ret = rcar_i2c_do_reset(priv);
+		if (ret)
+			goto out;
+		priv->flags &= ~ID_P_NO_RXDMA;
 	}
 
 	rcar_i2c_init(priv);
@@ -888,11 +899,8 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	/* ensure no irq is running before clearing ptr */
 	disable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSIER, 0);
-	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_reset_slave(priv);
 	enable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSCR, SDBS);
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
 	priv->slave = NULL;
 
@@ -945,6 +953,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
 	{ .compatible = "renesas,rcar-gen1-i2c", .data = (void *)I2C_RCAR_GEN1 },
 	{ .compatible = "renesas,rcar-gen2-i2c", .data = (void *)I2C_RCAR_GEN2 },
 	{ .compatible = "renesas,rcar-gen3-i2c", .data = (void *)I2C_RCAR_GEN3 },
+	{ .compatible = "renesas,rcar-gen4-i2c", .data = (void *)I2C_RCAR_GEN4 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);
@@ -1004,22 +1013,15 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		goto out_pm_disable;
 	}
 
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+	/* Bring hardware to known state */
+	rcar_i2c_init(priv);
+	rcar_i2c_reset_slave(priv);
 
 	if (priv->devtype < I2C_RCAR_GEN3) {
 		irqflags |= IRQF_NO_THREAD;
 		irqhandler = rcar_i2c_gen2_irq;
 	}
 
-	if (priv->devtype == I2C_RCAR_GEN3) {
-		priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-		if (!IS_ERR(priv->rstc)) {
-			ret = reset_control_status(priv->rstc);
-			if (ret < 0)
-				priv->rstc = ERR_PTR(-ENOTSUPP);
-		}
-	}
-
 	/* Stay always active when multi-master to keep arbitration working */
 	if (of_property_read_bool(dev->of_node, "multi-master"))
 		priv->flags |= ID_P_PM_BLOCKED;
@@ -1029,6 +1031,22 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "smbus"))
 		priv->flags |= ID_P_HOST_NOTIFY;
 
+	/* R-Car Gen3+ needs a reset before every transfer */
+	if (priv->devtype >= I2C_RCAR_GEN3) {
+		priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+		if (IS_ERR(priv->rstc)) {
+			ret = PTR_ERR(priv->rstc);
+			goto out_pm_put;
+		}
+
+		ret = reset_control_status(priv->rstc);
+		if (ret < 0)
+			goto out_pm_put;
+
+		/* hard reset disturbs HostNotify local target, so disable it */
+		priv->flags &= ~ID_P_HOST_NOTIFY;
+	}
+
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		goto out_pm_put;
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index e8a89e18c640..6fac638e423a 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -969,6 +969,7 @@ EXPORT_SYMBOL_GPL(i2c_unregister_device);
 
 static const struct i2c_device_id dummy_id[] = {
 	{ "dummy", 0 },
+	{ "smbus_host_notify", 0 },
 	{ },
 };
 
diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index 3bd0dcde8576..063707dd4fe3 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -63,6 +63,8 @@ MODULE_AUTHOR("Roland Dreier");
 MODULE_DESCRIPTION("InfiniBand userspace MAD packet access");
 MODULE_LICENSE("Dual BSD/GPL");
 
+#define MAX_UMAD_RECV_LIST_SIZE 200000
+
 enum {
 	IB_UMAD_MAX_PORTS  = RDMA_MAX_PORTS,
 	IB_UMAD_MAX_AGENTS = 32,
@@ -113,6 +115,7 @@ struct ib_umad_file {
 	struct mutex		mutex;
 	struct ib_umad_port    *port;
 	struct list_head	recv_list;
+	atomic_t		recv_list_size;
 	struct list_head	send_list;
 	struct list_head	port_list;
 	spinlock_t		send_lock;
@@ -180,24 +183,28 @@ static struct ib_mad_agent *__get_agent(struct ib_umad_file *file, int id)
 	return file->agents_dead ? NULL : file->agent[id];
 }
 
-static int queue_packet(struct ib_umad_file *file,
-			struct ib_mad_agent *agent,
-			struct ib_umad_packet *packet)
+static int queue_packet(struct ib_umad_file *file, struct ib_mad_agent *agent,
+			struct ib_umad_packet *packet, bool is_recv_mad)
 {
 	int ret = 1;
 
 	mutex_lock(&file->mutex);
 
+	if (is_recv_mad &&
+	    atomic_read(&file->recv_list_size) > MAX_UMAD_RECV_LIST_SIZE)
+		goto unlock;
+
 	for (packet->mad.hdr.id = 0;
 	     packet->mad.hdr.id < IB_UMAD_MAX_AGENTS;
 	     packet->mad.hdr.id++)
 		if (agent == __get_agent(file, packet->mad.hdr.id)) {
 			list_add_tail(&packet->list, &file->recv_list);
+			atomic_inc(&file->recv_list_size);
 			wake_up_interruptible(&file->recv_wait);
 			ret = 0;
 			break;
 		}
-
+unlock:
 	mutex_unlock(&file->mutex);
 
 	return ret;
@@ -224,7 +231,7 @@ static void send_handler(struct ib_mad_agent *agent,
 	if (send_wc->status == IB_WC_RESP_TIMEOUT_ERR) {
 		packet->length = IB_MGMT_MAD_HDR;
 		packet->mad.hdr.status = ETIMEDOUT;
-		if (!queue_packet(file, agent, packet))
+		if (!queue_packet(file, agent, packet, false))
 			return;
 	}
 	kfree(packet);
@@ -284,7 +291,7 @@ static void recv_handler(struct ib_mad_agent *agent,
 		rdma_destroy_ah_attr(&ah_attr);
 	}
 
-	if (queue_packet(file, agent, packet))
+	if (queue_packet(file, agent, packet, true))
 		goto err2;
 	return;
 
@@ -409,6 +416,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 
 	packet = list_entry(file->recv_list.next, struct ib_umad_packet, list);
 	list_del(&packet->list);
+	atomic_dec(&file->recv_list_size);
 
 	mutex_unlock(&file->mutex);
 
@@ -421,6 +429,7 @@ static ssize_t ib_umad_read(struct file *filp, char __user *buf,
 		/* Requeue packet */
 		mutex_lock(&file->mutex);
 		list_add(&packet->list, &file->recv_list);
+		atomic_inc(&file->recv_list_size);
 		mutex_unlock(&file->mutex);
 	} else {
 		if (packet->recv_wc)
diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
index 1cf5deda06e1..a765e185c7a1 100644
--- a/drivers/input/ff-core.c
+++ b/drivers/input/ff-core.c
@@ -12,8 +12,10 @@
 /* #define DEBUG */
 
 #include <linux/input.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -318,9 +320,8 @@ int input_ff_create(struct input_dev *dev, unsigned int max_effects)
 		return -EINVAL;
 	}
 
-	ff_dev_size = sizeof(struct ff_device) +
-				max_effects * sizeof(struct file *);
-	if (ff_dev_size < max_effects) /* overflow */
+	ff_dev_size = struct_size(ff, effect_owners, max_effects);
+	if (ff_dev_size == SIZE_MAX) /* overflow */
 		return -EINVAL;
 
 	ff = kzalloc(ff_dev_size, GFP_KERNEL);
diff --git a/drivers/media/dvb-frontends/as102_fe_types.h b/drivers/media/dvb-frontends/as102_fe_types.h
index 297f9520ebf9..8a4e392c8896 100644
--- a/drivers/media/dvb-frontends/as102_fe_types.h
+++ b/drivers/media/dvb-frontends/as102_fe_types.h
@@ -174,6 +174,6 @@ struct as10x_register_addr {
 	uint32_t addr;
 	/* register mode access */
 	uint8_t mode;
-};
+} __packed;
 
 #endif
diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
index f1d5e77d5dcc..db829754f135 100644
--- a/drivers/media/dvb-frontends/tda10048.c
+++ b/drivers/media/dvb-frontends/tda10048.c
@@ -410,6 +410,7 @@ static int tda10048_set_if(struct dvb_frontend *fe, u32 bw)
 	struct tda10048_config *config = &state->config;
 	int i;
 	u32 if_freq_khz;
+	u64 sample_freq;
 
 	dprintk(1, "%s(bw = %d)\n", __func__, bw);
 
@@ -451,9 +452,11 @@ static int tda10048_set_if(struct dvb_frontend *fe, u32 bw)
 	dprintk(1, "- pll_pfactor = %d\n", state->pll_pfactor);
 
 	/* Calculate the sample frequency */
-	state->sample_freq = state->xtal_hz * (state->pll_mfactor + 45);
-	state->sample_freq /= (state->pll_nfactor + 1);
-	state->sample_freq /= (state->pll_pfactor + 4);
+	sample_freq = state->xtal_hz;
+	sample_freq *= state->pll_mfactor + 45;
+	do_div(sample_freq, state->pll_nfactor + 1);
+	do_div(sample_freq, state->pll_pfactor + 4);
+	state->sample_freq = sample_freq;
 	dprintk(1, "- sample_freq = %d\n", state->sample_freq);
 
 	/* Update the I/F */
diff --git a/drivers/media/dvb-frontends/tda18271c2dd.c b/drivers/media/dvb-frontends/tda18271c2dd.c
index a34834487943..fd928787207e 100644
--- a/drivers/media/dvb-frontends/tda18271c2dd.c
+++ b/drivers/media/dvb-frontends/tda18271c2dd.c
@@ -328,7 +328,7 @@ static int CalcMainPLL(struct tda_state *state, u32 freq)
 
 	OscFreq = (u64) freq * (u64) Div;
 	OscFreq *= (u64) 16384;
-	do_div(OscFreq, (u64)16000000);
+	do_div(OscFreq, 16000000);
 	MainDiv = OscFreq;
 
 	state->m_Regs[MPD] = PostDiv & 0x77;
@@ -352,7 +352,7 @@ static int CalcCalPLL(struct tda_state *state, u32 freq)
 	OscFreq = (u64)freq * (u64)Div;
 	/* CalDiv = u32( OscFreq * 16384 / 16000000 ); */
 	OscFreq *= (u64)16384;
-	do_div(OscFreq, (u64)16000000);
+	do_div(OscFreq, 16000000);
 	CalDiv = OscFreq;
 
 	state->m_Regs[CPD] = PostDiv;
diff --git a/drivers/media/usb/dvb-usb/dib0700_devices.c b/drivers/media/usb/dvb-usb/dib0700_devices.c
index d3288c107906..afc561c1a5d6 100644
--- a/drivers/media/usb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/usb/dvb-usb/dib0700_devices.c
@@ -2419,7 +2419,12 @@ static int stk9090m_frontend_attach(struct dvb_usb_adapter *adap)
 
 	adap->fe_adap[0].fe = dvb_attach(dib9000_attach, &adap->dev->i2c_adap, 0x80, &stk9090m_config);
 
-	return adap->fe_adap[0].fe == NULL ?  -ENODEV : 0;
+	if (!adap->fe_adap[0].fe) {
+		release_firmware(state->frontend_firmware);
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static int dib9090_tuner_attach(struct dvb_usb_adapter *adap)
@@ -2492,8 +2497,10 @@ static int nim9090md_frontend_attach(struct dvb_usb_adapter *adap)
 	dib9000_i2c_enumeration(&adap->dev->i2c_adap, 1, 0x20, 0x80);
 	adap->fe_adap[0].fe = dvb_attach(dib9000_attach, &adap->dev->i2c_adap, 0x80, &nim9090md_config[0]);
 
-	if (adap->fe_adap[0].fe == NULL)
+	if (!adap->fe_adap[0].fe) {
+		release_firmware(state->frontend_firmware);
 		return -ENODEV;
+	}
 
 	i2c = dib9000_get_i2c_master(adap->fe_adap[0].fe, DIBX000_I2C_INTERFACE_GPIO_3_4, 0);
 	dib9000_i2c_enumeration(i2c, 1, 0x12, 0x82);
@@ -2501,7 +2508,12 @@ static int nim9090md_frontend_attach(struct dvb_usb_adapter *adap)
 	fe_slave = dvb_attach(dib9000_attach, i2c, 0x82, &nim9090md_config[1]);
 	dib9000_set_slave_frontend(adap->fe_adap[0].fe, fe_slave);
 
-	return fe_slave == NULL ?  -ENODEV : 0;
+	if (!fe_slave) {
+		release_firmware(state->frontend_firmware);
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static int nim9090md_tuner_attach(struct dvb_usb_adapter *adap)
diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 2290f132a82c..86e537f0316d 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -716,6 +716,7 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	struct dw2102_state *state;
+	int j;
 
 	if (!d)
 		return -ENODEV;
@@ -729,11 +730,11 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		return -EAGAIN;
 	}
 
-	switch (num) {
-	case 1:
-		switch (msg[0].addr) {
+	j = 0;
+	while (j < num) {
+		switch (msg[j].addr) {
 		case SU3000_STREAM_CTRL:
-			state->data[0] = msg[0].buf[0] + 0x36;
+			state->data[0] = msg[j].buf[0] + 0x36;
 			state->data[1] = 3;
 			state->data[2] = 0;
 			if (dvb_usb_generic_rw(d, state->data, 3,
@@ -745,61 +746,86 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			if (dvb_usb_generic_rw(d, state->data, 1,
 					state->data, 2, 0) < 0)
 				err("i2c transfer failed.");
-			msg[0].buf[1] = state->data[0];
-			msg[0].buf[0] = state->data[1];
+			msg[j].buf[1] = state->data[0];
+			msg[j].buf[0] = state->data[1];
 			break;
 		default:
-			if (3 + msg[0].len > sizeof(state->data)) {
-				warn("i2c wr: len=%d is too big!\n",
-				     msg[0].len);
+			/* if the current write msg is followed by a another
+			 * read msg to/from the same address
+			 */
+			if ((j+1 < num) && (msg[j+1].flags & I2C_M_RD) &&
+			    (msg[j].addr == msg[j+1].addr)) {
+				/* join both i2c msgs to one usb read command */
+				if (4 + msg[j].len > sizeof(state->data)) {
+					warn("i2c combined wr/rd: write len=%d is too big!\n",
+					    msg[j].len);
+					num = -EOPNOTSUPP;
+					break;
+				}
+				if (1 + msg[j+1].len > sizeof(state->data)) {
+					warn("i2c combined wr/rd: read len=%d is too big!\n",
+					    msg[j+1].len);
+					num = -EOPNOTSUPP;
+					break;
+				}
+
+				state->data[0] = 0x09;
+				state->data[1] = msg[j].len;
+				state->data[2] = msg[j+1].len;
+				state->data[3] = msg[j].addr;
+				memcpy(&state->data[4], msg[j].buf, msg[j].len);
+
+				if (dvb_usb_generic_rw(d, state->data, msg[j].len + 4,
+					state->data, msg[j+1].len + 1, 0) < 0)
+					err("i2c transfer failed.");
+
+				memcpy(msg[j+1].buf, &state->data[1], msg[j+1].len);
+				j++;
+				break;
+			}
+
+			if (msg[j].flags & I2C_M_RD) {
+				/* single read */
+				if (4 + msg[j].len > sizeof(state->data)) {
+					warn("i2c rd: len=%d is too big!\n", msg[j].len);
+					num = -EOPNOTSUPP;
+					break;
+				}
+
+				state->data[0] = 0x09;
+				state->data[1] = 0;
+				state->data[2] = msg[j].len;
+				state->data[3] = msg[j].addr;
+				memcpy(&state->data[4], msg[j].buf, msg[j].len);
+
+				if (dvb_usb_generic_rw(d, state->data, 4,
+					state->data, msg[j].len + 1, 0) < 0)
+					err("i2c transfer failed.");
+
+				memcpy(msg[j].buf, &state->data[1], msg[j].len);
+				break;
+			}
+
+			/* single write */
+			if (3 + msg[j].len > sizeof(state->data)) {
+				warn("i2c wr: len=%d is too big!\n", msg[j].len);
 				num = -EOPNOTSUPP;
 				break;
 			}
 
-			/* always i2c write*/
 			state->data[0] = 0x08;
-			state->data[1] = msg[0].addr;
-			state->data[2] = msg[0].len;
+			state->data[1] = msg[j].addr;
+			state->data[2] = msg[j].len;
 
-			memcpy(&state->data[3], msg[0].buf, msg[0].len);
+			memcpy(&state->data[3], msg[j].buf, msg[j].len);
 
-			if (dvb_usb_generic_rw(d, state->data, msg[0].len + 3,
+			if (dvb_usb_generic_rw(d, state->data, msg[j].len + 3,
 						state->data, 1, 0) < 0)
 				err("i2c transfer failed.");
+		} // switch
+		j++;
 
-		}
-		break;
-	case 2:
-		/* always i2c read */
-		if (4 + msg[0].len > sizeof(state->data)) {
-			warn("i2c rd: len=%d is too big!\n",
-			     msg[0].len);
-			num = -EOPNOTSUPP;
-			break;
-		}
-		if (1 + msg[1].len > sizeof(state->data)) {
-			warn("i2c rd: len=%d is too big!\n",
-			     msg[1].len);
-			num = -EOPNOTSUPP;
-			break;
-		}
-
-		state->data[0] = 0x09;
-		state->data[1] = msg[0].len;
-		state->data[2] = msg[1].len;
-		state->data[3] = msg[0].addr;
-		memcpy(&state->data[4], msg[0].buf, msg[0].len);
-
-		if (dvb_usb_generic_rw(d, state->data, msg[0].len + 4,
-					state->data, msg[1].len + 1, 0) < 0)
-			err("i2c transfer failed.");
-
-		memcpy(msg[1].buf, &state->data[1], msg[1].len);
-		break;
-	default:
-		warn("more than 2 i2c messages at a time is not handled yet.");
-		break;
-	}
+	} // while
 	mutex_unlock(&d->data_mutex);
 	mutex_unlock(&d->i2c_mutex);
 	return num;
diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index cb15eb32d2a6..50ac20c22630 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -247,7 +247,7 @@ struct s2255_vc {
 struct s2255_dev {
 	struct s2255_vc         vc[MAX_CHANNELS];
 	struct v4l2_device      v4l2_dev;
-	atomic_t                num_channels;
+	refcount_t		num_channels;
 	int			frames;
 	struct mutex		lock;	/* channels[].vdev.lock */
 	struct mutex		cmdlock; /* protects cmdbuf */
@@ -1552,11 +1552,11 @@ static void s2255_video_device_release(struct video_device *vdev)
 		container_of(vdev, struct s2255_vc, vdev);
 
 	dprintk(dev, 4, "%s, chnls: %d\n", __func__,
-		atomic_read(&dev->num_channels));
+		refcount_read(&dev->num_channels));
 
 	v4l2_ctrl_handler_free(&vc->hdl);
 
-	if (atomic_dec_and_test(&dev->num_channels))
+	if (refcount_dec_and_test(&dev->num_channels))
 		s2255_destroy(dev);
 	return;
 }
@@ -1661,7 +1661,7 @@ static int s2255_probe_v4l(struct s2255_dev *dev)
 				"failed to register video device!\n");
 			break;
 		}
-		atomic_inc(&dev->num_channels);
+		refcount_inc(&dev->num_channels);
 		v4l2_info(&dev->v4l2_dev, "V4L2 device registered as %s\n",
 			  video_device_node_name(&vc->vdev));
 
@@ -1669,11 +1669,11 @@ static int s2255_probe_v4l(struct s2255_dev *dev)
 	pr_info("Sensoray 2255 V4L driver Revision: %s\n",
 		S2255_VERSION);
 	/* if no channels registered, return error and probe will fail*/
-	if (atomic_read(&dev->num_channels) == 0) {
+	if (refcount_read(&dev->num_channels) == 0) {
 		v4l2_device_unregister(&dev->v4l2_dev);
 		return ret;
 	}
-	if (atomic_read(&dev->num_channels) != MAX_CHANNELS)
+	if (refcount_read(&dev->num_channels) != MAX_CHANNELS)
 		pr_warn("s2255: Not all channels available.\n");
 	return 0;
 }
@@ -2222,7 +2222,7 @@ static int s2255_probe(struct usb_interface *interface,
 		goto errorFWDATA1;
 	}
 
-	atomic_set(&dev->num_channels, 0);
+	refcount_set(&dev->num_channels, 0);
 	dev->pid = id->idProduct;
 	dev->fw_data = kzalloc(sizeof(struct s2255_fw), GFP_KERNEL);
 	if (!dev->fw_data)
@@ -2342,12 +2342,12 @@ static void s2255_disconnect(struct usb_interface *interface)
 {
 	struct s2255_dev *dev = to_s2255_dev(usb_get_intfdata(interface));
 	int i;
-	int channels = atomic_read(&dev->num_channels);
+	int channels = refcount_read(&dev->num_channels);
 	mutex_lock(&dev->lock);
 	v4l2_device_disconnect(&dev->v4l2_dev);
 	mutex_unlock(&dev->lock);
 	/*see comments in the uvc_driver.c usb disconnect function */
-	atomic_inc(&dev->num_channels);
+	refcount_inc(&dev->num_channels);
 	/* unregister each video device. */
 	for (i = 0; i < channels; i++)
 		video_unregister_device(&dev->vc[i].vdev);
@@ -2360,7 +2360,7 @@ static void s2255_disconnect(struct usb_interface *interface)
 		dev->vc[i].vidstatus_ready = 1;
 		wake_up(&dev->vc[i].wait_vidstatus);
 	}
-	if (atomic_dec_and_test(&dev->num_channels))
+	if (refcount_dec_and_test(&dev->num_channels))
 		s2255_destroy(dev);
 	dev_info(&interface->dev, "%s\n", __func__);
 }
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c41c0ff611b1..308fcbe394a5 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -964,28 +964,32 @@ static int nand_fill_column_cycles(struct nand_chip *chip, u8 *addrs,
 				   unsigned int offset_in_page)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	bool ident_stage = !mtd->writesize;
 
-	/* Make sure the offset is less than the actual page size. */
-	if (offset_in_page > mtd->writesize + mtd->oobsize)
-		return -EINVAL;
+	/* Bypass all checks during NAND identification */
+	if (likely(!ident_stage)) {
+		/* Make sure the offset is less than the actual page size. */
+		if (offset_in_page > mtd->writesize + mtd->oobsize)
+			return -EINVAL;
 
-	/*
-	 * On small page NANDs, there's a dedicated command to access the OOB
-	 * area, and the column address is relative to the start of the OOB
-	 * area, not the start of the page. Asjust the address accordingly.
-	 */
-	if (mtd->writesize <= 512 && offset_in_page >= mtd->writesize)
-		offset_in_page -= mtd->writesize;
+		/*
+		 * On small page NANDs, there's a dedicated command to access the OOB
+		 * area, and the column address is relative to the start of the OOB
+		 * area, not the start of the page. Asjust the address accordingly.
+		 */
+		if (mtd->writesize <= 512 && offset_in_page >= mtd->writesize)
+			offset_in_page -= mtd->writesize;
 
-	/*
-	 * The offset in page is expressed in bytes, if the NAND bus is 16-bit
-	 * wide, then it must be divided by 2.
-	 */
-	if (chip->options & NAND_BUSWIDTH_16) {
-		if (WARN_ON(offset_in_page % 2))
-			return -EINVAL;
+		/*
+		 * The offset in page is expressed in bytes, if the NAND bus is 16-bit
+		 * wide, then it must be divided by 2.
+		 */
+		if (chip->options & NAND_BUSWIDTH_16) {
+			if (WARN_ON(offset_in_page % 2))
+				return -EINVAL;
 
-		offset_in_page /= 2;
+			offset_in_page /= 2;
+		}
 	}
 
 	addrs[0] = offset_in_page;
@@ -994,7 +998,7 @@ static int nand_fill_column_cycles(struct nand_chip *chip, u8 *addrs,
 	 * Small page NANDs use 1 cycle for the columns, while large page NANDs
 	 * need 2
 	 */
-	if (mtd->writesize <= 512)
+	if (!ident_stage && mtd->writesize <= 512)
 		return 1;
 
 	addrs[1] = offset_in_page >> 8;
@@ -1189,16 +1193,19 @@ int nand_change_read_column_op(struct nand_chip *chip,
 			       unsigned int len, bool force_8bit)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
+	bool ident_stage = !mtd->writesize;
 
 	if (len && !buf)
 		return -EINVAL;
 
-	if (offset_in_page + len > mtd->writesize + mtd->oobsize)
-		return -EINVAL;
+	if (!ident_stage) {
+		if (offset_in_page + len > mtd->writesize + mtd->oobsize)
+			return -EINVAL;
 
-	/* Small page NANDs do not support column change. */
-	if (mtd->writesize <= 512)
-		return -ENOTSUPP;
+		/* Small page NANDs do not support column change. */
+		if (mtd->writesize <= 512)
+			return -ENOTSUPP;
+	}
 
 	if (nand_has_exec_op(chip)) {
 		const struct nand_sdr_timings *sdr =
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index fe55c81608da..fa0bf77870d4 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1100,9 +1100,9 @@ static int bond_option_arp_ip_targets_set(struct bonding *bond,
 	__be32 target;
 
 	if (newval->string) {
-		if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
-			netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
-				   &target);
+		if (strlen(newval->string) < 1 ||
+		    !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+			netdev_err(bond->dev, "invalid ARP target specified\n");
 			return ret;
 		}
 		if (newval->string[0] == '+')
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index 1f015b496a47..411b3adb1d9e 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -114,6 +114,7 @@ static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leaf_err_liste
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
 	.quirks = 0,
+	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ac56bc175b51..6a1ae774cfe9 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -116,8 +116,8 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
 {
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 
-	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
-				    list);
+	mdio_bus = list_first_entry_or_null(&chip->mdios,
+					    struct mv88e6xxx_mdio_bus, list);
 	if (!mdio_bus)
 		return NULL;
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
index 2a61229d3f97..c1fe9bcbb955 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
@@ -1262,7 +1262,7 @@ enum {
 
 struct bnx2x_fw_stats_req {
 	struct stats_query_header hdr;
-	struct stats_query_entry query[FP_SB_MAX_E1x+
+	struct stats_query_entry query[FP_SB_MAX_E2 +
 		BNX2X_FIRST_QUEUE_QUERY_IDX];
 };
 
diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 5ea626b1e578..1d7c0b872c59 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -213,8 +213,9 @@ ltq_etop_free_channel(struct net_device *dev, struct ltq_etop_chan *ch)
 	if (ch->dma.irq)
 		free_irq(ch->dma.irq, priv);
 	if (IS_RX(ch->idx)) {
-		int desc;
-		for (desc = 0; desc < LTQ_DESC_NUM; desc++)
+		struct ltq_dma_channel *dma = &ch->dma;
+
+		for (dma->desc = 0; dma->desc < LTQ_DESC_NUM; dma->desc++)
 			dev_kfree_skb_any(ch->skb[ch->dma.desc]);
 	}
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
index dc34e564c919..46689d95254b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
@@ -54,8 +54,13 @@ enum npc_kpu_lb_ltype {
 	NPC_LT_LB_CUSTOM1 = 0xF,
 };
 
+/* Don't modify ltypes up to IP6_EXT, otherwise length and checksum of IP
+ * headers may not be checked correctly. IPv4 ltypes and IPv6 ltypes must
+ * differ only at bit 0 so mask 0xE can be used to detect extended headers.
+ */
 enum npc_kpu_lc_ltype {
-	NPC_LT_LC_IP = 1,
+	NPC_LT_LC_PTP = 1,
+	NPC_LT_LC_IP,
 	NPC_LT_LC_IP_OPT,
 	NPC_LT_LC_IP6,
 	NPC_LT_LC_IP6_EXT,
@@ -63,7 +68,6 @@ enum npc_kpu_lc_ltype {
 	NPC_LT_LC_RARP,
 	NPC_LT_LC_MPLS,
 	NPC_LT_LC_NSH,
-	NPC_LT_LC_PTP,
 	NPC_LT_LC_FCOE,
 	NPC_LT_LC_CUSTOM0 = 0xE,
 	NPC_LT_LC_CUSTOM1 = 0xF,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 23b829f974de..e8a2552fb690 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1357,7 +1357,7 @@ static int rvu_check_rsrc_availability(struct rvu *rvu,
 		if (req->ssow > block->lf.max) {
 			dev_err(&rvu->pdev->dev,
 				"Func 0x%x: Invalid SSOW req, %d > max %d\n",
-				 pcifunc, req->sso, block->lf.max);
+				 pcifunc, req->ssow, block->lf.max);
 			return -EINVAL;
 		}
 		mappedlfs = rvu_get_rsrc_mapcount(pfvf, block->addr);
diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
index 3d0ac7f3c87e..a4b4fa78ef92 100644
--- a/drivers/net/ethernet/micrel/ks8851_common.c
+++ b/drivers/net/ethernet/micrel/ks8851_common.c
@@ -501,6 +501,7 @@ static int ks8851_net_open(struct net_device *dev)
 	ks8851_wrreg16(ks, KS_IER, ks->rc_ier);
 
 	ks->queued_len = 0;
+	ks->tx_space = ks8851_rdreg16(ks, KS_TXMIR);
 	netif_start_queue(ks->netdev);
 
 	netif_dbg(ks, ifup, ks->netdev, "network device up\n");
@@ -1057,7 +1058,6 @@ int ks8851_probe_common(struct net_device *netdev, struct device *dev,
 	int ret;
 
 	ks->netdev = netdev;
-	ks->tx_space = 6144;
 
 	gpio = of_get_named_gpio_flags(dev->of_node, "reset-gpios", 0, NULL);
 	if (gpio == -EPROBE_DEFER)
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index b825c6a9b6dd..e2bca6fa0822 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -70,6 +70,7 @@
 #define MPHDRLEN_SSN	4	/* ditto with short sequence numbers */
 
 #define PPP_PROTO_LEN	2
+#define PPP_LCP_HDRLEN	4
 
 /*
  * An instance of /dev/ppp can be associated with either a ppp
@@ -489,6 +490,15 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+static bool ppp_check_packet(struct sk_buff *skb, size_t count)
+{
+	/* LCP packets must include LCP header which 4 bytes long:
+	 * 1-byte code, 1-byte identifier, and 2-byte length.
+	 */
+	return get_unaligned_be16(skb->data) != PPP_LCP ||
+		count >= PPP_PROTO_LEN + PPP_LCP_HDRLEN;
+}
+
 static ssize_t ppp_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -511,6 +521,11 @@ static ssize_t ppp_write(struct file *file, const char __user *buf,
 		kfree_skb(skb);
 		goto out;
 	}
+	ret = -EINVAL;
+	if (unlikely(!ppp_check_packet(skb, count))) {
+		kfree_skb(skb);
+		goto out;
+	}
 
 	switch (pf->kind) {
 	case INTERFACE:
diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
index 0ba714ca5185..4b8528206cc8 100644
--- a/drivers/net/wireguard/allowedips.c
+++ b/drivers/net/wireguard/allowedips.c
@@ -15,8 +15,8 @@ static void swap_endian(u8 *dst, const u8 *src, u8 bits)
 	if (bits == 32) {
 		*(u32 *)dst = be32_to_cpu(*(const __be32 *)src);
 	} else if (bits == 128) {
-		((u64 *)dst)[0] = be64_to_cpu(((const __be64 *)src)[0]);
-		((u64 *)dst)[1] = be64_to_cpu(((const __be64 *)src)[1]);
+		((u64 *)dst)[0] = get_unaligned_be64(src);
+		((u64 *)dst)[1] = get_unaligned_be64(src + 8);
 	}
 }
 
diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index a2e702f8c582..5d2480d90fdb 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -126,10 +126,10 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
  */
 static inline int wg_cpumask_next_online(int *last_cpu)
 {
-	int cpu = cpumask_next(*last_cpu, cpu_online_mask);
+	int cpu = cpumask_next(READ_ONCE(*last_cpu), cpu_online_mask);
 	if (cpu >= nr_cpu_ids)
 		cpu = cpumask_first(cpu_online_mask);
-	*last_cpu = cpu;
+	WRITE_ONCE(*last_cpu, cpu);
 	return cpu;
 }
 
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 0d48e0f4a1ba..26e09c30d596 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -222,7 +222,7 @@ void wg_packet_send_keepalive(struct wg_peer *peer)
 {
 	struct sk_buff *skb;
 
-	if (skb_queue_empty(&peer->staged_packet_queue)) {
+	if (skb_queue_empty_lockless(&peer->staged_packet_queue)) {
 		skb = alloc_skb(DATA_PACKET_HEAD_ROOM + MESSAGE_MINIMUM_LENGTH,
 				GFP_ATOMIC);
 		if (unlikely(!skb))
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 457386f9de99..3f167bf4eef3 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -364,7 +364,8 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	struct ieee80211_p2p_noa_attr noa_attr;
 	const struct cfg80211_bss_ies *ies;
 	struct wilc_join_bss_param *param;
-	u8 rates_len = 0, ies_len;
+	u8 rates_len = 0;
+	int ies_len;
 	int ret;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9f59f93b70e2..54ca60db6547 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -420,7 +420,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		int node, srcu_idx;
 
 		srcu_idx = srcu_read_lock(&head->srcu);
-		for_each_node(node)
+		for_each_online_node(node)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5242feda5471..a7131f4752e2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -844,7 +844,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 59109eb8e8e4..a04bb02c1251 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -795,6 +795,15 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 
+	/*
+	 * we must reference the ctrl again after waiting for inflight IO
+	 * to complete. Because admin connect may have sneaked in after we
+	 * store sq->ctrl locally, but before we killed the percpu_ref. the
+	 * admin connect allocates and assigns sq->ctrl, which now needs a
+	 * final ref put, as this ctrl is going away.
+	 */
+	ctrl = sq->ctrl;
+
 	if (ctrl) {
 		/*
 		 * The teardown flow may take some time, and the host may not
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index ba2714bef8d0..cf1b249e67ca 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -18,18 +18,24 @@ static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
-				  bytes, 0, 0, 0);
+	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int meson_efuse_write(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
+
+	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
 
-	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
-				   bytes, 0, 0, 0);
+	return ret < 0 ? ret : 0;
 }
 
 static const struct of_device_id meson_efuse_match[] = {
diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index fbaa61859462..dce2d26b1d0f 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -857,6 +857,22 @@ static const struct ts_dmi_data schneider_sct101ctm_data = {
 	.properties	= schneider_sct101ctm_props,
 };
 
+static const struct property_entry globalspace_solt_ivw116_props[] = {
+	PROPERTY_ENTRY_U32("touchscreen-min-x", 7),
+	PROPERTY_ENTRY_U32("touchscreen-min-y", 22),
+	PROPERTY_ENTRY_U32("touchscreen-size-x", 1723),
+	PROPERTY_ENTRY_U32("touchscreen-size-y", 1077),
+	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-globalspace-solt-ivw116.fw"),
+	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
+	PROPERTY_ENTRY_BOOL("silead,home-button"),
+	{ }
+};
+
+static const struct ts_dmi_data globalspace_solt_ivw116_data = {
+	.acpi_name	= "MSSL1680:00",
+	.properties	= globalspace_solt_ivw116_props,
+};
+
 static const struct property_entry techbite_arc_11_6_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-min-x", 5),
 	PROPERTY_ENTRY_U32("touchscreen-min-y", 7),
@@ -1261,6 +1277,17 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_BIOS_DATE, "04/24/2018"),
 		},
 	},
+	{
+		/* Jumper EZpad 6s Pro */
+		.driver_data = (void *)&jumper_ezpad_6_pro_b_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Jumper"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Ezpad"),
+			/* Above matches are too generic, add bios match */
+			DMI_MATCH(DMI_BIOS_VERSION, "E.WSA116_8.E1.042.bin"),
+			DMI_MATCH(DMI_BIOS_DATE, "01/08/2020"),
+		},
+	},
 	{
 		/* Jumper EZpad 6 m4 */
 		.driver_data = (void *)&jumper_ezpad_6_m4_data,
@@ -1490,6 +1517,15 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "SCT101CTM"),
 		},
 	},
+	{
+		/* GlobalSpace SoLT IVW 11.6" */
+		.driver_data = (void *)&globalspace_solt_ivw116_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Globalspace Tech Pvt Ltd"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SolTIVW"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "PN20170413488"),
+		},
+	},
 	{
 		/* Techbite Arc 11.6 */
 		.driver_data = (void *)&techbite_arc_11_6_data,
diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 69882ff4db10..362c97d9bd5b 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1155,7 +1155,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (rc)
 			break;
 		if (copy_to_user(ucs, &kcs, sizeof(kcs)))
-			return -EFAULT;
+			rc = -EFAULT;
 		memzero_explicit(&kcs, sizeof(kcs));
 		break;
 	}
@@ -1187,7 +1187,7 @@ static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
 		if (rc)
 			break;
 		if (copy_to_user(ucp, &kcp, sizeof(kcp)))
-			return -EFAULT;
+			rc = -EFAULT;
 		memzero_explicit(&kcp, sizeof(kcp));
 		break;
 	}
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 1f8e81296beb..70f920f4b7a1 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -2351,9 +2351,6 @@ static int qedf_execute_tmf(struct qedf_rport *fcport, struct scsi_cmnd *sc_cmd,
 	io_req->fcport = fcport;
 	io_req->cmd_type = QEDF_TASK_MGMT_CMD;
 
-	/* Record which cpu this request is associated with */
-	io_req->cpu = smp_processor_id();
-
 	/* Set TM flags */
 	io_req->io_req_flags = QEDF_READ;
 	io_req->data_xfer_len = 0;
@@ -2375,6 +2372,9 @@ static int qedf_execute_tmf(struct qedf_rport *fcport, struct scsi_cmnd *sc_cmd,
 
 	spin_lock_irqsave(&fcport->rport_lock, flags);
 
+	/* Record which cpu this request is associated with */
+	io_req->cpu = smp_processor_id();
+
 	sqe_idx = qedf_get_sqe_idx(fcport);
 	sqe = &fcport->sq[sqe_idx];
 	memset(sqe, 0, sizeof(struct fcoe_wqe));
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 2f8a1225b697..1508e0f00dbc 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -291,6 +291,20 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	if (ifp->desc.bNumEndpoints >= num_ep)
 		goto skip_to_next_endpoint_or_interface_descriptor;
 
+	/* Save a copy of the descriptor and use it instead of the original */
+	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	memcpy(&endpoint->desc, d, n);
+	d = &endpoint->desc;
+
+	/* Clear the reserved bits in bEndpointAddress */
+	i = d->bEndpointAddress &
+			(USB_ENDPOINT_DIR_MASK | USB_ENDPOINT_NUMBER_MASK);
+	if (i != d->bEndpointAddress) {
+		dev_notice(ddev, "config %d interface %d altsetting %d has an endpoint descriptor with address 0x%X, changing to 0x%X\n",
+		    cfgno, inum, asnum, d->bEndpointAddress, i);
+		endpoint->desc.bEndpointAddress = i;
+	}
+
 	/* Check for duplicate endpoint addresses */
 	if (config_endpoint_is_duplicate(config, inum, asnum, d)) {
 		dev_notice(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
@@ -308,10 +322,8 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		}
 	}
 
-	endpoint = &ifp->endpoint[ifp->desc.bNumEndpoints];
+	/* Accept this endpoint */
 	++ifp->desc.bNumEndpoints;
-
-	memcpy(&endpoint->desc, d, n);
 	INIT_LIST_HEAD(&endpoint->urb_list);
 
 	/*
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 856947620f14..3a54d76c55a3 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -504,6 +504,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1b1c, 0x1b38), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
+	/* START BP-850k Printer */
+	{ USB_DEVICE(0x1bc3, 0x0003), .driver_info = USB_QUIRK_NO_SET_INTF },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index d51ea1c052f2..6bb69a4e6470 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -104,9 +104,12 @@ static int usb_string_copy(const char *s, char **s_copy)
 	int ret;
 	char *str;
 	char *copy = *s_copy;
+
 	ret = strlen(s);
 	if (ret > USB_MAX_STRING_LEN)
 		return -EOVERFLOW;
+	if (ret < 1)
+		return -EINVAL;
 
 	if (copy) {
 		str = copy;
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 48a9a0476a45..e568bf566ab0 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1764,6 +1764,49 @@ static int mos7840_port_remove(struct usb_serial_port *port)
 	return 0;
 }
 
+static int mos7840_suspend(struct usb_serial *serial, pm_message_t message)
+{
+	struct moschip_port *mos7840_port;
+	struct usb_serial_port *port;
+	int i;
+
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (!tty_port_initialized(&port->port))
+			continue;
+
+		mos7840_port = usb_get_serial_port_data(port);
+
+		usb_kill_urb(mos7840_port->read_urb);
+		mos7840_port->read_urb_busy = false;
+	}
+
+	return 0;
+}
+
+static int mos7840_resume(struct usb_serial *serial)
+{
+	struct moschip_port *mos7840_port;
+	struct usb_serial_port *port;
+	int res;
+	int i;
+
+	for (i = 0; i < serial->num_ports; ++i) {
+		port = serial->port[i];
+		if (!tty_port_initialized(&port->port))
+			continue;
+
+		mos7840_port = usb_get_serial_port_data(port);
+
+		mos7840_port->read_urb_busy = true;
+		res = usb_submit_urb(mos7840_port->read_urb, GFP_NOIO);
+		if (res)
+			mos7840_port->read_urb_busy = false;
+	}
+
+	return 0;
+}
+
 static struct usb_serial_driver moschip7840_4port_device = {
 	.driver = {
 		   .owner = THIS_MODULE,
@@ -1792,6 +1835,8 @@ static struct usb_serial_driver moschip7840_4port_device = {
 	.port_probe = mos7840_port_probe,
 	.port_remove = mos7840_port_remove,
 	.read_bulk_callback = mos7840_bulk_in_callback,
+	.suspend = mos7840_suspend,
+	.resume = mos7840_resume,
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 400e3e10b435..73d97f7bf15b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1425,6 +1425,10 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(0) | RSVD(1) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x1901, 0xff),	/* Telit LN940 (MBIM) */
 	  .driver_info = NCTRL(0) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x3000, 0xff),	/* Telit FN912 */
+	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x3001, 0xff),	/* Telit FN912 */
+	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x7010, 0xff),	/* Telit LE910-S1 (RNDIS) */
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x7011, 0xff),	/* Telit LE910-S1 (ECM) */
@@ -1433,6 +1437,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = NCTRL(2) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x701b, 0xff),	/* Telit LE910R1 (ECM) */
 	  .driver_info = NCTRL(2) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x9000, 0xff),	/* Telit generic core-dump device */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9010),				/* Telit SBL FN980 flashing device */
 	  .driver_info = NCTRL(0) | ZLP },
 	{ USB_DEVICE(TELIT_VENDOR_ID, 0x9200),				/* Telit LE910S1 flashing device */
@@ -2224,6 +2230,10 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_7106_2COM, 0x02, 0x02, 0x01) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_DC_4COM2, 0xff, 0x02, 0x01) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, MEDIATEK_PRODUCT_DC_4COM2, 0xff, 0x00, 0x00) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7126, 0xff, 0x00, 0x00),
+	  .driver_info = NCTRL(2) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(MEDIATEK_VENDOR_ID, 0x7127, 0xff, 0x00, 0x00),
+	  .driver_info = NCTRL(2) | NCTRL(3) | NCTRL(4) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MEN200) },
 	{ USB_DEVICE(CELLIENT_VENDOR_ID, CELLIENT_PRODUCT_MPL200),
 	  .driver_info = RSVD(1) | RSVD(4) },
@@ -2284,6 +2294,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0f0, 0xff),			/* Foxconn T99W373 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
+	  .driver_info = RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1508, 0x1001),						/* Fibocom NL668 (IOT version) */
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
@@ -2321,6 +2333,32 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0115, 0xff),			/* Rolling RW135-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0101, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for Global SKU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0101, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0101, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0106, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WRD for China SKU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0106, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0106, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0111, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for SA */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0111, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0111, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0112, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for EU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0112, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0112, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0113, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for NA */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0113, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0113, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0115, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for China EDU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0115, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0115, 0xff, 0xff, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Golbal EDU */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0x00, 0x40) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0116, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
diff --git a/fs/dcache.c b/fs/dcache.c
index 976c7474d62a..406a71abb1b5 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -329,7 +329,11 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	/*
+	 * The negative counter only tracks dentries on the LRU. Don't inc if
+	 * d_lru is on another list.
+	 */
+	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_inc(nr_dentry_negative);
 }
 
@@ -1940,9 +1944,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 
 	spin_lock(&dentry->d_lock);
 	/*
-	 * Decrement negative dentry count if it was in the LRU list.
+	 * The negative counter only tracks dentries on the LRU. Don't dec if
+	 * d_lru is on another list.
 	 */
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if ((dentry->d_flags &
+	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_dec(nr_dentry_negative);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 81ca58c10b72..40cc5e62907c 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -58,6 +58,7 @@ static void jffs2_i_init_once(void *foo)
 	struct jffs2_inode_info *f = foo;
 
 	mutex_init(&f->sem);
+	f->target = NULL;
 	inode_init_once(&f->vfs_inode);
 }
 
diff --git a/fs/locks.c b/fs/locks.c
index b0753c8871fb..843fa3d3375d 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1392,9 +1392,9 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 		locks_wake_up_blocks(left);
 	}
  out:
+	trace_posix_lock_inode(inode, request, error);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
-	trace_posix_lock_inode(inode, request, error);
 	/*
 	 * Free any unused locks.
 	 */
diff --git a/fs/nilfs2/alloc.c b/fs/nilfs2/alloc.c
index 279d945d4ebe..2dc5fae6a6ee 100644
--- a/fs/nilfs2/alloc.c
+++ b/fs/nilfs2/alloc.c
@@ -377,11 +377,12 @@ void *nilfs_palloc_block_get_entry(const struct inode *inode, __u64 nr,
  * @target: offset number of an entry in the group (start point)
  * @bsize: size in bits
  * @lock: spin lock protecting @bitmap
+ * @wrap: whether to wrap around
  */
 static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 					    unsigned long target,
 					    unsigned int bsize,
-					    spinlock_t *lock)
+					    spinlock_t *lock, bool wrap)
 {
 	int pos, end = bsize;
 
@@ -397,6 +398,8 @@ static int nilfs_palloc_find_available_slot(unsigned char *bitmap,
 
 		end = target;
 	}
+	if (!wrap)
+		return -ENOSPC;
 
 	/* wrap around */
 	for (pos = 0; pos < end; pos++) {
@@ -495,9 +498,10 @@ int nilfs_palloc_count_max_entries(struct inode *inode, u64 nused, u64 *nmaxp)
  * nilfs_palloc_prepare_alloc_entry - prepare to allocate a persistent object
  * @inode: inode of metadata file using this allocator
  * @req: nilfs_palloc_req structure exchanged for the allocation
+ * @wrap: whether to wrap around
  */
 int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
-				     struct nilfs_palloc_req *req)
+				     struct nilfs_palloc_req *req, bool wrap)
 {
 	struct buffer_head *desc_bh, *bitmap_bh;
 	struct nilfs_palloc_group_desc *desc;
@@ -516,7 +520,7 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 	entries_per_group = nilfs_palloc_entries_per_group(inode);
 
 	for (i = 0; i < ngroups; i += n) {
-		if (group >= ngroups) {
+		if (group >= ngroups && wrap) {
 			/* wrap around */
 			group = 0;
 			maxgroup = nilfs_palloc_group(inode, req->pr_entry_nr,
@@ -541,7 +545,13 @@ int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
 				bitmap = bitmap_kaddr + bh_offset(bitmap_bh);
 				pos = nilfs_palloc_find_available_slot(
 					bitmap, group_offset,
-					entries_per_group, lock);
+					entries_per_group, lock, wrap);
+				/*
+				 * Since the search for a free slot in the
+				 * second and subsequent bitmap blocks always
+				 * starts from the beginning, the wrap flag
+				 * only has an effect on the first search.
+				 */
 				if (pos >= 0) {
 					/* found a free entry */
 					nilfs_palloc_group_desc_add_entries(
diff --git a/fs/nilfs2/alloc.h b/fs/nilfs2/alloc.h
index 0303c3968cee..071fc620264e 100644
--- a/fs/nilfs2/alloc.h
+++ b/fs/nilfs2/alloc.h
@@ -50,8 +50,8 @@ struct nilfs_palloc_req {
 	struct buffer_head *pr_entry_bh;
 };
 
-int nilfs_palloc_prepare_alloc_entry(struct inode *,
-				     struct nilfs_palloc_req *);
+int nilfs_palloc_prepare_alloc_entry(struct inode *inode,
+				     struct nilfs_palloc_req *req, bool wrap);
 void nilfs_palloc_commit_alloc_entry(struct inode *,
 				     struct nilfs_palloc_req *);
 void nilfs_palloc_abort_alloc_entry(struct inode *, struct nilfs_palloc_req *);
diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
index 22b1ca5c379d..9b63cc42caac 100644
--- a/fs/nilfs2/dat.c
+++ b/fs/nilfs2/dat.c
@@ -75,7 +75,7 @@ int nilfs_dat_prepare_alloc(struct inode *dat, struct nilfs_palloc_req *req)
 {
 	int ret;
 
-	ret = nilfs_palloc_prepare_alloc_entry(dat, req);
+	ret = nilfs_palloc_prepare_alloc_entry(dat, req, true);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index 552234ef22fe..5c0e280c83ee 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -143,6 +143,9 @@ static bool nilfs_check_page(struct page *page)
 			goto Enamelen;
 		if (((offs + rec_len - 1) ^ offs) & ~(chunk_size-1))
 			goto Espan;
+		if (unlikely(p->inode &&
+			     NILFS_PRIVATE_INODE(le64_to_cpu(p->inode))))
+			goto Einumber;
 	}
 	if (offs != limit)
 		goto Eend;
@@ -168,6 +171,9 @@ static bool nilfs_check_page(struct page *page)
 	goto bad_entry;
 Espan:
 	error = "directory entry across blocks";
+	goto bad_entry;
+Einumber:
+	error = "disallowed inode number";
 bad_entry:
 	nilfs_error(sb,
 		    "bad entry in directory #%lu: %s - offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
@@ -390,11 +396,39 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
 
 struct nilfs_dir_entry *nilfs_dotdot(struct inode *dir, struct page **p)
 {
-	struct nilfs_dir_entry *de = nilfs_get_page(dir, 0, p);
+	struct page *page;
+	struct nilfs_dir_entry *de, *next_de;
+	size_t limit;
+	char *msg;
 
+	de = nilfs_get_page(dir, 0, &page);
 	if (IS_ERR(de))
 		return NULL;
-	return nilfs_next_entry(de);
+
+	limit = nilfs_last_byte(dir, 0);  /* is a multiple of chunk size */
+	if (unlikely(!limit || le64_to_cpu(de->inode) != dir->i_ino ||
+		     !nilfs_match(1, ".", de))) {
+		msg = "missing '.'";
+		goto fail;
+	}
+
+	next_de = nilfs_next_entry(de);
+	/*
+	 * If "next_de" has not reached the end of the chunk, there is
+	 * at least one more record.  Check whether it matches "..".
+	 */
+	if (unlikely((char *)next_de == (char *)de + nilfs_chunk_size(dir) ||
+		     !nilfs_match(2, "..", next_de))) {
+		msg = "missing '..'";
+		goto fail;
+	}
+	*p = page;
+	return next_de;
+
+fail:
+	nilfs_error(dir->i_sb, "directory #%lu %s", dir->i_ino, msg);
+	nilfs_put_page(page);
+	return NULL;
 }
 
 ino_t nilfs_inode_by_name(struct inode *dir, const struct qstr *qstr)
diff --git a/fs/nilfs2/ifile.c b/fs/nilfs2/ifile.c
index 02727ed3a7c6..9ee8d006f1a2 100644
--- a/fs/nilfs2/ifile.c
+++ b/fs/nilfs2/ifile.c
@@ -55,13 +55,10 @@ int nilfs_ifile_create_inode(struct inode *ifile, ino_t *out_ino,
 	struct nilfs_palloc_req req;
 	int ret;
 
-	req.pr_entry_nr = 0;  /*
-			       * 0 says find free inode from beginning
-			       * of a group. dull code!!
-			       */
+	req.pr_entry_nr = NILFS_FIRST_INO(ifile->i_sb);
 	req.pr_entry_bh = NULL;
 
-	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req);
+	ret = nilfs_palloc_prepare_alloc_entry(ifile, &req, false);
 	if (!ret) {
 		ret = nilfs_palloc_get_entry_block(ifile, req.pr_entry_nr, 1,
 						   &req.pr_entry_bh);
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index ace27a89fbb0..3f3971e0292d 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -116,9 +116,15 @@ enum {
 #define NILFS_FIRST_INO(sb) (((struct the_nilfs *)sb->s_fs_info)->ns_first_ino)
 
 #define NILFS_MDT_INODE(sb, ino) \
-	((ino) < NILFS_FIRST_INO(sb) && (NILFS_MDT_INO_BITS & BIT(ino)))
+	((ino) < NILFS_USER_INO && (NILFS_MDT_INO_BITS & BIT(ino)))
 #define NILFS_VALID_INODE(sb, ino) \
-	((ino) >= NILFS_FIRST_INO(sb) || (NILFS_SYS_INO_BITS & BIT(ino)))
+	((ino) >= NILFS_FIRST_INO(sb) ||				\
+	 ((ino) < NILFS_USER_INO && (NILFS_SYS_INO_BITS & BIT(ino))))
+
+#define NILFS_PRIVATE_INODE(ino) ({					\
+	ino_t __ino = (ino);						\
+	((__ino) < NILFS_USER_INO && (__ino) != NILFS_ROOT_INO &&	\
+	 (__ino) != NILFS_SKETCH_INO); })
 
 /**
  * struct nilfs_transaction_info: context information for synchronization
diff --git a/fs/nilfs2/the_nilfs.c b/fs/nilfs2/the_nilfs.c
index a8374d89da7c..09ba8bbaf6ca 100644
--- a/fs/nilfs2/the_nilfs.c
+++ b/fs/nilfs2/the_nilfs.c
@@ -452,6 +452,12 @@ static int nilfs_store_disk_layout(struct the_nilfs *nilfs,
 	}
 
 	nilfs->ns_first_ino = le32_to_cpu(sbp->s_first_ino);
+	if (nilfs->ns_first_ino < NILFS_USER_INO) {
+		nilfs_err(nilfs->ns_sb,
+			  "too small lower limit for non-reserved inode numbers: %u",
+			  nilfs->ns_first_ino);
+		return -EINVAL;
+	}
 
 	nilfs->ns_blocks_per_segment = le32_to_cpu(sbp->s_blocks_per_segment);
 	if (nilfs->ns_blocks_per_segment < NILFS_SEG_MIN_BLOCKS) {
diff --git a/fs/nilfs2/the_nilfs.h b/fs/nilfs2/the_nilfs.h
index 01914089e76d..c1eea04052e6 100644
--- a/fs/nilfs2/the_nilfs.h
+++ b/fs/nilfs2/the_nilfs.h
@@ -182,7 +182,7 @@ struct the_nilfs {
 	unsigned long		ns_nrsvsegs;
 	unsigned long		ns_first_data_block;
 	int			ns_inode_size;
-	int			ns_first_ino;
+	unsigned int		ns_first_ino;
 	u32			ns_crc_seed;
 
 	/* /sys/fs/<nilfs>/<device> */
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 2f2e430461b2..b48aef43b51d 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -200,7 +200,8 @@ static int orangefs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		     (long)new_op->downcall.resp.statfs.files_avail);
 
 	buf->f_type = sb->s_magic;
-	memcpy(&buf->f_fsid, &ORANGEFS_SB(sb)->fs_id, sizeof(buf->f_fsid));
+	buf->f_fsid.val[0] = ORANGEFS_SB(sb)->fs_id;
+	buf->f_fsid.val[1] = ORANGEFS_SB(sb)->id;
 	buf->f_bsize = new_op->downcall.resp.statfs.block_size;
 	buf->f_namelen = ORANGEFS_NAME_MAX;
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a75faf437e75..340f4fef5b5a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1800,6 +1800,7 @@ int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
 int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
 void sock_map_unhash(struct sock *sk);
+void sock_map_destroy(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
 static inline int sock_map_prog_update(struct bpf_map *map,
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 08eb06301791..3982c2dc541e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -269,6 +269,18 @@
  */
 #define __section(section)              __attribute__((__section__(section)))
 
+/*
+ * Optional: only supported since gcc >= 12
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-uninitialized-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#uninitialized
+ */
+#if __has_attribute(__uninitialized__)
+# define __uninitialized		__attribute__((__uninitialized__))
+#else
+# define __uninitialized
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-unused-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-unused-type-attribute
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2fd321da5c4b..5554d26f91d8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -171,8 +171,6 @@ int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
                            size_t hdr_bytes);
 int __efi_capsule_setup_info(struct capsule_info *cap_info);
 
-typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
-
 /*
  * Types and defines for Time Services
  */
@@ -609,10 +607,6 @@ efi_guid_to_str(efi_guid_t *guid, char *out)
 }
 
 extern void efi_init (void);
-extern void *efi_get_pal_addr (void);
-extern void efi_map_pal_code (void);
-extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
-extern void efi_gettimeofday (struct timespec64 *ts);
 #ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #else
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bb8467cd11ae..34f242105be2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -93,7 +93,13 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 {
 	const struct path *path = &file->f_path;
 
-	if (file->f_mode & FMODE_NONOTIFY)
+	/*
+	 * FMODE_NONOTIFY are fds generated by fanotify itself which should not
+	 * generate new events. We also don't want to generate events for
+	 * FMODE_PATH fds (involves open & close events) as they are just
+	 * handle creation / destruction events and not "real" file events.
+	 */
+	if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
 		return 0;
 
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 07abcd384975..35bb13ce1faf 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -370,7 +370,7 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
-	 void **lsmrule)
+	 void **lsmrule, gfp_t gfp)
 LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
 LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule)
 LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ffae2b330818..71150fb1cb2a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1353,8 +1353,9 @@ static inline int subsection_map_index(unsigned long pfn)
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
 {
 	int idx = subsection_map_index(pfn);
+	struct mem_section_usage *usage = READ_ONCE(ms->usage);
 
-	return test_bit(idx, READ_ONCE(ms->usage)->subsection_map);
+	return usage ? test_bit(idx, usage->subsection_map) : 0;
 }
 #else
 static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
diff --git a/include/linux/security.h b/include/linux/security.h
index 5b61aa19fac6..e32e040f094c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1856,7 +1856,8 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 #ifdef CONFIG_SECURITY
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			     gfp_t gfp);
 int security_audit_rule_known(struct audit_krule *krule);
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
 void security_audit_rule_free(void *lsmrule);
@@ -1864,7 +1865,7 @@ void security_audit_rule_free(void *lsmrule);
 #else
 
 static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
-					   void **lsmrule)
+					   void **lsmrule, gfp_t gfp)
 {
 	return 0;
 }
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 1138dd3071db..e2af013ec05f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -98,6 +98,7 @@ struct sk_psock {
 	spinlock_t			link_lock;
 	refcount_t			refcnt;
 	void (*saved_unhash)(struct sock *sk);
+	void (*saved_destroy)(struct sock *sk);
 	void (*saved_close)(struct sock *sk, long timeout);
 	void (*saved_write_space)(struct sock *sk);
 	struct proto			*sk_proto;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 333b3bcfc545..a5b43f25609e 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -521,7 +521,8 @@ static struct audit_entry *audit_data_to_entry(struct audit_rule_data *data,
 			entry->rule.buflen += f_val;
 			f->lsm_str = str;
 			err = security_audit_rule_init(f->type, f->op, str,
-						       (void **)&f->lsm_rule);
+						       (void **)&f->lsm_rule,
+						       GFP_KERNEL);
 			/* Keep currently invalid fields around in case they
 			 * become valid after a policy reload. */
 			if (err == -EINVAL) {
@@ -790,7 +791,7 @@ static inline int audit_dupe_lsm_field(struct audit_field *df,
 
 	/* our own (refreshed) copy of lsm_rule */
 	ret = security_audit_rule_init(df->type, df->op, df->lsm_str,
-				       (void **)&df->lsm_rule);
+				       (void **)&df->lsm_rule, GFP_KERNEL);
 	/* Keep currently invalid fields around in case they
 	 * become valid after a policy reload. */
 	if (ret == -EINVAL) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ad115ccc2fe0..60db311480d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2807,6 +2807,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 						continue;
 					if (type == STACK_MISC)
 						continue;
+					if (type == STACK_INVALID && env->allow_uninit_stack)
+						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
 						off, i, size);
 					return -EACCES;
@@ -2844,6 +2846,8 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				continue;
 			if (type == STACK_ZERO)
 				continue;
+			if (type == STACK_INVALID && env->allow_uninit_stack)
+				continue;
 			verbose(env, "invalid read from stack off %d+%d size %d\n",
 				off, i, size);
 			return -EACCES;
@@ -4300,7 +4304,8 @@ static int check_stack_range_initialized(
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
-		if (*stype == STACK_ZERO) {
+		if ((*stype == STACK_ZERO) ||
+		    (*stype == STACK_INVALID && env->allow_uninit_stack)) {
 			if (clobber) {
 				/* helper can write anything into the stack */
 				*stype = STACK_MISC;
@@ -9492,6 +9497,10 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 		if (old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_INVALID)
 			continue;
 
+		if (env->allow_uninit_stack &&
+		    old->stack[spi].slot_type[i % BPF_REG_SIZE] == STACK_MISC)
+			continue;
+
 		/* explored stack has more populated slots than current stack
 		 * and these slots were used
 		 */
diff --git a/kernel/exit.c b/kernel/exit.c
index bacdaf980933..af9c8e794e4d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -432,6 +432,8 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 * Search through everything else, we should not get here often.
 	 */
 	for_each_process(g) {
+		if (atomic_read(&mm->mm_users) <= 1)
+			break;
 		if (g->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(g, c) {
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 71e5c5853099..d18da926b2cd 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -76,7 +76,6 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	time_remaining = wait_for_completion_timeout(&try_completion,
 						     kunit_test_timeout());
 	if (time_remaining == 0) {
-		kunit_err(test, "try timed out\n");
 		try_catch->try_result = -ETIMEDOUT;
 	}
 
@@ -89,6 +88,8 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 		try_catch->try_result = 0;
 	else if (exit_code == -EINTR)
 		kunit_err(test, "wake_up_process() was never called\n");
+	else if (exit_code == -ETIMEDOUT)
+		kunit_err(test, "try timed out\n");
 	else if (exit_code)
 		kunit_err(test, "Unknown error: %d\n", exit_code);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index e8d7d3c2bfcb..b2c916474855 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -432,13 +432,20 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 	else
 		bg_thresh = (bg_ratio * available_memory) / PAGE_SIZE;
 
-	if (bg_thresh >= thresh)
-		bg_thresh = thresh / 2;
 	tsk = current;
 	if (rt_task(tsk)) {
 		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	if (thresh > UINT_MAX)
+		thresh = UINT_MAX;
+	/* This makes sure bg_thresh is within 32-bits as well */
+	if (bg_thresh >= thresh)
+		bg_thresh = thresh / 2;
 	dtc->thresh = thresh;
 	dtc->bg_thresh = bg_thresh;
 
@@ -488,7 +495,11 @@ static unsigned long node_dirty_limit(struct pglist_data *pgdat)
 	if (rt_task(tsk))
 		dirty += dirty / 4;
 
-	return dirty;
+	/*
+	 * Dirty throttling logic assumes the limits in page units fit into
+	 * 32-bits. This gives 16TB dirty limits max which is hopefully enough.
+	 */
+	return min_t(unsigned long, dirty, UINT_MAX);
 }
 
 /**
@@ -524,10 +535,17 @@ int dirty_background_bytes_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int ret;
+	unsigned long old_bytes = dirty_background_bytes;
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
+	if (ret == 0 && write) {
+		if (DIV_ROUND_UP(dirty_background_bytes, PAGE_SIZE) >
+								UINT_MAX) {
+			dirty_background_bytes = old_bytes;
+			return -ERANGE;
+		}
 		dirty_background_ratio = 0;
+	}
 	return ret;
 }
 
@@ -553,6 +571,10 @@ int dirty_bytes_handler(struct ctl_table *table, int write,
 
 	ret = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 	if (ret == 0 && write && vm_dirty_bytes != old_bytes) {
+		if (DIV_ROUND_UP(vm_dirty_bytes, PAGE_SIZE) > UINT_MAX) {
+			vm_dirty_bytes = old_bytes;
+			return -ERANGE;
+		}
 		writeback_set_ratelimit();
 		vm_dirty_ratio = 0;
 	}
@@ -1524,7 +1546,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	 */
 	dtc->wb_thresh = __wb_calc_thresh(dtc);
 	dtc->wb_bg_thresh = dtc->thresh ?
-		div64_u64(dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
+		div_u64((u64)dtc->wb_thresh * dtc->bg_thresh, dtc->thresh) : 0;
 
 	/*
 	 * In order to avoid the stacked BDI deadlock we need
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index ef5c174102d5..82d3f1204ee4 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1014,13 +1014,19 @@ static void delayed_work(struct work_struct *work)
 	struct ceph_mon_client *monc =
 		container_of(work, struct ceph_mon_client, delayed_work.work);
 
-	dout("monc delayed_work\n");
 	mutex_lock(&monc->mutex);
+	dout("%s mon%d\n", __func__, monc->cur_mon);
+	if (monc->cur_mon < 0) {
+		goto out;
+	}
+
 	if (monc->hunting) {
 		dout("%s continuing hunt\n", __func__);
 		reopen_session(monc);
 	} else {
 		int is_auth = ceph_auth_is_authenticated(monc->auth);
+
+		dout("%s is_authed %d\n", __func__, is_auth);
 		if (ceph_con_keepalive_expired(&monc->con,
 					       CEPH_MONC_PING_TIMEOUT)) {
 			dout("monc keepalive timeout\n");
@@ -1045,6 +1051,8 @@ static void delayed_work(struct work_struct *work)
 		}
 	}
 	__schedule_delayed(monc);
+
+out:
 	mutex_unlock(&monc->mutex);
 }
 
@@ -1157,13 +1165,15 @@ EXPORT_SYMBOL(ceph_monc_init);
 void ceph_monc_stop(struct ceph_mon_client *monc)
 {
 	dout("stop\n");
-	cancel_delayed_work_sync(&monc->delayed_work);
 
 	mutex_lock(&monc->mutex);
 	__close_session(monc);
+	monc->hunting = false;
 	monc->cur_mon = -1;
 	mutex_unlock(&monc->mutex);
 
+	cancel_delayed_work_sync(&monc->delayed_work);
+
 	/*
 	 * flush msgr queue before we destroy ourselves to ensure that:
 	 *  - any work that references our embedded con is finished.
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index bb4fbc60b272..51792dda1b73 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -599,6 +599,7 @@ struct sk_psock *sk_psock_init(struct sock *sk, int node)
 	psock->eval = __SK_NONE;
 	psock->sk_proto = prot;
 	psock->saved_unhash = prot->unhash;
+	psock->saved_destroy = prot->destroy;
 	psock->saved_close = prot->close;
 	psock->saved_write_space = sk->sk_write_space;
 
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 52e395a189df..d1d0ee2dbfaa 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1566,6 +1566,28 @@ void sock_map_unhash(struct sock *sk)
 	saved_unhash(sk);
 }
 
+void sock_map_destroy(struct sock *sk)
+{
+	void (*saved_destroy)(struct sock *sk);
+	struct sk_psock *psock;
+
+	rcu_read_lock();
+	psock = sk_psock_get(sk);
+	if (unlikely(!psock)) {
+		rcu_read_unlock();
+		if (sk->sk_prot->destroy)
+			sk->sk_prot->destroy(sk);
+		return;
+	}
+
+	saved_destroy = psock->saved_destroy;
+	sock_map_remove_links(sk, psock);
+	rcu_read_unlock();
+	sk_psock_put(sk, psock);
+	saved_destroy(sk);
+}
+EXPORT_SYMBOL_GPL(sock_map_destroy);
+
 void sock_map_close(struct sock *sk, long timeout)
 {
 	void (*saved_close)(struct sock *sk, long timeout);
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index fb676f349455..470582a70ccb 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -36,6 +36,8 @@ static int linkstate_get_sqi(struct net_device *dev)
 	mutex_lock(&phydev->lock);
 	if (!phydev->drv || !phydev->drv->get_sqi)
 		ret = -EOPNOTSUPP;
+	else if (!phydev->link)
+		ret = -ENETDOWN;
 	else
 		ret = phydev->drv->get_sqi(phydev);
 	mutex_unlock(&phydev->lock);
@@ -54,6 +56,8 @@ static int linkstate_get_sqi_max(struct net_device *dev)
 	mutex_lock(&phydev->lock);
 	if (!phydev->drv || !phydev->drv->get_sqi_max)
 		ret = -EOPNOTSUPP;
+	else if (!phydev->link)
+		ret = -ENETDOWN;
 	else
 		ret = phydev->drv->get_sqi_max(phydev);
 	mutex_unlock(&phydev->lock);
@@ -61,6 +65,17 @@ static int linkstate_get_sqi_max(struct net_device *dev)
 	return ret;
 };
 
+static bool linkstate_sqi_critical_error(int sqi)
+{
+	return sqi < 0 && sqi != -EOPNOTSUPP && sqi != -ENETDOWN;
+}
+
+static bool linkstate_sqi_valid(struct linkstate_reply_data *data)
+{
+	return data->sqi >= 0 && data->sqi_max >= 0 &&
+	       data->sqi <= data->sqi_max;
+}
+
 static int linkstate_get_link_ext_state(struct net_device *dev,
 					struct linkstate_reply_data *data)
 {
@@ -92,12 +107,12 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 	data->link = __ethtool_get_link(dev);
 
 	ret = linkstate_get_sqi(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi = ret;
 
 	ret = linkstate_get_sqi_max(dev);
-	if (ret < 0 && ret != -EOPNOTSUPP)
+	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi_max = ret;
 
@@ -122,11 +137,10 @@ static int linkstate_reply_size(const struct ethnl_req_info *req_base,
 	len = nla_total_size(sizeof(u8)) /* LINKSTATE_LINK */
 		+ 0;
 
-	if (data->sqi != -EOPNOTSUPP)
-		len += nla_total_size(sizeof(u32));
-
-	if (data->sqi_max != -EOPNOTSUPP)
-		len += nla_total_size(sizeof(u32));
+	if (linkstate_sqi_valid(data)) {
+		len += nla_total_size(sizeof(u32)); /* LINKSTATE_SQI */
+		len += nla_total_size(sizeof(u32)); /* LINKSTATE_SQI_MAX */
+	}
 
 	if (data->link_ext_state_provided)
 		len += nla_total_size(sizeof(u8)); /* LINKSTATE_EXT_STATE */
@@ -147,13 +161,14 @@ static int linkstate_fill_reply(struct sk_buff *skb,
 	    nla_put_u8(skb, ETHTOOL_A_LINKSTATE_LINK, !!data->link))
 		return -EMSGSIZE;
 
-	if (data->sqi != -EOPNOTSUPP &&
-	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
-		return -EMSGSIZE;
+	if (linkstate_sqi_valid(data)) {
+		if (nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI, data->sqi))
+			return -EMSGSIZE;
 
-	if (data->sqi_max != -EOPNOTSUPP &&
-	    nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI_MAX, data->sqi_max))
-		return -EMSGSIZE;
+		if (nla_put_u32(skb, ETHTOOL_A_LINKSTATE_SQI_MAX,
+				data->sqi_max))
+			return -EMSGSIZE;
+	}
 
 	if (data->link_ext_state_provided) {
 		if (nla_put_u8(skb, ETHTOOL_A_LINKSTATE_EXT_STATE,
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 27a5a7d66d18..b9df76f6571c 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1275,6 +1275,7 @@ static int inet_diag_dump_compat(struct sk_buff *skb,
 	req.sdiag_family = AF_UNSPEC; /* compatibility */
 	req.sdiag_protocol = inet_diag_type2proto(cb->nlh->nlmsg_type);
 	req.idiag_ext = rc->idiag_ext;
+	req.pad = 0;
 	req.idiag_states = rc->idiag_states;
 	req.id = rc->id;
 
@@ -1290,6 +1291,7 @@ static int inet_diag_get_exact_compat(struct sk_buff *in_skb,
 	req.sdiag_family = rc->idiag_family;
 	req.sdiag_protocol = inet_diag_type2proto(nlh->nlmsg_type);
 	req.idiag_ext = rc->idiag_ext;
+	req.pad = 0;
 	req.idiag_states = rc->idiag_states;
 	req.id = rc->id;
 
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index d0ca1fc325cd..f909e440bb22 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -582,6 +582,7 @@ static void tcp_bpf_rebuild_protos(struct proto prot[TCP_BPF_NUM_CFGS],
 				   struct proto *base)
 {
 	prot[TCP_BPF_BASE]			= *base;
+	prot[TCP_BPF_BASE].destroy		= sock_map_destroy;
 	prot[TCP_BPF_BASE].close		= sock_map_close;
 	prot[TCP_BPF_BASE].recvmsg		= tcp_bpf_recvmsg;
 	prot[TCP_BPF_BASE].stream_memory_read	= tcp_bpf_stream_read;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 512f8dc051c6..06c03b21500f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2084,8 +2084,16 @@ void tcp_clear_retrans(struct tcp_sock *tp)
 static inline void tcp_init_undo(struct tcp_sock *tp)
 {
 	tp->undo_marker = tp->snd_una;
+
 	/* Retransmission still in flight may cause DSACKs later. */
-	tp->undo_retrans = tp->retrans_out ? : -1;
+	/* First, account for regular retransmits in flight: */
+	tp->undo_retrans = tp->retrans_out;
+	/* Next, account for TLP retransmits in flight: */
+	if (tp->tlp_high_seq && tp->tlp_retrans)
+		tp->undo_retrans++;
+	/* Finally, avoid 0, because undo_retrans==0 means "can undo now": */
+	if (!tp->undo_retrans)
+		tp->undo_retrans = -1;
 }
 
 static bool tcp_is_rack(const struct sock *sk)
@@ -2164,6 +2172,7 @@ void tcp_enter_loss(struct sock *sk)
 
 	tcp_set_ca_state(sk, TCP_CA_Loss);
 	tp->high_seq = tp->snd_nxt;
+	tp->tlp_high_seq = 0;
 	tcp_ecn_queue_cwr(tp);
 
 	/* F-RTO RFC5682 sec 3.1 step 1: retransmit SND.UNA if no previous
@@ -2993,7 +3002,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 			return;
 
 		if (tcp_try_undo_dsack(sk))
-			tcp_try_keep_open(sk);
+			tcp_try_to_open(sk, flag);
 
 		tcp_identify_packet_loss(sk, ack_flag);
 		if (icsk->icsk_ca_state != TCP_CA_Recovery) {
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index f823a15b973c..95b5ac082a2f 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -619,6 +619,7 @@ static const struct nla_policy tcp_metrics_nl_policy[TCP_METRICS_ATTR_MAX + 1] =
 	[TCP_METRICS_ATTR_ADDR_IPV4]	= { .type = NLA_U32, },
 	[TCP_METRICS_ATTR_ADDR_IPV6]	= { .type = NLA_BINARY,
 					    .len = sizeof(struct in6_addr), },
+	[TCP_METRICS_ATTR_SADDR_IPV4]	= { .type = NLA_U32, },
 	/* Following attributes are not received for GET/DEL,
 	 * we keep them for reference
 	 */
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 5c7e10939dd9..316a4ef4db37 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -440,17 +440,34 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 				     const struct sk_buff *skb)
 {
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+	u32 user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	const int timeout = TCP_RTO_MAX * 2;
-	u32 rcv_delta, rtx_delta;
-
-	rcv_delta = inet_csk(sk)->icsk_timeout - tp->rcv_tstamp;
-	if (rcv_delta <= timeout)
-		return false;
+	int timeout = TCP_RTO_MAX * 2;
+	u32 rtx_delta;
+	s32 rcv_delta;
 
 	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
 			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
 
+	if (user_timeout) {
+		/* If user application specified a TCP_USER_TIMEOUT,
+		 * it does not want win 0 packets to 'reset the timer'
+		 * while retransmits are not making progress.
+		 */
+		if (rtx_delta > user_timeout)
+			return true;
+		timeout = min_t(u32, timeout, msecs_to_jiffies(user_timeout));
+	}
+
+	/* Note: timer interrupt might have been delayed by at least one jiffy,
+	 * and tp->rcv_tstamp might very well have been written recently.
+	 * rcv_delta can thus be negative.
+	 */
+	rcv_delta = icsk->icsk_timeout - tp->rcv_tstamp;
+	if (rcv_delta <= timeout)
+		return false;
+
 	return rtx_delta > timeout;
 }
 
@@ -492,8 +509,6 @@ void tcp_retransmit_timer(struct sock *sk)
 	if (WARN_ON_ONCE(!skb))
 		return;
 
-	tp->tlp_high_seq = 0;
-
 	if (!tp->snd_wnd && !sock_flag(sk, SOCK_DEAD) &&
 	    !((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))) {
 		/* Receiver dastardly shrinks window. Our retransmits
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index da9015efb45e..6ad25dc9710c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -317,6 +317,8 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 			goto fail_unlock;
 		}
 
+		sock_set_flag(sk, SOCK_RCU_FREE);
+
 		sk_add_node_rcu(sk, &hslot->head);
 		hslot->count++;
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
@@ -333,7 +335,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 		hslot2->count++;
 		spin_unlock(&hslot2->lock);
 	}
-	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	error = 0;
 fail_unlock:
 	spin_unlock_bh(&hslot->lock);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8a6f4cdd5a48..ac09d4543f3e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4107,7 +4107,7 @@ static void addrconf_dad_work(struct work_struct *w)
 			if (!ipv6_generate_eui64(addr.s6_addr + 8, idev->dev) &&
 			    ipv6_addr_equal(&ifp->addr, &addr)) {
 				/* DAD failed for link-local based on MAC */
-				idev->cnf.disable_ipv6 = 1;
+				WRITE_ONCE(idev->cnf.disable_ipv6, 1);
 
 				pr_info("%s: IPv6 being disabled!\n",
 					ifp->idev->dev->name);
@@ -6220,7 +6220,8 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 		idev = __in6_dev_get(dev);
 		if (idev) {
 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
-			idev->cnf.disable_ipv6 = newf;
+
+			WRITE_ONCE(idev->cnf.disable_ipv6, newf);
 			if (changed)
 				dev_disable_change(idev);
 		}
@@ -6237,7 +6238,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 
 	net = (struct net *)table->extra2;
 	old = *p;
-	*p = newf;
+	WRITE_ONCE(*p, newf);
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
 		rtnl_unlock();
@@ -6245,7 +6246,7 @@ static int addrconf_disable_ipv6(struct ctl_table *table, int *p, int newf)
 	}
 
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
-		net->ipv6.devconf_dflt->disable_ipv6 = newf;
+		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
 	} else if ((!newf) ^ (!old))
 		dev_disable_change((struct inet6_dev *)table->extra1);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 4eb9fbfdce33..8cf5b10eee69 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -165,7 +165,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	__IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_IN, skb->len);
 
 	if ((skb = skb_share_check(skb, GFP_ATOMIC)) == NULL ||
-	    !idev || unlikely(idev->cnf.disable_ipv6)) {
+	    !idev || unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INDISCARDS);
 		goto drop;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4126be15e0d9..32512b8ca5e7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -240,7 +240,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(idev->cnf.disable_ipv6)) {
+	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb(skb);
 		return 0;
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index c6d6a6fe9602..a59a8ad38721 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1038,6 +1038,14 @@ static int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		 */
 		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
 			goto drop;
+
+		/* The ct may be dropped if a clash has been resolved,
+		 * so it's necessary to retrieve it from skb again to
+		 * prevent UAF.
+		 */
+		ct = nf_ct_get(skb, &ctinfo);
+		if (!ct)
+			skip_add = true;
 	}
 
 	if (!skip_add)
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index bc4fe944ef85..79cf4cda2cf6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -6994,6 +6994,7 @@ static int sctp_getsockopt_assoc_ids(struct sock *sk, int len,
 	struct sctp_sock *sp = sctp_sk(sk);
 	struct sctp_association *asoc;
 	struct sctp_assoc_ids *ids;
+	size_t ids_size;
 	u32 num = 0;
 
 	if (sctp_style(sk, TCP))
@@ -7006,11 +7007,11 @@ static int sctp_getsockopt_assoc_ids(struct sock *sk, int len,
 		num++;
 	}
 
-	if (len < sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * num)
+	ids_size = struct_size(ids, gaids_assoc_id, num);
+	if (len < ids_size)
 		return -EINVAL;
 
-	len = sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * num;
-
+	len = ids_size;
 	ids = kmalloc(len, GFP_USER | __GFP_NOWARN);
 	if (unlikely(!ids))
 		return -ENOMEM;
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 3a1ffd84eac2..bf534a323fdd 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -213,7 +213,7 @@ kallsyms_step()
 	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
 	kallsyms ${kallsyms_vmlinux} ${kallsyms_S}
 
-	info AS ${kallsyms_S}
+	info AS ${kallsymso}
 	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} \
 	      ${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL} \
 	      -c -o ${kallsymso} ${kallsyms_S}
diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
index 704b0c895605..963df28584ee 100644
--- a/security/apparmor/audit.c
+++ b/security/apparmor/audit.c
@@ -173,7 +173,7 @@ void aa_audit_rule_free(void *vrule)
 	}
 }
 
-int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
+int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp)
 {
 	struct aa_audit_rule *rule;
 
@@ -186,14 +186,14 @@ int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		return -EINVAL;
 	}
 
-	rule = kzalloc(sizeof(struct aa_audit_rule), GFP_KERNEL);
+	rule = kzalloc(sizeof(struct aa_audit_rule), gfp);
 
 	if (!rule)
 		return -ENOMEM;
 
 	/* Currently rules are treated as coming from the root ns */
 	rule->label = aa_label_parse(&root_ns->unconfined->label, rulestr,
-				     GFP_KERNEL, true, false);
+				     gfp, true, false);
 	if (IS_ERR(rule->label)) {
 		int err = PTR_ERR(rule->label);
 		aa_audit_rule_free(rule);
diff --git a/security/apparmor/include/audit.h b/security/apparmor/include/audit.h
index 18519a4eb67e..f325f1bef8d6 100644
--- a/security/apparmor/include/audit.h
+++ b/security/apparmor/include/audit.h
@@ -186,7 +186,7 @@ static inline int complain_error(int error)
 }
 
 void aa_audit_rule_free(void *vrule);
-int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
+int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule, gfp_t gfp);
 int aa_audit_rule_known(struct audit_krule *rule);
 int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6ebefec616e4..14b77a71c16c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -420,7 +420,7 @@ static inline void ima_free_modsig(struct modsig *modsig)
 #else
 
 static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-				       void **lsmrule)
+				       void **lsmrule, gfp_t gfp)
 {
 	return -EINVAL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 4f5d44037081..8d69b2e27936 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -349,7 +349,8 @@ static void ima_free_rule(struct ima_rule_entry *entry)
 	kfree(entry);
 }
 
-static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
+static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry,
+						gfp_t gfp)
 {
 	struct ima_rule_entry *nentry;
 	int i;
@@ -358,7 +359,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), gfp);
 	if (!nentry)
 		return NULL;
 
@@ -373,7 +374,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
-				     &nentry->lsm[i].rule);
+				     &nentry->lsm[i].rule,
+				     gfp);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				nentry->lsm[i].args_p);
@@ -386,7 +388,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	int i;
 	struct ima_rule_entry *nentry;
 
-	nentry = ima_lsm_copy_rule(entry);
+	nentry = ima_lsm_copy_rule(entry, GFP_KERNEL);
 	if (!nentry)
 		return -ENOMEM;
 
@@ -573,7 +575,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 		}
 
 		if (rc == -ESTALE && !rule_reinitialized) {
-			lsm_rule = ima_lsm_copy_rule(rule);
+			lsm_rule = ima_lsm_copy_rule(rule, GFP_ATOMIC);
 			if (lsm_rule) {
 				rule_reinitialized = true;
 				goto retry;
@@ -990,7 +992,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 	entry->lsm[lsm_rule].type = audit_type;
 	result = ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
 				      entry->lsm[lsm_rule].args_p,
-				      &entry->lsm[lsm_rule].rule);
+				      &entry->lsm[lsm_rule].rule,
+				      GFP_KERNEL);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
diff --git a/security/security.c b/security/security.c
index 0bbcb100ba8e..f836f292ea16 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2545,9 +2545,11 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule,
+			     gfp_t gfp)
 {
-	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule,
+			     gfp);
 }
 
 int security_audit_rule_known(struct audit_krule *krule)
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index 073a3d34a0d2..72af85ff96a4 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -18,12 +18,14 @@
  *	@op: the operater the rule uses
  *	@rulestr: the text "target" of the rule
  *	@rule: pointer to the new rule structure returned via this
+ *	@gfp: GFP flag used for kmalloc
  *
  *	Returns 0 if successful, -errno if not.  On success, the rule structure
  *	will be allocated internally.  The caller must free this structure with
  *	selinux_audit_rule_free() after use.
  */
-int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule);
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rule,
+			    gfp_t gfp);
 
 /**
  *	selinux_audit_rule_free - free an selinux audit rule structure.
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 3db8bd2158d9..a01e768337cd 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3542,7 +3542,8 @@ void selinux_audit_rule_free(void *vrule)
 	}
 }
 
-int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
+			    gfp_t gfp)
 {
 	struct selinux_state *state = &selinux_state;
 	struct selinux_policy *policy;
@@ -3583,7 +3584,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 		return -EINVAL;
 	}
 
-	tmprule = kzalloc(sizeof(struct selinux_audit_rule), GFP_KERNEL);
+	tmprule = kzalloc(sizeof(struct selinux_audit_rule), gfp);
 	if (!tmprule)
 		return -ENOMEM;
 
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 750f6007bbbb..8c790563b33a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4490,11 +4490,13 @@ static int smack_post_notification(const struct cred *w_cred,
  * @op: required testing operator (=, !=, >, <, ...)
  * @rulestr: smack label to be audited
  * @vrule: pointer to save our own audit rule representation
+ * @gfp: type of the memory for the allocation
  *
  * Prepare to audit cases where (@field @op @rulestr) is true.
  * The label to be audited is created if necessay.
  */
-static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
+static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
+				 gfp_t gfp)
 {
 	struct smack_known *skp;
 	char **rule = (char **)vrule;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5c5a144e707f..669937bae570 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9057,6 +9057,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x841c, "HP Pavilion 15-CK0xx", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8497, "HP Envy x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84a6, "HP 250 G7 Notebook PC", ALC269_FIXUP_HP_LINE1_MIC1_LED),
 	SND_PCI_QUIRK(0x103c, 0x84ae, "HP 15-db0403ng", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x84da, "HP OMEN dc0019-ur", ALC295_FIXUP_HP_OMEN),
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
@@ -9189,6 +9190,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x10ec, 0x11bc, "VAIO VJFE-IL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x10ec, 0x1230, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
@@ -9396,6 +9398,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1945, "Redmi G", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1947, "RedmiBook Air", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
+	SND_PCI_QUIRK(0x2782, 0x0214, "VAIO VJFE-CL", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0x0232, "CHUWI CoreBook XPro", ALC269VB_FIXUP_CHUWI_COREBOOK_XPRO),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
@@ -10807,6 +10810,7 @@ enum {
 	ALC897_FIXUP_LENOVO_HEADSET_MODE,
 	ALC897_FIXUP_HEADSET_MIC_PIN2,
 	ALC897_FIXUP_UNIS_H3C_X500S,
+	ALC897_FIXUP_HEADSET_MIC_PIN3,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -11253,10 +11257,18 @@ static const struct hda_fixup alc662_fixups[] = {
 			{}
 		},
 	},
+	[ALC897_FIXUP_HEADSET_MIC_PIN3] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11050 }, /* use as headset mic */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1019, 0x9087, "ECS", ALC662_FIXUP_ASUS_MODE2),
+	SND_PCI_QUIRK(0x1019, 0x9859, "JP-IK LEAP W502", ALC897_FIXUP_HEADSET_MIC_PIN3),
 	SND_PCI_QUIRK(0x1025, 0x022f, "Acer Aspire One", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0241, "Packard Bell DOTS", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0308, "Acer Aspire 8942G", ALC662_FIXUP_ASPIRE),
diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index f05cfc082915..4303b31498d8 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -101,6 +101,7 @@ enum bpf_enum_value_kind {
 	case 2: val = *(const unsigned short *)p; break;		      \
 	case 4: val = *(const unsigned int *)p; break;			      \
 	case 8: val = *(const unsigned long long *)p; break;		      \
+	default: val = 0; break;					      \
 	}								      \
 	val <<= __CORE_RELO(s, field, LSHIFT_U64);			      \
 	if (__CORE_RELO(s, field, SIGNED))				      \
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
new file mode 100644
index 000000000000..8fba3f3649e2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct Small {
+	long x;
+};
+
+struct Big {
+	long x;
+	long y;
+};
+
+__noinline int foo(const struct Big *big)
+{
+	if (!big)
+		return 0;
+
+	return bpf_get_prandom_u32() < big->y;
+}
+
+SEC("cgroup_skb/ingress")
+__failure __msg("invalid indirect access to stack")
+int global_func10(struct __sk_buff *skb)
+{
+	const struct Small small = {.x = skb->len };
+
+	return foo((struct Big *)&small) ? 1 : 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index eb888c8479c3..4b0628cd2d03 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1948,19 +1948,22 @@
 	 * that fp-8 stack slot was unused in the fall-through
 	 * branch and will accept the program incorrectly
 	 */
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_1, 2, 2),
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_0, 2, 2),
 	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
 	BPF_JMP_IMM(BPF_JA, 0, 0, 0),
 	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
 	BPF_LD_MAP_FD(BPF_REG_1, 0),
 	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.fixup_map_hash_48b = { 6 },
-	.errstr = "invalid indirect read from stack R2 off -8+0 size 8",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_XDP,
+	.fixup_map_hash_48b = { 7 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -8+0 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"calls: ctx read at start of subprog",
diff --git a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
index 0ab7f1dfc97a..0e24aa11c457 100644
--- a/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
+++ b/tools/testing/selftests/bpf/verifier/helper_access_var_len.c
@@ -29,19 +29,30 @@
 {
 	"helper access to variable memory: stack, bitwise AND, zero included",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 64),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	/* use bitwise AND to limit r3 range to [0, 64] */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 64),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory at &fp[-64] is
+	 * not initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 4 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: stack, bitwise AND + JMP, wrong max",
@@ -183,20 +194,31 @@
 {
 	"helper access to variable memory: stack, JMP, no min check",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
-	BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, -128),
-	BPF_JMP_IMM(BPF_JGT, BPF_REG_2, 64, 3),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	/* use JMP to limit r3 range to [0, 64] */
+	BPF_JMP_IMM(BPF_JGT, BPF_REG_3, 64, 6),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory at &fp[-64] is
+	 * not initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+0 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 4 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+0 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: stack, JMP (signed), no min check",
@@ -564,29 +586,41 @@
 {
 	"helper access to variable memory: 8 bytes leak",
 	.insns = {
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, 8),
-	BPF_MOV64_REG(BPF_REG_1, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -64),
+	/* set max stack size */
+	BPF_ST_MEM(BPF_DW, BPF_REG_10, -128, 0),
+	/* set r3 to a random value */
+	BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32),
+	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
+	BPF_LD_MAP_FD(BPF_REG_1, 0),
+	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -64),
 	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -64),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -56),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -48),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -40),
+	/* Note: fp[-32] left uninitialized */
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -24),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -16),
 	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
-	BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_2, -128),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_10, -128),
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 63),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1),
-	BPF_MOV64_IMM(BPF_REG_3, 0),
-	BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_10, -16),
+	/* Limit r3 range to [1, 64] */
+	BPF_ALU64_IMM(BPF_AND, BPF_REG_3, 63),
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
+	BPF_MOV64_IMM(BPF_REG_4, 0),
+	/* Call bpf_ringbuf_output(), it is one of a few helper functions with
+	 * ARG_CONST_SIZE_OR_ZERO parameter allowed in unpriv mode.
+	 * For unpriv this should signal an error, because memory region [1, 64]
+	 * at &fp[-64] is not fully initialized.
+	 */
+	BPF_EMIT_CALL(BPF_FUNC_ringbuf_output),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
 	BPF_EXIT_INSN(),
 	},
-	.errstr = "invalid indirect read from stack R1 off -64+32 size 64",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.fixup_map_ringbuf = { 3 },
+	.errstr_unpriv = "invalid indirect read from stack R2 off -64+32 size 64",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"helper access to variable memory: 8 bytes no leak (init memory)",
diff --git a/tools/testing/selftests/bpf/verifier/int_ptr.c b/tools/testing/selftests/bpf/verifier/int_ptr.c
index 070893fb2900..02d9e004260b 100644
--- a/tools/testing/selftests/bpf/verifier/int_ptr.c
+++ b/tools/testing/selftests/bpf/verifier/int_ptr.c
@@ -54,12 +54,13 @@
 		/* bpf_strtoul() */
 		BPF_EMIT_CALL(BPF_FUNC_strtoul),
 
-		BPF_MOV64_IMM(BPF_REG_0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_EXIT_INSN(),
 	},
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_CGROUP_SYSCTL,
-	.errstr = "invalid indirect read from stack R4 off -16+4 size 8",
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid indirect read from stack R4 off -16+4 size 8",
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"ARG_PTR_TO_LONG misaligned",
diff --git a/tools/testing/selftests/bpf/verifier/search_pruning.c b/tools/testing/selftests/bpf/verifier/search_pruning.c
index 7e36078f8f48..949cbe460248 100644
--- a/tools/testing/selftests/bpf/verifier/search_pruning.c
+++ b/tools/testing/selftests/bpf/verifier/search_pruning.c
@@ -128,9 +128,10 @@
 		BPF_EXIT_INSN(),
 	},
 	.fixup_map_hash_8b = { 3 },
-	.errstr = "invalid read from stack off -16+0 size 8",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_TRACEPOINT,
+	.errstr_unpriv = "invalid read from stack off -16+0 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
 {
 	"allocated_stack",
@@ -187,6 +188,8 @@
 	BPF_EXIT_INSN(),
 	},
 	.flags = BPF_F_TEST_STATE_FREQ,
-	.errstr = "invalid read from stack off -8+1 size 8",
-	.result = REJECT,
+	.errstr_unpriv = "invalid read from stack off -8+1 size 8",
+	.result_unpriv = REJECT,
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
 },
diff --git a/tools/testing/selftests/bpf/verifier/sock.c b/tools/testing/selftests/bpf/verifier/sock.c
index 8c224eac93df..59d976d22867 100644
--- a/tools/testing/selftests/bpf/verifier/sock.c
+++ b/tools/testing/selftests/bpf/verifier/sock.c
@@ -530,33 +530,6 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = ACCEPT,
 },
-{
-	"sk_storage_get(map, skb->sk, &stack_value, 1): partially init stack_value",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 0),
-	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_2, -8),
-	BPF_LDX_MEM(BPF_DW, BPF_REG_1, BPF_REG_1, offsetof(struct __sk_buff, sk)),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_1, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_EMIT_CALL(BPF_FUNC_sk_fullsock),
-	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	BPF_MOV64_IMM(BPF_REG_4, 1),
-	BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, -8),
-	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_sk_storage_get),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_sk_storage_map = { 14 },
-	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.result = REJECT,
-	.errstr = "invalid indirect read from stack",
-},
 {
 	"bpf_map_lookup_elem(smap, &key)",
 	.insns = {
diff --git a/tools/testing/selftests/bpf/verifier/spill_fill.c b/tools/testing/selftests/bpf/verifier/spill_fill.c
index 0b943897aaf6..1e76841b7bfa 100644
--- a/tools/testing/selftests/bpf/verifier/spill_fill.c
+++ b/tools/testing/selftests/bpf/verifier/spill_fill.c
@@ -104,3 +104,214 @@
 	.result = ACCEPT,
 	.retval = POINTER_VALUE,
 },
+{
+	"Spill and refill a u32 const scalar.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u32 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=20 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,off=20 R2=pkt R3=pkt_end R4=20 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,off=20,r=20 R2=pkt,r=20 R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 const, refill from another half of the uninit u32 from the stack",
+	.insns = {
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u32 *)(r10 -4) fp-8=????rrrr*/
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid read from stack off -4+0 size 4",
+	/* in privileged mode reads from uninitialized stack locations are permitted */
+	.result = ACCEPT,
+},
+{
+	"Spill a u32 const scalar.  Refill as u16.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u16 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill u32 const scalars.  Refill as u64.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r6 = 0 */
+	BPF_MOV32_IMM(BPF_REG_6, 0),
+	/* r7 = 20 */
+	BPF_MOV32_IMM(BPF_REG_7, 20),
+	/* *(u32 *)(r10 -4) = r6 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_6, -4),
+	/* *(u32 *)(r10 -8) = r7 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_7, -8),
+	/* r4 = *(u64 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -8),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 const scalar.  Refill as u16 from fp-6.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u16 *)(r10 -6) */
+	BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_10, -6),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=umax=65535 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=65535 R2=pkt R3=pkt_end R4=20 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill and refill a u32 const scalar at non 8byte aligned stack addr.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	/* r4 = 20 */
+	BPF_MOV32_IMM(BPF_REG_4, 20),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* *(u32 *)(r10 -4) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
+	/* r4 = *(u32 *)(r10 -4),  */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -4),
+	/* r0 = r2 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r0 += r4 R0=pkt R2=pkt R3=pkt_end R4=umax=U32_MAX */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_4),
+	/* if (r0 > r3) R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_0, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r2 R0=pkt,umax=U32_MAX R2=pkt R3=pkt_end R4= */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_2, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = REJECT,
+	.errstr = "invalid access to packet",
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill and refill a umax=40 bounded scalar.  Offset to skb->data",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1,
+		    offsetof(struct __sk_buff, data)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1,
+		    offsetof(struct __sk_buff, data_end)),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_1,
+		    offsetof(struct __sk_buff, tstamp)),
+	BPF_JMP_IMM(BPF_JLE, BPF_REG_4, 40, 2),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	/* *(u32 *)(r10 -8) = r4 R4=umax=40 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = (*u32 *)(r10 - 8) */
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_10, -8),
+	/* r2 += r4 R2=pkt R4=umax=40 */
+	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_4),
+	/* r0 = r2 R2=pkt,umax=40 R4=umax=40 */
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+	/* r2 += 20 R0=pkt,umax=40 R2=pkt,umax=40 */
+	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 20),
+	/* if (r2 > r3) R0=pkt,umax=40 R2=pkt,off=20,umax=40 */
+	BPF_JMP_REG(BPF_JGT, BPF_REG_2, BPF_REG_3, 1),
+	/* r0 = *(u32 *)r0 R0=pkt,r=20,umax=40 R2=pkt,off=20,r=20,umax=40 */
+	BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
+{
+	"Spill a u32 scalar at fp-4 and then at fp-8",
+	.insns = {
+	/* r4 = 4321 */
+	BPF_MOV32_IMM(BPF_REG_4, 4321),
+	/* *(u32 *)(r10 -4) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -4),
+	/* *(u32 *)(r10 -8) = r4 */
+	BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_4, -8),
+	/* r4 = *(u64 *)(r10 -8) */
+	BPF_LDX_MEM(BPF_DW, BPF_REG_4, BPF_REG_10, -8),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
+},
diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index eab1f7f56e2f..dc92a29f0d74 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -212,31 +212,6 @@
 	.result = REJECT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
-{
-	"indirect variable-offset stack access, max_off+size > max_initialized",
-	.insns = {
-	/* Fill only the second from top 8 bytes of the stack. */
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -16, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_2, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, but we don't know
-	 * which. fp-12 size 8 is partially uninitialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_10),
-	/* Dereference it indirectly. */
-	BPF_LD_MAP_FD(BPF_REG_1, 0),
-	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.fixup_map_hash_8b = { 5 },
-	.errstr = "invalid indirect read from stack R2 var_off",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_LWT_IN,
-},
 {
 	"indirect variable-offset stack access, min_off < min_initialized",
 	.insns = {
@@ -289,33 +264,6 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_CGROUP_SKB,
 },
-{
-	"indirect variable-offset stack access, uninitialized",
-	.insns = {
-	BPF_MOV64_IMM(BPF_REG_2, 6),
-	BPF_MOV64_IMM(BPF_REG_3, 28),
-	/* Fill the top 16 bytes of the stack. */
-	BPF_ST_MEM(BPF_W, BPF_REG_10, -16, 0),
-	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
-	/* Get an unknown value. */
-	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, 0),
-	/* Make it small and 4-byte aligned. */
-	BPF_ALU64_IMM(BPF_AND, BPF_REG_4, 4),
-	BPF_ALU64_IMM(BPF_SUB, BPF_REG_4, 16),
-	/* Add it to fp.  We now have either fp-12 or fp-16, we don't know
-	 * which, but either way it points to initialized stack.
-	 */
-	BPF_ALU64_REG(BPF_ADD, BPF_REG_4, BPF_REG_10),
-	BPF_MOV64_IMM(BPF_REG_5, 8),
-	/* Dereference it indirectly. */
-	BPF_EMIT_CALL(BPF_FUNC_getsockopt),
-	BPF_MOV64_IMM(BPF_REG_0, 0),
-	BPF_EXIT_INSN(),
-	},
-	.errstr = "invalid indirect read from stack R4 var_off",
-	.result = REJECT,
-	.prog_type = BPF_PROG_TYPE_SOCK_OPS,
-},
 {
 	"indirect variable-offset stack access, ok",
 	.insns = {
diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..7ea5fb28c93d 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -85,6 +85,7 @@ static bool cfg_rx;
 static int  cfg_runtime_ms	= 4200;
 static int  cfg_verbose;
 static int  cfg_waittime_ms	= 500;
+static int  cfg_notification_limit = 32;
 static bool cfg_zerocopy;
 
 static socklen_t cfg_alen;
@@ -95,6 +96,7 @@ static char payload[IP_MAXPACKET];
 static long packets, bytes, completions, expected_completions;
 static int  zerocopied = -1;
 static uint32_t next_completion;
+static uint32_t sends_since_notify;
 
 static unsigned long gettimeofday_ms(void)
 {
@@ -208,6 +210,7 @@ static bool do_sendmsg(int fd, struct msghdr *msg, bool do_zerocopy, int domain)
 		error(1, errno, "send");
 	if (cfg_verbose && ret != len)
 		fprintf(stderr, "send: ret=%u != %u\n", ret, len);
+	sends_since_notify++;
 
 	if (len) {
 		packets++;
@@ -435,7 +438,7 @@ static bool do_recv_completion(int fd, int domain)
 	/* Detect notification gaps. These should not happen often, if at all.
 	 * Gaps can occur due to drops, reordering and retransmissions.
 	 */
-	if (lo != next_completion)
+	if (cfg_verbose && lo != next_completion)
 		fprintf(stderr, "gap: %u..%u does not append to %u\n",
 			lo, hi, next_completion);
 	next_completion = hi + 1;
@@ -460,6 +463,7 @@ static bool do_recv_completion(int fd, int domain)
 static void do_recv_completions(int fd, int domain)
 {
 	while (do_recv_completion(fd, domain)) {}
+	sends_since_notify = 0;
 }
 
 /* Wait for all remaining completions on the errqueue */
@@ -549,6 +553,9 @@ static void do_tx(int domain, int type, int protocol)
 		else
 			do_sendmsg(fd, &msg, cfg_zerocopy, domain);
 
+		if (cfg_zerocopy && sends_since_notify >= cfg_notification_limit)
+			do_recv_completions(fd, domain);
+
 		while (!do_poll(fd, POLLOUT)) {
 			if (cfg_zerocopy)
 				do_recv_completions(fd, domain);
@@ -708,7 +715,7 @@ static void parse_opts(int argc, char **argv)
 
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "46c:C:D:i:mp:rs:S:t:vz")) != -1) {
+	while ((c = getopt(argc, argv, "46c:C:D:i:l:mp:rs:S:t:vz")) != -1) {
 		switch (c) {
 		case '4':
 			if (cfg_family != PF_UNSPEC)
@@ -736,6 +743,9 @@ static void parse_opts(int argc, char **argv)
 			if (cfg_ifindex == 0)
 				error(1, errno, "invalid iface: %s", optarg);
 			break;
+		case 'l':
+			cfg_notification_limit = strtoul(optarg, NULL, 0);
+			break;
 		case 'm':
 			cfg_cork_mixed = true;
 			break;

