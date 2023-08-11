Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F8C7792FA
	for <lists+stable@lfdr.de>; Fri, 11 Aug 2023 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHKPZM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 11 Aug 2023 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjHKPZL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 11 Aug 2023 11:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0441B30CB
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 08:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBDD67518
        for <stable@vger.kernel.org>; Fri, 11 Aug 2023 15:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEE8C433C9;
        Fri, 11 Aug 2023 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691767510;
        bh=dKBH+5v9yXkAIb+sjf4mZp8ar4Gys9SAwHV8pPHz2z8=;
        h=Subject:To:Cc:From:Date:From;
        b=BuV6/8eqIIb7XuqUvEeE7NKyOtQ0yycDoZ3mfVdwXf+wilHtjH/5iOULV3zIlXUyM
         VqZSkbUcjvzHuy3xwIb3EbZT6ay+oMHNOCvyAI9ZLmjabL8i4EFrG3Udl1CbDG6PBS
         3LcX5e+S4RJi3wunGkoW/Ur4d6BokOx8OfRjTe0E=
Subject: FAILED: patch "[PATCH] KVM: SEV: only access GHCB fields once" failed to apply to 5.15-stable tree
To:     pbonzini@redhat.com, theflow@google.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 11 Aug 2023 17:25:07 +0200
Message-ID: <2023081107-secluding-shed-defa@gregkh>
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
git cherry-pick -x 7588dbcebcbf0193ab5b76987396d0254270b04a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081107-secluding-shed-defa@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7588dbcebcbf ("KVM: SEV: only access GHCB fields once")
4e15a0ddc3ff ("KVM: SEV: snapshot the GHCB before accessing it")
aa9f58415a8e ("KVM: SVM: Exit to userspace on ENOMEM/EFAULT GHCB errors")
ad5b353240c8 ("KVM: SVM: Do not terminate SEV-ES guests on GHCB validation failure")
a655276a5949 ("KVM: SEV: Fall back to vmalloc for SEV-ES scratch area if necessary")
75236f5f2299 ("KVM: SEV: Return appropriate error codes if SEV-ES scratch setup fails")
1f05833193d8 ("Merge branch 'kvm-sev-move-context' into kvm-master")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7588dbcebcbf0193ab5b76987396d0254270b04a Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Aug 2023 12:56:36 -0400
Subject: [PATCH] KVM: SEV: only access GHCB fields once

A KVM guest using SEV-ES or SEV-SNP with multiple vCPUs can trigger
a double fetch race condition vulnerability and invoke the VMGEXIT
handler recursively.

sev_handle_vmgexit() maps the GHCB page using kvm_vcpu_map() and then
fetches the exit code using ghcb_get_sw_exit_code().  Soon after,
sev_es_validate_vmgexit() fetches the exit code again. Since the GHCB
page is shared with the guest, the guest is able to quickly swap the
values with another vCPU and hence bypass the validation. One vmexit code
that can be rejected by sev_es_validate_vmgexit() is SVM_EXIT_VMGEXIT;
if sev_handle_vmgexit() observes it in the second fetch, the call
to svm_invoke_exit_handler() will invoke sev_handle_vmgexit() again
recursively.

To avoid the race, always fetch the GHCB data from the places where
sev_es_sync_from_ghcb stores it.

Exploiting recursions on linux kernel has been proven feasible
in the past, but the impact is mitigated by stack guard pages
(CONFIG_VMAP_STACK).  Still, if an attacker manages to call the handler
multiple times, they can theoretically trigger a stack overflow and
cause a denial-of-service, or potentially guest-to-host escape in kernel
configurations without stack guard pages.

Note that winning the race reliably in every iteration is very tricky
due to the very tight window of the fetches; depending on the compiler
settings, they are often consecutive because of optimization and inlining.

Tested by booting an SEV-ES RHEL9 guest.

Fixes: CVE-2023-4155
Fixes: 291bd20d5d88 ("KVM: SVM: Add initial support for a VMGEXIT VMEXIT")
Cc: stable@vger.kernel.org
Reported-by: Andy Nguyen <theflow@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index e898f0b2b0ba..ca4ba5fe9a01 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2445,9 +2445,15 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
 	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
 }
 
+static u64 kvm_ghcb_get_sw_exit_code(struct vmcb_control_area *control)
+{
+	return (((u64)control->exit_code_hi) << 32) | control->exit_code;
+}
+
 static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 {
-	struct kvm_vcpu *vcpu;
+	struct vmcb_control_area *control = &svm->vmcb->control;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct ghcb *ghcb;
 	u64 exit_code;
 	u64 reason;
@@ -2458,7 +2464,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	 * Retrieve the exit code now even though it may not be marked valid
 	 * as it could help with debugging.
 	 */
-	exit_code = ghcb_get_sw_exit_code(ghcb);
+	exit_code = kvm_ghcb_get_sw_exit_code(control);
 
 	/* Only GHCB Usage code 0 is supported */
 	if (ghcb->ghcb_usage) {
@@ -2473,7 +2479,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	    !kvm_ghcb_sw_exit_info_2_is_valid(svm))
 		goto vmgexit_err;
 
-	switch (ghcb_get_sw_exit_code(ghcb)) {
+	switch (exit_code) {
 	case SVM_EXIT_READ_DR7:
 		break;
 	case SVM_EXIT_WRITE_DR7:
@@ -2490,18 +2496,18 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 		if (!kvm_ghcb_rax_is_valid(svm) ||
 		    !kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
-		if (ghcb_get_rax(ghcb) == 0xd)
+		if (vcpu->arch.regs[VCPU_REGS_RAX] == 0xd)
 			if (!kvm_ghcb_xcr0_is_valid(svm))
 				goto vmgexit_err;
 		break;
 	case SVM_EXIT_INVD:
 		break;
 	case SVM_EXIT_IOIO:
-		if (ghcb_get_sw_exit_info_1(ghcb) & SVM_IOIO_STR_MASK) {
+		if (control->exit_info_1 & SVM_IOIO_STR_MASK) {
 			if (!kvm_ghcb_sw_scratch_is_valid(svm))
 				goto vmgexit_err;
 		} else {
-			if (!(ghcb_get_sw_exit_info_1(ghcb) & SVM_IOIO_TYPE_MASK))
+			if (!(control->exit_info_1 & SVM_IOIO_TYPE_MASK))
 				if (!kvm_ghcb_rax_is_valid(svm))
 					goto vmgexit_err;
 		}
@@ -2509,7 +2515,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	case SVM_EXIT_MSR:
 		if (!kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
-		if (ghcb_get_sw_exit_info_1(ghcb)) {
+		if (control->exit_info_1) {
 			if (!kvm_ghcb_rax_is_valid(svm) ||
 			    !kvm_ghcb_rdx_is_valid(svm))
 				goto vmgexit_err;
@@ -2553,8 +2559,6 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	return 0;
 
 vmgexit_err:
-	vcpu = &svm->vcpu;
-
 	if (reason == GHCB_ERR_INVALID_USAGE) {
 		vcpu_unimpl(vcpu, "vmgexit: ghcb usage %#x is not valid\n",
 			    ghcb->ghcb_usage);
@@ -2852,8 +2856,6 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 
 	trace_kvm_vmgexit_enter(vcpu->vcpu_id, ghcb);
 
-	exit_code = ghcb_get_sw_exit_code(ghcb);
-
 	sev_es_sync_from_ghcb(svm);
 	ret = sev_es_validate_vmgexit(svm);
 	if (ret)
@@ -2862,6 +2864,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 	ghcb_set_sw_exit_info_1(ghcb, 0);
 	ghcb_set_sw_exit_info_2(ghcb, 0);
 
+	exit_code = kvm_ghcb_get_sw_exit_code(control);
 	switch (exit_code) {
 	case SVM_VMGEXIT_MMIO_READ:
 		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);

