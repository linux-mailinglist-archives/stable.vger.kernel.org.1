Return-Path: <stable+bounces-241270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IuOKkkn72lE8AAAu9opvQ
	(envelope-from <stable+bounces-241270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:07:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34046F8EF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3A773054F59
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3F3ACEE2;
	Mon, 27 Apr 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOnddLmi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686893ACA6A;
	Mon, 27 Apr 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280425; cv=none; b=E1SJyHo9fgENJc2M3V8k+ZKz1jQFq/4G5bPvkZNZktt1IdZ5Wo9Bz1o6k+Uhsd0ZqMasESZjyfM8eFZoZxPjJBH+M/vFtNjn+t/WOfnq1lNGNTCTxnUcdoEwcgGNasdtoiwnWCBy4demFdfUsI5zwi2oxtaIUGtV99siMW/0SS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280425; c=relaxed/simple;
	bh=p11m1qkgDiZhbp7WCgA/lTdQ6yP2okCMD8NKm+Lhho8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2ZCXhdnVwRCYXg+xCLEc5wSiOkSiqJuw7xGL4lyHhvv4oa8MedrItVCac1HdIyg4tu795ZPqNm7SeZlDaPCPxqxFGtYSQiN9TedF2Mt1Ha12BxiStNVNDG+qnNJB7nrSPhsaeVgFO+Nw0R1AYLXI746DWmiljvpT6qO+dySJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOnddLmi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777280425; x=1808816425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p11m1qkgDiZhbp7WCgA/lTdQ6yP2okCMD8NKm+Lhho8=;
  b=mOnddLmi/8Ieqzo4IvhW320ZkCUEy1qg1e81FeIp3jQtOJTYCs5oD7Xi
   9tTZgrOu/ZcFMcBOCaThCrnIFqZ5niVhGhz7zkJdkgpHDI6kop4b4g8nl
   /Jge72mFyHtcOXTr4mA+XmeT2YjiKT/w8MnIIMDKjgve8q2cRh6ZXN5gP
   sLi2mIt+jTfvM4NlLAC37CCa8mO2xxbNyfMaSYz+6zE4KOBV+kwMn1cPH
   8wT9R7Lob2o1Ba/9NvS4g3FxitAVIJ/avCR1z6kg2LYaMn8DXXeULVg6a
   Ldo2ZAnp4obj9e9iIbmEyTzwy6+2jQnPg/7lU+cY5DDYxWzc3+YGMluZy
   Q==;
X-CSE-ConnectionGUID: 9IXb9OfWRdiDfhLhol+3Sw==
X-CSE-MsgGUID: ZWPYmgu3SrG4s6phSSskOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88476349"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88476349"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:00:25 -0700
X-CSE-ConnectionGUID: iPoYK+znQwKbu543zfQM7A==
X-CSE-MsgGUID: G34I9i8PQVSpwCxE9kEhLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233850645"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 02:00:21 -0700
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
Subject: [Patch v3 3/4] perf/x86/intel: Enable auto counter reload for DMR
Date: Mon, 27 Apr 2026 16:55:12 +0800
Message-Id: <20260427085513.3728672-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
References: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C34046F8EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dapeng1.mi@linux.intel.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241270-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+]

Panther cove µarch starts to support auto counter reload (ACR), but the
static_call intel_pmu_enable_acr_event() is not updated for the Panther
Cove µarch used by DMR. It leads to the auto counter reload is not
really enabled on DMR.

Update static_call intel_pmu_enable_acr_event() in intel_pmu_init_pnc().

Cc: stable@vger.kernel.org
Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c1841fa89908..60568a9ce06b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7518,6 +7518,7 @@ static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
 	hybrid(pmu, event_constraints) = intel_pnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_pnc_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_pnc_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
-- 
2.34.1


