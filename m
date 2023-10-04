Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81867B8471
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbjJDQDj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbjJDQDj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 12:03:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997BCCE
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 09:03:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2682C433C7;
        Wed,  4 Oct 2023 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696435415;
        bh=qheLRzii5x6b0KLtbb1saFedabUXMVNbMomBlc2c67k=;
        h=Subject:To:Cc:From:Date:From;
        b=HjWoVguvdUYANTAzWFiC/0T27maPSDKbLqEXWh0/3UDocKmMMdBxBVhQC22zMptpq
         v0Pzw2ZVZuWyJM1LvfTcbm24T8bj1/flhjtJ73/thWgDigVk+Iy4PXZ3fNcgPkAiE8
         4gDrKHm5ytzmskwfgkW4s6JU5KYy88ufA/hKzAV4=
Subject: FAILED: patch "[PATCH] arm64: cpufeature: Fix CLRBHB and BC detection" failed to apply to 6.1-stable tree
To:     kristina.martsenko@arm.com, broonie@kernel.org, will@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 18:03:24 +0200
Message-ID: <2023100424-cheer-freeness-471f@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 479965a2b7ec481737df0cadf553331063b9c343
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100424-cheer-freeness-471f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 479965a2b7ec481737df0cadf553331063b9c343 Mon Sep 17 00:00:00 2001
From: Kristina Martsenko <kristina.martsenko@arm.com>
Date: Tue, 12 Sep 2023 14:34:29 +0100
Subject: [PATCH] arm64: cpufeature: Fix CLRBHB and BC detection

ClearBHB support is indicated by the CLRBHB field in ID_AA64ISAR2_EL1.
Following some refactoring the kernel incorrectly checks the BC field
instead. Fix the detection to use the right field.

(Note: The original ClearBHB support had it as FTR_HIGHER_SAFE, but this
patch uses FTR_LOWER_SAFE, which seems more correct.)

Also fix the detection of BC (hinted conditional branches) to use
FTR_LOWER_SAFE, so that it is not reported on mismatched systems.

Fixes: 356137e68a9f ("arm64/sysreg: Make BHB clear feature defines match the architecture")
Fixes: 8fcc8285c0e3 ("arm64/sysreg: Convert ID_AA64ISAR2_EL1 to automatic generation")
Cc: stable@vger.kernel.org
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20230912133429.2606875-1-kristina.martsenko@arm.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 96e50227f940..5bba39376055 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -663,7 +663,7 @@ static inline bool supports_clearbhb(int scope)
 		isar2 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
 
 	return cpuid_feature_extract_unsigned_field(isar2,
-						    ID_AA64ISAR2_EL1_BC_SHIFT);
+						    ID_AA64ISAR2_EL1_CLRBHB_SHIFT);
 }
 
 const struct cpumask *system_32bit_el0_cpumask(void);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b018ae12ff5f..444a73c2e638 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -222,7 +222,8 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
 static const struct arm64_ftr_bits ftr_id_aa64isar2[] = {
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CSSC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_RPRFM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, ID_AA64ISAR2_EL1_BC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_CLRBHB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_BC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR2_EL1_MOPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
 		       FTR_STRICT, FTR_EXACT, ID_AA64ISAR2_EL1_APA3_SHIFT, 4, 0),
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 2517ef7c21cf..76ce150e7347 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1347,7 +1347,11 @@ UnsignedEnum	51:48	RPRFM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	47:28
+Res0	47:32
+UnsignedEnum	31:28	CLRBHB
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	27:24	PAC_frac
 	0b0000	NI
 	0b0001	IMP

