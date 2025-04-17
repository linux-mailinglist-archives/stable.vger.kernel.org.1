Return-Path: <stable+bounces-133026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D6A91A19
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957AA16D487
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0F210F49;
	Thu, 17 Apr 2025 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ac+USeBo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7GgLwFD"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866762356D5;
	Thu, 17 Apr 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888161; cv=none; b=FkGSNTsRWkKjjnlyMzbS0IUmYHM/F80rT8DEnbcdCl0eCDfzMffHYhiZsolQ1KVcNtIzIJxTsyj5OYJALQSN9l/EtRL0YUjx6f/788mXtdZQbdpLfqlXmFnoRKMIHek/KDbS9q5ismyIEz+sPE1TA4wcO3q65/q/J4gIyG1DwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888161; c=relaxed/simple;
	bh=5puMHPm5a87fNjffOm8TjQVllFKlg74x4C4TnBsj+9k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HTxb5rvfNVwCqWkvP6kZXCkMq/BawpLAyXVuAr9w9zb/Mq3CTP5QSyMrhYDb5j1oYkiBfd9EVxqUSEs3kKOZWBTKJmswXMBG/814+iviNmGR0fFtUwk1TfIujCqe6G93cYNKi1PiZNhnqLNfVi56glebe28ZJ9HoslupbYoyL7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ac+USeBo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7GgLwFD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 11:09:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744888155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZJmgyGvl6ED8aSpl3ziueshC5NWU/gz94EhblpQ+ak=;
	b=Ac+USeBo95sxL6H7vwwAcEvSB6Y70iRuZg41NTS9ISMgo+3ufWfZv6hd+yxjMzF2smk1aS
	rimQiYcGmmWLGfkamOSFnY4l3VEkYGGsVNzt1ZK2fo/S4lGPnoQqc7Ne+zTrpzzq43D4/q
	K1zOaL9jWTYLganDYRIHC5fbbGb/RwYlaFCCdq9me4G2i5bVZpbCYqj2KUqP3fLw2ZMerl
	ErZyx6FwSV2po7qypYWQOi6j7oZFMHEdk7leIcRp/E4EMNm6SXISJbSxZ3R5sciR0wMWPM
	YpQj3bn2xnxDZN86uMkoSOXc9c17deGVri1Xu9CbgjR/YmmDHHkvKwj3Zn0Rqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744888155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZJmgyGvl6ED8aSpl3ziueshC5NWU/gz94EhblpQ+ak=;
	b=O7GgLwFDsvbHej4UHNOwIqJZWTq4yMGNu2oKfn1/zN9sM2Cnj/DsaJGnUxhCo8L5aGF3Yv
	drrc6RiQlaUkBPCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix the scale of IIO free
 running counters on ICX
Cc: Tang Jun <dukang.tj@alibaba-inc.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416142426.3933977-2-kan.liang@linux.intel.com>
References: <20250416142426.3933977-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174488814713.31282.14629333098136448405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     32c7f1150225694d95a51110a93be25db03bb5db
Gitweb:        https://git.kernel.org/tip/32c7f1150225694d95a51110a93be25db03bb5db
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 16 Apr 2025 07:24:25 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 12:57:29 +02:00

perf/x86/intel/uncore: Fix the scale of IIO free running counters on ICX

There was a mistake in the ICX uncore spec too. The counter increments
for every 32 bytes rather than 4 bytes.

The same as SNR, there are 1 ioclk and 8 IIO bandwidth in free running
counters. Reuse the snr_uncore_iio_freerunning_events().

Fixes: 2b3b76b5ec67 ("perf/x86/intel/uncore: Add Ice Lake server uncore support")
Reported-by: Tang Jun <dukang.tj@alibaba-inc.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
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
 

