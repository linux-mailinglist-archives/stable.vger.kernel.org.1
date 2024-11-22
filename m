Return-Path: <stable+bounces-94637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6079D6517
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C56116131D
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396F3186612;
	Fri, 22 Nov 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hh6+08b0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAE1531C8
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309662; cv=none; b=SE4MlGiraVutd07f52L8986V8t1ijP6utMA79jL3K+AsAt538/OlUuaC7oS4vWReTX7szpIcIOTwfITY4fOo/eExX19nLgpTXpVTokupfqGNW2YWUiVRnzevOAYPY3l4caLpO1lodM5KId4GDLPoEUFXxiYniC+OX1La1jtThvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309662; c=relaxed/simple;
	bh=OrFzebLtw4Wo3Q01TDIAMHOiwP0z6Owqgd4TBgJEAfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p0+tAwBqqlCzA3NqQGN6bpTYq2cV9b5mvo/KZe2h94YaQCE1LMsK5X40PIIMFQ3n7/0K0bhnRPduXW0TCGQwxkTQI63+bo9TC8+mM6mkykMd37Ro1zaxojRk9C2/ZOmVRH8B3J4V1sD/iUfNnjGUBBQEHtAUSFuCBIehqWDq4vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hh6+08b0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309659; x=1763845659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OrFzebLtw4Wo3Q01TDIAMHOiwP0z6Owqgd4TBgJEAfw=;
  b=hh6+08b0R0sJWkup2uDuQXVowFb+h4qfPf7vOmsccZRfKcmjI3avAood
   2L/a38ZxnxEjc9dVF2UB/4SfE9MwHjWmEtSvGaubamnZl7Ilzv1q/Cd7T
   QPnAIr/TlZCfcnC4a9QdzGpn4rZyOXgCaFhXRuFq79N7hOe7FXSc8F5BS
   XvqbF7kVfv89inmHA0ikTf0FagHqrnDcPJIU3N1Vj4nvf/RvlEY5/Csd5
   oc0PqtpCRfkv67Ns4Z50kyaVNWTFJqxyICTWtMQFjZDn8xlygeJOYXIiE
   aRix/YaV8E+pThYDLqFXlzMKVPlSEDR7ax2jpcfKml/+SgSM5g85wdd/p
   A==;
X-CSE-ConnectionGUID: V/7MfOwqQVOgIMUs9J8HtQ==
X-CSE-MsgGUID: +XY0c/Q1TLCpxKVlRuYiag==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878253"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878253"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
X-CSE-ConnectionGUID: oPAZ/Y/bSv2YJZUXmo4bMw==
X-CSE-MsgGUID: nyGiKtmvS2CPccKyiuh52A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457178"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:39 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 00/31] xe/i915 fixes for 6.11
Date: Fri, 22 Nov 2024 13:06:48 -0800
Message-ID: <20241122210719.213373-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Due to some issues with hibernation on Lunar Lake (integrated), it was
decided to re-use the migration logic from Battle Mage (discrete).
However in 6.11 there were several patches missing to allow that to
work. A few patches were picked automatically for 6.11.10, but they are
not sufficient.  Bring the additional patches and some tests to make
sure the backports work: this correspond to 20 of the patches here.
Others were additional fixes or dependencies.

This was tested on top of 6.11.10.

Akshata Jahagirdar (5):
  drm/xe/migrate: Handle clear ccs logic for xe2 dgfx
  drm/xe/migrate: Add helper function to program identity map
  drm/xe/migrate: Add kunit to test clear functionality
  drm/xe/xe2: Introduce identity map for compressed pat for vram
  drm/xe/xe_migrate: Handle migration logic for xe2+ dgfx

Aradhya Bhatia (1):
  drm/xe/xe2lpg: Extend Wa_15016589081 for xe2lpg

Chaitanya Kumar Borah (1):
  drm/i915: Do not explicilty enable FEC in DP_TP_CTL for UHBR rates

Daniele Ceraolo Spurio (1):
  drm/xe/uc: Use managed bo for HuC and GSC objects

Gustavo Sousa (2):
  drm/xe/xe2: Extend performance tuning to media GT
  drm/xe/xe2: Add performance tuning for L3 cache flushing

He Lugang (1):
  drm/xe: use devm_add_action_or_reset() helper

Imre Deak (5):
  drm/xe: Handle polling only for system s/r in
    xe_display_pm_suspend/resume()
  drm/i915/dp: Assume panel power is off if runtime suspended
  drm/i915/dp: Disable unnecessary HPD polling for eDP
  drm/xe/display: Separate the d3cold and non-d3cold runtime PM handling
  drm/xe/display: Add missing HPD interrupt enabling during non-d3cold
    RPM resume

