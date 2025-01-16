Return-Path: <stable+bounces-109202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BC4A131B8
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 04:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7470E3A4AE5
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 03:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BBF78F47;
	Thu, 16 Jan 2025 03:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcavWrOn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F4A1482F2;
	Thu, 16 Jan 2025 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736997920; cv=none; b=bmJENhmezDewpt19QHMQNJmPkwfxSSJLctzCmDfQAvlTP4DVnNhRvFM0o/PrJLI5oG3gwTG+metyT93zAQxH+9iPr63jVpjk9UNXx2DiJMUcEfmFKly1xmHR+Y6Xs8PnoKKTtl0TWLBi/zlvJRTN+X3UURaEixKGqSFdySNoljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736997920; c=relaxed/simple;
	bh=Qh95bfftKSAqWbqh1JWGCL2eQxCGpzz4NwlXtWeDByk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjOnAb0TWuyrIc3pOVefxonEiNn0OkGZYPtMwhxqyZel6IvGBBil/67nNyadXSZtMwDfVu+75Tn13py+XSUjZLSf1RI2XvHZick7BDKF7FZP8F4QrMLy293VCSVKpWZsVpKXtyH2dGV8RjofNOR26tSBvtMjQkKpcPWtMjCgLvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcavWrOn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736997918; x=1768533918;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qh95bfftKSAqWbqh1JWGCL2eQxCGpzz4NwlXtWeDByk=;
  b=OcavWrOn8UKs2Wbm1DiE3bNKxdDT7slUlUaIGJPY4Hlgor+/dhUcu40e
   /S+2hk2e4ypmGbsYgbDQzHcEEXo6rFTmm87BpjHoGOEzx3ZH3300wQ2RJ
   LziaI+dxNk+L2gnsXml8pQFU9Rko4OclyWCW42NbE9C8DNXHLdxeYiFFk
   0UDODDFxIRlkqAoLaNYKbz3FgMch+H39lxqrh+TFel4Z8d1LmRs4500+2
   tR1GyIINuF5RiuGB4Z0qggMcZpcET5B9QUklPJzi4fgZZji1hNYxRlorD
   EznNhSwTm7fbuBQnnlOFH+8jx89A5/8xmWQHgHT10+wmPKuebwUwi4q8P
   A==;
X-CSE-ConnectionGUID: ymbCBnmlQdicZRPiqvRAqA==
X-CSE-MsgGUID: rPLL8Z1bRJeNgNb5xxIIEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37478857"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37478857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 19:25:18 -0800
X-CSE-ConnectionGUID: F+/z/oqMQ1OjVZPfvtHgNA==
X-CSE-MsgGUID: i5TgPROpRCCPvYlrGUipKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142604327"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa001.jf.intel.com with ESMTP; 15 Jan 2025 19:25:15 -0800
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
Subject: [PATCH v2 0/3] mtd: rawnand: cadence: improvement and fixes
Date: Thu, 16 Jan 2025 11:21:51 +0800
Message-Id: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

This patchset introduces improvements and fixes for cadence nand driver.
The changes include:

1. Support deferred prob mechanism when DMA driver is not probed yet.
2. Map the slave DMA address using dma_map_resource. When ARM SMMU
   is enabled, using a direct physical address of SDMA results in
   DMA transaction failure.
3. Fixed the incorrect device context used for dma_unmap_single.

v2 changes:-
- Added the missing Fixes and Cc: stable tags to the patches.

Niravkumar L Rabara (3):
  mtd: rawnand: cadence: support deferred prob when DMA is not ready
  mtd: rawnand: cadence: use dma_map_resource for sdma address
  mtd: rawnand: cadence: fix incorrect dev context in dma_unmap_single

 .../mtd/nand/raw/cadence-nand-controller.c    | 35 +++++++++++++++----
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
2.25.1


