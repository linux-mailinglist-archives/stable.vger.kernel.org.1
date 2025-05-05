Return-Path: <stable+bounces-141320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07604AAB26D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B23188C36B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EE8429535;
	Tue,  6 May 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJREYSs8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524ED27875A;
	Mon,  5 May 2025 22:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485749; cv=none; b=DDg6qZlBwVHTRCNWmE8h5cS1DpKScKwt7SxZPUkgbObVqYcSdcpF4tLGr5kNL+/2TLbxC2U7b/A+8YuORWTmhqCbVF+pEUU1sc4i2KT03vNvg28J/pAZCrlNKlYvgnE/qxusI3tKdTvsIqp8rLRyKV3+YuiKoNLiSI4NQq7RlzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485749; c=relaxed/simple;
	bh=AO9GV99mzhCrPk2fpfmQvbB6VP8nxmgcM6cNff05R70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETcbP+OL25PyV9ouKMoGRyjMnVJ5xXrX4fIniQGt2AAFbCbH9rQcP98HG5YC0BjPKZC2U+UvN29WbSca7a6tGv9HDt0sag9yle1KNWq93RvY8zec6+sTxoKJYCx9bJWPYzd8Z9PW1MvLMs8GEYDxqt+obaQMXgDzfea0bO5VEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJREYSs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3860C4CEEE;
	Mon,  5 May 2025 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485748;
	bh=AO9GV99mzhCrPk2fpfmQvbB6VP8nxmgcM6cNff05R70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJREYSs84nl656NY/K0MHDK5IgLE8S14KuI+52ir8g72826OYbR7LRC5q62r0qkCG
	 UE+cDy312RWN94+ntAdY7nZY56FeBbczJB3Y77TQLQGWRONIyucCK9jYDSwaNvzyqy
	 /bBKsS1ILmIcw4tQfGa7m3ELHHTtb9DnlWtzXmYc8dKNOITDLnEe7aMptUbufeVxTB
	 LFYtFLhFxcYxhWQOJDumIO3jBz6zsEezSpG31QyF5IpH8MH5BfH1eD4EjNMdzm2vXu
	 NF0iFLxmdlVeWF0U5a6qBdAGfiayWxObk3Y2GBw/Dk1XxnzO8lE73LdWIfmGh4con1
	 /DNn2RN3t0ZzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	acme@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 460/486] perf/amd/ibs: Fix ->config to sample period calculation for OP PMU
Date: Mon,  5 May 2025 18:38:56 -0400
Message-Id: <20250505223922.2682012-460-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ravi Bangoria <ravi.bangoria@amd.com>

[ Upstream commit 598bdf4fefff5af4ce6d26d16f7b2a20808fc4cb ]

Instead of using standard perf_event_attr->freq=0 and ->sample_period
fields, IBS event in 'sample period mode' can also be opened by setting
period value directly in perf_event_attr->config in a MaxCnt bit-field
format.

IBS OP MaxCnt bits are defined as:

  (high bits) IbsOpCtl[26:20] = IbsOpMaxCnt[26:20]
  (low bits)  IbsOpCtl[15:0]  = IbsOpMaxCnt[19:4]

Perf event sample period can be derived from MaxCnt bits as:

  sample_period = (high bits) | ((low_bits) << 4);

However, current code just masks MaxCnt bits and shifts all of them,
including high bits, which is incorrect. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-4-ravi.bangoria@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/ibs.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 8f3b5764e139d..d34ee6f04f18f 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -272,7 +272,7 @@ static int perf_ibs_init(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs;
-	u64 max_cnt, config;
+	u64 config;
 	int ret;
 
 	perf_ibs = get_ibs_pmu(event->attr.type);
@@ -309,10 +309,19 @@ static int perf_ibs_init(struct perf_event *event)
 		if (!hwc->sample_period)
 			hwc->sample_period = 0x10;
 	} else {
-		max_cnt = config & perf_ibs->cnt_mask;
+		u64 period = 0;
+
+		if (perf_ibs == &perf_ibs_op) {
+			period = (config & IBS_OP_MAX_CNT) << 4;
+			if (ibs_caps & IBS_CAPS_OPCNTEXT)
+				period |= config & IBS_OP_MAX_CNT_EXT_MASK;
+		} else {
+			period = (config & IBS_FETCH_MAX_CNT) << 4;
+		}
+
 		config &= ~perf_ibs->cnt_mask;
-		event->attr.sample_period = max_cnt << 4;
-		hwc->sample_period = event->attr.sample_period;
+		event->attr.sample_period = period;
+		hwc->sample_period = period;
 	}
 
 	if (!hwc->sample_period)
-- 
2.39.5


