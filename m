Return-Path: <stable+bounces-48396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327F18FE8D9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84486B25118
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C501974E7;
	Thu,  6 Jun 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxgMXTtL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07A4196C7D;
	Thu,  6 Jun 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682940; cv=none; b=svW6Hd/JftOlm5y8oa7oImvtkIFWG5DRKBF8sLwWHPXJyfUXgJvIpzzg5prj0jJJzkX6DtCjffDYK6gwZr1YqNxY9vEXF95HCLlzsU+q1g6cvqr9HWeyI7371iIxQIFmC89ZfePpsCZ7U1D65oSoTvBbckUutINx+5IVx6rodSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682940; c=relaxed/simple;
	bh=lRKfhnIFhlvTBSQsObfPuONEnhnWjZP+hNfp8B6QUa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvKwlq+6e9RvAq/pwT+eSWur5s5uF+XwWnwJIQV9W/AQpV2tfRTFC4sqrsW6puFK8pyN8hnEyIfbjxHANiJUpVBIXo+n9hD05cnX3K3BUWOzwa19v8D27OaR/Ii6IbOQMHmqpZFj6SXOcFG05eDrS02+ifnDjS+8zmfHnyoFvX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qxgMXTtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B662C2BD10;
	Thu,  6 Jun 2024 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682940;
	bh=lRKfhnIFhlvTBSQsObfPuONEnhnWjZP+hNfp8B6QUa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxgMXTtLxZh0ZuyDQHGWxYYkaLRoU5b5M//Da4zAWSbsmjXXhS0hDiiSQtWcliAsd
	 09xWITC+IhJhtJU/SdML3WunxiGzCYI9wUT5nXtEInBY0x7ddn0XCI1aGOEXq+uJQV
	 VRxjUvbsnwHIePgv+qlb1GVt7J3td0IccZngE96E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yabin Cui <yabinc@google.com>,
	Mike Leach <mike.leach@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 056/374] coresight: etm4x: Do not save/restore Data trace control registers
Date: Thu,  6 Jun 2024 16:00:35 +0200
Message-ID: <20240606131653.713922521@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

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
index b9c6c544d7597..a9765d45a0ee8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1739,9 +1739,6 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcvissctlr = etm4x_read32(csa, TRCVISSCTLR);
 	if (drvdata->nr_pe_cmp)
 		state->trcvipcssctlr = etm4x_read32(csa, TRCVIPCSSCTLR);
-	state->trcvdctlr = etm4x_read32(csa, TRCVDCTLR);
-	state->trcvdsacctlr = etm4x_read32(csa, TRCVDSACCTLR);
-	state->trcvdarcctlr = etm4x_read32(csa, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
@@ -1872,9 +1869,6 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, state->trcvissctlr, TRCVISSCTLR);
 	if (drvdata->nr_pe_cmp)
 		etm4x_relaxed_write32(csa, state->trcvipcssctlr, TRCVIPCSSCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdctlr, TRCVDCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdsacctlr, TRCVDSACCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdarcctlr, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9ea678bc2e8e5..9e430f72bbd6f 100644
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
@@ -272,9 +266,6 @@
 /* List of registers accessible via System instructions */
 #define ETM4x_ONLY_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPROCSELR)		\
-	CASE_##op((val), TRCVDCTLR)		\
-	CASE_##op((val), TRCVDSACCTLR)		\
-	CASE_##op((val), TRCVDARCCTLR)		\
 	CASE_##op((val), TRCOSLAR)
 
 #define ETM_COMMON_SYSREG_LIST(op, val)		\
@@ -422,22 +413,6 @@
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
@@ -907,9 +882,6 @@ struct etmv4_save_state {
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




