Return-Path: <stable+bounces-105173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58ADC9F69C9
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 16:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91781628D7
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB34189F2B;
	Wed, 18 Dec 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0qpZ1Sb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8255FEE6;
	Wed, 18 Dec 2024 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534972; cv=none; b=XRuvEoCtE0ar0kREsyCrrCLdH5J2L0ccKsEzwi7IHakGN7FiD1cpRWq2ziYHKVHW+YaNbWW+0VBrnz2c7J6f285g3H5lAQTl6kjAoi8FNhC6Ltca9MQd0KdAuo8nOXYYHxrGExrDnE+OzMY1KQE1VRDedF1Civvr6zeJoi7w1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534972; c=relaxed/simple;
	bh=8/gobZpEotzrTqqW9q/uFG5l8ZutJeSbAun02px5kJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GSW9pd7pTXnYSBAxyw026g8dfTFm6LZETpo2vdm6aU5jWgiaJkpLRYRJBY2uM3iZGeV3z+g0INQKyYrKwnyVztLaN9cZRAlhIej8HIS3aaFKgpURwu3zUlEHYTBRPUdtLQdy3alOQ5Ta/3JfilUWlZnzZ8egPEZLumTAH3GncZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0qpZ1Sb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734534969; x=1766070969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8/gobZpEotzrTqqW9q/uFG5l8ZutJeSbAun02px5kJM=;
  b=B0qpZ1SbD6Zh4OyJ8KhN4n+SSac+1GmGFOXBmcsb6mDDsgjeqkvbV7dG
   PKeDj+2zYzFrDfaYEJ9ILi2Pp3RUpugfZ6GZxMowEMfWZQvtAl6OjDd7B
   uUeWYiI9QLPBypYKwouooKFI1BK36QFR7GbBdZdOgl1PCoc6BCKLcu++S
   rldP9iKCdc5A30nwQh4ieBy+P0wL1QO79Rn6P/mtUwbLqCYFA2O+vXvPI
   qsYIsSA3Z46hqVbIhowLEyrAYBDeoGJLs4AqOoMz+3mfKWvfzI5s7YiCu
   p+yxuxvnVfUiYPiA0q6Q593v/yAln3Z+HXI3V0TqS4wrtTDkPf3/0bbdh
   Q==;
X-CSE-ConnectionGUID: WAePwUgCTBGtdhfyPOzIRw==
X-CSE-MsgGUID: aRhpEdH9TUOfS2Lh8b2a1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35047704"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35047704"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:16:08 -0800
X-CSE-ConnectionGUID: 80Ture5xTWmrdpzDzXJfNQ==
X-CSE-MsgGUID: xOB5ojYWTtqQGMqbvSBw2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97687788"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Dec 2024 07:16:07 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V6 1/3] perf/x86/intel/ds: Add PEBS format 6
Date: Wed, 18 Dec 2024 07:16:41 -0800
Message-Id: <20241218151643.1031659-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The only difference between 5 and 6 is the new counters snapshotting
group, without the following counters snapshotting enabling patches,
it's impossible to utilize the feature in a PEBS record. It's safe to
share the same code path with format 5.

Add format 6, so the end user can at least utilize the legacy PEBS
features.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---

No changes since V5

 arch/x86/events/intel/ds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8dcf90f6fb59..ba74e1198328 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2551,6 +2551,7 @@ void __init intel_ds_init(void)
 			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
+		case 6:
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
-- 
2.38.1


