Return-Path: <stable+bounces-114474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66867A2E3C3
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 06:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2FC3A57D9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 05:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936EC1922C0;
	Mon, 10 Feb 2025 05:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0r3cLW+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4B191F94;
	Mon, 10 Feb 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165987; cv=none; b=KiL65YVvJycn1H1Ww47M6Yd/SzLLhbSsRlKnUXekUyRSVBye7FYO8qpj4nSUPjBw06/wniTcUaQCreQU7PNHpyJJZNRARyY/uFM/yJp9WFOxIr3nlPkDD54URw9JiuUo6ko+r7Y+RTknygbuK1BKw9DLxtJfBI9yzWLrbR+sXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165987; c=relaxed/simple;
	bh=buG6voVc5zfk4HiKSZp19+HKiFIsBIA6Ww+wD6EEDD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWXeR+d/dcyu33GPwOQpeFd9ek2RQ+wvTBq0K4yirlWQ+rqn3TRPMMJtaOpDDNiec8kOJ7Jckg5C86O+tKznie+g/UhU1CjnqKIIYEYxzd4/zSxcXB2NNKaojfBq3zt47veKl69HdglsXGAr81PsF11+AXEBwGwrRCziL1SlKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0r3cLW+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739165985; x=1770701985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buG6voVc5zfk4HiKSZp19+HKiFIsBIA6Ww+wD6EEDD0=;
  b=Q0r3cLW+0VpqEdkEZmfacVDpZMYOryGQDrcVznLaIWWcsyQFPRH4tmZV
   SHzBc0Fkgd3HQcf6tttSCTrzU+KZZZ2NE+/NBwrDJraprEHcP3mQ1D8ct
   zRDI+0CFXLx+8Xj7lv+28LhLhzpP18hHMq4dVhSR5O1jMnR+4yBhdCh0U
   DEcFzSesAXNlHmbEerPdWdbHQJOvSkVhie7qWyAJB4YRro7GN6jQc6ka6
   zZShhj06GVcJULmL3w9ZVn6t4sCRap4aWtivQYYVZYFuaXevtp9w1XPXW
   Rs0mLZd2rFFO3ghYP01cIR3chzEBjse7fAbgl/OKBtHxgMj1IuW4Axx/s
   Q==;
X-CSE-ConnectionGUID: wzTWrSs6QzWcTjzLnI7oNg==
X-CSE-MsgGUID: FkEm4cjnTK2Z26U3viJOUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43657951"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43657951"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:39:45 -0800
X-CSE-ConnectionGUID: ApGwRRFvRWS+8W6N15XrDA==
X-CSE-MsgGUID: gbY2Fzp2SgSxQBdk4A1XfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112318428"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa008.fm.intel.com with ESMTP; 09 Feb 2025 21:39:42 -0800
From: niravkumar.l.rabara@intel.com
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux@treblig.org,
	Shen Lichuan <shenlichuan@vivo.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	u.kleine-koenig@baylibre.com,
	nirav.rabara@altera.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3 3/3] mtd: rawnand: cadence: fix incorrect device in dma_unmap_single
Date: Mon, 10 Feb 2025 13:35:51 +0800
Message-Id: <20250210053551.2399716-4-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210053551.2399716-1-niravkumar.l.rabara@intel.com>
References: <20250210053551.2399716-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

dma_map_single is using physical/bus device (DMA) but dma_unmap_single
is using framework device(NAND controller), which is incorrect.
Fixed dma_unmap_single to use correct physical/bus device.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 47950a0ac6d2..0b2db4173e72 100644
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


