Return-Path: <stable+bounces-164557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A812AB0FF6C
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 06:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F104547E19
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E71EC01B;
	Thu, 24 Jul 2025 04:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNGhM065"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127001E8335
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329977; cv=none; b=UltjhmwVqY6cyMOT+ebzzHBjysmNNzNmfuUdOy+wrVtCuQMZP7Ni4/sehj4H3SU03Hmim8FfhSDgqZnpls7nil/lMFgzAmBeFg+5Wf3eWfu+DpLWFPbznnAvHeW54jmLhjuhZL9yR6DcFnKOdoaOaq1hjqBrqqBWwA9OcM4z7SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329977; c=relaxed/simple;
	bh=7LhSsrSSMmJlaXd4IkRIGV7ifMRhAO6gF3cgw563aJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SM+r6PdUGWd5mNBOUApqohF6gO6YxBH/kA1HGlqkqUy30T++ec5+EhVKlTzIwc/0vFHP+/IeENlP9Vk+i5ZZSs+rpTJp0gyRaEgZHwEKrmD0NR5SylMf1R61cjGPtDQIoQIvq4Zf2NumHEeEQosukRSeX+W8vyBoaRAAYdUsvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNGhM065; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7721DC4CEED;
	Thu, 24 Jul 2025 04:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753329976;
	bh=7LhSsrSSMmJlaXd4IkRIGV7ifMRhAO6gF3cgw563aJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNGhM065oP+rTa31WDcEal8mSZEFZm/lf7tAto7zhWYFLqcBSdWkYevyMwkrlYgEJ
	 NQMknHPgJPZM0AouUlzoCRGIB2Z+b3LIkFXSQQZF6uAfdBNXlDTPcwtcViu/p/qZQJ
	 onWSUba0Mue5tFsPx/3GAqwaGsK/dBvifvJzBe+C706ioiQQZFcwn0cvhaZGYqLgZv
	 ZCn98ve4NzLfHa6BTQZmuYC8lUBsue9EeDcTZDkD4JKaAb2Ko14wjrEAdojoS1ewQT
	 5Y7KXajt7fJBUYtShMc+Bxqg44McxusXPBWc+URtQ3kjrF4s0G2xUK3FECXXdSGa00
	 TpoxHAntZ2F0g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Vince Weaver <vincent.weaver@maine.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] perf/x86/intel: Fix crash in icl_update_topdown_event()
Date: Thu, 24 Jul 2025 00:06:12 -0400
Message-Id: <20250724040612.1296188-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025062337-conceal-parole-52a4@gregkh>
References: <2025062337-conceal-parole-52a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit b0823d5fbacb1c551d793cbfe7af24e0d1fa45ed ]

The perf_fuzzer found a hard-lockup crash on a RaptorLake machine:

  Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
  CPU: 23 UID: 0 PID: 0 Comm: swapper/23
  Tainted: [W]=WARN
  Hardware name: Dell Inc. Precision 9660/0VJ762
  RIP: 0010:native_read_pmc+0x7/0x40
  Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
  RSP: 000:fffb03100273de8 EFLAGS: 00010046
  ....
  Call Trace:
    <TASK>
    icl_update_topdown_event+0x165/0x190
    ? ktime_get+0x38/0xd0
    intel_pmu_read_event+0xf9/0x210
    __perf_event_read+0xf9/0x210

CPUs 16-23 are E-core CPUs that don't support the perf metrics feature.
The icl_update_topdown_event() should not be invoked on these CPUs.

It's a regression of commit:

  f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")

The bug introduced by that commit is that the is_topdown_event() function
is mistakenly used to replace the is_topdown_count() call to check if the
topdown functions for the perf metrics feature should be invoked.

Fix it.

Fixes: f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")
Closes: https://lore.kernel.org/lkml/352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu/
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
Cc: stable@vger.kernel.org # v6.15+
Link: https://lore.kernel.org/r/20250612143818.2889040-1-kan.liang@linux.intel.com
[ omitted PEBS check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 835c9febb6a85..87ea4339e03a2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2734,7 +2734,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		if (pmu_enabled)
 			intel_pmu_disable_all();
 
-		if (is_topdown_event(event))
+		if (is_topdown_count(event))
 			static_call(intel_pmu_update_topdown_event)(event);
 		else
 			intel_pmu_drain_pebs_buffer();
-- 
2.39.5


