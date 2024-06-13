Return-Path: <stable+bounces-51760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C23907176
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DC61F25FBC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC28312C81F;
	Thu, 13 Jun 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y324K79B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F8441D;
	Thu, 13 Jun 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282232; cv=none; b=sUitaREx2nRRqn4fjdwPCU124zvPuIakamh1EciFK4ianx0JbUZCoTKzcMBm0NLVxQUprJshlCpLg+xjcJ7KOA8Bml54tL84SvFrhKBl0yp6nYVAWjAq2igCdfr8X3ofdY1d0DPl4/NPpp5N2pPB3otZ6SFbFkeiWd/ULmVwRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282232; c=relaxed/simple;
	bh=m2VPtiJpTuIWW1fcuOLdj22nNXqbuLBLD3odXhxSg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THKj7YAp4+rYZjbTCzFnVDxIL1VZFRkQ8uUo1McvzOMlS2sd2Zb3DmmZAFWtPeOIlMgwZGqNq5uO1saxip//7/M7vt2rxW/rrDXNDTPgGRgPngiXnA9e/+2ySEzn4wBULXUVkiEDrj8GBPn7iUE5ucKcSKXGQj478A1/tLqah2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y324K79B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DC0C32786;
	Thu, 13 Jun 2024 12:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282232;
	bh=m2VPtiJpTuIWW1fcuOLdj22nNXqbuLBLD3odXhxSg88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y324K79B2vLLtZ4ST0//O6d3+WFzIvfxPVvO47QCOmUwXpDZudstiPn8zPBbxW2mv
	 3yjTFD/oa8Fo5Z82jc9FAcCzxxUTSOd2GifGrp6z30hXOsGa9M7BbiiIi9wjXCIMgD
	 iQABaGzQV5WH9xgkcsQlYxDvi2nyWEUTr/zra3+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 207/402] coresight: etm4x: Cleanup TRCIDR0 register accesses
Date: Thu, 13 Jun 2024 13:32:44 +0200
Message-ID: <20240613113310.219900432@linuxfoundation.org>
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

From: James Clark <james.clark@arm.com>

[ Upstream commit e601cc9a3a9b94b48de7f120b583d94c2d9fe3b5 ]

This is a no-op change for style and consistency and has no effect on
the binary output by the compiler. In sysreg.h fields are defined as
the register name followed by the field name and then _MASK. This
allows for grepping for fields by name rather than using magic numbers.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Link: https://lore.kernel.org/r/20220304171913.2292458-2-james.clark@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Stable-dep-of: 46bf8d7cd853 ("coresight: etm4x: Safe access for TRCQCLTR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../coresight/coresight-etm4x-core.c          | 36 +++++--------------
 drivers/hwtracing/coresight/coresight-etm4x.h | 13 +++++++
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index fd753669b33eb..ed5b38013dc14 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1048,41 +1048,21 @@ static void etm4_init_arch_data(void *info)
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
 	/* INSTP0, bits[2:1] P0 tracing support field */
-	if (BMVAL(etmidr0, 1, 2) == 0b11)
-		drvdata->instrp0 = true;
-	else
-		drvdata->instrp0 = false;
-
+	drvdata->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);
 	/* TRCBB, bit[5] Branch broadcast tracing support bit */
-	if (BMVAL(etmidr0, 5, 5))
-		drvdata->trcbb = true;
-	else
-		drvdata->trcbb = false;
-
+	drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
 	/* TRCCOND, bit[6] Conditional instruction tracing support bit */
-	if (BMVAL(etmidr0, 6, 6))
-		drvdata->trccond = true;
-	else
-		drvdata->trccond = false;
-
+	drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
 	/* TRCCCI, bit[7] Cycle counting instruction bit */
-	if (BMVAL(etmidr0, 7, 7))
-		drvdata->trccci = true;
-	else
-		drvdata->trccci = false;
-
+	drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
 	/* RETSTACK, bit[9] Return stack bit */
-	if (BMVAL(etmidr0, 9, 9))
-		drvdata->retstack = true;
-	else
-		drvdata->retstack = false;
-
+	drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
 	/* NUMEVENT, bits[11:10] Number of events field */
-	drvdata->nr_event = BMVAL(etmidr0, 10, 11);
+	drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
 	/* QSUPP, bits[16:15] Q element support field */
-	drvdata->q_support = BMVAL(etmidr0, 15, 16);
+	drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
 	/* TSSIZE, bits[28:24] Global timestamp size field */
-	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
+	drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
 
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 348d440ccd060..c463dab350397 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -125,6 +125,19 @@
 
 #define TRCRSR_TA			BIT(12)
 
+/*
+ * Bit positions of registers that are defined above, in the sysreg.h style
+ * of _MASK for multi bit fields and BIT() for single bits.
+ */
+#define TRCIDR0_INSTP0_MASK			GENMASK(2, 1)
+#define TRCIDR0_TRCBB				BIT(5)
+#define TRCIDR0_TRCCOND				BIT(6)
+#define TRCIDR0_TRCCCI				BIT(7)
+#define TRCIDR0_RETSTACK			BIT(9)
+#define TRCIDR0_NUMEVENT_MASK			GENMASK(11, 10)
+#define TRCIDR0_QSUPP_MASK			GENMASK(16, 15)
+#define TRCIDR0_TSSIZE_MASK			GENMASK(28, 24)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
-- 
2.43.0




