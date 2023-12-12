Return-Path: <stable+bounces-6528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59D80FA39
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 23:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFD31C20DB9
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 22:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A7660F6;
	Tue, 12 Dec 2023 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLOX+AKs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DBCF;
	Tue, 12 Dec 2023 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702419816; x=1733955816;
  h=from:to:cc:subject:date:message-id;
  bh=bs2Pt5v1W0sFAFjRahx11+5bS/VM2UK4YvQBDFDNmSA=;
  b=nLOX+AKsZ9ddRAP3cZ+wrq8Sta8VL4MLnZt/uGqi5zGkL5VgaRSJiXhy
   VdZ37btXCMJIbn43K1nIjEnDpcnJ63I60K0VhuGu2g2YsFCF1xqxPzKhh
   z7fWt/hQPIkccfrQr9R24EPPCHPTLc/cRHfcDwZ078pXzcr5IHbBnTXUI
   QXGZttfamn6c0wlpMD7eLRj4UzowL4cBrbeZVU7AoTqGFi/3khrxbM5an
   mFLxeJM0JE5VSdjo0nJNeFMwSd3SjKNfldQTdXkhB1Th5iTZZMcX04qrP
   El23mOcUumrxwmbNsFQNbyxFOkVxdm6NoMcWmItfSr//yrEu2NxszsEi3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2049297"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2049297"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 14:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="802631179"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="802631179"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2023 14:23:35 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>,
	Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v4 0/4] x86/cacheinfo: Set the number of leaves per CPU
Date: Tue, 12 Dec 2023 14:25:15 -0800
Message-Id: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi,

The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
if CPUs have different numbers of subleaves in CPUID 4. This is the case
of Intel Meteor Lake.

This is v4 of a patchset to fix the cache sysfs interface by setting the
number of cache leaves independently for each CPU.

v1, v2, and v3 can be found here[1], here[2], and here[3].

All the tests described in [4] passed.

Changes since v3:
  * Fixed another NULL-pointer dereference when checking the validity of
    the last-level cache info.
  * Added the Reviewed-by tags from Radu and Sudeep. Thanks!
  * Rebased on v6.7-rc5.

Changes since v2:
  * This version uncovered a NULL-pointer dereference in recent changes to
    cacheinfo[5]. This dereference is observed when the system does not
    configure cacheinfo early during boot nor makes corrections later
    during CPU hotplug; as is the case in x86. Patch 1 fixes this issue.

Changes since v1:
  * Dave Hansen suggested to use the existing per-CPU ci_cpu_cacheinfo
    variable. Now the global variable num_cache_leaves became useless.
  * While here, I noticed that init_cache_level() also became useless:
    x86 does not need ci_cpu_cacheinfo::num_levels.

Thanks and BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20230314231658.30169-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/all/20230424001956.21434-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/lkml/20230805012421.7002-1-ricardo.neri-calderon@linux.intel.com/
[4]. https://lore.kernel.org/lkml/20230912032350.GA17008@ranerica-svr.sc.intel.com/
[5]. https://lore.kernel.org/all/20230412185759.755408-1-rrendec@redhat.com/

Ricardo Neri (4):
  cacheinfo: Check for null last-level cache info
  cacheinfo: Allocate memory for memory if not done from the primary CPU
  x86/cacheinfo: Delete global num_cache_leaves
  x86/cacheinfo: Clean out init_cache_level()

 arch/x86/kernel/cpu/cacheinfo.c | 49 +++++++++++++++++----------------
 drivers/base/cacheinfo.c        |  9 +++++-
 2 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.25.1


