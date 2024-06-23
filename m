Return-Path: <stable+bounces-54886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7137E913941
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 11:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC6D1F21F2F
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE412F5A0;
	Sun, 23 Jun 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9xdMbrj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952912E1CE;
	Sun, 23 Jun 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135166; cv=none; b=OnH2OeCnavjgs7/9/1s/0oXTXHleSC2nWE673EUo/duoGgQeHA5METBfug9B+CQRbxqGMeFxbwlDirKJsxI9OvW7DGfs0eZ8PIfJpgBwx4ATSgyUtDobfWaWNtv/kfqs8C2s6xHx5f6YYOZVOukghHFkw/JPi99HUI7yrTxw8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135166; c=relaxed/simple;
	bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k4HrI6yKZI1KDml9jkqIhQEzVhB/YEAnmFSCV0Aoy1w/GYeM9wR6gPAVfd3C0gN7Cb0p2V0YOesCt+mC0HOJiU+NoFbx3eqnt7aaLnIj6bdF3LR1Pn8+vCaCvz/BM8eeZ9FdyU36CRMxCBrqxiC+3KfuipkNufFfXkU0wC+nYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9xdMbrj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719135164; x=1750671164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JM1sD9QP4RyHSPhRqlUabkVUXwe0DuYqN6xM1zvvobw=;
  b=h9xdMbrjV2k3RJx/2j8wlokYqibL1JMJfGLt0z0U7kDxUHMvGTQ0VKxI
   a9iesIwT6GEzldDo/dQonx6rdg/zFj98IN/og6IQSp8PLPIMQ7hI8zNJ7
   sUY08yctto1X/R83IsjDBtK6NhJpStXYB6tsneSLMWC+XqbfLJtU+pan0
   Bddkj7SzOeDcVMN8aYS11JXkfUDm6Yy/9lHKgeN88ECKzfOoCSBBoXEbg
   r4q8HwnzkQqIaLFgVqk9JNiRLgf5p4zNZLN29HkCeJOy/poGMmDDH1iUK
   UYKzZSByqz+sNquXhh7ET3lloamIsc/NXPZrbutPXGNDEwPN/1JRtOA0V
   w==;
X-CSE-ConnectionGUID: FqoXEs9gS2utdn/Ndwmktg==
X-CSE-MsgGUID: tFaomdIiRnytyI+oQ4UuSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16089098"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16089098"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:32:44 -0700
X-CSE-ConnectionGUID: wCZye3qESUy0kwHa2b+nxQ==
X-CSE-MsgGUID: SUUb/IcfTy6jTTz8eKuVFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="73761754"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2024 02:32:43 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH 5/6] mei: vsc: Prevent timeout error with added delay post-firmware download
Date: Sun, 23 Jun 2024 17:30:55 +0800
Message-Id: <20240623093056.4169438-6-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623093056.4169438-1-wentong.wu@intel.com>
References: <20240623093056.4169438-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After completing the firmware download, the firmware requires some
time to become functional. This change introduces additional sleep
time before the first read operation to prevent a confusing timeout
error in vsc_tp_xfer().

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/platform-vsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index 1ec65d87488a..d02f6e881139 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -28,8 +28,8 @@
 
 #define MEI_VSC_MAX_MSG_SIZE		512
 
-#define MEI_VSC_POLL_DELAY_US		(50 * USEC_PER_MSEC)
-#define MEI_VSC_POLL_TIMEOUT_US		(200 * USEC_PER_MSEC)
+#define MEI_VSC_POLL_DELAY_US		(100 * USEC_PER_MSEC)
+#define MEI_VSC_POLL_TIMEOUT_US		(400 * USEC_PER_MSEC)
 
 #define mei_dev_to_vsc_hw(dev)		((struct mei_vsc_hw *)((dev)->hw))
 
-- 
2.34.1


