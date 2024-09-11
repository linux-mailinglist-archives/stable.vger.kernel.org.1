Return-Path: <stable+bounces-75813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A7974F3E
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 12:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7944D2882DD
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B50117B51B;
	Wed, 11 Sep 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDH5r8Yt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFysFXLB"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85613A884;
	Wed, 11 Sep 2024 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726049213; cv=none; b=rMWVb/goqn5cn+HreEm+89nG/fK1Sb5HyxStE0GUf7Svi5Q+2f2M5J2urX5zGgUEvvS2Ilu2kpPY2bZQYTnFV+dgzwt7oPQm2aVgemW9L5stefK1eS+spDT8UpOWD8B2KArs7KgEn9uAQqOan42ykrwGBRtCw71uhduKrPCM4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726049213; c=relaxed/simple;
	bh=j7Vkpupxfk7+rTtHxoILPpzEtyYb9xsvJQ/vdmrzzd0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lWYCCZATmiNeX2/yL6h/rPXUnDXcY/lqGk90Ou9PiPxIo3GLPRRFWiqG2ZBA/3+hATCCIEXIB5ARhaFiJM4vsAy8yI8EpRqTwq5bo8ISydKEPRLfPdOPzQlD6iTybKfvHVLQnoo3EgkBfgP0R7zFwygWjgj7s2SImColbMDVTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YDH5r8Yt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFysFXLB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Sep 2024 10:06:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726049210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ3kUgGWKSQGLSixMX014dGSHDJnnNvpx2tES2cafgw=;
	b=YDH5r8YtydDRk+ayh0emZVh9cemy5RgsliL52Ll1iWmcFY+jJlE9XbCN76+E5CrFiaECGf
	3+wGWun3o8t3SOYPDiMo/R/32ya7ugbYXac0Mjjxoeo/UL35ZMhbKw5+pLRaA3lY/BnerB
	jNa2yQqsyMO6egi7wTSS6ThEIjP6cWeXa6Y1AfEWXej+uPG47RCz6MFRTNHgqZgXl7XiWk
	q66ey5/JD9bH4rNOowtEuW/hj5JEKe08Dh7vpp+N/IYluz3jBqSiOAtMi6DDnu/D9D1VTi
	8nFOO/RhhUv91Tq5vLTy6L9fFo1o8hWYhm60PVbhpfu2u4yrsl6+Nq/jzeii9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726049210;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ3kUgGWKSQGLSixMX014dGSHDJnnNvpx2tES2cafgw=;
	b=uFysFXLBxX9+Z/XY8gqqvALom4rFKYtzK52NT8frKSi6doKtIgIOLbddTYQpSyoaAeXFe1
	E7gi6GEbYIzI6eCw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Allow to setup LBR for counting
 event for BPF
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andrii Nakryiko <andrii@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240909155848.326640-1-kan.liang@linux.intel.com>
References: <20240909155848.326640-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172604920952.2215.6617498667963214270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     ef493f4b122d6b14a6de111d1acac1eab1d673b0
Gitweb:        https://git.kernel.org/tip/ef493f4b122d6b14a6de111d1acac1eab1d673b0
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 09 Sep 2024 08:58:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 12:02:23 +02:00

perf/x86/intel: Allow to setup LBR for counting event for BPF

The BPF subsystem may capture LBR data on a counting event. However, the
current implementation assumes that LBR can/should only be used with
sampling events.

For instance, retsnoop tool ([0]) makes an extensive use of this
functionality and sets up perf event as follows:

	struct perf_event_attr attr;

	memset(&attr, 0, sizeof(attr));
	attr.size = sizeof(attr);
	attr.type = PERF_TYPE_HARDWARE;
	attr.config = PERF_COUNT_HW_CPU_CYCLES;
	attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
	attr.branch_sample_type = PERF_SAMPLE_BRANCH_KERNEL;

To limit the LBR for a sampling event is to avoid unnecessary branch
stack setup for a counting event in the sample read. Because LBR is only
read in the sampling event's overflow.

Although in most cases LBR is used in sampling, there is no HW limit to
bind LBR to the sampling mode. Allow an LBR setup for a counting event
unless in the sample read mode.

Fixes: 85846b27072d ("perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag")
Closes: https://lore.kernel.org/lkml/20240905180055.1221620-1-andrii@kernel.org/
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240909155848.326640-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9e519d8..d879478 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3972,8 +3972,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
-	if (needs_branch_stack(event) && is_sampling_event(event))
-		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	if (needs_branch_stack(event)) {
+		/* Avoid branch stack setup for counting events in SAMPLE READ */
+		if (is_sampling_event(event) ||
+		    !(event->attr.sample_type & PERF_SAMPLE_READ))
+			event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+	}
 
 	if (branch_sample_counters(event)) {
 		struct perf_event *leader, *sibling;

