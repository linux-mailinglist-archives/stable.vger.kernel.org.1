Return-Path: <stable+bounces-87996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A399ADA93
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 05:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476FBB229B8
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 03:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F099B166F1B;
	Thu, 24 Oct 2024 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpOPyoQm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275616EB56
	for <stable@vger.kernel.org>; Thu, 24 Oct 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741144; cv=none; b=l6Kj+d0veHAGofAJHGVxfZixKhyGsPbBJGXzzss5TyPxP3Klh6M3LYxdZV0MyvXnFAq/JO8Ii1fgF8G10eEo0XiaQV0b0mOsbQu0LzJgPktq/mHjgU1BHXJgre+Qe81DAEwlnVJovB6Gqu3QcKZbmGrfYRGealI3Ad6R/uiEWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741144; c=relaxed/simple;
	bh=mpeT81tMdEloJnWUxKY5Cy3k6f2K+c6xLh8+RLY0p5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRDDaK5vMsEdNsV92GSC2QcU1d7Ks3VPv02suwHqLNY1xASZX88XuJzMEvaFrVh6uG85fImONcTza52EwqbldJZ/N3LRpbbj/EmEoQg8pGbtQ1+zW55lrtk3xys+7NT3g46iF6irhjg42zVao87BRld8AUq1wEYF10LX+GupY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpOPyoQm; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729741142; x=1761277142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpeT81tMdEloJnWUxKY5Cy3k6f2K+c6xLh8+RLY0p5U=;
  b=fpOPyoQmcm1paTI2PXaq63EA7lNUnMN9Jp+Jg9K8L8nLlP5dmU1+DXh3
   6jy76wNqRkEs4VokA5Rw7spC8BKZGhrDgBcm3RiJzZxqS5y/AXI+di4jc
   7ktWSWJDDLUEL6rX/pzIoeuYEjUyjBSX3k6km0Cw+W3npbcH7QeMu+1Ob
   0xF9ynbRjwyFwaIYP2x15l/ESIi9Hh0H/RqHvRGPrAzbLWydlHdxzOsfz
   1cMnppnUc/g6HARwvMoCJ3rvI1AGeJV60IoZJycg90riAp/3MBbTk/cp8
   MyqzvGXw1E7mmSpJBMYUAtInrZIzFmo4BMwbv8a7dq5GYN9Y7RLgTbGEJ
   w==;
X-CSE-ConnectionGUID: Z2qo+wn0RvqvOSiVneXXbQ==
X-CSE-MsgGUID: rLQkEDC7SRCzWb0eE5Pweg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33265003"
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="33265003"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:53 -0700
X-CSE-ConnectionGUID: SUQ2j/kwTqyOw36PCyVY0g==
X-CSE-MsgGUID: i/NflVXbQVemRNShJX0bkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80384986"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 20:38:51 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tejas Upadhyay <tejas.upadhyay@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH xe-i915-for-6.11 17/22] drm/xe: Move enable host l2 VRAM post MCR init
Date: Wed, 23 Oct 2024 20:38:09 -0700
Message-ID: <20241024033815.3538736-17-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024033815.3538736-1-lucas.demarchi@intel.com>
References: <20241024033815.3538736-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

commit ab0d6ef864c5fa820e894ee1a07f861e63851664 upstream.

xe_gt_enable_host_l2_vram() is reading the XE2_GAMREQSTRM_CTRL register
that is currently missing the MCR annotation. However, just adding the
annotation doesn't work as this function is called before MCR handling
is initialized in xe_gt_mcr_init().

xe_gt_enable_host_l2_vram() is used to implement WA 16023588340 that
needs to be done as early as possible during initialization in order to
be effective since the MMIO writes impact it. In the failure scenario,
driver would simply not be able to bind successfully.

Moving xe_gt_enable_host_l2_vram() later, after MCR initialization is
done, only incurs a few additional HW accesses, particularly when
loading GuC for hwconfig. Binding/unbinding the driver 100 times in BMG
still works so it should be ok to start handling the WA a little bit
later. This is sufficient to allow adding the MCR annotation to
XE2_GAMREQSTRM_CTRL.

Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240814095614.909774-2-tejas.upadhyay@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/xe_gt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 0062a5e4d5fac..7737d7266b42a 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -555,7 +555,6 @@ int xe_gt_init_hwconfig(struct xe_gt *gt)
 
 	xe_gt_mcr_init_early(gt);
 	xe_pat_init(gt);
-	xe_gt_enable_host_l2_vram(gt);
 
 	err = xe_uc_init(&gt->uc);
 	if (err)
@@ -567,6 +566,7 @@ int xe_gt_init_hwconfig(struct xe_gt *gt)
 
 	xe_gt_topology_init(gt);
 	xe_gt_mcr_init(gt);
+	xe_gt_enable_host_l2_vram(gt);
 
 out_fw:
 	xe_force_wake_put(gt_to_fw(gt), XE_FW_GT);
-- 
2.47.0


