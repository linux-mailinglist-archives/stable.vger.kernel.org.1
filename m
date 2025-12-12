Return-Path: <stable+bounces-200932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 561A7CB97B4
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 18:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F9B130AC68B
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 17:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CED2F49FE;
	Fri, 12 Dec 2025 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fZJEQpOd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99E2F3C37;
	Fri, 12 Dec 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765561831; cv=none; b=UqqHUQQTla6aRG9b8IAY+bjOz6TwjM/QJrHK/JOu+X3S/oF695MwJHbuto8d0AT0umQpFjr7A/uNkYIp1GmghpTxY95jlcZPsUDOCLWUsW0QKM7Bnlt26ok2vn5tffUEYBevxxwS8nnNMF1B0h9Ra6ruvAYE/R31YvXxrqcUGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765561831; c=relaxed/simple;
	bh=PQ+vVlrr3GAK5PGqWzgPA7tkurc/dUuzbTuNb3MPfIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0UpD1D/GFPy685Y6JeNaDVeD2AJ5OACmz+ecE077GTx8AwQJ1yK5OY8CTh30Uc9O7WAZnrI5CqpmdfsqEikO5VLs+2Qb36Ls+R5Mtg1ojADfAkwxZuO+N7QGAZDDub1sGFckM9c2EHYqSkSWuEnbEm7SGBuMHgcnjbLPZiCZFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fZJEQpOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F80C4CEF1;
	Fri, 12 Dec 2025 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765561830;
	bh=PQ+vVlrr3GAK5PGqWzgPA7tkurc/dUuzbTuNb3MPfIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZJEQpOdz7MtOJ3Z91/49lSIYpFVGNWL4o9qNg5vGqVigGvcugdTtnUf1RFugWDb2
	 gG8a8ZHnfYdq++0ZP16saLkHSnVENRnykIXCfHIdRAPk8maxQeROoS1C2xzpbXpVm1
	 UUSWAEh14WBlSdYEtV8zqbCpIXbtyjyp0hWgMJHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.17.12
Date: Fri, 12 Dec 2025 18:50:18 +0100
Message-ID: <2025121218-expectant-tipping-294c@gregkh>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025121218-tycoon-esophagus-4f22@gregkh>
References: <2025121218-tycoon-esophagus-4f22@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index f50d8e02f476..6b1f827a335b 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -54,8 +54,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  uart-has-rtscts: false
-
 required:
   - compatible
   - reg
diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index ef3b116492df..f4fc0da8999d 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -104,8 +104,10 @@ kernels go out with a handful of known regressions though, hopefully, none
 of them are serious.
 
 Once a stable release is made, its ongoing maintenance is passed off to the
-"stable team," currently Greg Kroah-Hartman. The stable team will release
-occasional updates to the stable release using the 5.x.y numbering scheme.
+"stable team," currently consists of Greg Kroah-Hartman and Sasha Levin. The
+stable team will release occasional updates to the stable release using the
+5.x.y numbering scheme.
+
 To be considered for an update release, a patch must (1) fix a significant
 bug, and (2) already be merged into the mainline for the next development
 kernel. Kernels will typically receive stable updates for a little more
diff --git a/Makefile b/Makefile
index d977c277e44f..49052b005854 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 17
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 00d97b8a757f..51746005239b 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -26,9 +26,12 @@ void __init apply_alternatives_all(void);
 bool alternative_is_applied(u16 cpucap);
 
 #ifdef CONFIG_MODULES
-void apply_alternatives_module(void *start, size_t length);
+int apply_alternatives_module(void *start, size_t length);
 #else
-static inline void apply_alternatives_module(void *start, size_t length) { }
+static inline int apply_alternatives_module(void *start, size_t length)
+{
+	return 0;
+}
 #endif
 
 void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 8ff6610af496..f5ec7e7c1d3f 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -139,9 +139,9 @@ static noinstr void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(const struct alt_region *region,
-				 bool is_module,
-				 unsigned long *cpucap_mask)
+static int __apply_alternatives(const struct alt_region *region,
+				bool is_module,
+				unsigned long *cpucap_mask)
 {
 	struct alt_instr *alt;
 	__le32 *origptr, *updptr;
@@ -166,10 +166,13 @@ static void __apply_alternatives(const struct alt_region *region,
 		updptr = is_module ? origptr : lm_alias(origptr);
 		nr_inst = alt->orig_len / AARCH64_INSN_SIZE;
 
-		if (ALT_HAS_CB(alt))
+		if (ALT_HAS_CB(alt)) {
 			alt_cb  = ALT_REPL_PTR(alt);
-		else
+			if (is_module && !core_kernel_text((unsigned long)alt_cb))
+				return -ENOEXEC;
+		} else {
 			alt_cb = patch_alternative;
+		}
 
 		alt_cb(alt, origptr, updptr, nr_inst);
 
@@ -193,6 +196,8 @@ static void __apply_alternatives(const struct alt_region *region,
 		bitmap_and(applied_alternatives, applied_alternatives,
 			   system_cpucaps, ARM64_NCAPS);
 	}
+
+	return 0;
 }
 
 static void __init apply_alternatives_vdso(void)
@@ -277,7 +282,7 @@ void __init apply_boot_alternatives(void)
 }
 
 #ifdef CONFIG_MODULES
-void apply_alternatives_module(void *start, size_t length)
+int apply_alternatives_module(void *start, size_t length)
 {
 	struct alt_region region = {
 		.begin	= start,
@@ -287,7 +292,7 @@ void apply_alternatives_module(void *start, size_t length)
 
 	bitmap_fill(all_capabilities, ARM64_NCAPS);
 
-	__apply_alternatives(&region, true, &all_capabilities[0]);
+	return __apply_alternatives(&region, true, &all_capabilities[0]);
 }
 #endif
 
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index d6d443c4a01a..0b15c57285ad 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -489,8 +489,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 	int ret;
 
 	s = find_section(hdr, sechdrs, ".altinstructions");
-	if (s)
-		apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+	if (s) {
+		ret = apply_alternatives_module((void *)s->sh_addr, s->sh_size);
+		if (ret < 0) {
+			pr_err("module %s: error occurred when applying alternatives\n", me->name);
+			return ret;
+		}
+	}
 
 	if (scs_is_dynamic()) {
 		s = find_section(hdr, sechdrs, ".init.eh_frame");
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index f9381800e291..8ef4e4595d61 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -249,6 +249,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 	crash_smp_send_stop();
 #endif
+	machine_kexec_mask_interrupts();
 	cpumask_set_cpu(crashing_cpu, &cpus_in_crash);
 
 	pr_info("Starting crashdump kernel...\n");
@@ -286,6 +287,7 @@ void machine_kexec(struct kimage *image)
 
 	/* We do not want to be bothered. */
 	local_irq_disable();
+	machine_kexec_mask_interrupts();
 
 	pr_notice("EFI boot flag 0x%lx\n", efi_boot);
 	pr_notice("Command line at 0x%lx\n", cmdline_ptr);
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7e87e7d9ba5a..ae4c6c176922 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2123,6 +2123,11 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
  *			     the gfn, i.e. retrying the instruction will hit a
  *			     !PRESENT fault, which results in a new shadow page
  *			     and sends KVM back to square one.
+ *
+ * EMULTYPE_SKIP_SOFT_INT - Set in combination with EMULTYPE_SKIP to only skip
+ *                          an instruction if it could generate a given software
+ *                          interrupt, which must be encoded via
+ *                          EMULTYPE_SET_SOFT_INT_VECTOR().
  */
 #define EMULTYPE_NO_DECODE	    (1 << 0)
 #define EMULTYPE_TRAP_UD	    (1 << 1)
@@ -2133,6 +2138,10 @@ u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
 #define EMULTYPE_PF		    (1 << 6)
 #define EMULTYPE_COMPLETE_USER_EXIT (1 << 7)
 #define EMULTYPE_WRITE_PF_TO_SP	    (1 << 8)
+#define EMULTYPE_SKIP_SOFT_INT	    (1 << 9)
+
+#define EMULTYPE_SET_SOFT_INT_VECTOR(v)	((u32)((v) & 0xff) << 16)
+#define EMULTYPE_GET_SOFT_INT_VECTOR(e)	(((e) >> 16) & 0xff)
 
 static inline bool kvm_can_emulate_event_vectoring(int emul_type)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 30c143cc6bf4..ccf57f000542 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -280,6 +280,7 @@ static void svm_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask)
 }
 
 static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
+					   int emul_type,
 					   bool commit_side_effects)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -301,7 +302,7 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 		if (unlikely(!commit_side_effects))
 			old_rflags = svm->vmcb->save.rflags;
 
-		if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
+		if (!kvm_emulate_instruction(vcpu, emul_type))
 			return 0;
 
 		if (unlikely(!commit_side_effects))
