Return-Path: <stable+bounces-130869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE87A80652
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800F67A42A7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409626AABF;
	Tue,  8 Apr 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zKuL0eUH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FA26A0BA;
	Tue,  8 Apr 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114872; cv=none; b=tH6tH0iw3hJfP4XabaNGLlB+0AeBpaheV7rcId3Pld0SyCdtPlvfpiR4GllyAQZmVJq6F6yKlSUQ1JHrHFyaaxW6K2pPsWemXwdBL9ohGPkDHBbfoI4HOH6F68sNumMXaXFYImA/9KrQ9RvPejmf/tWENM78jXBtB65XBMALg94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114872; c=relaxed/simple;
	bh=6RL8lmgt9TvO4GreVKQlHTwDvDuRR6TvSTge/I5TQ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmG/aApaYkgEsVSGHGlhUXrtS0y40KPYc9OVKLEArXDPEnYnjGyInlWivElILKOZeuvlvaYw7w16Ni1XnQXUyi/clkFN1jvuYPWMJOQUg6mHrDP57wFdgW634fWoGTBkxOLnKeVePZa7lzD0Cmn60rV8c8oW+8TyP7nDTg8Xydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zKuL0eUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5031C4CEE5;
	Tue,  8 Apr 2025 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114872;
	bh=6RL8lmgt9TvO4GreVKQlHTwDvDuRR6TvSTge/I5TQ4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zKuL0eUHFCgTWR1LLPuBCRjFTxr/YFB1iMjRH3rUKwMELHyjZVTfd2xnzIIt9Jpt/
	 fTX/o22HijcNcoIwLXm5KnEUKD/EPTqecCI8uLJtGB9xk0L4CnjY8iPsbfIt9+oZFl
	 AHpJgi7IUGSi9HY40v6ftADpY6fvcZ7q8z71Kzok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 267/499] perf vendor events arm64 AmpereOneX: Fix frontend_bound calculation
Date: Tue,  8 Apr 2025 12:47:59 +0200
Message-ID: <20250408104857.874606131@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

[ Upstream commit 182f12f3193341c3400ae719a34c00a8a1204cff ]

frontend_bound metrics was miscalculated due to different scaling in
a couple of metrics it depends on. Change the scaling to match with
AmpereOne.

Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Link: https://lore.kernel.org/r/20250313201559.11332-3-ilkka@os.amperecomputing.com
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
index c5d1d22bd034b..5228f94a793f9 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -229,19 +229,19 @@
     },
     {
         "MetricName": "slots_lost_misspeculation_fraction",
-        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
+        "MetricExpr": "100 * (OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
-        "ScaleUnit": "100percent of slots"
+        "ScaleUnit": "1percent of slots"
     },
     {
         "MetricName": "retired_fraction",
-        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * #slots)",
+        "MetricExpr": "100 * OP_RETIRED / (CPU_CYCLES * #slots)",
         "BriefDescription": "Fraction of slots retiring, useful work",
         "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
-        "ScaleUnit": "100percent of slots"
+        "ScaleUnit": "1percent of slots"
     },
     {
         "MetricName": "backend_core",
@@ -266,7 +266,7 @@
     },
     {
         "MetricName": "frontend_bandwidth",
-        "MetricExpr": "frontend_bound - frontend_latency",
+        "MetricExpr": "frontend_bound - 100 * frontend_latency",
         "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
         "MetricGroup": "TopdownL2",
         "ScaleUnit": "1percent of slots"
-- 
2.39.5




