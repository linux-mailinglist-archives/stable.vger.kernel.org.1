Return-Path: <stable+bounces-109205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D7A131BE
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 04:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662797A29C6
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 03:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDA2148850;
	Thu, 16 Jan 2025 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HRDwsNo/"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F11487C8;
	Thu, 16 Jan 2025 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736997938; cv=none; b=kbEZPYiwok2C87PzVP9KSQJ01QBlCMFUciUo89gUkHt0nbEhEcEVhlhv3Zo/u0vyf9RM1NLuO36952tz42yVi2ZgSXWTH766P1NUbxVboZIqJwNmIfSS7/CwLFmtkuLPBCrZLVN18qvJd+/u63JtLaDYIsYXxJVhdBvQnpcFCsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736997938; c=relaxed/simple;
	bh=td3ZZ0j0HLouPMAMZAhj2DUcSXrlnPeWRXzfXSyW9Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7ttHNFLI0Th/yBrfA5E72QNi916Id3+OLa6TIz5lbD5EUrV50nDeOi93Zs58TAEsI/2yn9NdiGzLJM36nuXBjdGE9oE1PNdxYIYSyB46/nBQI3lGOUGSl9aVPc9u9egbnlN2obfT7n18CdY3Y9aldSYTThg3qvQlK5X+4U2Rrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HRDwsNo/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736997936; x=1768533936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=td3ZZ0j0HLouPMAMZAhj2DUcSXrlnPeWRXzfXSyW9Gs=;
  b=HRDwsNo/LydDY+NKPe1bgjNhVavjnE13NXiNYKbSknncXBusW9DQFVoa
   gumw4rtpRS3m0u/YKDHBKxqLAslCDoDrBR6F0s3FaA8WooQ6STSD52h4e
   z/DovjlYT0BWAzPuOYm5ixsG5Dgfb3Ur1+899jqS3ungeTlaTR88Wa656
   BEk/x9JnzzpxvlSPwaJNipUi1CmaUrC7f+fN0lAm140JO1yp7QS56AObn
   e2eAVenApQHpVrtvT8zqSgtXCnWd4lBQ+rEifh6rY80/7t1IcR8cvDjxy
   D9zoXZG/4OA0/WeLWDrU4uphOEx1ZJi2TEv3J/yhaXTYxiBy0BytWwyoy
   w==;
X-CSE-ConnectionGUID: j/tdAceTRaKNCBWpR67woA==
X-CSE-MsgGUID: gDDHeOynRqeGUTKKH0J6Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37478918"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37478918"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 19:25:36 -0800
X-CSE-ConnectionGUID: yEniKsXdQiWkMRkAKPxzKw==
X-CSE-MsgGUID: Kd575k5bQYGSVVDfyZxTwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142604370"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa001.jf.intel.com with ESMTP; 15 Jan 2025 19:25:33 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux@treblig.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	u.kleine-koenig@baylibre.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 3/3] mtd: rawnand: cadence: fix incorrect dev context in dma_unmap_single
Date: Thu, 16 Jan 2025 11:21:54 +0800
Message-Id: <20250116032154.3976447-4-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

dma_map_single is using dma_dev->dev, however dma_unmap_single
is using cdns_ctrl->dev, which is incorrect.
Used the correct device context dma_dev->dev for dma_unmap_single.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 8281151cf869..2d50eeb902ac 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -1863,12 +1863,12 @@ static int cadence_nand_slave_dma_transfer(struct cdns_nand_ctrl *cdns_ctrl,
 	dma_async_issue_pending(cdns_ctrl->dmac);
 	wait_for_completion(&finished);
 
-	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+	dma_unmap_single(dma_dev->dev, buf_dma, len, dir);
 
 	return 0;
 
 err_unmap:
-	dma_unmap_single(cdns_ctrl->dev, buf_dma, len, dir);
+	dma_unmap_single(dma_dev->dev, buf_dma, len, dir);
 
 err:
 	dev_dbg(cdns_ctrl->dev, "Fall back to CPU I/O\n");
-- 
2.25.1


