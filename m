Return-Path: <stable+bounces-114472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFB2A2E3BC
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 06:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1FA188665D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 05:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C11188915;
	Mon, 10 Feb 2025 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6SHTetY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4581922F5;
	Mon, 10 Feb 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165976; cv=none; b=phfsT6YX4M0UiPALS/+kpQBaM1LaH0OINIHfbuHaBuxjLtZrGOlEj8Af2k2SBjowtFrWbscIcER+5N8TDqB4/KNSHoLapg3ksGrJOJ+Z1wlbIYw/PPvEhXWSnGf43jKX0QMuYCcGDDMyZSY9dPecmPne72VPkZ8kCk1GDKZPru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165976; c=relaxed/simple;
	bh=E5Gx0mln1QzktxWO4z36jzZMXzJEeo8ZrweNjo//Bz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SjyLKND+GRFD8zXheB7+AhJ6wosp5COZ0WuZAaFZt304KCXS7kt/jM409gpHiZCic8I3Q3wa1f7jfEaVEvGAATO6rVPwolpeNdyfwxx8VgrO/5RrwIUIPun0HiS52t0XvJCiXkdMnCj9W1X+myfpC+QOZ+sqdfEeP1s5DKiaCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6SHTetY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739165975; x=1770701975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E5Gx0mln1QzktxWO4z36jzZMXzJEeo8ZrweNjo//Bz8=;
  b=h6SHTetYWCyZ5Dm6zV+gq5vA/H0IZa7Bb9RBdEVgvkq/+GSDjLwmJPJo
   Lh8kVb+IxbUfBKoIscOqH274NgnSEpLf0z29eGJWPs4QLcpcdWYJ37h6K
   vliKTonbhZcQECs6Sfoqb6xAv2oWWFUdvfRqTKcvQ+/xOFwZSId6Q077P
   tVKc4HGC69LzJ/geXMV0cfb2G5f9fib4gNiQTDQuF9tNbVQ9RqTIy2NAh
   HE1nzVCu6JDNjLb32CQb0RzJQhCEpZVjZF3JyzWuzE5Iu0iwS6fPf4wkz
   TBUzS/EejLfgZOT1NldpI8Lya14GWeKItgoLODD5dJeUsvgqCiZvDtlnD
   A==;
X-CSE-ConnectionGUID: rWOW+yg0TtSFMTUgfdFmnA==
X-CSE-MsgGUID: rG22I1baSEeJCcHyCZB1bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43657923"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43657923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:39:34 -0800
X-CSE-ConnectionGUID: /OnQ3929R/ex36lOmtQeeQ==
X-CSE-MsgGUID: PpKNo84rQ6WI/FRAXYPNLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112318414"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa008.fm.intel.com with ESMTP; 09 Feb 2025 21:39:31 -0800
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
Subject: [PATCH v3 1/3] mtd: rawnand: cadence: fix error code in cadence_nand_init()
Date: Mon, 10 Feb 2025 13:35:49 +0800
Message-Id: <20250210053551.2399716-2-niravkumar.l.rabara@intel.com>
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

Replace dma_request_channel() with dma_request_chan_by_mask() and use
helper functions to return proper error code instead of fixed -EBUSY.

Fixes: ec4ba01e894d ("mtd: rawnand: Add new Cadence NAND driver to MTD subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 8d1d710e439d..fb5f671bdb7b 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2904,11 +2904,10 @@ static int cadence_nand_init(struct cdns_nand_ctrl *cdns_ctrl)
 	dma_cap_set(DMA_MEMCPY, mask);
 
 	if (cdns_ctrl->caps1->has_dma) {
-		cdns_ctrl->dmac = dma_request_channel(mask, NULL, NULL);
-		if (!cdns_ctrl->dmac) {
-			dev_err(cdns_ctrl->dev,
-				"Unable to get a DMA channel\n");
-			ret = -EBUSY;
+		cdns_ctrl->dmac = dma_request_chan_by_mask(&mask);
+		if (IS_ERR(cdns_ctrl->dmac)) {
+			ret = dev_err_probe(cdns_ctrl->dev, PTR_ERR(cdns_ctrl->dmac),
+					    "%d: Failed to get a DMA channel\n", ret);
 			goto disable_irq;
 		}
 	}
-- 
2.25.1


