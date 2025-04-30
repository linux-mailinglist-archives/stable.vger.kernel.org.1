Return-Path: <stable+bounces-139142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC36EAA4A85
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9EE188F3AE
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C1E25B1EF;
	Wed, 30 Apr 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dhu5Pzzt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HEXpQGDy"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A2125A620;
	Wed, 30 Apr 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014338; cv=none; b=tFoCLntmQWkbz64yF1THo224Ce622en3FctXoQIs8hU/0gILZICZkchk2wNB1p9ppGnrEPseasHSff1u66Fu3Wxks2AgQn/DtvlkeFKGT6y3hXLbbSS3sCh09WUozNYvqjcoZK6yWZRR6qO4riss21wDIsC7FlEn3vZGmxJtrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014338; c=relaxed/simple;
	bh=RPT6xVXskHNaBNVRduzIyuTQ0XExI1FewjwZBhtutGY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IYppddhrtkyoqghUTJMDCAIRendzCBXtJVNxsbfZXBFh3KYt4+VYA2H5SFJEPViSIRpITywSLc/bPfsWFeh5VbL56vntg5VXuOdu7EMREzSGv2FKoELlGyo68RYOMufWkz4EwoBwZcrnf4p2N9EjttVeubtZCzZV8+raGbx+5/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dhu5Pzzt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HEXpQGDy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 11:58:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746014334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYdwIozfucINEClBOXK8ye0Y616rg5vy4GYB20b2H+c=;
	b=dhu5Pzztg7xmVFR0WSAyzgewyKZ3PiIph5OU3l99XzKLvglqGavvDAYpSW8FBKaoCS3X1r
	q4NLWJtRz4eyZhX/uQsorc89/Xd8sw7K52PnNepp4ucdjPKjALJChjVKrWP09nW8u7aUg6
	yYSA0RDhK76WIuxkhpZFs0zRsKC+5VCeKrCIldOcRFB2O/JUnDJ5b6ryoZ/CN2pHj21NvY
	tVwsY9sXFtlaiAJC61/3BsG9Gbb3HOa+kYZSWRYiXY4c+IWMLpp9MUPJFoFstQWxvFT6rZ
	g01lsPf4C6q+Tnr3216cGzg7FAOl1YtMYDOqcjhYLs4AGdiXp0OVx+VPTXQrbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746014334;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CYdwIozfucINEClBOXK8ye0Y616rg5vy4GYB20b2H+c=;
	b=HEXpQGDyQsmFFzIuC5NUOZJQdrciXvgpdD+o4BxytnOmV0HpV0r4z4G0IJFrCgX0cAoDUl
	j4bd/MwNqeHK4vAQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Only check the group flag for X86 leader
Cc: Luo Gengkun <luogengkun@huaweicloud.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250424134718.311934-2-kan.liang@linux.intel.com>
References: <20250424134718.311934-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174601433392.22196.265193893533639752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     75aea4b0656ead0facd13d2aae4cb77326e53d2f
Gitweb:        https://git.kernel.org/tip/75aea4b0656ead0facd13d2aae4cb77326e53d2f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 24 Apr 2025 06:47:14 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Apr 2025 14:55:19 +02:00

perf/x86/intel: Only check the group flag for X86 leader

A warning in intel_pmu_lbr_counters_reorder() may be triggered by below
perf command.

perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1

It's because the group is mistakenly treated as a branch counter group.

The hw.flags of the leader are used to determine whether a group is a
branch counters group. However, the hw.flags is only available for a
hardware event. The field to store the flags is a union type. For a
software event, it's a hrtimer. The corresponding bit may be set if the
leader is a software event.

For a branch counter group and other groups that have a group flag
(e.g., topdown, PEBS counters snapshotting, and ACR), the leader must
be a X86 event. Check the X86 event before checking the flag.
The patch only fixes the issue for the branch counter group.
The following patch will fix the other groups.

There may be an alternative way to fix the issue by moving the hw.flags
out of the union type. It should work for now. But it's still possible
that the flags will be used by other types of events later. As long as
that type of event is used as a leader, a similar issue will be
triggered. So the alternative way is dropped.

Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
Closes: https://lore.kernel.org/lkml/20250412091423.1839809-1-luogengkun@huaweicloud.com/
Reported-by: Luo Gengkun <luogengkun@huaweicloud.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250424134718.311934-2-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  2 +-
 arch/x86/events/perf_event.h |  9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3a4f031..139ad80 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -754,7 +754,7 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-static inline int is_x86_event(struct perf_event *event)
+int is_x86_event(struct perf_event *event)
 {
 	int i;
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2c0ce0e..4237c37 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -110,9 +110,16 @@ static inline bool is_topdown_event(struct perf_event *event)
 	return is_metric_event(event) || is_slots_event(event);
 }
 
+int is_x86_event(struct perf_event *event);
+
+static inline bool check_leader_group(struct perf_event *leader, int flags)
+{
+	return is_x86_event(leader) ? !!(leader->hw.flags & flags) : false;
+}
+
 static inline bool is_branch_counters_group(struct perf_event *event)
 {
-	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
+	return check_leader_group(event->group_leader, PERF_X86_EVENT_BRANCH_COUNTERS);
 }
 
 static inline bool is_pebs_counter_event_group(struct perf_event *event)

