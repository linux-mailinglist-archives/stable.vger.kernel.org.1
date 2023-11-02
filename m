Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C04B7DF8C3
	for <lists+stable@lfdr.de>; Thu,  2 Nov 2023 18:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjKBRd1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 2 Nov 2023 13:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKBRd0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 2 Nov 2023 13:33:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8545B10E
        for <stable@vger.kernel.org>; Thu,  2 Nov 2023 10:33:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F87EC433C8;
        Thu,  2 Nov 2023 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698946404;
        bh=ZKiwVmmxGFrqHIavcUu30zIezcxTXncRkz5aoq4SASI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dx2Arxn6jwP9irCASOLZSA+8b8al9jmAEZNhG1b4UsFyn6dy4k1bRq2IYKL1LMOAW
         ZMtV06jlmOI5gNvfgLnZ4BYGc2Z/+vH3mWqOnZFPSs2D3zCklzrY5wMh9losCv8uWb
         Oii6YnltpdpVAzzHxqY17PXziPpq1NOrpMRosupneWFRhEoanvI/YyXcElrV9mZJAH
         NMaIIzmrL98f0f325zsfPQn57FSaahLRxW5uQAbX7UaaDjeydAA88jDwJdAq3DCNRn
         uNWJQMFfVl9SL5fZAiZYblYDGbOSpqBEbyutXxe5iulGfb+4yr4TGaKmUx5VVU4Iff
         tUzbA7gcEDOHw==
From:   SeongJae Park <sj@kernel.org>
To:     stable@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 6.1.y] x86: KVM: SVM: always update the x2avic msr interception
Date:   Thu,  2 Nov 2023 17:33:11 +0000
Message-Id: <20231102173311.128654-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102017-human-marine-7125@gregkh>
References: <2023102017-human-marine-7125@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maxim Levitsky <mlevitsk@redhat.com>

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
(cherry picked from commit b65235f6e102354ccafda601eaa1c5bef5284d21)
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 arch/x86/kvm/svm/svm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c871a6d6364c..1139d4b91b80 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -822,8 +822,7 @@ void svm_set_x2apic_msr_interception(struct vcpu_svm *svm, bool intercept)
 	if (intercept == svm->x2avic_msrs_intercepted)
 		return;
 
-	if (avic_mode != AVIC_MODE_X2 ||
-	    !apic_x2apic_mode(svm->vcpu.arch.apic))
+	if (!x2avic_enabled)
 		return;
 
 	for (i = 0; i < MAX_DIRECT_ACCESS_MSRS; i++) {
-- 
2.34.1

