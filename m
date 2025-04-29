Return-Path: <stable+bounces-137982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B24AA15FA
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F991B624DD
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41B25178C;
	Tue, 29 Apr 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6GyaRST"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA2924503E;
	Tue, 29 Apr 2025 17:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745947728; cv=none; b=at9lhB73uDv2NHcn8tSHA15Rkx3P5PKOA+SMq4NHRef1HB2H18fgBOq/S4RwiRxBgT5W9Pc2HbAC3cJBPZbMU2q8iMnmfWIBOB/lxfIO3HMJK2X2FAxp9/mhDbnJ6gAIZtJhuedgQkpdndyWuj8NdlaZAnGxFkFkCQPlDdLrfF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745947728; c=relaxed/simple;
	bh=yjTCV7PVfF+4EsFXN6ADst08EqydfgE2FyrqyMKXXeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJVZaqUVINpO9BMzf4uAdMLrsaZmnF0+ESV2l43wTydf0MjzCmhtk87njQxaS8eHUccVqW2eUWAN5ss5134QxJwGjbUZhxnG6e2s1pI+y6H0oSiWiN5v1Ea1NhigA3DR1GdJrTkfuqqAFrI6s3kcBFeRmLWABhc/OrN8P/44nuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6GyaRST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E484C4CEE9;
	Tue, 29 Apr 2025 17:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745947728;
	bh=yjTCV7PVfF+4EsFXN6ADst08EqydfgE2FyrqyMKXXeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6GyaRSThaAzRKzxeZQsS7QaRLKQkBtHLFv27lFPmJvp2gB1a2rhvzAC5NZRHdreS
	 EteOLdpGkfgzJJk/GCcvMq+6Y8OgNjnfLeQfplaR2Kcuq/J/JfjixyHJ9mkdB/H+xB
	 m6XEYAxOkl/kbMdwbcMfP+sO2OUPgRr+cPYA8dOs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 088/280] perf/x86: Fix non-sampling (counting) events on certain x86 platforms
Date: Tue, 29 Apr 2025 18:40:29 +0200
Message-ID: <20250429161118.711565947@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luo Gengkun <luogengkun@huaweicloud.com>

[ Upstream commit 1a97fea9db9e9b9c4839d4232dde9f505ff5b4cc ]

Perf doesn't work at perf stat for hardware events on certain x86 platforms:

 $perf stat -- sleep 1
 Performance counter stats for 'sleep 1':
             16.44 msec task-clock                       #    0.016 CPUs utilized
                 2      context-switches                 #  121.691 /sec
                 0      cpu-migrations                   #    0.000 /sec
                54      page-faults                      #    3.286 K/sec
   <not supported>	cycles
   <not supported>	instructions
   <not supported>	branches
   <not supported>	branch-misses

The reason is that the check in x86_pmu_hw_config() for sampling events is
unexpectedly applied to counting events as well.

It should only impact x86 platforms with limit_period used for non-PEBS
events. For Intel platforms, it should only impact some older platforms,
e.g., HSW, BDW and NHM.

Fixes: 88ec7eedbbd2 ("perf/x86: Fix low freqency setting issue")
Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20250423064724.3716211-1-luogengkun@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0d33c85da4535..d737d53d03aa9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -628,7 +628,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (!event->attr.freq && x86_pmu.limit_period) {
+	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)
-- 
2.39.5




