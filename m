Return-Path: <stable+bounces-133001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5004FA91982
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C9417622B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E622DFA0;
	Thu, 17 Apr 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDr2McNG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+jYYxnyt"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05A1E521A;
	Thu, 17 Apr 2025 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886332; cv=none; b=obAo1V0rdDgyPQXJc/6wv0hcjgsbR2RsvltyuYT/8MxfFgqYM1nSCHK030AsfhTs+N60nXekDxodxqT+3FEoCN8/jObJsfzWjrp2doakpefPf6qGJ8gSi41cI/c5MxFWia9XBDix9NgPUCf3UCWgGKRnD4YScAOzii3Eee+l04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886332; c=relaxed/simple;
	bh=A+Vb07bT6Jvf8Lo+COCMGdTzW0Hc79DetGZdU6B/nHs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xn8yDK8yolyEjcTBBS8Dnx/09dPzFL9Pc6aKMLLJPyn6O/P6h3NaLHxJLqnuAuPXX7Ie6JgwdhkTeGeozuRGoNY4Iyi/9W8KOHxVUVWlCbcw9O3pOV3erXOUetlfwLzpZ/tg8f6x5ZQ/DqH3EiEgGlHaOFt0b33pJN42lnCQQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YDr2McNG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+jYYxnyt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 10:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744886328;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cnpDee6LqNDnwZ7Yolgsx2nRPmglV/y13cY5D2NIbI=;
	b=YDr2McNGHBfXl6DPF8zVvOyXLC/WvN0KKIvcxUAvg15lw3d6zD/u6FzOoagOYkpuDYqbOw
	Uwc7j2ulPTmm75ALoWMcfFXa52+wPszrUUneQFNXrbWDTd09tkfdGJMNaCjYLYrHRw3gqd
	+bIhi0sLr3afXfCyBRo/BBzTem0sytGmTlE2qyZWQd25teh8m7RuZvExkJpa2XySmWDumi
	HZ8LOuaiL+ZLnSwSduYYQ6VxL/pXY8ZWF3olrYbgfBssWaFpehCyLbjGZRFLpN7ZuPDFwD
	MVcXu52jptCWaSldEtuL6GxYiroyOsotMf/eLAXnAZkDhfv+nRopqAujiJZNyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744886328;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cnpDee6LqNDnwZ7Yolgsx2nRPmglV/y13cY5D2NIbI=;
	b=+jYYxnytihfqZJTDLQvBB/ntePQgiEtu+pnRfaDJEWYXXVDvcWxW7C7IpC44zcDLep607N
	rhvsEXMGCYgultBQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix the scale of IIO free
 running counters on ICX
Cc: Tang Jun <dukang.tj@alibaba-inc.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416142426.3933977-2-kan.liang@linux.intel.com>
References: <20250416142426.3933977-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174488632811.31282.11062584600266249498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     33bb2d134a761cf002e0517a1cb7edd9b5431733
Gitweb:        https://git.kernel.org/tip/33bb2d134a761cf002e0517a1cb7edd9b5431733
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 16 Apr 2025 07:24:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 12:19:17 +02:00

perf/x86/intel/uncore: Fix the scale of IIO free running counters on ICX

There was a mistake in the ICX uncore spec too. The counter increments
for every 32 bytes rather than 4 bytes.

The same as SNR, there are 1 ioclk and 8 IIO bandwidth in free running
counters. Reuse the snr_uncore_iio_freerunning_events().

Fixes: 2b3b76b5ec67 ("perf/x86/intel/uncore: Add Ice Lake server uncore support")
Reported-by: Tang Jun <dukang.tj@alibaba-inc.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250416142426.3933977-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 33 +---------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 35da2c4..fb08911 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -5485,37 +5485,6 @@ static struct freerunning_counters icx_iio_freerunning[] = {
 	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
 };
 
-static struct uncore_event_desc icx_uncore_iio_freerunning_events[] = {
-	/* Free-Running IIO CLOCKS Counter */
-	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
-	/* Free-Running IIO BANDWIDTH IN Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
-	{ /* end: all zeroes */ },
-};
-
 static struct intel_uncore_type icx_uncore_iio_free_running = {
 	.name			= "iio_free_running",
 	.num_counters		= 9,
@@ -5523,7 +5492,7 @@ static struct intel_uncore_type icx_uncore_iio_free_running = {
 	.num_freerunning_types	= ICX_IIO_FREERUNNING_TYPE_MAX,
 	.freerunning		= icx_iio_freerunning,
 	.ops			= &skx_uncore_iio_freerunning_ops,
-	.event_descs		= icx_uncore_iio_freerunning_events,
+	.event_descs		= snr_uncore_iio_freerunning_events,
 	.format_group		= &skx_uncore_iio_freerunning_format_group,
 };
 

