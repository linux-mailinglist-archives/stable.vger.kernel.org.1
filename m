Return-Path: <stable+bounces-119517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC9A4426A
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72A2188B2F9
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8802526AAAF;
	Tue, 25 Feb 2025 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da6o9sl2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZLfZjqr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D522676C8;
	Tue, 25 Feb 2025 14:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492902; cv=none; b=oPGR+IvNsS1/B5e+2tTjKJubiQ+wohXxEF5iwA4Uz1okeLBelFZprXgT9/EczCJ4tQOxSwTRNbro/QTxN8tHhIjm+RAZVRSTTh3Iuw6Gji/rnn4YqUT+ucbnXyHtTETHl7e7mZwO5hEUHEZx8wKnNEiJq5D83t7D2YFIRkyHLTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492902; c=relaxed/simple;
	bh=U6uSAkBhDRyvz4gQn4eBLXEUrDlYjPr0AusvC2OdAso=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f4dCsrwzxRUIh9lmr4PPePEKva9nMdKmFEguGccs/kIP5E0BRv3Z5GUhYTGF1Hjdh4LHISDPauwbFwVC+s1LMaW8NUrG1CJDKoTVjICKXjQo6DGuf2az4WvInu+jFs/LlhuKoDVNoWmCwkKQI4uisPn6gxA4PgvCuM+pJKoE10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=da6o9sl2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZLfZjqr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 14:14:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740492898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqVAaX7M9nwvgTr5mda3FCROeOawpH0KvMcmbiZ6Vus=;
	b=da6o9sl2Pr9dVZBu/SBxrBIEBjWJC8Zym1ScsrbJ0C46w/CkNDZOpL5JkEg9QOIYAo4PRs
	I+BFOBV6u4/HqS07wchsPJfLEKtLZJH+ncxDdZ03LVsqAb+OtVFkkmpChzFhGI6YJ1Phf7
	pijl3nfNjIsHMSjFBDUsSX7lg0N9wpWwTtMyVKQ2Z8Uil0q9Mm0lmsAO9St7nC/MQRSvai
	weLH/BvC8ngCoTv42O3nPZD/KFgmkp2MDSba9tKrylrslvL+acGpsCQ37j7Y2lDcuiU8/o
	semBOfYhg0OYQ7F1Oe5zFF9ZRtV8EtBPAiTWSai1rWZusjs7B5xvelR476+0pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740492898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqVAaX7M9nwvgTr5mda3FCROeOawpH0KvMcmbiZ6Vus=;
	b=aZLfZjqrLxgycNsnH7tkY9vWaUZtDj+Ht8p2G3OIiWcsa/N3Po3yqml2b/5EsZ7rYXwwUF
	nIK/r9Egxx7/GUBQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86: Fix low freqency setting issue
Cc: Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250117151913.3043942-1-kan.liang@linux.intel.com>
References: <20250117151913.3043942-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174049289790.10177.11456494248824677937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     88ec7eedbbd21cad38707620ad6c48a4e9a87c18
Gitweb:        https://git.kernel.org/tip/88ec7eedbbd21cad38707620ad6c48a4e9a87c18
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Jan 2025 07:19:11 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 14:54:14 +01:00

perf/x86: Fix low freqency setting issue

Perf doesn't work at low frequencies:

  $ perf record -e cpu_core/instructions/ppp -F 120
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument)
  for event (cpu_core/instructions/ppp).
  "dmesg | grep -i perf" may provide additional information.

The limit_period() check avoids a low sampling period on a counter. It
doesn't intend to limit the frequency.

The check in the x86_pmu_hw_config() should be limited to non-freq mode.
The attr.sample_period and attr.sample_freq are union. The
attr.sample_period should not be used to indicate the frequency mode.

Fixes: c46e665f0377 ("perf/x86: Add INST_RETIRED.ALL workarounds")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250117151913.3043942-1-kan.liang@linux.intel.com
Closes: https://lore.kernel.org/lkml/20250115154949.3147-1-ravi.bangoria@amd.com/
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f218ac..2092d61 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -628,7 +628,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (event->attr.sample_period && x86_pmu.limit_period) {
+	if (!event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)

