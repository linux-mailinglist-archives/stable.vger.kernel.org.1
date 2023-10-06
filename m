Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F667BBC22
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjJFPuc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjJFPuc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 11:50:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 691C0B9
        for <stable@vger.kernel.org>; Fri,  6 Oct 2023 08:50:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67650C15;
        Fri,  6 Oct 2023 08:51:10 -0700 (PDT)
Received: from e126864.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F78A3F5A1;
        Fri,  6 Oct 2023 08:50:30 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1.y] arm64: cpufeature: Fix CLRBHB and BC detection
Date:   Fri,  6 Oct 2023 16:49:53 +0100
Message-Id: <20231006154953.3853617-1-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023100424-cheer-freeness-471f@gregkh>
References: <2023100424-cheer-freeness-471f@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 479965a2b7ec481737df0cadf553331063b9c343 ]

ClearBHB support is indicated by the CLRBHB field in ID_AA64ISAR2_EL1.
Following some refactoring the kernel incorrectly checks the BC field
instead. Fix the detection to use the right field.

(Note: The original ClearBHB support had it as FTR_HIGHER_SAFE, but this
patch uses FTR_LOWER_SAFE, which seems more correct.)

Also fix the detection of BC (hinted conditional branches) to use
FTR_LOWER_SAFE, so that it is not reported on mismatched systems.

[ Backport to 6.1: minor adjustments to account for new features missing
  in 6.1 (BC FTR_VISIBLE -> FTR_HIDDEN; sysreg UnsignedEnum -> Enum;
  sysreg RPRFM/CSSC fields missing) ]

Fixes: 356137e68a9f ("arm64/sysreg: Make BHB clear feature defines match the architecture")
Fixes: 8fcc8285c0e3 ("arm64/sysreg: Convert ID_AA64ISAR2_EL1 to automatic generation")
Cc: stable@vger.kernel.org
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20230912133429.2606875-1-kristina.martsenko@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h | 2 +-
 arch/arm64/kernel/cpufeature.c      | 3 ++-
 arch/arm64/tools/sysreg             | 6 +++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f73f11b55042..37b71553d3dd 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -670,7 +670,7 @@ static inline bool supports_clearbhb(int scope)
 		isar2 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
 
 	return cpuid_feature_extract_unsigned_field(isar2,
-						    ID_AA64ISAR2_EL1_BC_SHIFT);
+						    ID_AA64ISAR2_EL1_CLRBHB_SHIFT);
 }
 
 const struct cpumask *system_32bit_el0_cpumask(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b3eb53847c96..770a31c6ed81 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -212,7 +212,8 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_EL1_BC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CLRBHB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_BC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
 		       FTR_STRICT, FTR_EXACT, ID_AA64ISAR2_EL1_APA3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 384757a7eda9..11c3f7a7cec7 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -484,7 +484,11 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR2_EL1	3	0	0	6	2
-Res0	63:28
+Res0	63:32
+Enum	31:28	CLRBHB
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 Enum	27:24	PAC_frac
 	0b0000	NI
 	0b0001	IMP
-- 
2.25.1

