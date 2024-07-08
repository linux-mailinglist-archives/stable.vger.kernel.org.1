Return-Path: <stable+bounces-58252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5094492A9DD
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 21:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1248B21EE2
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3014EC40;
	Mon,  8 Jul 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OCJG12EX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C3C14900C;
	Mon,  8 Jul 2024 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467168; cv=none; b=sN8kTPLPj/eS9Xp7Fc3Tcj2X4RfJeG1n2iG9tjORaD936VpWKYJ85FbW2ZnAkw0WBTlUaHCVggvQdW6bSDKo7TowDLEGNbh61Sw4GRJdg6NwqqpivvOS5VlhLWMLoStqS7m7EyDuxuHLQYAKVhPIA2WPP3xMVwCkmERcQoK7zvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467168; c=relaxed/simple;
	bh=PQRWnOx82i3fG2doBPseySJto3zDK3NV4Mn8e9GyrTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkDpp3E/6bGhMTOt4dG4rovUQKvcpBpfYoJ/JfNUMb3aXkPtztR4AoeztUnBa+pP37+XQkE9L2ky7nNZ6TvvdbYcSbSupq5Q59FS9+jF1qexnjQMTKnMKgKprcnGvtapScCuGUuKmZ1ZJu+D7Rk1gkPftncTq1uObXsJCF4a1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OCJG12EX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720467166; x=1752003166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQRWnOx82i3fG2doBPseySJto3zDK3NV4Mn8e9GyrTY=;
  b=OCJG12EX5DwJd+SSDwV/7QWN8uUNzKdAA8BJuz3Y5ZLPtqlpMmD0ZQR2
   88KEHflkFHz+yAaRO53c41BjpBBUxpy8FUXdECMQYhbR3uteusWLgkz3R
   eAUks8223hJ3zAmoKPgtqEo9ZAUfPQ89e9tQmUT7Hnw8X8ah46JtNoeM7
   HAzVh8qYbXDwef9GxKtBrF+9JnjUp4C4nGiT3UimUWPxeteyEXaWboHfh
   m27duOLj1I7mkGvRhilpO78OwIWkLlylSa2nkmimNUbmjYkKdAshWTW1n
   WNQCOOONSz+44EJp9EN5oMlpt5QHxV6SlKtbCnxB5RO6y+pAJI1PLWlJI
   w==;
X-CSE-ConnectionGUID: MXhKG6/iT9a9ZUweaPEI5A==
X-CSE-MsgGUID: aT+sJGZwQs+D14kctfAd9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17520497"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17520497"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 12:32:42 -0700
X-CSE-ConnectionGUID: TRnwzIJdTVOWbRO8PJilvg==
X-CSE-MsgGUID: aK+CzMhgQU2ZUlCUsjL8ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="48265602"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa007.jf.intel.com with ESMTP; 08 Jul 2024 12:32:42 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@kernel.org,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	"Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] perf/x86/intel/ds: Fix non 0 retire latency on Raptorlake
Date: Mon,  8 Jul 2024 12:33:36 -0700
Message-Id: <20240708193336.1192217-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240708193336.1192217-1-kan.liang@linux.intel.com>
References: <20240708193336.1192217-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

A non-0 retire latency can be observed on a Raptorlake which doesn't
support the retire latency feature.
By design, the retire latency shares the PERF_SAMPLE_WEIGHT_STRUCT
sample type with other types of latency. That could avoid adding too
many different sample types to support all kinds of latency. For the
machine which doesn't support some kind of latency, 0 should be
returned.

Perf doesn’t clear/init all the fields of a sample data for the sake
of performance. It expects the later perf_{prepare,output}_sample() to
update the uninitialized field. However, the current implementation
doesn't touch the field of the retire latency if the feature is not
supported. The memory garbage is dumped into the perf data.

Clear the retire latency if the feature is not supported.

Fixes: c87a31093c70 ("perf/x86: Support Retire Latency")
Reported-by: "Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>
Tested-by: "Bayduraev, Alexey V" <alexey.v.bayduraev@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/intel/ds.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b9cc520b2942..fa5ea65de0d0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1944,8 +1944,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	set_linear_ip(regs, basic->ip);
 	regs->flags = PERF_EFLAGS_EXACT;
 
-	if ((sample_type & PERF_SAMPLE_WEIGHT_STRUCT) && (x86_pmu.flags & PMU_FL_RETIRE_LATENCY))
-		data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+	if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		if (x86_pmu.flags & PMU_FL_RETIRE_LATENCY)
+			data->weight.var3_w = format_size >> PEBS_RETIRE_LATENCY_OFFSET & PEBS_LATENCY_MASK;
+		else
+			data->weight.var3_w = 0;
+	}
 
 	/*
 	 * The record for MEMINFO is in front of GP
-- 
2.38.1


