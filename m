Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC673E910
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjFZSc2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjFZScM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:32:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868819AA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC07160F52
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DFBC433C0;
        Mon, 26 Jun 2023 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804310;
        bh=iDl4IWD+ybCInsU/umWV4edir9gcTmRo1vcgR1vBVI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+/IZlYpms9vTGQLssF9TyIUcAzSaMeLyymj6yxqtSgMX2TwdkjgS/gk3aCZ3LN3c
         n/oa2jXO2rJij77daWqKXY8lF90DL4TwI1YGKlreQkPujzy2odwkDxMlHPZjZCj8wU
         pkoPcf50eyuBoYlR6iwjYTeLKHbAHLIxnhOfW9tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Reiji Watanabe <reijiw@google.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 085/170] KVM: arm64: PMU: Restore the hosts PMUSERENR_EL0
Date:   Mon, 26 Jun 2023 20:10:54 +0200
Message-ID: <20230626180804.383788606@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Reiji Watanabe <reijiw@google.com>

[ Upstream commit 8681f71759010503892f9e3ddb05f65c0f21b690 ]

Restore the host's PMUSERENR_EL0 value instead of clearing it,
before returning back to userspace, as the host's EL0 might have
a direct access to PMU registers (some bits of PMUSERENR_EL0 for
might not be zero for the host EL0).

Fixes: 83a7a4d643d3 ("arm64: perf: Enable PMU counter userspace access for perf event")
Signed-off-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230603025035.3781797-2-reijiw@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/hyp/include/hyp/switch.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 2208d79b18dea..081aca8f432ef 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -81,7 +81,12 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
 	 * EL1 instead of being trapped to EL2.
 	 */
 	if (kvm_arm_support_pmu_v3()) {
+		struct kvm_cpu_context *hctxt;
+
 		write_sysreg(0, pmselr_el0);
+
+		hctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
+		ctxt_sys_reg(hctxt, PMUSERENR_EL0) = read_sysreg(pmuserenr_el0);
 		write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
 	}
 
@@ -105,8 +110,12 @@ static inline void __deactivate_traps_common(struct kvm_vcpu *vcpu)
 	write_sysreg(vcpu->arch.mdcr_el2_host, mdcr_el2);
 
 	write_sysreg(0, hstr_el2);
-	if (kvm_arm_support_pmu_v3())
-		write_sysreg(0, pmuserenr_el0);
+	if (kvm_arm_support_pmu_v3()) {
+		struct kvm_cpu_context *hctxt;
+
+		hctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
+		write_sysreg(ctxt_sys_reg(hctxt, PMUSERENR_EL0), pmuserenr_el0);
+	}
 
 	if (cpus_have_final_cap(ARM64_SME)) {
 		sysreg_clear_set_s(SYS_HFGRTR_EL2, 0,
-- 
2.39.2



