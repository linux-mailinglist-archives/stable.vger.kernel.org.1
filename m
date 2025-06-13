Return-Path: <stable+bounces-152610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85822AD84F9
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 09:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A807AFEE4
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 07:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CECD279DA0;
	Fri, 13 Jun 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoAYcFYz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pmtJQTdO"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7A257429;
	Fri, 13 Jun 2025 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800817; cv=none; b=knSXzPkpz/Yu9sP4+aeYMQU1JtMV7Vrxgxf8WjJzl2rNFtHDynojNQgW7U3BdPB6CNpHj6pouQyXIWwhdkgw9UUZfoZn1HtxLUCLhiOXCKXL54dYNVWSer6H8K6zA6z9zvUy71aMc3d8LFp9KcpclDHummPgJ2+q4XS/vFiq+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800817; c=relaxed/simple;
	bh=ggsEPsc5My9b6nGy0dNSc9jiNHHKzbYi2GfOzd74X7I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tvQlpClVqDolvMaEstXzN2WJH8FMwKtWjdyH5WMAvRZ766eH8LZvC8T5Bg13vDM3PcqpqU5kcqh+Nsofcv8UhAIZUv4WnsIqWfBYGaduiTmWsT0eVd8/d9rCRoSKYqvkxO1llOrx/LAS98RXnjzXJeZl6JZfK8ctZye+oMN1CBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UoAYcFYz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pmtJQTdO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:46:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800813;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeARu5qdgdS1dM2fNHluVEYW7CA6XC6Z01lr5OTWuYw=;
	b=UoAYcFYzxURd/fetIWkGfzLFBqXgg+Lq878U+dq9KrXyTsCPO55w13FfARR0SmmmmsTtqR
	3gdnIdh0eIBqvu1lfjW5d8ryA8LSNmhrpO4mTduTQyh2cJRrcykQgElYbVNScHnOseS2OH
	Udk/AlvfrNwk50/3I7mA1ZHYL9ZSAqDGC5cpLXrSHfRGpLVPvn9jcLIdH0OmoUtnArF1tL
	ZCxqFPeRLH9Pm8+Mg9bRlIDaIUBvRxw50x0sL4iUqJeG5OoxNg64fq+BeQFWxqMoib005a
	zLa/SDs08xS5uUfzmitg5Ymsx7CpOpGmhQ/n9flFfRBESkwmpTnzo+kce3+qOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800813;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeARu5qdgdS1dM2fNHluVEYW7CA6XC6Z01lr5OTWuYw=;
	b=pmtJQTdOgj3Em9HcJs4Ry7+JQbw5JpuoxEXiAiXU72Hl6ew9azDIGrR+eSeDITj2sBC5Xq
	hv6mz6Hxa9IRU4Dg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/intel: Fix crash in icl_update_topdown_event()
Cc: Vince Weaver <vincent.weaver@maine.edu>,
	Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org,
	#@tip-bot2.tec.linutronix.de, v6.15+@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250612143818.2889040-1-kan.liang@linux.intel.com>
References: <20250612143818.2889040-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980081261.406.7304310374946346602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b0823d5fbacb1c551d793cbfe7af24e0d1fa45ed
Gitweb:        https://git.kernel.org/tip/b0823d5fbacb1c551d793cbfe7af24e0d1fa45ed
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Jun 2025 07:38:18 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 09:38:06 +02:00

perf/x86/intel: Fix crash in icl_update_topdown_event()

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
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 741b229..c2fb729 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,7 +2826,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
 		 */
-		if (is_topdown_event(event) && !is_pebs_counter_event_group(event))
+		if (is_topdown_count(event) && !is_pebs_counter_event_group(event))
 			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();

