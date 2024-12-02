Return-Path: <stable+bounces-95991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B899E0007
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35663161A50
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D4205ADA;
	Mon,  2 Dec 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uh2HY9XM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMKV6CkM"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4D2040AF;
	Mon,  2 Dec 2024 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138067; cv=none; b=N7UbhRhss5AHsWAe2IQRnls7QKjHP+881OroH6WrGwO3WbLocpYbDmfwVUbPt1wjTC7uhNejl0uD0FnkpU5+ZYVvTfs247GqiNgMDOSlw1N8+dgJb/PjWajmJ9/MaBJE3FEEC5wE0/fHdxCPIJYLu8tHNAc0jVgNCukzAYSKjn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138067; c=relaxed/simple;
	bh=Fcs4TBsLg7vaUcCabys4iZIu6dXFo662hFb/nqSCx7M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R0MWwQ7gPUFxCM51QlwpaVV45PB8gpkas/i8eUR/zx9Ldt9RyRme+R4GTi6AYfw9pQTa1d6ovlyvIKeD9qkLxQffqLClg9e+iAK+20OU0Zg3ssTjZkqDScOxnJ3qi6S3wnPSNAYtFTfhEYH41wUoPPiB8U0JnQx9QfCPLuVcgKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uh2HY9XM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMKV6CkM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awY3/8mLcs7Xs0cc/ojP3N7Xfe1gJWU4sOT+e24CkyM=;
	b=Uh2HY9XMFtqEreOzCM7gV2HsnRLGKLM3RzrudSvhv+UYXni/74SCVqtYpJ03IUe7SorGdb
	QIaBuKnmzIC5P6bi+UPOY+H36H0x+bpKtWM15pQ1nV+OoDdKcXkoeD6DtomJKQGqA8RuxN
	+Lk3sNJitCmyUaeg8okY/wfNtE3fGDMDgWRItNmeavLEbZ2WarHWm+yLWHOifSm5HaR3yl
	O6XVWKQ4EbssEprt8/1EUVpDKzwmbozXP7vi5/dSEtv3JTFUeYWHvtia45fg03Ye5Iyo28
	NTn6rmcMsHq4Ev9UN01VcHe0PySLj3gzkKAvEEhRKsV7zw0Zi61j+cmEOfrfSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awY3/8mLcs7Xs0cc/ojP3N7Xfe1gJWU4sOT+e24CkyM=;
	b=SMKV6CkMaqCBW0ryQnm5R/1CqYwhbPL4CtUr+ePWyt188xKSf75sz1cQ+vTbI7wWWKKyEn
	OlZA8sfUO8bpTpDQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Unconditionally drain PEBS DS
 when changing PEBS_DATA_CFG
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241119135504.1463839-2-kan.liang@linux.intel.com>
References: <20241119135504.1463839-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313806215.412.18103414401551662348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9f3de72a0c37005f897d69e4bdd59c25b8898447
Gitweb:        https://git.kernel.org/tip/9f3de72a0c37005f897d69e4bdd59c25b8898447
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 19 Nov 2024 05:55:01 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:33 +01:00

perf/x86/intel/ds: Unconditionally drain PEBS DS when changing PEBS_DATA_CFG

The PEBS kernel warnings can still be observed with the below case.

when the below commands are running in parallel for a while.

  while true;
  do
	perf record --no-buildid -a --intr-regs=AX  \
		    -e cpu/event=0xd0,umask=0x81/pp \
		    -c 10003 -o /dev/null ./triad;
  done &

  while true;
  do
	perf record -e 'cpu/mem-loads,ldlat=3/uP' -W -d -- ./dtlb
  done

The commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
PEBS_DATA_CFG") intends to flush the entire PEBS buffer before the
hardware is reprogrammed. However, it fails in the above case.

The first perf command utilizes the large PEBS, while the second perf
command only utilizes a single PEBS. When the second perf event is
added, only the n_pebs++. The intel_pmu_pebs_enable() is invoked after
intel_pmu_pebs_add(). So the cpuc->n_pebs == cpuc->n_large_pebs check in
the intel_pmu_drain_large_pebs() fails. The PEBS DS is not flushed.
The new PEBS event should not be taken into account when flushing the
existing PEBS DS.

The check is unnecessary here. Before the hardware is reprogrammed, all
the stale records must be drained unconditionally.

For single PEBS or PEBS-vi-pt, the DS must be empty. The drain_pebs()
can handle the empty case. There is no harm to unconditionally drain the
PEBS DS.

Fixes: b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing PEBS_DATA_CFG")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20241119135504.1463839-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8afc4ad..1a4b326 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1489,7 +1489,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 			 * hence we need to drain when changing said
 			 * size.
 			 */
-			intel_pmu_drain_large_pebs(cpuc);
+			intel_pmu_drain_pebs_buffer();
 			adaptive_pebs_record_size_update();
 			wrmsrl(MSR_PEBS_DATA_CFG, pebs_data_cfg);
 			cpuc->active_pebs_data_cfg = pebs_data_cfg;

