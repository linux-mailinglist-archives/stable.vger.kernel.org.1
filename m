Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCC57D14FE
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 19:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjJTRkW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjJTRkW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 13:40:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8079FA
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 10:40:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECB4C433C8;
        Fri, 20 Oct 2023 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697823620;
        bh=COueDFjuhf805Nt20Mt5UNUK6r2WKZuTfnrVSH2C1X0=;
        h=Subject:To:Cc:From:Date:From;
        b=0qpuwG/2+eyjmGPU7w+eGrecHHRH5kipPT+Oo4D1UsFOG9ZQEMPMSC5TevvR+mWyn
         ccUtcoKXK4ExzpmRmWNIOPOTRrB2Tp/bRBDkbQZdKWJY/h46HMTk1uCkuLVDka36Jj
         7CNjgMaJGiyJorOPB2kPabBcwcMguk+IH8OyJ5v0=
Subject: FAILED: patch "[PATCH] x86: KVM: SVM: always update the x2avic msr interception" failed to apply to 6.1-stable tree
To:     mlevitsk@redhat.com, pbonzini@redhat.com, seanjc@google.com,
        suravee.suthikulpanit@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 20 Oct 2023 19:40:17 +0200
Message-ID: <2023102017-human-marine-7125@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b65235f6e102354ccafda601eaa1c5bef5284d21
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102017-human-marine-7125@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b65235f6e102354ccafda601eaa1c5bef5284d21 Mon Sep 17 00:00:00 2001
From: Maxim Levitsky <mlevitsk@redhat.com>
Date: Thu, 28 Sep 2023 20:33:51 +0300
Subject: [PATCH] x86: KVM: SVM: always update the x2avic msr interception

The following problem exists since x2avic was enabled in the KVM:

svm_set_x2apic_msr_interception is called to enable the interception of
the x2apic msrs.

In particular it is called at the moment the guest resets its apic.

Assuming that the guest's apic was in x2apic mode, the reset will bring
it back to the xapic mode.

The svm_set_x2apic_msr_interception however has an erroneous check for
'!apic_x2apic_mode()' which prevents it from doing anything in this case.

As a result of this, all x2apic msrs are left unintercepted, and that
exposes the bare metal x2apic (if enabled) to the guest.
Oops.

Remove the erroneous '!apic_x2apic_mode()' check to fix that.

This fixes CVE-2023-5090

Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
Cc: stable@vger.kernel.org
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20230928173354.217464-2-mlevitsk@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9507df93f410..acdd0b89e471 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -913,8 +913,7 @@ void svm_set_x2apic_msr_interception(struct vcpu_svm *svm, bool intercept)
 	if (intercept == svm->x2avic_msrs_intercepted)
 		return;
 
-	if (!x2avic_enabled ||
-	    !apic_x2apic_mode(svm->vcpu.arch.apic))
+	if (!x2avic_enabled)
 		return;
 
 	for (i = 0; i < MAX_DIRECT_ACCESS_MSRS; i++) {