@@ -319,11 +320,13 @@ static int __svm_skip_emulated_instruction(struct kvm_vcpu *vcpu,
 
 static int svm_skip_emulated_instruction(struct kvm_vcpu *vcpu)
 {
-	return __svm_skip_emulated_instruction(vcpu, true);
+	return __svm_skip_emulated_instruction(vcpu, EMULTYPE_SKIP, true);
 }
 
-static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu)
+static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu, u8 vector)
 {
+	const int emul_type = EMULTYPE_SKIP | EMULTYPE_SKIP_SOFT_INT |
+			      EMULTYPE_SET_SOFT_INT_VECTOR(vector);
 	unsigned long rip, old_rip = kvm_rip_read(vcpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -339,7 +342,7 @@ static int svm_update_soft_interrupt_rip(struct kvm_vcpu *vcpu)
 	 * in use, the skip must not commit any side effects such as clearing
 	 * the interrupt shadow or RFLAGS.RF.
 	 */
-	if (!__svm_skip_emulated_instruction(vcpu, !nrips))
+	if (!__svm_skip_emulated_instruction(vcpu, emul_type, !nrips))
 		return -EIO;
 
 	rip = kvm_rip_read(vcpu);
@@ -375,7 +378,7 @@ static void svm_inject_exception(struct kvm_vcpu *vcpu)
 	kvm_deliver_exception_payload(vcpu, ex);
 
 	if (kvm_exception_is_soft(ex->vector) &&
-	    svm_update_soft_interrupt_rip(vcpu))
+	    svm_update_soft_interrupt_rip(vcpu, ex->vector))
 		return;
 
 	svm->vmcb->control.event_inj = ex->vector
@@ -3662,11 +3665,12 @@ static bool svm_set_vnmi_pending(struct kvm_vcpu *vcpu)
 
 static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 {
+	struct kvm_queued_interrupt *intr = &vcpu->arch.interrupt;
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 type;
 
-	if (vcpu->arch.interrupt.soft) {
-		if (svm_update_soft_interrupt_rip(vcpu))
+	if (intr->soft) {
+		if (svm_update_soft_interrupt_rip(vcpu, intr->nr))
 			return;
 
 		type = SVM_EVTINJ_TYPE_SOFT;
@@ -3674,12 +3678,10 @@ static void svm_inject_irq(struct kvm_vcpu *vcpu, bool reinjected)
 		type = SVM_EVTINJ_TYPE_INTR;
 	}
 
-	trace_kvm_inj_virq(vcpu->arch.interrupt.nr,
-			   vcpu->arch.interrupt.soft, reinjected);
+	trace_kvm_inj_virq(intr->nr, intr->soft, reinjected);
 	++vcpu->stat.irq_injections;
 
-	svm->vmcb->control.event_inj = vcpu->arch.interrupt.nr |
-				       SVM_EVTINJ_VALID | type;
+	svm->vmcb->control.event_inj = intr->nr | SVM_EVTINJ_VALID | type;
 }
 
 void svm_complete_interrupt_delivery(struct kvm_vcpu *vcpu, int delivery_mode,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0bfab634c591..c91fc5062ad8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9021,6 +9021,23 @@ static bool is_vmware_backdoor_opcode(struct x86_emulate_ctxt *ctxt)
 	return false;
 }
 
+static bool is_soft_int_instruction(struct x86_emulate_ctxt *ctxt,
+				    int emulation_type)
+{
+	u8 vector = EMULTYPE_GET_SOFT_INT_VECTOR(emulation_type);
+
+	switch (ctxt->b) {
+	case 0xcc:
+		return vector == BP_VECTOR;
+	case 0xcd:
+		return vector == ctxt->src.val;
+	case 0xce:
+		return vector == OF_VECTOR;
+	default:
+		return false;
+	}
+}
+
 /*
  * Decode an instruction for emulation.  The caller is responsible for handling
  * code breakpoints.  Note, manually detecting code breakpoints is unnecessary
@@ -9131,6 +9148,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * injecting single-step #DBs.
 	 */
 	if (emulation_type & EMULTYPE_SKIP) {
+		if (emulation_type & EMULTYPE_SKIP_SOFT_INT &&
+		    !is_soft_int_instruction(ctxt, emulation_type))
+			return 0;
+
 		if (ctxt->mode != X86EMUL_MODE_PROT64)
 			ctxt->eip = (u32)ctxt->_eip;
 		else
diff --git a/crypto/zstd.c b/crypto/zstd.c
index ac318d333b68..32a339b74f34 100644
--- a/crypto/zstd.c
+++ b/crypto/zstd.c
@@ -75,11 +75,6 @@ static int zstd_init(struct crypto_acomp *acomp_tfm)
 	return ret;
 }
 
-static void zstd_exit(struct crypto_acomp *acomp_tfm)
-{
-	crypto_acomp_free_streams(&zstd_streams);
-}
-
 static int zstd_compress_one(struct acomp_req *req, struct zstd_ctx *ctx,
 			     const void *src, void *dst, unsigned int *dlen)
 {
@@ -297,7 +292,6 @@ static struct acomp_alg zstd_acomp = {
 		.cra_module = THIS_MODULE,
 	},
 	.init = zstd_init,
-	.exit = zstd_exit,
 	.compress = zstd_compress,
 	.decompress = zstd_decompress,
 };
@@ -310,6 +304,7 @@ static int __init zstd_mod_init(void)
 static void __exit zstd_mod_fini(void)
 {
 	crypto_unregister_acomp(&zstd_acomp);
+	crypto_acomp_free_streams(&zstd_streams);
 }
 
 module_init(zstd_mod_init);
diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
index a6dbf623e557..6d69554c940e 100644
--- a/drivers/acpi/acpi_mrrm.c
+++ b/drivers/acpi/acpi_mrrm.c
@@ -152,26 +152,49 @@ ATTRIBUTE_GROUPS(memory_range);
 
 static __init int add_boot_memory_ranges(void)
 {
-	struct kobject *pkobj, *kobj;
+	struct kobject *pkobj, *kobj, **kobjs;
 	int ret = -EINVAL;
-	char *name;
+	char name[16];
+	int i;
 
 	pkobj = kobject_create_and_add("memory_ranges", acpi_kobj);
+	if (!pkobj)
+		return -ENOMEM;
 
-	for (int i = 0; i < mrrm_mem_entry_num; i++) {
-		name = kasprintf(GFP_KERNEL, "range%d", i);
-		if (!name) {
-			ret = -ENOMEM;
-			break;
-		}
+	kobjs = kcalloc(mrrm_mem_entry_num, sizeof(*kobjs), GFP_KERNEL);
+	if (!kobjs) {
+		kobject_put(pkobj);
+		return -ENOMEM;
+	}
 
+	for (i = 0; i < mrrm_mem_entry_num; i++) {
+		scnprintf(name, sizeof(name), "range%d", i);
 		kobj = kobject_create_and_add(name, pkobj);
+		if (!kobj) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
 
 		ret = sysfs_create_groups(kobj, memory_range_groups);
-		if (ret)
-			return ret;
+		if (ret) {
+			kobject_put(kobj);
+			goto cleanup;
+		}
+		kobjs[i] = kobj;
 	}
 
+	kfree(kobjs);
+	return 0;
+
+cleanup:
+	for (int j = 0; j < i; j++) {
+		if (kobjs[j]) {
+			sysfs_remove_groups(kobjs[j], memory_range_groups);
+			kobject_put(kobjs[j]);
+		}
+	}
+	kfree(kobjs);
+	kobject_put(pkobj);
 	return ret;
 }
 
diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1d4a7887abcc..52794db2739b 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -50,7 +50,7 @@
 
 #define	RTL_CHIP_SUBVER (&(struct rtl_vendor_cmd) {{0x10, 0x38, 0x04, 0x28, 0x80}})
 #define	RTL_CHIP_REV    (&(struct rtl_vendor_cmd) {{0x10, 0x3A, 0x04, 0x28, 0x80}})
-#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0x0D, 0x00, 0xb0}})
+#define	RTL_SEC_PROJ    (&(struct rtl_vendor_cmd) {{0x10, 0xA4, 0xAD, 0x00, 0xb0}})
 
 #define RTL_PATCH_SNIPPETS		0x01
 #define RTL_PATCH_DUMMY_HEADER		0x02
@@ -534,7 +534,6 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 {
 	struct rtl_epatch_header_v2 *hdr;
 	int rc;
-	u8 reg_val[2];
 	u8 key_id;
 	u32 num_sections;
 	struct rtl_section *section;
@@ -549,14 +548,7 @@ static int rtlbt_parse_firmware_v2(struct hci_dev *hdev,
 		.len  = btrtl_dev->fw_len - 7, /* Cut the tail */
 	};
 
-	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
-	if (rc < 0)
-		return -EIO;
-	key_id = reg_val[0];
-
-	rtl_dev_dbg(hdev, "%s: key id %u", __func__, key_id);
-
-	btrtl_dev->key_id = key_id;
+	key_id = btrtl_dev->key_id;
 
 	hdr = rtl_iov_pull_data(&iov, sizeof(*hdr));
 	if (!hdr)
@@ -1070,6 +1062,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver, lmp_ver, chip_type = 0;
 	int ret;
+	int rc;
+	u8 key_id;
 	u8 reg_val[2];
 
 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
@@ -1180,6 +1174,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
+	rc = btrtl_vendor_read_reg16(hdev, RTL_SEC_PROJ, reg_val);
+	if (rc < 0)
+		goto err_free;
+
+	key_id = reg_val[0];
+	btrtl_dev->key_id = key_id;
+	rtl_dev_info(hdev, "%s: key id %u", __func__, key_id);
+
 	btrtl_dev->fw_len = -EIO;
 	if (lmp_subver == RTL_ROM_LMP_8852A && hci_rev == 0x000c) {
 		snprintf(fw_name, sizeof(fw_name), "%s_v2.bin",
@@ -1202,7 +1204,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		goto err_free;
 	}
 
-	if (btrtl_dev->ic_info->cfg_name) {
+	if (btrtl_dev->ic_info->cfg_name && !btrtl_dev->key_id) {
 		if (postfix) {
 			snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
 				 btrtl_dev->ic_info->cfg_name, postfix);
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 7e2f2b1a1c36..b2e62e04afd9 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -3023,7 +3023,12 @@ static int compat_chaninfo(struct file *file, unsigned long arg)
 	chaninfo.rangelist = compat_ptr(chaninfo32.rangelist);
 
 	mutex_lock(&dev->mutex);
-	err = do_chaninfo_ioctl(dev, &chaninfo);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		err = -ENODEV;
+	} else {
+		err = do_chaninfo_ioctl(dev, &chaninfo);
+	}
 	mutex_unlock(&dev->mutex);
 	return err;
 }
@@ -3044,7 +3049,12 @@ static int compat_rangeinfo(struct file *file, unsigned long arg)
 	rangeinfo.range_ptr = compat_ptr(rangeinfo32.range_ptr);
 
 	mutex_lock(&dev->mutex);
-	err = do_rangeinfo_ioctl(dev, &rangeinfo);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		err = -ENODEV;
+	} else {
+		err = do_rangeinfo_ioctl(dev, &rangeinfo);
+	}
 	mutex_unlock(&dev->mutex);
 	return err;
 }
@@ -3120,7 +3130,12 @@ static int compat_cmd(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
-	rc = do_cmd_ioctl(dev, &cmd, &copy, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_cmd_ioctl(dev, &cmd, &copy, file);
+	}
 	mutex_unlock(&dev->mutex);
 	if (copy) {
 		/* Special case: copy cmd back to user. */
@@ -3145,7 +3160,12 @@ static int compat_cmdtest(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
-	rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
+	}
 	mutex_unlock(&dev->mutex);
 	if (copy) {
 		err = put_compat_cmd(compat_ptr(arg), &cmd);
@@ -3205,7 +3225,12 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 	}
 
 	mutex_lock(&dev->mutex);
-	rc = do_insnlist_ioctl(dev, insns, insnlist32.n_insns, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_insnlist_ioctl(dev, insns, insnlist32.n_insns, file);
+	}
 	mutex_unlock(&dev->mutex);
 	kfree(insns);
 	return rc;
@@ -3224,7 +3249,12 @@ static int compat_insn(struct file *file, unsigned long arg)
 		return rc;
 
 	mutex_lock(&dev->mutex);
-	rc = do_insn_ioctl(dev, &insn, file);
+	if (!dev->attached) {
+		dev_dbg(dev->class_dev, "no driver attached\n");
+		rc = -ENODEV;
+	} else {
+		rc = do_insn_ioctl(dev, &insn, file);
+	}
 	mutex_unlock(&dev->mutex);
 	return rc;
 }
diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
index 14b90d1c64dc..8a38d97d463b 100644
--- a/drivers/comedi/drivers/c6xdigio.c
+++ b/drivers/comedi/drivers/c6xdigio.c
@@ -249,9 +249,6 @@ static int c6xdigio_attach(struct comedi_device *dev,
 	if (ret)
 		return ret;
 
-	/*  Make sure that PnP ports get activated */
-	pnp_register_driver(&c6xdigio_pnp_driver);
-
 	s = &dev->subdevices[0];
 	/* pwm output subdevice */
 	s->type		= COMEDI_SUBD_PWM;
@@ -278,19 +275,46 @@ static int c6xdigio_attach(struct comedi_device *dev,
 	return 0;
 }
 
-static void c6xdigio_detach(struct comedi_device *dev)
-{
-	comedi_legacy_detach(dev);
-	pnp_unregister_driver(&c6xdigio_pnp_driver);
-}
-
 static struct comedi_driver c6xdigio_driver = {
 	.driver_name	= "c6xdigio",
 	.module		= THIS_MODULE,
 	.attach		= c6xdigio_attach,
-	.detach		= c6xdigio_detach,
+	.detach		= comedi_legacy_detach,
 };
-module_comedi_driver(c6xdigio_driver);
+
+static bool c6xdigio_pnp_registered = false;
+
+static int __init c6xdigio_module_init(void)
+{
+	int ret;
+
+	ret = comedi_driver_register(&c6xdigio_driver);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_PNP)) {
+		/*  Try to activate the PnP ports */
+		ret = pnp_register_driver(&c6xdigio_pnp_driver);
+		if (ret) {
+			pr_warn("failed to register pnp driver - err %d\n",
+				ret);
+			ret = 0;	/* ignore the error. */
+		} else {
+			c6xdigio_pnp_registered = true;
+		}
+	}
+
+	return 0;
+}
+module_init(c6xdigio_module_init);
+
+static void __exit c6xdigio_module_exit(void)
+{
+	if (c6xdigio_pnp_registered)
+		pnp_unregister_driver(&c6xdigio_pnp_driver);
+	comedi_driver_unregister(&c6xdigio_driver);
+}
+module_exit(c6xdigio_module_exit);
 
 MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for the C6x_DIGIO DSP daughter card");
diff --git a/drivers/comedi/drivers/multiq3.c b/drivers/comedi/drivers/multiq3.c
index 07ff5383da99..ac369e9a262d 100644
--- a/drivers/comedi/drivers/multiq3.c
+++ b/drivers/comedi/drivers/multiq3.c
@@ -67,6 +67,11 @@
 #define MULTIQ3_TRSFRCNTR_OL		0x10	/* xfer CNTR to OL (x and y) */
 #define MULTIQ3_EFLAG_RESET		0x06	/* reset E bit of flag reg */
 
+/*
+ * Limit on the number of optional encoder channels
+ */
+#define MULTIQ3_MAX_ENC_CHANS		8
+
 static void multiq3_set_ctrl(struct comedi_device *dev, unsigned int bits)
 {
 	/*
@@ -312,6 +317,10 @@ static int multiq3_attach(struct comedi_device *dev,
 	s->insn_read	= multiq3_encoder_insn_read;
 	s->insn_config	= multiq3_encoder_insn_config;
 
+	/* sanity check for number of encoder channels */
+	if (s->n_chan > MULTIQ3_MAX_ENC_CHANS)
+		s->n_chan = MULTIQ3_MAX_ENC_CHANS;
+
 	for (i = 0; i < s->n_chan; i++)
 		multiq3_encoder_reset(dev, i);
 
diff --git a/drivers/comedi/drivers/pcl818.c b/drivers/comedi/drivers/pcl818.c
index 4127adcfb229..06fe06396f23 100644
--- a/drivers/comedi/drivers/pcl818.c
+++ b/drivers/comedi/drivers/pcl818.c
@@ -1111,10 +1111,9 @@ static void pcl818_detach(struct comedi_device *dev)
 {
 	struct pcl818_private *devpriv = dev->private;
 
-	if (devpriv) {
-		pcl818_ai_cancel(dev, dev->read_subdev);
+	if (devpriv)
 		pcl818_reset(dev);
-	}
+
 	pcl818_free_dma(dev);
 	comedi_legacy_detach(dev);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 827507cfed7a..fab6e7721c80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3688,6 +3688,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
 		/* TODO: unmap ranges from GPU that lost access */
 	}
+	update_mapping |= !p->xnack_enabled && !list_empty(&remap_list);
+
 	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
 		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
 			 prange->svms, prange, prange->start,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
index 7de20e56082c..fd4e76486f2d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
@@ -32,22 +32,22 @@ enum vmw_bo_dirty_method {
 
 /**
  * struct vmw_bo_dirty - Dirty information for buffer objects
+ * @ref_count: Reference count for this structure. Must be first member!
  * @start: First currently dirty bit
  * @end: Last currently dirty bit + 1
  * @method: The currently used dirty method
  * @change_count: Number of consecutive method change triggers
- * @ref_count: Reference count for this structure
  * @bitmap_size: The size of the bitmap in bits. Typically equal to the
  * nuber of pages in the bo.
  * @bitmap: A bitmap where each bit represents a page. A set bit means a
  * dirty page.
  */
 struct vmw_bo_dirty {
+	struct   kref ref_count;
 	unsigned long start;
 	unsigned long end;
 	enum vmw_bo_dirty_method method;
 	unsigned int change_count;
-	unsigned int ref_count;
 	unsigned long bitmap_size;
 	unsigned long bitmap[];
 };
@@ -221,7 +221,7 @@ int vmw_bo_dirty_add(struct vmw_bo *vbo)
 	int ret;
 
 	if (dirty) {
-		dirty->ref_count++;
+		kref_get(&dirty->ref_count);
 		return 0;
 	}
 
@@ -235,7 +235,7 @@ int vmw_bo_dirty_add(struct vmw_bo *vbo)
 	dirty->bitmap_size = num_pages;
 	dirty->start = dirty->bitmap_size;
 	dirty->end = 0;
-	dirty->ref_count = 1;
+	kref_init(&dirty->ref_count);
 	if (num_pages < PAGE_SIZE / sizeof(pte_t)) {
 		dirty->method = VMW_BO_DIRTY_PAGETABLE;
 	} else {
@@ -274,10 +274,8 @@ void vmw_bo_dirty_release(struct vmw_bo *vbo)
 {
 	struct vmw_bo_dirty *dirty = vbo->dirty;
 
-	if (dirty && --dirty->ref_count == 0) {
-		kvfree(dirty);
+	if (dirty && kref_put(&dirty->ref_count, (void *)kvfree))
 		vbo->dirty = NULL;
-	}
 }
 
 /**
diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 61404d7a43ee..57da4f86a9fa 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -355,6 +355,7 @@ static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
 
 static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "SONiX USB DEVICE" },
+	{ "SONiX AK870 PRO" },
 	{ "Keychron" },
 	{ "AONE" },
 	{ "GANSS" },
diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 69771fd35006..981d1b6e9658 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -75,7 +75,8 @@ static const __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		 */
 		mouse_button_fixup(hdev, rdesc, *rsize, 20, 28, 22, 14, 8);
 		break;
-	case USB_DEVICE_ID_ELECOM_M_XT3URBK:
+	case USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB:
+	case USB_DEVICE_ID_ELECOM_M_XT3URBK_018F:
 	case USB_DEVICE_ID_ELECOM_M_XT3DRBK:
 	case USB_DEVICE_ID_ELECOM_M_XT4DRBK:
 		/*
@@ -119,7 +120,8 @@ static const __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_018F) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 52ae7c29f9e0..c4589075a5ed 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -449,7 +449,8 @@
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
 #define USB_DEVICE_ID_ELECOM_M_XGL20DLBK	0x00e6
-#define USB_DEVICE_ID_ELECOM_M_XT3URBK	0x00fb
+#define USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB	0x00fb
+#define USB_DEVICE_ID_ELECOM_M_XT3URBK_018F	0x018f
 #define USB_DEVICE_ID_ELECOM_M_XT3DRBK	0x00fc
 #define USB_DEVICE_ID_ELECOM_M_XT4DRBK	0x00fd
 #define USB_DEVICE_ID_ELECOM_M_DT1URBK	0x00fe
@@ -718,6 +719,7 @@
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
 #define I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720	0x837a
 #define USB_DEVICE_ID_ITE_LENOVO_YOGA900	0x8396
+#define I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD	0x8987
 #define USB_DEVICE_ID_ITE8595		0x8595
 #define USB_DEVICE_ID_ITE_MEDION_E1239T	0xce50
 
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 2c743e35c1d3..bc7de9ef45ec 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -386,10 +386,11 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_CHROMEBOOK_TROGDOR_POMPOM),
 	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	/*
-	 * Elan I2C-HID touchscreens seem to all report a non present battery,
-	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C-HID devices.
+	 * Elan HID touchscreens seem to all report a non present battery,
+	 * set HID_BATTERY_QUIRK_IGNORE for all Elan I2C and USB HID devices.
 	 */
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, HID_ANY_ID), HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 654879814f97..9cc3e029e9f6 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -148,6 +148,14 @@ static const __u8 lenovo_tpIIbtkbd_need_fixup_collection[] = {
 	0x81, 0x01,		/*   Input (Const,Array,Abs,No Wrap,Linear,Preferred State,No Null Position) */
 };
 
+static const __u8 lenovo_yoga7x_kbd_need_fixup_collection[] = {
+	0x15, 0x00,	// Logical Minimum (0)
+	0x25, 0x65,	// Logical Maximum (101)
+	0x05, 0x07,	// Usage Page (Keyboard)
+	0x19, 0x00,	// Usage Minimum (0)
+	0x29, 0xDD,	// Usage Maximum (221)
+};
+
 static const __u8 *lenovo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -177,6 +185,13 @@ static const __u8 *lenovo_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			rdesc[260] = 0x01; /* report count (2) = 0x01 */
 		}
 		break;
+	case I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD:
+		if (*rsize == 176 &&
+		    memcmp(&rdesc[52], lenovo_yoga7x_kbd_need_fixup_collection,
+			  sizeof(lenovo_yoga7x_kbd_need_fixup_collection)) == 0) {
+			rdesc[55] = rdesc[61]; // logical maximum = usage maximum
+		}
+		break;
 	}
 	return rdesc;
 }
@@ -1538,6 +1553,8 @@ static const struct hid_device_id lenovo_devices[] = {
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X12_TAB) },
 	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
 		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X12_TAB2) },
