Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6906C7B8A61
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243808AbjJDSe7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244411AbjJDSe7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:34:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402D9AB
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:34:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86176C433C8;
        Wed,  4 Oct 2023 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444495;
        bh=wEDAUdfXAxQ4wP4qSZHxi9IAacO9he0B63JgHHAEvoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SIfVJ8sJuFNssEZ6A617tEBOHRZEOS85mH2VtRsdfXQuMt/jA45xSUSTWhT5EM2wI
         kiTK/QHHE4HSdFqFbMl3Qsn5MhkJBwsEAag1JK8wSLt4SvdcZ2Ep5wNKCMXbPcNacC
         QURUEl1SMkuapUX5mljM6ftSlj+G+fbI1q7LAqgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.5 243/321] KVM: SVM: INTERCEPT_RDTSCP is never intercepted anyway
Date:   Wed,  4 Oct 2023 19:56:28 +0200
Message-ID: <20231004175240.508281098@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

commit e8d93d5d93f85949e7299be289c6e7e1154b2f78 upstream.

svm_recalc_instruction_intercepts() is always called at least once
before the vCPU is started, so the setting or clearing of the RDTSCP
intercept can be dropped from the TSC_AUX virtualization support.

Extracted from a patch by Tom Lendacky.

Cc: stable@vger.kernel.org
Fixes: 296d5a17e793 ("KVM: SEV-ES: Use V_TSC_AUX if available instead of RDTSC/MSR_TSC_AUX intercepts")
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm/sev.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2994,11 +2994,8 @@ static void sev_es_init_vmcb(struct vcpu
 
 	if (boot_cpu_has(X86_FEATURE_V_TSC_AUX) &&
 	    (guest_cpuid_has(&svm->vcpu, X86_FEATURE_RDTSCP) ||
-	     guest_cpuid_has(&svm->vcpu, X86_FEATURE_RDPID))) {
+	     guest_cpuid_has(&svm->vcpu, X86_FEATURE_RDPID)))
 		set_msr_interception(vcpu, svm->msrpm, MSR_TSC_AUX, 1, 1);
-		if (guest_cpuid_has(&svm->vcpu, X86_FEATURE_RDTSCP))
-			svm_clr_intercept(svm, INTERCEPT_RDTSCP);
-	}
 }
 
 void sev_init_vmcb(struct vcpu_svm *svm)


