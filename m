Return-Path: <stable+bounces-51758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77378907175
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C16B24FEA
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8F1EEF8;
	Thu, 13 Jun 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmgvahNB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808153C24;
	Thu, 13 Jun 2024 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282226; cv=none; b=NKvBMikcUTJLtetMKwPJNHnVuQMIBJWPXirVw3kP3w/GJt8zhNMQKD+1wUlpf79bUTfVR9XqqwnwLq6iqHLswsCY8VdjnUe/DKsWVa8ddTONIHmghSwkUcY6ChTTujBgw1W8aScWgMQeYK5n3lnOr9beswP4xfqQwl35ddGW5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282226; c=relaxed/simple;
	bh=8TDL3UjNo7SfYjF4PraCVVmEAMFIZysJRBzwH7EoUsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fn3vJ9twWwavVb2ILWq/HMc3h2FA+lYO1OPcAOraVsf4YJS1AkldlLp8xgtLj86PJTRxZSd9gBSNVqhVGLWQgpooOn2q0a5NmiHX8ux5xc+ZxYBNynWapE8wIh5//ikG/rYyX9BkeoFyf1kV1DfStKmsOEWJUav/WF4/XB2o2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bmgvahNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E69C2BBFC;
	Thu, 13 Jun 2024 12:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282226;
	bh=8TDL3UjNo7SfYjF4PraCVVmEAMFIZysJRBzwH7EoUsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmgvahNBajVjfazmrPfq/rnSSNgws1qMJq1Hpe74WgrOSs11nX2z/JoBvyp0hAE0B
	 yBnAQvtpqp8+9Re4UMQCujmRupieb8DczKRqqYNJG5H0VcWzfwWb9cLMMhM9SGyVPd
	 jOGk/JD6Mb6x10WgYe1xuj5CXOgHO/N+ms3D3rCo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yabin Cui <yabinc@google.com>,
	Mike Leach <mike.leach@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 205/402] coresight: etm4x: Do not save/restore Data trace control registers
Date: Thu, 13 Jun 2024 13:32:42 +0200
Message-ID: <20240613113310.143279113@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 5eb3a0c2c52368cb9902e9a6ea04888e093c487d ]

ETM4x doesn't support Data trace on A class CPUs. As such do not access the
Data trace control registers during CPU idle. This could cause problems for
ETE. While at it, remove all references to the Data trace control registers.

Fixes: f188b5e76aae ("coresight: etm4x: Save/restore state across CPU low power states")
Reported-by: Yabin Cui <yabinc@google.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Yabin Cui <yabinc@google.com>
Link: https://lore.kernel.org/r/20240412142702.2882478-3-suzuki.poulose@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../coresight/coresight-etm4x-core.c          |  6 ----
 drivers/hwtracing/coresight/coresight-etm4x.h | 28 -------------------
 2 files changed, 34 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 07f1c0ff89961..d3c11e305e5b9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1609,9 +1609,6 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcvissctlr = etm4x_read32(csa, TRCVISSCTLR);
 	if (drvdata->nr_pe_cmp)
 		state->trcvipcssctlr = etm4x_read32(csa, TRCVIPCSSCTLR);
-	state->trcvdctlr = etm4x_read32(csa, TRCVDCTLR);
-	state->trcvdsacctlr = etm4x_read32(csa, TRCVDSACCTLR);
-	state->trcvdarcctlr = etm4x_read32(csa, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
@@ -1726,9 +1723,6 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, state->trcvissctlr, TRCVISSCTLR);
 	if (drvdata->nr_pe_cmp)
 		etm4x_relaxed_write32(csa, state->trcvipcssctlr, TRCVIPCSSCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdctlr, TRCVDCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdsacctlr, TRCVDSACCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdarcctlr, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a0f3f0ba3380c..348d440ccd060 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -43,9 +43,6 @@
 #define TRCVIIECTLR			0x084
 #define TRCVISSCTLR			0x088
 #define TRCVIPCSSCTLR			0x08C
-#define TRCVDCTLR			0x0A0
-#define TRCVDSACCTLR			0x0A4
-#define TRCVDARCCTLR			0x0A8
 /* Derived resources registers */
 #define TRCSEQEVRn(n)			(0x100 + (n * 4)) /* n = 0-2 */
 #define TRCSEQRSTEVR			0x118
@@ -90,9 +87,6 @@
 /* Address Comparator registers n = 0-15 */
 #define TRCACVRn(n)			(0x400 + (n * 8))
 #define TRCACATRn(n)			(0x480 + (n * 8))
-/* Data Value Comparator Value registers, n = 0-7 */
-#define TRCDVCVRn(n)			(0x500 + (n * 16))
-#define TRCDVCMRn(n)			(0x580 + (n * 16))
 /* ContextID/Virtual ContextID comparators, n = 0-7 */
 #define TRCCIDCVRn(n)			(0x600 + (n * 8))
 #define TRCVMIDCVRn(n)			(0x640 + (n * 8))
@@ -174,9 +168,6 @@
 /* List of registers accessible via System instructions */
 #define ETM4x_ONLY_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPROCSELR)		\
-	CASE_##op((val), TRCVDCTLR)		\
-	CASE_##op((val), TRCVDSACCTLR)		\
-	CASE_##op((val), TRCVDARCCTLR)		\
 	CASE_##op((val), TRCOSLAR)
 
 #define ETM_COMMON_SYSREG_LIST(op, val)		\
@@ -324,22 +315,6 @@
 	CASE_##op((val), TRCACATRn(13))		\
 	CASE_##op((val), TRCACATRn(14))		\
 	CASE_##op((val), TRCACATRn(15))		\
-	CASE_##op((val), TRCDVCVRn(0))		\
-	CASE_##op((val), TRCDVCVRn(1))		\
-	CASE_##op((val), TRCDVCVRn(2))		\
-	CASE_##op((val), TRCDVCVRn(3))		\
-	CASE_##op((val), TRCDVCVRn(4))		\
-	CASE_##op((val), TRCDVCVRn(5))		\
-	CASE_##op((val), TRCDVCVRn(6))		\
-	CASE_##op((val), TRCDVCVRn(7))		\
-	CASE_##op((val), TRCDVCMRn(0))		\
-	CASE_##op((val), TRCDVCMRn(1))		\
-	CASE_##op((val), TRCDVCMRn(2))		\
-	CASE_##op((val), TRCDVCMRn(3))		\
-	CASE_##op((val), TRCDVCMRn(4))		\
-	CASE_##op((val), TRCDVCMRn(5))		\
-	CASE_##op((val), TRCDVCMRn(6))		\
-	CASE_##op((val), TRCDVCMRn(7))		\
 	CASE_##op((val), TRCCIDCVRn(0))		\
 	CASE_##op((val), TRCCIDCVRn(1))		\
 	CASE_##op((val), TRCCIDCVRn(2))		\
@@ -821,9 +796,6 @@ struct etmv4_save_state {
 	u32	trcviiectlr;
 	u32	trcvissctlr;
 	u32	trcvipcssctlr;
-	u32	trcvdctlr;
-	u32	trcvdsacctlr;
-	u32	trcvdarcctlr;
 
 	u32	trcseqevr[ETM_MAX_SEQ_STATES];
 	u32	trcseqrstevr;
-- 
2.43.0




