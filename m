Return-Path: <stable+bounces-26895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338DB872C2E
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 02:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E0D285B3A
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 01:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6EF6FD0;
	Wed,  6 Mar 2024 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+b3rpQ5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A31D517
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 01:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688200; cv=none; b=YEEDKnhgfHdVrPOms0yWRaVUGFF+gq3lfcCBN7hm/uPkiRORU4grTSB1XzgGwJwFeXw1vYeAjQabZd0Hzbq14EjPgbG9Aa4v8LGSL9kRXQHwswub+uJ4+uWA9f60+ilIytWF79M8l8QEpZMpzhiLMfH2XspZx6Xj0PmjlYq8apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688200; c=relaxed/simple;
	bh=9QFb+ls8zmFoD5cK7OMUyxdIOVvqIXnWDbo4N55X8bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R64c2TJpptNrhkFiaQmvy2wiFH2qVDegTbKdw9bHJwaiMvN8mi3YMP3Ugm36ZlP5yFKcL81lqzriLc5Ii0vbaQqvOfx26LUHxSzHUePj6N1lbbMZi0jb4YyPBPJNVKfi0Yx85SdefV0cbwWXm9CtrWm928zPja+qoq/p4nKbhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+b3rpQ5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709688198; x=1741224198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9QFb+ls8zmFoD5cK7OMUyxdIOVvqIXnWDbo4N55X8bI=;
  b=X+b3rpQ5l5S/cjwi00HtvaB8ChlXa972NnJDBHqbc91bkyreg7WCIU94
   QDCIlRHrO6xBRC7sVSx0uCNxeESuPNjylkW/mku9Zwl38hCnJO/taQHv5
   i15jDdzykzsjRZj6s6ueny6Bo1aRdJ3OLtpYuOZ281QKZKXGhr8nPUqYc
   eXBG+3g1F7TkTRt1EY/xhvqmilaibeDRueKVIBI7BUsn8kVTxkYUFQpcC
   FjMp6X/qYfLMUONi4M+jzlZWrSLLVZn2vBCqOoHE5xiuJI0wjt3JDbZ9a
   GQNK1NldBFmvXGqujo+5t60fkdG4DH0LcARnXLSc3iAFUmi/ALFrENHlD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="8098382"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="8098382"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="40573887"
Received: from unknown (HELO intel.com) ([10.247.118.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 17:22:57 -0800
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
Subject: [PATCH v4 0/3] Disable automatic load CCS load balancing
Date: Wed,  6 Mar 2024 02:22:44 +0100
Message-ID: <20240306012247.246003-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I have to admit that v3 was a lazy attempt. This one should be on
the right path.

this series does basically two things:

1. Disables automatic load balancing as adviced by the hardware
   workaround.

2. Assigns all the CCS slices to one single user engine. The user
   will then be able to query only one CCS engine

I'm using here the "Requires: " tag, but I'm not sure the commit
id will be valid, on the other hand, I don't know what commit id
I should use.

Thanks Tvrtko, Matt, John and Joonas for your reviews!

Andi

Changelog
=========
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
- In Patch 2 do not add the extra CCS engines to the exposed UABI
  engine list and adapt the engine counting accordingly (thanks
  Tvrtko).
- Reword the commit of Patch 2 (thanks John).


Andi Shyti (3):
  drm/i915/gt: Disable HW load balancing for CCS
  drm/i915/gt: Refactor uabi engine class/instance list creation
  drm/i915/gt: Enable only one CCS for compute workload

 drivers/gpu/drm/i915/gt/intel_engine_user.c | 40 ++++++++++++++-------
 drivers/gpu/drm/i915/gt/intel_gt.c          | 23 ++++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  6 ++++
 drivers/gpu/drm/i915/gt/intel_workarounds.c |  5 +++
 4 files changed, 62 insertions(+), 12 deletions(-)

-- 
2.43.0