+	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
+		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD) },
 	{ }
 };
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 22760ac50f2d..c89a015686c0 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -410,7 +410,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_ELECOM)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XGL20DLBK) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_00FB) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK_018F) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 6e61787ed321..e15310fcd21a 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -125,7 +125,7 @@
 
 /* Miscellaneous Definitions */
 #define AD4080_SPI_READ						BIT(7)
-#define AD4080_CHIP_ID						GENMASK(2, 0)
+#define AD4080_CHIP_ID						0x0050
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -445,7 +445,8 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(st->regmap);
-	unsigned int id;
+	__le16 id_le;
+	u16 id;
 	int ret;
 
 	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
@@ -458,10 +459,12 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_CHIP_TYPE, &id);
+	ret = regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id_le,
+			       sizeof(id_le));
 	if (ret)
 		return ret;
 
+	id = le16_to_cpu(id_le);
 	if (id != AD4080_CHIP_ID)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 018f5afcd50d..5648f3200361 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -8113,6 +8113,9 @@ static const struct usb_device_id dev_table[] = {
 /* TP-Link TL-WN823N V2 */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0135, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192fu_fops},
+/* D-Link AN3U rev. A1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3328, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192fu_fops},
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 /* Still supported by rtlwifi */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
index 324fd5c8bfd4..755f76840b12 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
@@ -21,6 +21,8 @@ static const struct usb_device_id rtw_8822cu_id_table[] = {
 	  .driver_info = (kernel_ulong_t)&(rtw8822c_hw_spec) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x13b1, 0x0043, 0xff, 0xff, 0xff),
 	  .driver_info = (kernel_ulong_t)&(rtw8822c_hw_spec) }, /* Alpha - Alpha */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3329, 0xff, 0xff, 0xff),
