Return-Path: <stable+bounces-58731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C292B887
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565BD1C21BBD
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07215884A;
	Tue,  9 Jul 2024 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X3btMmIP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j2BGF8vI"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA148158202;
	Tue,  9 Jul 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525319; cv=none; b=TO98l21Akg6auAjBBqCrXCEp2xOJJKn0FkJati4ImnpdJU0pvqTdF1Is1xJVmOQ3JHvvuhb0sEmVIoxCzzcosRSf3udiul9Eejpnm9/NovPVQFKRh/cAaK9QLf4k3k9TaHR+Eu6udWAlO0449iCCMY6/j4ywZtGv1awDhX0oo9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525319; c=relaxed/simple;
	bh=1764vrQOyFf+W8/zcN2ULspPhlu0+SDEuGDSHQRcW1o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DR4sdh5kShiPo2qBSaHDROF0pzVvw/gwjwd+82uAUk1s6kui4KmrNLgEVtwN3GBZisghZZ7rbc+fXOz6aaFzBb9qJu5HAi5+EavvruPM52FJu/GbtNiCiNjzxNba/JF7iwdHfm2PNTR9U9/ajgU2J4JgOLs0Ez6gAvYUjpuoq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X3btMmIP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j2BGF8vI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Jul 2024 11:41:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720525316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU5FkUAsWlcZKXWxEwHv/MhW/ib6aXTvhCd4AJUPA8k=;
	b=X3btMmIP3ROnr/LRF4AeSBs892FIACcxgC9ZCues5UcmTwBcGj8PDXQ07aDpKl0D5QzKmv
	HFML2qrctSDY8AQsmIDa2rPDGzt4E3jDmHFUSl9GGt7lqunPbJKsaiYDrxrDrX7TJ9n+Dh
	+cvNUxnglOwFDF5shM5Re86YoGdNFkU1/YnK0L9zY2cVmcxiFKf7jbrk41ThCWsjqqFm9X
	mtPrL13o4sj3IAQHYqyvPmBpWy7RWhEW1hc4FzIT5Oq9+1WpDEjFhwAEXjc6O6nEimX3cg
	8Xag92M0UHx+10Lrt7+T0n0rhoXl4S6fWVvo6pVdEOenhlxWHpDl1Dx/QGS6Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720525316;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eU5FkUAsWlcZKXWxEwHv/MhW/ib6aXTvhCd4AJUPA8k=;
	b=j2BGF8vIdUgSg4X64Res3pS0wlDFLrynRglFUfchIdX6EHBtEobStyrh/1naMs6d7Kkldq
	7sVICh5wFgb2htDg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Add a distinct name for Granite Rapids
Cc: Ahmad Yasin <ahmad.yasin@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240708193336.1192217-3-kan.liang@linux.intel.com>
References: <20240708193336.1192217-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172052531554.2215.6640350424955122434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fa0c1c9d283b37fdb7fc1dcccbb88fc8f48a4aa4
Gitweb:        https://git.kernel.org/tip/fa0c1c9d283b37fdb7fc1dcccbb88fc8f48=
a4aa4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 08 Jul 2024 12:33:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Jul 2024 13:26:39 +02:00

perf/x86/intel: Add a distinct name for Granite Rapids

Currently, the Sapphire Rapids and Granite Rapids share the same PMU
name, sapphire_rapids. Because from the kernel=E2=80=99s perspective, GNR is
similar to SPR. The only key difference is that they support different
extra MSRs. The code path and the PMU name are shared.

However, from end users' perspective, they are quite different. Besides
the extra MSRs, GNR has a newer PEBS format, supports Retire Latency,
supports new CPUID enumeration architecture, doesn't required the
load-latency AUX event, has additional TMA Level 1 Architectural Events,
etc. The differences can be enumerated by CPUID or the PERF_CAPABILITIES
MSR. They weren't reflected in the model-specific kernel setup.
But it is worth to have a distinct PMU name for GNR.

Fixes: a6742cb90b56 ("perf/x86/intel: Fix the FRONTEND encoding on GNR and MT=
L")
Suggested-by: Ahmad Yasin <ahmad.yasin@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240708193336.1192217-3-kan.liang@linux.inte=
l.com
---
 arch/x86/events/intel/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b613679..0c9c270 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6943,12 +6943,18 @@ __init int intel_pmu_init(void)
 	case INTEL_EMERALDRAPIDS_X:
 		x86_pmu.flags |=3D PMU_FL_MEM_LOADS_AUX;
 		x86_pmu.extra_regs =3D intel_glc_extra_regs;
-		fallthrough;
+		pr_cont("Sapphire Rapids events, ");
+		name =3D "sapphire_rapids";
+		goto glc_common;
+
 	case INTEL_GRANITERAPIDS_X:
 	case INTEL_GRANITERAPIDS_D:
+		x86_pmu.extra_regs =3D intel_rwc_extra_regs;
+		pr_cont("Granite Rapids events, ");
+		name =3D "granite_rapids";
+
+	glc_common:
 		intel_pmu_init_glc(NULL);
-		if (!x86_pmu.extra_regs)
-			x86_pmu.extra_regs =3D intel_rwc_extra_regs;
 		x86_pmu.pebs_ept =3D 1;
 		x86_pmu.hw_config =3D hsw_hw_config;
 		x86_pmu.get_event_constraints =3D glc_get_event_constraints;
@@ -6959,8 +6965,6 @@ __init int intel_pmu_init(void)
 		td_attr =3D glc_td_events_attrs;
 		tsx_attr =3D glc_tsx_events_attrs;
 		intel_pmu_pebs_data_source_skl(true);
-		pr_cont("Sapphire Rapids events, ");
-		name =3D "sapphire_rapids";
 		break;
=20
 	case INTEL_ALDERLAKE:

