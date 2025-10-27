Return-Path: <stable+bounces-190041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E50C0F557
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 17:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A80464407
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D35B3128DA;
	Mon, 27 Oct 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOXfulKx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067E530ACF4
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582565; cv=none; b=de39RMGTr4aGPrPJrcRDswLDwyzTmPKhZxe/+C6rRC2ieJEFYCnTJsSHpRe1faO9Xp6dK12Dna7VkvQD4tJlILq6S0nRH0a1qgso0UJ4rXpHpM6Qzw2yON211FEE3jo0rQ17Wg35vpQZ8cD+mttRtJJhYcYqcg2d2IRhlR/vwZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582565; c=relaxed/simple;
	bh=9G7HcCue1KgV8b59QPx2zzmoYhWrYa4zv4XefXoROgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lB5qc7sKURUdZsKoGumN1hbqcSlRzRte1ujHQmxmT5NkwFIgW+WDDfD2stHb6mH6hwuecFrKjypiEf5EEn9mbEOTA+qkohww2HiW+zjGxJKnOHDycwlatQL3yXFCmUHVt20fJiy9+I9sCdoQjyhMxskfHb8MUpxrf1+1l13AGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOXfulKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EB0C113D0;
	Mon, 27 Oct 2025 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761582564;
	bh=9G7HcCue1KgV8b59QPx2zzmoYhWrYa4zv4XefXoROgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOXfulKxXxIOYfLA88o4kMxTdPVHwAbVvM6QGy6q/DgO1Ogc7BJQEri6B7emf7Bnl
	 186FdfMhiU8Q4v9fQtW0rpIaKiEI4kwHr4MA+xw+MMU3WCJuGMDkfPSZnKfIUNtZ6a
	 3NV3FMP3UdMPBUu9ghw2iyden9kfu/u4nwYM93c7HZax3nWRErvKVUWaMC7GPEoQBH
	 a0GwWA/XNalkaGA6DvzZ7ggDyjuc57Lrz/262CJUEP6bnQ3Ei5/ZPwU6QRx2ySzpqC
	 N/4is1klB2JD//SGO5Mr9/R0/yVe6wfxyRib6YCxCz6R453H3YnKQojvAKjutQIhtv
	 ejluP+HOFF/DA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
Date: Mon, 27 Oct 2025 12:29:18 -0400
Message-ID: <20251027162919.577996-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027162919.577996-1-sashal@kernel.org>
References: <2025102712-unearned-duplicate-8c3b@gregkh>
 <20251027162919.577996-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit cab63934c33b12c0d1e9f4da7450928057f2c142 ]

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
Link: https://lore.kernel.org/r/20250505125630.561699-3-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: f3d12ec847b9 ("xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.c | 19 ++++++++++++++++---
 drivers/usb/host/xhci-dbgcap.h |  3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 177382632614e..ca541914f7035 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -855,6 +855,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 {
 	dma_addr_t		deq;
 	union xhci_trb		*evt;
+	enum evtreturn		ret = EVT_DONE;
 	u32			ctrl, portsc;
 	bool			update_erdp = false;
 
@@ -939,6 +940,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
+			ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;
@@ -957,7 +959,7 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 		lo_hi_writeq(deq, &dbc->regs->erdp);
 	}
 
-	return EVT_DONE;
+	return ret;
 }
 
 static void xhci_dbc_handle_events(struct work_struct *work)
@@ -966,6 +968,7 @@ static void xhci_dbc_handle_events(struct work_struct *work)
 	struct xhci_dbc		*dbc;
 	unsigned long		flags;
 	unsigned int		poll_interval;
+	unsigned long		busypoll_timelimit;
 
 	dbc = container_of(to_delayed_work(work), struct xhci_dbc, event_work);
 	poll_interval = dbc->poll_interval;
@@ -984,11 +987,21 @@ static void xhci_dbc_handle_events(struct work_struct *work)
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
index 313b5e97a4672..1fab3eb9c831d 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -95,6 +95,7 @@ struct dbc_ep {
 #define DBC_WRITE_BUF_SIZE		8192
 #define DBC_POLL_INTERVAL_DEFAULT	64	/* milliseconds */
 #define DBC_POLL_INTERVAL_MAX		5000	/* milliseconds */
+#define DBC_XFER_INACTIVITY_TIMEOUT	10	/* milliseconds */
 /*
  * Private structure for DbC hardware state:
  */
@@ -141,6 +142,7 @@ struct xhci_dbc {
 	enum dbc_state			state;
 	struct delayed_work		event_work;
 	unsigned int			poll_interval;	/* ms */
+	unsigned long			xfer_timestamp;
 	unsigned			resume_required:1;
 	struct dbc_ep			eps[2];
 
@@ -186,6 +188,7 @@ struct dbc_request {
 enum evtreturn {
 	EVT_ERR	= -1,
 	EVT_DONE,
+	EVT_XFER_DONE,
 	EVT_GSER,
 	EVT_DISC,
 };
-- 
2.51.0


