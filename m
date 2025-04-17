Return-Path: <stable+bounces-133024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B8A91A12
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C555619E4DA6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61922356CC;
	Thu, 17 Apr 2025 11:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LYMjsHgV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sUXvyNUi"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785E282F5;
	Thu, 17 Apr 2025 11:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888150; cv=none; b=pRFLkk8BDpoFsHNu4bvLmZN9QPLogw9jio8MpFkrgADhGlOWOJybbMesI26JR2F4/j+MgscfHq7th0UjR4k1jwGdVV8xvOuI1R5iv25Vnyu1T+Dz0vz6ig3HE6lAvT2gCs2c+pew9lBENhRO654k0YFD/0LJ8S+MTaDA8tLhhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888150; c=relaxed/simple;
	bh=DMRPs6Pg9YVDPOXdyTSZNoTtok8ps/JAKSlHPeisvoM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=STD8sNGcnKWVWoIYCT5Krf0eI/75TLCqRnl0LZEYzW9bYY7Eu7e3B/eHXi+LSFrF9MkRHPF7e8ISY8XF5Vvg5+0CP+LL6Zl9QUBmbe0yMUkMKMtM/kAZOtLuXzM3kvpDL0sFn5Qv9OTw7URKmN2a8IfQ+q7tPIn33RebnHq16S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LYMjsHgV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sUXvyNUi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 11:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744888147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9xAsHwuZuHioxK7TNKzzVFd35a3MwUcAAl7xcFNIpc=;
	b=LYMjsHgVfW9n+1M9o7SRzYWrcEScFC4KoJ8GEGZHaxEZbh82cufLBPKbU/YmJZdasb4OJ1
	W7KYzSnxLzO18EJAq3f1TKDt2azSk0u7LGEu/q+S6NSuNVgzDlH48nBxugZZtcKVWRCEKt
	rzzjAGwAEyHdoCCQK6Bkpmhm6RTeBE2YG9XKjAR3CBy54NljwJ9+ST+AhsSqvEj7ck5D30
	GdU3QsShU1fEQlg0tLrgYq2AosI6e/uGsOz1lXbVyHgQqgV/0WvqWshAGse7CPx7NRXRa9
	lWbzCk3SwcPh1KLxT/jydRzzQFhCFArbAnf0fW01dEXWvFpsLMAqpPCjc5+PJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744888147;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h9xAsHwuZuHioxK7TNKzzVFd35a3MwUcAAl7xcFNIpc=;
	b=sUXvyNUiyyhQ4yc0+aCtbdoV/jHToZu8+NhbJkgJI/iCKgh3iHOVR7WU05hPsprnQ99+RW
	aWXFAeBh/rZd8oCQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix the scale of IIO free
 running counters on SPR
Cc: Tang Jun <dukang.tj@alibaba-inc.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416142426.3933977-3-kan.liang@linux.intel.com>
References: <20250416142426.3933977-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174488814342.31282.6685848537217689272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     506f981ab40f0b03a11a640cfd77f48b09aff330
Gitweb:        https://git.kernel.org/tip/506f981ab40f0b03a11a640cfd77f48b09aff330
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 16 Apr 2025 07:24:26 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 12:57:32 +02:00

perf/x86/intel/uncore: Fix the scale of IIO free running counters on SPR

The scale of IIO bandwidth in free running counters is inherited from
the ICX. The counter increments for every 32 bytes rather than 4 bytes.

The IIO bandwidth out free running counters don't increment with a
consistent size. The increment depends on the requested size. It's
impossible to find a fixed increment. Remove it from the event_descs.

Fixes: 0378c93a92e2 ("perf/x86/intel/uncore: Support IIO free-running counters on Sapphire Rapids server")
Reported-by: Tang Jun <dukang.tj@alibaba-inc.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250416142426.3933977-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 58 +---------------------------
 1 file changed, 1 insertion(+), 57 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index fb08911..76d96df 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6289,69 +6289,13 @@ static struct freerunning_counters spr_iio_freerunning[] = {
 	[SPR_IIO_MSR_BW_OUT]	= { 0x3808, 0x1, 0x10, 8, 48 },
 };
 
-static struct uncore_event_desc spr_uncore_iio_freerunning_events[] = {
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
-	/* Free-Running IIO BANDWIDTH OUT Counters */
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0,		"event=0xff,umask=0x30"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1,		"event=0xff,umask=0x31"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2,		"event=0xff,umask=0x32"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3,		"event=0xff,umask=0x33"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port4,		"event=0xff,umask=0x34"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port4.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port4.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port5,		"event=0xff,umask=0x35"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port5.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port5.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port6,		"event=0xff,umask=0x36"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port6.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port6.unit,	"MiB"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port7,		"event=0xff,umask=0x37"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port7.scale,	"3.814697266e-6"),
-	INTEL_UNCORE_EVENT_DESC(bw_out_port7.unit,	"MiB"),
-	{ /* end: all zeroes */ },
-};
-
 static struct intel_uncore_type spr_uncore_iio_free_running = {
 	.name			= "iio_free_running",
 	.num_counters		= 17,
 	.num_freerunning_types	= SPR_IIO_FREERUNNING_TYPE_MAX,
 	.freerunning		= spr_iio_freerunning,
 	.ops			= &skx_uncore_iio_freerunning_ops,
-	.event_descs		= spr_uncore_iio_freerunning_events,
+	.event_descs		= snr_uncore_iio_freerunning_events,
 	.format_group		= &skx_uncore_iio_freerunning_format_group,
 };
 

