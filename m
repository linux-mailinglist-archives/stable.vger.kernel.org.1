Return-Path: <stable+bounces-26713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9A87156C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 06:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E25B22D9C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 05:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11974CE0E;
	Tue,  5 Mar 2024 05:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSrOnzED"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF02AE95
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617880; cv=none; b=XdnZi4vyNZrtU9KH6m5LFtRpDTk97/QGh8hfNqhzzHFHtWPUjd1GvN35Nvcbc2lGfdf3lNKUppdW1YswXh6WPMiwDuFXYhYPl2qW3CBs+kB5kebYsOHCGN0PV9tTf/88t0FKLKZndw0xDpukUEeptBnqFA/rmi9iZWLUnfJ5B+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617880; c=relaxed/simple;
	bh=3Zg7i/ZzdfjetNS/XB5okJZYHRy8k1+wT83SqXKo4JM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R/otnEJtsiTjnhhdeg9P83mzqWje9fHIc67XzdWozMXDwSZGmT9gWqVIEkDiJkf3BapU+xLzZaoslpIqwtl9x8EaXf0YFcOuxUzhedYbKWHmMAwesqd5vn+LFz8+GUMn9odP3FfAN3ITBWDWpLYvCLFiXCleuhmtLlZy8d/PguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSrOnzED; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709617878; x=1741153878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Zg7i/ZzdfjetNS/XB5okJZYHRy8k1+wT83SqXKo4JM=;
  b=JSrOnzEDLa/Op3xkgqbS+iN8io1ET9M2LOU9hN7LjNSZb5R3pUKHnyzn
   jVshRJDZJT3dzqzOh0De/1FtTAnuRpd+FUhGq2KOhLr7wECSU0o9m7JM3
   13PuHlWAIw0T3RNljfWwThDhejINaod6SDU8FWHALMvaf0EQm7+ZecyuZ
   K/+3yjZtWR3P9rsTusQxGi/0oZAynqAf4We2S1w7TJqbgXGY15Tb1buPb
   PT1jiyvgqj47RghATp6gUFUHbknJ0VIub4oqqTidkzIefz3w8KUEPLQm4
   0lPw2gfgk391sJF6v4INMZAZogqIYISbwUo/QZ4iut+tuDjQq0d03xDCj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4307661"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4307661"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9219482"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:51:17 -0800
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	ankit.k.nautiyal@intel.com,
	stanislav.lisovskiy@intel.com,
	jani.nikula@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/dp: Fix the computation for compressed_bpp for DISPLAY < 13
Date: Tue,  5 Mar 2024 11:14:43 +0530
Message-Id: <20240305054443.2489895-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For DISPLAY < 13, compressed bpp is chosen from a list of
supported compressed bpps. Fix the condition to choose the
appropriate compressed bpp from the list.

Fixes: 1c56e9a39833 ("drm/i915/dp: Get optimal link config to have best compressed bpp")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.7+
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10162
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index e13121dc3a03..d579195f84ee 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1918,8 +1918,9 @@ icl_dsc_compute_link_config(struct intel_dp *intel_dp,
 	dsc_max_bpp = min(dsc_max_bpp, pipe_bpp - 1);
 
 	for (i = 0; i < ARRAY_SIZE(valid_dsc_bpp); i++) {
-		if (valid_dsc_bpp[i] < dsc_min_bpp ||
-		    valid_dsc_bpp[i] > dsc_max_bpp)
+		if (valid_dsc_bpp[i] < dsc_min_bpp)
+			continue;
+		if (valid_dsc_bpp[i] > dsc_max_bpp)
 			break;
 
 		ret = dsc_compute_link_config(intel_dp,
-- 
2.40.1


