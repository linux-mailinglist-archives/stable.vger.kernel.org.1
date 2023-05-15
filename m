Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29CA7035E6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbjEOREi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbjEOREQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:04:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873C28A4B
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2543362A8C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C62C4339B;
        Mon, 15 May 2023 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170098;
        bh=0vKsgebch6DEWlrLqP/YWvpz1W9QeBIdoiMAiDGI8yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppTbNTDMepMRWVCPlNPI9NNeWxRDZGAXOMpxSRIKKLZfDLpEDLFn4Sje6rP8C5UqL
         T32/V6L903L5YUytD7gA/58WRYAqSncDmmztzFx8h8uAk2X+5uTtmN/EbPcYUDkA+5
         ba8wPo1je8DHOGI+B0KYof0J9g4OXad6dCbfx5/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 006/239] perf/x86/core: Zero @lbr instead of returning -1 in x86_perf_get_lbr() stub
Date:   Mon, 15 May 2023 18:24:29 +0200
Message-Id: <20230515161721.764288785@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 0b9ca98b722969660ad98b39f766a561ccb39f5f ]

Drop the return value from x86_perf_get_lbr() and have the stub zero out
the @lbr structure instead of returning -1 to indicate "no LBR support".
KVM doesn't actually check the return value, and instead subtly relies on
zeroing the number of LBRs in intel_pmu_init().

Formalize "nr=0 means unsupported" so that KVM doesn't need to add a
pointless check on the return value to fix KVM's benign bug.

Note, the stub is necessary even though KVM x86 selects PERF_EVENTS and
the caller exists only when CONFIG_KVM_INTEL=y.  Despite the name,
KVM_INTEL doesn't strictly require CPU_SUP_INTEL, it can be built with
any of INTEL || CENTAUR || ZHAOXIN CPUs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-Id: <20221006000314.73240-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Stable-dep-of: 098f4c061ea1 ("KVM: x86/pmu: Disallow legacy LBRs if architectural LBRs are available")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/lbr.c       | 6 +-----
 arch/x86/include/asm/perf_event.h | 6 +++---
 arch/x86/kvm/vmx/capabilities.h   | 3 ++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8259d725054d0..4dbde69c423ba 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1603,10 +1603,8 @@ void __init intel_pmu_arch_lbr_init(void)
  * x86_perf_get_lbr - get the LBR records information
  *
  * @lbr: the caller's memory to store the LBR records information
- *
- * Returns: 0 indicates the LBR info has been successfully obtained
  */
-int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
 	int lbr_fmt = x86_pmu.intel_cap.lbr_format;
 
@@ -1614,8 +1612,6 @@ int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 	lbr->from = x86_pmu.lbr_from;
 	lbr->to = x86_pmu.lbr_to;
 	lbr->info = (lbr_fmt == LBR_FORMAT_INFO) ? x86_pmu.lbr_info : 0;
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 9ac46dbe57d48..5d0f6891ae611 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -543,12 +543,12 @@ static inline void perf_check_microcode(void) { }
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
-extern int x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
+extern void x86_perf_get_lbr(struct x86_pmu_lbr *lbr);
 #else
 struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data);
-static inline int x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
+static inline void x86_perf_get_lbr(struct x86_pmu_lbr *lbr)
 {
-	return -1;
+	memset(lbr, 0, sizeof(*lbr));
 }
 #endif
 
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 07254314f3dd5..479124e49bbda 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -407,7 +407,8 @@ static inline u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	if (x86_perf_get_lbr(&lbr) >= 0 && lbr.nr)
+	x86_perf_get_lbr(&lbr);
+	if (lbr.nr)
 		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 
 	if (vmx_pebs_supported()) {
-- 
2.39.2



