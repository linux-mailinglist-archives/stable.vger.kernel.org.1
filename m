Return-Path: <stable+bounces-160280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A67BAFA3DB
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57683BA2CD
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 09:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99F71EDA26;
	Sun,  6 Jul 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PhcsVGej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756235972;
	Sun,  6 Jul 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793210; cv=none; b=jEvpZ9cCekm7hYwRgQSrVQMOOx4gdcr+ZzP+Ts+EfVHn0MbSsHNZPLdvcMXY6NRk7G64adxNsobsongcgr2FvrFeqYMiS0Us5leUwJPgG7PnZaosHwsBv4ZSIpwvGlg36fLB6sebUrh45mMyZun0rD0VkbuqvTeg13sQoMmyXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793210; c=relaxed/simple;
	bh=ENapkJrUOQUv+n4+RWdIeHni+2azkip+swDbapTblSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hV8vnj85MBIwEwjRXbLoARmXN8WxQocvNRb8fS1yg2/j0iHstJuOh1fsL05ltXJ7JpVYlCUesNXuln/llx4IsoduaEe/cpakfXI5hZlA1phXon6eyP1MXzUbrknrdtkc7MP5jRucNTjx6s8HI/G3LiDura0HtsVO4v9+v/97+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PhcsVGej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5987C4CEED;
	Sun,  6 Jul 2025 09:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751793209;
	bh=ENapkJrUOQUv+n4+RWdIeHni+2azkip+swDbapTblSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PhcsVGej+CfiVYmfKLVYr/c7gt10/Bc/M9VG4TwTt+fkNiOIQhElXbLwlFIB/W6xN
	 +D558RBo2q1ht2Il1vZZ7s4TeVAWEa0ywRKTLPSocMhg1oYzaeeOgEA/JVIcFV2bvF
	 xzCgG6ClamJRRMUNvVeW0un3szxbG1Vk89W/h6Tk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.143
Date: Sun,  6 Jul 2025 11:13:24 +0200
Message-ID: <2025070624-museum-caboose-5d55@gregkh>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <2025070624-outright-rely-d710@gregkh>
References: <2025070624-outright-rely-d710@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 6258f5f59b19..7ee56e628c87 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -44,7 +44,7 @@ allOf:
                   - ns16550
                   - ns16550a
     then:
-      anyOf:
+      oneOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
 
diff --git a/Makefile b/Makefile
index 5168b93dfed2..14e0e8bf3e74 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 142
+SUBLEVEL = 143
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 1408a6a15d0e..fa622b77c785 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -10,6 +10,7 @@
 #include <uapi/asm/ptrace.h>
 
 #ifndef __ASSEMBLY__
