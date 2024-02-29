Return-Path: <stable+bounces-25501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FB586CB17
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 15:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3291C21210
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5531361B4;
	Thu, 29 Feb 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2eTOQBh"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC912BF22;
	Thu, 29 Feb 2024 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216002; cv=none; b=mJzuy1OA8D9gFXpe08IbRqb9GH2f2gDDhtSSVMr3iTMNT9FFy7SYMXNnjP/Hbfi/b85/lLdifOQx8p3OpxSOdjNsH0KlCWo1KUd+3qePD/NXUCmIcWOVoOtu6BoLg24ZBOmDOJNneFfrT5kOJweU96HPNAGLoEJd8EAhMa+hL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216002; c=relaxed/simple;
	bh=esVJlwSvV9/+UWQnk31M30c2daFC4+WWFpkYBl8pZsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kg5ZrjV6wORshvlbYg4KH5Ivm1Wq+893FmCqAz3n+qOYO9z0PVMz6M+5YjQNtg+upUYkw/WSZ1Et6roWPOVgNKbkCYFLVtFBmGWau5RSK1njHgflZ1EgBUpeoXWjXSb9Ec+mhpA6G/71JTmOToObX35ihLTVG7IkOET9zRVuQUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2eTOQBh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709216001; x=1740752001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=esVJlwSvV9/+UWQnk31M30c2daFC4+WWFpkYBl8pZsQ=;
  b=c2eTOQBhS0pu+mIBlN63sHhof94HPdc+FIrC0E/cwwHHV5Yx+55YdPlq
   dII3IsblyI2DOQHxKjecEJl+BAJ9lAvdI14yDLQZklEC0r9z57xXC0GA0
   59my51kyjuvrdM4lJ5b3/HYBUI+mieXprfRNoYS/WFx7uoHCp/AlVi46i
   Lhpt4rYddY1K5fQEecu2aY7X+6cq91dJINKbVuEVSFuFj3nH8up9ADLxZ
   0RDztRPn8lFNzvR9ZyIi+49WmcDAKEdEs6MncpkXPCZSlpkIxYyVSrK8U
   idD8zuYSgFwlo1cI8eJkehQt8stZcvwIcoR1FDBoXdAPemty2vbX0lWcs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3609412"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3609412"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 06:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="937035997"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937035997"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 06:13:18 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Prashanth K <quic_prashk@quicinc.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 9/9] usb: xhci: Add error handling in xhci_map_urb_for_dma
Date: Thu, 29 Feb 2024 16:14:38 +0200
Message-Id: <20240229141438.619372-10-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229141438.619372-1-mathias.nyman@linux.intel.com>
References: <20240229141438.619372-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prashanth K <quic_prashk@quicinc.com>

Currently xhci_map_urb_for_dma() creates a temporary buffer and copies
the SG list to the new linear buffer. But if the kzalloc_node() fails,
then the following sg_pcopy_to_buffer() can lead to crash since it
tries to memcpy to NULL pointer.

So return -ENOMEM if kzalloc returns null pointer.

Cc: <stable@vger.kernel.org> # 5.11
Fixes: 2017a1e58472 ("usb: xhci: Use temporary buffer to consolidate SG")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5d70e0176527..8579603edaff 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1219,6 +1219,8 @@ static int xhci_map_temp_buffer(struct usb_hcd *hcd, struct urb *urb)
 
 	temp = kzalloc_node(buf_len, GFP_ATOMIC,
 			    dev_to_node(hcd->self.sysdev));
+	if (!temp)
+		return -ENOMEM;
 
 	if (usb_urb_dir_out(urb))
 		sg_pcopy_to_buffer(urb->sg, urb->num_sgs,
-- 
2.25.1


