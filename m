Return-Path: <stable+bounces-118634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2129DA3FF97
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 20:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DC43BE0FD
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 19:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C17252916;
	Fri, 21 Feb 2025 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRtcJACA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Vj/MPO0"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFCF25290F;
	Fri, 21 Feb 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165564; cv=none; b=SQycYhyatcvCOYg6gSLViwjWQaYvTEvmG63QnKunsuryWo48UCSdhZoJ47MkQAiHS1V4a5i5SvS13owxdoewJSYo7l03JKIuHHtEYUjuZkow1yQJ7k88pX/l2ACIrvfw06/ypypDMcKGP52S29CS0tV8EfkSIUPZXr/GvZQhxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165564; c=relaxed/simple;
	bh=zxmsWUgNWZNFgsvJHAhCYpf+ENmRHkY81EjWL4vEQGM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GUaYwF7DyOiJynjcyCimdEb/ixaZNAfClJ4PHCQbzmVc6m53/aKav95stwEHTd3lMBoaJ2hvxGFNmnyPWmYsPvyScbeUFeTio+sHJgEA6xR37SoNexdukCVh7O0G4DfBxuycTwMgWMqjZzhOHcFK0tflKMW4jyVP11Q8EYG1T+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRtcJACA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Vj/MPO0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 19:19:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740165560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxsITrpGY7G/KPdxKChAGRdgrO7clA1QnRdJzmj1QB0=;
	b=vRtcJACAh5yLwFHxpTnmkDxxgcef1LgOs49n7dL4XXJXgEDPUYa0Y4qDO/PbGIoDKTwitO
	1dc8bAaGmkLIuk/78tQmwzXSkeecZv7SJLH9tFPdPIXK9Icagcsrvd+tesTK+PbP/ZxIhr
	sKbLzOgmiDAOl3wVRvTMI0DURxVZ4FnF53smH8zy69KtDI8JTqoSdoVay3ZGNpctZb7Q0h
	WMhP9/IB+Cjc+wCn2ZLixVC/cgXnywhFz6wcnWUZEfDV4zNpXecW8oUVl7GJ+6DQiNfn72
	a3qzzr3XC4U71MkCPUsKfjpfNqx4RNw8yaAbWzVR20SxKKtIKn6UOXpM6D928A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740165560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxsITrpGY7G/KPdxKChAGRdgrO7clA1QnRdJzmj1QB0=;
	b=9Vj/MPO0A+Mn5muwxrnjAhZ9KdZt3v0OJtP0/YS5hKp7Zry0REZxDjs7EceW999WsROGvQ
	yZyAeBwZNuXo7eCQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix event constraints for LNC
Cc: Amiri Khalil <amiri.khalil@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250219141005.2446823-1-kan.liang@linux.intel.com>
References: <20250219141005.2446823-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174016555617.10177.644960926822500092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     782cffeec9ad96daa64ffb2d527b2a052fb02552
Gitweb:        https://git.kernel.org/tip/782cffeec9ad96daa64ffb2d527b2a052fb02552
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 19 Feb 2025 06:10:05 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Feb 2025 16:07:10 +01:00

perf/x86/intel: Fix event constraints for LNC

According to the latest event list, update the event constraint tables
for Lion Cove core.

The general rule (the event codes < 0x90 are restricted to counters
0-3.) has been removed. There is no restriction for most of the
performance monitoring events.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Reported-by: Amiri Khalil <amiri.khalil@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250219141005.2446823-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 20 +++++++-------------
 arch/x86/events/intel/ds.c   |  2 +-
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e86333e..cdcebf3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -397,34 +397,28 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
 
+	INTEL_EVENT_CONSTRAINT(0x20, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x012a, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x012b, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x0175, 0x4),
 
 	INTEL_EVENT_CONSTRAINT(0x2e, 0x3ff),
 	INTEL_EVENT_CONSTRAINT(0x3c, 0x3ff),
-	/*
-	 * Generally event codes < 0x90 are restricted to counters 0-3.
-	 * The 0x2E and 0x3C are exception, which has no restriction.
-	 */
-	INTEL_EVENT_CONSTRAINT_RANGE(0x01, 0x8f, 0xf),
 
-	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
-	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x08a3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x01cd, 0x3fc),
 	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
-	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
 
 	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
-	/*
-	 * Generally event codes >= 0x90 are likely to have no restrictions.
-	 * The exception are defined as above.
-	 */
-	INTEL_EVENT_CONSTRAINT_RANGE(0x90, 0xfe, 0x3ff),
+
+	INTEL_UEVENT_CONSTRAINT(0x00e0, 0xf),
 
 	EVENT_CONSTRAINT_END
 };
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c2e2eae..f122882 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1199,7 +1199,7 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
-	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3ff),
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */

