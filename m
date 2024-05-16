Return-Path: <stable+bounces-45241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A127F8C7007
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 03:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2021C210FA
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 01:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0910F1;
	Thu, 16 May 2024 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwEaGJP6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE2EBB;
	Thu, 16 May 2024 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715823201; cv=none; b=T+RHPn9M27XXexQYOV4GbwjFOA80Z6Ad3jfabZTtjHT2BIkn2u9Kti++j+l8Z/kDKA0TcKNB+BhzoksqnRqMtNGDJU4m7L6c0cewSHdjOcmWedoJAW9k+QvcKJN6FBSFJZYjwnooF7tQ1MuF7g+2xtmVZbZn+8PtNK8UOiDJNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715823201; c=relaxed/simple;
	bh=L/MSeE85WwDv+k9wnUzILdJTM7kfnpnvNhjH6yhtOPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSGDvD2X0kOHFPGEDJQRkIv8ozDtB7tIa5jFKDhenenOWTQ5JYJP+u3GR9+nP+OvLcTXxltVHY8jjph+OqJOp9+UsyDXxE3q48yMOGV5tig1+gQ6LS1TJTKSCorkPd3ABAUllr8eGzvU7poSTxtibCN09kmWrOeTp03Js0KKNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwEaGJP6; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715823200; x=1747359200;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L/MSeE85WwDv+k9wnUzILdJTM7kfnpnvNhjH6yhtOPw=;
  b=LwEaGJP60KYbkjK36GlxJyLswavXQtapRPu92PeLejKGcvecuJOmKY2G
   dCaJwVigubM04DJ1YvX4Qdt8hSc0m8FZlhjwEp+ZgyIOnU3v6j43GrUSy
   rw/Xsh9s50SzRDTVJwzwu2jS4tH3DbQhP4qAkmVkhJCpYNUSyeCR0uyXY
   +DGvAlmroobBXbmOPsGlAjiNnl3FDfUebKaYCm3chl7cRd4Tkz1UmfjGl
   0pMlN6MN6oc3RhNOXSShju8yYNcmenoHK61XRQl0z2kHqChr+A4T4qrQ1
   RGI14TaU90AhAkMDshujj6Q4LBspCz3uR9+acCLdyV/4PBfqgcBm26gxP
   w==;
X-CSE-ConnectionGUID: jz019q2SQsK2VkUMwAJW7w==
X-CSE-MsgGUID: QCi6LtSgRtu5p1lSByaB7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15686570"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="15686570"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 18:33:19 -0700
X-CSE-ConnectionGUID: sRUhUOvISA6D5GZbceR8Hw==
X-CSE-MsgGUID: zYNpDQmeRn+ekVV0I9yNSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="35977510"
Received: from wentongw-optiplex-8070.sh.intel.com ([10.239.154.12])
  by orviesa003.jf.intel.com with ESMTP; 15 May 2024 18:33:17 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	hao.yao@intel.com,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH] mei: vsc: Don't stop/restart mei device during system suspend/resume
Date: Thu, 16 May 2024 09:54:00 +0800
Message-Id: <20240516015400.3281634-1-wentong.wu@intel.com>
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

Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Reported-by: Hao Yao <hao.yao@intel.com>
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
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


