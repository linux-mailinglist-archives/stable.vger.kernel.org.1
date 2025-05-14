Return-Path: <stable+bounces-144369-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13564AB6BBB
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C407D1893D50
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1F4270571;
	Wed, 14 May 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmMI/ERY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B54156F45
	for <stable@vger.kernel.org>; Wed, 14 May 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226902; cv=none; b=rnZp31cB7aib+AmFnj/z3bHlsWXRtCnrhO6uOWIp0GnXChM8/wUDBWH8COhST3nqNoTwLWe4ALGdzasluwM4cTPYnhWMJ9fwhfv5Ko1ykZH+OQELE2rPxc+opAqxKNhyCH3/L3uYJ9xD5a7UwPtmdJgwBNzdAXvLsYr6bZFSIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226902; c=relaxed/simple;
	bh=zoM4WnRi5RJ/q0Bc58RgWuhyFG7CfNuGKkozXs9g/Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qVFFs9kkxSahHPU+HJlX+ZDGCBn/03zcVxWh9xAmQzqL9/AxQEjBu3EinEmieZLdybwsOr7gAKZTlcJUmkiuSMEjwDPc2WF7J0N9Hbam6kNT5fIi4cmM3jxzCBeUxUwHTm9m/uTRsa3+51f2K4pAIKfTIMgeaIoIJ4SbQkb0oHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dmMI/ERY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747226901; x=1778762901;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zoM4WnRi5RJ/q0Bc58RgWuhyFG7CfNuGKkozXs9g/Xk=;
  b=dmMI/ERY7nVb3qL7NHNsxgO3ZhXHDJDCSmHOl/G9QS9PXTkMnlSeDEZw
   mQCUSiQZ3+5nFE3oj1wvF+xOa1wEP4e3MKBppsYLfhVqG9AdI/KZEn8iL
   85VJ+gM/VSHfW6cVGQpA5qWuYMyhTKSDuXiv67jW9cdtN6FDX3YTNTMym
   we7aZJL3w7fsI1rBjnNVU5MQukaH9UBwGQm+r+gLve1WzEQRzs6485zQV
   4gDMPwN15Zh+S0HgxQP8JRJ6cYhPVeVeJyzbp1WER8v0Js1+U2lIbboWd
   Js32Qg/unp4+1WAxjab9sFWU/ekp/Iafb6uX6C3LHJFIgNzMF1pQqBT7o
   g==;
X-CSE-ConnectionGUID: /e1cF56DQn6WhxOXIWkQ6Q==
X-CSE-MsgGUID: 64+ZPWRUTJ6CXKBSEwUhjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="74520116"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="74520116"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 05:48:20 -0700
X-CSE-ConnectionGUID: LOt5dIjVTZer5yYtIUBBMg==
X-CSE-MsgGUID: /41MbBWDTj2fDFCy+IFpew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="143150265"
Received: from unknown (HELO mnyman-desk.fi.intel.com) ([10.237.72.199])
  by orviesa005.jf.intel.com with ESMTP; 14 May 2025 05:48:19 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Subject: [PATCH] xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
Date: Wed, 14 May 2025 15:47:47 +0300
Message-ID: <20250514124748.168922-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit cab63934c33b12c0d1e9f4da7450928057f2c142 ]

Backport for linux-6.12.y stable

6.12 kernel used older poll_interval of 1ms instead of 0 as described
in the original commit message below.
CPU hogging is not that bad with 1ms delay, fix it anyways, but don't
touch poll_interval.

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
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 19 ++++++++++++++++---
 drivers/usb/host/xhci-dbgcap.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 241d7aa1fbc2..b12273f72c93 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -822,6 +822,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 {
 	dma_addr_t		deq;
 	union xhci_trb		*evt;
+	enum evtreturn		ret = EVT_DONE;
 	u32			ctrl, portsc;
 	bool			update_erdp = false;
 
@@ -906,6 +907,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
+			ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
@@ -924,7 +926,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 		lo_hi_writeq(deq, &dbc->regs->erdp);
 	}
 
-	return EVT_DONE;
+	return ret;
 }
 
 static void xhci_dbc_handle_events(struct work_struct *work)
@@ -933,6 +935,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 	struct xhci_dbc		*dbc;
 	unsigned long		flags;
 	unsigned int		poll_interval;
+	unsigned long		busypoll_timelimit;
 
 	dbc = container_of(to_delayed_work(work), struct xhci_dbc, event_work);
 	poll_interval = dbc->poll_interval;
@@ -951,11 +954,21 @@ static void xhci_dbc_handle_events(struct work_struct *work)
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
 			poll_interval = 1;
 		break;
+	case EVT_XFER_DONE:
+		dbc->xfer_timestamp = jiffies;
+		poll_interval = 1;
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


