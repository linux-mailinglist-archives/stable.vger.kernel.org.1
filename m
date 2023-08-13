Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A670077AC80
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjHMVdw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjHMVdv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:33:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E29D10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:33:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C12AF62BCD
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7804C433C7;
        Sun, 13 Aug 2023 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962432;
        bh=ZT7cWqjLII30clHnd11sS+I77+NKtunGs1B5f/b6ZUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Btly3z4w+4iks5Sv63+0Lc7r8wIO2Eh/OKoxOPB8ElsCBuNKpTcxKDuVTJkDC5DY0
         pLBSefVLfqrqxL2D3LNAbv8wonUvk/9TlHARUU5tnFRsbNlTZeiGQC12EpWmiah/js
         GASXHYpfdDIoeoB4gHpbSvnS4dsiGPc565e6OXTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.1 007/149] KVM: SEV: snapshot the GHCB before accessing it
Date:   Sun, 13 Aug 2023 23:17:32 +0200
Message-ID: <20230813211718.983186091@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 4e15a0ddc3ff40e8ea84032213976ecf774d7f77 upstream.

Validation of the GHCB is susceptible to time-of-check/time-of-use vulnerabilities.
To avoid them, we would like to always snapshot the fields that are read in
sev_es_validate_vmgexit(), and not use the GHCB anymore after it returns.

This means:

- invoking sev_es_sync_from_ghcb() before any GHCB access, including before
  sev_es_validate_vmgexit()

- snapshotting all fields including the valid bitmap and the sw_scratch field,
  which are currently not caching anywhere.

The valid bitmap is the first thing to be copied out of the GHCB; then,
further accesses will use the copy in svm->sev_es.

Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |   69 ++++++++++++++++++++++++-------------------------
 arch/x86/kvm/svm/svm.h |   26 ++++++++++++++++++
 2 files changed, 61 insertions(+), 34 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2410,15 +2410,18 @@ static void sev_es_sync_from_ghcb(struct
 	 */
 	memset(vcpu->arch.regs, 0, sizeof(vcpu->arch.regs));
 
-	vcpu->arch.regs[VCPU_REGS_RAX] = ghcb_get_rax_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RBX] = ghcb_get_rbx_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RCX] = ghcb_get_rcx_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RDX] = ghcb_get_rdx_if_valid(ghcb);
-	vcpu->arch.regs[VCPU_REGS_RSI] = ghcb_get_rsi_if_valid(ghcb);
+	BUILD_BUG_ON(sizeof(svm->sev_es.valid_bitmap) != sizeof(ghcb->save.valid_bitmap));
+	memcpy(&svm->sev_es.valid_bitmap, &ghcb->save.valid_bitmap, sizeof(ghcb->save.valid_bitmap));
 
-	svm->vmcb->save.cpl = ghcb_get_cpl_if_valid(ghcb);
+	vcpu->arch.regs[VCPU_REGS_RAX] = kvm_ghcb_get_rax_if_valid(svm, ghcb);
+	vcpu->arch.regs[VCPU_REGS_RBX] = kvm_ghcb_get_rbx_if_valid(svm, ghcb);
+	vcpu->arch.regs[VCPU_REGS_RCX] = kvm_ghcb_get_rcx_if_valid(svm, ghcb);
+	vcpu->arch.regs[VCPU_REGS_RDX] = kvm_ghcb_get_rdx_if_valid(svm, ghcb);
+	vcpu->arch.regs[VCPU_REGS_RSI] = kvm_ghcb_get_rsi_if_valid(svm, ghcb);
 
