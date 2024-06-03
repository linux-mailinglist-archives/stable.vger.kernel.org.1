Return-Path: <stable+bounces-47884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0368D8834
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 19:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CBDB22C24
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 17:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F9A13776F;
	Mon,  3 Jun 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fbKeq7gH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D120317
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437165; cv=none; b=mvYDlfsktw9ilW/gQCuEPw425BwOgwmdmd1pt6nJV9cfOUFAmYoAfmVnl6W2DVnM2FJQton0Q+rf1WsbJEGWQdY0m9q39s+cvmUhX6LP0joH9rcrzqPEo73jm/06SdMz040sPv6nYYMZAv1JGw+IuBHHx6KH9SMDCB++qTVOros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437165; c=relaxed/simple;
	bh=7RiY7iCEcP9ZQAec8XAiUTSRCn7j/OquBUZlIDtRagg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kS0CMj3CrX2PNdj3DgnQY/61ewpLFFIeeN4qcCstsmOuBS4O9UEBnaNTsYIiBvZO5FTD+2SxDYkcY/S2wCZFJtGK8DYp8W3ZD0hJS4H6Vxte08KsgdzsSMYK9monjrfGKSzt23T1iQZ1/3ymotf31d0lVTSSRZYV7Fyt0VLxTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fbKeq7gH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717437164; x=1748973164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7RiY7iCEcP9ZQAec8XAiUTSRCn7j/OquBUZlIDtRagg=;
  b=fbKeq7gHdFMBPwStDky/KP7nbi3r341EIw468zD5NoWxneBmEQ4yCoIf
   N+b02wsISfyN+pu4h4VLp8F1JPvhE5B+1/jnbE462MOXjB2yvkGyWvzrn
   9pwVipGgH7YQehFDJhz1kB1uBhI+siaE0j6fYjlVbl7k609kO0iV9jH8h
   oEilDiCLYzdqGqBU8Cq1pgErfzqsO/g7cVslGjT27svQxnbJnt5GVYO6c
   AsP5pEdnwpqTUO1pSQiCj/rtd8lPsC4RACDu++Ry8HHBytM0V9qbdFtz/
   E2DAnsQY+zW1YKbyvbIRCIP6FBf3Vq/5RMQHbCn+LNmXu0gCIRtfzaSHd
   A==;
X-CSE-ConnectionGUID: 4WWV0SOOQpCoTuXak4fZKQ==
X-CSE-MsgGUID: 6YQp9j/0Tc6oWlCCKIwqXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14103395"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="14103395"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 10:52:44 -0700
X-CSE-ConnectionGUID: o6lOeMmcQzeG32RNxpintg==
X-CSE-MsgGUID: JALQqogjRW2URFqsFdQ+bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="36977745"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 10:52:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Restrict user fences to long running VMs
Date: Mon,  3 Jun 2024 10:53:12 -0700
Message-Id: <20240603175312.1915763-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

User fences are intended to be used on long running VMs, enforce this
restriction. This addresses possible concerns of using user fences in
dma-fence and having the dma-fence signal before the user fence.

Fixes: d1df9bfbf68c ("drm/xe: Only allow 1 ufence per exec / bind IOCTL")
Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_exec.c | 3 ++-
 drivers/gpu/drm/xe/xe_vm.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 97eeb973e897..a145813ad229 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -168,7 +168,8 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 			num_ufence++;
 	}
 
-	if (XE_IOCTL_DBG(xe, num_ufence > 1)) {
+	if (XE_IOCTL_DBG(xe, num_ufence > 1) ||
+	    XE_IOCTL_DBG(xe, num_ufence && !xe_vm_in_lr_mode(vm))) {
 		err = -EINVAL;
 		goto err_syncs;
 	}
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 26b409e1b0f0..85da3a8a83b6 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -3226,7 +3226,8 @@ int xe_vm_bind_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 			num_ufence++;
 	}
 
-	if (XE_IOCTL_DBG(xe, num_ufence > 1)) {
+	if (XE_IOCTL_DBG(xe, num_ufence > 1) ||
+	    XE_IOCTL_DBG(xe, num_ufence && !xe_vm_in_lr_mode(vm))) {
 		err = -EINVAL;
 		goto free_syncs;
 	}
-- 
2.34.1


