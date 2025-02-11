Return-Path: <stable+bounces-114930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8BBA30F2C
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE593A3E90
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76908250C0F;
	Tue, 11 Feb 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBNeLvg+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D1Os2vR1"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3426BD8C;
	Tue, 11 Feb 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286370; cv=none; b=TWWyUYMHZ36UIgFm7IzmClEDewIC+aMGmkqjaTDloc1JA1pAQ1w3W3meVqEXBhweGggGlxGlVdZjMdNyhDWBRInfl1chBIIvZLCjCH5crDEvlbFbTwrhxXxzuhlnn9qTbeLv2Loa+kqVJr+HtQXFAFyvrACITUvMRoHPFaNSXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286370; c=relaxed/simple;
	bh=Ctc36I2G+HwmYH0NsEN1NHNI4mtgY8vS6LWogAuJ5pc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CdcAmP4E4xVWbx0bxJ4ShNo0WRMXNw6MtD3v99MG9UAWXCqP5y6z0C8AHkbSOZ1S2Vhl+/MRcB1APobtB7WKnO4GTFOU232gxMgrfM4f0RrMDOvKRM5NVQKMXEZqv0UvfVqzAaVypFxGJqRw2U0djvMH6IcyblY6Ryp4AyN+K+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBNeLvg+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D1Os2vR1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Feb 2025 15:05:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739286366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XU0MPZBXA06mO+hPRk0RRhTnQO+/+tcbh8VCOkhO1T0=;
	b=pBNeLvg+H3N/dOLOh1Gls4gpNF7Yt2Iw4RQTfthNO1plKzFWp1cQPviKjj1HlWSQ0uclCo
	4EqO6WqhOockeRFhnINb0lLp/7a3y1/cB6egu8wcqROuxoP6A5Ubg8BuBoqCv+LsAePGY5
	YvMYasrsLPYBYeuC6V+iJj606QVI+LnQgZ8R0lUUbzA5MeNzZ1nszmKnPtmjCnlWK5bRLR
	6qdCd6ylB1Ev/FDKrq7tZbLU8H9wR6/UPZCdLZmcSMA+33+XZU7bPBAuEneuDs+4uEIwyv
	7vGa/kLAeQ8iaUxSeKAo1OwZ5aabDYpHBaAIbTdzteMMjgF+2R165daBEkebbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739286366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XU0MPZBXA06mO+hPRk0RRhTnQO+/+tcbh8VCOkhO1T0=;
	b=D1Os2vR1RwWuei05q7XsJPkzpCQ3GvrcfVxj4bGHlMNJLcM/kJUkzI+C1NAhbQbcPWs82x
	s/URBA+PMzExYMCQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Ensure LBRs are disabled when a
 CPU is starting
Cc: Maxim Levitsky <mlevitsk@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250131010721.470503-1-seanjc@google.com>
References: <20250131010721.470503-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173928635756.10177.2615441983621971003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     c631a2de7ae48d50434bdc205d901423f8577c65
Gitweb:        https://git.kernel.org/tip/c631a2de7ae48d50434bdc205d901423f8577c65
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 30 Jan 2025 17:07:21 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 08 Feb 2025 15:47:26 +01:00

perf/x86/intel: Ensure LBRs are disabled when a CPU is starting

Explicitly clear DEBUGCTL.LBR when a CPU is starting, prior to purging the
LBR MSRs themselves, as at least one system has been found to transfer
control to the kernel with LBRs enabled (it's unclear whether it's a BIOS
flaw or a CPU goof).  Because the kernel preserves the original DEBUGCTL,
even when toggling LBRs, leaving DEBUGCTL.LBR as is results in running
with LBRs enabled at all times.

Closes: https://lore.kernel.org/all/c9d8269bff69f6359731d758e3b1135dedd7cc61.camel@redhat.com
Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250131010721.470503-1-seanjc@google.com
---
 arch/x86/events/intel/core.c     | 5 ++++-
 arch/x86/include/asm/msr-index.h | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f3d5b71..e86333e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5042,8 +5042,11 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	init_debug_store_on_cpu(cpu);
 	/*
-	 * Deal with CPUs that don't clear their LBRs on power-up.
+	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
+	 * even boot with LBRs enabled.
 	 */
+	if (!static_cpu_has(X86_FEATURE_ARCH_LBR) && x86_pmu.lbr_nr)
+		msr_clear_bit(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR_BIT);
 	intel_pmu_lbr_reset();
 
 	cpuc->lbr_sel = NULL;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9a71880..72765b2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -395,7 +395,8 @@
 #define MSR_IA32_PASID_VALID		BIT_ULL(31)
 
 /* DEBUGCTLMSR bits (others vary by model): */
-#define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_LBR_BIT		0	     /* last branch recording */
+#define DEBUGCTLMSR_LBR			(1UL <<  DEBUGCTLMSR_LBR_BIT)
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)