-	if (ghcb_xcr0_is_valid(ghcb)) {
+	svm->vmcb->save.cpl = kvm_ghcb_get_cpl_if_valid(svm, ghcb);
+
+	if (kvm_ghcb_xcr0_is_valid(svm)) {
 		vcpu->arch.xcr0 = ghcb_get_xcr0(ghcb);
 		kvm_update_cpuid_runtime(vcpu);
 	}
@@ -2429,6 +2432,7 @@ static void sev_es_sync_from_ghcb(struct
 	control->exit_code_hi = upper_32_bits(exit_code);
 	control->exit_info_1 = ghcb_get_sw_exit_info_1(ghcb);
 	control->exit_info_2 = ghcb_get_sw_exit_info_2(ghcb);
+	svm->sev_es.sw_scratch = kvm_ghcb_get_sw_scratch_if_valid(svm, ghcb);
 
 	/* Clear the valid entries fields */
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
@@ -2457,56 +2461,56 @@ static int sev_es_validate_vmgexit(struc
 
 	reason = GHCB_ERR_MISSING_INPUT;
 
-	if (!ghcb_sw_exit_code_is_valid(ghcb) ||
-	    !ghcb_sw_exit_info_1_is_valid(ghcb) ||
-	    !ghcb_sw_exit_info_2_is_valid(ghcb))
+	if (!kvm_ghcb_sw_exit_code_is_valid(svm) ||
+	    !kvm_ghcb_sw_exit_info_1_is_valid(svm) ||
+	    !kvm_ghcb_sw_exit_info_2_is_valid(svm))
 		goto vmgexit_err;
 
 	switch (ghcb_get_sw_exit_code(ghcb)) {
 	case SVM_EXIT_READ_DR7:
 		break;
 	case SVM_EXIT_WRITE_DR7:
-		if (!ghcb_rax_is_valid(ghcb))
+		if (!kvm_ghcb_rax_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_EXIT_RDTSC:
 		break;
 	case SVM_EXIT_RDPMC:
-		if (!ghcb_rcx_is_valid(ghcb))
+		if (!kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_EXIT_CPUID:
-		if (!ghcb_rax_is_valid(ghcb) ||
-		    !ghcb_rcx_is_valid(ghcb))
+		if (!kvm_ghcb_rax_is_valid(svm) ||
+		    !kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
 		if (ghcb_get_rax(ghcb) == 0xd)
-			if (!ghcb_xcr0_is_valid(ghcb))
+			if (!kvm_ghcb_xcr0_is_valid(svm))
 				goto vmgexit_err;
 		break;
 	case SVM_EXIT_INVD:
 		break;
 	case SVM_EXIT_IOIO:
 		if (ghcb_get_sw_exit_info_1(ghcb) & SVM_IOIO_STR_MASK) {
-			if (!ghcb_sw_scratch_is_valid(ghcb))
+			if (!kvm_ghcb_sw_scratch_is_valid(svm))
 				goto vmgexit_err;
 		} else {
 			if (!(ghcb_get_sw_exit_info_1(ghcb) & SVM_IOIO_TYPE_MASK))
-				if (!ghcb_rax_is_valid(ghcb))
+				if (!kvm_ghcb_rax_is_valid(svm))
 					goto vmgexit_err;
 		}
 		break;
 	case SVM_EXIT_MSR:
-		if (!ghcb_rcx_is_valid(ghcb))
+		if (!kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
 		if (ghcb_get_sw_exit_info_1(ghcb)) {
-			if (!ghcb_rax_is_valid(ghcb) ||
-			    !ghcb_rdx_is_valid(ghcb))
+			if (!kvm_ghcb_rax_is_valid(svm) ||
+			    !kvm_ghcb_rdx_is_valid(svm))
 				goto vmgexit_err;
 		}
 		break;
 	case SVM_EXIT_VMMCALL:
-		if (!ghcb_rax_is_valid(ghcb) ||
-		    !ghcb_cpl_is_valid(ghcb))
+		if (!kvm_ghcb_rax_is_valid(svm) ||
+		    !kvm_ghcb_cpl_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_EXIT_RDTSCP:
@@ -2514,19 +2518,19 @@ static int sev_es_validate_vmgexit(struc
 	case SVM_EXIT_WBINVD:
 		break;
 	case SVM_EXIT_MONITOR:
-		if (!ghcb_rax_is_valid(ghcb) ||
-		    !ghcb_rcx_is_valid(ghcb) ||
-		    !ghcb_rdx_is_valid(ghcb))
+		if (!kvm_ghcb_rax_is_valid(svm) ||
+		    !kvm_ghcb_rcx_is_valid(svm) ||
+		    !kvm_ghcb_rdx_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_EXIT_MWAIT:
-		if (!ghcb_rax_is_valid(ghcb) ||
-		    !ghcb_rcx_is_valid(ghcb))
+		if (!kvm_ghcb_rax_is_valid(svm) ||
+		    !kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_VMGEXIT_MMIO_READ:
 	case SVM_VMGEXIT_MMIO_WRITE:
-		if (!ghcb_sw_scratch_is_valid(ghcb))
+		if (!kvm_ghcb_sw_scratch_is_valid(svm))
 			goto vmgexit_err;
 		break;
 	case SVM_VMGEXIT_NMI_COMPLETE:
@@ -2556,9 +2560,6 @@ vmgexit_err:
 		dump_ghcb(svm);
 	}
 
-	/* Clear the valid entries fields */
-	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
-
 	ghcb_set_sw_exit_info_1(ghcb, 2);
 	ghcb_set_sw_exit_info_2(ghcb, reason);
 
@@ -2579,7 +2580,7 @@ void sev_es_unmap_ghcb(struct vcpu_svm *
 		 */
 		if (svm->sev_es.ghcb_sa_sync) {
 			kvm_write_guest(svm->vcpu.kvm,
-					ghcb_get_sw_scratch(svm->sev_es.ghcb),
+					svm->sev_es.sw_scratch,
 					svm->sev_es.ghcb_sa,
 					svm->sev_es.ghcb_sa_len);
 			svm->sev_es.ghcb_sa_sync = false;
@@ -2630,7 +2631,7 @@ static int setup_vmgexit_scratch(struct
 	u64 scratch_gpa_beg, scratch_gpa_end;
 	void *scratch_va;
 
-	scratch_gpa_beg = ghcb_get_sw_scratch(ghcb);
+	scratch_gpa_beg = svm->sev_es.sw_scratch;
 	if (!scratch_gpa_beg) {
 		pr_err("vmgexit: scratch gpa not provided\n");
 		goto e_scratch;
@@ -2846,11 +2847,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *
 
 	exit_code = ghcb_get_sw_exit_code(ghcb);
 
+	sev_es_sync_from_ghcb(svm);
 	ret = sev_es_validate_vmgexit(svm);
 	if (ret)
 		return ret;
 
-	sev_es_sync_from_ghcb(svm);
 	ghcb_set_sw_exit_info_1(ghcb, 0);
 	ghcb_set_sw_exit_info_2(ghcb, 0);
 
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -196,10 +196,12 @@ struct vcpu_sev_es_state {
 	/* SEV-ES support */
 	struct sev_es_save_area *vmsa;
 	struct ghcb *ghcb;
+	u8 valid_bitmap[16];
 	struct kvm_host_map ghcb_map;
 	bool received_first_sipi;
 
 	/* SEV-ES scratch area support */
+	u64 sw_scratch;
 	void *ghcb_sa;
 	u32 ghcb_sa_len;
 	bool ghcb_sa_sync;
@@ -688,4 +690,28 @@ void sev_es_unmap_ghcb(struct vcpu_svm *
 void __svm_sev_es_vcpu_run(struct vcpu_svm *svm, bool spec_ctrl_intercepted);
 void __svm_vcpu_run(struct vcpu_svm *svm, bool spec_ctrl_intercepted);
 
+#define DEFINE_KVM_GHCB_ACCESSORS(field)						\
+	static __always_inline bool kvm_ghcb_##field##_is_valid(const struct vcpu_svm *svm) \
+	{									\
+		return test_bit(GHCB_BITMAP_IDX(field),				\
+				(unsigned long *)&svm->sev_es.valid_bitmap);	\
+	}									\
+										\
+	static __always_inline u64 kvm_ghcb_get_##field##_if_valid(struct vcpu_svm *svm, struct ghcb *ghcb) \
+	{									\
+		return kvm_ghcb_##field##_is_valid(svm) ? ghcb->save.field : 0;	\
+	}									\
+
+DEFINE_KVM_GHCB_ACCESSORS(cpl)
+DEFINE_KVM_GHCB_ACCESSORS(rax)
+DEFINE_KVM_GHCB_ACCESSORS(rcx)
+DEFINE_KVM_GHCB_ACCESSORS(rdx)
+DEFINE_KVM_GHCB_ACCESSORS(rbx)
+DEFINE_KVM_GHCB_ACCESSORS(rsi)
+DEFINE_KVM_GHCB_ACCESSORS(sw_exit_code)
+DEFINE_KVM_GHCB_ACCESSORS(sw_exit_info_1)
+DEFINE_KVM_GHCB_ACCESSORS(sw_exit_info_2)
+DEFINE_KVM_GHCB_ACCESSORS(sw_scratch)
+DEFINE_KVM_GHCB_ACCESSORS(xcr0)
+
 #endif