Maarten Lankhorst (2):
  drm/xe: Remove runtime argument from display s/r functions
  drm/xe: Fix missing conversion to xe_display_pm_runtime_resume

Matthew Auld (3):
  drm/xe/client: use mem_type from the current resource
  drm/xe/queue: move xa_alloc to prevent UAF
  drm/xe/bmg: improve cache flushing behaviour

Matthew Brost (1):
  drm/xe: Do not run GPU page fault handler on a closed VM

Michal Wajdeczko (4):
  drm/xe/kunit: Kill xe_cur_kunit()
  drm/xe/kunit: Simplify xe_bo live tests code layout
  drm/xe/kunit: Simplify xe_dma_buf live tests code layout
  drm/xe/kunit: Simplify xe_migrate live tests code layout

Rodrigo Vivi (1):
  drm/{i915, xe}: Avoid direct inspection of dpt_vma from outside dpt

Suraj Kandpal (2):
  drm/xe/display: Do not suspend resume dp mst during runtime
  drm/xe/display: Do not do intel_fbdev_set_suspend during runtime

Thomas Hellström (1):
  drm/xe: Use separate rpm lockdep map for non-d3cold-capable devices

Vinod Govindapillai (1):
  drm/xe/display: handle HPD polling in display runtime suspend/resume

 drivers/gpu/drm/i915/display/intel_dp.c       |  16 +-
 drivers/gpu/drm/i915/display/intel_dpt.c      |   4 +
 drivers/gpu/drm/i915/display/intel_dpt.h      |   3 +
 .../drm/i915/display/skl_universal_plane.c    |   3 +-
 drivers/gpu/drm/i915/intel_runtime_pm.h       |   8 +-
 .../xe/compat-i915-headers/intel_runtime_pm.h |   8 +
 drivers/gpu/drm/xe/display/xe_display.c       |  78 ++++-
 drivers/gpu/drm/xe/display/xe_display.h       |  12 +-
 drivers/gpu/drm/xe/display/xe_fb_pin.c        |   9 +-
 drivers/gpu/drm/xe/regs/xe_gt_regs.h          |  12 +-
 drivers/gpu/drm/xe/tests/Makefile             |   3 -
 drivers/gpu/drm/xe/tests/xe_bo.c              |  24 +-
 drivers/gpu/drm/xe/tests/xe_bo_test.c         |  21 --
 drivers/gpu/drm/xe/tests/xe_bo_test.h         |  14 -
 drivers/gpu/drm/xe/tests/xe_dma_buf.c         |  20 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf_test.c    |  20 --
 drivers/gpu/drm/xe/tests/xe_dma_buf_test.h    |  13 -
 drivers/gpu/drm/xe/tests/xe_live_test_mod.c   |   9 +
 drivers/gpu/drm/xe/tests/xe_migrate.c         | 299 +++++++++++++++++-
 drivers/gpu/drm/xe/tests/xe_migrate_test.c    |  20 --
 drivers/gpu/drm/xe/tests/xe_migrate_test.h    |  13 -
 drivers/gpu/drm/xe/tests/xe_mocs.c            |   8 +-
 drivers/gpu/drm/xe/tests/xe_pci_test.c        |   4 +-
 drivers/gpu/drm/xe/tests/xe_test.h            |   8 +-
 drivers/gpu/drm/xe/xe_drm_client.c            |   7 +-
 drivers/gpu/drm/xe/xe_exec_queue.c            |   4 +-
 drivers/gpu/drm/xe/xe_gsc.c                   |  12 +-
 drivers/gpu/drm/xe/xe_gsc_proxy.c             |  36 +--
 drivers/gpu/drm/xe/xe_gt.c                    |   1 -
 drivers/gpu/drm/xe/xe_gt_freq.c               |   4 +-
 drivers/gpu/drm/xe/xe_gt_pagefault.c          |   6 +
 drivers/gpu/drm/xe/xe_gt_sysfs.c              |   2 +-
 drivers/gpu/drm/xe/xe_huc.c                   |  19 +-
 drivers/gpu/drm/xe/xe_migrate.c               | 185 +++++++----
 drivers/gpu/drm/xe/xe_module.c                |   9 +
 drivers/gpu/drm/xe/xe_pm.c                    | 100 ++++--
 drivers/gpu/drm/xe/xe_pm.h                    |   1 +
 drivers/gpu/drm/xe/xe_tuning.c                |  28 ++
 drivers/gpu/drm/xe/xe_wa.c                    |   4 +
 39 files changed, 735 insertions(+), 312 deletions(-)
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_bo_test.c
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_bo_test.h
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_dma_buf_test.c
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_dma_buf_test.h
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_migrate_test.c
 delete mode 100644 drivers/gpu/drm/xe/tests/xe_migrate_test.h

-- 
2.47.0


