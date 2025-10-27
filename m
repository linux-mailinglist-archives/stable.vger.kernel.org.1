Return-Path: <stable+bounces-190057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340CC0FAB1
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D41D034FCC5
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDA3161BC;
	Mon, 27 Oct 2025 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWIMcgxt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE12D4B4B
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586350; cv=none; b=rhyJVzMx0wiwqNsYfP120NqGcdos3TLVSOJmyr8Z27ZeZXw0LQm3vcZpnsuxryiO51YzZ5cxLQSzcUjytIiZbvfZnKCi0VS/nHxpZLUcK8c9Pzj4o/dlZ6FUPBjr9xddpC2aLuEkGarlTIUEQGeGL1nG0esQXhSCAyyd5de+rc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586350; c=relaxed/simple;
	bh=BDbqPXmvb6zsC+fTq7iA+b8VOU9KNaHtfeRYWjsagAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlV4qVCz4HrSj87JgiUa1bHVq62uMPYTXlj3v43liyrZDtD2mnds39ElVG5Ji5qaV7/eNsQKax5FgTkgZrjxXsCKb1y5fcjUbEV5zJUIFs5lprvl0tCYsqsisa06scysgDatAJ2dY7gVseT3DbAkXMb3oEirzwMJMfZbJoFt2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWIMcgxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEC5C116B1;
	Mon, 27 Oct 2025 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761586349;
	bh=BDbqPXmvb6zsC+fTq7iA+b8VOU9KNaHtfeRYWjsagAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWIMcgxtGftZiPT7GR3nxST4QyRIYGeBIDAxfUwyMYlbBrv/97vu7LCrKpBf+tAxx
	 gbJVg8HxoQI2BMsygcY34wN/orfNYnQGECMD4BBWQAfdyOM6D4ldZuAVPhxlPU2b07
	 JzdUS252CUDA4c5uU1xkXaRIWIZYwa08/XZ0XW4CWjDWPUvwj4KSvWtgIH4VTvNfAH
	 +cNTxPEDlQjx9AGMSnAkWDI8Gao4mWORrP+UKDGJy95mK7oTbaKqUea5dlACkKyw2K
	 VXpgncfo5I1aPDcpC+Sb5gy846EDBN215dF1KErJncuNyHJFQG4B+q/pobv0lAsv+K
	 GCJ9dLOcU9SUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Uday M Bhat <uday.m.bhat@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] xhci: dbc: poll at different rate depending on data transfer activity
Date: Mon, 27 Oct 2025 13:32:22 -0400
Message-ID: <20251027173226.609057-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027173226.609057-1-sashal@kernel.org>
References: <2025102713-cucumber-persevere-aa50@gregkh>
 <20251027173226.609057-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit fb18e5bb96603cc79d97f03e4c05f3992cf28624 ]

DbC driver starts polling for events immediately when DbC is enabled.
The current polling interval is 1ms, which keeps the CPU busy, impacting
power management even when there are no active data transfers.

Solve this by polling at a slower rate, with a 64ms interval as default
until a transfer request is queued, or if there are still are pending
unhandled transfers at event completion.

Tested-by: Uday M Bhat <uday.m.bhat@intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20240229141438.619372-9-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f3d12ec847b9 ("xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 13 +++++++++++--
 drivers/usb/host/xhci-dbgcap.h |  2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 764657070883c..79d70e5aaa92c 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -665,7 +665,8 @@ static int xhci_dbc_start(struct xhci_dbc *dbc)
 		return ret;
 	}
 
-	return mod_delayed_work(system_wq, &dbc->event_work, 1);
+	return mod_delayed_work(system_wq, &dbc->event_work,
+				msecs_to_jiffies(dbc->poll_interval));
 }
 
 static void xhci_dbc_stop(struct xhci_dbc *dbc)
@@ -964,8 +965,10 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 	enum evtreturn		evtr;
 	struct xhci_dbc		*dbc;
 	unsigned long		flags;
+	unsigned int		poll_interval;
 
 	dbc = container_of(to_delayed_work(work), struct xhci_dbc, event_work);
+	poll_interval = dbc->poll_interval;
 
 	spin_lock_irqsave(&dbc->lock, flags);
 	evtr = xhci_dbc_do_handle_events(dbc);
@@ -981,13 +984,18 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 			dbc->driver->disconnect(dbc);
 		break;
 	case EVT_DONE:
+		/* set fast poll rate if there are pending data transfers */
+		if (!list_empty(&dbc->eps[BULK_OUT].list_pending) ||
+		    !list_empty(&dbc->eps[BULK_IN].list_pending))
+			poll_interval = 1;
 		break;
 	default:
 		dev_info(dbc->dev, "stop handling dbc events\n");
 		return;
 	}
 
-	mod_delayed_work(system_wq, &dbc->event_work, 1);
+	mod_delayed_work(system_wq, &dbc->event_work,
+			 msecs_to_jiffies(poll_interval));
 }
 
 static ssize_t dbc_show(struct device *dev,
@@ -1242,6 +1250,7 @@ xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *
 	dbc->idVendor = DBC_VENDOR_ID;
 	dbc->bcdDevice = DBC_DEVICE_REV;
 	dbc->bInterfaceProtocol = DBC_PROTOCOL;
+	dbc->poll_interval = DBC_POLL_INTERVAL_DEFAULT;
 
 	if (readl(&dbc->regs->control) & DBC_CTRL_DBC_ENABLE)
 		goto err;
diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 2de0dc49a3e9f..d165bafecd98f 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -93,6 +93,7 @@ struct dbc_ep {
 
 #define DBC_QUEUE_SIZE			16
 #define DBC_WRITE_BUF_SIZE		8192
+#define DBC_POLL_INTERVAL_DEFAULT	64	/* milliseconds */
 
 /*
  * Private structure for DbC hardware state:
@@ -139,6 +140,7 @@ struct xhci_dbc {
 
 	enum dbc_state			state;
 	struct delayed_work		event_work;
+	unsigned int			poll_interval;	/* ms */
 	unsigned			resume_required:1;
 	struct dbc_ep			eps[2];
 
-- 
2.51.0