+	  .driver_info = (kernel_ulong_t)&(rtw8822c_hw_spec) }, /* D-Link AC13U rev. A1 */
 	{},
 };
 MODULE_DEVICE_TABLE(usb, rtw_8822cu_id_table);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5714d4993282..28c598008124 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4896,7 +4896,6 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 	 */
 	nvme_stop_keep_alive(ctrl);
 	blk_mq_destroy_queue(ctrl->admin_q);
-	blk_put_queue(ctrl->admin_q);
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		blk_mq_destroy_queue(ctrl->fabrics_q);
 		blk_put_queue(ctrl->fabrics_q);
@@ -5040,6 +5039,8 @@ static void nvme_free_ctrl(struct device *dev)
 		container_of(dev, struct nvme_ctrl, ctrl_device);
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
+	if (ctrl->admin_q)
+		blk_put_queue(ctrl->admin_q);
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 	nvme_free_cels(ctrl);
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 83eb075b6bfa..3d6601dc6fcc 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -215,7 +215,7 @@ static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 	 */
 	if (d && i != gpio_func &&
 	    !test_and_set_bit(d->hwirq, pctrl->disabled_for_mux))
-		disable_irq(irq);
+		disable_irq_nosync(irq);
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 13eb22b35aa8..d848afc91f87 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -102,6 +102,7 @@ MODULE_ALIAS("wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");
 
 enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT = 0x1,
+	WMID_BACKLIGHT_EVENT = 0x4,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
 	WMID_AC_EVENT = 0x8,
@@ -2369,6 +2370,9 @@ static void acer_wmi_notify(union acpi_object *obj, void *context)
 			sparse_keymap_report_event(acer_wmi_input_dev, scancode, 1, true);
 		}
 		break;
+	case WMID_BACKLIGHT_EVENT:
+		/* Already handled by acpi-video */
+		break;
 	case WMID_ACCEL_OR_KBD_DOCK_EVENT:
 		acer_gsensor_event();
 		acer_kbd_dock_event(&return_value);
diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index d63aaad7ef59..404e62ad293a 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -122,6 +122,14 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
 		}
 	},
