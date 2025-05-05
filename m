Return-Path: <stable+bounces-141460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D3DAAB3A2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB731C04F66
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF61293B5D;
	Tue,  6 May 2025 00:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFzId9r2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7352C0307;
	Mon,  5 May 2025 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486360; cv=none; b=br1WUb+5oRElLc3rgFGnZ0tbJ5KsIvf0SE2mSuWxYacoxs7UZKR0aasTaAf+0LBmvxOD7YSkB9+N1y2wxn4MqU1UDz4KqnImf+t96rddba9QfchX8hoOVmTf50n48wfbixNWi+tn2tryVUMOmIQp1tEKrGPSl/dFR6OjWIbLirU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486360; c=relaxed/simple;
	bh=+/ENvqZEfyIPrgyGGLNvnPCd/LlCpKKXGSOt+FYsk6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NURj1kamU8X0wfvCQp7j0dIIBTGDUqN6X5uoQLlioenK5D9VLzuQWmZocmqx0xayyHUj0K1C4P9lwGumMK5QB+GSmZ9mp0MKaAADiGZaGVASoxu9txSCBV3ZK7n2c20904YOEJS32XN96n7En4IVpWXuDQWJsW1JMJnDBlh0ZhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFzId9r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27DCC4CEEE;
	Mon,  5 May 2025 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486360;
	bh=+/ENvqZEfyIPrgyGGLNvnPCd/LlCpKKXGSOt+FYsk6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFzId9r2syvoxy7DYq1lbberzw8SoqpQnQE5J3ni37rrotiZpzljWjfci3hRWRIh0
	 iB9Zo9wSTafULrtj9OD6c1+9rEPfwXgW5a33zP4mQxEkpEEpCj28No2sH+hlv0mOW1
	 E/8SMZ7Z61HpxCpzC8Unj8DBai60N3ypFtXb+8phRY3qI5poFPNAQALlyxVAi8M/IP
	 sH7bmQ4jNb9L1X8W+EENgU6jQq3vZDu3czmJ4a5ZC3koB3FKENvpTHgBJNNRVn4kyG
	 EqWyMVo94JSrL/gtMFukWLm+wzTDmx9yy3KgAgZQf3JCN7w/DMtd6pyFnhe/ulPeTH
	 4GdTVClbZx7mQ==
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
Subject: [PATCH AUTOSEL 6.6 280/294] perf/amd/ibs: Fix ->config to sample period calculation for OP PMU
Date: Mon,  5 May 2025 18:56:20 -0400
Message-Id: <20250505225634.2688578-280-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 85731f121feb5..fac3d97111b09 100644
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
@@ -306,10 +306,19 @@ static int perf_ibs_init(struct perf_event *event)
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


