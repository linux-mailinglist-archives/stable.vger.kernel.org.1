Return-Path: <stable+bounces-119516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06362A44258
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71B017601E
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8AA26A084;
	Tue, 25 Feb 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SO/IXozv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rHj85Edp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5275B26981F;
	Tue, 25 Feb 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492901; cv=none; b=JSq3KL/W9nXN5i2BiONACJJGPJFJLlQuxjAQk3Jfa/boIj7iXuDX0RZtR5JGoI5qsM4ShT9LLzothag5O8B1az2RNuyzm5CaxIhQkU5MSv4zlYHbEOX6stLBdQcwHOD9qACRQArRToWMG7aZ2fQBfiN7WRSBnioVWxRaTgWycks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492901; c=relaxed/simple;
	bh=+4sOTnaI32gMkpbK4Vc4mkjXdozIuu22YMJvCGL12gk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QyGnhCVTbl8Yxxh8JufbM74ziN3REA6BG8IfGigjUoqQScy3qyMQmxyfl28VvPllzyxdQrrP62PbnQ2v9DURpdP8oRUYm8lD/tdMJVktYA3OpEaGbNbDxPEh+ito3W1QVs4FEwfK0Ym59e7M1gn9F1UXqobQtKnn/P0pU9WaJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SO/IXozv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rHj85Edp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 14:14:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740492897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlVBUYBwZpW8JMX4dMGaTAmNpH8sM3M7GOc48qsT1LI=;
	b=SO/IXozvwZhN3mRcVqQw3E/ehzRh1yQDCLcMOhFxs5xwH80dH2nE5E+PgWOkOxS+qJ1xjL
	3kTfH4A1IJXfPwXBYzA5DIFsxBeTvvjWjuH96xCSsLM4/beEw0HDx+BTnURQx+EPyLrHO/
	AJPZfHD8P7OHcGpy/heXr25esuXriHnsnf2VK54rQhjRgjgC3zgKG8p1LnxyQA1xJffTiV
	ps/GSSu5UM/KuThlLZt9vS9H+2diDO+tPuHrRQYgLB4B9XwkKuLm7ploreP6VQtPQRUPDN
	HPxWs8UzKL5WGFtplgzuPjvjIsAhYFjQSGoZ9XemTVkefTU0r990t9xVoHFyTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740492897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlVBUYBwZpW8JMX4dMGaTAmNpH8sM3M7GOc48qsT1LI=;
	b=rHj85Edpt1NJhLOQHSImVCYZTwJCHuLzknZCZexgf1aRBf355qIo/1wNLZ3KaLNGg0/meW
	3EeHwrjVnLmCGQAA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix low freq setting via IOC_PERIOD
Cc: Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Peter Zijlstra <peterz@infradead.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250117151913.3043942-2-kan.liang@linux.intel.com>
References: <20250117151913.3043942-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174049289699.10177.3800796469110076364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0d39844150546fa1415127c5fbae26db64070dd3
Gitweb:        https://git.kernel.org/tip/0d39844150546fa1415127c5fbae26db64070dd3
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Jan 2025 07:19:12 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 14:54:14 +01:00

perf/core: Fix low freq setting via IOC_PERIOD

A low attr::freq value cannot be set via IOC_PERIOD on some platforms.

The perf_event_check_period() introduced in:

  81ec3f3c4c4d ("perf/x86: Add check_period PMU callback")

was intended to check the period, rather than the frequency.
A low frequency may be mistakenly rejected by limit_period().

Fix it.

Fixes: 81ec3f3c4c4d ("perf/x86: Add check_period PMU callback")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250117151913.3043942-2-kan.liang@linux.intel.com
Closes: https://lore.kernel.org/lkml/20250115154949.3147-1-ravi.bangoria@amd.com/
---
 kernel/events/core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 086d46d..6364319 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5969,14 +5969,15 @@ static int _perf_event_period(struct perf_event *event, u64 value)
 	if (!value)
 		return -EINVAL;
 
-	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
-		return -EINVAL;
-
-	if (perf_event_check_period(event, value))
-		return -EINVAL;
-
-	if (!event->attr.freq && (value & (1ULL << 63)))
-		return -EINVAL;
+	if (event->attr.freq) {
+		if (value > sysctl_perf_event_sample_rate)
+			return -EINVAL;
+	} else {
+		if (perf_event_check_period(event, value))
+			return -EINVAL;
+		if (value & (1ULL << 63))
+			return -EINVAL;
+	}
 
 	event_function_call(event, __perf_event_period, &value);
 

