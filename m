Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0F7792F7
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbjHKPYn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbjHKPYm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 11:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFADFF5
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:24:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D33167512
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 15:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF2DC433C7;
        Fri, 11 Aug 2023 15:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691767480;
        bh=7NCiZXoh+iIMMeTnVoP6gdWGV1gIVDNIoq0B2tdDD8U=;
        h=Subject:To:Cc:From:Date:From;
        b=vdNc9lrDUDKeVTUYiooo7BgYfpMIRS7m8rI0V3SbHwNtXlGEf3ZjWXItjs6RCCOf9
         kp0PBq8SqwvI8JWAj3Hd3HBgsJKAKkWqyRa/RPOq8+oY4wgj+wpNXFVv0RO232Kpnl
         r2PX9LL9KuwvgljQR2NhIM2AYxoHj6W2O/xNQeP4=
Subject: FAILED: patch "[PATCH] KVM: SEV: snapshot the GHCB before accessing it" failed to apply to 5.15-stable tree
To:     pbonzini@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 11 Aug 2023 17:24:37 +0200
Message-ID: <2023081137-tabby-commodity-6599@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4e15a0ddc3ff40e8ea84032213976ecf774d7f77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081137-tabby-commodity-6599@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

4e15a0ddc3ff ("KVM: SEV: snapshot the GHCB before accessing it")
aa9f58415a8e ("KVM: SVM: Exit to userspace on ENOMEM/EFAULT GHCB errors")
ad5b353240c8 ("KVM: SVM: Do not terminate SEV-ES guests on GHCB validation failure")
a655276a5949 ("KVM: SEV: Fall back to vmalloc for SEV-ES scratch area if necessary")
75236f5f2299 ("KVM: SEV: Return appropriate error codes if SEV-ES scratch setup fails")
1f05833193d8 ("Merge branch 'kvm-sev-move-context' into kvm-master")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4e15a0ddc3ff40e8ea84032213976ecf774d7f77 Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Aug 2023 12:42:45 -0400
Subject: [PATCH] KVM: SEV: snapshot the GHCB before accessing it

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

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 07756b7348ae..e898f0b2b0ba 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2417,15 +2417,18 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
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
@@ -2436,6 +2439,7 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
 	control->exit_code_hi = upper_32_bits(exit_code);
 	control->exit_info_1 = ghcb_get_sw_exit_info_1(ghcb);
 	control->exit_info_2 = ghcb_get_sw_exit_info_2(ghcb);
+	svm->sev_es.sw_scratch = kvm_ghcb_get_sw_scratch_if_valid(svm, ghcb);
 
 	/* Clear the valid entries fields */
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
@@ -2464,56 +2468,56 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 
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
@@ -2521,19 +2525,19 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
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
@@ -2563,9 +2567,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		dump_ghcb(svm);
 	}
 
-	/* Clear the valid entries fields */
-	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
-
 	ghcb_set_sw_exit_info_1(ghcb, 2);
 	ghcb_set_sw_exit_info_2(ghcb, reason);
 
@@ -2586,7 +2587,7 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 		 */
 		if (svm->sev_es.ghcb_sa_sync) {
 			kvm_write_guest(svm->vcpu.kvm,
-					ghcb_get_sw_scratch(svm->sev_es.ghcb),
+					svm->sev_es.sw_scratch,
 					svm->sev_es.ghcb_sa,
 					svm->sev_es.ghcb_sa_len);
 			svm->sev_es.ghcb_sa_sync = false;
@@ -2637,7 +2638,7 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 	u64 scratch_gpa_beg, scratch_gpa_end;
 	void *scratch_va;
 
-	scratch_gpa_beg = ghcb_get_sw_scratch(ghcb);
+	scratch_gpa_beg = svm->sev_es.sw_scratch;
 	if (!scratch_gpa_beg) {
 		pr_err("vmgexit: scratch gpa not provided\n");
 		goto e_scratch;
@@ -2853,11 +2854,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 
 	exit_code = ghcb_get_sw_exit_code(ghcb);
 
+	sev_es_sync_from_ghcb(svm);
 	ret = sev_es_validate_vmgexit(svm);
 	if (ret)
 		return ret;
 
-	sev_es_sync_from_ghcb(svm);
 	ghcb_set_sw_exit_info_1(ghcb, 0);
 	ghcb_set_sw_exit_info_2(ghcb, 0);
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 18af7e712a5a..8239c8de45ac 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -190,10 +190,12 @@ struct vcpu_sev_es_state {
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
@@ -744,4 +746,28 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm);
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

