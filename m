Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3C77AC81
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjHMVdy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjHMVdy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED83010DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:33:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFEE62C5C
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:33:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A6EC433C8;
        Sun, 13 Aug 2023 21:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962435;
        bh=G/N48ezMuk7AoFba76u6qqt1mFMV+xPjHG1b8leiEPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWKAYpzjNR3SsdGE1Gydst/pyV6DdRNdnwQATQ32gsVRl4FjfCKqmlSGKZcQxUGuc
         a5snxLvoBzBLuyRmjatPmlSiFJGgyBkiLVb9HVK1SArZ0Y8B9Qatkagffqoxq83J9C
         rL37ng7fzWAjO4D9od8B1J5M7UHanOI+HFQWIif8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andy Nguyen <theflow@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.1 008/149] KVM: SEV: only access GHCB fields once
Date:   Sun, 13 Aug 2023 23:17:33 +0200
Message-ID: <20230813211719.013389953@linuxfoundation.org>
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

commit 7588dbcebcbf0193ab5b76987396d0254270b04a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2438,9 +2438,15 @@ static void sev_es_sync_from_ghcb(struct
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
@@ -2451,7 +2457,7 @@ static int sev_es_validate_vmgexit(struc
 	 * Retrieve the exit code now even though it may not be marked valid
 	 * as it could help with debugging.
 	 */
-	exit_code = ghcb_get_sw_exit_code(ghcb);
+	exit_code = kvm_ghcb_get_sw_exit_code(control);
 
 	/* Only GHCB Usage code 0 is supported */
 	if (ghcb->ghcb_usage) {
@@ -2466,7 +2472,7 @@ static int sev_es_validate_vmgexit(struc
 	    !kvm_ghcb_sw_exit_info_2_is_valid(svm))
 		goto vmgexit_err;
 
-	switch (ghcb_get_sw_exit_code(ghcb)) {
+	switch (exit_code) {
 	case SVM_EXIT_READ_DR7:
 		break;
 	case SVM_EXIT_WRITE_DR7:
@@ -2483,18 +2489,18 @@ static int sev_es_validate_vmgexit(struc
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
@@ -2502,7 +2508,7 @@ static int sev_es_validate_vmgexit(struc
 	case SVM_EXIT_MSR:
 		if (!kvm_ghcb_rcx_is_valid(svm))
 			goto vmgexit_err;
-		if (ghcb_get_sw_exit_info_1(ghcb)) {
+		if (control->exit_info_1) {
 			if (!kvm_ghcb_rax_is_valid(svm) ||
 			    !kvm_ghcb_rdx_is_valid(svm))
 				goto vmgexit_err;
@@ -2546,8 +2552,6 @@ static int sev_es_validate_vmgexit(struc
 	return 0;
 
 vmgexit_err:
-	vcpu = &svm->vcpu;
-
 	if (reason == GHCB_ERR_INVALID_USAGE) {
 		vcpu_unimpl(vcpu, "vmgexit: ghcb usage %#x is not valid\n",
 			    ghcb->ghcb_usage);
@@ -2845,8 +2849,6 @@ int sev_handle_vmgexit(struct kvm_vcpu *
 
 	trace_kvm_vmgexit_enter(vcpu->vcpu_id, ghcb);
 
-	exit_code = ghcb_get_sw_exit_code(ghcb);
-
 	sev_es_sync_from_ghcb(svm);
 	ret = sev_es_validate_vmgexit(svm);
 	if (ret)
@@ -2855,6 +2857,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *
 	ghcb_set_sw_exit_info_1(ghcb, 0);
 	ghcb_set_sw_exit_info_2(ghcb, 0);
 
+	exit_code = kvm_ghcb_get_sw_exit_code(control);
 	switch (exit_code) {
 	case SVM_VMGEXIT_MMIO_READ:
 		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);


