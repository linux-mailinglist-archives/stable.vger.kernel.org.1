Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442636F8F58
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 08:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjEFGla (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 02:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEFGlU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 6 May 2023 02:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1E900B
        for <stable@vger.kernel.org>; Fri,  5 May 2023 23:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B49E061779
        for <stable@vger.kernel.org>; Sat,  6 May 2023 06:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133E8C433D2;
        Sat,  6 May 2023 06:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683355278;
        bh=c344TkFOAWoswMF7LizLxnzaY2NoMOSbLUdIgsZvYeU=;
        h=Subject:To:Cc:From:Date:From;
        b=DDjmRtrZra/qgwBH9iJwo53URDELpa8y2Ox4m67V0H9fA5jR6OqSOb4lHNS61Yin5
         5kQl+omcTDFFdyuohMFsGsAc/6lBpBa0T5dklEOTt6D2ZD3Nv1jIj2twlSl/FgoMJn
         oZmOy23c0FAbXByJr++nHUnqB0UCXE8nYGFG57hs=
Subject: FAILED: patch "[PATCH] KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs are" failed to apply to 6.1-stable tree
To:     seanjc@google.com, like.xu.linux@gmail.com, likexu@tencent.com,
        pbonzini@redhat.com, weijiang.yang@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:30:48 +0900
Message-ID: <2023050648-citable-spill-5eac@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 098f4c061ea10b777033b71c10bd9fd706820ee9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050648-citable-spill-5eac@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 098f4c061ea10b777033b71c10bd9fd706820ee9 Mon Sep 17 00:00:00 2001
From: Sean Christopherson <seanjc@google.com>
Date: Sat, 28 Jan 2023 00:14:27 +0000
Subject: [PATCH] KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs are
 available

Disallow enabling LBR support if the CPU supports architectural LBRs.
Traditional LBR support is absent on CPU models that have architectural
LBRs, and KVM doesn't yet support arch LBRs, i.e. KVM will pass through
non-existent MSRs if userspace enables LBRs for the guest.

Cc: stable@vger.kernel.org
Cc: Yang Weijiang <weijiang.yang@intel.com>
Cc: Like Xu <like.xu.linux@gmail.com>
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: be635e34c284 ("KVM: vmx/pmu: Expose LBR_FMT in the MSR_IA32_PERF_CAPABILITIES")
Tested-by: Like Xu <likexu@tencent.com>
Link: https://lore.kernel.org/r/20230128001427.2548858-1-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d7bf14abdba1..c18f74899f01 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7793,9 +7793,11 @@ static u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	x86_perf_get_lbr(&lbr);
-	if (lbr.nr)
-		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR)) {
+		x86_perf_get_lbr(&lbr);
+		if (lbr.nr)
+			perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	}
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;

