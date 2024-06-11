Return-Path: <stable+bounces-50150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51794903B74
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC8FB29585
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 12:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871BD17997D;
	Tue, 11 Jun 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDGDNDbP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE1617623D;
	Tue, 11 Jun 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107470; cv=none; b=bQ49lHIE/yOuECW8gzOX3r9HmdNhtO3dmFAS0C8TcjTQgnNxi2SEX0jTl3TxtEt5TZS0ux1MVMu9oftXfxFQA2Q1u68glGuVfcGK/qQJUyEXChkr46JgfzpE6tl4HIExJP293KHKba9jVyh8oszVsfbeOkvkgm4pq029wsr8F/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107470; c=relaxed/simple;
	bh=1nSyM6YW2dR/MWHSSAghG64Mqg7LH86n8D6WFtRNn6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O36+BP48maI2dZs4WN4NARQsuyyukgrgTTO6J2T6YWtLdaEVSLA+XYWCUSfMr3bc4QEqc5h7ftsECvhjymAnivr+tPxbVF+8uqgbFs8CwB5kehCZyZnHQoWd82iZvulY4E7La8zDtvbWOpDF9O/7cEy6doH7WjGLYHl8UQqyd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDGDNDbP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718107468; x=1749643468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1nSyM6YW2dR/MWHSSAghG64Mqg7LH86n8D6WFtRNn6g=;
  b=iDGDNDbPKvrL2dh3Kywgt5NBl63WwSTuO+bLIECWFBqSURD79PzqwVfz
   y2O9svrwSOnuOwOQyjBnJd+VPxsuslV/n7r/BTdBhC09WVSRS6KIyLC8+
   SGw3/wY3GVQ/7puSQAz2cInVp2E3h+r4pAASoa7eFnWY+3YYoNrVM8Ce7
   EEgbNLjZjS3WGqtehZd/VHiSiiX6ezkb/Z5aEZED+NPkVdNW28yBInm2f
   RH3dlhgaED9R7pPjcOXY3M8EpJPs4BlZu4KwrMTQwyL3nCuTKYxZ02apg
   3FFgnu5VxTnec6bh48fpnXArmBhmqFXVLC54ifmYcmqnwyJA26XdLuQCu
   w==;
X-CSE-ConnectionGUID: FELixaNdQxq8kL1SPXdjYw==
X-CSE-MsgGUID: Hk4+XB8oTKKNJq40yqZ25g==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="18641743"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="18641743"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 05:04:28 -0700
X-CSE-ConnectionGUID: lHmZS5cZSkiSgSBVwDoSzg==
X-CSE-MsgGUID: UoBwV39nQre4FfDC48D/UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="76879631"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa001.jf.intel.com with ESMTP; 11 Jun 2024 05:04:26 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Pierre Tomon <pierretom+12@ik.me>,
	stable@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 1/4] xhci: Set correct transferred length for cancelled bulk transfers
Date: Tue, 11 Jun 2024 15:06:07 +0300
Message-Id: <20240611120610.3264502-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611120610.3264502-1-mathias.nyman@linux.intel.com>
References: <20240611120610.3264502-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The transferred length is set incorrectly for cancelled bulk
transfer TDs in case the bulk transfer ring stops on the last transfer
block with a 'Stop - Length Invalid' completion code.

length essentially ends up being set to the requested length:
urb->actual_length = urb->transfer_buffer_length

Length for 'Stop - Length Invalid' cases should be the sum of all
TRB transfer block lengths up to the one the ring stopped on,
_excluding_ the one stopped on.

Fix this by always summing up TRB lengths for 'Stop - Length Invalid'
bulk cases.

This issue was discovered by Alan Stern while debugging
https://bugzilla.kernel.org/show_bug.cgi?id=218890, but does not
solve that bug. Issue is older than 4.10 kernel but fix won't apply
to those due to major reworks in that area.

Tested-by: Pierre Tomon <pierretom+12@ik.me>
Cc: stable@vger.kernel.org # v4.10+
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 9e90d2952760..1db61bb2b9b5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2524,9 +2524,8 @@ static int process_bulk_intr_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		goto finish_td;
 	case COMP_STOPPED_LENGTH_INVALID:
 		/* stopped on ep trb with invalid length, exclude it */
-		ep_trb_len	= 0;
-		remaining	= 0;
-		break;
+		td->urb->actual_length = sum_trb_lengths(xhci, ep_ring, ep_trb);
+		goto finish_td;
 	case COMP_USB_TRANSACTION_ERROR:
 		if (xhci->quirks & XHCI_NO_SOFT_RETRY ||
 		    (ep->err_count++ > MAX_SOFT_RETRY) ||
-- 
2.25.1


