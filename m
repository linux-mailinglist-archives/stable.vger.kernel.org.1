Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40B87B88D4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbjJDSUA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjJDST7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3B5A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5803C433C7;
        Wed,  4 Oct 2023 18:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443594;
        bh=Pf1kqytYFh5P25ymBosn/BfP5/m338aOLln805qBOmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmO8P7nAog9QQYPLts9YfLgyIy+DuhV5V8Gxar6t0qrmELcZPYqSYHKQ48PSB/7gR
         1tvPhXqmKIMkpzBrpCdPbBVNwVZxG3hA/VPKru/mg2C4PBzrhpO3FKwCRjHjYZhXGY
         AnBfXP1f6IXADFVN030F7wF2vIt81f7mJau6svcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.1 211/259] KVM: SVM: INTERCEPT_RDTSCP is never intercepted anyway
Date:   Wed,  4 Oct 2023 19:56:24 +0200
Message-ID: <20231004175226.989451161@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2990,11 +2990,8 @@ static void sev_es_init_vmcb(struct vcpu
 
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


