Return-Path: <stable+bounces-109629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EECA1810F
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 16:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6496018898BC
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FF31F4703;
	Tue, 21 Jan 2025 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eg/O4xRp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6B23A9;
	Tue, 21 Jan 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472961; cv=none; b=s4GEtm32tEZqfWt/fOU+p+k6kTRAyM2Mfzyf0kJDBKkpTATlg9Q4LCX5ftxwI/Jfi/NAQMzEVTXWDF9Z8RgSBCpi6Y+Y5GhDQq+T09iUMwsMpI8FEv21ZWoB6O8XzZv/vakfFVX6LxLC5UKrFMpTV0qliJKmL7qQ9e+faz8cW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472961; c=relaxed/simple;
	bh=ayEVt7ToU1rh5WGkoEX9FOAU1+7+Q10pEjmaIDV6fVM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2BxHBQITUPOKe9eChH6QlBBkwfaPs+PKXvv5EKovuzGqxufyRVa08ZcZ1CN0G/sCQweyw4a8U5XWiaRrQRxhfxM6YjqmDIrWPJbsuH6YtVn9hJXgstHrWROIi3jQkLW93z7jO3YRc6Eg4hW1x1AC4l6OJxPnaZ/q7PwPdZwPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eg/O4xRp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737472960; x=1769008960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ayEVt7ToU1rh5WGkoEX9FOAU1+7+Q10pEjmaIDV6fVM=;
  b=Eg/O4xRpHfrl+TkSn6FRCCXtWPk360ERbdOo0YTucu5ATUDuzDzwpqTC
   mFk/2dXNUfnu0ffBa7YN2WI4n3yW/WudLis2fXtigAzPrfrgxPSdQTpUc
   jhXY6gq7pYhsh9RddDuh1rGypTb4Tv6tXPMP3ssKNjRdBrENfOoTkK5ZV
   cXc+n1Grjzgg32idaHKUT8/4vePEVO5LqsqVcsHjnt4htRPQEa539NwzO
   FphamBomvsWc3nkQXSQZjWG54mH52vzrCl6I4F6hCRQmLZYfryBlBluoJ
   pCAhH2a+5qFx8ZUP5Rjp5aED7RYAt7CKQxHVnSdWcCa0NCZHWZzPIbcDf
   Q==;
X-CSE-ConnectionGUID: yGEPzkxDQ0qBK6ik1mseeA==
X-CSE-MsgGUID: NpUQZmFFSNalngmr+wC0tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37161451"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="37161451"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:22:38 -0800
X-CSE-ConnectionGUID: M+ssqkmNScOiKEZJ6WhveQ==
X-CSE-MsgGUID: fpAZIaqhRiCwzCsOEJZQgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111925741"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa005.jf.intel.com with ESMTP; 21 Jan 2025 07:22:38 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V10 1/4] perf/x86/intel: Apply static call for drain_pebs
Date: Tue, 21 Jan 2025 07:23:00 -0800
Message-Id: <20250121152303.3128733-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

The x86_pmu_drain_pebs static call was introduced in commit 7c9903c9bf71
("x86/perf, static_call: Optimize x86_pmu methods"), but it's not really
used to replace the old method.

Apply the static call for drain_pebs.

Fixes: 7c9903c9bf71 ("x86/perf, static_call: Optimize x86_pmu methods")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
---

New for V10

 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/ds.c   | 2 +-
 arch/x86/events/perf_event.h | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2a2824e9c50d..4daa45ae9bd2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3066,7 +3066,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
-		x86_pmu.drain_pebs(regs, &data);
+		static_call(x86_pmu_drain_pebs)(regs, &data);
 		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba74e1198328..322963b02a91 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -957,7 +957,7 @@ static inline void intel_pmu_drain_pebs_buffer(void)
 {
 	struct perf_sample_data data;
 
-	x86_pmu.drain_pebs(NULL, &data);
+	static_call(x86_pmu_drain_pebs)(NULL, &data);
 }
 
 /*
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 31c2771545a6..084e9196b458 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1107,6 +1107,7 @@ extern struct x86_pmu x86_pmu __read_mostly;
 
 DECLARE_STATIC_CALL(x86_pmu_set_period, *x86_pmu.set_period);
 DECLARE_STATIC_CALL(x86_pmu_update,     *x86_pmu.update);
+DECLARE_STATIC_CALL(x86_pmu_drain_pebs,	*x86_pmu.drain_pebs);
 
 static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
 {
-- 
2.38.1


