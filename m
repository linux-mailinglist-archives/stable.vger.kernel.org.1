Return-Path: <stable+bounces-46299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57828CFFCB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C86B23844
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E7F15E5D1;
	Mon, 27 May 2024 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kVO2pEnD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B6613C3CA;
	Mon, 27 May 2024 12:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812230; cv=none; b=S9OWYQaf4uUHE+1lXKMLVhMNKhsvDgfpH/KUqvJXUj3YGxDOcXvt7CYpv2puqftjJL+7PQt89Utaby2OrhaJqcap2NE+ddiCmfReLJ7pnLoX0Qs+fBMb2uxpf8h9Bgu0Qs+0T/9Jzd8QGzsg3bmwiU5sErYrKanXIT38huTxjoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812230; c=relaxed/simple;
	bh=v7mwebxOX/a1s/ML0ZEls3SJ4IPgSe8KPM9vsKrPK9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FS8xG5enWKMHCZkFqaXpAKqx8u0ZyY5RScgXgiksNxpVbEMk7kvuJw4AJdlDf0/acfLIWO2TMV1u/g6qi3bgCoQe80UYKPzhf8/6To54i7Gz2zhxnVhUjDk5i+7JulmYlxQp+e5m0+90Du90npW53LrOmRxLJgfQVaI0vlJbCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kVO2pEnD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716812228; x=1748348228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v7mwebxOX/a1s/ML0ZEls3SJ4IPgSe8KPM9vsKrPK9I=;
  b=kVO2pEnDjK9x6TH/ykKA6NnsnfD4DDNcIfUHHsP7VECYWIw74hhX/4b6
   kRZq2VwflOUlrrPVjL4hP1pL6tciwyIfN/yVpd+/PWjewCsXAndy4TzHy
   EkzL5YvgvkME2ilE/eOPAMUXpFLLWwgltsnUj/yPKI2EXd8l3XCFMk/wg
   YRzNvW42nNAzMdKDK4GzGaUtgrOZ3f7HZOQmaOIuiBoGfUI7Msgr4cLVq
   /dpocrA4oku7upUFQC//9x5JvReZbISm0+47Jfatmc8wTJGRej61Pdubv
   J0lJC8Hp20B6cNaWdITb1mTgOb+YNJ0HT4sXpmPeHuQ6pm2x0HwffR9vD
   g==;
X-CSE-ConnectionGUID: 57/v2V0xRy6xdyc7HNT0UA==
X-CSE-MsgGUID: SOu1kKn8RUOUKHA7hloO1A==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="24253945"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="24253945"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:17:08 -0700
X-CSE-ConnectionGUID: r5jiZ86jQhaITYpFAWV54g==
X-CSE-MsgGUID: mgrFYRFzR2iM6Xu4Hio2ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39289986"
Received: from wentongw-optiplex-8070.sh.intel.com ([10.239.154.12])
  by fmviesa004.fm.intel.com with ESMTP; 27 May 2024 05:17:05 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Hao Yao <hao.yao@intel.com>,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v3] mei: vsc: Don't stop/restart mei device during system suspend/resume
Date: Mon, 27 May 2024 20:38:35 +0800
Message-Id: <20240527123835.522384-1-wentong.wu@intel.com>
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
Changes since v2:
 - add change log which is not covered by v2, and no code change

Changes since v1:
 - correct Fixes commit id in commit message, and no code change

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


