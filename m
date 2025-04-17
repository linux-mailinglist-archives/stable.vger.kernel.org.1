Return-Path: <stable+bounces-133025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BFCA91A16
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7690B5A00BC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE3D2356DF;
	Thu, 17 Apr 2025 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2oECC+Ok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qGBs5Rxg"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25031282F5;
	Thu, 17 Apr 2025 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888159; cv=none; b=KN5xeFD3l2SL7iWuydZvQKU8Jqt0DgTt6ZkBIepy33V67CYwKtzHes8suFl5+yXN9npIABgxpoWvrF4qkksA6C2OFgCsO2sOl/oqP3GGA38JreUrVMi25w5HWcvi82j/Z0WrecNUfQVPEH3d1qb7U+hpOvKnQF/MH9hzc6BUXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888159; c=relaxed/simple;
	bh=569Vl79qE9wxBCgdTtnVWyUSAIMktPNuoFwl7F2vJOU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MAblx+EN/KC3DWbIxXRFYjttqvGuOHJPlAa0V0d2EwEUqt6MYuxifvU1i+igPizKA+IEbwFEC5jmbY88M9GlXL2slevhoRGOEvfARzJAOo25DsxO7XbPe/SA5Oq4CVrFau2Sxt7+kH20TZRXzZuanjKQaJbG6K5xK8+su2IS6Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2oECC+Ok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qGBs5Rxg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 11:09:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744888156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzArZZa9Qxkr/GWJ2jSL4BIuKleIDz7osPoXYKOSEmk=;
	b=2oECC+OkhZVKiGd4quuLnSGCcZlwxggcY0f3F8kdzD5UKVp6RG4XdP1WDvlejccXqxRVId
	ET2kWPeKglamDp0jRiKaZhprWCYZep/+XjlSKuAI2sJBeWW+lOCe4sUZEvHOujq98lljps
	FRzPDDWotbJ3VrVmFTmyuGTmOgsLM7a6IGTae/PnLztH0AiYd8FslTflu0KBWlW/jmBFwo
	+TuTRhq3O3mMu6d6pCOcgUhVJzr7p/nK7aGfctoJtH+kpy6Ut03yY8EBBFPfh/VK9+LMZY
	I6NRpONTGUvttO5K9NCbDlYRIB7Mvm/amBIPVNpGEO2bgTWo2wn4zcXlu9dt4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744888156;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GzArZZa9Qxkr/GWJ2jSL4BIuKleIDz7osPoXYKOSEmk=;
	b=qGBs5Rxg20bS9YMG7kk362D+k5rfI2zjy/EnFYCdUF/NuA8WVS8WKuRXBNFYME+PQwwC68
	elXx0ahvJCh+YPAw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix the scale of IIO free
 running counters on SNR
Cc: Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416142426.3933977-1-kan.liang@linux.intel.com>
References: <20250416142426.3933977-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174488815597.31282.9087365988248723967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     96a720db59ab330c8562b2437153faa45dac705f
Gitweb:        https://git.kernel.org/tip/96a720db59ab330c8562b2437153faa45dac705f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 16 Apr 2025 07:24:24 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 12:57:20 +02:00

perf/x86/intel/uncore: Fix the scale of IIO free running counters on SNR

There was a mistake in the SNR uncore spec. The counter increments for
every 32 bytes of data sent from the IO agent to the SOC, not 4 bytes
which was documented in the spec.

The event list has been updated:

  "EventName": "UNC_IIO_BANDWIDTH_IN.PART0_FREERUN",
  "BriefDescription": "Free running counter that increments for every 32
		       bytes of data sent from the IO agent to the SOC",

Update the scale of the IIO bandwidth in free running counters as well.

Fixes: 210cc5f9db7a ("perf/x86/intel/uncore: Add uncore support for Snow Ridge server")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250416142426.3933977-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 60973c2..35da2c4 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4891,28 +4891,28 @@ static struct uncore_event_desc snr_uncore_iio_freerunning_events[] = {
 	INTEL_UNCORE_EVENT_DESC(ioclk,			"event=0xff,umask=0x10"),
 	/* Free-Running IIO BANDWIDTH IN Counters */
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0,		"event=0xff,umask=0x20"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1,		"event=0xff,umask=0x21"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2,		"event=0xff,umask=0x22"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3,		"event=0xff,umask=0x23"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4,		"event=0xff,umask=0x24"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port4.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port4.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5,		"event=0xff,umask=0x25"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port5.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port5.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6,		"event=0xff,umask=0x26"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port6.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port6.unit,	"MiB"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7,		"event=0xff,umask=0x27"),
-	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.814697266e-6"),
+	INTEL_UNCORE_EVENT_DESC(bw_in_port7.scale,	"3.0517578125e-5"),
 	INTEL_UNCORE_EVENT_DESC(bw_in_port7.unit,	"MiB"),
 	{ /* end: all zeroes */ },
 };

