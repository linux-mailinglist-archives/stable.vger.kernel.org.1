Return-Path: <stable+bounces-120235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA2A4DC9C
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 12:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2AD3A4EC6
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 11:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184D20013D;
	Tue,  4 Mar 2025 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGf8UoBK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8351FF1BC;
	Tue,  4 Mar 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087859; cv=none; b=uTEspbFp6kgab2UnSpNPF6DmZ76Wikj/SaFI+wCo9jTWxwdX8BpUc67q7I6tAe/AgZ9OofanTrzAM3lGT3F651jACwWgKoWLqY+9zLsa3BREBP3BBzjxNuq2yWiKSer1yikXOgRQWsNCQx0eEeuCV1m6aEUj7dBSjHDvSkBah4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087859; c=relaxed/simple;
	bh=4/jBk9xtbogP2RV88hAWcvGyhY+MU92F09nJhw35Cz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxA4YRrfcbqzB+UttzUpSOK7wLSSSYiHxUAHB+ngkSmdKe/29BXdk7rF/pzop9Ocq7GrB4xAgQILMZJ02YoA1CcKf9Nh0rLMyJgUrwmmAZ1dsc0AAcsjiQIPHC6oGORk2tfHEJQkxxlhhmPXrpyH/5MFSWh8F7LW2ifvGVgn+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGf8UoBK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741087858; x=1772623858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4/jBk9xtbogP2RV88hAWcvGyhY+MU92F09nJhw35Cz8=;
  b=JGf8UoBKdWHyvU+kWKD/AAK0rXkEuseDviuSDZNWs9GBZSGQ9fLo71h5
   RxUW6lkX5/E4+4NoqmJR1V0g4UK8ppFTHmsdbLYeEls5eawQzIyrVJDTx
   3toHkNiHdY2qeOQCnvGNO0QgcE1egvJP/8xaeeSzLCNwUmy6S9wY/mvkp
   EBO3XRgJAn3uJ48x6guPFi5Ui9WVcLP+3QR+5Hw+itvb5ElfbMLvNk1zx
   aVRKFe44bNYQVAfD1o34gu8qjQXa2s0atARYyL/UkX9dCaw7GJqv4sBWZ
   O+MJ/O+hAEmOgd6rhM5tH5mMJLpcC2Shkk/UOAly9NWdkp5aowf79KH/v
   w==;
X-CSE-ConnectionGUID: Vq2Igk44TAGs1cXzdvyhLw==
X-CSE-MsgGUID: kOa5UVXWRwe2opPiON17lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41898331"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41898331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:30:58 -0800
X-CSE-ConnectionGUID: 4aStvVBhTtyygl5UeeAFvQ==
X-CSE-MsgGUID: uWo3fcq+RUizq0IioXevqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="141579994"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2025 03:30:56 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 1/1] usb: xhci: Fix host controllers "dying" after suspend and resume
Date: Tue,  4 Mar 2025 13:31:47 +0200
Message-ID: <20250304113147.3322584-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304113147.3322584-1-mathias.nyman@linux.intel.com>
References: <20250304113147.3322584-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

A recent cleanup went a bit too far and dropped clearing the cycle bit
of link TRBs, so it stays different from the rest of the ring half of
the time. Then a race occurs: if the xHC reaches such link TRB before
more commands are queued, the link's cycle bit unintentionally matches
the xHC's cycle so it follows the link and waits for further commands.
If more commands are queued before the xHC gets there, inc_enq() flips
the bit so the xHC later sees a mismatch and stops executing commands.

This function is called before suspend and 50% of times after resuming
the xHC is doomed to get stuck sooner or later. Then some Stop Endpoint
command fails to complete in 5 seconds and this shows up

xhci_hcd 0000:00:10.0: xHCI host not responding to stop endpoint command
xhci_hcd 0000:00:10.0: xHCI host controller not responding, assume dead
xhci_hcd 0000:00:10.0: HC died; cleaning up

followed by loss of all USB decives on the affected bus. That's if you
are lucky, because if Set Deq gets stuck instead, the failure is silent.

Likely responsible for kernel bug 219824. I found this while searching
for possible causes of that regression and reproduced it locally before
hearing back from the reporter. To repro, simply wait for link cycle to
become set (debugfs), then suspend, resume and wait. To accelerate the
failure I used a script which repeatedly starts and stops a UVC camera.

Some HCs get fully reinitialized on resume and they are not affected.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219824
Fixes: 36b972d4b7ce ("usb: xhci: improve xhci_clear_command_ring()")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 45653114ccd7..1a90ebc8a30e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -780,8 +780,12 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 	struct xhci_segment *seg;
 
 	ring = xhci->cmd_ring;
-	xhci_for_each_ring_seg(ring->first_seg, seg)
+	xhci_for_each_ring_seg(ring->first_seg, seg) {
+		/* erase all TRBs before the link */
 		memset(seg->trbs, 0, sizeof(union xhci_trb) * (TRBS_PER_SEGMENT - 1));
+		/* clear link cycle bit */
+		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= cpu_to_le32(~TRB_CYCLE);
+	}
 
 	xhci_initialize_ring_info(ring);
 	/*
-- 
2.43.0