+	{
+		.ident = "ROG Xbox Ally RC73YA",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "RC73YA"),
+		}
+	},
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=218024 */
 	{
 		.ident = "V14 G4 AMN",
@@ -204,6 +212,23 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82ND"),
 		}
 	},
+	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4618 */
+	{
+		.ident = "Lenovo Legion Go 2",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N0"),
+		}
+	},
+	{
+		.ident = "Lenovo Legion Go 2",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83N1"),
+		}
+	},
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/2684 */
 	{
 		.ident = "HP Laptop 15s-eq2xxx",
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index bd318fd02ccf..cae3fcafd4d7 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -106,6 +106,7 @@ static void amd_pmc_get_ip_info(struct amd_pmc_dev *dev)
 	switch (dev->cpu_id) {
 	case AMD_CPU_ID_PCO:
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 		dev->num_ips = 12;
@@ -517,6 +518,7 @@ static int amd_pmc_get_os_hint(struct amd_pmc_dev *dev)
 	case AMD_CPU_ID_PCO:
 		return MSG_OS_HINT_PCO;
 	case AMD_CPU_ID_RN:
+	case AMD_CPU_ID_VG:
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 	case AMD_CPU_ID_PS:
@@ -717,6 +719,7 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_RV) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SP) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_SHP) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, AMD_CPU_ID_VG) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_ROOT) },
 	{ }
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index 62f3e51020fd..fe3f53eb5955 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -156,6 +156,7 @@ void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
 #define AMD_CPU_ID_RN			0x1630
 #define AMD_CPU_ID_PCO			AMD_CPU_ID_RV
 #define AMD_CPU_ID_CZN			AMD_CPU_ID_RN
+#define AMD_CPU_ID_VG			0x1645
 #define AMD_CPU_ID_YC			0x14B5
 #define AMD_CPU_ID_CB			0x14D8
 #define AMD_CPU_ID_PS			0x14E8
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8b3533d6ba09..ad9d9f97960f 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -92,9 +92,11 @@ static const char * const victus_thermal_profile_boards[] = {
 	"8A25"
 };
 
-/* DMI Board names of Victus 16-r1000 and Victus 16-s1000 laptops */
+/* DMI Board names of Victus 16-r and Victus 16-s laptops */
 static const char * const victus_s_thermal_profile_boards[] = {
-	"8C99", "8C9C"
+	"8BBE", "8BD4", "8BD5",
+	"8C78", "8C99", "8C9C",
+	"8D41",
 };
 
 enum hp_wmi_radio {
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index c3772df34679..8a4c54089ace 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -81,6 +81,10 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x289, { KEY_WLAN } },
 	// Huawei |M| key
 	{ KE_KEY,    0x28a, { KEY_CONFIG } },
+	// HONOR YOYO key
+	{ KE_KEY,    0x28b, { KEY_NOTIFICATION_CENTER } },
+	// HONOR print screen
+	{ KE_KEY,    0x28e, { KEY_PRINT } },
 	// Keyboard backlit
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index f25a427cccda..9c07a7faf18f 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -55,6 +55,7 @@ static const struct acpi_device_id intel_hid_ids[] = {
 	{ "INTC10CB" },
 	{ "INTC10CC" },
 	{ "INTC10F1" },
+	{ "INTC10F2" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 2a6897035150..0dfc552b2802 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -256,6 +256,10 @@ static const struct x86_cpu_id intel_uncore_cpu_ids[] = {
 	X86_MATCH_VFM(INTEL_ARROWLAKE, NULL),
 	X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
 	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
+	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
+	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_uncore_cpu_ids);
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 155ddeb8fcd4..bbf1fd4fe1e9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -519,9 +519,15 @@ static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
 	u32 reg;
 
-	reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
-	reg |= MX51_ECSPI_CTRL_XCH;
-	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	if (spi_imx->usedma) {
+		reg = readl(spi_imx->base + MX51_ECSPI_DMA);
+		reg |= MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN;
+		writel(reg, spi_imx->base + MX51_ECSPI_DMA);
+	} else {
+		reg = readl(spi_imx->base + MX51_ECSPI_CTRL);
+		reg |= MX51_ECSPI_CTRL_XCH;
+		writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
+	}
 }
 
 static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
@@ -759,7 +765,6 @@ static void mx51_setup_wml(struct spi_imx_data *spi_imx)
 	writel(MX51_ECSPI_DMA_RX_WML(spi_imx->wml - 1) |
 		MX51_ECSPI_DMA_TX_WML(tx_wml) |
 		MX51_ECSPI_DMA_RXT_WML(spi_imx->wml) |
-		MX51_ECSPI_DMA_TEDEN | MX51_ECSPI_DMA_RXDEN |
 		MX51_ECSPI_DMA_RXTDEN, spi_imx->base + MX51_ECSPI_DMA);
 }
 
@@ -1520,6 +1525,8 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 	reinit_completion(&spi_imx->dma_tx_completion);
 	dma_async_issue_pending(controller->dma_tx);
 
+	spi_imx->devtype_data->trigger(spi_imx);
+
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
 	/* Wait SDMA to finish the data transfer.*/
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index d59cc8a18484..c86dc56f38b4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -300,7 +300,7 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 
 		/* Read out all the data from the Rx FIFO */
 		rx_words = n_words;
-		stalled = 10;
+		stalled = 32;
 		while (rx_words) {
 			if (rx_words == n_words && !(stalled--) &&
 			    !(sr & XSPI_SR_TX_EMPTY_MASK) &&
diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 53d4c113b19c..df35c616e71f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -140,22 +140,24 @@ u8 *rtw_get_ie(u8 *pbuf, signed int index, signed int *len, signed int limit)
 	signed int tmp, i;
 	u8 *p;
 
-	if (limit < 1)
+	if (limit < 2)
 		return NULL;
 
 	p = pbuf;
 	i = 0;
 	*len = 0;
-	while (1) {
+	while (i + 2 <= limit) {
+		tmp = *(p + 1);
+		if (i + 2 + tmp > limit)
+			break;
+
 		if (*p == index) {
-			*len = *(p + 1);
+			*len = tmp;
 			return p;
 		}
-		tmp = *(p + 1);
+
 		p += (tmp + 2);
 		i += (tmp + 2);
-		if (i >= limit)
-			break;
 	}
 	return NULL;
 }
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bc980d21d50e..32aa168bcb07 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -579,9 +579,11 @@ unsigned int OnBeacon(struct adapter *padapter, union recv_frame *precv_frame)
 
 	p = rtw_get_ie(pframe + sizeof(struct ieee80211_hdr_3addr) + _BEACON_IE_OFFSET_, WLAN_EID_EXT_SUPP_RATES, &ielen, precv_frame->u.hdr.len - sizeof(struct ieee80211_hdr_3addr) - _BEACON_IE_OFFSET_);
 	if (p && ielen > 0) {
-		if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D))
-			/* Invalid value 0x2D is detected in Extended Supported Rates (ESR) IE. Try to fix the IE length to avoid failed Beacon parsing. */
-			*(p + 1) = ielen - 1;
+		if (p + 2 + ielen < pframe + len) {
+			if ((*(p + 1 + ielen) == 0x2D) && (*(p + 2 + ielen) != 0x2D))
+				/* Invalid value 0x2D is detected in Extended Supported Rates (ESR) IE. Try to fix the IE length to avoid failed Beacon parsing. */
+				*(p + 1) = ielen - 1;
+		}
 	}
 
 	if (pmlmeext->sitesurvey_res.state == SCAN_PROCESS) {
@@ -1033,6 +1035,9 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 		status = WLAN_STATUS_CHALLENGE_FAIL;
 		goto OnAssocReqFail;
 	} else {
+		if (ie_len > sizeof(supportRate))
+			ie_len = sizeof(supportRate);
+
 		memcpy(supportRate, p+2, ie_len);
 		supportRateNum = ie_len;
 
@@ -1040,7 +1045,7 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 				pkt_len - WLAN_HDR_A3_LEN - ie_offset);
 		if (p) {
 
-			if (supportRateNum <= sizeof(supportRate)) {
+			if (supportRateNum + ie_len <= sizeof(supportRate)) {
 				memcpy(supportRate+supportRateNum, p+2, ie_len);
 				supportRateNum += ie_len;
 			}
diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 152f914c599d..12e8ceffab65 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -95,6 +95,11 @@
 #define PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
 #define PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
 
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7500        0x7003
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG     0x7024
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG     0x7025
+#define PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG     0x7026
+
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
@@ -5996,6 +6001,38 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0,
 		pbn_ADDIDATA_PCIe_8_3906250 },
 
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7500,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_4_115200 },
+
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_4_115200 },
+
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_2_115200 },
+
+	{	PCI_VENDOR_ID_ADDIDATA,
+		PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG,
+		PCI_ANY_ID,
+		PCI_ANY_ID,
+		0,
+		0,
+		pbn_b0_1_115200 },
+
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
 		PCI_VENDOR_ID_IBM, 0x0299,
 		0, 0, pbn_b0_bt_2_115200 },
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 62bb62b82cbe..1db4af6fe590 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1024,8 +1024,16 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		status &= ~s->params->overrun_mask;
-		s->ops->write_reg(port, s->params->overrun_reg, status);
+		if (s->type == SCI_PORT_RSCI) {
+			/*
+			 * All of the CFCLR_*C clearing bits match the corresponding
+			 * CSR_*status bits. So, reuse the overrun mask for clearing.
+			 */
+			s->ops->clear_SCxSR(port, s->params->overrun_mask);
+		} else {
+			status &= ~s->params->overrun_mask;
+			s->ops->write_reg(port, s->params->overrun_reg, status);
+		}
 
 		port->icount.overrun++;
 
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 44f5b58beec9..aa6b4c4ad5ec 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -435,7 +435,7 @@ static int belkin_sa_tiocmset(struct tty_struct *tty,
 	struct belkin_sa_private *priv = usb_get_serial_port_data(port);
 	unsigned long control_state;
 	unsigned long flags;
-	int retval;
+	int retval = 0;
 	int rts = 0;
 	int dtr = 0;
 
@@ -452,26 +452,32 @@ static int belkin_sa_tiocmset(struct tty_struct *tty,
 	}
 	if (clear & TIOCM_RTS) {
 		control_state &= ~TIOCM_RTS;
-		rts = 0;
+		rts = 1;
 	}
 	if (clear & TIOCM_DTR) {
 		control_state &= ~TIOCM_DTR;
-		dtr = 0;
+		dtr = 1;
 	}
 
 	priv->control_state = control_state;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	retval = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST, rts);
