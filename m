Return-Path: <stable+bounces-20276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05085652B
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 15:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2C21C23A95
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 14:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769EB13173C;
	Thu, 15 Feb 2024 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4sf77BO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547B12FF7C
	for <stable@vger.kernel.org>; Thu, 15 Feb 2024 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005617; cv=none; b=gS31xPiNnqC6aeKeKpTQBpOuPnQ+i2VQZQmdtAUSdDwRF+UvmJefE7urdTfn/uDCQzG9894XjRE9q3FF9IIjR51QCT872FLcMHPf/tB8U/rHg3U26ApZo2RdtC6PcQp1mcnvDIQQYEKziRgi0vVWCcxLkGOvSaks++EXbCB7dXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005617; c=relaxed/simple;
	bh=s28gQVWPZGE3H1osjrzS3iQPjQBdB6vAoufDHgxlyXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTUBff5mCKfOelSkWNFIo/KcerRSKuriCwN2y0Oe5ZXD+8exnZd/vy7AzoDsD1fMf8T+FRcYoqCf69bhm+AzFO4nSYAU5WF34F8IlcEWKKpAdDDFT6+oF1Bame/7rXohdxVL4NV+819eZ4N6hkQ+BPyK+spBdcUcLJIVQ06vKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4sf77BO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708005615; x=1739541615;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s28gQVWPZGE3H1osjrzS3iQPjQBdB6vAoufDHgxlyXs=;
  b=D4sf77BO4CjLqs6464rCaaq1ZQZArp4sM8DY5tUCVDSC3SQRNpSKlCDp
   WzU6zuN/kmAc6CfjavbpPzjkQUBWrGM5zGTAEFWkLH7eSorJdJFNew+U0
   qfKH45LXdYSuulriCluHmVP8eFjA6nLztHDS2wlTpwfMCub7UFk5t/cWa
   pkagyNTZGzES7uE9LDgCDL1f39EawXcAhVUmfEGpK3WpZ6YTYawKuxOAy
   646iDA56Zlw5Y3mci0Rus6N6Hxss8SLZjbZSZt0MTe+q8LhXB7qhqpUIh
   Ot3PfBZowcJ4ujeuvy0Unc4MG3c6V/uQP7pwmajgDaLjufoco1na+w29o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5061154"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="5061154"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="8188580"
Received: from yspisare-mobl2.ger.corp.intel.com (HELO intel.com) ([10.246.50.215])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:00:11 -0800
From: Andi Shyti <andi.shyti@linux.intel.com>
To: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	stable@vger.kernel.org,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 0/2] Disable automatic load CCS load balancing
Date: Thu, 15 Feb 2024 14:59:22 +0100
Message-ID: <20240215135924.51705-1-andi.shyti@linux.intel.com>
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

2. Forces the sharing of the load submitted to CCS among all the
   CCS available (as of now only DG2 has more than one CCS). This
   way the user, when sending a query, will see only one CCS
   available.

Andi

Andi Shyti (2):
  drm/i915/gt: Disable HW load balancing for CCS
  drm/i915/gt: Set default CCS mode '1'

 drivers/gpu/drm/i915/gt/intel_gt.c          | 11 +++++++++++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h     |  3 +++
 drivers/gpu/drm/i915/gt/intel_workarounds.c |  6 ++++++
 drivers/gpu/drm/i915/i915_drv.h             | 17 +++++++++++++++++
 drivers/gpu/drm/i915/i915_query.c           |  5 +++--
 5 files changed, 40 insertions(+), 2 deletions(-)

-- 
2.43.0


