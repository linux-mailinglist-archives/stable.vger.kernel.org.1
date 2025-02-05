Return-Path: <stable+bounces-112286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3B9A286BB
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 10:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40FEC3A71BA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FA22A7EE;
	Wed,  5 Feb 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVRmGewf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N9y5W3z3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EB922A7E2;
	Wed,  5 Feb 2025 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748333; cv=none; b=LPw5uS/mzWmW/3KwmJxUSp4MMR/a0GdRavzZS/KATvhGC0SmRFZBV00zhWRGN/4sPiBLUHu9GeUt7zJHdU6EmHT7fvA1cnc086vimX46QTEM25GsvOozwYWu3Dhp+3/mFE56X1dN9xuASCCTbVRjk/tiWrl6/DRNCrwFsUY9+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748333; c=relaxed/simple;
	bh=oM49LPTzNbzwxr6L5ZCoPGGccLykOkBrsMAJFibVO04=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q2vxYkUjsgDcQl6Ipuiyu/dO9a/HEn1HdkF4eizC46CXTBoUUvdfLXgeyQutH/VJT5Z2CJVswiT5wa65i+pwvjdgdpHJRM/NhdJDWu7iUv+jHAX7FTyqsbYNkkrvXqQ+Nj5/0UKtSNooDLvet6T6d7CdOdWDrkTHqA/TqvbI1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVRmGewf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N9y5W3z3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 09:38:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738748330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=de6jziJA6PRo+qhBsB3buPX6qFnZhRwpH02yDDgUFyM=;
	b=zVRmGewfKSCrZL9dE5heIgOFe2FMwE4QtI8Eb++bCAJX32uCAEN8A+L2Ftxb3BYbi11CTm
	OrNkyXdfDwsC49zOv613NY9Ipa6Hs6IqNDBS1YNwfZAmCYPowhDEMldQ06FZR9bf6Tt+OU
	WfcEE8QXGNNQ2AEvrEcSRyN9A3KOYzOQfRbGNPZ5w0GM435xLjuXaM/wZrvAICXhbRrem1
	mzlOHvl47yufSHKKv7d719diKFL7WWYO/uVAip7vxNnqnUBTjPcaL/yBuUNhrZG3GZSrL5
	omPEGoYcTs6ynVnuQ66AsgqGs0k89j6K1T52e4AsZD5dm2ruvTB/+8jtmfx0Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738748330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=de6jziJA6PRo+qhBsB3buPX6qFnZhRwpH02yDDgUFyM=;
	b=N9y5W3z3sgSt7/0aLsr2PA96V77dh8P3ah2CNMX/61EaWLvcKj/1uJnqq5hB3NopSIIAhr
	Sc+KS+xBQvVgsWAQ==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Apply static call for drain_pebs
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250121152303.3128733-1-kan.liang@linux.intel.com>
References: <20250121152303.3128733-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173874832985.10177.15853906267073116548.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     314dfe10576912e1d786b13c5d4eee8c51b63caa
Gitweb:        https://git.kernel.org/tip/314dfe10576912e1d786b13c5d4eee8c51b63caa
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 21 Jan 2025 07:23:00 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Feb 2025 10:29:45 +01:00

perf/x86/intel: Apply static call for drain_pebs

The x86_pmu_drain_pebs static call was introduced in commit 7c9903c9bf71
("x86/perf, static_call: Optimize x86_pmu methods"), but it's not really
used to replace the old method.

Apply the static call for drain_pebs.

Fixes: 7c9903c9bf71 ("x86/perf, static_call: Optimize x86_pmu methods")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250121152303.3128733-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/ds.c   | 2 +-
 arch/x86/events/perf_event.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7601196..2acea83 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3076,7 +3076,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
-		x86_pmu.drain_pebs(regs, &data);
+		static_call(x86_pmu_drain_pebs)(regs, &data);
 		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba74e11..322963b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -957,7 +957,7 @@ static inline void intel_pmu_drain_pebs_buffer(void)
 {
 	struct perf_sample_data data;
 
-	x86_pmu.drain_pebs(NULL, &data);
+	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 31c2771..084e919 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1107,6 +1107,7 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
+DECLARE_STATIC_CALL(x86_pmu_drain_pebs,	*x86_pmu.drain_pebs);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {

