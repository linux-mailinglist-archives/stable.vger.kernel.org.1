Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA53679B6F8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376490AbjIKWTr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238278AbjIKNxF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:53:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B97FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:53:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9412C433C8;
        Mon, 11 Sep 2023 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440380;
        bh=Dx0HDu0R2IDB1xkAwnNs6at+PQkvoSrWPUfmch1Cfy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVkEzOHA9+h1MBHsSnn2BRr7U1ZPyfzK8ENO8wj2C86RdKstgcgBzdTBHhpq9I1uK
         KIseRWUrpxxvj2Mm/Vf+AqyL1cO4kwbYxDfjv57FY6r9T5yqy6Q6l9i92kUAsIXeKf
         KY35bBx7rUUvD/xDcLBud9NYZsaq4vfQgRqKrLzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 040/739] arm64/fpsimd: Only provide the length to cpufeature for xCR registers
Date:   Mon, 11 Sep 2023 15:37:19 +0200
Message-ID: <20230911134652.224933764@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 01948b09edc3fecf8486c57c2d2fb8b80886f3d0 ]

For both SVE and SME we abuse the generic register field comparison
support in the cpufeature code as part of our detection of unsupported
variations in the vector lengths available to PEs, reporting the maximum
vector lengths via ZCR_EL1.LEN and SMCR_EL1.LEN.  Since these are
configuration registers rather than identification registers the
assumptions the cpufeature code makes about how unknown bitfields behave
are invalid, leading to warnings when SME features like FA64 are enabled
and we hotplug a CPU:

  CPU features: SANITY CHECK: Unexpected variation in SYS_SMCR_EL1. Boot CPU: 0x0000000000000f, CPU3: 0x0000008000000f
  CPU features: Unsupported CPU feature variation detected.

SVE has no controls other than the vector length so is not yet impacted
but the same issue will apply there if any are defined.

Since the only field we are interested in having the cpufeature code
handle is the length field and we use a custom read function to obtain
the value we can avoid these warnings by filtering out all other bits
when we return the register value, if we're doing that we don't need to
bother reading the register at all and can simply use the RDVL/RDSVL
value we were filling in instead.

Fixes: 2e0f2478ea37 ("arm64/sve: Probe SVE capabilities and usable vector lengths")
FixeS: b42990d3bf77 ("arm64/sme: Identify supported SME vector lengths at boot")
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 087c05aa960ea..91e44ac7150f9 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1179,9 +1179,6 @@ void sve_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
  */
 u64 read_zcr_features(void)
 {
-	u64 zcr;
-	unsigned int vq_max;
-
 	/*
 	 * Set the maximum possible VL, and write zeroes to all other
 	 * bits to see if they stick.
@@ -1189,12 +1186,8 @@ u64 read_zcr_features(void)
 	sve_kernel_enable(NULL);
 	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
 
-	zcr = read_sysreg_s(SYS_ZCR_EL1);
-	zcr &= ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
-	vq_max = sve_vq_from_vl(sve_get_vl());
-	zcr |= vq_max - 1; /* set LEN field to maximum effective value */
-
-	return zcr;
+	/* Return LEN value that would be written to get the maximum VL */
+	return sve_vq_from_vl(sve_get_vl()) - 1;
 }
 
 void __init sve_setup(void)
@@ -1349,9 +1342,6 @@ void fa64_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
  */
 u64 read_smcr_features(void)
 {
-	u64 smcr;
-	unsigned int vq_max;
-
 	sme_kernel_enable(NULL);
 
 	/*
@@ -1360,12 +1350,8 @@ u64 read_smcr_features(void)
 	write_sysreg_s(read_sysreg_s(SYS_SMCR_EL1) | SMCR_ELx_LEN_MASK,
 		       SYS_SMCR_EL1);
 
-	smcr = read_sysreg_s(SYS_SMCR_EL1);
-	smcr &= ~(u64)SMCR_ELx_LEN_MASK; /* Only the LEN field */
-	vq_max = sve_vq_from_vl(sme_get_vl());
-	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
-
-	return smcr;
+	/* Return LEN value that would be written to get the maximum VL */
+	return sve_vq_from_vl(sme_get_vl()) - 1;
 }
 
 void __init sme_setup(void)
-- 
2.40.1



