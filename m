Return-Path: <stable+bounces-55015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A515914E9F
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 15:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88041F23176
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 13:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74FE13F42C;
	Mon, 24 Jun 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFnUBlxH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4513D8A4;
	Mon, 24 Jun 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235783; cv=none; b=JZT4RoZN3424uZkv/fN+zys5pT6I9CPQZAALvhx7MflpN7WPKqBparVevLtzGilqGBPj3v4bawhJ2yXcKkPzTkQuMKc/sj6qUG+Uzr3UXT/qOfRtBm0jTAOX0Kk1CbnE3mIvTP6fMNcF060+Bzw8h//8vFmwYooSDcfRZCEcEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235783; c=relaxed/simple;
	bh=dQSS+cisNfaft2A5cQ4bXxLvcIiPOe9EipzRaGlA4QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OK1Unn9g9+2SEK+EpOJ4Jph5YpMuuk/LI4DV3J60AcECcNGu0k7fzoN44lWN2bHK+Ir5cmgoDZFRWoU/Lt54xW04HuRioWngmcCE66m4TPdozK72MCiM8dHCf1gsarX+HTZ2tT3pcho7+3S+ePPFpqa/U0k5Z4rjJ+0e/yBhXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bFnUBlxH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719235782; x=1750771782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dQSS+cisNfaft2A5cQ4bXxLvcIiPOe9EipzRaGlA4QI=;
  b=bFnUBlxHgy8aSi+FOxl9DCjldfh7x/oHhlZTpjfKJWurtveLgzw2/1PI
   d1cViWao8h7+5iGEvr5uEq+vU9nz6w02gybIlzGphCvK+67JRuSP+w/R6
   DKGictQa+j3x3MMu9IZkK0ljZ0VdiARAMBBeLgix3KbUnlO1UTlfnv1Jj
   ZqdB/CeaLaaxJOxum0pE8RyJPuXtesO3GDEsmCBkHyIQADacHSKLMJqFa
   OFrXRzwruq3Hmh4AMMFXtBBzH/xPX/pyoT9GcRFtlljfKxgeL9fANu8rp
   uFYjmJ06AwfN/K3z3hthsep2jMjFKMaCA0UZjwFU/v5g+291g6WLPXVSU
   A==;
X-CSE-ConnectionGUID: Tu0QBPLXRH+fIH7fKqNp3w==
X-CSE-MsgGUID: vwg2eRgeQ2eCGd9SE5W5Kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="26830737"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="26830737"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 06:29:41 -0700
X-CSE-ConnectionGUID: 9RPJwmkCQZy7zLJsmO+BpA==
X-CSE-MsgGUID: mygQ8wcYT5+1+DphH/JbIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47746673"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2024 06:29:39 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v3 1/5] mei: vsc: Enhance IVSC chipset stability during warm reboot
Date: Mon, 24 Jun 2024 21:28:45 +0800
Message-Id: <20240624132849.4174494-2-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624132849.4174494-1-wentong.wu@intel.com>
References: <20240624132849.4174494-1-wentong.wu@intel.com>
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


