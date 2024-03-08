Return-Path: <stable+bounces-27188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9551876BC2
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 21:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D4128259E
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 20:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123EA5B5B6;
	Fri,  8 Mar 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9JB9pSE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E4604B6
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929361; cv=none; b=oBKaJ8cM94fF81niBjkt3J/r8mljnJAlRiXPPXGO+TBP/JrFN6ttOzqDWymni8WgSecHlw9ShcI/v7NPa1j/FHrEwbIdNhYon+42GvjsBNcoN12pGEg+N7x21L9DC0XvMRGaEKlZK+peqU+HyM9dvWOvRkCBbZ0N8yjE0HQ1vLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929361; c=relaxed/simple;
	bh=z5C+/kqT7zzayWP3YRJGvQW73+4jn1t84uLJD3UPT5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T8rm+5lsKfmgQo2k64xsjyHWot3Y9tB2YKfryrfXwybEpPEs3l98VxAVK/2Tje4AxIHOmNi8hpC25DHt1mVG5K/gNH78oq+oN3/DovT9eBXEDG1SiK3B9CK0szJQWflNkPrPc/MtLudNh8wa0ms7gLLcElb5D5y5MMgmsoT3C/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9JB9pSE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709929361; x=1741465361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z5C+/kqT7zzayWP3YRJGvQW73+4jn1t84uLJD3UPT5o=;
  b=b9JB9pSEFLjzzuL9DLO+hh5tHoZxDYtZFMh4NJZ7Lg9gt9QIWTW7J7kV
   H5OxvJHrNK0xvPBr0HBRjc6z4DOViL5zCBghuZouks727Tctefntpq8T7
   xg5xQrH9HAcW/j5pPmNEslZTf5i67CaLNpJiDgTIqfhj2jI6Inb284EMR
   ToKYbCnuXNa89/7/hRLhncU7zOxRAQrZbBCAXvv3c1KRY6JvAiBjNhSiz
   +enhfsUctFKyNhRVzavvbPQexapewJ2Rci14ia69lADjTwZSQ3lWdIllR
   qk39lu7e1oCtI1GzqwkTX4CVE6/UsM2U9HUxM/nndqornx8HeLy+gZn/9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11007"; a="22120685"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="22120685"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 12:22:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="41503833"
Received: from unknown (HELO intel.com) ([10.247.118.109])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 12:22:33 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Tvrtko Ursulin <tursulin@ursulin.net>
Subject: [PATCH v5 0/4] Disable automatic load CCS load balancing
Date: Fri,  8 Mar 2024 21:22:15 +0100
Message-ID: <20240308202223.406384-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series does basically two things:

1. Disables automatic load balancing as adviced by the hardware
   workaround.

2. Assigns all the CCS slices to one single user engine. The user
   will then be able to query only one CCS engine

In this v5 I have created a new file, gt/intel_gt_ccs_mode.c
where I added the intel_gt_apply_ccs_mode(). In the upcoming
patches, this file will contain the implementation for dynamic
CCS mode setting.

I saw also necessary the creation of a new mechanism fro looping
through engines in order to exclude the CCS's that are merged
into one single stream. It's called for_each_available_engine()
and I started using it in the hangcheck sefltest. I might still
need to iterate a few CI runs in order to cover more cases when
this call is needed.

I'm using here the "Requires: " tag, but I'm not sure the commit
id will be valid, on the other hand, I don't know what commit id
I should use.

Thanks Tvrtko, Matt, John and Joonas for your reviews!

Andi

Changelog
=========
v4 -> v5
 - Use the workaround framework to do all the CCS balancing
   settings in order to always apply the modes also when the
   engine resets. Put everything in its own specific function to
   be executed for the first CCS engine encountered. (Thanks
   Matt)
 - Calculate the CCS ID for the CCS mode as the first available
   CCS among all the engines (Thanks Matt)
 - create the intel_gt_ccs_mode.c function to host the CCS
   configuration. We will have it ready for the next series.
 - Fix a selftest that was failing because could not set CCS2.
 - Add the for_each_available_engine() macro to exclude CCS1+ and
   start using it in the hangcheck selftest.

v3 -> v4
 - Reword correctly the comment in the workaround
 - Fix a buffer overflow (Thanks Joonas)
 - Handle properly the fused engines when setting the CCS mode.

v2 -> v3
 - Simplified the algorithm for creating the list of the exported
   uabi engines. (Patch 1) (Thanks, Tvrtko)
 - Consider the fused engines when creating the uabi engine list
   (Patch 2) (Thanks, Matt)
 - Patch 4 now uses a the refactoring from patch 1, in a cleaner
   outcome.

v1 -> v2
 - In Patch 1 use the correct workaround number (thanks Matt).
 - In Patch 2 do not add the extra CCS engines to the exposed
   UABI engine list and adapt the engine counting accordingly
   (thanks Tvrtko).
 - Reword the commit of Patch 2 (thanks John).

Andi Shyti (4):
  drm/i915/gt: Disable HW load balancing for CCS
  drm/i915/gt: Refactor uabi engine class/instance list creation
  drm/i915/gt: Disable tests for CCS engines beyond the first
  drm/i915/gt: Enable only one CCS for compute workload

 drivers/gpu/drm/i915/Makefile                |  1 +
 drivers/gpu/drm/i915/gt/intel_engine_user.c  | 40 ++++++++++++++------
 drivers/gpu/drm/i915/gt/intel_gt.h           | 13 +++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c  | 39 +++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h  | 13 +++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h      |  6 +++
 drivers/gpu/drm/i915/gt/intel_workarounds.c  | 30 ++++++++++++++-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c | 22 +++++------
 8 files changed, 139 insertions(+), 25 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h

-- 
2.43.0


