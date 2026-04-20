Return-Path: <stable+bounces-238683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNAbAXCU5WnrlgEAu9opvQ
	(envelope-from <stable+bounces-238683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:50:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE63426686
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 04:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C7C130067AC
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D9837EFE5;
	Mon, 20 Apr 2026 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzkOmSXs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A7637EFE2;
	Mon, 20 Apr 2026 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653420; cv=none; b=N0O31znXcon4PTvnnKj/3ijlMqbZs/ftgyefgEaFltx9bH8pY9witvnUrMKI07ra0BE/CkrI/da+qYRyXQ+ZByDd4tGy3kopJBD0JpfOdw3IBuKv6T9E1UET63Nb719cR0Y9z/3MbkXiiMa4v4p3OxlRKuQcp4PYzlqY3WrOtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653420; c=relaxed/simple;
	bh=kMqwokR32BTLt39tHBsnECxD5tRPyKYHB08MUi1kLvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/e/WiZ+V08A/AV5syCMhA9sw0T1qxCz34TjUvTTg8QI/K6Lp/5baON8lW4ZuC0bYXMHT13Ahs4puqKeEPqq2+035qUDRXcPyKGyDoZ7gJ9WF/ixHcyWnvs92TLzkyk9dl+sp8Vn8dbtwcqTFW+xeTFfmrPTGNG3uC5Si0tGM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzkOmSXs; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776653420; x=1808189420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kMqwokR32BTLt39tHBsnECxD5tRPyKYHB08MUi1kLvM=;
  b=gzkOmSXs+RpnyeBr3d6/Neu0UabpK+CFnEaSiys4KJ0VNRYtdOcrUIyV
   ksgvFwDvnAsmwisnc7wLuFdWz0Qv1DQll+xb+HFLbYhG0RAHzprhytpoB
   ZL5wJ0z1MdK/JBC6g9IRc23Ejm6pbRfdg6CCGEvRG0ffRmdZGl4pGjKAc
   rDFBEfvlZTll6cehBxchsVBlBdBFnBrOrmQe711itdBx8qkpMzDSW8Ia3
   b4v58AjLi2uG1MF8K8VNUHpVNkceycNb1EHeirfJ6D/+4CrsaU7mN/Sip
   F/F/eWMdJOjhYV3aBIiwbtJpqOwQr07QPlp/PwQ/bfbQWIunCzX2kHOGu
   A==;
X-CSE-ConnectionGUID: i/5GbbflTbmnQEwfA3FWsQ==
X-CSE-MsgGUID: t7ODjzkGRdaIV1EYFbQ27g==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="81442179"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="81442179"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 19:50:20 -0700
X-CSE-ConnectionGUID: OnPnkz01RcWWFnFx7baGsw==
X-CSE-MsgGUID: hdxUWPRUQnCSy0MxCu1Zmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228908019"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 19 Apr 2026 19:50:16 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
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
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	stable@vger.kernel.org
Subject: [Patch v2 3/4] perf/x86/intel: Enable auto counter reload for DMR
Date: Mon, 20 Apr 2026 10:45:27 +0800
Message-Id: <20260420024528.2130065-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
References: <20260420024528.2130065-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-238683-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 9DE63426686
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Panther cove µarch starts to support auto counter reload (ACR), but the
static_call intel_pmu_enable_acr_event() is not updated for the Panther
Cove µarch used by DMR. It leads to the auto counter reload is not
really enabled on DMR.

Update static_call intel_pmu_enable_acr_event() in intel_pmu_init_pnc().

Cc: stable@vger.kernel.org
Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V2: New patch.

 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 510b087c9e89..fa4073bf18fe 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7506,6 +7506,7 @@ static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
 	hybrid(pmu, event_constraints) = intel_pnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_pnc_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_pnc_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
-- 
2.34.1


