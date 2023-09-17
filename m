Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9FA7A3949
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbjIQTrS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjIQTrH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:47:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763FC6
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:47:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADA5C433C7;
        Sun, 17 Sep 2023 19:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980022;
        bh=mrPJXpCKk63myEWwJO5ZMdUYeu+afRGdVubDOOyzklM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpygmjBvosZFolcWcm253VH47qZm7pNk6ptjRn+x0bQ7+mhlTlPrtP5WOy3IFbsUc
         QH0WK0OiVeWJrcNDr+nMNaIykpHf0I8L+xVglL+e6mOjEckp3/Zy8xeeJirpFRQCmn
         0B2aMaIQsGWrVtAci1kPaT81TYVueGy1r3j0CKpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 075/285] KVM: SVM: Dont defer NMI unblocking until next exit for SEV-ES guests
Date:   Sun, 17 Sep 2023 21:11:15 +0200
Message-ID: <20230917191054.318636011@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 389fbbec261b2842fd0e34b26a2b288b122cc406 ]

Immediately mark NMIs as unmasked in response to #VMGEXIT(NMI complete)
instead of setting awaiting_iret_completion and waiting until the *next*
VM-Exit to unmask NMIs.  The whole point of "NMI complete" is that the
guest is responsible for telling the hypervisor when it's safe to inject
an NMI, i.e. there's no need to wait.  And because there's no IRET to
single-step, the next VM-Exit could be a long time coming, i.e. KVM could
incorrectly hold an NMI pending for far longer than what is required and
expected.

Opportunistically fix a stale reference to HF_IRET_MASK.

Fixes: 916b54a7688b ("KVM: x86: Move HF_NMI_MASK and HF_IRET_MASK into "struct vcpu_svm"")
Fixes: 4444dfe4050b ("KVM: SVM: Add NMI support for an SEV-ES guest")
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20230615063757.3039121-9-aik@amd.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/svm/sev.c |  5 ++++-
 arch/x86/kvm/svm/svm.c | 10 +++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index d3aec1f2cad20..42630f5b11875 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2881,7 +2881,10 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 					    svm->sev_es.ghcb_sa);
 		break;
 	case SVM_VMGEXIT_NMI_COMPLETE:
-		ret = svm_invoke_exit_handler(vcpu, SVM_EXIT_IRET);
+		++vcpu->stat.nmi_window_exits;
+		svm->nmi_masked = false;
+		kvm_make_request(KVM_REQ_EVENT, vcpu);
+		ret = 1;
 		break;
 	case SVM_VMGEXIT_AP_HLT_LOOP:
 		ret = kvm_emulate_ap_reset_hold(vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d4bfdc607fe7f..dfb8a3f504322 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2510,12 +2510,13 @@ static int iret_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	WARN_ON_ONCE(sev_es_guest(vcpu->kvm));
+
 	++vcpu->stat.nmi_window_exits;
 	svm->awaiting_iret_completion = true;
 
 	svm_clr_iret_intercept(svm);
-	if (!sev_es_guest(vcpu->kvm))
-		svm->nmi_iret_rip = kvm_rip_read(vcpu);
+	svm->nmi_iret_rip = kvm_rip_read(vcpu);
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	return 1;
@@ -3918,12 +3919,11 @@ static void svm_complete_interrupts(struct kvm_vcpu *vcpu)
 	svm->soft_int_injected = false;
 
 	/*
-	 * If we've made progress since setting HF_IRET_MASK, we've
+	 * If we've made progress since setting awaiting_iret_completion, we've
 	 * executed an IRET and can allow NMI injection.
 	 */
 	if (svm->awaiting_iret_completion &&
-	    (sev_es_guest(vcpu->kvm) ||
-	     kvm_rip_read(vcpu) != svm->nmi_iret_rip)) {
+	    kvm_rip_read(vcpu) != svm->nmi_iret_rip) {
 		svm->awaiting_iret_completion = false;
 		svm->nmi_masked = false;
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
-- 
2.40.1