-	if (retval < 0) {
-		dev_err(&port->dev, "Set RTS error %d\n", retval);
-		goto exit;
+	if (rts) {
+		retval = BSA_USB_CMD(BELKIN_SA_SET_RTS_REQUEST,
+					!!(control_state & TIOCM_RTS));
+		if (retval < 0) {
+			dev_err(&port->dev, "Set RTS error %d\n", retval);
+			goto exit;
+		}
 	}
 
-	retval = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST, dtr);
-	if (retval < 0) {
-		dev_err(&port->dev, "Set DTR error %d\n", retval);
-		goto exit;
+	if (dtr) {
+		retval = BSA_USB_CMD(BELKIN_SA_SET_DTR_REQUEST,
+					!!(control_state & TIOCM_DTR));
+		if (retval < 0) {
+			dev_err(&port->dev, "Set DTR error %d\n", retval);
+			goto exit;
+		}
 	}
 exit:
 	return retval;
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index b37fa31f5694..9993a5123344 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -628,10 +628,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_IBS_PEDO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_IBS_PROD_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_TAVIR_STK500_PID) },
-	{ USB_DEVICE(FTDI_VID, FTDI_TIAO_UMPA_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLXM_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_TIAO_UMPA_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_NT_ORIONLXM_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONLX_PLUS_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORION_IO_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_NT_ORIONMX_PID) },
@@ -842,24 +840,17 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_ELSTER_UNICOM_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_PROPOX_JTAGCABLEII_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_PROPOX_ISPCABLEIII_PID) },
-	{ USB_DEVICE(FTDI_VID, CYBER_CORTEX_AV_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, CYBER_CORTEX_AV_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_OCD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_OCD_H_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_TINY_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(OLIMEX_VID, OLIMEX_ARM_USB_TINY_H_PID, 1) },
-	{ USB_DEVICE(FIC_VID, FIC_NEO1973_DEBUG_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_OOCDLINK_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, LMI_LM3S_DEVEL_BOARD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, LMI_LM3S_EVAL_BOARD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, LMI_LM3S_ICDI_BOARD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_TURTELIZER_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FIC_VID, FIC_NEO1973_DEBUG_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_OOCDLINK_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_DEVEL_BOARD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_EVAL_BOARD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_ICDI_BOARD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_TURTELIZER_PID, 1) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_USB60F) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_SCU18) },
 	{ USB_DEVICE(FTDI_VID, FTDI_REU_TINY_PID) },
@@ -901,17 +892,14 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(ATMEL_VID, STK541_PID) },
 	{ USB_DEVICE(DE_VID, STB_PID) },
 	{ USB_DEVICE(DE_VID, WHT_PID) },
-	{ USB_DEVICE(ADI_VID, ADI_GNICE_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(ADI_VID, ADI_GNICEPLUS_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(ADI_VID, ADI_GNICE_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ADI_VID, ADI_GNICEPLUS_PID, 1) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(MICROCHIP_VID, MICROCHIP_USB_BOARD_PID,
 					USB_CLASS_VENDOR_SPEC,
 					USB_SUBCLASS_VENDOR_SPEC, 0x00) },
 	{ USB_DEVICE_INTERFACE_NUMBER(ACTEL_VID, MICROSEMI_ARROW_SF2PLUS_BOARD_PID, 2) },
 	{ USB_DEVICE(JETI_VID, JETI_SPC1201_PID) },
-	{ USB_DEVICE(MARVELL_VID, MARVELL_SHEEVAPLUG_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(MARVELL_VID, MARVELL_SHEEVAPLUG_PID, 1) },
 	{ USB_DEVICE(LARSENBRUSGAARD_VID, LB_ALTITRACK_PID) },
 	{ USB_DEVICE(GN_OTOMETRICS_VID, AURICAL_USB_PID) },
 	{ USB_DEVICE(FTDI_VID, PI_C865_PID) },
@@ -934,10 +922,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(PI_VID, PI_1016_PID) },
 	{ USB_DEVICE(KONDO_VID, KONDO_USB_SERIAL_PID) },
 	{ USB_DEVICE(BAYER_VID, BAYER_CONTOUR_CABLE_PID) },
-	{ USB_DEVICE(FTDI_VID, MARVELL_OPENRD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, TI_XDS100V2_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, MARVELL_OPENRD_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, TI_XDS100V2_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, HAMEG_HO820_PID) },
 	{ USB_DEVICE(FTDI_VID, HAMEG_HO720_PID) },
 	{ USB_DEVICE(FTDI_VID, HAMEG_HO730_PID) },
@@ -946,18 +932,14 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, MJSG_SR_RADIO_PID) },
 	{ USB_DEVICE(FTDI_VID, MJSG_HD_RADIO_PID) },
 	{ USB_DEVICE(FTDI_VID, MJSG_XM_RADIO_PID) },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_ST_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SLITE_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SH2_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, XVERVE_SIGNALYZER_ST_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, XVERVE_SIGNALYZER_SLITE_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, XVERVE_SIGNALYZER_SH2_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, XVERVE_SIGNALYZER_SH4_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(FTDI_VID, SEGWAY_RMP200_PID) },
 	{ USB_DEVICE(FTDI_VID, ACCESIO_COM4SM_PID) },
-	{ USB_DEVICE(IONICS_VID, IONICS_PLUGCOMPUTER_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(IONICS_VID, IONICS_PLUGCOMPUTER_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_24_MASTER_WING_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_PC_WING_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_CHAMSYS_USB_DMX_PID) },
@@ -972,15 +954,12 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(FTDI_VID, FTDI_CINTERION_MC55I_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_FHE_PID) },
 	{ USB_DEVICE(FTDI_VID, FTDI_DOTEC_PID) },
-	{ USB_DEVICE(QIHARDWARE_VID, MILKYMISTONE_JTAGSERIAL_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(ST_VID, ST_STMCLT_2232_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(QIHARDWARE_VID, MILKYMISTONE_JTAGSERIAL_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ST_VID, ST_STMCLT_2232_PID, 1) },
 	{ USB_DEVICE(ST_VID, ST_STMCLT_4232_PID),
 		.driver_info = (kernel_ulong_t)&ftdi_stmclite_quirk },
 	{ USB_DEVICE(FTDI_VID, FTDI_RF_R106) },
-	{ USB_DEVICE(FTDI_VID, FTDI_DISTORTEC_JTAG_LOCK_PICK_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_DISTORTEC_JTAG_LOCK_PICK_PID, 1) },
 	{ USB_DEVICE(FTDI_VID, FTDI_LUMEL_PD12_PID) },
 	/* Crucible Devices */
 	{ USB_DEVICE(FTDI_VID, FTDI_CT_COMET_PID) },
@@ -1055,8 +1034,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7561U_PID) },
 	{ USB_DEVICE(ICPDAS_VID, ICPDAS_I7563U_PID) },
 	{ USB_DEVICE(WICED_VID, WICED_USB20706V2_PID) },
-	{ USB_DEVICE(TI_VID, TI_CC3200_LAUNCHPAD_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(TI_VID, TI_CC3200_LAUNCHPAD_PID, 1) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_BT_USB_PID) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_WL_USB_PID) },
 	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
@@ -1076,10 +1054,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE(UBLOX_VID, UBLOX_C099F9P_ODIN_PID) },
 	{ USB_DEVICE_INTERFACE_NUMBER(UBLOX_VID, UBLOX_EVK_M101_PID, 2) },
 	/* FreeCalypso USB adapters */
