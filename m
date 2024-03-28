Return-Path: <stable+bounces-33054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5BF88F8D5
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 08:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF229295FBE
	for <lists+stable@lfdr.de>; Thu, 28 Mar 2024 07:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7BA50279;
	Thu, 28 Mar 2024 07:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVY7WbcI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812A3DABF3
	for <stable@vger.kernel.org>; Thu, 28 Mar 2024 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611272; cv=none; b=Jr7lpEEc8ddavmQMZwHBbEHPCxInk8zReeGfIWTnqC+AbYSZ/63V6Zc1IDlMNGZXHqV9nN6fRkSxyonSWv5eNBHtk1Z1QLEKxw0pMrzNKFFOElq6YE44Sl1dg2HH5Jocl5i2cgoV0knsDGb04I80FblFzcGxD4XVP9ov6f75Cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611272; c=relaxed/simple;
	bh=R5d0KY+pyyNN0XveYowt5rWQyfNi5jptYbW9bA4xwoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BY51CK35PP5d9x0xufZFuUvsD1ltH8yqJhT4Yu2tM8XsKjHxezSXiWSk/vpW+kb7fX8P63KTb/aR6vxFUd81g0mawOykuYsAb+5zrB+wDUtAiSit5JtZON5BRabq/34jS+w10t1zAfTkWqRX/ZA7LWIoBvGNfUWoi7MpQzLLnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVY7WbcI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711611270; x=1743147270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R5d0KY+pyyNN0XveYowt5rWQyfNi5jptYbW9bA4xwoQ=;
  b=VVY7WbcIItmHOsEdrVPAoxqZUE0/+xGq9XiD2pY5iXL2xrJgGpFX2VSm
   ZfyzaVNlV4FkROfDJAG6dVNbNPQuckIwPSSxzm5QcW8bDowOg1WFBYaZ1
   1hCIUfVE3nhzITrxDM48+wXq/ONAoRgN2Q4dvxlpWF07yZr3I5v2nGGPa
   wJMBirlNT669b3Jn5MsUr6pLFblYV+pR8jERJtAUwj4qxZUi0aLRyDcRQ
   5FhUC11T/QyYr/zbUDPvwdkZBex4YzHnSgJuwXwx4wRs2d0Cf7rCe8X/3
   g1GIi98sQtK0G6CXl8a3tDLw68d586VPPXm6SKv4FEUQqBtQaKRx572gQ
   Q==;
X-CSE-ConnectionGUID: n21fQHiGRU+UOk4EteJ7qQ==
X-CSE-MsgGUID: ZIhx10r4SCeH6og1szo43A==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6640570"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6640570"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="47763887"
Received: from unknown (HELO intel.com) ([10.247.118.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:34:23 -0700
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
Subject: [PATCH v8 0/3] Disable automatic load CCS load balancing
Date: Thu, 28 Mar 2024 08:34:02 +0100
Message-ID: <20240328073409.674098-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I think we are at the end of it and hopefully this is the last
version. Thanks Matt for having followed this series until here.

This series does basically two things:

1. Disables automatic load balancing as adviced by the hardware
   workaround.

2. Assigns all the CCS slices to one single user engine. The user
   will then be able to query only one CCS engine

From v5 I have created a new file, gt/intel_gt_ccs_mode.c where
I added the intel_gt_apply_ccs_mode(). In the upcoming patches,
this file will contain the implementation for dynamic CCS mode
setting.

Thanks Tvrtko, Matt, John and Joonas for your reviews!

Andi

Changelog
=========
v7 -> v8
 - Just used a different way for removing the first instance of
   the CCS from the info->engine_mask, as suggested by Matt.

v6 -> v7
 - find a more appropriate place where to remove the CCS engines:
   remove them in init_engine_mask() instead of
   intel_engines_init_mmio(). (Thanks, Matt)
 - Add Michal's ACK, thanks Michal!

v5 -> v6 (thanks Matt for the suggestions in v6)
 - Remove the refactoring and the for_each_available_engine()
   macro and instead do not create the intel_engine_cs structure
   at all.
 - In patch 1 just a trivial reordering of the bit definitions.

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

Andi Shyti (3):
  drm/i915/gt: Disable HW load balancing for CCS
  drm/i915/gt: Do not generate the command streamer for all the CCS
  drm/i915/gt: Enable only one CCS for compute workload

 drivers/gpu/drm/i915/Makefile               |  1 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c   | 17 +++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c | 39 +++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h | 13 +++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  6 ++++
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 30 ++++++++++++++--
 6 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h

-- 
2.43.0


