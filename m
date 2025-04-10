Return-Path: <stable+bounces-132127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB7EA84793
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 17:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CFB19E8159
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 15:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C4B1E9B3D;
	Thu, 10 Apr 2025 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZEVxcV1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC41E9B0F;
	Thu, 10 Apr 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744298262; cv=none; b=dvRXNqri5DXt0isrZL7/rmxjLd9U73sxJ1YAp2rg+UHTKF6fIenu0yo1lUskOM03l5Q8keRX3cAFTM9UnBcQ2h3owMLtt31MIG8fXOCFEkMnxAk0JFCJePY46tTAJ7QAP6lL8OXzED/elXfAQ1XvGh0Ps7XwrbxdtXYrDbaxWwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744298262; c=relaxed/simple;
	bh=ihgs8oQ5HV7KkFZRvPnbVcGuq5j4Sx5YNX3RvTm0kXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq1EEcsNmpJGcwlaSakR/dXXg6L6C1bfGpuE5DhXZo+8JNjfrslMQw1BvgzmNk72a7vUCDn4Of1D5Jxv2mhq6PY9w+dwl95SgzI/92wEGGGfA0kXpvWFXLb2upTzaX2iQtr+2g75XtuQ9RzyV3l1RhC8buZt4LXAYLsVLIUHOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZEVxcV1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744298261; x=1775834261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihgs8oQ5HV7KkFZRvPnbVcGuq5j4Sx5YNX3RvTm0kXs=;
  b=QZEVxcV13VRJ/9K8jUBWbslPeydjb3sQ27j9bqEjKG7NHdncDkHGTrfQ
   rffPz4afne8G6cXzqS96vKiABbDaJohXOsB105lgyGeDtLZwEf58ePxgF
   eEaCwc3rhfSPu030Ztt9eBxjrikQHDLIQsd8/MTYbqi5+Tnk2g57PnRIq
   32isIWCCKGmr5HmfkBPv129CthEavaNO77qpGk9TtyzksPhcGeXKDmP6A
   qblu0dYqlmZmQl7kUcq05NLs/3BUx2L6LrqyjfLXaaRo3JQe8JBKiTaU3
   T2G2++dbblXhicvP4j1+2p38mMYLmkVhh0Hu6rfk4xauSXaAkNloUYMWa
   A==;
X-CSE-ConnectionGUID: H4XYRMzXTwaI5xyoOqoPow==
X-CSE-MsgGUID: GNhFDYCOSE+UaIqTrm8DXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="48534987"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="48534987"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:17:40 -0700
X-CSE-ConnectionGUID: O69HrhR4Ssmcu14P6DdlvA==
X-CSE-MsgGUID: UJ+nMm9zStydMmp2pb6oBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128913217"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 10 Apr 2025 08:17:39 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4/5] usb: xhci: Fix invalid pointer dereference in Etron workaround
Date: Thu, 10 Apr 2025 18:18:26 +0300
Message-ID: <20250410151828.2868740-5-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410151828.2868740-1-mathias.nyman@linux.intel.com>
References: <20250410151828.2868740-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

This check is performed before prepare_transfer() and prepare_ring(), so
enqueue can already point at the final link TRB of a segment. And indeed
it will, some 0.4% of times this code is called.

Then enqueue + 1 is an invalid pointer. It will crash the kernel right
away or load some junk which may look like a link TRB and cause the real
link TRB to be replaced with a NOOP. This wouldn't end well.

Use a functionally equivalent test which doesn't dereference the pointer
and always gives correct result.

Something has crashed my machine twice in recent days while playing with
an Etron HC, and a control transfer stress test ran for confirmation has
just crashed it again. The same test passes with this patch applied.

Fixes: 5e1c67abc930 ("xhci: Fix control transfer error on Etron xHCI host")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4e975caca235..b906bc2eea5f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3777,7 +3777,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
 		 * TRB to be breaked by the Link TRB.
 		 */
-		if (trb_is_link(ep_ring->enqueue + 1)) {
+		if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue + 1)) {
 			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
 			queue_trb(xhci, ep_ring, false, 0, 0,
 					TRB_INTR_TARGET(0), field);
-- 
2.43.0