-	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
-	{ USB_DEVICE(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID),
-		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_FALCONIA_JTAG_BUF_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_FALCONIA_JTAG_UNBUF_PID, 1) },
 	/* GMC devices */
 	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
 	/* Altera USB Blaster 3 */
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 464433be2034..96ea571c436a 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -418,7 +418,7 @@ static int kobil_tiocmset(struct tty_struct *tty,
 	struct usb_serial_port *port = tty->driver_data;
 	struct device *dev = &port->dev;
 	struct kobil_private *priv;
-	int result;
+	int result = 0;
 	int dtr = 0;
 	int rts = 0;
 
@@ -435,12 +435,12 @@ static int kobil_tiocmset(struct tty_struct *tty,
 	if (set & TIOCM_DTR)
 		dtr = 1;
 	if (clear & TIOCM_RTS)
-		rts = 0;
+		rts = 1;
 	if (clear & TIOCM_DTR)
-		dtr = 0;
+		dtr = 1;
 
-	if (priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) {
-		if (dtr != 0)
+	if (dtr && priv->device_type == KOBIL_ADAPTER_B_PRODUCT_ID) {
+		if (set & TIOCM_DTR)
 			dev_dbg(dev, "%s - Setting DTR\n", __func__);
 		else
 			dev_dbg(dev, "%s - Clearing DTR\n", __func__);
@@ -448,13 +448,13 @@ static int kobil_tiocmset(struct tty_struct *tty,
 			  usb_sndctrlpipe(port->serial->dev, 0),
 			  SUSBCRequest_SetStatusLinesOrQueues,
 			  USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			  ((dtr != 0) ? SUSBCR_SSL_SETDTR : SUSBCR_SSL_CLRDTR),
+			  ((set & TIOCM_DTR) ? SUSBCR_SSL_SETDTR : SUSBCR_SSL_CLRDTR),
 			  0,
 			  NULL,
 			  0,
 			  KOBIL_TIMEOUT);
-	} else {
-		if (rts != 0)
+	} else if (rts) {
+		if (set & TIOCM_RTS)
 			dev_dbg(dev, "%s - Setting RTS\n", __func__);
 		else
 			dev_dbg(dev, "%s - Clearing RTS\n", __func__);
@@ -462,7 +462,7 @@ static int kobil_tiocmset(struct tty_struct *tty,
 			usb_sndctrlpipe(port->serial->dev, 0),
 			SUSBCRequest_SetStatusLinesOrQueues,
 			USB_TYPE_VENDOR | USB_RECIP_ENDPOINT | USB_DIR_OUT,
-			((rts != 0) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
+			((set & TIOCM_RTS) ? SUSBCR_SSL_SETRTS : SUSBCR_SSL_CLRRTS),
 			0,
 			NULL,
 			0,
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index e9400727ad36..4c0e5a3ab557 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1433,17 +1433,31 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10b3, 0xff, 0xff, 0x60) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c0, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c1, 0xff),	/* Telit FE910C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c2, 0xff),	/* Telit FE910C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c3, 0xff),	/* Telit FE910C04 (ECM) */
+	  .driver_info = NCTRL(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c4, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c5, 0xff),	/* Telit FE910C04 (RNDIS) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c6, 0xff),	/* Telit FE910C04 (MBIM) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),	/* Telit FE910C04 (ECM) */
+	  .driver_info = NCTRL(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c8, 0xff),	/* Telit FE910C04 (rmnet) */
 	  .driver_info = RSVD(0) | NCTRL(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10c9, 0xff),	/* Telit FE910C04 (MBIM) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x10cb, 0xff),	/* Telit FE910C04 (RNDIS) */
+	  .driver_info = NCTRL(3) | RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x30),	/* Telit FN990B (rmnet) */
 	  .driver_info = NCTRL(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d0, 0xff, 0xff, 0x60) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x30),	/* Telit FE910C04 (ECM) */
-	  .driver_info = NCTRL(4) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10c7, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x30),	/* Telit FN990B (MBIM) */
 	  .driver_info = NCTRL(6) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x10d1, 0xff, 0xff, 0x40) },
@@ -2376,6 +2390,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe0f0, 0xff),			/* Foxconn T99W373 MBIM */
 	  .driver_info = RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe123, 0xff),			/* Foxconn T99W760 MBIM */
+	  .driver_info = RSVD(3) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe145, 0xff),			/* Foxconn T99W651 RNDIS */
 	  .driver_info = RSVD(5) | RSVD(6) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x0489, 0xe15f, 0xff),                     /* Foxconn T99W709 */
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index 1d41ce477df5..984b365df046 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -61,7 +61,19 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 	off = (ino - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
 	di = (struct bfs_inode *)bh->b_data + off;
 
-	inode->i_mode = 0x0000FFFF & le32_to_cpu(di->i_mode);
+	/*
+	 * https://martin.hinner.info/fs/bfs/bfs-structure.html explains that
+	 * BFS in SCO UnixWare environment used only lower 9 bits of di->i_mode
+	 * value. This means that, although bfs_write_inode() saves whole
+	 * inode->i_mode bits (which include S_IFMT bits and S_IS{UID,GID,VTX}
+	 * bits), middle 7 bits of di->i_mode value can be garbage when these
+	 * bits were not saved by bfs_write_inode().
+	 * Since we can't tell whether middle 7 bits are garbage, use only
+	 * lower 12 bits (i.e. tolerate S_IS{UID,GID,VTX} bits possibly being
+	 * garbage) and reconstruct S_IFMT bits for Linux environment from
+	 * di->i_vtype value.
+	 */
+	inode->i_mode = 0x00000FFF & le32_to_cpu(di->i_mode);
 	if (le32_to_cpu(di->i_vtype) == BFS_VDIR) {
 		inode->i_mode |= S_IFDIR;
 		inode->i_op = &bfs_dir_inops;
@@ -71,6 +83,11 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
 		inode->i_op = &bfs_file_inops;
 		inode->i_fop = &bfs_file_operations;
 		inode->i_mapping->a_ops = &bfs_aops;
+	} else {
+		brelse(bh);
+		printf("Unknown vtype=%u %s:%08lx\n",
+		       le32_to_cpu(di->i_vtype), inode->i_sb->s_id, ino);
+		goto error;
 	}
 
 	BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..1f6bc05593df 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -418,7 +418,12 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 		return -ENOSPC;
 
 	ext4_write_lock_xattr(inode, &no_expand);
-
+	/*
+	 * ei->i_inline_size may have changed since the initial check
+	 * if other xattrs were added. Recalculate to ensure
+	 * ext4_update_inline_data() validates against current capacity.
+	 */
+	(void) ext4_find_inline_data_nolock(inode);
 	if (ei->i_inline_off)
 		ret = ext4_update_inline_data(handle, inode, len);
 	else
@@ -446,9 +451,13 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	if (!ei->i_inline_off)
 		return 0;
 
+	down_write(&ei->i_data_sem);
+
 	error = ext4_get_inode_loc(inode, &is.iloc);
-	if (error)
+	if (error) {
+		up_write(&ei->i_data_sem);
 		return error;
+	}
 
 	error = ext4_xattr_ibody_find(inode, &i, &is);
 	if (error)
@@ -487,6 +496,7 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 	brelse(is.iloc.bh);
 	if (error == -ENODATA)
 		error = 0;
+	up_write(&ei->i_data_sem);
 	return error;
 }
 
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 3e510564de6e..9ce626ac947e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1284,14 +1284,23 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
 	 * committing transaction's lists, but it HAS to be in Forget state in
 	 * that case: the transaction must have deleted the buffer for it to be
 	 * reused here.
+	 * In the case of file system data inconsistency, for example, if the
+	 * block bitmap of a referenced block is not set, it can lead to the
+	 * situation where a block being committed is allocated and used again.
+	 * As a result, the following condition will not be satisfied, so here
+	 * we directly trigger a JBD abort instead of immediately invoking
+	 * bugon.
 	 */
 	spin_lock(&jh->b_state_lock);
-	J_ASSERT_JH(jh, (jh->b_transaction == transaction ||
-		jh->b_transaction == NULL ||
-		(jh->b_transaction == journal->j_committing_transaction &&
-			  jh->b_jlist == BJ_Forget)));
+	if (!(jh->b_transaction == transaction || jh->b_transaction == NULL ||
+	      (jh->b_transaction == journal->j_committing_transaction &&
+	       jh->b_jlist == BJ_Forget)) || jh->b_next_transaction != NULL) {
+		err = -EROFS;
+		spin_unlock(&jh->b_state_lock);
+		jbd2_journal_abort(journal, err);
+		goto out;
+	}
 
-	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
 	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
 
 	if (jh->b_transaction == NULL) {
diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index c9cd00b96cde..44dc5e24482e 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1472,7 +1472,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 			break;
 		}
 
