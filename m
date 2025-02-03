Return-Path: <stable+bounces-112020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C9A259B5
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 13:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D561641E3
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 12:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4F22046B8;
	Mon,  3 Feb 2025 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FxRcT2TZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANzjv8hN"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE822040A6;
	Mon,  3 Feb 2025 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586901; cv=none; b=gPWwdGxhOphP/YN0FDoYgwVxYtNLGkC3d9UeyKGJKrbmzYW1YAy6yT3OFRVg1lMo+8KqhEkzkPWHAYrZQkdHnWpGhkJHjaibDFUaP1SfxL7AZdutr145gRV0EFiEE1tYLqCCAr2Q/vRJ/4eiAeN+J/3BLLcgMnhXBpYSbLuRwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586901; c=relaxed/simple;
	bh=9YrQ17kwWyOKvCaZ9JpyOUMd9iYdID2XBfm93uNpbNo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=peUXoBeCY7PNFKM5O2SRdql6udvXyP219Z7/K/f/3THc9JZLpEZTqM4r6t8mNfzWiZKm2SEppD127C9W1C1rQo9mx2ePfp322uyj9o4BcFERzUev+ZNI8OOceXkDVaqlm7vxfiyYSljBjd94ixFxVsUZToVLEOSJyiY8wj1xkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FxRcT2TZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANzjv8hN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIDaTTsAm7CQB91SN8/ZLSbDOeRxLUcmSQbFR3tOwQg=;
	b=FxRcT2TZ+jD2as6WPKzMdXXMPKh13lbMbdzYmDZ+QjZhM4s5d8ENDmc4+VyeVa4Fclcw/B
	M+E/Y78gYL2HxZFmC/i9D8Q/rWNMt+DIEkWmW5a36cjhihJxhKXH6PyR02WoWZ73Qw3LN0
	71JqP1NhnbpdAc1Sq1DYXoi96b0GXolM0SoVRVLDiWuwglo6Hx2QXkqrZtrAO2+50t4zgA
	usVS9t1M6XeiQ3Hz0TXcGxQaGNNdV+llXk0PxLRkYbAXvDMBxz7JiTPDvMRxWG1wvJzV0T
	LXqouS2b+QUtH0gMmFUttgbQvwuUT2C+h6PpH0KOSLgbM+RmhlAP3levqIl24w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIDaTTsAm7CQB91SN8/ZLSbDOeRxLUcmSQbFR3tOwQg=;
	b=ANzjv8hNK5d459RlXNdjXPxwaebI1uO1a7QmjzMole/IGWIy20dTvofH5ei+hKH5EiOlO2
	F0KymiXaPKwaoMDA==
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
Message-ID: <173858689667.10177.14581139399834679001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da6e8c7a252bb0bbad53f1e6993460e17d891652
Gitweb:        https://git.kernel.org/tip/da6e8c7a252bb0bbad53f1e6993460e17d891652
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 21 Jan 2025 07:23:00 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:07 +01:00

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

