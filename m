Return-Path: <stable+bounces-54883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4426D91393B
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 11:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E389A1F21C88
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3638E7442F;
	Sun, 23 Jun 2024 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L5qiUZVf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD05FB9C;
	Sun, 23 Jun 2024 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719135151; cv=none; b=qHot9+MoZraDnJ8HMFSA0aWPjSdJqb1y8x++AhIvUx57pCqDsXB9ObVHnToiCIteHWw5da1j8uLKuCv3Em86r6dCMyZFEa9wIlrOimNuQ+souaNL1wqDwyU/Zn8HW9vEgxy3FsuXfpYwM95wRhDMYEzJM2SM7cJJMHwB49KAtjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719135151; c=relaxed/simple;
	bh=XmOQcTrxfUfHjL/0izCrhg/Yqc+CNqGhOUcXysJjsvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DOQG3t/nefJQ7debzE8n1JJAV2eghJJzXingtSKmpqxBFDBxxjfbOZijqEjz5ZG18lbo5EzVKa5+WdxF5kC6mvZ9+E0GfIcns4rE4MAGCc9q3seaqFSKF0k+QH7YaWCOrulGqO7p/QqQQWt21/zYQLxwKjM9kOwpy9IMZC6YIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L5qiUZVf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719135149; x=1750671149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XmOQcTrxfUfHjL/0izCrhg/Yqc+CNqGhOUcXysJjsvA=;
  b=L5qiUZVfs/28nSMPdFJYtcohhoV8gbXW32vo+DnnSCJFTw45d6sIoXrQ
   3QP7ILno3T3PSYs7/zima6WEgPZGre6D+1nsRlBYe6W/7vrqBcwK1ATjk
   6HbgK8LBkZNi/Xy5ZCX+m/o2j8jXM6ObqUCiIOK9RQiy9YK0R/xu7d9f7
   oqAR860+Ik/X96ezOb4nc0Hz+UMEE4yHqhRFRhr4xZ+ZqRm3+sj9DuaMt
   coij4CM/TE4LzhRQ1gE4N3DcbAOd6U/Ae3Y5JTFUfy+tS5dVRBcHd5Vwc
   Xh4v9ZaVrML8rKsTd3CfIa1htVH73nPYa9BQAcQEwLZ1sFW4QPhj81ocM
   A==;
X-CSE-ConnectionGUID: toXZe1SNQYym5rN010STbA==
X-CSE-MsgGUID: QDrb+Un0SM+/pCiSP1Mw7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="16089086"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="16089086"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 02:32:29 -0700
X-CSE-ConnectionGUID: l0olGh5WTniS46YTWBw8fA==
X-CSE-MsgGUID: Md9Tz+HIQmm5mXVYkSMaxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="73761709"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa002.jf.intel.com with ESMTP; 23 Jun 2024 02:32:27 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH 2/6] mei: vsc: Enhance IVSC chipset stability during warm reboot
Date: Sun, 23 Jun 2024 17:30:52 +0800
Message-Id: <20240623093056.4169438-3-wentong.wu@intel.com>
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

During system shutdown, incorporate reset logic to ensure the IVSC
chipset remains in a valid state. This adjustment guarantees that
the IVSC chipset operates in a known state following a warm reboot.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index dcab5174bf00..4595b1a25536 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -570,6 +570,19 @@ static void vsc_tp_remove(struct spi_device *spi)
 	free_irq(spi->irq, tp);
 }
 
+static void vsc_tp_shutdown(struct spi_device *spi)
+{
+	struct vsc_tp *tp = spi_get_drvdata(spi);
+
+	platform_device_unregister(tp->pdev);
+
+	mutex_destroy(&tp->mutex);
+
+	vsc_tp_reset(tp);
+
+	free_irq(spi->irq, tp);
+}
+
 static const struct acpi_device_id vsc_tp_acpi_ids[] = {
 	{ "INTC1009" }, /* Raptor Lake */
 	{ "INTC1058" }, /* Tiger Lake */
@@ -582,6 +595,7 @@ MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
 static struct spi_driver vsc_tp_driver = {
 	.probe = vsc_tp_probe,
 	.remove = vsc_tp_remove,
+	.shutdown = vsc_tp_shutdown,
 	.driver = {
 		.name = "vsc-tp",
 		.acpi_match_table = vsc_tp_acpi_ids,
-- 
2.34.1


