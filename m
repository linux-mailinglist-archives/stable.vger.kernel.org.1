Return-Path: <stable+bounces-109203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858DA131BA
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 04:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933181886A43
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A76878F30;
	Thu, 16 Jan 2025 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWX6w0XZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460713D279;
	Thu, 16 Jan 2025 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736997926; cv=none; b=Bhq0bM5WS9Kw/nhx+xi9lGre5/g/anFgJ5Z/aPb+PaPd9BfwtGmLolVIG+/fZyb2pN+ThrgcOSURjQkWxIRhR+sESv7SVPc1aHQiN0NGznakVBsrshG5EeYmC/rOdIMfEC5wwZ3rj/zzPT6ntM04FDHlrOGVkRaXdVqF7d3BUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736997926; c=relaxed/simple;
	bh=9YYGXevSZHlst/BPZfEfbibwoduDeeUOTds+39AMyPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H932dg55YlAtmyWkCb7xw1OLHZAumLOots4MR0fwscT+Q+CVBT6BvraElYnA9nn2QQpmRUVuKO9kcrK7WnCn7BmQXuVwf+JZwxi8hXqfqhnlehfRxlD9j97jGJPpHkwlZLvImrVc4hAhNe9I7ONk3fPy3axWH/Pv220RX2vjFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWX6w0XZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736997925; x=1768533925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YYGXevSZHlst/BPZfEfbibwoduDeeUOTds+39AMyPo=;
  b=OWX6w0XZf0wjaEjZh67dGK0syDwG46wxinKXLE3nxTaNGVNF7CS3O6Zs
   5Jdb/dP+24Uc2Lw/FzeQkQ0PWZAc9FdqrZfbdWNoPVUvTglqZVrTpwHb3
   su81ZA4Z/GmQdYLaB59ADpRA75mM8LD23rO8vjeWVeacNhu8dlENwOET+
   upY9dX2m3qo5ul+pW5KHVsKqTq1DqWpNnvI62j2jBaH8gBL7H2A95kCiM
   VayiS4G1C5ajf/89Nx1UNxE/GZlRN2v9KffWfdaKP9D5b8Bz76UF+hveq
   By6Ua8qvaOV+DCc5gaHyoWJCg2Rd0m+w23qqyXATupE0EMV3/Fzagk5zO
   Q==;
X-CSE-ConnectionGUID: xUVlj1wPQZOnnJQS2kx8TQ==
X-CSE-MsgGUID: LKwY4z3vSPyYYus5c1RtPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37478869"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37478869"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 19:25:24 -0800
X-CSE-ConnectionGUID: UZ+Enxz+Q3uMV4IIBC95Kw==
X-CSE-MsgGUID: dWe5rzSyTlWc1CFGsZI1mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142604337"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa001.jf.intel.com with ESMTP; 15 Jan 2025 19:25:22 -0800
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
Subject: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob when DMA is not ready
Date: Thu, 16 Jan 2025 11:21:52 +0800
Message-Id: <20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
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

Use deferred driver probe in case the DMA driver is not probed.
When ARM SMMU is enabled, all peripheral device drivers, including NAND,
are probed earlier than the DMA driver.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 8d1d710e439d..5e27f5546f1b 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2908,7 +2908,7 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 		if (!cdns_ctrl->dmac) {
 			dev_err(cdns_ctrl->dev,
 				"Unable to get a DMA channel\n");
-			ret = -EBUSY;
+			ret = -EPROBE_DEFER;
 			goto disable_irq;
 		}
 	}
-- 
2.25.1


