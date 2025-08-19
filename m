Return-Path: <stable+bounces-171791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7368B2C477
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 15:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0204D1BA7CC8
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62933EB1D;
	Tue, 19 Aug 2025 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVbYK9l2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1F33EB19;
	Tue, 19 Aug 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608350; cv=none; b=OlywJu7yhAKYVQph7hmkYT1pD1TJ6Lu8xdj108C1FI4yvi3kWHD24bUddulHEpbSO0PjaZ2FlgJZDKP5mTkZR+Xmx6zqhaK7yuAdxHeZw5cK9Ucu6bBmhoU0jz7q3F7tvniAp2PQkUiPkMr0nrSRRPbGM9WCSQ+Om9ceYvVbRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608350; c=relaxed/simple;
	bh=KsB5xb8CLoPkCYCy86lfDA/oqLNe9JXtjWhvzXKw/Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBytyIS5rRF9TtnU9CF3Tg579tQ5WGK6VN8lGSMQXtqMx8ZcATNv0Qyayu8CfkepthpZIZUoIyB2Iy0tjtJRg0KKMxT2uilSuZo+Sbquhzoe98Z/tpxlN+A5XJJ0VE1JIYNL9ot/f1kCdDvCqA3Vg/OBJamq1G2x1fRWMqmtT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVbYK9l2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755608349; x=1787144349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KsB5xb8CLoPkCYCy86lfDA/oqLNe9JXtjWhvzXKw/Qc=;
  b=MVbYK9l2ZM/2bCNJjfypDADT7wV8JpqNrXv8dcR/NFF11TZKBTsk4k4j
   4scuuytSlggEqG3PWSJ+SZbTeYRwRVVclzXbq2TdoEStDHJh90V1M8Gwj
   AmB/oiBrFgUnof1t/j7vfjekhMd947pWjMsoy/ih+bX0BQcU6PQ2eJ7L0
   5g/00bZooQ6ldCl6VM2h/iR9WueIBSO0UYKpg+1IoJfOEkby6vqAnFm0p
   pH+FGqZwyP8nAVYv6UZMQnwn1nNUgCs5kUWys/4/iznINnQI0Pob4zTY2
   E0UQme/U7yhKJ4qU0umGoEpIHd98px6UREqVU/PhxfbSlk30Y5xwjYaZZ
   w==;
X-CSE-ConnectionGUID: 6QTJ25ImQve8ZlwTCxRJGA==
X-CSE-MsgGUID: OtHapr9eSRy0i2qhY4gMiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="75423032"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="75423032"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 05:58:59 -0700
X-CSE-ConnectionGUID: 5Z4CW7WKTqu80yOedwfu2g==
X-CSE-MsgGUID: kWUFMHGNRHKypsybcOcUJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="168194869"
Received: from mnyman-desk.fi.intel.com ([10.237.72.199])
  by fmviesa008.fm.intel.com with ESMTP; 19 Aug 2025 05:58:57 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	christian@heusel.eu,
	michal.pecio@gmail.com,
	niklas.neronin@linux.intel.com,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 2/2] usb: xhci: fix host not responding after suspend and resume
Date: Tue, 19 Aug 2025 15:58:44 +0300
Message-ID: <20250819125844.2042452-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819125844.2042452-1-mathias.nyman@linux.intel.com>
References: <20250819125844.2042452-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niklas Neronin <niklas.neronin@linux.intel.com>

Partially revert commit e1db856bd288 ("usb: xhci: remove '0' write to
write-1-to-clear register") because the patch cleared the Interrupt Pending
bit during interrupt enabling and disabling. The Interrupt Pending bit
should only be cleared when the driver has handled the interrupt.

Ideally, all interrupts should be handled before disabling the interrupt;
consequently, no interrupt should be pending when enabling the interrupt.
For this reason, keep the debug message informing if an interrupt is still
pending when an interrupt is disabled.

Because the Interrupt Pending bit is write-1-to-clear, writing '0' to it
ensures that the state does not change.

Link: https://lore.kernel.org/linux-usb/20250818231103.672ec7ed@foxbook
Fixes: e1db856bd288 ("usb: xhci: remove '0' write to write-1-to-clear register")
Closes: https://bbs.archlinux.org/viewtopic.php?id=307641
cc: stable@vger.kernel.org # 6.16+
Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 0e03691f03bf..742c23826e17 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -309,6 +309,7 @@ int xhci_enable_interrupter(struct xhci_interrupter *ir)
 		return -EINVAL;
 
 	iman = readl(&ir->ir_set->iman);
+	iman &= ~IMAN_IP;
 	iman |= IMAN_IE;
 	writel(iman, &ir->ir_set->iman);
 
@@ -325,6 +326,7 @@ int xhci_disable_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 		return -EINVAL;
 
 	iman = readl(&ir->ir_set->iman);
+	iman &= ~IMAN_IP;
 	iman &= ~IMAN_IE;
 	writel(iman, &ir->ir_set->iman);
 
-- 
2.43.0