+#include <linux/bitfield.h>
 #include <linux/types.h>
 
 struct pt_regs {
@@ -35,8 +36,8 @@ struct svc_pt_regs {
 
 #ifndef CONFIG_CPU_V7M
 #define isa_mode(regs) \
-	((((regs)->ARM_cpsr & PSR_J_BIT) >> (__ffs(PSR_J_BIT) - 1)) | \
-	 (((regs)->ARM_cpsr & PSR_T_BIT) >> (__ffs(PSR_T_BIT))))
+	(FIELD_GET(PSR_J_BIT, (regs)->ARM_cpsr) << 1 | \
+	 FIELD_GET(PSR_T_BIT, (regs)->ARM_cpsr))
 #else
 #define isa_mode(regs) 1 /* Thumb */
 #endif
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cd14c3c22320..e9288b28cb1e 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1503,7 +1503,8 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	next = addr;
 	end = addr + PUD_SIZE;
 	do {
-		pmd_free_pte_page(pmdp, next);
+		if (pmd_present(READ_ONCE(*pmdp)))
+			pmd_free_pte_page(pmdp, next);
 	} while (pmdp++, next += PMD_SIZE, next != end);
 
 	pud_clear(pudp);
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 62b80616ca72..576457915625 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -690,7 +690,7 @@ ENTRY(stack_overflow)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_R8(64,%r11),0(%r14)
-	stg	%r10,__PT_ORIG_GPR2(%r11) # store last break to orig_gpr2
+	mvc	__PT_ORIG_GPR2(8,%r11),__LC_PGM_LAST_BREAK
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	jg	kernel_stack_overflow
diff --git a/arch/um/drivers/ubd_user.c b/arch/um/drivers/ubd_user.c
index a1afe414ce48..fb5b1e7c133d 100644
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
index 6d8ae86ae978..c16b80011ada 100644
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
diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 472540aeabc2..08cd913cbd4e 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -10,8 +10,7 @@
 #include <assert.h>
 #include <unistd.h>
 #include <stdarg.h>
-
-#define unlikely(cond) (cond)
+#include <linux/kallsyms.h>
 
 #include <asm/insn.h>
 #include <inat.c>
@@ -106,7 +105,7 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
-#define BUFSIZE 256
+#define BUFSIZE (256 + KSYM_NAME_LEN)
 
 int main(int argc, char **argv)
 {
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
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 766017570488..e2175651f979 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2859,6 +2859,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 		return -EINVAL;
 	}
 
+	xdev->common.directions |= chan->direction;
+
 	/* Request the interrupt */
 	chan->irq = of_irq_get(node, chan->tdest);
 	if (chan->irq < 0)
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index fe06dc193689..53fd9b17b9bd 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1177,6 +1177,39 @@ static int scmi_common_extended_name_get(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+/**
+ * scmi_protocol_msg_check  - Check protocol message attributes
+ *
+ * @ph: A reference to the protocol handle.
+ * @message_id: The ID of the message to check.
+ * @attributes: A parameter to optionally return the retrieved message
+ *		attributes, in case of Success.
+ *
+ * An helper to check protocol message attributes for a specific protocol
+ * and message pair.
+ *
+ * Return: 0 on SUCCESS
+ */
+static int scmi_protocol_msg_check(const struct scmi_protocol_handle *ph,
+				   u32 message_id, u32 *attributes)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = xfer_get_init(ph, PROTOCOL_MESSAGE_ATTRIBUTES,
+			    sizeof(__le32), 0, &t);
+	if (ret)
+		return ret;
+
+	put_unaligned_le32(message_id, t->tx.buf);
+	ret = do_xfer(ph, t);
+	if (!ret && attributes)
+		*attributes = get_unaligned_le32(t->rx.buf);
+	xfer_put(ph, t);
+
+	return ret;
+}
+
 /**
  * struct scmi_iterator  - Iterator descriptor
  * @msg: A reference to the message TX buffer; filled by @prepare_message with
@@ -1318,6 +1351,7 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	int ret;
 	u32 flags;
 	u64 phys_addr;
+	u32 attributes;
 	u8 size;
 	void __iomem *addr;
 	struct scmi_xfer *t;
@@ -1326,6 +1360,15 @@ scmi_common_fastchannel_init(const struct scmi_protocol_handle *ph,
 	struct scmi_msg_resp_desc_fc *resp;
 	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
 
+	/* Check if the MSG_ID supports fastchannel */
+	ret = scmi_protocol_msg_check(ph, message_id, &attributes);
+	if (ret || !MSG_SUPPORTS_FASTCHANNEL(attributes)) {
+		dev_dbg(ph->dev,
+			"Skip FC init for 0x%02X/%d  domain:%d - ret:%d\n",
+			pi->proto->id, message_id, domain, ret);
+		return;
+	}
+
 	if (!p_addr) {
 		ret = -EINVAL;
 		goto err_out;
@@ -1454,6 +1497,7 @@ static const struct scmi_proto_helpers_ops helpers_ops = {
 	.extended_name_get = scmi_common_extended_name_get,
 	.iter_response_init = scmi_iterator_init,
 	.iter_response_run = scmi_iterator_run,
+	.protocol_msg_check = scmi_protocol_msg_check,
 	.fastchannel_init = scmi_common_fastchannel_init,
 	.fastchannel_db_ring = scmi_common_fastchannel_db_ring,
 };
diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
index 2f3bf691db7c..1a9753608a2b 100644
--- a/drivers/firmware/arm_scmi/protocols.h
+++ b/drivers/firmware/arm_scmi/protocols.h
@@ -29,6 +29,8 @@
 #define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
 #define PROTOCOL_REV_MINOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x))))
 
+#define MSG_SUPPORTS_FASTCHANNEL(x)	((x) & BIT(0))
+
 enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
 	PROTOCOL_ATTRIBUTES = 0x1,
@@ -243,6 +245,8 @@ struct scmi_fc_info {
  *			provided in @ops.
  * @iter_response_run: A common helper to trigger the run of a previously
  *		       initialized iterator.
+ * @protocol_msg_check: A common helper to check is a specific protocol message
+ *			is supported.
  * @fastchannel_init: A common helper used to initialize FC descriptors by
  *		      gathering FC descriptions from the SCMI platform server.
  * @fastchannel_db_ring: A common helper to ring a FC doorbell.
@@ -255,6 +259,8 @@ struct scmi_proto_helpers_ops {
 				    unsigned int max_resources, u8 msg_id,
 				    size_t tx_size, void *priv);
 	int (*iter_response_run)(void *iter);
+	int (*protocol_msg_check)(const struct scmi_protocol_handle *ph,
+				  u32 message_id, u32 *attributes);
 	void (*fastchannel_init)(const struct scmi_protocol_handle *ph,
 				 u8 describe_id, u32 message_id,
 				 u32 valid_size, u32 domain,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 779707f19c88..52d9fbfbb69e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -28,6 +28,10 @@
 #include "amdgpu.h"
 #include "amdgpu_ucode.h"
 
+static const struct kicker_device kicker_device_list[] = {
+	{0x744B, 0x00},
+};
+
 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
 {
 	DRM_DEBUG("size_bytes: %u\n", le32_to_cpu(hdr->size_bytes));
@@ -1059,6 +1063,19 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 	return 0;
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
index 4c20eb410960..9649982e357c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -535,6 +535,11 @@ struct amdgpu_firmware {
 	uint64_t fw_buf_mc;
 };
 
+struct kicker_device{
+	unsigned short device;
+	u8 revision;
+};
+
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr);
@@ -561,5 +566,6 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type);
 const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id);
 
 void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type, char *ucode_prefix, int len);
+bool amdgpu_is_kicker_fw(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 16594a0a6d18..24867e96b520 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -396,7 +396,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	int r;
 
 	lpfn = (u64)place->lpfn << PAGE_SHIFT;
-	if (!lpfn)
+	if (!lpfn || lpfn > man->size)
 		lpfn = man->size;
 
 	fpfn = (u64)place->fpfn << PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 2880ed96ac2e..80d567ba9484 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1340,6 +1340,7 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
 	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
 	if (unlikely(user_gpu_id == -EINVAL)) {
 		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
+		kfd_unref_process(p);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 18250845a989..f335624c2d77 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -201,7 +201,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 
 	packet->bitfields2.engine_sel =
 		engine_sel__mes_map_queues__compute_vi;
-	packet->bitfields2.gws_control_queue = q->gws ? 1 : 0;
+	packet->bitfields2.gws_control_queue = q->properties.is_gws ? 1 : 0;
 	packet->bitfields2.extended_engine_sel =
 		extended_engine_sel__mes_map_queues__legacy_engine_sel;
 	packet->bitfields2.queue_type =
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index ff930a71e496..7f8f127e7722 100644
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
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index 20bece84ff8c..fd4e1853d414 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -609,15 +609,18 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
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
@@ -717,6 +720,11 @@ static void cdns_dsi_bridge_post_disable(struct drm_bridge *bridge)
 	struct cdns_dsi_input *input = bridge_to_cdns_dsi_input(bridge);
 	struct cdns_dsi *dsi = input_to_dsi(input);
 
+	dsi->phy_initialized = false;
+	dsi->link_initialized = false;
+	phy_power_off(dsi->dphy);
+	phy_exit(dsi->dphy);
+
 	pm_runtime_put(dsi->base.dev);
 }
 
@@ -798,7 +806,7 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
-	u32 tmp, reg_wakeup, div;
+	u32 tmp, reg_wakeup, div, status;
 	int nlanes;
 
 	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
@@ -812,6 +820,19 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
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
@@ -986,7 +1007,7 @@ static int cdns_dsi_attach(struct mipi_dsi_host *host,
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_DSI);
 	} else {
-		bridge = of_drm_find_bridge(dev->dev.of_node);
+		bridge = of_drm_find_bridge(np);
 		if (!bridge)
 			bridge = ERR_PTR(-EINVAL);
 	}
@@ -1186,7 +1207,6 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 	clk_disable_unprepare(dsi->dsi_sys_clk);
 	clk_disable_unprepare(dsi->dsi_p_clk);
 	reset_control_assert(dsi->dsi_p_rst);
-	dsi->link_initialized = false;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 3c8e33f416e7..26a064624d97 100644
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
@@ -1182,9 +1160,14 @@ static enum drm_connector_status ti_sn_bridge_detect(struct drm_bridge *bridge)
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
@@ -1198,6 +1181,35 @@ static struct edid *ti_sn_bridge_get_edid(struct drm_bridge *bridge,
 	return drm_get_edid(connector, &pdata->aux.ddc);
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
@@ -1211,6 +1223,9 @@ static const struct drm_bridge_funcs ti_sn_bridge_funcs = {
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.debugfs_init = ti_sn65dsi86_debugfs_init,
+	.hpd_enable = ti_sn_bridge_hpd_enable,
+	.hpd_disable = ti_sn_bridge_hpd_disable,
 };
 
 static void ti_sn_bridge_parse_lanes(struct ti_sn65dsi86 *pdata,
@@ -1299,8 +1314,26 @@ static int ti_sn_bridge_probe(struct auxiliary_device *adev,
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
 
@@ -1917,8 +1950,6 @@ static int ti_sn65dsi86_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ti_sn65dsi86_debugfs_init(pdata);
-
 	/*
 	 * Break ourselves up into a collection of aux devices. The only real
 	 * motiviation here is to solve the chicken-and-egg problem of probe
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
index 5d506767b8f2..13a6812f7d71 100644
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
@@ -75,7 +76,9 @@ static enum drm_gpu_sched_stat etnaviv_sched_timedout_job(struct drm_sched_job
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 
 out_no_timeout:
-	list_add(&sched_job->list, &sched_job->sched->pending_list);
+	spin_lock(&sched->job_list_lock);
+	list_add(&sched_job->list, &sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 4e73b915fe1a..4e50ac39d7c8 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -147,6 +147,7 @@ void msm_devfreq_init(struct msm_gpu *gpu)
 		return;
 
 	mutex_init(&df->lock);
+	df->suspended = true;
 
 	ret = dev_pm_qos_add_request(&gpu->pdev->dev, &df->boost_freq,
 				     DEV_PM_QOS_MIN_FREQUENCY, 0);
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index a67453cee883..557eaaaab1c3 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1319,10 +1319,16 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
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
 
@@ -1330,10 +1336,8 @@ static struct drm_plane *tegra_dc_add_shared_planes(struct drm_device *drm,
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
@@ -1387,7 +1391,10 @@ static void tegra_crtc_reset(struct drm_crtc *crtc)
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
index b872527a123c..439ee7491677 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -756,9 +756,9 @@ static const struct drm_plane_helper_funcs tegra_shared_plane_helper_funcs = {
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
diff --git a/drivers/gpu/drm/udl/udl_drv.c b/drivers/gpu/drm/udl/udl_drv.c
index 91effdcefb6d..0a20d7fe135f 100644
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
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index a4062f617ba2..ee65da98c7d5 100644
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
index b3395b3eb804..276b3e4f661f 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2012,14 +2012,18 @@ static int wacom_initialize_remotes(struct wacom *wacom)
 
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
 
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index d95e567a190d..25e2958923af 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -120,7 +120,9 @@ const struct vmbus_device vmbus_devs[] = {
 	},
 
 	/* File copy */
-	{ .dev_type = HV_FCOPY,
+	/* fcopy always uses 16KB ring buffer size and is working well for last many years */
+	{ .pref_ring_size = 0x4000,
+	  .dev_type = HV_FCOPY,
 	  HV_FCOPY_GUID,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
@@ -140,12 +142,19 @@ const struct vmbus_device vmbus_devs[] = {
 	  .allowed_in_isolated = false,
 	},
 
-	/* Unknown GUID */
-	{ .dev_type = HV_UNKNOWN,
+	/*
+	 * Unknown GUID
+	 * 64 KB ring buffer + 4 KB header should be sufficient size for any Hyper-V device apart
+	 * from HV_NIC and HV_SCSI. This case avoid the fallback for unknown devices to allocate
+	 * much bigger (2 MB) of ring size.
+	 */
+	{ .pref_ring_size = 0x11000,
+	  .dev_type = HV_UNKNOWN,
 	  .perf_device = false,
 	  .allowed_in_isolated = false,
 	},
 };
+EXPORT_SYMBOL_GPL(vmbus_devs);
 
 static const struct {
 	guid_t guid;
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index da51b50787df..7bb94e0dd0f6 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -104,8 +104,14 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID;
 	}
 
-	msg->monitor_page1 = vmbus_connection.monitor_pages_pa[0];
-	msg->monitor_page2 = vmbus_connection.monitor_pages_pa[1];
+	/*
+	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
+	 * bitwise OR it
+	 */
+	msg->monitor_page1 = virt_to_phys(vmbus_connection.monitor_pages[0]) |
+				ms_hyperv.shared_gpa_boundary;
+	msg->monitor_page2 = virt_to_phys(vmbus_connection.monitor_pages[1]) |
+				ms_hyperv.shared_gpa_boundary;
 
 	msg->target_vcpu = hv_cpu_number_to_vp_number(VMBUS_CONNECT_CPU);
 
@@ -199,12 +205,20 @@ int vmbus_connect(void)
 	INIT_LIST_HEAD(&vmbus_connection.chn_list);
 	mutex_init(&vmbus_connection.channel_mutex);
 
+	/*
+	 * The following Hyper-V interrupt and monitor pages can be used by
+	 * UIO for mapping to user-space, so they should always be allocated on
+	 * system page boundaries. The system page size must be >= the Hyper-V
+	 * page size.
+	 */
+	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
+
 	/*
 	 * Setup the vmbus event connection for channel interrupt
 	 * abstraction stuff
 	 */
 	vmbus_connection.int_page =
-	(void *)hv_alloc_hyperv_zeroed_page();
+		(void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	if (vmbus_connection.int_page == NULL) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -219,73 +233,37 @@ int vmbus_connect(void)
 	 * Setup the monitor notification facility. The 1st page for
 	 * parent->child and the 2nd page for child->parent
 	 */
-	vmbus_connection.monitor_pages[0] = (void *)hv_alloc_hyperv_zeroed_page();
-	vmbus_connection.monitor_pages[1] = (void *)hv_alloc_hyperv_zeroed_page();
+	vmbus_connection.monitor_pages[0] = (void *)__get_free_page(GFP_KERNEL);
+	vmbus_connection.monitor_pages[1] = (void *)__get_free_page(GFP_KERNEL);
 	if ((vmbus_connection.monitor_pages[0] == NULL) ||
 	    (vmbus_connection.monitor_pages[1] == NULL)) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
-	vmbus_connection.monitor_pages_original[0]
-		= vmbus_connection.monitor_pages[0];
-	vmbus_connection.monitor_pages_original[1]
-		= vmbus_connection.monitor_pages[1];
-	vmbus_connection.monitor_pages_pa[0]
-		= virt_to_phys(vmbus_connection.monitor_pages[0]);
-	vmbus_connection.monitor_pages_pa[1]
-		= virt_to_phys(vmbus_connection.monitor_pages[1]);
-
-	if (hv_is_isolation_supported()) {
-		ret = set_memory_decrypted((unsigned long)
-					   vmbus_connection.monitor_pages[0],
-					   1);
-		ret |= set_memory_decrypted((unsigned long)
-					    vmbus_connection.monitor_pages[1],
-					    1);
-		if (ret)
-			goto cleanup;
-
-		/*
-		 * Isolation VM with AMD SNP needs to access monitor page via
-		 * address space above shared gpa boundary.
-		 */
-		if (hv_isolation_type_snp()) {
-			vmbus_connection.monitor_pages_pa[0] +=
-				ms_hyperv.shared_gpa_boundary;
-			vmbus_connection.monitor_pages_pa[1] +=
-				ms_hyperv.shared_gpa_boundary;
-
-			vmbus_connection.monitor_pages[0]
-				= memremap(vmbus_connection.monitor_pages_pa[0],
-					   HV_HYP_PAGE_SIZE,
-					   MEMREMAP_WB);
-			if (!vmbus_connection.monitor_pages[0]) {
-				ret = -ENOMEM;
-				goto cleanup;
-			}
-
-			vmbus_connection.monitor_pages[1]
-				= memremap(vmbus_connection.monitor_pages_pa[1],
-					   HV_HYP_PAGE_SIZE,
-					   MEMREMAP_WB);
-			if (!vmbus_connection.monitor_pages[1]) {
-				ret = -ENOMEM;
-				goto cleanup;
-			}
-		}
-
+	ret = set_memory_decrypted((unsigned long)
+				vmbus_connection.monitor_pages[0], 1);
+	ret |= set_memory_decrypted((unsigned long)
+				vmbus_connection.monitor_pages[1], 1);
+	if (ret) {
 		/*
-		 * Set memory host visibility hvcall smears memory
-		 * and so zero monitor pages here.
+		 * If set_memory_decrypted() fails, the encryption state
+		 * of the memory is unknown. So leak the memory instead
+		 * of risking returning decrypted memory to the free list.
+		 * For simplicity, always handle both pages the same.
 		 */
-		memset(vmbus_connection.monitor_pages[0], 0x00,
-		       HV_HYP_PAGE_SIZE);
-		memset(vmbus_connection.monitor_pages[1], 0x00,
-		       HV_HYP_PAGE_SIZE);
-
+		vmbus_connection.monitor_pages[0] = NULL;
+		vmbus_connection.monitor_pages[1] = NULL;
+		goto cleanup;
 	}
 
+	/*
+	 * Set_memory_decrypted() will change the memory contents if
+	 * decryption occurs, so zero monitor pages here.
+	 */
+	memset(vmbus_connection.monitor_pages[0], 0x00, HV_HYP_PAGE_SIZE);
+	memset(vmbus_connection.monitor_pages[1], 0x00, HV_HYP_PAGE_SIZE);
+
 	msginfo = kzalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_initiate_contact),
 			  GFP_KERNEL);
@@ -372,35 +350,25 @@ void vmbus_disconnect(void)
 		destroy_workqueue(vmbus_connection.work_queue);
 
 	if (vmbus_connection.int_page) {
-		hv_free_hyperv_page((unsigned long)vmbus_connection.int_page);
+		free_page((unsigned long)vmbus_connection.int_page);
 		vmbus_connection.int_page = NULL;
 	}
 
-	if (hv_is_isolation_supported()) {
-		/*
-		 * memunmap() checks input address is ioremap address or not
-		 * inside. It doesn't unmap any thing in the non-SNP CVM and
-		 * so not check CVM type here.
-		 */
-		memunmap(vmbus_connection.monitor_pages[0]);
-		memunmap(vmbus_connection.monitor_pages[1]);
-
-		set_memory_encrypted((unsigned long)
-			vmbus_connection.monitor_pages_original[0],
-			1);
-		set_memory_encrypted((unsigned long)
-			vmbus_connection.monitor_pages_original[1],
-			1);
+	if (vmbus_connection.monitor_pages[0]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[0], 1))
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[0]);
+		vmbus_connection.monitor_pages[0] = NULL;
 	}
 
-	hv_free_hyperv_page((unsigned long)
-		vmbus_connection.monitor_pages_original[0]);
-	hv_free_hyperv_page((unsigned long)
-		vmbus_connection.monitor_pages_original[1]);
-	vmbus_connection.monitor_pages_original[0] =
-		vmbus_connection.monitor_pages[0] = NULL;
-	vmbus_connection.monitor_pages_original[1] =
+	if (vmbus_connection.monitor_pages[1]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[1], 1))
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[1]);
 		vmbus_connection.monitor_pages[1] = NULL;
+	}
 }
 
 /*
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..d1a3be24396f 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -38,42 +38,6 @@ int hv_init(void)
 	return 0;
 }
 
-/*
- * Functions for allocating and freeing memory with size and
- * alignment HV_HYP_PAGE_SIZE. These functions are needed because
- * the guest page size may not be the same as the Hyper-V page
- * size. We depend upon kmalloc() aligning power-of-two size
- * allocations to the allocation size boundary, so that the
- * allocated memory appears to Hyper-V as a page of the size
- * it expects.
- */
-
-void *hv_alloc_hyperv_page(void)
-{
-	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
-
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL);
-	else
-		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
-}
-
-void *hv_alloc_hyperv_zeroed_page(void)
-{
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	else
-		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
-}
-
-void hv_free_hyperv_page(unsigned long addr)
-{
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		free_page(addr);
-	else
-		kfree((void *)addr);
-}
-
 /*
  * hv_post_message - Post a message using the hypervisor message IPC.
  *
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ae68298c0dca..2bc1aea07046 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -17,8 +17,11 @@
 #include <linux/export.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
+#include <linux/sched/task_stack.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
+#include <linux/kdebug.h>
+#include <linux/kmsg_dump.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <asm/hyperv-tlfs.h>
@@ -51,6 +54,10 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 void * __percpu *hyperv_pcpu_output_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
+static void hv_kmsg_dump_unregister(void);
+
+static struct ctl_table_header *hv_ctl_table_hdr;
+
 /*
  * Hyper-V specific initialization and shutdown code that is
  * common across all architectures.  Called from architecture
@@ -59,6 +66,12 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
 void __init hv_common_free(void)
 {
+	unregister_sysctl_table(hv_ctl_table_hdr);
+	hv_ctl_table_hdr = NULL;
+
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		hv_kmsg_dump_unregister();
+
 	kfree(hv_vp_index);
 	hv_vp_index = NULL;
 
@@ -69,10 +82,203 @@ void __init hv_common_free(void)
 	hyperv_pcpu_input_arg = NULL;
 }
 
+/*
+ * Functions for allocating and freeing memory with size and
+ * alignment HV_HYP_PAGE_SIZE. These functions are needed because
+ * the guest page size may not be the same as the Hyper-V page
+ * size. We depend upon kmalloc() aligning power-of-two size
+ * allocations to the allocation size boundary, so that the
+ * allocated memory appears to Hyper-V as a page of the size
+ * it expects.
+ */
+
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
+
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL);
+	else
+		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	else
+		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
+
+void hv_free_hyperv_page(void *addr)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		free_page((unsigned long)addr);
+	else
+		kfree(addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
+static void *hv_panic_page;
+
+/*
+ * Boolean to control whether to report panic messages over Hyper-V.
+ *
+ * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
+ */
+static int sysctl_record_panic_msg = 1;
+
+/*
+ * sysctl option to allow the user to control whether kmsg data should be
+ * reported to Hyper-V on panic.
+ */
+static struct ctl_table hv_ctl_table[] = {
+	{
+		.procname	= "hyperv_record_panic_msg",
+		.data		= &sysctl_record_panic_msg,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
+	{}
+};
+
+static int hv_die_panic_notify_crash(struct notifier_block *self,
+				     unsigned long val, void *args);
+
+static struct notifier_block hyperv_die_report_block = {
+	.notifier_call = hv_die_panic_notify_crash,
+};
+
+static struct notifier_block hyperv_panic_report_block = {
+	.notifier_call = hv_die_panic_notify_crash,
+};
+
+/*
+ * The following callback works both as die and panic notifier; its
+ * goal is to provide panic information to the hypervisor unless the
+ * kmsg dumper is used [see hv_kmsg_dump()], which provides more
+ * information but isn't always available.
+ *
+ * Notice that both the panic/die report notifiers are registered only
+ * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE set.
+ */
+static int hv_die_panic_notify_crash(struct notifier_block *self,
+				     unsigned long val, void *args)
+{
+	struct pt_regs *regs;
+	bool is_die;
+
+	/* Don't notify Hyper-V unless we have a die oops event or panic. */
+	if (self == &hyperv_panic_report_block) {
+		is_die = false;
+		regs = current_pt_regs();
+	} else { /* die event */
+		if (val != DIE_OOPS)
+			return NOTIFY_DONE;
+
+		is_die = true;
+		regs = ((struct die_args *)args)->regs;
+	}
+
+	/*
+	 * Hyper-V should be notified only once about a panic/die. If we will
+	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
+	 * notification here.
+	 */
+	if (!sysctl_record_panic_msg || !hv_panic_page)
+		hyperv_report_panic(regs, val, is_die);
+
+	return NOTIFY_DONE;
+}
+
+/*
+ * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
+ * buffer and call into Hyper-V to transfer the data.
+ */
+static void hv_kmsg_dump(struct kmsg_dumper *dumper,
+			 enum kmsg_dump_reason reason)
+{
+	struct kmsg_dump_iter iter;
+	size_t bytes_written;
+
+	/* We are only interested in panics. */
+	if (reason != KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
+		return;
+
+	/*
+	 * Write dump contents to the page. No need to synchronize; panic should
+	 * be single-threaded.
+	 */
+	kmsg_dump_rewind(&iter);
+	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+			     &bytes_written);
+	if (!bytes_written)
+		return;
+	/*
+	 * P3 to contain the physical address of the panic page & P4 to
+	 * contain the size of the panic data in that page. Rest of the
+	 * registers are no-op when the NOTIFY_MSG flag is set.
+	 */
+	hv_set_register(HV_REGISTER_CRASH_P0, 0);
+	hv_set_register(HV_REGISTER_CRASH_P1, 0);
+	hv_set_register(HV_REGISTER_CRASH_P2, 0);
+	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
+	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
+
+	/*
+	 * Let Hyper-V know there is crash data available along with
+	 * the panic message.
+	 */
+	hv_set_register(HV_REGISTER_CRASH_CTL,
+			(HV_CRASH_CTL_CRASH_NOTIFY |
+			 HV_CRASH_CTL_CRASH_NOTIFY_MSG));
+}
+
+static struct kmsg_dumper hv_kmsg_dumper = {
+	.dump = hv_kmsg_dump,
+};
+
+static void hv_kmsg_dump_unregister(void)
+{
+	kmsg_dump_unregister(&hv_kmsg_dumper);
+	unregister_die_notifier(&hyperv_die_report_block);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &hyperv_panic_report_block);
+
+	hv_free_hyperv_page(hv_panic_page);
+	hv_panic_page = NULL;
+}
+
+static void hv_kmsg_dump_register(void)
+{
+	int ret;
+
+	hv_panic_page = hv_alloc_hyperv_zeroed_page();
+	if (!hv_panic_page) {
+		pr_err("Hyper-V: panic message page memory allocation failed\n");
+		return;
+	}
+
+	ret = kmsg_dump_register(&hv_kmsg_dumper);
+	if (ret) {
+		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
+		hv_free_hyperv_page(hv_panic_page);
+		hv_panic_page = NULL;
+	}
+}
+
 int __init hv_common_init(void)
 {
 	int i;
 
+	if (hv_is_isolation_supported())
+		sysctl_record_panic_msg = 0;
+
 	/*
 	 * Hyper-V expects to get crash register data or kmsg when
 	 * crash enlightment is available and system crashes. Set
@@ -81,8 +287,33 @@ int __init hv_common_init(void)
 	 * kernel.
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		u64 hyperv_crash_ctl;
+
 		crash_kexec_post_notifiers = true;
 		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
+
+		/*
+		 * Panic message recording (sysctl_record_panic_msg)
+		 * is enabled by default in non-isolated guests and
+		 * disabled by default in isolated guests; the panic
+		 * message recording won't be available in isolated
+		 * guests should the following registration fail.
+		 */
+		hv_ctl_table_hdr = register_sysctl("kernel", hv_ctl_table);
+		if (!hv_ctl_table_hdr)
+			pr_err("Hyper-V: sysctl table register error");
+
+		/*
+		 * Register for panic kmsg callback only if the right
+		 * capability is supported by the hypervisor.
+		 */
+		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
+		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
+			hv_kmsg_dump_register();
+
+		register_die_notifier(&hyperv_die_report_block);
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &hyperv_panic_report_block);
 	}
 
 	/*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index ab12e21bf5fc..f039b110e98c 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -241,8 +241,6 @@ struct vmbus_connection {
 	 * is child->parent notification
 	 */
 	struct hv_monitor_page *monitor_pages[2];
