Return-Path: <stable+bounces-33002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A20388E9FD
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02E51F33511
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D351304A2;
	Wed, 27 Mar 2024 15:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+9/qG5r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B81B12FF93
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555024; cv=none; b=NwbRbbIarfjLTbjxNeqIpAK2Hg9oTnvgJ6+B3ZORXC2nThAWdFquElYy6KQwFQUtul4EmS2VCsCYGyiEiZ/vAypO7zH0nEM+/jQmY6VWAKQ0vkCJ8jOqi7Q4lAwoWJxDjM3/qh0VEjehG6jpkmc3aueBVJ6fhVTgRGj5UNfz+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555024; c=relaxed/simple;
	bh=CezWxV1ugvmeHdvtfKDNqDryeTvRwf2uaIO+AyEy+mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWfGX0nmVSNVBwKCo5/wmELomJzh/8v10hbTQqH2avyJCf10wOcMm6uORwRauP20XM+aLau3sqJsUElPJvXErTvxBzn3oQFUSicqkpEKht95BrxFvJaT/klRF8kmASoT4HM5v1YWM4W3Z+lwOh+PhuwYHvm0G2QsaiPxU2o5270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+9/qG5r; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711555023; x=1743091023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CezWxV1ugvmeHdvtfKDNqDryeTvRwf2uaIO+AyEy+mw=;
  b=K+9/qG5rtl7zvQqOMekbw5UDDoz+mKBtzxNvuRbX3KffKnctBiOda4Lo
   AKPZ/Bty9cWjEqf0J6CVOYgMVTndGBwmrOMzzS85mWG7Ap1+b17PBCPrK
   ozFEut72rzJ23r0DpIBkGZUy7F0vPFTFXui8nDKCg7TgGvKwNSpCOAP15
   Pq0V6TX45HiHWKtRsAB2rXgI7m2c4cjxuPM8ZBiPnfJz9uMtm8ypUlRif
   OKgui5Wx8M2jKcFRqr7inMUXTCxzQc0QgVP4R22Cd28/T3ZSNs0ZAJyIe
   ReTm+EXWKiXCZ4yiljSXoBJGhnrH4IVn+5P5p+8hdIbKYLI9ggyA+Ynoq
   w==;
X-CSE-ConnectionGUID: jRgPzswISB+O4ebhdreMYA==
X-CSE-MsgGUID: QBypNkwLSiW6mHDQbO6ODA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17215711"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="17215711"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="47548021"
Received: from unknown (HELO intel.com) ([10.247.118.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:56:54 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	John Harrison <John.C.Harrison@Intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Michal Mrozek <michal.mrozek@intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v7 0/3] Disable automatic load CCS load balancing
Date: Wed, 27 Mar 2024 16:56:16 +0100
Message-ID: <20240327155622.538140-1-andi.shyti@linux.intel.com>
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

From v5 I have created a new file, gt/intel_gt_ccs_mode.c where
I added the intel_gt_apply_ccs_mode(). In the upcoming patches,
this file will contain the implementation for dynamic CCS mode
setting.

Thanks Tvrtko, Matt, John and Joonas for your reviews!

Andi

Changelog
=========
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
 drivers/gpu/drm/i915/gt/intel_engine_cs.c   | 15 ++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c | 39 +++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h | 13 +++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  6 ++++
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 30 ++++++++++++++--
 6 files changed, 102 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h

-- 
2.43.0


