Return-Path: <stable+bounces-139683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EACAA93B9
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 14:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA5A7A9B07
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BB251797;
	Mon,  5 May 2025 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exql5B09"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA2146D53;
	Mon,  5 May 2025 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449846; cv=none; b=Y/3gAFfxGw9U9I+21USVMQjRnZybl6+KRG5WO9W2p0a8sWnOcaCBBJod7ZZMcJ2ffvPwFJ3JHjc9dVoScTvCjdJxI77y54Ii0GVIZG6fWDEjoHnhgTmFmVIOCx9ztiyEKaft/VlrJtiuc14EerGYG0c7wKb10O8mBK8cCT/icoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449846; c=relaxed/simple;
	bh=A8dahzrlKe2KglU8LHZBXCxvVFCHODOywH9O+yQASNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4hH1R6Y3sqPELpNi+SlNxitt1ahBAi8MEdIacJOIgapDrcabNzr5GDxbkAZKMcPMse4JCSsjQbPDrxIxXlCW3Du2JnOI/sYBQJRQ0EHNRwNmhUOSgmNTMF/I0ys19B0vrLVaPVZwmiFKfRkr+gpj+YSyHk46PDV6le1WhU+9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exql5B09; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746449845; x=1777985845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8dahzrlKe2KglU8LHZBXCxvVFCHODOywH9O+yQASNU=;
  b=exql5B09DKgDbYEO84PPTSArqOsnlI2KNBIEr60zFntrZjTRi7poc4iw
   qUdeZhP4BlrZv9JY9fUHfeUvI8UZf6se1wzhHmnWvYR1RvAOUVpPyiegR
   ZZ724rCyM95mJqOLMZUX/2XTFtkyhvQKpoYYrek5dVJUrOIu1FHloId6S
   cLklhRYr9mR1Z2UJX+8DRm4vVfilJtGscyncaW9FJnAjeHJf+S2K6DzhZ
   RGe6NqqMbc2p28/njWVn+dyPjmzFlpZUhiA+v0E5S2CNBAqrXHqPIoJ80
   JctBam0ind0+DhcT8t6HNNPF4Sc7o/Qad6Zur5gVmKI6LgytACGbBhyPL
   A==;
X-CSE-ConnectionGUID: lEO8AYKXQoa6IFcaYLCanw==
X-CSE-MsgGUID: TGeL6MqUSVWnOf1Husiy+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11423"; a="35675911"
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="35675911"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 05:57:24 -0700
X-CSE-ConnectionGUID: DsmJJm4wS9WNyh+Wwzc69A==
X-CSE-MsgGUID: ileZhGtrSdSkoxzhti2K6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,262,1739865600"; 
   d="scan'208";a="135151089"
Received: from unknown (HELO mnyman-desk.fi.intel.com) ([10.237.72.199])
  by orviesa010.jf.intel.com with ESMTP; 05 May 2025 05:57:22 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
Date: Mon,  5 May 2025 15:56:30 +0300
Message-ID: <20250505125630.561699-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505125630.561699-1-mathias.nyman@linux.intel.com>
References: <20250505125630.561699-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Event polling delay is set to 0 if there are any pending requests in
either rx or tx requests lists. Checking for pending requests does
not work well for "IN" transfers as the tty driver always queues
requests to the list and TRBs to the ring, preparing to receive data
from the host.

This causes unnecessary busylooping and cpu hogging.

Only set the event polling delay to 0 if there are pending tx "write"
transfers, or if it was less than 10ms since last active data transfer
in any direction.

Cc: Łukasz Bartosik <ukaszb@chromium.org>
Fixes: fb18e5bb9660 ("xhci: dbc: poll at different rate depending on data transfer activity")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 19 ++++++++++++++++---
 drivers/usb/host/xhci-dbgcap.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index fd7895b24367..0d4ce5734165 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -823,6 +823,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 {
 	dma_addr_t		deq;
 	union xhci_trb		*evt;
+	enum evtreturn		ret = EVT_DONE;
 	u32			ctrl, portsc;
 	bool			update_erdp = false;
 
@@ -909,6 +910,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
+			ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
@@ -927,7 +929,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 		lo_hi_writeq(deq, &dbc->regs->erdp);
 	}
 
-	return EVT_DONE;
+	return ret;
 }
 
 static void xhci_dbc_handle_events(struct work_struct *work)
@@ -936,6 +938,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 	struct xhci_dbc		*dbc;
 	unsigned long		flags;
 	unsigned int		poll_interval;
+	unsigned long		busypoll_timelimit;
 
 	dbc = container_of(to_delayed_work(work), struct xhci_dbc, event_work);
 	poll_interval = dbc->poll_interval;
@@ -954,11 +957,21 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 			dbc->driver->disconnect(dbc);
 		break;
 	case EVT_DONE:
-		/* set fast poll rate if there are pending data transfers */
+		/*
+		 * Set fast poll rate if there are pending out transfers, or
+		 * a transfer was recently processed
+		 */
+		busypoll_timelimit = dbc->xfer_timestamp +
+			msecs_to_jiffies(DBC_XFER_INACTIVITY_TIMEOUT);
+
 		if (!list_empty(&dbc->eps[BULK_OUT].list_pending) ||
-		    !list_empty(&dbc->eps[BULK_IN].list_pending))
+		    time_is_after_jiffies(busypoll_timelimit))
 			poll_interval = 0;
 		break;
+	case EVT_XFER_DONE:
+		dbc->xfer_timestamp = jiffies;
+		poll_interval = 0;
+		break;
 	default:
 		dev_info(dbc->dev, "stop handling dbc events\n");
 		return;
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 9dc8f4d8077c..47ac72c2286d 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -96,6 +96,7 @@ struct dbc_ep {
 #define DBC_WRITE_BUF_SIZE		8192
 #define DBC_POLL_INTERVAL_DEFAULT	64	/* milliseconds */
 #define DBC_POLL_INTERVAL_MAX		5000	/* milliseconds */
+#define DBC_XFER_INACTIVITY_TIMEOUT	10	/* milliseconds */
 /*
  * Private structure for DbC hardware state:
  */
@@ -142,6 +143,7 @@ struct xhci_dbc {
 	enum dbc_state			state;
 	struct delayed_work		event_work;
 	unsigned int			poll_interval;	/* ms */
+	unsigned long			xfer_timestamp;
 	unsigned			resume_required:1;
 	struct dbc_ep			eps[2];
 
@@ -187,6 +189,7 @@ struct dbc_request {
 enum evtreturn {
 	EVT_ERR	= -1,
 	EVT_DONE,
+	EVT_XFER_DONE,
 	EVT_GSER,
 	EVT_DISC,
 };
-- 
2.43.0


