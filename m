Return-Path: <stable+bounces-55973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E66191A9E5
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9EC286C10
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0CE19882E;
	Thu, 27 Jun 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQFlz1yz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EEA197A9D;
	Thu, 27 Jun 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500021; cv=none; b=QatoDtBSe5B1Bx83nofIu9ZIp4VRvT+NZGPneNGB8/3hS2/jIX41lDwqm4FVqt5GOx0lqAER0+8cthTAjeAuyT9cbiQzvkf2ar+Sh8KhoK5M2Ytm2ArqPdZ/5W3PWnl/HkZKd0RgKqCJBEZp6wQwOKwXxf0YqjRKhgPHbWN1NYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500021; c=relaxed/simple;
	bh=A1ciydZdlZ7VC+2vPYirzmBZg1x+p8y4Ghx5XaxL9zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhidju0zz8lnUplkX+DiExadWm37C7brAKyR1kTd2oyQhUaD0y/nqsAFgAPWka2USr7MYMibwC9szGivfgBn3+OPxx5DkQK7lgXgGtnW+8Ze1o9s5/wLg+BUkg5GlEQW+Mgoj5mdzntjCUNAZmYG0j8ERhZfzfRmkuGtaNAqR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQFlz1yz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719500020; x=1751036020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A1ciydZdlZ7VC+2vPYirzmBZg1x+p8y4Ghx5XaxL9zY=;
  b=gQFlz1yzghnkcdvkJTApuwAland53tIy3q9SfWb8Khkkb0iq/RQPjzWI
   mVpUnygvm8WyPUV56eflNO2ui0P42qRqQ0tLwhgQ1vplS8Llfmi0JRS2U
   hQcYyBimJKZHp/W9Nzz19BwpShluOOeloL+QmOgvb59pbaRPgObMua7lM
   FpnF2DSfNeNOhC8f9u4sgBbmINcv5gnD15KKH5mJOsfmcbfzj+fo0MKt1
   W/vcsJrQckNxR9T3BwLE+W8Kn3HmEmuQHRV2Ez6MMZxEqwjFZjnsFtWZU
   BgYW8MMZAlp4RTDf/z/BwRdewB7aGd2eYM+VKn8vgSnLYza9ZXW+Uwh5p
   Q==;
X-CSE-ConnectionGUID: Crl1ACrbShCkQmcEivxigA==
X-CSE-MsgGUID: iLgyRkBXQA6hO2K/+ruM3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20450121"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="20450121"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:53:29 -0700
X-CSE-ConnectionGUID: f8EYsdR9RGiMkOQ/ACu7KQ==
X-CSE-MsgGUID: 8BtxDxS7S6qgZZ0PdP4/lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="44301404"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa010.jf.intel.com with ESMTP; 27 Jun 2024 07:53:27 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Remi Pommarel <repk@triplefau.lt>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] xhci: always resume roothubs if xHC was reset during resume
Date: Thu, 27 Jun 2024 17:55:23 +0300
Message-Id: <20240627145523.1453155-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627145523.1453155-1-mathias.nyman@linux.intel.com>
References: <20240627145523.1453155-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usb device connect may not be detected after runtime resume if
xHC is reset during resume.

In runtime resume cases xhci_resume() will only resume roothubs if there
are pending port events. If the xHC host is reset during runtime resume
due to a Save/Restore Error (SRE) then these pending port events won't be
detected as PORTSC change bits are not immediately set by host after reset.

Unconditionally resume roothubs if xHC is reset during resume to ensure
device connections are detected.

Also return early with error code if starting xHC fails after reset.

Issue was debugged and a similar solution suggested by Remi Pommarel.
Using this instead as it simplifies future refactoring.

Reported-by: Remi Pommarel <repk@triplefau.lt>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218987
Suggested-by: Remi Pommarel <repk@triplefau.lt>
Tested-by: Remi Pommarel <repk@triplefau.lt>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 37eb37b0affa..0a8cf6c17f82 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1125,10 +1125,20 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 			xhci_dbg(xhci, "Start the secondary HCD\n");
 			retval = xhci_run(xhci->shared_hcd);
 		}
-
+		if (retval)
+			return retval;
+		/*
+		 * Resume roothubs unconditionally as PORTSC change bits are not
+		 * immediately visible after xHC reset
+		 */
 		hcd->state = HC_STATE_SUSPENDED;
-		if (xhci->shared_hcd)
+
+		if (xhci->shared_hcd) {
 			xhci->shared_hcd->state = HC_STATE_SUSPENDED;
+			usb_hcd_resume_root_hub(xhci->shared_hcd);
+		}
+		usb_hcd_resume_root_hub(hcd);
+
 		goto done;
 	}
 
@@ -1152,7 +1162,6 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 
 	xhci_dbc_resume(xhci);
 
- done:
 	if (retval == 0) {
 		/*
 		 * Resume roothubs only if there are pending events.
@@ -1178,6 +1187,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 			usb_hcd_resume_root_hub(hcd);
 		}
 	}
+done:
 	/*
 	 * If system is subject to the Quirk, Compliance Mode Timer needs to
 	 * be re-initialized Always after a system resume. Ports are subject
-- 
2.25.1


