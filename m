Return-Path: <stable+bounces-54964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F84D914024
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 03:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B551F2319E
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 01:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386DC8FF;
	Mon, 24 Jun 2024 01:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S0LO/7rP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D779F6;
	Mon, 24 Jun 2024 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193400; cv=none; b=oTn/g2HiHQB6RiFhQuUHb5Cy8ZsrROAlJonG2HlmlX1GJGtzkfUMKTYvzdr0gcpLTCfcFcNpWztuE2jEd3PKKOsbbub/m1QnzY3AiCAY59LE4H/uMlTTLXxUe7X0u6NXr80DE5HOnIaYJuUb6JE1kcUWmtYEXNv8PDBbag15Py8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193400; c=relaxed/simple;
	bh=dlSC/zVmzLNuhEKcph1rM7e1p5iGGVD5RK80YRfDr3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTRw8j+PxoSDTsEq05D96R/u/8kgPnFBIrP3ffrqb7QVdleb9vId1PGx1VFAwQ5dib23GxFMA5+UPySpiBy8iFYBBqJOVdKyLOz2mP7PptTzrOUaFNLcjXY9IlNbA+ZfFoZhrjanb4CN5uvRBiDxSE6ZD6cKzn+9/D+v2dWqIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S0LO/7rP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719193399; x=1750729399;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlSC/zVmzLNuhEKcph1rM7e1p5iGGVD5RK80YRfDr3E=;
  b=S0LO/7rP6KyEWVyD8/egXoSPWQktHEwBq/GIv76lKPhYteRys2FI7eXK
   pCmybBVxNLocJO9xtrst0xj3CwlGcnb4bWay7Oex3io8/fpKTPNaYN8+r
   /qWE2goX0GgP5lsguR12+0ruwGTC/UtHpxetqOXeN5U8e5PVQnj8HOG+d
   KW3bxatEY3U9j7BuG+3Xm3vc9O2VME3MBMmIJCRe0RTZWQmdlYVnFRT5U
   YZ47jNzAbyVQOEmGxwc/9CUYb1tN+5BiBtTSae7vE6swh+vx5XpsSIzgd
   BjPzVnL+4zYPNqeBGzFXlwqPCmQ0RJSApQH3ew80cL1bFfVsVNnbHeKEg
   w==;
X-CSE-ConnectionGUID: wU4ZmImBSK69R+K/JLBmiw==
X-CSE-MsgGUID: +fHO8bG6StGBFDhUiiDgCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="12202754"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="12202754"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 18:43:18 -0700
X-CSE-ConnectionGUID: WRb/btplTfeXyShIZm08YQ==
X-CSE-MsgGUID: vwnc/n6OTfCuija306mzLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43821188"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2024 18:43:17 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v2 2/5] mei: vsc: Enhance SPI transfer of IVSC rom
Date: Mon, 24 Jun 2024 09:42:20 +0800
Message-Id: <20240624014223.4171341-3-wentong.wu@intel.com>
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

Constructing the SPI transfer command as per the specific request.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 5f3195636e53..fed156919fda 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -331,7 +331,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 	}
 
-	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, tp->rx_buf, len);
+	ret = vsc_tp_dev_xfer(tp, tp->tx_buf, ibuf ? tp->rx_buf : ibuf, len);
 	if (ret)
 		return ret;
 
-- 
2.34.1


