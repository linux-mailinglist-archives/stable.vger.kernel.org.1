Return-Path: <stable+bounces-245359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLszKNxiAmposAEAu9opvQ
	(envelope-from <stable+bounces-245359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:14:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94A517340
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 01:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8671B300B9DD
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD921364E81;
	Mon, 11 May 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcl5bjXO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0C1356777;
	Mon, 11 May 2026 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541248; cv=none; b=iCoQa7FT/OPvxHLP9ZmrRT6YtZpVNbp8qdKxupDrdHCPihjJdOK+mhH3D9AVUrUA83WKf0lgiVTHtE2XVRgydWY9rOkU2l2cQbwdanrVl4E18bMjPj+WJAMec2NMnnJmwwN12rxS2TE9ZUd8pJlaQ20vOh00czSBXWDfgVFHAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541248; c=relaxed/simple;
	bh=fFM7lla6UGM3h5hfEvNbwtOwJxgnMMIR4e6uQcmG0cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fN6E/lQ2/x9MzIfucHGQ8Clt6+AbWi/smEzD2AqEhpGw5WunDXnnAyAr0CwHQrFjYMXheClBm25KD3f5DXC0WRkooc+RnJJdfu9W97GyCNCfbqSdWReFz96ZVVKZxfHf9sFZOIJOdxNv/H0BAtzy3vWHdCrbNdfZK/d9MIYZmd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcl5bjXO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778541246; x=1810077246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fFM7lla6UGM3h5hfEvNbwtOwJxgnMMIR4e6uQcmG0cs=;
  b=gcl5bjXOIKXpvW+iH7wGqEmmhDE8i8pflB9sVp18PZujiT4AXvbplAT0
   hSB/BgzoxHVIyAYBIKoTyD/VfisQywccrV7Nvr4fMeHpZcBfwnA6zCYVJ
   MnhewoGhIJuRT51d7Tlu7UIcAp34hUV0w4hwRA+hE6jjTWeHwsGx/kf1l
   8Gl2fq7b2zSlZvtjctKtoBRd3IvbkUwwZBslsbDMgMjJ8fD0XuWk/zjsy
   DOdVLol6cBQ1aKM5GEjBGUXN/hg00g6z8rDr1zT4mNuNHlqvYGEbmRE1z
   FsYvvJWaVBr0znz34h5AoyaO6geed6Kbtx6ucZ9IS098bkPPP397HbZAY
   w==;
X-CSE-ConnectionGUID: maiwrhjkSfOvr3+85VYS5A==
X-CSE-MsgGUID: HxOrX3yvSaWIG3KxSS7f4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83058112"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="83058112"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
X-CSE-ConnectionGUID: u8a1BpfCT92oXCGW9M3sZg==
X-CSE-MsgGUID: GsKpFoiJQICmPNyc2giBOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="267944463"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:14:06 -0700
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/6] perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()
Date: Mon, 11 May 2026 16:05:24 -0700
Message-ID: <20260511230527.26096-4-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511230527.26096-1-zide.chen@intel.com>
References: <20260511230527.26096-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD94A517340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245359-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zide.chen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
may increase power consumption even when no perf events are in use.

Drop adl_uncore_msr_init_box() and defer programming the global control
register to enable_box(), so it is only set when a box is actually used.

Cc: stable@vger.kernel.org
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3dbc6bacbd9d..edddd4f9ab5f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box = rkl_uncore_msr_init_box;
 }
 
-static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->pmu_idx == 0)
-		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
-}
-
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
@@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_box *box)
 }
 
 static struct intel_uncore_ops adl_uncore_msr_ops = {
-	.init_box	= adl_uncore_msr_init_box,
 	.enable_box	= adl_uncore_msr_enable_box,
 	.disable_box	= adl_uncore_msr_disable_box,
 	.exit_box	= adl_uncore_msr_exit_box,
-- 
2.54.0