-	void *monitor_pages_original[2];
-	phys_addr_t monitor_pages_pa[2];
 	struct list_head chn_msg_list;
 	spinlock_t channelmsg_lock;
 
@@ -414,6 +412,11 @@ static inline bool hv_is_perf_channel(struct vmbus_channel *channel)
 	return vmbus_devs[channel->device_id].perf_device;
 }
 
+static inline size_t hv_dev_ring_size(struct vmbus_channel *channel)
+{
+	return vmbus_devs[channel->device_id].pref_ring_size;
+}
+
 static inline bool hv_is_allocated_cpu(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index dfbfdbf9cbd7..074168f34afd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -25,11 +25,9 @@
 #include <linux/sched/task_stack.h>
 
 #include <linux/delay.h>
-#include <linux/notifier.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
 #include <linux/screen_info.h>
-#include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
 #include <linux/kernel.h>
@@ -48,8 +46,6 @@ static struct acpi_device  *hv_acpi_dev;
 
 static int hyperv_cpuhp_online;
 
-static void *hv_panic_page;
-
 static long __percpu *vmbus_evt;
 
 /* Values parsed from ACPI DSDT */
@@ -57,62 +53,23 @@ int vmbus_irq;
 int vmbus_interrupt;
 
 /*
- * Boolean to control whether to report panic messages over Hyper-V.
+ * The panic notifier below is responsible solely for unloading the
+ * vmbus connection, which is necessary in a panic event.
  *
- * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
+ * Notice an intrincate relation of this notifier with Hyper-V
+ * framebuffer panic notifier exists - we need vmbus connection alive
+ * there in order to succeed, so we need to order both with each other
+ * [see hvfb_on_panic()] - this is done using notifiers' priorities.
  */
-static int sysctl_record_panic_msg = 1;
-
-static int hyperv_report_reg(void)
-{
-	return !sysctl_record_panic_msg || !hv_panic_page;
-}
-
-static int hyperv_panic_event(struct notifier_block *nb, unsigned long val,
+static int hv_panic_vmbus_unload(struct notifier_block *nb, unsigned long val,
 			      void *args)
 {
-	struct pt_regs *regs;
-
 	vmbus_initiate_unload(true);
-
-	/*
-	 * Hyper-V should be notified only once about a panic.  If we will be
-	 * doing hv_kmsg_dump() with kmsg data later, don't do the notification
-	 * here.
-	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
-	    && hyperv_report_reg()) {
-		regs = current_pt_regs();
-		hyperv_report_panic(regs, val, false);
-	}
-	return NOTIFY_DONE;
-}
-
-static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
-			    void *args)
-{
-	struct die_args *die = args;
-	struct pt_regs *regs = die->regs;
-
-	/* Don't notify Hyper-V if the die event is other than oops */
-	if (val != DIE_OOPS)
-		return NOTIFY_DONE;
-
-	/*
-	 * Hyper-V should be notified only once about a panic.  If we will be
-	 * doing hv_kmsg_dump() with kmsg data later, don't do the notification
-	 * here.
-	 */
-	if (hyperv_report_reg())
-		hyperv_report_panic(regs, val, true);
 	return NOTIFY_DONE;
 }
-
-static struct notifier_block hyperv_die_block = {
-	.notifier_call = hyperv_die_event,
-};
-static struct notifier_block hyperv_panic_block = {
-	.notifier_call = hyperv_panic_event,
+static struct notifier_block hyperv_panic_vmbus_unload_block = {
+	.notifier_call	= hv_panic_vmbus_unload,
+	.priority	= INT_MIN + 1, /* almost the latest one to execute */
 };
 
 static const char *fb_mmio_name = "fb_range";
@@ -1356,98 +1313,6 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
- * buffer and call into Hyper-V to transfer the data.
- */
-static void hv_kmsg_dump(struct kmsg_dumper *dumper,
-			 enum kmsg_dump_reason reason)
-{
-	struct kmsg_dump_iter iter;
-	size_t bytes_written;
-
-	/* We are only interested in panics. */
-	if ((reason != KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
-		return;
-
-	/*
-	 * Write dump contents to the page. No need to synchronize; panic should
-	 * be single-threaded.
-	 */
-	kmsg_dump_rewind(&iter);
-	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
-			     &bytes_written);
-	if (!bytes_written)
-		return;
-	/*
-	 * P3 to contain the physical address of the panic page & P4 to
-	 * contain the size of the panic data in that page. Rest of the
-	 * registers are no-op when the NOTIFY_MSG flag is set.
-	 */
-	hv_set_register(HV_REGISTER_CRASH_P0, 0);
-	hv_set_register(HV_REGISTER_CRASH_P1, 0);
-	hv_set_register(HV_REGISTER_CRASH_P2, 0);
-	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
-	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
-
-	/*
-	 * Let Hyper-V know there is crash data available along with
-	 * the panic message.
-	 */
-	hv_set_register(HV_REGISTER_CRASH_CTL,
-	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
-}
-
-static struct kmsg_dumper hv_kmsg_dumper = {
-	.dump = hv_kmsg_dump,
-};
-
-static void hv_kmsg_dump_register(void)
-{
-	int ret;
-
-	hv_panic_page = hv_alloc_hyperv_zeroed_page();
-	if (!hv_panic_page) {
-		pr_err("Hyper-V: panic message page memory allocation failed\n");
-		return;
-	}
-
-	ret = kmsg_dump_register(&hv_kmsg_dumper);
-	if (ret) {
-		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
-		hv_free_hyperv_page((unsigned long)hv_panic_page);
-		hv_panic_page = NULL;
-	}
-}
-
-static struct ctl_table_header *hv_ctl_table_hdr;
-
-/*
- * sysctl option to allow the user to control whether kmsg data should be
- * reported to Hyper-V on panic.
- */
-static struct ctl_table hv_ctl_table[] = {
-	{
-		.procname       = "hyperv_record_panic_msg",
-		.data           = &sysctl_record_panic_msg,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{}
-};
-
-static struct ctl_table hv_root_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= hv_ctl_table
-	},
-	{}
-};
-
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
  *
@@ -1511,43 +1376,12 @@ static int vmbus_bus_init(void)
 	if (ret)
 		goto err_connect;
 
-	if (hv_is_isolation_supported())
-		sysctl_record_panic_msg = 0;
-
 	/*
-	 * Only register if the crash MSRs are available
-	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
-		u64 hyperv_crash_ctl;
-		/*
-		 * Panic message recording (sysctl_record_panic_msg)
-		 * is enabled by default in non-isolated guests and
-		 * disabled by default in isolated guests; the panic
-		 * message recording won't be available in isolated
-		 * guests should the following registration fail.
-		 */
-		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
-		if (!hv_ctl_table_hdr)
-			pr_err("Hyper-V: sysctl table register error");
-
-		/*
-		 * Register for panic kmsg callback only if the right
-		 * capability is supported by the hypervisor.
-		 */
-		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
-		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
-			hv_kmsg_dump_register();
-
-		register_die_notifier(&hyperv_die_block);
-	}
-
-	/*
-	 * Always register the panic notifier because we need to unload
-	 * the VMbus channel connection to prevent any VMbus
-	 * activity after the VM panics.
+	 * Always register the vmbus unload panic notifier because we
+	 * need to shut the VMbus channel connection on panic.
 	 */
 	atomic_notifier_chain_register(&panic_notifier_list,
-			       &hyperv_panic_block);
+			       &hyperv_panic_vmbus_unload_block);
 
 	vmbus_request_offers();
 
@@ -1565,8 +1399,6 @@ static int vmbus_bus_init(void)
 	}
 err_setup:
 	bus_unregister(&hv_bus);
-	unregister_sysctl_table(hv_ctl_table_hdr);
-	hv_ctl_table_hdr = NULL;
 	return ret;
 }
 
@@ -2812,21 +2644,13 @@ static void __exit vmbus_exit(void)
 	vmbus_free_channels();
 	kfree(vmbus_connection.channels);
 
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
-		kmsg_dump_unregister(&hv_kmsg_dumper);
-		unregister_die_notifier(&hyperv_die_block);
-	}
-
 	/*
-	 * The panic notifier is always registered, hence we should
+	 * The vmbus panic notifier is always registered, hence we should
 	 * also unconditionally unregister it here as well.
 	 */
 	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &hyperv_panic_block);
+					&hyperv_panic_vmbus_unload_block);
 
-	free_page((unsigned long)hv_panic_page);
-	unregister_sysctl_table(hv_ctl_table_hdr);
-	hv_ctl_table_hdr = NULL;
 	bus_unregister(&hv_bus);
 
 	cpuhp_remove_state(hyperv_cpuhp_online);
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index ea7609058a12..91359647d1e7 100644
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
index 4477b1ab7357..6d836f10b3de 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -189,7 +189,8 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
 
 static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
 {
-	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
+	return FIELD_GET(CORESIGHT_CLAIM_MASK,
+			 csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR));
 }
 
 static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 595ce5862056..b04612961a86 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -8,6 +8,7 @@
 
 #include <linux/amba/bus.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/coresight.h>
 #include <linux/pm_runtime.h>
@@ -32,6 +33,7 @@
  * Coresight device CLAIM protocol.
  * See PSCI - ARM DEN 0022D, Section: 6.8.1 Debug and Trace save and restore.
  */
+#define CORESIGHT_CLAIM_MASK		GENMASK(1, 0)
 #define CORESIGHT_CLAIM_SELF_HOSTED	BIT(1)
 
 #define TIMEOUT_US		100
diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
index 66dfa211e736..8e4cf9028b23 100644
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
 	.master_xfer	= osif_xfer,
 	.functionality	= osif_func,
@@ -143,6 +148,7 @@ static int osif_probe(struct usb_interface *interface,
 
 	priv->adapter.owner = THIS_MODULE;
 	priv->adapter.class = I2C_CLASS_HWMON;
+	priv->adapter.quirks = &osif_quirks;
 	priv->adapter.algo = &osif_algorithm;
 	priv->adapter.algo_data = priv;
 	snprintf(priv->adapter.name, sizeof(priv->adapter.name),
diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index d1fa9ff5aeab..204cc0883da6 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -140,6 +140,11 @@ static u32 usb_func(struct i2c_adapter *adapter)
 	return ret;
 }
 
+/* prevent invalid 0-length usb_control_msg */
+static const struct i2c_adapter_quirks usb_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN_READ,
+};
+
 /* This is the actual algorithm we define */
 static const struct i2c_algorithm usb_algorithm = {
 	.master_xfer	= usb_xfer,
@@ -244,6 +249,7 @@ static int i2c_tiny_usb_probe(struct usb_interface *interface,
 	/* setup i2c adapter description */
 	dev->adapter.owner = THIS_MODULE;
 	dev->adapter.class = I2C_CLASS_HWMON;
+	dev->adapter.quirks = &usb_quirks;
 	dev->adapter.algo = &usb_algorithm;
 	dev->adapter.algo_data = dev;
 	snprintf(dev->adapter.name, sizeof(dev->adapter.name),
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 7e2192870743..533667eefe41 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -476,6 +476,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		 * byte set to zero. */
 		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
 		break;
+
+	default:
+		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
+		goto irq_handled;
 	}
 
 	/*
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index fdb1b765206b..7f352a79c1a5 100644
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
index ec62a4811613..e0785935f4ba 100644
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
index 6f54501dc776..cb31ad917b35 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -459,8 +459,8 @@ void mbox_free_channel(struct mbox_chan *chan)
 	if (chan->txdone_method == TXDONE_BY_ACK)
 		chan->txdone_method = TXDONE_BY_POLL;
 
-	module_put(chan->mbox->dev->driver->owner);
 	spin_unlock_irqrestore(&chan->lock, flags);
+	module_put(chan->mbox->dev->driver->owner);
 }
 EXPORT_SYMBOL_GPL(mbox_free_channel);
 
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1ddae5c97239..2c7b3c8673de 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1741,7 +1741,12 @@ static void cache_set_flush(struct closure *cl)
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
index 99b4738e867a..21a1586c69a7 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -2381,7 +2381,7 @@ static int super_init_validation(struct raid_set *rs, struct md_rdev *rdev)
 	 */
 	sb_retrieve_failed_devices(sb, failed_devices);
 	rdev_for_each(r, mddev) {
-		if (test_bit(Journal, &rdev->flags) ||
+		if (test_bit(Journal, &r->flags) ||
 		    !r->sb_page)
 			continue;
 		sb2 = page_address(r->sb_page);
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 02629516748e..dac27206cd3d 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -546,7 +546,7 @@ static int md_bitmap_new_disk_sb(struct bitmap *bitmap)
 	 * is a good choice?  We choose COUNTER_MAX / 2 arbitrarily.
 	 */
 	write_behind = bitmap->mddev->bitmap_info.max_write_behind;
-	if (write_behind > COUNTER_MAX)
+	if (write_behind > COUNTER_MAX / 2)
 		write_behind = COUNTER_MAX / 2;
 	sb->write_behind = cpu_to_le32(write_behind);
 	bitmap->mddev->bitmap_info.max_write_behind = write_behind;
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
index ecf3b6562ba2..c83dd0acb5b0 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h
@@ -58,7 +58,6 @@
 #define CAST_OFBSIZE_LO			CAST_STATUS18
 #define CAST_OFBSIZE_HI			CAST_STATUS19
 
-#define MXC_MAX_SLOTS	1 /* TODO use all 4 slots*/
 /* JPEG-Decoder Wrapper Slot Registers 0..3 */
 #define SLOT_BASE			0x10000
 #define SLOT_STATUS			0x0
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 7d6dd7a4833c..6e8d95a2406f 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -330,6 +330,10 @@ static unsigned int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Debug level (0-3)");
 
+static unsigned int hw_timeout = 2000;
+module_param(hw_timeout, int, 0644);
+MODULE_PARM_DESC(hw_timeout, "MXC JPEG hw timeout, the number of milliseconds");
+
 static void mxc_jpeg_bytesperline(struct mxc_jpeg_q_data *q, u32 precision);
 static void mxc_jpeg_sizeimage(struct mxc_jpeg_q_data *q);
 
@@ -474,90 +478,86 @@ static void notify_src_chg(struct mxc_jpeg_ctx *ctx)
 	v4l2_event_queue_fh(&ctx->fh, &ev);
 }
 
-static int mxc_get_free_slot(struct mxc_jpeg_slot_data slot_data[], int n)
+static int mxc_get_free_slot(struct mxc_jpeg_slot_data *slot_data)
 {
-	int free_slot = 0;
+	if (!slot_data->used)
+		return slot_data->slot;
+	return -1;
+}
 
-	while (slot_data[free_slot].used && free_slot < n)
-		free_slot++;
+static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg)
+{
+	/* free descriptor for decoding/encoding phase */
+	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
+			  jpeg->slot_data.desc,
+			  jpeg->slot_data.desc_handle);
+	jpeg->slot_data.desc = NULL;
+	jpeg->slot_data.desc_handle = 0;
 
-	return free_slot; /* >=n when there are no more free slots */
+	/* free descriptor for encoder configuration phase / decoder DHT */
+	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
+			  jpeg->slot_data.cfg_desc,
+			  jpeg->slot_data.cfg_desc_handle);
+	jpeg->slot_data.cfg_desc_handle = 0;
+	jpeg->slot_data.cfg_desc = NULL;
+
+	/* free configuration stream */
+	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
+			  jpeg->slot_data.cfg_stream_vaddr,
+			  jpeg->slot_data.cfg_stream_handle);
+	jpeg->slot_data.cfg_stream_vaddr = NULL;
+	jpeg->slot_data.cfg_stream_handle = 0;
+
+	jpeg->slot_data.used = false;
 }
 
-static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg,
-				     unsigned int slot)
+static bool mxc_jpeg_alloc_slot_data(struct mxc_jpeg_dev *jpeg)
 {
 	struct mxc_jpeg_desc *desc;
 	struct mxc_jpeg_desc *cfg_desc;
 	void *cfg_stm;
 
-	if (jpeg->slot_data[slot].desc)
+	if (jpeg->slot_data.desc)
 		goto skip_alloc; /* already allocated, reuse it */
 
 	/* allocate descriptor for decoding/encoding phase */
 	desc = dma_alloc_coherent(jpeg->dev,
 				  sizeof(struct mxc_jpeg_desc),
-				  &jpeg->slot_data[slot].desc_handle,
+				  &jpeg->slot_data.desc_handle,
 				  GFP_ATOMIC);
 	if (!desc)
 		goto err;
-	jpeg->slot_data[slot].desc = desc;
+	jpeg->slot_data.desc = desc;
 
 	/* allocate descriptor for configuration phase (encoder only) */
 	cfg_desc = dma_alloc_coherent(jpeg->dev,
 				      sizeof(struct mxc_jpeg_desc),
-				      &jpeg->slot_data[slot].cfg_desc_handle,
+				      &jpeg->slot_data.cfg_desc_handle,
 				      GFP_ATOMIC);
 	if (!cfg_desc)
 		goto err;
-	jpeg->slot_data[slot].cfg_desc = cfg_desc;
+	jpeg->slot_data.cfg_desc = cfg_desc;
 
 	/* allocate configuration stream */
 	cfg_stm = dma_alloc_coherent(jpeg->dev,
 				     MXC_JPEG_MAX_CFG_STREAM,
-				     &jpeg->slot_data[slot].cfg_stream_handle,
+				     &jpeg->slot_data.cfg_stream_handle,
 				     GFP_ATOMIC);
 	if (!cfg_stm)
 		goto err;
-	memset(cfg_stm, 0, MXC_JPEG_MAX_CFG_STREAM);
-	jpeg->slot_data[slot].cfg_stream_vaddr = cfg_stm;
+	jpeg->slot_data.cfg_stream_vaddr = cfg_stm;
 
 skip_alloc:
-	jpeg->slot_data[slot].used = true;
+	jpeg->slot_data.used = true;
 
 	return true;
 err:
-	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", slot);
+	dev_err(jpeg->dev, "Could not allocate descriptors for slot %d", jpeg->slot_data.slot);
+	mxc_jpeg_free_slot_data(jpeg);
 
 	return false;
 }
 
-static void mxc_jpeg_free_slot_data(struct mxc_jpeg_dev *jpeg,
-				    unsigned int slot)
-{
-	if (slot >= MXC_MAX_SLOTS) {
-		dev_err(jpeg->dev, "Invalid slot %d, nothing to free.", slot);
-		return;
-	}
-
-	/* free descriptor for decoding/encoding phase */
-	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data[slot].desc,
-			  jpeg->slot_data[slot].desc_handle);
-
-	/* free descriptor for encoder configuration phase / decoder DHT */
-	dma_free_coherent(jpeg->dev, sizeof(struct mxc_jpeg_desc),
-			  jpeg->slot_data[slot].cfg_desc,
-			  jpeg->slot_data[slot].cfg_desc_handle);
-
-	/* free configuration stream */
-	dma_free_coherent(jpeg->dev, MXC_JPEG_MAX_CFG_STREAM,
-			  jpeg->slot_data[slot].cfg_stream_vaddr,
-			  jpeg->slot_data[slot].cfg_stream_handle);
-
-	jpeg->slot_data[slot].used = false;
-}
-
 static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,
 					       struct vb2_v4l2_buffer *src_buf,
 					       struct vb2_v4l2_buffer *dst_buf)
@@ -570,6 +570,26 @@ static void mxc_jpeg_check_and_set_last_buffer(struct mxc_jpeg_ctx *ctx,
 	}
 }
 
+static void mxc_jpeg_job_finish(struct mxc_jpeg_ctx *ctx, enum vb2_buffer_state state, bool reset)
+{
+	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
+	void __iomem *reg = jpeg->base_reg;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+
+	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(src_buf, state);
+	v4l2_m2m_buf_done(dst_buf, state);
+
+	mxc_jpeg_disable_irq(reg, ctx->slot);
+	jpeg->slot_data.used = false;
+	if (reset)
+		mxc_jpeg_sw_reset(reg);
+}
+
 static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 {
 	struct mxc_jpeg_dev *jpeg = priv;
@@ -602,6 +622,9 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 		goto job_unlock;
 	}
 
+	if (!jpeg->slot_data.used)
+		goto job_unlock;
+
 	dec_ret = readl(reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS));
 	writel(dec_ret, reg + MXC_SLOT_OFFSET(slot, SLOT_STATUS)); /* w1c */
 
@@ -666,14 +689,9 @@ static irqreturn_t mxc_jpeg_dec_irq(int irq, void *priv)
 	buf_state = VB2_BUF_STATE_DONE;
 
 buffers_done:
-	mxc_jpeg_disable_irq(reg, ctx->slot);
-	jpeg->slot_data[slot].used = false; /* unused, but don't free */
-	mxc_jpeg_check_and_set_last_buffer(ctx, src_buf, dst_buf);
-	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_buf_done(src_buf, buf_state);
-	v4l2_m2m_buf_done(dst_buf, buf_state);
+	mxc_jpeg_job_finish(ctx, buf_state, false);
 	spin_unlock(&jpeg->hw_lock);
+	cancel_delayed_work(&ctx->task_timer);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 	return IRQ_HANDLED;
 job_unlock:
@@ -826,13 +844,13 @@ static void mxc_jpeg_config_dec_desc(struct vb2_buffer *out_buf,
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	void __iomem *reg = jpeg->base_reg;
 	unsigned int slot = ctx->slot;
-	struct mxc_jpeg_desc *desc = jpeg->slot_data[slot].desc;
-	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data[slot].cfg_desc;
-	dma_addr_t desc_handle = jpeg->slot_data[slot].desc_handle;
-	dma_addr_t cfg_desc_handle = jpeg->slot_data[slot].cfg_desc_handle;
-	dma_addr_t cfg_stream_handle = jpeg->slot_data[slot].cfg_stream_handle;
-	unsigned int *cfg_size = &jpeg->slot_data[slot].cfg_stream_size;
-	void *cfg_stream_vaddr = jpeg->slot_data[slot].cfg_stream_vaddr;
+	struct mxc_jpeg_desc *desc = jpeg->slot_data.desc;
+	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data.cfg_desc;
+	dma_addr_t desc_handle = jpeg->slot_data.desc_handle;
+	dma_addr_t cfg_desc_handle = jpeg->slot_data.cfg_desc_handle;
+	dma_addr_t cfg_stream_handle = jpeg->slot_data.cfg_stream_handle;
+	unsigned int *cfg_size = &jpeg->slot_data.cfg_stream_size;
+	void *cfg_stream_vaddr = jpeg->slot_data.cfg_stream_vaddr;
 	struct mxc_jpeg_src_buf *jpeg_src_buf;
 
 	jpeg_src_buf = vb2_to_mxc_buf(src_buf);
@@ -888,18 +906,18 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
 	void __iomem *reg = jpeg->base_reg;
 	unsigned int slot = ctx->slot;
-	struct mxc_jpeg_desc *desc = jpeg->slot_data[slot].desc;
-	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data[slot].cfg_desc;
-	dma_addr_t desc_handle = jpeg->slot_data[slot].desc_handle;
-	dma_addr_t cfg_desc_handle = jpeg->slot_data[slot].cfg_desc_handle;
-	void *cfg_stream_vaddr = jpeg->slot_data[slot].cfg_stream_vaddr;
+	struct mxc_jpeg_desc *desc = jpeg->slot_data.desc;
+	struct mxc_jpeg_desc *cfg_desc = jpeg->slot_data.cfg_desc;
+	dma_addr_t desc_handle = jpeg->slot_data.desc_handle;
+	dma_addr_t cfg_desc_handle = jpeg->slot_data.cfg_desc_handle;
+	void *cfg_stream_vaddr = jpeg->slot_data.cfg_stream_vaddr;
 	struct mxc_jpeg_q_data *q_data;
 	enum mxc_jpeg_image_format img_fmt;
 	int w, h;
 
 	q_data = mxc_jpeg_get_q_data(ctx, src_buf->vb2_queue->type);
 
-	jpeg->slot_data[slot].cfg_stream_size =
+	jpeg->slot_data.cfg_stream_size =
 			mxc_jpeg_setup_cfg_stream(cfg_stream_vaddr,
 						  q_data->fmt->fourcc,
 						  q_data->w,
@@ -908,7 +926,7 @@ static void mxc_jpeg_config_enc_desc(struct vb2_buffer *out_buf,
 	/* chain the config descriptor with the encoding descriptor */
 	cfg_desc->next_descpt_ptr = desc_handle | MXC_NXT_DESCPT_EN;
 
-	cfg_desc->buf_base0 = jpeg->slot_data[slot].cfg_stream_handle;
+	cfg_desc->buf_base0 = jpeg->slot_data.cfg_stream_handle;
 	cfg_desc->buf_base1 = 0;
 	cfg_desc->line_pitch = 0;
 	cfg_desc->stm_bufbase = 0; /* no output expected */
@@ -1004,6 +1022,23 @@ static int mxc_jpeg_job_ready(void *priv)
 	return ctx->source_change ? 0 : 1;
 }
 
+static void mxc_jpeg_device_run_timeout(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct mxc_jpeg_ctx *ctx = container_of(dwork, struct mxc_jpeg_ctx, task_timer);
+	struct mxc_jpeg_dev *jpeg = ctx->mxc_jpeg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->mxc_jpeg->hw_lock, flags);
+	if (ctx->mxc_jpeg->slot_data.used) {
+		dev_warn(jpeg->dev, "%s timeout, cancel it\n",
+			 ctx->mxc_jpeg->mode == MXC_JPEG_DECODE ? "decode" : "encode");
+		mxc_jpeg_job_finish(ctx, VB2_BUF_STATE_ERROR, true);
+		v4l2_m2m_job_finish(ctx->mxc_jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	}
+	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
+}
+
 static void mxc_jpeg_device_run(void *priv)
 {
 	struct mxc_jpeg_ctx *ctx = priv;
@@ -1063,12 +1098,12 @@ static void mxc_jpeg_device_run(void *priv)
 	mxc_jpeg_enable(reg);
 	mxc_jpeg_set_l_endian(reg, 1);
 
-	ctx->slot = mxc_get_free_slot(jpeg->slot_data, MXC_MAX_SLOTS);
-	if (ctx->slot >= MXC_MAX_SLOTS) {
+	ctx->slot = mxc_get_free_slot(&jpeg->slot_data);
+	if (ctx->slot < 0) {
 		dev_err(dev, "No more free slots\n");
 		goto end;
 	}
-	if (!mxc_jpeg_alloc_slot_data(jpeg, ctx->slot)) {
+	if (!mxc_jpeg_alloc_slot_data(jpeg)) {
 		dev_err(dev, "Cannot allocate slot data\n");
 		goto end;
 	}
@@ -1089,6 +1124,7 @@ static void mxc_jpeg_device_run(void *priv)
 					 &src_buf->vb2_buf, &dst_buf->vb2_buf);
 		mxc_jpeg_dec_mode_go(dev, reg);
 	}
+	schedule_delayed_work(&ctx->task_timer, msecs_to_jiffies(hw_timeout));
 end:
 	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
 }
@@ -1681,7 +1717,8 @@ static int mxc_jpeg_open(struct file *file)
 	}
 	ctx->fh.ctrl_handler = &ctx->ctrl_handler;
 	mxc_jpeg_set_default_params(ctx);
-	ctx->slot = MXC_MAX_SLOTS; /* slot not allocated yet */
+	ctx->slot = -1; /* slot not allocated yet */
+	INIT_DELAYED_WORK(&ctx->task_timer, mxc_jpeg_device_run_timeout);
 
 	if (mxc_jpeg->mode == MXC_JPEG_DECODE)
 		dev_dbg(dev, "Opened JPEG decoder instance %p\n", ctx);
@@ -2132,6 +2169,11 @@ static int mxc_jpeg_attach_pm_domains(struct mxc_jpeg_dev *jpeg)
 		dev_err(dev, "No power domains defined for jpeg node\n");
 		return jpeg->num_domains;
 	}
+	if (jpeg->num_domains == 1) {
+		/* genpd_dev_pm_attach() attach automatically if power domains count is 1 */
+		jpeg->num_domains = 0;
+		return 0;
+	}
 
 	jpeg->pd_dev = devm_kmalloc_array(dev, jpeg->num_domains,
 					  sizeof(*jpeg->pd_dev), GFP_KERNEL);
@@ -2173,7 +2215,6 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	int ret;
 	int mode;
 	const struct of_device_id *of_id;
-	unsigned int slot;
 
 	of_id = of_match_node(mxc_jpeg_match, dev->of_node);
 	mode = *(const int *)of_id->data;
@@ -2195,19 +2236,22 @@ static int mxc_jpeg_probe(struct platform_device *pdev)
 	if (IS_ERR(jpeg->base_reg))
 		return PTR_ERR(jpeg->base_reg);
 
-	for (slot = 0; slot < MXC_MAX_SLOTS; slot++) {
-		dec_irq = platform_get_irq(pdev, slot);
-		if (dec_irq < 0) {
-			ret = dec_irq;
-			goto err_irq;
-		}
-		ret = devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
-				       0, pdev->name, jpeg);
-		if (ret) {
-			dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
-				dec_irq, ret);
-			goto err_irq;
-		}
+	ret = of_property_read_u32_index(pdev->dev.of_node, "slot", 0, &jpeg->slot_data.slot);
+	if (ret)
+		jpeg->slot_data.slot = 0;
+	dev_info(&pdev->dev, "choose slot %d\n", jpeg->slot_data.slot);
+	dec_irq = platform_get_irq(pdev, 0);
+	if (dec_irq < 0) {
+		dev_err(&pdev->dev, "Failed to get irq %d\n", dec_irq);
+		ret = dec_irq;
+		goto err_irq;
+	}
+	ret = devm_request_irq(&pdev->dev, dec_irq, mxc_jpeg_dec_irq,
+			       0, pdev->name, jpeg);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request irq %d (%d)\n",
+			dec_irq, ret);
+		goto err_irq;
 	}
 
 	jpeg->pdev = pdev;
@@ -2367,11 +2411,9 @@ static const struct dev_pm_ops	mxc_jpeg_pm_ops = {
 
 static int mxc_jpeg_remove(struct platform_device *pdev)
 {
-	unsigned int slot;
 	struct mxc_jpeg_dev *jpeg = platform_get_drvdata(pdev);
 
-	for (slot = 0; slot < MXC_MAX_SLOTS; slot++)
-		mxc_jpeg_free_slot_data(jpeg, slot);
+	mxc_jpeg_free_slot_data(jpeg);
 
 	pm_runtime_disable(&pdev->dev);
 	video_unregister_device(jpeg->dec_vdev);
diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
index d742b638ddc9..00ecb976fd75 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h
@@ -92,14 +92,16 @@ struct mxc_jpeg_ctx {
 	struct mxc_jpeg_q_data		cap_q;
 	struct v4l2_fh			fh;
 	enum mxc_jpeg_enc_state		enc_state;
-	unsigned int			slot;
+	int				slot;
 	unsigned int			source_change;
 	bool				header_parsed;
 	struct v4l2_ctrl_handler	ctrl_handler;
 	u8				jpeg_quality;
+	struct delayed_work		task_timer;
 };
 
 struct mxc_jpeg_slot_data {
+	int slot;
 	bool used;
 	struct mxc_jpeg_desc *desc; // enc/dec descriptor
 	struct mxc_jpeg_desc *cfg_desc; // configuration descriptor
@@ -122,7 +124,7 @@ struct mxc_jpeg_dev {
 	struct v4l2_device		v4l2_dev;
 	struct v4l2_m2m_dev		*m2m_dev;
 	struct video_device		*dec_vdev;
-	struct mxc_jpeg_slot_data	slot_data[MXC_MAX_SLOTS];
+	struct mxc_jpeg_slot_data	slot_data;
 	int				num_domains;
 	struct device			**pd_dev;
 	struct device_link		**pd_link;
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 618e66784d0e..466f947ef440 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1752,7 +1752,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 	unsigned int processed_ctrls = 0;
 	struct uvc_control *ctrl;
 	unsigned int i;
-	int ret;
+	int ret = 0;
 
 	if (entity == NULL)
 		return 0;
@@ -1781,8 +1781,6 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 				dev->intfnum, ctrl->info.selector,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
 				ctrl->info.size);
-		else
-			ret = 0;
 
 		if (!ret)
 			processed_ctrls++;
@@ -1794,17 +1792,24 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
 
 		ctrl->dirty = 0;
 
-		if (ret < 0) {
+		if (!rollback && handle && !ret &&
+		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+			uvc_ctrl_set_handle(handle, ctrl, handle);
+
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
-
-		if (!rollback && handle &&
-		    ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-			uvc_ctrl_set_handle(handle, ctrl, handle);
 	}
 
+	if (ret)
+		return ret;
+
 	return processed_ctrls;
 }
 
@@ -1835,7 +1840,8 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_control *err_ctrl;
 	struct uvc_entity *entity;
-	int ret = 0;
+	int ret_out = 0;
+	int ret;
 
 	/* Find the control. */
 	list_for_each_entry(entity, &chain->entities, chain) {
@@ -1846,17 +1852,23 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
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
index d44ad6f33742..61a5ccafa18e 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -467,6 +467,7 @@ static void max14577_i2c_remove(struct i2c_client *i2c)
 {
 	struct max14577 *max14577 = i2c_get_clientdata(i2c);
 
+	device_init_wakeup(max14577->dev, false);
 	mfd_remove_devices(max14577->dev);
 	regmap_del_irq_chip(max14577->irq, max14577->irq_data);
 	if (max14577->dev_type == MAXIM_DEVICE_TYPE_MAX77836)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
index caab3d626a2a..63e067038385 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c
@@ -98,7 +98,6 @@ static int bnxt_hwrm_queue_cos2bw_cfg(struct bnxt *bp, struct ieee_ets *ets,
 {
 	struct hwrm_queue_cos2bw_cfg_input *req;
 	struct bnxt_cos2bw_cfg cos2bw;
-	void *data;
 	int rc, i;
 
 	rc = hwrm_req_init(bp, req, HWRM_QUEUE_COS2BW_CFG);
@@ -129,11 +128,15 @@ static int bnxt_hwrm_queue_cos2bw_cfg(struct bnxt *bp, struct ieee_ets *ets,
 				cpu_to_le32((ets->tc_tx_bw[i] * 100) |
 					    BW_VALUE_UNIT_PERCENT1_100);
 		}
-		data = &req->unused_0 + qidx * (sizeof(cos2bw) - 4);
-		memcpy(data, &cos2bw.queue_id, sizeof(cos2bw) - 4);
 		if (qidx == 0) {
 			req->queue_id0 = cos2bw.queue_id;
-			req->unused_0 = 0;
+			req->queue_id0_min_bw = cos2bw.min_bw;
+			req->queue_id0_max_bw = cos2bw.max_bw;
+			req->queue_id0_tsa_assign = cos2bw.tsa;
+			req->queue_id0_pri_lvl = cos2bw.pri_lvl;
+			req->queue_id0_bw_weight = cos2bw.bw_weight;
+		} else {
+			memcpy(&req->cfg[i - 1], &cos2bw.cfg, sizeof(cos2bw.cfg));
 		}
 	}
 	return hwrm_req_send(bp, req);
@@ -144,7 +147,6 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt *bp, struct ieee_ets *ets)
 	struct hwrm_queue_cos2bw_qcfg_output *resp;
 	struct hwrm_queue_cos2bw_qcfg_input *req;
 	struct bnxt_cos2bw_cfg cos2bw;
-	void *data;
 	int rc, i;
 
 	rc = hwrm_req_init(bp, req, HWRM_QUEUE_COS2BW_QCFG);
@@ -158,13 +160,19 @@ static int bnxt_hwrm_queue_cos2bw_qcfg(struct bnxt *bp, struct ieee_ets *ets)
 		return rc;
 	}
 
-	data = &resp->queue_id0 + offsetof(struct bnxt_cos2bw_cfg, queue_id);
-	for (i = 0; i < bp->max_tc; i++, data += sizeof(cos2bw.cfg)) {
+	for (i = 0; i < bp->max_tc; i++) {
 		int tc;
 
-		memcpy(&cos2bw.cfg, data, sizeof(cos2bw.cfg));
-		if (i == 0)
+		if (i == 0) {
 			cos2bw.queue_id = resp->queue_id0;
+			cos2bw.min_bw = resp->queue_id0_min_bw;
+			cos2bw.max_bw = resp->queue_id0_max_bw;
+			cos2bw.tsa = resp->queue_id0_tsa_assign;
+			cos2bw.pri_lvl = resp->queue_id0_pri_lvl;
+			cos2bw.bw_weight = resp->queue_id0_bw_weight;
+		} else {
+			memcpy(&cos2bw.cfg, &resp->cfg[i - 1], sizeof(cos2bw.cfg));
+		}
 
 		tc = bnxt_queue_to_tc(bp, cos2bw.queue_id);
 		if (tc < 0)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
index fb78fc38530d..750a8bebd41d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h
@@ -5674,286 +5674,48 @@ struct hwrm_queue_cos2bw_qcfg_output {
 	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID0_TSA_ASSIGN_RESERVED_LAST  0xffUL
 	u8	queue_id0_pri_lvl;
 	u8	queue_id0_bw_weight;
-	u8	queue_id1;
-	__le32	queue_id1_min_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id1_max_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id1_tsa_assign;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID1_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id1_pri_lvl;
-	u8	queue_id1_bw_weight;
-	u8	queue_id2;
-	__le32	queue_id2_min_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id2_max_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id2_tsa_assign;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID2_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id2_pri_lvl;
-	u8	queue_id2_bw_weight;
-	u8	queue_id3;
-	__le32	queue_id3_min_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id3_max_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id3_tsa_assign;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID3_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id3_pri_lvl;
-	u8	queue_id3_bw_weight;
-	u8	queue_id4;
-	__le32	queue_id4_min_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id4_max_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id4_tsa_assign;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID4_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id4_pri_lvl;
-	u8	queue_id4_bw_weight;
-	u8	queue_id5;
-	__le32	queue_id5_min_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id5_max_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id5_tsa_assign;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID5_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id5_pri_lvl;
-	u8	queue_id5_bw_weight;
-	u8	queue_id6;
-	__le32	queue_id6_min_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id6_max_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id6_tsa_assign;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID6_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id6_pri_lvl;
-	u8	queue_id6_bw_weight;
-	u8	queue_id7;
-	__le32	queue_id7_min_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id7_max_bw;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id7_tsa_assign;
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID7_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id7_pri_lvl;
-	u8	queue_id7_bw_weight;
+	struct {
+		u8	queue_id;
+		__le32	queue_id_min_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_INVALID
+		__le32	queue_id_max_bw;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_INVALID
+		u8	queue_id_tsa_assign;
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_QCFG_RESP_QUEUE_ID_TSA_ASSIGN_RESERVED_LAST  0xffUL
+		u8	queue_id_pri_lvl;
+		u8	queue_id_bw_weight;
+	} __packed cfg[7];
 	u8	unused_2[4];
 	u8	valid;
 };
@@ -6017,286 +5779,48 @@ struct hwrm_queue_cos2bw_cfg_input {
 	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID0_TSA_ASSIGN_RESERVED_LAST  0xffUL
 	u8	queue_id0_pri_lvl;
 	u8	queue_id0_bw_weight;
-	u8	queue_id1;
-	__le32	queue_id1_min_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id1_max_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id1_tsa_assign;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID1_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id1_pri_lvl;
-	u8	queue_id1_bw_weight;
-	u8	queue_id2;
-	__le32	queue_id2_min_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id2_max_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id2_tsa_assign;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID2_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id2_pri_lvl;
-	u8	queue_id2_bw_weight;
-	u8	queue_id3;
-	__le32	queue_id3_min_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id3_max_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id3_tsa_assign;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID3_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id3_pri_lvl;
-	u8	queue_id3_bw_weight;
-	u8	queue_id4;
-	__le32	queue_id4_min_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id4_max_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id4_tsa_assign;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID4_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id4_pri_lvl;
-	u8	queue_id4_bw_weight;
-	u8	queue_id5;
-	__le32	queue_id5_min_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id5_max_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id5_tsa_assign;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID5_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id5_pri_lvl;
-	u8	queue_id5_bw_weight;
-	u8	queue_id6;
-	__le32	queue_id6_min_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id6_max_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id6_tsa_assign;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID6_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id6_pri_lvl;
-	u8	queue_id6_bw_weight;
-	u8	queue_id7;
-	__le32	queue_id7_min_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MIN_BW_BW_VALUE_UNIT_INVALID
-	__le32	queue_id7_max_bw;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_MASK             0xfffffffUL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_SFT              0
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE                     0x10000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_BITS                  (0x0UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_SCALE_BYTES
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_SFT         29
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_MAX_BW_BW_VALUE_UNIT_INVALID
-	u8	queue_id7_tsa_assign;
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_SP             0x0UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_ETS            0x1UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_RESERVED_FIRST 0x2UL
-	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID7_TSA_ASSIGN_RESERVED_LAST  0xffUL
-	u8	queue_id7_pri_lvl;
-	u8	queue_id7_bw_weight;
+	struct {
+		u8	queue_id;
+		__le32	queue_id_min_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MIN_BW_BW_VALUE_UNIT_INVALID
+		__le32	queue_id_max_bw;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_MASK             0xfffffffUL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_SFT              0
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_SCALE                     0x10000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_SCALE_BITS                  (0x0UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_SCALE_BYTES                 (0x1UL << 28)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_SCALE_LAST                 QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_SCALE_BYTES
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_MASK        0xe0000000UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_SFT         29
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_MEGA          (0x0UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_KILO          (0x2UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_BASE          (0x4UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_GIGA          (0x6UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_PERCENT1_100  (0x1UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_INVALID       (0x7UL << 29)
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_LAST         QUEUE_COS2BW_CFG_REQ_QUEUE_ID_MAX_BW_BW_VALUE_UNIT_INVALID
+		u8	queue_id_tsa_assign;
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_TSA_ASSIGN_SP             0x0UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_TSA_ASSIGN_ETS            0x1UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_TSA_ASSIGN_RESERVED_FIRST 0x2UL
+	#define QUEUE_COS2BW_CFG_REQ_QUEUE_ID_TSA_ASSIGN_RESERVED_LAST  0xffUL
+		u8	queue_id_pri_lvl;
+		u8	queue_id_bw_weight;
+	} __packed cfg[7];
 	u8	unused_1[5];
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 18ca1f42b1f7..04d3e0dedc96 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -461,7 +461,7 @@ static inline u64 _enetc_rd_reg64(void __iomem *reg)
 		tmp = ioread32(reg + 4);
 	} while (high != tmp);
 
-	return le64_to_cpu((__le64)high << 32 | low);
+	return (u64)high << 32 | low;
 }
 #endif
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index acf73a91e87e..bdc70025fb53 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -438,7 +438,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 {
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
-	void *cookie = READ_ONCE(ioucmd->cookie);
 
 	req->bio = pdu->bio;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
@@ -451,14 +450,14 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	pdu->u.result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
-	 * For iopoll, complete it directly.
-	 * Otherwise, move the completion to task work.
+	 * IOPOLL could potentially complete this request directly, but
+	 * if multiple rings are polling on the same queue, then it's possible
+	 * for one ring to find completions for another ring. Punting the
+	 * completion via task_work will always direct it to the right
+	 * location, rather than potentially complete requests for ringA
+	 * under iopoll invocations from ringB.
 	 */
-	if (cookie != NULL && blk_rq_is_poll(req))
-		nvme_uring_task_cb(ioucmd, IO_URING_F_UNLOCKED);
-	else
-		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
-
+	io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
 	return RQ_END_IO_FREE;
 }
 
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 487d01f6b4f5..1113e21ee386 100644
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
index 17885c9f55cb..6a94f4965a2d 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1155,7 +1155,7 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
 }
 
 static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 247e84e989aa..0d398029b2af 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5909,7 +5909,11 @@ megasas_set_high_iops_queue_affinity_and_hint(struct megasas_instance *instance)
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
diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index ac731415f733..904beca2c02d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -869,29 +869,21 @@ static signed int aes_cipher(u8 *key, uint	hdrlen,
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
@@ -1081,15 +1073,15 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
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
@@ -1097,14 +1089,6 @@ static signed int aes_decipher(u8 *key, uint	hdrlen,
 
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
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fe22ca009fb3..e1d88a499554 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -239,6 +239,7 @@ struct imx_port {
 	enum imx_tx_state	tx_state;
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
+	unsigned int		rxtl;
 };
 
 struct imx_port_ucrs {
@@ -1320,6 +1321,7 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
 
 #define TXTL_DEFAULT 8
 #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
+#define RXTL_CONSOLE_DEFAULT 1
 #define TXTL_DMA 8 /* DMA burst setting */
 #define RXTL_DMA 9 /* DMA burst setting */
 
@@ -1432,7 +1434,7 @@ static void imx_uart_disable_dma(struct imx_port *sport)
 	ucr1 &= ~(UCR1_RXDMAEN | UCR1_TXDMAEN | UCR1_ATDMAEN);
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	sport->dma_is_enabled = 0;
 }
@@ -1457,7 +1459,12 @@ static int imx_uart_startup(struct uart_port *port)
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
@@ -1906,7 +1913,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 	if (retval)
 		clk_disable_unprepare(sport->clk_ipg);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 
@@ -1998,7 +2005,7 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 		/* If the receiver trigger is 0, set it to a default value */
 		ufcr = imx_uart_readl(sport, UFCR);
 		if ((ufcr & UFCR_RXTL_MASK) == 0)
-			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 		imx_uart_start_rx(port);
 	}
 
@@ -2183,7 +2190,7 @@ imx_uart_console_setup(struct console *co, char *options)
 	else
 		imx_uart_console_get_options(sport, &baud, &parity, &bits);
 
-	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, sport->rxtl);
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index eca41ac5477c..a75677d5cbef 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -879,16 +879,6 @@ static int ulite_probe(struct platform_device *pdev)
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
@@ -930,16 +920,25 @@ static struct platform_driver ulite_platform_driver = {
 
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
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e1b40a384868..ccfd9d93c10c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1014,7 +1014,7 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 	}
 
 	if (redraw) {
-		int update;
+		bool update;
 		int old_was_color = vc->vc_can_do_color;
 
 		set_origin(vc);
@@ -1050,7 +1050,7 @@ int vc_cons_allocated(unsigned int i)
 	return (i < MAX_NR_CONSOLES && vc_cons[i].d);
 }
 
-static void visual_init(struct vc_data *vc, int num, int init)
+static void visual_init(struct vc_data *vc, int num, bool init)
 {
 	/* ++Geert: vc->vc_sw->con_init determines console size */
 	if (vc->vc_sw)
@@ -1134,7 +1134,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	vc->port.ops = &vc_port_ops;
 	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 
-	visual_init(vc, currcons, 1);
+	visual_init(vc, currcons, true);
 
 	if (!*vc->uni_pagedict_loc)
 		con_set_default_unimap(vc);
@@ -1628,7 +1628,7 @@ static void csi_X(struct vc_data *vc, unsigned int vpar)
 	vc_uniscr_clear_line(vc, vc->state.x, count);
 	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
 	if (con_should_update(vc))
-		vc->vc_sw->con_clear(vc, vc->state.y, vc->state.x, 1, count);
+		vc->vc_sw->con_clear(vc, vc->state.y, vc->state.x, count);
 	vc->vc_need_wrap = 0;
 }
 
@@ -3530,7 +3530,7 @@ static int __init con_init(void)
 		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
 		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
 		tty_port_init(&vc->port);
-		visual_init(vc, currcons, 1);
+		visual_init(vc, currcons, true);
 		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
 		vc_init(vc, vc->vc_rows, vc->vc_cols,
@@ -3701,7 +3701,7 @@ static int do_bind_con_driver(const struct consw *csw, int first, int last,
 		old_was_color = vc->vc_can_do_color;
 		vc->vc_sw->con_deinit(vc);
 		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
-		visual_init(vc, i, 0);
+		visual_init(vc, i, false);
 		set_origin(vc);
 		update_attr(vc);
 
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 94dda3d4d509..2cfe0087abc1 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -249,6 +249,7 @@ hv_uio_probe(struct hv_device *dev,
 	struct hv_uio_private_data *pdata;
 	void *ring_buffer;
 	int ret;
+	size_t ring_size = hv_dev_ring_size(channel);
 
 	/* Communicating with host has to be via shared memory not hypercall */
 	if (!channel->offermsg.monitor_allocated) {
@@ -256,12 +257,17 @@ hv_uio_probe(struct hv_device *dev,
 		return -ENOTSUPP;
 	}
 
+	if (!ring_size)
+		ring_size = HV_RING_SIZE * PAGE_SIZE;
+
+	/* Adjust ring size if necessary to have it page aligned */
+	ring_size = VMBUS_RING_SIZE(ring_size);
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = vmbus_alloc_ring(channel, HV_RING_SIZE * PAGE_SIZE,
-			       HV_RING_SIZE * PAGE_SIZE);
+	ret = vmbus_alloc_ring(channel, ring_size, ring_size);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index e3408a67af45..3da91bb8b316 100644
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
@@ -1015,7 +1010,7 @@ static void service_interrupt_work(struct work_struct *work)
 
 	spin_lock_irq(&desc->iuspin);
 	service_outstanding_interrupt(desc);
-	if (!desc->resp_count) {
+	if (!desc->resp_count && (desc->length || desc->rerr)) {
 		set_bit(WDM_READ, &desc->flags);
 		wake_up(&desc->wait);
 	}
diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
index 3f5180d64931..91461c744fcd 100644
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
@@ -277,6 +293,9 @@ static int usb_conn_remove(struct platform_device *pdev)
 
 	cancel_delayed_work_sync(&info->dw_det);
 
+	if (info->charger)
+		ida_free(&usb_conn_ida, info->conn_id);
+
 	if (info->last_role == USB_ROLE_HOST && info->vbus)
 		regulator_disable(info->vbus);
 
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 3500e3c94c4b..2215f8ca5417 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -704,15 +704,16 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 		dev_set_name(&dev->dev, "usb%d", bus->busnum);
 		root_hub = 1;
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
@@ -721,6 +722,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
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
index cea6c4fc7995..d4ca1677ad23 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4602,6 +4602,12 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
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
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 3c9541357c24..55a81ad6837b 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1321,14 +1321,14 @@ static struct se_portal_group *usbg_make_tpg(struct se_wwn *wwn,
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
index f80124102328..26e0e72f4f16 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -320,6 +320,10 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
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
index 941735c73161..a74f8e1a28c2 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -214,7 +214,7 @@ int typec_switch_set(struct typec_switch *sw,
 		sw_dev = sw->sw_devs[i];
 
 		ret = sw_dev->set(sw_dev, orientation);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 
@@ -421,7 +421,7 @@ int typec_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 		mux_dev = mux->mux_devs[i];
 
 		ret = mux_dev->set(mux_dev, state);
-		if (ret)
+		if (ret && ret != -EOPNOTSUPP)
 			return ret;
 	}
 
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index f1711b2f9ff0..d99e1b3e4e5c 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -82,6 +82,15 @@ static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 	/* Redraw, so that we get putc(s) for output done while blanked */
 	return 1;
 }
+
+static bool dummycon_switch(struct vc_data *vc)
+{
+	/*
+	 * Redraw, so that we get putc(s) for output done while switched
+	 * away. Informs deferred consoles to take over the display.
+	 */
+	return true;
+}
 #else
 static void dummycon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
 static void dummycon_putcs(struct vc_data *vc, const unsigned short *s,
@@ -90,6 +99,10 @@ static int dummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 {
 	return 0;
 }
+static bool dummycon_switch(struct vc_data *vc)
+{
+	return false;
+}
 #endif
 
 static const char *dummycon_startup(void)
@@ -97,7 +110,7 @@ static const char *dummycon_startup(void)
     return "dummy device";
 }
 
-static void dummycon_init(struct vc_data *vc, int init)
+static void dummycon_init(struct vc_data *vc, bool init)
 {
     vc->vc_can_do_color = 1;
     if (init) {
@@ -108,8 +121,8 @@ static void dummycon_init(struct vc_data *vc, int init)
 }
 
 static void dummycon_deinit(struct vc_data *vc) { }
-static void dummycon_clear(struct vc_data *vc, int sy, int sx, int height,
-			   int width) { }
+static void dummycon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			   unsigned int width) { }
 static void dummycon_cursor(struct vc_data *vc, int mode) { }
 
 static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
@@ -119,11 +132,6 @@ static bool dummycon_scroll(struct vc_data *vc, unsigned int top,
 	return false;
 }
 
-static int dummycon_switch(struct vc_data *vc)
-{
-	return 0;
-}
-
 /*
  *  The console `switch' structure for the dummy console
  *
diff --git a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
index ef29b321967f..26b41a8f36c8 100644
--- a/drivers/video/console/mdacon.c
+++ b/drivers/video/console/mdacon.c
@@ -352,7 +352,7 @@ static const char *mdacon_startup(void)
 	return "MDA-2";
 }
 
-static void mdacon_init(struct vc_data *c, int init)
+static void mdacon_init(struct vc_data *c, bool init)
 {
 	c->vc_complement_mask = 0x0800;	 /* reverse video */
 	c->vc_display_fg = &mda_display_fg;
@@ -442,26 +442,21 @@ static void mdacon_putcs(struct vc_data *c, const unsigned short *s,
 	}
 }
 
-static void mdacon_clear(struct vc_data *c, int y, int x, 
-			  int height, int width)
+static void mdacon_clear(struct vc_data *c, unsigned int y, unsigned int x,
+			 unsigned int width)
 {
 	u16 *dest = mda_addr(x, y);
 	u16 eattr = mda_convert_attr(c->vc_video_erase_char);
 
-	if (width <= 0 || height <= 0)
+	if (width <= 0)
 		return;
 
-	if (x==0 && width==mda_num_columns) {
-		scr_memsetw(dest, eattr, height*width*2);
-	} else {
-		for (; height > 0; height--, dest+=mda_num_columns)
-			scr_memsetw(dest, eattr, width*2);
-	}
+	scr_memsetw(dest, eattr, width * 2);
 }
-                        
-static int mdacon_switch(struct vc_data *c)
+
+static bool mdacon_switch(struct vc_data *c)
 {
-	return 1;	/* redrawing needed */
+	return true;	/* redrawing needed */
 }
 
 static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index d9c682ae0392..1ebb18bf1098 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -324,7 +324,7 @@ static const char *newport_startup(void)
 	return NULL;
 }
 
-static void newport_init(struct vc_data *vc, int init)
+static void newport_init(struct vc_data *vc, bool init)
 {
 	int cols, rows;
 
@@ -346,12 +346,12 @@ static void newport_deinit(struct vc_data *c)
 	}
 }
 
-static void newport_clear(struct vc_data *vc, int sy, int sx, int height,
-			  int width)
+static void newport_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			  unsigned int width)
 {
 	int xend = ((sx + width) << 3) - 1;
 	int ystart = ((sy << 4) + topscan) & 0x3ff;
-	int yend = (((sy + height) << 4) + topscan - 1) & 0x3ff;
+	int yend = (((sy + 1) << 4) + topscan - 1) & 0x3ff;
 
 	if (logo_active)
 		return;
@@ -462,7 +462,7 @@ static void newport_cursor(struct vc_data *vc, int mode)
 	}
 }
 
-static int newport_switch(struct vc_data *vc)
+static bool newport_switch(struct vc_data *vc)
 {
 	static int logo_drawn = 0;
 
@@ -476,7 +476,7 @@ static int newport_switch(struct vc_data *vc)
 		}
 	}
 
-	return 1;
+	return true;
 }
 
 static int newport_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index f304163e87e9..6b82194a8ef3 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -272,7 +272,7 @@ static int sticon_font_set(struct vc_data *vc, struct console_font *font,
 	return sticon_set_font(vc, font);
 }
 
-static void sticon_init(struct vc_data *c, int init)
+static void sticon_init(struct vc_data *c, bool init)
 {
     struct sti_struct *sti = sticon_sti;
     int vc_cols, vc_rows;
@@ -299,19 +299,19 @@ static void sticon_deinit(struct vc_data *c)
 	sticon_set_def_font(i, NULL);
 }
 
-static void sticon_clear(struct vc_data *conp, int sy, int sx, int height,
-			 int width)
+static void sticon_clear(struct vc_data *conp, unsigned int sy, unsigned int sx,
+			 unsigned int width)
 {
-    if (!height || !width)
+    if (!width)
 	return;
 
-    sti_clear(sticon_sti, sy, sx, height, width,
+    sti_clear(sticon_sti, sy, sx, 1, width,
 	      conp->vc_video_erase_char, font_data[conp->vc_num]);
 }
 
-static int sticon_switch(struct vc_data *conp)
+static bool sticon_switch(struct vc_data *conp)
 {
-    return 1;	/* needs refreshing */
+    return true;	/* needs refreshing */
 }
 
 static int sticon_blank(struct vc_data *c, int blank, int mode_switch)
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index e960b27caada..81f27cd61027 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -65,16 +65,8 @@ static struct vgastate vgastate;
  *  Interface used by the world
  */
 
-static const char *vgacon_startup(void);
-static void vgacon_init(struct vc_data *c, int init);
-static void vgacon_deinit(struct vc_data *c);
-static void vgacon_cursor(struct vc_data *c, int mode);
-static int vgacon_switch(struct vc_data *c);
-static int vgacon_blank(struct vc_data *c, int blank, int mode_switch);
-static void vgacon_scrolldelta(struct vc_data *c, int lines);
 static int vgacon_set_origin(struct vc_data *c);
-static void vgacon_save_screen(struct vc_data *c);
-static void vgacon_invert_region(struct vc_data *c, u16 * p, int count);
+
 static struct uni_pagedict *vgacon_uni_pagedir;
 static int vgacon_refcount;
 
@@ -142,12 +134,6 @@ static inline void vga_set_mem_top(struct vc_data *c)
 	write_vga(12, (c->vc_visible_origin - vga_vram_base) / 2);
 }
 
-static void vgacon_restore_screen(struct vc_data *c)
-{
-	if (c->vc_origin != c->vc_visible_origin)
-		vgacon_scrolldelta(c, 0);
-}
-
 static void vgacon_scrolldelta(struct vc_data *c, int lines)
 {
 	vc_scrolldelta_helper(c, lines, vga_rolled_over, (void *)vga_vram_base,
@@ -155,6 +141,12 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	vga_set_mem_top(c);
 }
 
+static void vgacon_restore_screen(struct vc_data *c)
+{
+	if (c->vc_origin != c->vc_visible_origin)
+		vgacon_scrolldelta(c, 0);
+}
+
 static const char *vgacon_startup(void)
 {
 	const char *display_desc = NULL;
@@ -340,7 +332,7 @@ static const char *vgacon_startup(void)
 	return display_desc;
 }
 
-static void vgacon_init(struct vc_data *c, int init)
+static void vgacon_init(struct vc_data *c, bool init)
 {
 	struct uni_pagedict *p;
 
@@ -357,7 +349,7 @@ static void vgacon_init(struct vc_data *c, int init)
 	c->vc_scan_lines = vga_scan_lines;
 	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
 
-	/* set dimensions manually if init != 0 since vc_resize() will fail */
+	/* set dimensions manually if init is true since vc_resize() will fail */
 	if (init) {
 		c->vc_cols = vga_video_num_columns;
 		c->vc_rows = vga_video_num_lines;
@@ -603,7 +595,7 @@ static int vgacon_doresize(struct vc_data *c,
 	return 0;
 }
 
-static int vgacon_switch(struct vc_data *c)
+static bool vgacon_switch(struct vc_data *c)
 {
 	int x = c->vc_cols * VGA_FONTWIDTH;
 	int y = c->vc_rows * c->vc_cell_height;
@@ -632,7 +624,7 @@ static int vgacon_switch(struct vc_data *c)
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
 
-	return 0;		/* Redrawing not needed */
+	return false;		/* Redrawing not needed */
 }
 
 static void vga_set_palette(struct vc_data *vc, const unsigned char *table)
@@ -1174,8 +1166,8 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
  *  The console `switch' structure for the VGA based console
  */
 
-static void vgacon_clear(struct vc_data *vc, int sy, int sx, int height,
-			 int width) { }
+static void vgacon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			 unsigned int width) { }
 static void vgacon_putc(struct vc_data *vc, int c, int ypos, int xpos) { }
 static void vgacon_putcs(struct vc_data *vc, const unsigned short *s,
 			 int count, int ypos, int xpos) { }
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3f9d2178d387..1a1727418711 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -993,7 +993,7 @@ static const char *fbcon_startup(void)
 	return display_desc;
 }
 
-static void fbcon_init(struct vc_data *vc, int init)
+static void fbcon_init(struct vc_data *vc, bool init)
 {
 	struct fb_info *info;
 	struct fbcon_ops *ops;
@@ -1240,8 +1240,8 @@ static void fbcon_deinit(struct vc_data *vc)
  *  restriction is simplicity & efficiency at the moment.
  */
 
-static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
-			int width)
+static void __fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			  unsigned int height, unsigned int width)
 {
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
@@ -1280,6 +1280,12 @@ static void fbcon_clear(struct vc_data *vc, int sy, int sx, int height,
 		ops->clear(vc, info, real_y(p, sy), sx, height, width, fg, bg);
 }
 
+static void fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
+			unsigned int width)
+{
+	__fbcon_clear(vc, sy, sx, 1, width);
+}
+
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos)
 {
@@ -1768,7 +1774,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		case SCROLL_MOVE:
 			fbcon_redraw_blit(vc, info, p, t, b - t - count,
 				     count);
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
@@ -1791,7 +1797,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_up;
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_REDRAW:
@@ -1809,7 +1815,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 							  vc->vc_rows - b, b);
 			} else
 				fbcon_redraw_move(vc, p, t + count, b - t - count, t);
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_MOVE:
@@ -1832,14 +1838,14 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_up;
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_REDRAW:
 		      redraw_up:
 			fbcon_redraw(vc, p, t, b - t - count,
 				     count * vc->vc_cols);
-			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							(b - count)),
@@ -1856,7 +1862,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		case SCROLL_MOVE:
 			fbcon_redraw_blit(vc, info, p, b - 1, b - t - count,
 				     -count);
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							t),
@@ -1879,7 +1885,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_down;
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_MOVE:
@@ -1901,7 +1907,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					    b - t - count, vc->vc_cols);
 			else
 				goto redraw_down;
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_PAN_REDRAW:
@@ -1918,14 +1924,14 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					fbcon_redraw_move(vc, p, count, t, 0);
 			} else
 				fbcon_redraw_move(vc, p, t, b - t - count, t + count);
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			break;
 
 		case SCROLL_REDRAW:
 		      redraw_down:
 			fbcon_redraw(vc, p, b - 1, b - t - count,
 				     -count * vc->vc_cols);
-			fbcon_clear(vc, t, 0, count, vc->vc_cols);
+			__fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
 							vc->vc_size_row *
 							t),
@@ -2067,7 +2073,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	return 0;
 }
 
-static int fbcon_switch(struct vc_data *vc)
+static bool fbcon_switch(struct vc_data *vc)
 {
 	struct fb_info *info, *old_info = NULL;
 	struct fbcon_ops *ops;
@@ -2189,9 +2195,9 @@ static int fbcon_switch(struct vc_data *vc)
 			      vc->vc_origin + vc->vc_size_row * vc->vc_top,
 			      vc->vc_size_row * (vc->vc_bottom -
 						 vc->vc_top) / 2);
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
 static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
@@ -2204,7 +2210,7 @@ static void fbcon_generic_blank(struct vc_data *vc, struct fb_info *info,
 
 		oldc = vc->vc_video_erase_char;
 		vc->vc_video_erase_char &= charmask;
-		fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
+		__fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
 		vc->vc_video_erase_char = oldc;
 	}
 }
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 7355a299cdb5..f8c32c58b5b2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1536,7 +1536,7 @@ static int fb_check_foreignness(struct fb_info *fi)
 
 static int do_register_framebuffer(struct fb_info *fb_info)
 {
-	int i;
+	int i, err = 0;
 	struct fb_videomode mode;
 
 	if (fb_check_foreignness(fb_info))
@@ -1545,10 +1545,18 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (num_registered_fb == FB_MAX)
 		return -ENXIO;
 
-	num_registered_fb++;
 	for (i = 0 ; i < FB_MAX; i++)
 		if (!registered_fb[i])
 			break;
+
+	if (!fb_info->modelist.prev || !fb_info->modelist.next)
+		INIT_LIST_HEAD(&fb_info->modelist);
+
+	fb_var_to_videomode(&mode, &fb_info->var);
+	err = fb_add_videomode(&mode, &fb_info->modelist);
+	if (err < 0)
+		return err;
+
 	fb_info->node = i;
 	refcount_set(&fb_info->count, 1);
 	mutex_init(&fb_info->lock);
@@ -1581,16 +1589,12 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 	if (!fb_info->pixmap.blit_y)
 		fb_info->pixmap.blit_y = ~(u32)0;
 
-	if (!fb_info->modelist.prev || !fb_info->modelist.next)
-		INIT_LIST_HEAD(&fb_info->modelist);
-
 	if (fb_info->skip_vt_switch)
 		pm_vt_switch_required(fb_info->dev, false);
 	else
 		pm_vt_switch_required(fb_info->dev, true);
 
-	fb_var_to_videomode(&mode, &fb_info->var);
-	fb_add_videomode(&mode, &fb_info->modelist);
+	num_registered_fb++;
 	registered_fb[i] = fb_info;
 
 #ifdef CONFIG_GUMSTIX_AM200EPD
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 41c496ff55cc..dfb449f3e4a4 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1209,7 +1209,15 @@ static int hvfb_probe(struct hv_device *hdev,
 	par->fb_ready = true;
 
 	par->synchronous_fb = false;
+
+	/*
+	 * We need to be sure this panic notifier runs _before_ the
+	 * vmbus disconnect, so order it by priority. It must execute
+	 * before the function hv_panic_vmbus_unload() [drivers/hv/vmbus_drv.c],
+	 * which is almost at the end of list, with priority = INT_MIN + 1.
+	 */
 	par->hvfb_panic_nb.notifier_call = hvfb_on_panic;
+	par->hvfb_panic_nb.priority = INT_MIN + 10;
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &par->hvfb_panic_nb);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8c0da0025bc7..76a261cbf39d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2481,8 +2481,7 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		found = true;
 		root = read_tree_root_path(tree_root, path, &key);
 		if (IS_ERR(root)) {
-			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
-				ret = PTR_ERR(root);
+			ret = PTR_ERR(root);
 			break;
 		}
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2195e07803b8..f7f97cd3cdf0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9181,6 +9181,7 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	int ret;
 	int ret2;
 	bool need_abort = false;
+	bool logs_pinned = false;
 	struct fscrypt_name old_fname, new_fname;
 	struct fscrypt_str *old_name, *new_name;
 
@@ -9309,6 +9310,31 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	old_inode->i_ctime = ctime;
 	new_inode->i_ctime = ctime;
 
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
 				BTRFS_I(old_inode), 1);
@@ -9366,30 +9392,23 @@ static int btrfs_rename_exchange(struct inode *old_dir,
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
@@ -9439,6 +9458,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	int ret2;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
 	struct fscrypt_name old_fname, new_fname;
+	bool logs_pinned = false;
 
 	if (btrfs_ino(BTRFS_I(new_dir)) == BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)
 		return -EPERM;
@@ -9577,6 +9597,29 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	new_dir->i_ctime = old_dir->i_mtime;
 	old_inode->i_ctime = old_dir->i_mtime;
 
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
 				BTRFS_I(old_inode), 1);
@@ -9626,7 +9669,7 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
 	if (old_inode->i_nlink == 1)
 		BTRFS_I(old_inode)->dir_index = index;
 
-	if (old_ino != BTRFS_FIRST_FREE_OBJECTID)
+	if (logs_pinned)
 		btrfs_log_new_name(trans, old_dentry, BTRFS_I(old_dir),
 				   rename_ctx.index, new_dentry->d_parent);
 
@@ -9642,6 +9685,10 @@ static int btrfs_rename(struct user_namespace *mnt_userns,
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
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a4177014eb8b..628238493167 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3203,6 +3203,12 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
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
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 882eccfd67e8..3336647e64df 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2043,7 +2043,7 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 	s32 stripe_unit = ci->i_layout.stripe_unit;
 	s32 stripe_count = ci->i_layout.stripe_count;
 	s32 object_size = ci->i_layout.object_size;
-	u64 object_set_size = object_size * stripe_count;
+	u64 object_set_size = (u64) object_size * stripe_count;
 	u64 nearly, t;
 
 	/* round offset up to next period boundary */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f415bc073bb5..84fc6591e3f9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1753,26 +1753,32 @@ static int f2fs_statfs_project(struct super_block *sb,
 
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
diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 5e32526174e8..32ae408ee699 100644
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
index aae1a77ac2d3..67d89ebb5044 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2249,14 +2249,14 @@ static int attach_recursive_mnt(struct mount *source_mnt,
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
index f2e66b946f4b..e774cfc85eee 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -555,6 +555,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			set_nlink(inode, fattr->nlink);
 		else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
+		else
+			set_nlink(inode, 1);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
 		else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0f28607c5747..29f8a2df2c11 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6065,6 +6065,8 @@ static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
 	struct nfs_server *server = NFS_SERVER(inode);
 	int ret;
 
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	if (!nfs4_server_supports_acls(server, type))
 		return -EOPNOTSUPP;
 	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
@@ -6139,6 +6141,9 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
 {
 	struct nfs4_exception exception = { };
 	int err;
+
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	do {
 		err = __nfs4_proc_set_acl(inode, buf, buflen, type);
 		trace_nfs4_set_acl(inode, err);
@@ -10630,7 +10635,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3;
+	ssize_t error, error2, error3, error4;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10653,8 +10658,16 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
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
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index fa7fe2393ff6..425ff6800c41 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -14,7 +14,7 @@ static u32 omfs_max_extents(struct omfs_sb_info *sbi, int offset)
 {
 	return (sbi->s_sys_blocksize - offset -
 		sizeof(struct omfs_extent)) /
-		sizeof(struct omfs_extent_entry) + 1;
+		sizeof(struct omfs_extent_entry);
 }
 
 void omfs_make_empty_table(struct buffer_head *bh, int offset)
@@ -24,8 +24,8 @@ void omfs_make_empty_table(struct buffer_head *bh, int offset)
 	oe->e_next = ~cpu_to_be64(0ULL);
 	oe->e_extent_count = cpu_to_be32(1),
 	oe->e_fill = cpu_to_be32(0x22),
-	oe->e_entry.e_cluster = ~cpu_to_be64(0ULL);
-	oe->e_entry.e_blocks = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_cluster = ~cpu_to_be64(0ULL);
+	oe->e_entry[0].e_blocks = ~cpu_to_be64(0ULL);
 }
 
 int omfs_shrink_inode(struct inode *inode)
@@ -68,7 +68,7 @@ int omfs_shrink_inode(struct inode *inode)
 
 		last = next;
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		/* ignore last entry as it is the terminator */
 		for (; extent_count > 1; extent_count--) {
@@ -117,7 +117,7 @@ static int omfs_grow_extent(struct inode *inode, struct omfs_extent *oe,
 			u64 *ret_block)
 {
 	struct omfs_extent_entry *terminator;
-	struct omfs_extent_entry *entry = &oe->e_entry;
+	struct omfs_extent_entry *entry = oe->e_entry;
 	struct omfs_sb_info *sbi = OMFS_SB(inode->i_sb);
 	u32 extent_count = be32_to_cpu(oe->e_extent_count);
 	u64 new_block = 0;
@@ -245,7 +245,7 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 
 		extent_count = be32_to_cpu(oe->e_extent_count);
 		next = be64_to_cpu(oe->e_next);
-		entry = &oe->e_entry;
+		entry = oe->e_entry;
 
 		if (extent_count > max_extents)
 			goto out_brelse;
diff --git a/fs/omfs/omfs_fs.h b/fs/omfs/omfs_fs.h
index caecb3d5a344..1ff6b9e41297 100644
--- a/fs/omfs/omfs_fs.h
+++ b/fs/omfs/omfs_fs.h
@@ -77,7 +77,7 @@ struct omfs_extent {
 	__be64 e_next;			/* next extent table location */
 	__be32 e_extent_count;		/* total # extents in this table */
 	__be32 e_fill;
-	struct omfs_extent_entry e_entry;	/* start of extent entries */
+	struct omfs_extent_entry e_entry[];	/* start of extent entries */
 };
 
 #endif
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 83cd20f79c5c..6922d8d705cb 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -229,7 +229,9 @@ enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path *path)
 
 struct dentry *ovl_dentry_upper(struct dentry *dentry)
 {
-	return ovl_upperdentry_dereference(OVL_I(d_inode(dentry)));
+	struct inode *inode = d_inode(dentry);
+
+	return inode ? ovl_upperdentry_dereference(OVL_I(inode)) : NULL;
 }
 
 struct dentry *ovl_dentry_lower(struct dentry *dentry)
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 17fce0afb297..9c5aa646b8cc 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -675,6 +675,7 @@ struct TCP_Server_Info {
 	char workstation_RFC1001_name[RFC1001_NAME_LEN_WITH_NULL];
 	__u32 sequence_number; /* for signing, protected by srv_mutex */
 	__u32 reconnect_instance; /* incremented on each reconnect */
+	__le32 session_key_id; /* retrieved from negotiate response and send in session setup request */
 	struct session_key session_key;
 	unsigned long lstrp; /* when we got last response from this server */
 	struct cifs_secmech secmech; /* crypto sec mech functs, descriptors */
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 9cb457706334..a682c50d7ace 100644
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
index 6077fe1dcc9c..0c6ade196894 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -469,6 +469,7 @@ CIFSSMBNegotiate(const unsigned int xid,
 	server->max_rw = le32_to_cpu(pSMBr->MaxRawSize);
 	cifs_dbg(NOISY, "Max buf = %d\n", ses->server->maxBuf);
 	server->capabilities = le32_to_cpu(pSMBr->Capabilities);
+	server->session_key_id = pSMBr->SessionKey;
 	server->timeAdj = (int)(__s16)le16_to_cpu(pSMBr->ServerTimeZone);
 	server->timeAdj *= 60;
 
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 3826f7176608..99a0a1fe6618 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -307,6 +307,14 @@ check_smb_hdr(struct smb_hdr *smb)
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
index c8f7ae0a2006..883d1cb1fc8b 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -605,6 +605,7 @@ static __u32 cifs_ssetup_hdr(struct cifs_ses *ses,
 					USHRT_MAX));
 	pSMB->req.MaxMpxCount = cpu_to_le16(server->maxReq);
 	pSMB->req.VcNumber = cpu_to_le16(1);
+	pSMB->req.SessionKey = server->session_key_id;
 
 	/* Now no need to set SMBFLG_CASELESS or obsolete CANONICAL PATH */
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index ca54ac7ff6ea..899285bba8dd 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1356,8 +1356,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 		return rc;
 
 	sz = le16_to_cpu(rsp->SecurityBufferOffset);
-	chgblob =
-		(struct challenge_message *)((char *)&rsp->hdr.ProtocolId + sz);
+	chgblob = (struct challenge_message *)rsp->Buffer;
 	memset(chgblob, 0, sizeof(struct challenge_message));
 
 	if (!work->conn->use_spnego) {
@@ -1390,8 +1389,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 		goto out;
 	}
 
-	sz = le16_to_cpu(rsp->SecurityBufferOffset);
-	memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
+	memcpy(rsp->Buffer, spnego_blob, spnego_blob_len);
 	rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 
 out:
@@ -1473,8 +1471,7 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		if (rc)
 			return -ENOMEM;
 
-		sz = le16_to_cpu(rsp->SecurityBufferOffset);
-		memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
+		memcpy(rsp->Buffer, spnego_blob, spnego_blob_len);
 		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 		kfree(spnego_blob);
 	}
@@ -2686,7 +2683,7 @@ int smb2_open(struct ksmbd_work *work)
 	int req_op_level = 0, open_flags = 0, may_flags = 0, file_info = 0;
 	int rc = 0;
 	int contxt_cnt = 0, query_disk_id = 0;
-	int maximal_access_ctxt = 0, posix_ctxt = 0;
+	bool maximal_access_ctxt = false, posix_ctxt = false;
 	int s_type = 0;
 	int next_off = 0;
 	char *name = NULL;
@@ -2713,6 +2710,27 @@ int smb2_open(struct ksmbd_work *work)
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
 		if ((req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
 		    *(char *)req->Buffer == '\\') {
@@ -2744,9 +2762,11 @@ int smb2_open(struct ksmbd_work *work)
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
@@ -2861,28 +2881,6 @@ int smb2_open(struct ksmbd_work *work)
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
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bfb9eb9d7215..a9b52845335c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -187,7 +187,7 @@ int hv_common_cpu_die(unsigned int cpu);
 
 void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
-void hv_free_hyperv_page(unsigned long addr);
+void hv_free_hyperv_page(void *addr);
 
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
diff --git a/include/linux/console.h b/include/linux/console.h
index 8c1686e2c233..ab8b19f6affa 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -34,9 +34,14 @@ enum vc_intensity;
 /**
  * struct consw - callbacks for consoles
  *
+ * @con_init:   initialize the console on @vc. @init is true for the very first
+ *		call on this @vc.
+ * @con_clear:  erase @count characters at [@x, @y] on @vc. @count >= 1.
  * @con_scroll: move lines from @top to @bottom in direction @dir by @lines.
  *		Return true if no generic handling should be done.
  *		Invoked by csi_M and printing to the console.
+ * @con_switch: notifier about the console switch; it is supposed to return
+ *		true if a redraw is needed.
  * @con_set_palette: sets the palette of the console to @table (optional)
  * @con_scrolldelta: the contents of the console should be scrolled by @lines.
  *		     Invoked by user. (optional)
@@ -44,10 +49,10 @@ enum vc_intensity;
 struct consw {
 	struct module *owner;
 	const char *(*con_startup)(void);
-	void	(*con_init)(struct vc_data *vc, int init);
+	void	(*con_init)(struct vc_data *vc, bool init);
 	void	(*con_deinit)(struct vc_data *vc);
-	void	(*con_clear)(struct vc_data *vc, int sy, int sx, int height,
-			int width);
+	void	(*con_clear)(struct vc_data *vc, unsigned int y,
+			     unsigned int x, unsigned int count);
 	void	(*con_putc)(struct vc_data *vc, int c, int ypos, int xpos);
 	void	(*con_putcs)(struct vc_data *vc, const unsigned short *s,
 			int count, int ypos, int xpos);
@@ -55,7 +60,7 @@ struct consw {
 	bool	(*con_scroll)(struct vc_data *vc, unsigned int top,
 			unsigned int bottom, enum con_scroll dir,
 			unsigned int lines);
-	int	(*con_switch)(struct vc_data *vc);
+	bool	(*con_switch)(struct vc_data *vc);
 	int	(*con_blank)(struct vc_data *vc, int blank, int mode_switch);
 	int	(*con_font_set)(struct vc_data *vc, struct console_font *font,
 			unsigned int flags);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 80d876593caa..43f778b6b9cd 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -820,6 +820,8 @@ struct vmbus_requestor {
 #define VMBUS_RQST_RESET (U64_MAX - 3)
 
 struct vmbus_device {
+	/* preferred ring buffer size in KB, 0 means no preferred size for this device */
+	size_t pref_ring_size;
 	u16  dev_type;
 	guid_t guid;
 	bool perf_device;
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 9f27e004127b..9a44de45cc1f 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -199,7 +199,6 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
-	u8 dontfrag:1;
 };
 
 /**
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
index 147ada2ce747..d18fe3996ddb 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -510,7 +510,7 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		if (bl->buf_nr_pages || !list_empty(&bl->buf_list))
 			return -EEXIST;
 	} else {
-		free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
+		free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL_ACCOUNT);
 		if (!bl)
 			return -ENOMEM;
 	}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e5fbae585e52..1220e8113dad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2600,6 +2600,15 @@ config FORTIFY_KUNIT_TEST
 	  by the str*() and mem*() family of functions. For testing runtime
 	  traps of FORTIFY_SOURCE, see LKDTM's "FORTIFY_*" tests.
 
+config LONGEST_SYM_KUNIT_TEST
+	tristate "Test the longest symbol possible" if !KUNIT_ALL_TESTS
+	depends on KUNIT && KPROBES
+	default KUNIT_ALL_TESTS
+	help
+	  Tests the longest symbol possible
+
+	  If unsure, say N.
+
 config HW_BREAKPOINT_KUNIT_TEST
 	bool "Test hw_breakpoint constraints accounting" if !KUNIT_ALL_TESTS
 	depends on HAVE_HW_BREAKPOINT
diff --git a/lib/Makefile b/lib/Makefile
index 6f1611d053e6..6ae66e13f319 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -389,6 +389,8 @@ obj-$(CONFIG_OVERFLOW_KUNIT_TEST) += overflow_kunit.o
 CFLAGS_stackinit_kunit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_STACKINIT_KUNIT_TEST) += stackinit_kunit.o
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
+obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
+CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/longest_symbol_kunit.c b/lib/longest_symbol_kunit.c
new file mode 100644
index 000000000000..2fea82a6d34e
--- /dev/null
+++ b/lib/longest_symbol_kunit.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test the longest symbol length. Execute with:
+ *  ./tools/testing/kunit/kunit.py run longest-symbol
+ *  --arch=x86_64 --kconfig_add CONFIG_KPROBES=y --kconfig_add CONFIG_MODULES=y
+ *  --kconfig_add CONFIG_RETPOLINE=n --kconfig_add CONFIG_CFI_CLANG=n
+ *  --kconfig_add CONFIG_MITIGATION_RETPOLINE=n
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+#include <linux/stringify.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+
+#define DI(name) s##name##name
+#define DDI(name) DI(n##name##name)
+#define DDDI(name) DDI(n##name##name)
+#define DDDDI(name) DDDI(n##name##name)
+#define DDDDDI(name) DDDDI(n##name##name)
+
+/*Generate a symbol whose name length is 511 */
+#define LONGEST_SYM_NAME  DDDDDI(g1h2i3j4k5l6m7n)
+
+#define RETURN_LONGEST_SYM 0xAAAAA
+
+noinline int LONGEST_SYM_NAME(void);
+noinline int LONGEST_SYM_NAME(void)
+{
+	return RETURN_LONGEST_SYM;
+}
+
+_Static_assert(sizeof(__stringify(LONGEST_SYM_NAME)) == KSYM_NAME_LEN,
+"Incorrect symbol length found. Expected KSYM_NAME_LEN: "
+__stringify(KSYM_NAME_LEN) ", but found: "
+__stringify(sizeof(LONGEST_SYM_NAME)));
+
+static void test_longest_symbol(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, LONGEST_SYM_NAME());
+};
+
+static void test_longest_symbol_kallsyms(struct kunit *test)
+{
+	unsigned long (*kallsyms_lookup_name)(const char *name);
+	static int (*longest_sym)(void);
+
+	struct kprobe kp = {
+		.symbol_name = "kallsyms_lookup_name",
+	};
+
+	if (register_kprobe(&kp) < 0) {
+		pr_info("%s: kprobe not registered", __func__);
+		KUNIT_FAIL(test, "test_longest_symbol kallsyms: kprobe not registered\n");
+		return;
+	}
+
+	kunit_warn(test, "test_longest_symbol kallsyms: kprobe registered\n");
+	kallsyms_lookup_name = (unsigned long (*)(const char *name))kp.addr;
+	unregister_kprobe(&kp);
+
+	longest_sym =
+		(void *) kallsyms_lookup_name(__stringify(LONGEST_SYM_NAME));
+	KUNIT_EXPECT_EQ(test, RETURN_LONGEST_SYM, longest_sym());
+};
+
+static struct kunit_case longest_symbol_test_cases[] = {
+	KUNIT_CASE(test_longest_symbol),
+	KUNIT_CASE(test_longest_symbol_kallsyms),
+	{}
+};
+
+static struct kunit_suite longest_symbol_test_suite = {
+	.name = "longest-symbol",
+	.test_cases = longest_symbol_test_cases,
+};
+kunit_test_suite(longest_symbol_test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test the longest symbol length");
+MODULE_AUTHOR("Sergio GonzÃ¡lez Collado");
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 294cb9efe3d3..511467bb7fe4 100644
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
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 550c3da6f391..514adb013f3f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3600,7 +3600,7 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 	struct l2cap_conf_rfc rfc = { .mode = L2CAP_MODE_BASIC };
 	struct l2cap_conf_efs efs;
 	u8 remote_efs = 0;
-	u16 mtu = L2CAP_DEFAULT_MTU;
+	u16 mtu = 0;
 	u16 result = L2CAP_CONF_SUCCESS;
 	u16 size;
 
@@ -3711,6 +3711,13 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
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
index 7af99d07762e..946e92cca211 100644
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
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index cfc276e5a249..f7a225da8525 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1450,7 +1450,6 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
-	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1484,7 +1483,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags)
+			     unsigned int flags, struct ipcm6_cookie *ipc6)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1540,7 +1539,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
+	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1885,7 +1884,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags);
+				 from, length, transhdrlen, flags, ipc6);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2090,7 +2089,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
-				flags);
+				flags, ipc6);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
 		return ERR_PTR(err);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e8326e09d1b3..e60c8607e4b6 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4452,7 +4452,7 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 {
 	u64 tsf = drv_get_tsf(local, sdata);
 	u64 dtim_count = 0;
-	u16 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
+	u32 beacon_int = sdata->vif.bss_conf.beacon_int * 1024;
 	u8 dtim_period = sdata->vif.bss_conf.dtim_period;
 	struct ps_data *ps;
 	u8 bcns_from_dtim;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 79b783a70c87..2c33d787b860 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -577,6 +577,11 @@ static void unix_sock_destructor(struct sock *sk)
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
@@ -604,20 +609,23 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	unix_state_unlock(sk);
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	if (u->oob_skb) {
-		kfree_skb(u->oob_skb);
-		u->oob_skb = NULL;
-	}
+	u->oob_skb = NULL;
 #endif
 
 	wake_up_interruptible_all(&u->peer_wait);
 
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
@@ -2133,13 +2141,9 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	}
 
 	maybe_add_creds(skb, sock, other);
-	skb_get(skb);
-
 	scm_stat_add(other, skb);
 
 	spin_lock(&other->sk_receive_queue.lock);
-	if (ousk->oob_skb)
-		consume_skb(ousk->oob_skb);
 	WRITE_ONCE(ousk->oob_skb, skb);
 	__skb_queue_tail(&other->sk_receive_queue, skb);
 	spin_unlock(&other->sk_receive_queue.lock);
@@ -2600,11 +2604,6 @@ static long unix_stream_data_wait(struct sock *sk, long timeo,
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
@@ -2619,11 +2618,11 @@ struct unix_stream_read_state {
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
@@ -2638,10 +2637,15 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	oob_skb = u->oob_skb;
 
-	if (!(state->flags & MSG_PEEK))
+	if (!(state->flags & MSG_PEEK)) {
 		WRITE_ONCE(u->oob_skb, NULL);
-	else
-		skb_get(oob_skb);
+
+		if (oob_skb->prev != (struct sk_buff *)&sk->sk_receive_queue &&
+		    !unix_skb_len(oob_skb->prev)) {
+			read_skb = oob_skb->prev;
+			__skb_unlink(read_skb, &sk->sk_receive_queue);
+		}
+	}
 
 	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
@@ -2651,10 +2655,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 	if (!(state->flags & MSG_PEEK))
 		UNIXCB(oob_skb).consumed += 1;
 
-	consume_skb(oob_skb);
-
 	mutex_unlock(&u->iolock);
 
+	consume_skb(read_skb);
+
 	if (chunk < 0)
 		return -EFAULT;
 
@@ -2680,12 +2684,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			if (copied) {
 				skb = NULL;
 			} else if (!(flags & MSG_PEEK)) {
-				if (sock_flag(sk, SOCK_URGINLINE)) {
-					WRITE_ONCE(u->oob_skb, NULL);
-					consume_skb(skb);
-				} else {
+				WRITE_ONCE(u->oob_skb, NULL);
+
+				if (!sock_flag(sk, SOCK_URGINLINE)) {
 					__skb_unlink(skb, &sk->sk_receive_queue);
-					WRITE_ONCE(u->oob_skb, NULL);
 					unlinked_skb = skb;
 					skb = skb_peek(&sk->sk_receive_queue);
 				}
@@ -2696,10 +2698,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 
 		spin_unlock(&sk->sk_receive_queue.lock);
 
-		if (unlinked_skb) {
-			WARN_ON_ONCE(skb_unref(unlinked_skb));
-			kfree_skb(unlinked_skb);
-		}
+		kfree_skb(unlinked_skb);
 	}
 	return skb;
 }
@@ -2742,7 +2741,6 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		unix_state_unlock(sk);
 
 		if (drop) {
-			WARN_ON_ONCE(skb_unref(skb));
 			kfree_skb(skb);
 			return -EAGAIN;
 		}
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 23efb78fe9ef..0068e758be4d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -337,23 +337,6 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
-enum unix_recv_queue_lock_class {
-	U_RECVQ_LOCK_NORMAL,
-	U_RECVQ_LOCK_EMBRYO,
-};
-
-static void unix_collect_queue(struct unix_sock *u, struct sk_buff_head *hitlist)
-{
-	skb_queue_splice_init(&u->sk.sk_receive_queue, hitlist);
-
-#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	if (u->oob_skb) {
-		WARN_ON_ONCE(skb_unref(u->oob_skb));
-		u->oob_skb = NULL;
-	}
-#endif
-}
-
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -375,13 +358,12 @@ static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist
 			skb_queue_walk(queue, skb) {
 				struct sk_buff_head *embryo_queue = &skb->sk->sk_receive_queue;
 
-				/* listener -> embryo order, the inversion never happens. */
-				spin_lock_nested(&embryo_queue->lock, U_RECVQ_LOCK_EMBRYO);
-				unix_collect_queue(unix_sk(skb->sk), hitlist);
+				spin_lock(&embryo_queue->lock);
+				skb_queue_splice_init(embryo_queue, hitlist);
 				spin_unlock(&embryo_queue->lock);
 			}
 		} else {
-			unix_collect_queue(u, hitlist);
+			skb_queue_splice_init(queue, hitlist);
 		}
 
 		spin_unlock(&queue->lock);
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 94a92ab82b6b..eeca6b2d5160 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -229,6 +229,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
                     #[cfg(MODULE)]
                     #[doc(hidden)]
                     #[no_mangle]
+                    #[link_section = \".exit.text\"]
                     pub extern \"C\" fn cleanup_module() {{
                         // SAFETY:
                         // - This function is inaccessible to the outside due to the double
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 890c2f7c33fc..4c7355a0814d 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -45,7 +45,7 @@ static void hda_codec_unsol_event(struct hdac_device *dev, unsigned int ev)
 	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 
 	/* ignore unsol events during shutdown */
-	if (codec->bus->shutdown)
+	if (codec->card->shutdown || codec->bus->shutdown)
 		return;
 
 	/* ignore unsol events during system suspend/resume */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d1639d8c2298..1bb315c175f6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2793,6 +2793,9 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE(0x1002, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	{ PCI_VDEVICE(ATI, 0xab40),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	/* GLENFLY */
 	{ PCI_DEVICE(PCI_VENDOR_ID_GLENFLY, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3cacdbcb0d3e..13b3ec78010a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10154,6 +10154,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1da2, "ASUS UP6502ZA/ZD", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1e02, "ASUS UX3402ZA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x1e10, "ASUS VivoBook X507UAR", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e12, "ASUS UM3402", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index d5dc1d48fca9..30f28f33a52c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -367,6 +367,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M5602RA"),
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
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index d2548fdf9ae5..99de81c48968 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -16,7 +16,7 @@
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
@@ -357,6 +356,10 @@ struct wcd9335_irq {
 	char *name;
 };
 
+static const char * const wcd9335_supplies[] = {
+	"vdd-buck", "vdd-buck-sido", "vdd-tx", "vdd-rx", "vdd-io",
+};
+
 static const struct wcd9335_slim_ch wcd9335_tx_chs[WCD9335_TX_MAX] = {
 	WCD9335_SLIM_TX_CH(0),
 	WCD9335_SLIM_TX_CH(1),
@@ -5032,53 +5035,30 @@ static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
 static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 {
 	struct device *dev = wcd->dev;
-	struct device_node *np = dev->of_node;
 	int ret;
 
-	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
-	if (wcd->reset_gpio < 0) {
-		dev_err(dev, "Reset GPIO missing from DT\n");
-		return wcd->reset_gpio;
-	}
+	wcd->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(wcd->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(wcd->reset_gpio), "Reset GPIO missing from DT\n");
 
 	wcd->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(wcd->mclk)) {
-		dev_err(dev, "mclk not found\n");
-		return PTR_ERR(wcd->mclk);
-	}
+	if (IS_ERR(wcd->mclk))
+		return dev_err_probe(dev, PTR_ERR(wcd->mclk), "mclk not found\n");
 
 	wcd->native_clk = devm_clk_get(dev, "slimbus");
-	if (IS_ERR(wcd->native_clk)) {
-		dev_err(dev, "slimbus clock not found\n");
-		return PTR_ERR(wcd->native_clk);
-	}
+	if (IS_ERR(wcd->native_clk))
+		return dev_err_probe(dev, PTR_ERR(wcd->native_clk), "slimbus clock not found\n");
 
-	wcd->supplies[0].supply = "vdd-buck";
-	wcd->supplies[1].supply = "vdd-buck-sido";
-	wcd->supplies[2].supply = "vdd-tx";
-	wcd->supplies[3].supply = "vdd-rx";
-	wcd->supplies[4].supply = "vdd-io";
-
-	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(wcd9335_supplies),
+					     wcd9335_supplies);
+	if (ret)
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
@@ -5088,9 +5068,9 @@ static int wcd9335_power_on_reset(struct wcd9335_codec *wcd)
 	 */
 	usleep_range(600, 650);
 
-	gpio_direction_output(wcd->reset_gpio, 0);
+	gpiod_set_value(wcd->reset_gpio, 1);
 	msleep(20);
-	gpio_set_value(wcd->reset_gpio, 1);
+	gpiod_set_value(wcd->reset_gpio, 0);
 	msleep(20);
 
 	return 0;
@@ -5166,10 +5146,8 @@ static int wcd9335_slim_probe(struct slim_device *slim)
 
 	wcd->dev = dev;
 	ret = wcd9335_parse_dt(wcd);
-	if (ret) {
-		dev_err(dev, "Error parsing DT: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = wcd9335_power_on_reset(wcd);
 	if (ret)
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b2a612c5b299..ac43bdf6e9ca 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2180,6 +2180,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x17aa, 0x104d, /* Lenovo ThinkStation P620 Internal Speaker + Front Headset */
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
+	DEVICE_FLG(0x17ef, 0x3083, /* Lenovo TBT3 dock */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1852, 0x5062, /* Luxman D-08u */
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1852, 0x5065, /* Luxman DA-06 */
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index e14c725acebf..0f1558ef8555 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -982,6 +982,8 @@ snd_usb_get_audioformat_uac3(struct snd_usb_audio *chip,
 	 * and request Cluster Descriptor
 	 */
 	wLength = le16_to_cpu(hc_header.wLength);
+	if (wLength < sizeof(cluster))
+		return NULL;
 	cluster = kzalloc(wLength, GFP_KERNEL);
 	if (!cluster)
 		return ERR_PTR(-ENOMEM);
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index cfdee656789b..72334cc14d73 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -224,6 +224,9 @@ static void btf_dump_free_names(struct hashmap *map)
 	size_t bkt;
 	struct hashmap_entry *cur;
 
+	if (!map)
+		return;
+
 	hashmap__for_each_entry(map, cur, bkt)
 		free((void *)cur->key);
 

