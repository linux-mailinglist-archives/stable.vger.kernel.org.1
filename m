Return-Path: <stable+bounces-190159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD7AC10137
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE9254FE029
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAE321F48;
	Mon, 27 Oct 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2I6+fpQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBC31B82C
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590575; cv=none; b=pEK44YMEPFA81KYz5B/DWEiP9DAzTZ6wzQpe45DPIC525zgU2cJhKRjXG8xmrhLYEdzbdTa6Qbv/52l/0UAqCN06WaPNPUUbI/3NNGTPV3fD8GxjCe+2bAM8quKEUM6UAweOWZGsm1YGRjyhl0dJYpTFv7MmCPjOX9LIvKGLvAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590575; c=relaxed/simple;
	bh=B+ZNwGoSK9XRgSnYXwwvft8cMrT1JLi3VhND6IClJRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfeXKGBI+HIKlLZnSLzdOfPG2XMl8rbqZyvcWO0+Z3CsWu0udY4S2PW4aGCJV0XYnuzdPp/10F/wzTyecEWqYYhvlHPXRFIEZK28C1CArhC7g6rp8DfOtYOS84NBrPITJtvjemG09LvGp9hTwb2iXt2Wy0kMqaR5pmnm4P7xzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2I6+fpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F447C4CEF1;
	Mon, 27 Oct 2025 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761590575;
	bh=B+ZNwGoSK9XRgSnYXwwvft8cMrT1JLi3VhND6IClJRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2I6+fpQlZauvoAvmTWk24EDAqk8Ul+DhmbHPYrLPF/1haYq1qH17RqD66HDFIm36
	 bkWGZ6kmt7xNMryAag9XkF9I3Tbl5CcTOlix0N7rwDmMtj1U9SmnunsiWuoa/tumjo
	 y0m/JjUte23PqrvJnm8qRpGZ5SPg2eFZglDA/+6o5rMZlrhFqR79UPCHQvI1N1oY+3
	 y542g5iuWJ+HBboBc+arOpWhdq8hh/KENk9nVE04CyzPouxP8A5NBbv5IAQ3H29gDM
	 vok5Io1PvqPVKqpLI+dSkAHovL8HxgiSARvlNSfFGqQ2NZVVzCIKIXkY2l+CuW0gud
	 K+Gkwrb3aJrVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
	Uday M Bhat <uday.m.bhat@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/6] xhci: dbc: poll at different rate depending on data transfer activity
Date: Mon, 27 Oct 2025 14:42:48 -0400
Message-ID: <20251027184252.639069-2-sashal@kernel.org>
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
index 9a1728333affa..fa4ef738d9e62 100644
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
index 34c20d6c9e559..86312043552df 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -93,6 +93,7 @@ struct dbc_ep {
 
 #define DBC_QUEUE_SIZE			16
 #define DBC_WRITE_BUF_SIZE		8192
+#define DBC_POLL_INTERVAL_DEFAULT	64	/* milliseconds */
 
 /*
  * Private structure for DbC hardware state:
@@ -138,6 +139,7 @@ struct xhci_dbc {
 
 	enum dbc_state			state;
 	struct delayed_work		event_work;
+	unsigned int			poll_interval;	/* ms */
 	unsigned			resume_required:1;
 	struct dbc_ep			eps[2];
 
-- 
2.51.0


