Return-Path: <stable+bounces-48234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C95A8FD281
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 18:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652E21C23820
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 16:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96AD14E2CA;
	Wed,  5 Jun 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RvwX/4Si"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABE27450;
	Wed,  5 Jun 2024 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603821; cv=none; b=Ks7Z7GN+UQ1FUqoX9cnJ7tTA6UuJb7ljmbtOIVeI8RmbxQ3DLcZXOOLYhMV1mKKdjILcDiskEPDwawLEMpl6/HiBb/rVqPSKeMC+P9LmDuGVrkICPyh+0ucKDHCpUBVXgYFJibg7WSh8isXbQQrs44oWrjTcIkjWtQpD3a49ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603821; c=relaxed/simple;
	bh=3klxGnG3GkyhrDKSmcnlThuDuIl/9pv+mo2n6zzAz+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FXXblESjcOO6Q7pTqJgneNvxGokUEJG1/aJ/bauFtPqfNdqzphNp7H3J9oK1p0Idd+votHPGJZyFvtu5MGNiS+5DKyncfdHljOzP1sPB1WT3BY5uoemUa3W0jb+wvZ30xSqM/lR4E9hxIPTKUi8Z/Q53zdfAKsodqC5D6lJ4ccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RvwX/4Si; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717603820; x=1749139820;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3klxGnG3GkyhrDKSmcnlThuDuIl/9pv+mo2n6zzAz+o=;
  b=RvwX/4Si+wYPxv9mzyj/ZkLyOvwOL+Wo3fpj49FcGY0UdqR52WiQcAem
   NVSf6a3JlyVVxOm4WZ7KhVjwm/FcnhQzo/iQD69TUWO0mYQlxkHbrjAwd
   r2m717NAAc4SkemvLzK7oWfras5Tr/jUYqq26Ia3qv72ZOdoVbGhMFQF4
   QpgfsHZVrT5kwt73IWM1mEVvFdF3/pXE0+LlY+IMxNT//l6cuG7J3gh5b
   S25I3ZNVvhUW162ZVmmT6kDccGk8gASVlgw2puZZSUQAaIlbDqQVYevrQ
   Dcl1CfpDCqij3GROs0HxlOEZhSxoZfyDoNSg6MtWfiTS1rrIiQRG+0oZW
   g==;
X-CSE-ConnectionGUID: XXmzOSDpSMWr8JYqkntMMg==
X-CSE-MsgGUID: +X2XEUlVTe6UC1VhwRlGRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25633485"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="25633485"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:10:03 -0700
X-CSE-ConnectionGUID: KMwrIFJPSKubjbNif9H/mg==
X-CSE-MsgGUID: EyQtD6qpQxGjOaC/hL9sVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="38300791"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 05 Jun 2024 09:10:03 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kan Liang <kan.liang@linux.intel.com>,
	"Khalil, Amiri" <amiri.khalil@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] perf stat: Fix the hard-coded metrics calculation on the hybrid
Date: Wed,  5 Jun 2024 09:08:48 -0700
Message-Id: <20240605160848.4116061-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The hard-coded metrics is wrongly calculated on the hybrid machine.

$ perf stat -e cycles,instructions -a sleep 1

 Performance counter stats for 'system wide':

        18,205,487      cpu_atom/cycles/
         9,733,603      cpu_core/cycles/
         9,423,111      cpu_atom/instructions/     #  0.52  insn per cycle
         4,268,965      cpu_core/instructions/     #  0.23  insn per cycle

The insn per cycle for cpu_core should be 4,268,965 / 9,733,603 = 0.44.

When finding the metric events, the find_stat() doesn't take the PMU
type into account. The cpu_atom/cycles/ is wrongly used to calculate
the IPC of the cpu_core.

Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 tools/perf/util/stat-shadow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..4d0edc061f1a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -176,6 +176,10 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 		if (type != evsel__stat_type(cur))
 			continue;
 
+		/* Ignore if not the PMU we're looking for. */
+		if (evsel->pmu != cur->pmu)
+			continue;
+
 		aggr = &cur->stats->aggr[aggr_idx];
 		if (type == STAT_NSECS)
 			return aggr->counts.val;
-- 
2.35.1


