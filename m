Return-Path: <stable+bounces-106193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042569FD40B
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 13:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27D287A1892
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 12:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074B1F193A;
	Fri, 27 Dec 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hx0TmUyq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5771F190D;
	Fri, 27 Dec 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735300856; cv=none; b=MpA5rTzU1WUj4nzOip62XlA4twaMNTkt7oNWV1q0fgEhH/vQgdywveUEfOowiB9fsQC6yjZoIrb0WaQvw4pe08ek77gQIWgja+u+DljYGxg9pQxYyXTm9fwuvMMiUPa4Q9BS49SOOoZ1mkaDtutOq65oORzFZk1duuZQqOi0t1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735300856; c=relaxed/simple;
	bh=4qQzC02wqrdGnNxqHzqMTu/5RUVAiwcDlAflh1KJkWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIvHR0jTWQXuk2z922We/tU1zjY20unqnQxXL/mBXCfMQR64+MoyainSV/5sg4vlWfe20MHCPLI8AfRzp+JCTbpQuGuvbyJAupi0cd2g3vGuPLgu/zhJewaqgYq+8evgrGaaAK8JAxE3HC3uNkCcdhyl6owrT/jCNR51caTBU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hx0TmUyq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735300854; x=1766836854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4qQzC02wqrdGnNxqHzqMTu/5RUVAiwcDlAflh1KJkWg=;
  b=Hx0TmUyqNw3edZf/dXDI8MFX7zSE4wwdv9XMO3Owq+SLxdeYagOrweiG
   1f8b3moz1VBfoKb7pAJNLUF8HN6SpYbPZneGSEvIFM5kEqOX8Uko4Vs5Y
   77595r3Z43oDuU3/tOsedCvDgkx7RbLm7H/3OSQE9tlG6nf2+hInH6Hah
   w93l2QS70NwfrOWJjtt92Kc3t8kUs2uwRBvtpIWhMR6DK38kiIRgzXQ9L
   oK8VvySwYhnw8urDtvAGtZKlcp8l+DHKylTWV6SmhvPVwjy/65UnSiX9T
   O+dy9bkXVnMCSghWaWuWWVrbV1gHFg45pNjGRy6feC9V7jNsPXmw+TI4K
   Q==;
X-CSE-ConnectionGUID: zC8+wOqXTMqEtiDk/6Eg6Q==
X-CSE-MsgGUID: FT5zzKMSRbiVe/Ye1rgY6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11298"; a="35932527"
X-IronPort-AV: E=Sophos;i="6.12,269,1728975600"; 
   d="scan'208";a="35932527"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 04:00:54 -0800
X-CSE-ConnectionGUID: icueMuu2QbOMTyPg9svYuA==
X-CSE-MsgGUID: SCiyC6HtSsSK97X1ZKNWSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104772445"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 27 Dec 2024 04:00:52 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 3/5] usb: xhci: Fix NULL pointer dereference on certain command aborts
Date: Fri, 27 Dec 2024 14:01:40 +0200
Message-Id: <20241227120142.1035206-4-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241227120142.1035206-1-mathias.nyman@linux.intel.com>
References: <20241227120142.1035206-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

If a command is queued to the final usable TRB of a ring segment, the
enqueue pointer is advanced to the subsequent link TRB and no further.
If the command is later aborted, when the abort completion is handled
the dequeue pointer is advanced to the first TRB of the next segment.

If no further commands are queued, xhci_handle_stopped_cmd_ring() sees
the ring pointers unequal and assumes that there is a pending command,
so it calls xhci_mod_cmd_timer() which crashes if cur_cmd was NULL.

Don't attempt timer setup if cur_cmd is NULL. The subsequent doorbell
ring likely is unnecessary too, but it's harmless. Leave it alone.

This is probably Bug 219532, but no confirmation has been received.

The issue has been independently reproduced and confirmed fixed using
a USB MCU programmed to NAK the Status stage of SET_ADDRESS forever.
Everything continued working normally after several prevented crashes.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219532
Fixes: c311e391a7ef ("xhci: rework command timeout and cancellation,")
CC: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4cf5363875c7..da26e317ab0c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -422,7 +422,8 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci);
+		if (cur_cmd)
+			xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
-- 
2.25.1


