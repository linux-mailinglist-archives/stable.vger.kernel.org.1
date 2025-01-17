Return-Path: <stable+bounces-109393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92121A152A6
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB423AE72C
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A381531C0;
	Fri, 17 Jan 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KVXTx8bR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E22B9B9;
	Fri, 17 Jan 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127133; cv=none; b=cfIunX8b6xj/SuRdFuU5bs3wkb+ygeRMYfio5HcS0u/gxtlC2cCF4sA0KjoaY2H396mw21j7HQQZ+Fea+0JeRAYtW0Vsko10oGf+1NQMZY2sJufotcGCBWZFgXiKsUhLmo21m3wPCBm3YiFkHkMgxJ//loqUqVZ0MXsV619DImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127133; c=relaxed/simple;
	bh=47Bn9D94VvHLczml3kGYJHvJOn141p8dJMneHeCvff0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rgckEYsxxjqCPjKR803p8MNU+oEkVvD+eW/8NRIUhaW4RnvlRfzO3mjA9LpUJP+2FZVjLPbuZ6yKWDxfsAklCFnsmasZch+Zg61/dmD5d2EJ/rUk0IwQttGzzCsXzeUZZM6MiyPvCTYJCCf2fP7RtdbPLE1RNyJ0zIIsxGAv/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KVXTx8bR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737127132; x=1768663132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=47Bn9D94VvHLczml3kGYJHvJOn141p8dJMneHeCvff0=;
  b=KVXTx8bRjRgeIcooaFWkrUHFIQEiLUM3SLuNfo2dyKvCpdTr1Kdh0o+A
   IVwImPf144lYnKCdM10Pv0ossa+Q/TjFX++wDx5xHd+EN3y9wsX36/ZTw
   bJO+2RHmLtJ/RkfDrkBsy/t54YKAYStXuvSAn4JicXKG5fs4mtM3TBKYV
   XIOcHP//5FNMxV2H3bnERX7A58uJO7KDnh3239b1nrQp6IEu1rMeFdE7y
   ulmiMP5Jh2DpkMh4RLb4/7ipQElucoUTv0jdATVwh+q2dJP+4dHroZwoN
   4ekLyOnf8aI4xXaNnk/AtDMGvX007TRrkfKLpxwjeg+6Yrvk6nKIwgT2n
   Q==;
X-CSE-ConnectionGUID: pMXgGm+9TKeI8P+zWbG8dQ==
X-CSE-MsgGUID: R2RTI8o0Rz2QWEciCNbvaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37798344"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37798344"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 07:18:51 -0800
X-CSE-ConnectionGUID: XSXsfn1pQ0u4TyraChtyqA==
X-CSE-MsgGUID: ouBrs4J+SAuf2dLeEzXS+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106292022"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 17 Jan 2025 07:18:51 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	ravi.bangoria@amd.com,
	jolsa@redhat.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] perf/x86: Fix low freq setting issue
Date: Fri, 17 Jan 2025 07:19:11 -0800
Message-Id: <20250117151913.3043942-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Perf doesn't work with a low freq.

perf record -e cpu_core/instructions/ppp -F 120
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cpu_core/instructions/ppp).
"dmesg | grep -i perf" may provide additional information.

The limit_period() check avoids a low sampling period on a counter. It
doesn't intend to limit the frequency.
The check in the x86_pmu_hw_config() should be limited to non-freq mode.
The attr.sample_period and attr.sample_freq are union. The
attr.sample_period should not be used to indicate the freq mode.

Fixes: c46e665f0377 ("perf/x86: Add INST_RETIRED.ALL workarounds")
Closes: https://lore.kernel.org/lkml/20250115154949.3147-1-ravi.bangoria@amd.com/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b6430e5a77b..20ad5cca6ad2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -630,7 +630,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (event->attr.type == event->pmu->type)
 		event->hw.config |= x86_pmu_get_event_config(event);
 
-	if (event->attr.sample_period && x86_pmu.limit_period) {
+	if (!event->attr.freq && x86_pmu.limit_period) {
 		s64 left = event->attr.sample_period;
 		x86_pmu.limit_period(event, &left);
 		if (left > event->attr.sample_period)
-- 
2.38.1


