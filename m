Return-Path: <stable+bounces-28092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCAA87B2BD
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 21:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215961C2272E
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722A74CDE0;
	Wed, 13 Mar 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WRoBLe4G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12ED1EB31
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361214; cv=none; b=PPl3kdohf44YAR+RDzxKBdQHMqaGhxu3KGpR9V8H7keHIDKvOAR5UpRat2bLX2pWlU09qvB9Yp/xnFWpdwuYzqioae1/XvArsT3JCAdBxbofgVpX21YeuG6LMmhicO4KsagAp2bCt1Uq99t/dTBD1exsz/I+jFMGpknIP0GiDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361214; c=relaxed/simple;
	bh=jTJZWPto4ZZRzieeqkUXml/CzBikUEgLbp1WISYlPhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obXF498Ne7zwuJqUS0lV/ha0xhiZl+sDuu+H9iFFSM56qEKeW51jlYqPaI7/rA64grgR0gd3VHKSk3R+b3o65ta92r/z+tg/7TbuZCVOkte+ZTDM/+agDxFmAmYSPNqOdxYWYnIgG/xB8k5zcAMJusvg2sfRo0keVCdLBhEODLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WRoBLe4G; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710361212; x=1741897212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jTJZWPto4ZZRzieeqkUXml/CzBikUEgLbp1WISYlPhU=;
  b=WRoBLe4GaTfXP55LxmfodyuZO9yVDufkMioZDrmviVf0Cm82B/C2WiOm
   D7+LcW3fff3UPQuDT0aV19Y8N1fK5mmbQWVKk0QBsfhEbTcvYSKIsSVjG
   CN/D7BvXh9uOyRnA0RYxNrFpHz3zliNsTs7z5BhFkIUf7Dp4IVV3p/EtO
   54nWMAuIxV35Kap75+g4kiUMHLEa3CPRMC6NYlSlJ3aJcudsnIfeDSz1k
   ICDckZ3wH0c8dMWM8G2ZT/ZDSsx6knMmHDRA2WIvj/sKQozNAaXrKwhVr
   APgW/yPETlcYxl+EIdRty63QfLtO0lA7oPcTWE7gq/VnQb2PXSEUGsBi3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="8975859"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="8975859"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 13:20:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="35176284"
Received: from unknown (HELO intel.com) ([10.247.118.152])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 13:20:04 -0700
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
Subject: [PATCH v6 0/3] Disable automatic load CCS load balancing
Date: Wed, 13 Mar 2024 21:19:48 +0100
Message-ID: <20240313201955.95716-1-andi.shyti@linux.intel.com>
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
 drivers/gpu/drm/i915/gt/intel_engine_cs.c   | 20 ++++++++---
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c | 39 +++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h | 13 +++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  6 ++++
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 30 ++++++++++++++--
 6 files changed, 103 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.h

-- 
2.43.0


