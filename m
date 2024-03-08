Return-Path: <stable+bounces-27152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D8876728
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA251C215D8
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 15:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB11D54D;
	Fri,  8 Mar 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EwBsVQWt"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3AA1DDEC
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911011; cv=none; b=AQRyN7JkpueH8bbpGLMSkwklHduGwHRek4UiqtH8QN3Z4bAsBGcsUdlxychJ4s0TzeXP4NBa2vJB7pwFliDnzWS3z7AsdfWvbXak/zcra+85RJmsxTJyay3veumgXCYpo9h1RDWtFSkM51PE7QSf9CS0aS67y1037VLpGpwJfhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911011; c=relaxed/simple;
	bh=M3TBwDflkS4tioem08wLQkcoO3ethpXeXv66QOk3U2M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KO6u9pqFpGDqzvcnLQr2HA7bowBRub17g0sDDQWVjYW/o2kMpgo00r8CQiKZNCn4i9KIU3FVgszl/CpQYoxEqtBVAKRaLo3AVCoOl/aN0GXsBIJYP+NdflDeoetYIdFi+8aYGVTL1io7DIQOv7HDLBxd38jM0HbsgXcfry0GDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EwBsVQWt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709911009; x=1741447009;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M3TBwDflkS4tioem08wLQkcoO3ethpXeXv66QOk3U2M=;
  b=EwBsVQWthwnhYk0pc4mP2vT8TdpAm+AmqRhDlRmY4b3o08p38l5/uPfv
   cQFiFZQxnUglbMx/l57tOfxsqzsqYL2jiT/0+DwyUcsWIaDPV3UOQsvp6
   OoOxMFOJz9nNmHkLVDKbv9bEUnxkxqN/TJjCwY5zHE7iFFpVgShSw/RYU
   /iRTe/p9gRX/4t7Q0MbLQfcTTxqPV/WSiY9FW0a/FhmFfmfKA+Qy5OLaC
   yYY452xFi6Lugwu9iPpfv2TqAi0e8fn2AGLRU6Z4q5kiZYO967S3CB0Va
   ZMKDR/vHkQXQ/uOWA0oj1AJddTmDFqc5CuWpngVGcXAS5BNH5wco6YBRR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="5233275"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="5233275"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 07:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="47948775"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa001.jf.intel.com with ESMTP; 08 Mar 2024 07:13:30 -0800
From: kan.liang@linux.intel.com
To: stable@vger.kernel.org
Cc: andrew.brown@intel.com,
	dave.hansen@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Hector Martin <marcan@marcan.st>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH stable 6.6 and 6.7 1/2] perf top: Use evsel's cpus to replace user_requested_cpus
Date: Fri,  8 Mar 2024 07:12:38 -0800
Message-Id: <20240308151239.2414774-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

[The patch set is to fix the perf top failure on all Intel hybrid
machines. Without the patch, the default perf top command is broken.

I have verified that the patches on both stable 6.6 and 6.7. They can
be applied to stable 6.6 and 6.7 tree without any modification as well.

Please consider to apply them to stable 6.6 and 6.7. Thanks]

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit 5fa695e7da4975e8d21ce49f3718d6cf00ecb75e ]

perf top errors out on a hybrid machine
 $perf top

 Error:
 The cycles:P event is not supported.

The perf top expects that the "cycles" is collected on all CPUs in the
system. But for hybrid there is no single "cycles" event which can cover
all CPUs. Perf has to split it into two cycles events, e.g.,
cpu_core/cycles/ and cpu_atom/cycles/. Each event has its own CPU mask.
If a event is opened on the unsupported CPU. The open fails. That's the
reason of the above error out.

Perf should only open the cycles event on the corresponding CPU. The
commit ef91871c960e ("perf evlist: Propagate user CPU maps intersecting
core PMU maps") intersect the requested CPU map with the CPU map of the
PMU. Use the evsel's cpus to replace user_requested_cpus.

The evlist's threads are also propagated to the evsel's threads in
__perf_evlist__propagate_maps(). For a system-wide event, perf appends
a dummy event and assign it to the evsel's threads. For a per-thread
event, the evlist's thread_map is assigned to the evsel's threads. The
same as the other tools, e.g., perf record, using the evsel's threads
when opening an event.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/ZXNnDrGKXbEELMXV@kernel.org/
Link: https://lore.kernel.org/r/20231214144612.1092028-1-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ea8c7eca5eee..cce9350177e2 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1027,8 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	evlist__for_each_entry(evlist, counter) {
 try_again:
-		if (evsel__open(counter, top->evlist->core.user_requested_cpus,
-				     top->evlist->core.threads) < 0) {
+		if (evsel__open(counter, counter->core.cpus,
+				counter->core.threads) < 0) {
 
 			/*
 			 * Specially handle overwrite fall back.
-- 
2.34.1


