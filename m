Return-Path: <stable+bounces-109394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF00A152A7
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59DF16B78C
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B72193067;
	Fri, 17 Jan 2025 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKRKDEgc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421B14884C;
	Fri, 17 Jan 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127135; cv=none; b=BDu5CqcKJqx3fnECiybemJpR20+H9q9FsJD/LcA9MJwAo1fcj3MRem0LQGVgJGX+qnjGZdfvfh/LFzyOlhV33zPBeUz68/4UogvCjKsvxHZwcMCXx7B2/nEgINmGI4azNi/7AajysuN3KSzgs7MFJ+xrGX54N6hiqbOewOo2PDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127135; c=relaxed/simple;
	bh=ccZPE7fqhciJeBEtguK8eWJ8wR1KZE2kbEW/4xZB99Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWNcJeyaVXdyx1n0OH7zNRQZKRNTSBZs8Zw+H7nNdjgaTJB2RkYovndv/OeoPNS4eXk/Zbn9kHb1/jcY20r4hNTMrXJC3ylBhuSo1K5I/jPPa95N5goqbJFiYJfb1kmR3ciengY5VF/kxoKGxgBqIoiRzuLuJRlplF+2LrWr+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKRKDEgc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737127134; x=1768663134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccZPE7fqhciJeBEtguK8eWJ8wR1KZE2kbEW/4xZB99Y=;
  b=iKRKDEgc0oYTor5yFB6FhB1LmDP2qlpfAqjfqM9z8qzkPyWI3KVYS3qT
   JwyB7ukjQuL/h/d3pEQalNxD91yPsUmCQxtx+lG3Ejz8nz2ebqDzoZFDp
   N55Q9qT1BGlW3QfsTN4DtqNq+S4KiUFiuo2HFtNAdtsWXJXTbFG+Ai+X4
   9XRbQkdibX5o+sIshnhfUzGiYKbUHtZ4hN04QrXRV2pONlrUU1KRRVIVt
   kZTq54BqEcOa/07mn+4AFQigDKkxxkjU3RXpJftzeyWAYidTkvT7fwWok
   kDGVO7RHCsO4qvXhUAP8IZn36eekMclOeYzsjnObH1p5EPSy8VltH+l5Y
   Q==;
X-CSE-ConnectionGUID: I0J2ZhJhS2yQ0lFFHNKxLg==
X-CSE-MsgGUID: CgYmS2ktSsyjN3o6QHCyYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="37798351"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="37798351"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 07:18:51 -0800
X-CSE-ConnectionGUID: oW9l30i0SlaY7wgr04LkVw==
X-CSE-MsgGUID: gD5WkwFJQYq4N1oL+LpqkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106292023"
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
Subject: [PATCH 2/3] perf: Fix low freq setting via IOC_PERIOD
Date: Fri, 17 Jan 2025 07:19:12 -0800
Message-Id: <20250117151913.3043942-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250117151913.3043942-1-kan.liang@linux.intel.com>
References: <20250117151913.3043942-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

A low freq cannot be set via IOC_PERIOD on some platforms.

The perf_event_check_period() introduced in commit 81ec3f3c4c4d
("perf/x86: Add check_period PMU callback") intended to check the
period, rather than the freq. A low freq may be mistakenly rejected by
the limit_period().

Fixes: 81ec3f3c4c4d ("perf/x86: Add check_period PMU callback")
Closes: https://lore.kernel.org/lkml/20250115154949.3147-1-ravi.bangoria@amd.com/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: stable@vger.kernel.org
---
 kernel/events/core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f91ba29048ce..a9a04d4f3619 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5960,14 +5960,15 @@ static int _perf_event_period(struct perf_event *event, u64 value)
 	if (!value)
 		return -EINVAL;
 
-	if (event->attr.freq && value > sysctl_perf_event_sample_rate)
-		return -EINVAL;
-
-	if (perf_event_check_period(event, value))
-		return -EINVAL;
-
-	if (!event->attr.freq && (value & (1ULL << 63)))
-		return -EINVAL;
+	if (event->attr.freq) {
+		if (value > sysctl_perf_event_sample_rate)
+			return -EINVAL;
+	} else {
+		if (perf_event_check_period(event, value))
+			return -EINVAL;
+		if (value & (1ULL << 63))
+			return -EINVAL;
+	}
 
 	event_function_call(event, __perf_event_period, &value);
 
-- 
2.38.1


