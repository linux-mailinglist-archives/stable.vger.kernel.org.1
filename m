Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DE47ECE89
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjKOTnr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbjKOTnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5D01B6
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC8EC433C7;
        Wed, 15 Nov 2023 19:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077422;
        bh=02uq4pMhhX2h2ce0zvawW2VSJUfrh9mjiM6rkOKtZBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEDcpO6xcF/dzGkgmPPU5nKpXh2tmGToBXjGb9B2ITWU2urlKzMex3o6A3g7BBXj4
         dk8/PCBJr/81pS0NJs5k56EE7Ntt5FUwIKyzhMFu+UB+/5JqxxbyCq4ZVUUnhf+gne
         yUTHbQLzWyUGSaJS0GmrMUgifA8heEA4ICz+APLw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ross Burton <ross.burton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 268/603] clocksource/drivers/arm_arch_timer: limit XGene-1 workaround
Date:   Wed, 15 Nov 2023 14:13:33 -0500
Message-ID: <20231115191631.869627659@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 851354cbd12bb9500909733c3d4054306f61df87 ]

The AppliedMicro XGene-1 CPU has an erratum where the timer condition
would only consider TVAL, not CVAL. We currently apply a workaround when
seeing the PartNum field of MIDR_EL1 being 0x000, under the assumption
that this would match only the XGene-1 CPU model.
However even the Ampere eMAG (aka XGene-3) uses that same part number, and
only differs in the "Variant" and "Revision" fields: XGene-1's MIDR is
0x500f0000, our eMAG reports 0x503f0002. Experiments show the latter
doesn't show the faulty behaviour.

Increase the specificity of the check to only consider partnum 0x000 and
variant 0x00, to exclude the Ampere eMAG.

Fixes: 012f18850452 ("clocksource/drivers/arm_arch_timer: Work around broken CVAL implementations")
Reported-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20231016153127.116101-1-andre.przywara@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/cputype.h     | 3 ++-
 arch/arm64/kvm/guest.c               | 2 +-
 drivers/clocksource/arm_arch_timer.c | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 74d00feb62f03..7c7493cb571f9 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -86,7 +86,8 @@
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
 
-#define APM_CPU_PART_POTENZA		0x000
+#define APM_CPU_PART_XGENE		0x000
+#define APM_CPU_VAR_POTENZA		0x00
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 #define CAVIUM_CPU_PART_THUNDERX_81XX	0x0A2
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 95f6945c44325..a1710e5fa72b6 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -874,7 +874,7 @@ u32 __attribute_const__ kvm_target_cpu(void)
 		break;
 	case ARM_CPU_IMP_APM:
 		switch (part_number) {
-		case APM_CPU_PART_POTENZA:
+		case APM_CPU_PART_XGENE:
 			return KVM_ARM_TARGET_XGENE_POTENZA;
 		}
 		break;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 7dd2c615bce23..071b04f1ee730 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -836,8 +836,9 @@ static u64 __arch_timer_check_delta(void)
 		 * Note that TVAL is signed, thus has only 31 of its
 		 * 32 bits to express magnitude.
 		 */
-		MIDR_ALL_VERSIONS(MIDR_CPU_MODEL(ARM_CPU_IMP_APM,
-						 APM_CPU_PART_POTENZA)),
+		MIDR_REV_RANGE(MIDR_CPU_MODEL(ARM_CPU_IMP_APM,
+					      APM_CPU_PART_XGENE),
+			       APM_CPU_VAR_POTENZA, 0x0, 0xf),
 		{},
 	};
 
-- 
2.42.0



