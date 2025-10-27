Return-Path: <stable+bounces-190163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19777C1011C
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467F61A2058A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496B322DCB;
	Mon, 27 Oct 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4y4fwD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7131D378
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590578; cv=none; b=DpwF8COXNVDc9G50aUYuHA/SFD56qLNT2tDnLIKWKbC/ZOHoTGlxL+Ykg3IvT/iVivpPvNORT5X8sbQjOJJ3v3grJ2b8U5TWtUztgqXSa9jtW+IGByUbFNEAiNDTsYsOj0e7BFYuOjGyPJhoArQ5iVH05sW6yNE7bPj+7+vq9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590578; c=relaxed/simple;
	bh=mhycTtNJ2PayCxjDdPGSWX9VfSLcH3PAywQivDeHCBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeeTnBEp7B/9oKvHmRs0W0ExhFSc7NHYiB1Ubg8DCGbS4GxOQNyY0cgcOMI8yImIg4JrBT1/sXypoVYpmIkIfMqrlIczflmz+KfJet+rWtjhQav8HTlT1KC5jtta3qK347usVMHjOOiaTn9IsyWSrLWn/de9Or1N7wP+9wE9Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4y4fwD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C819BC4CEF1;
	Mon, 27 Oct 2025 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590578;
	bh=mhycTtNJ2PayCxjDdPGSWX9VfSLcH3PAywQivDeHCBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F4y4fwD9W2YFeYK8TndV7jv6GKaAC70zse9huLLb70k0PfZ3qvblepZgk52OJgvjQ
	 QXoQ1L/nN94QPziM7QHtlF+QWXejiXhJ9oWt/EWbplx6BUZhP7vTAGuapTqIvSGbAY
	 g2it4wStdZAXP7x2XHq+JVyRARat9n/H0450ok416cfkxlG4ax2MREflzyZ9kdMfIo
	 UItuH0nlgxWprNk/k/FVDc+I527gbbdi6e6aOlpkEVyrykMKyo74ryg/zu8atYFaBS
	 WOXHr2wIKPDimnhUG7U5uDJu4X0Z9zX4/d0lrjz/rMuhjHhA979iIHFOep/8OIEJoR
	 3uOiVdrQg+liA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 5/6] xhci: dbc: Avoid event polling busyloop if pending rx transfers are inactive.
Date: Mon, 27 Oct 2025 14:42:51 -0400
Message-ID: <20251027184252.639069-5-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027184252.639069-1-sashal@kernel.org>
References: <2025102714-patriot-eel-32c8@gregkh>
 <20251027184252.639069-1-sashal@kernel.org>
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
index ce56b9316e124..86b1d1b84ed1d 100644
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
index abafd31e04e05..cda5a14b9462e 100644
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
@@ -140,6 +141,7 @@ struct xhci_dbc {
 	enum dbc_state			state;
 	struct delayed_work		event_work;
 	unsigned int			poll_interval;	/* ms */
+	unsigned long			xfer_timestamp;
 	unsigned			resume_required:1;
 	struct dbc_ep			eps[2];
 
@@ -185,6 +187,7 @@ struct dbc_request {
 enum evtreturn {
 	EVT_ERR	= -1,
 	EVT_DONE,
+	EVT_XFER_DONE,
 	EVT_GSER,
 	EVT_DISC,
 };
-- 
2.51.0


