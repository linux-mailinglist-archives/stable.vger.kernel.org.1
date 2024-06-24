Return-Path: <stable+bounces-54963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB000914022
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 03:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B363282CB2
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 01:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215005256;
	Mon, 24 Jun 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSh/xBMG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D32564;
	Mon, 24 Jun 2024 01:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193397; cv=none; b=Oyjs4pmruZ1f2o0SixeauNASZAQgbAJqA+HA1d3auutZ+tZtpy7du+o8wsPCzP0dZ1/ChgzuLvk1pf+XWNrxP6ZhfJH86bcmoIGBkA1xjbwpzKb++UtUCiuG7p+riTXLkhGXS2/5jLx+xoARfOMXLjMnJmly+cdJNKZXJwbM2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193397; c=relaxed/simple;
	bh=dQSS+cisNfaft2A5cQ4bXxLvcIiPOe9EipzRaGlA4QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UzLcILbHylzI+yJARSYM3tjMc3v2gkNBDY/+UKKpWCiokLNzYNp50wLVNnRyzszlXl6IwiLQeL0nUNMjvoyPhe6DuPlOUdmotfAiTwFfQgyXi7xw1uJ/i8qlbQw0gNRUHQ1WDWjmYougNPM6IeaRPtG5obtN/hJZDI28KWAYVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSh/xBMG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719193396; x=1750729396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dQSS+cisNfaft2A5cQ4bXxLvcIiPOe9EipzRaGlA4QI=;
  b=lSh/xBMGM6pBzH1iys/UOrgg8kVKhoagccTbp5q/EQpM+tht8fnZWKGp
   02orl9pOPC+lFIjtU5m9LylhrMmPqVEEqyMshCag+RGvrNIFbNmW3P+aG
   k1f3/Vz7SR9hnFo2KpcdJst+YgMcn60y+NZJ+gT/0AqJTSk204inK07mr
   ILG+QvzdEr8S7nT+LxBjKbH6LLgrEHRUIK3kE+CSHNQj7VYh+NAwcHlH1
   H/LBfN06guxfqFKg7x1uP8aDYJyqggXy8BFIBiS5BOj6//L2o+2SgdIAT
   /g4StshFxi1tik6FmbRiYQdVdjpVifEmfKYwgHPu8/RFLPQdI8hsMLnwu
   w==;
X-CSE-ConnectionGUID: DNG8NNPPSXyMomvLVng0VQ==
X-CSE-MsgGUID: JwJVOIdAQGmrG5vqC2UKUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="12202748"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="12202748"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 18:43:16 -0700
X-CSE-ConnectionGUID: b+DP2NKySZWqjRby6sfcFQ==
X-CSE-MsgGUID: ZCT72PlLQ0OMgcIHe9+V0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43821151"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2024 18:43:14 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v2 1/5] mei: vsc: Enhance IVSC chipset stability during warm reboot
Date: Mon, 24 Jun 2024 09:42:19 +0800
Message-Id: <20240624014223.4171341-2-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624014223.4171341-1-wentong.wu@intel.com>
References: <20240624014223.4171341-1-wentong.wu@intel.com>
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
index e6a98dba8a73..5f3195636e53 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -568,6 +568,19 @@ static void vsc_tp_remove(struct spi_device *spi)
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
@@ -580,6 +593,7 @@ MODULE_DEVICE_TABLE(acpi, vsc_tp_acpi_ids);
 static struct spi_driver vsc_tp_driver = {
 	.probe = vsc_tp_probe,
 	.remove = vsc_tp_remove,
+	.shutdown = vsc_tp_shutdown,
 	.driver = {
 		.name = "vsc-tp",
 		.acpi_match_table = vsc_tp_acpi_ids,
-- 
2.34.1


