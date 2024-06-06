Return-Path: <stable+bounces-49916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2B78FF43E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 20:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3914AB28438
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D61993A6;
	Thu,  6 Jun 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZzKpqVD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F5199246;
	Thu,  6 Jun 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697074; cv=none; b=s1xuDjB5HIxbDN1EyiE1rG0uOYUz0cb6MudJmFNw1X3cjw7fgrz/Wh05l/eK03w8STofF+F3cz4RhX0UYJpJlbLhcrnJN+L9t8btM9vilRH5b6m4CzbQKYsim81q5PBcESr1NYfrG9CE4k1BgkSxaOUpR4Bi6Ph1J0hR7rkO95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697074; c=relaxed/simple;
	bh=N7urc3PGrVRVyhlP4ECO2cQhX6mwjAHqaA+2X4Nkxno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cUud3b8UpAzB7VmB+jFF0kRQt2sroz2hs9RvpqyHEVcTG6TncUR2cYTPm4jCMqIf8LUjLM7toTvJpZ1uwYrPqGEJuZRS7Lpju/LKry+EFejf22ajLPY1bBMpWSiNnwdvBRDbmkLpNI+TaiXH+YMW1rhHtnHEQy41avnPF81kVNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZzKpqVD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717697073; x=1749233073;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N7urc3PGrVRVyhlP4ECO2cQhX6mwjAHqaA+2X4Nkxno=;
  b=mZzKpqVDKEietPZXO0iIp42rsdp1TSRgTuAlzSeG9CQYlv9NyM0S3Ag0
   ywCQ92CS3D6TJkP8a3897Ec72D1af3VUDw3Kf29KEvr8jrC8OucHRbD4X
   KjN0gK68QGqW9iGEI/5X/dt88wDEnqr1N2imPzo6erBMy9INMLnaktW6Z
   g2JTLQvVAQeMXrvLZzdTv66hMgbs786OSaiaPU5vIdpIqYo9+prBRp3XZ
   1gYFWnKyJU+vhqV6Mn4C6g+C8iDgZhwHOhYUMH2/TZD4433D6eGJ4wV+P
   3FnA3KqmFaofTeWVMJ+q3Fc50vNEGBmpOb21k4fcBi6HdzDM+Mf8Sjah0
   w==;
X-CSE-ConnectionGUID: xf/xh1ygRbSJ4DanRJfXXw==
X-CSE-MsgGUID: nJT56psGSaOIP6QEeT/t1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="31883375"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="31883375"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 11:04:32 -0700
X-CSE-ConnectionGUID: 7+a/ImkFSuKYq4D81JiMGA==
X-CSE-MsgGUID: fLEw+7VUQS+oeVZ2UqNCIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38170025"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa009.fm.intel.com with ESMTP; 06 Jun 2024 11:04:31 -0700
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
Subject: [PATCH V2] perf stat: Fix the hard-coded metrics calculation on the hybrid
Date: Thu,  6 Jun 2024 11:03:16 -0700
Message-Id: <20240606180316.4122904-1-kan.liang@linux.intel.com>
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

In the hard-coded metrics, the events from a different PMU are only
SW_CPU_CLOCK and SW_TASK_CLOCK. They both have the stat type,
STAT_NSECS. Except the SW CLOCK events, check the PMU type as well.

Fixes: 0a57b910807a ("perf stat: Use counts rather than saved_value")
Reported-by: "Khalil, Amiri" <amiri.khalil@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---

Changes since V1:
- Don't check the PMU of the SW CLOCK events 

 tools/perf/util/stat-shadow.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..6bb975e46de3 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -176,6 +176,13 @@ static double find_stat(const struct evsel *evsel, int aggr_idx, enum stat_type
 		if (type != evsel__stat_type(cur))
 			continue;
 
+		/*
+		 * Except the SW CLOCK events,
+		 * ignore if not the PMU we're looking for.
+		 */
+		if ((type != STAT_NSECS) && (evsel->pmu != cur->pmu))
+			continue;
+
 		aggr = &cur->stats->aggr[aggr_idx];
 		if (type == STAT_NSECS)
 			return aggr->counts.val;
-- 
2.35.1


