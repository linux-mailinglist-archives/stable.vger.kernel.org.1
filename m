Return-Path: <stable+bounces-114471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578BA2E3BA
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 06:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6858164F8D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 05:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FA189906;
	Mon, 10 Feb 2025 05:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b7nOkKV0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0E14885B;
	Mon, 10 Feb 2025 05:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739165971; cv=none; b=rCJiWKfu0O3QOMPcrEtS2OfzZxLicTn2xl8nLqqN8kxlIpoF0WF57cZQ6ljRPT+Y8z2jVRJL5ZGw0ymma9ivClQ9Wd+Eq4c/6SZgau0fQiTh8fCJ9CuKzCaB/qeqNpGeNuSBuWt5qZw+UAyFZrACjG5hI5tqIZa0eHb3ziuleX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739165971; c=relaxed/simple;
	bh=Ksfd3sS+urRxMxMu37a3Dqzf3ivVB4yAYamRm8eK3LQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WD9j5faTgXK4ibmEYfxsw0uprxi7NJSA3CxZMLQMVsTZNA8JQW37DQuelCcloYirRlNh9+Yl+TrbMbxCcPVjkOh4BsvNzFiuipLQvmo8H8W68wrZEOOa37z/e0uph1WV6j6NtBgVM5fWiacjjJuXT39sG9VASbUS7n1XJqWs/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b7nOkKV0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739165970; x=1770701970;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ksfd3sS+urRxMxMu37a3Dqzf3ivVB4yAYamRm8eK3LQ=;
  b=b7nOkKV0xTlXG+Yfi+LoU5TmOAAcf26+RxCfMv68WEMO6cwes4ej2bMd
   Wieuq/ieyaZav4zKWDPhOmYhDJBP5GjzGvX2rkW2mSBYbHp+ju+wTthXS
   Nnmk7OZPeLArV473QSX0WBXppIjYbCActt9YesWNZ5o2TriMj2ubM/tQL
   N2N/XuD9SuBoAuWNVp6t5r8yCx0PISKBTI1BNLdvcHbkvQpNpodtEE2L0
   mFoFYG2ug/lK4eZweQO9GaawiJ5OIm6Iir5z6uYqpxOoCCsTbkpgbgl4P
   54dgHcqQZ8k/2Q9eLZr94t2iAiD+BcyNL6J6bsbpg2hM7/UXG4kb3AsfE
   w==;
X-CSE-ConnectionGUID: Zc2nOl7hT7mvcC0rxhHzlg==
X-CSE-MsgGUID: +fNtah1bQuq68vbOz6L0/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="43657911"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="43657911"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:39:29 -0800
X-CSE-ConnectionGUID: nlFPBAaWS96PEwA9yPo2Aw==
X-CSE-MsgGUID: z8VdSwINTHugCccQgtorJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="112318407"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa008.fm.intel.com with ESMTP; 09 Feb 2025 21:39:26 -0800
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
Subject: [PATCH v3 0/3] mtd: rawnand: cadence: improvement and fixes
Date: Mon, 10 Feb 2025 13:35:48 +0800
Message-Id: <20250210053551.2399716-1-niravkumar.l.rabara@intel.com>
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

1. Replace dma_request_channel() with dma_request_chan_by_mask() and use
   helper functions to return proper error code instead of fixed -EBUSY.
2. Remap the slave DMA I/O resources to enhance driver portability.
3. Fixed dma_unmap_single to use correct physical/bus device.


v3 changes:-
  * Update commit message based on v2 review feedback for better clarity.
  * Use dma_request_chan_by_mask() and helper functions to return proper
    error code instead of fixed -EBUSY error code.

link to v2:
 - https://lore.kernel.org/all/20250116032154.3976447-1-niravkumar.l.rabara@intel.com/

v2 changes:-
  * Added the missing Fixes and Cc: stable tags to the patches.

link to v1:
 - https://lore.kernel.org/all/20250108135234.3107502-1-niravkumar.l.rabara@intel.com/

Niravkumar L Rabara (3):
  mtd: rawnand: cadence: fix error code in cadence_nand_init()
  mtd: rawnand: cadence: use dma_map_resource for sdma address
  mtd: rawnand: cadence: fix incorrect device in dma_unmap_single

 .../mtd/nand/raw/cadence-nand-controller.c    | 42 ++++++++++++++-----
 1 file changed, 31 insertions(+), 11 deletions(-)

-- 
2.25.1