-		if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) >
+		if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) ==
 		    CIFS_MAX_USERNAME_LEN) {
 			pr_warn("username too long\n");
 			goto cifs_parse_mount_err;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2c08cccfa680..2dbabe2d8005 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -553,12 +553,16 @@ static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle
 	up_write(&ipc_msg_table_lock);
 
 	ret = ipc_msg_send(msg);
-	if (ret)
+	if (ret) {
+		down_write(&ipc_msg_table_lock);
 		goto out;
+	}
 
 	ret = wait_event_interruptible_timeout(entry.wait,
 					       entry.response != NULL,
 					       IPC_WAIT_TIMEOUT);
+
+	down_write(&ipc_msg_table_lock);
 	if (entry.response) {
 		ret = ipc_validate_msg(&entry);
 		if (ret) {
@@ -567,7 +571,6 @@ static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle
 		}
 	}
 out:
-	down_write(&ipc_msg_table_lock);
 	hash_del(&entry.ipc_table_hlist);
 	up_write(&ipc_msg_table_lock);
 	return entry.response;
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2e41db..2338b3adfb55 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
-	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1e4740de66c2..9592579db949 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5377,8 +5377,8 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
-		init_irq_work(&rq->scx.deferred_irq_work, deferred_irq_workfn);
-		init_irq_work(&rq->scx.kick_cpus_irq_work, kick_cpus_irq_workfn);
+		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
+		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
 		if (cpu_online(cpu))
 			cpu_rq(cpu)->scx.flags |= SCX_RQ_ONLINE;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index cbeb7e833131..59cfacb8a5bb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1971,7 +1971,8 @@ static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops)
  */
 static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 					 struct ftrace_hash *old_hash,
-					 struct ftrace_hash *new_hash)
+					 struct ftrace_hash *new_hash,
+					 bool update_target)
 {
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec, *end = NULL;
@@ -2006,10 +2007,13 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 		if (rec->flags & FTRACE_FL_DISABLED)
 			continue;
 
-		/* We need to update only differences of filter_hash */
+		/*
+		 * Unless we are updating the target of a direct function,
+		 * we only need to update differences of filter_hash
+		 */
 		in_old = !!ftrace_lookup_ip(old_hash, rec->ip);
 		in_new = !!ftrace_lookup_ip(new_hash, rec->ip);
-		if (in_old == in_new)
+		if (!update_target && (in_old == in_new))
 			continue;
 
 		if (in_new) {
@@ -2020,7 +2024,16 @@ static int __ftrace_hash_update_ipmodify(struct ftrace_ops *ops,
 				if (is_ipmodify)
 					goto rollback;
 
-				FTRACE_WARN_ON(rec->flags & FTRACE_FL_DIRECT);
+				/*
+				 * If this is called by __modify_ftrace_direct()
+				 * then it is only changing where the direct
+				 * pointer is jumping to, and the record already
+				 * points to a direct trampoline. If it isn't,
+				 * then it is a bug to update ipmodify on a direct
+				 * caller.
+				 */
+				FTRACE_WARN_ON(!update_target &&
+					       (rec->flags & FTRACE_FL_DIRECT));
 
 				/*
 				 * Another ops with IPMODIFY is already
@@ -2076,7 +2089,7 @@ static int ftrace_hash_ipmodify_enable(struct ftrace_ops *ops)
 	if (ftrace_hash_empty(hash))
 		hash = NULL;
 
-	return __ftrace_hash_update_ipmodify(ops, EMPTY_HASH, hash);
+	return __ftrace_hash_update_ipmodify(ops, EMPTY_HASH, hash, false);
 }
 
 /* Disabling always succeeds */
@@ -2087,7 +2100,7 @@ static void ftrace_hash_ipmodify_disable(struct ftrace_ops *ops)
 	if (ftrace_hash_empty(hash))
 		hash = NULL;
 
-	__ftrace_hash_update_ipmodify(ops, hash, EMPTY_HASH);
+	__ftrace_hash_update_ipmodify(ops, hash, EMPTY_HASH, false);
 }
 
 static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
@@ -2101,7 +2114,7 @@ static int ftrace_hash_ipmodify_update(struct ftrace_ops *ops,
 	if (ftrace_hash_empty(new_hash))
 		new_hash = NULL;
 
-	return __ftrace_hash_update_ipmodify(ops, old_hash, new_hash);
+	return __ftrace_hash_update_ipmodify(ops, old_hash, new_hash, false);
 }
 
 static void print_ip_ins(const char *fmt, const unsigned char *p)
@@ -6114,7 +6127,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
 static int
 __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash;
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	struct ftrace_func_entry *entry, *iter;
 	static struct ftrace_ops tmp_ops = {
 		.func		= ftrace_stub,
@@ -6134,13 +6147,21 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	if (err)
 		return err;
 
+	/*
+	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
+	 * ops->ops_func for the ops. This is needed because the above
+	 * register_ftrace_function_nolock() worked on tmp_ops.
+	 */
+	err = __ftrace_hash_update_ipmodify(ops, hash, hash, true);
+	if (err)
+		goto out;
+
 	/*
 	 * Now the ftrace_ops_list_func() is called to do the direct callers.
 	 * We can safely change the direct functions attached to each entry.
 	 */
 	mutex_lock(&ftrace_lock);
 
-	hash = ops->func_hash->filter_hash;
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
@@ -6155,6 +6176,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 
 	mutex_unlock(&ftrace_lock);
 
+out:
 	/* Removing the tmp_ops will add the updated direct callers to the functions */
 	unregister_ftrace_function(&tmp_ops);
 
diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..424a6fa15723 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -19,6 +19,12 @@
 #include <time.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
+
+// Work around glibc header silliness
+#undef AT_RENAME_NOREPLACE
+#undef AT_RENAME_EXCHANGE
+#undef AT_RENAME_WHITEOUT
+
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #define statx foo
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
index 8c6cb57d5cfc..24cf7d7a1972 100644
--- a/samples/watch_queue/watch_test.c
+++ b/samples/watch_queue/watch_test.c
@@ -16,6 +16,12 @@
 #include <errno.h>
 #include <sys/ioctl.h>
 #include <limits.h>
+
+// Work around glibc header silliness
+#undef AT_RENAME_NOREPLACE
+#undef AT_RENAME_EXCHANGE
+#undef AT_RENAME_WHITEOUT
+
 #include <linux/watch_queue.h>
 #include <linux/unistd.h>
 #include <linux/keyctl.h>
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 796f555dd381..5e0c0f1e231b 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6685,6 +6685,15 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8e60, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e61, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8e62, "HP Trekker ", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed5, "HP Merino13X", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed6, "HP Merino13", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed7, "HP Merino14", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed8, "HP Merino16", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8ed9, "HP Merino14W", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8eda, "HP Merino16W", ALC245_FIXUP_TAS2781_SPI_2),
+	SND_PCI_QUIRK(0x103c, 0x8f40, "HP Lampas14", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x103c, 0x8f41, "HP Lampas16", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x103c, 0x8f42, "HP LampasW14", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1032, "ASUS VivoBook X513EA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1034, "ASUS GU605C", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 13f68f7b6dd6..0ccb6775f4de 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -894,7 +894,8 @@ static int find_sdca_entity_control(struct device *dev, struct sdca_entity *enti
 		return ret;
 	}
 
-	control->values = devm_kzalloc(dev, hweight64(control->cn_list), GFP_KERNEL);
+	control->values = devm_kcalloc(dev, hweight64(control->cn_list),
+				       sizeof(int), GFP_KERNEL);
 	if (!control->values)
 		return -ENOMEM;
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b04f52adb1f4..70f9e0cc28fa 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2022,6 +2022,8 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case USB_ID(0x16d0, 0x09d8): /* NuPrime IDA-8 */
 	case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
 	case USB_ID(0x16d0, 0x09dd): /* Encore mDSD */
+	case USB_ID(0x16d0, 0x0ab1): /* PureAudio APA DAC */
+	case USB_ID(0x16d0, 0xeca1): /* PureAudio Lotus DAC5, DAC5 SE, DAC5 Pro */
 	case USB_ID(0x1db5, 0x0003): /* Bryston BDA3 */
 	case USB_ID(0x20a0, 0x4143): /* WaveIO USB Audio 2.0 */
 	case USB_ID(0x22e1, 0xca01): /* HDTA Serenade DSD */
@@ -2289,6 +2291,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CLOCK_SOURCE),
 	DEVICE_FLG(0x1686, 0x00dd, /* Zoom R16/24 */
 		   QUIRK_FLAG_TX_LENGTH | QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x16d0, 0x0ab1, /* PureAudio APA DAC */
+		   QUIRK_FLAG_DSD_RAW),
+	DEVICE_FLG(0x16d0, 0xeca1, /* PureAudio Lotus DAC5, DAC5 SE and DAC5 Pro */
+		   QUIRK_FLAG_DSD_RAW),
 	DEVICE_FLG(0x17aa, 0x1046, /* Lenovo ThinkStation P620 Rear Line-in, Line-out and Microphone */
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x17aa, 0x104d, /* Lenovo ThinkStation P620 Internal Speaker + Front Headset */

