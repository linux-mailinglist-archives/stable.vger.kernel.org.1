Return-Path: <stable+bounces-45960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FF8CD4EE
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151341C222A0
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440DF14A4F1;
	Thu, 23 May 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbVM5iVJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7F1E495;
	Thu, 23 May 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471624; cv=none; b=jtQ+BinNaxNqEbYqB9/voHwLwEzbNuAeq84DP7Xm+3g7t0gVN7g8F8qdCySyKFW6dbjMTA21nf4Dep8pJXKMgW+cgcN4rLWDbNZRj26KkjfojJspLKn6S6e8TCUM/Zmnhuyh8qbIILMqWQF8ptWVRNrc3przfKHCasCaRQkqhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471624; c=relaxed/simple;
	bh=eYAHQBTLuS0nAWdW8Q2PeqwvoBoaWkUHPFim7U0bnT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nlaAsqb8r6Fo3MOFY7IYSLsDUJj6kF4YseeGwPffgveItI2zkeJZ+6/ES/QsOyJEDkYaOpvJPr+ocgAy6SKFRK/D1A45l6Yrlb0ACd+t1EttzmbYVt6mjlgtLizYVNs35ZFzBxwuQtM3QHUadGIIXRQ4PgjcbIeSQ+j9VxKBe+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbVM5iVJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716471622; x=1748007622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eYAHQBTLuS0nAWdW8Q2PeqwvoBoaWkUHPFim7U0bnT8=;
  b=NbVM5iVJ21Cn7uvEH/Q52QaPZsG2z2aN7gSNDoFPRGy/Yce9RApr3gTT
   SI547g6nbyrC8rdsKSnnmH2YXYncgMdfL49V2EoOPVLutxbvq22ReXUt+
   zaQ6LXwIxoqNyLEXUViIosrhq2LucNc6U7U1oIcmTCTxBuOHkT2YZCoy7
   VYLgIlpq5o3qbT8zmAKDFLN7J8uoW8X0y4L5qgm69kADofNyqBQvbMQgd
   uHBi7e3scN61vGQZzIwREPEMhI+J/OfRc4/zDHpiJcthzEuSGO0EOTJrQ
   qmHOGeLyFGQf0gtUDEsnv6RlltkgDNafhpnhVj9fN9In7MqoqsCJcHaNR
   Q==;
X-CSE-ConnectionGUID: tdhyFOJYQvucsnR46v9GCQ==
X-CSE-MsgGUID: d76Qtnz4ROaRtpbHFF6CZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="23922490"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="23922490"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:40:20 -0700
X-CSE-ConnectionGUID: 60SQMP+GThCQJ+N0T81BXA==
X-CSE-MsgGUID: 2UzRAYvsQhem3VM7pfn3oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33740010"
Received: from wentongw-optiplex-8070.sh.intel.com ([10.239.154.12])
  by fmviesa009.fm.intel.com with ESMTP; 23 May 2024 06:40:18 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Hao Yao <hao.yao@intel.com>,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v2] mei: vsc: Don't stop/restart mei device during system suspend/resume
Date: Thu, 23 May 2024 22:01:34 +0800
Message-Id: <20240523140134.506033-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dynamically created mei client device (mei csi) is used as one V4L2
sub device of the whole video pipeline, and the V4L2 connection graph is
built by software node. The mei_stop() and mei_restart() will delete the
old mei csi client device and create a new mei client device, which will
cause the software node information saved in old mei csi device lost and
the whole video pipeline will be broken.

Removing mei_stop()/mei_restart() during system suspend/resume can fix
the issue above and won't impact hardware actual power saving logic.

Fixes: f6085a96c973 ("mei: vsc: Unregister interrupt handler for system suspend")
Cc: stable@vger.kernel.org # for 6.8+
Reported-by: Hao Yao <hao.yao@intel.com>
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/mei/platform-vsc.c | 39 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/mei/platform-vsc.c b/drivers/misc/mei/platform-vsc.c
index b543e6b9f3cf..1ec65d87488a 100644
--- a/drivers/misc/mei/platform-vsc.c
+++ b/drivers/misc/mei/platform-vsc.c
@@ -399,41 +399,32 @@ static void mei_vsc_remove(struct platform_device *pdev)
 
 static int mei_vsc_suspend(struct device *dev)
 {
-	struct mei_device *mei_dev = dev_get_drvdata(dev);
-	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
+	struct mei_device *mei_dev;
+	int ret = 0;
 
-	mei_stop(mei_dev);
+	mei_dev = dev_get_drvdata(dev);
+	if (!mei_dev)
+		return -ENODEV;
 
-	mei_disable_interrupts(mei_dev);
+	mutex_lock(&mei_dev->device_lock);
 
-	vsc_tp_free_irq(hw->tp);
+	if (!mei_write_is_idle(mei_dev))
+		ret = -EAGAIN;
 
-	return 0;
+	mutex_unlock(&mei_dev->device_lock);
+
+	return ret;
 }
 
 static int mei_vsc_resume(struct device *dev)
 {
-	struct mei_device *mei_dev = dev_get_drvdata(dev);
-	struct mei_vsc_hw *hw = mei_dev_to_vsc_hw(mei_dev);
-	int ret;
-
-	ret = vsc_tp_request_irq(hw->tp);
-	if (ret)
-		return ret;
-
-	ret = mei_restart(mei_dev);
-	if (ret)
-		goto err_free;
+	struct mei_device *mei_dev;
 
-	/* start timer if stopped in suspend */
-	schedule_delayed_work(&mei_dev->timer_work, HZ);
+	mei_dev = dev_get_drvdata(dev);
+	if (!mei_dev)
+		return -ENODEV;
 
 	return 0;
-
-err_free:
-	vsc_tp_free_irq(hw->tp);
-
-	return ret;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(mei_vsc_pm_ops, mei_vsc_suspend, mei_vsc_resume);
-- 
2.34.1


