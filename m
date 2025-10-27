Return-Path: <stable+bounces-189921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6495AC0C178
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 08:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0C93BC458
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC852DCBEC;
	Mon, 27 Oct 2025 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtNjE0og"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978112DCBE6
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 07:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761549623; cv=none; b=klM6uTDc8p5UEdRadF/rH6/0r6ydbLNTBSQ2EzMJWcHm1/HGF8UZBG/bGbqiJcM98oS8UWp0aIR7aipbufbNzcHxPuR6QvQ04M05/8luQNA7QiM82dkwg7M6W5QZg5e68D6d1wUaghZOgkCogeKiC36yyFnM+9efFCky510O4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761549623; c=relaxed/simple;
	bh=Ht7aOpDhI5eD4Zhq7lTVUdyiARjVUT9A/lLHNRSZ1uw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZxWzu1p7rRZaZNP//eK2dokvk1CFo9u09WAR145ZSaazvJ2WdGqjNJiHtsQ4BiY4JPjDz47/22/7lbx766dkOQPKWKPVWa4s8RmcJ16k7JqxxoEjKOQpbGvWlF//wyXvEfc7REeopq10sDqYB8uQIfp5qO9DkAAWED8YJ6CC+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtNjE0og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA666C4CEF1;
	Mon, 27 Oct 2025 07:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761549623;
	bh=Ht7aOpDhI5eD4Zhq7lTVUdyiARjVUT9A/lLHNRSZ1uw=;
	h=Subject:To:Cc:From:Date:From;
	b=PtNjE0ogwan1GehwYlAke43zkyzrNP/JMDl7djVTOaUwwcCc9D8u0B0lWldnkxZLV
	 XrL3QJpK1aqHc8MsJ+Ih8k/qRAJ1wnYzKYUtquJdnYaxHeR0ZWf24V0/EIvjFoGN4z
	 COs9lLKviBRZO57AVIA1z635s6IBi6zAfg1BGHoE=
Subject: FAILED: patch "[PATCH] xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races" failed to apply to 5.10-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org,stable@kernel.org,ukaszb@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Oct 2025 08:20:15 +0100
Message-ID: <2025102715-bagginess-civic-022b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f3d12ec847b945d5d65846c85f062d07d5e73164
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102715-bagginess-civic-022b@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f3d12ec847b945d5d65846c85f062d07d5e73164 Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Tue, 14 Oct 2025 01:55:41 +0300
Subject: [PATCH] xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races
 with stall event
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DbC may add 1024 bogus bytes to the beginneing of the receiving endpoint
if DbC hw triggers a STALL event before any Transfer Blocks (TRBs) for
incoming data are queued, but driver handles the event after it queued
the TRBs.

This is possible as xHCI DbC hardware may trigger spurious STALL transfer
events even if endpoint is empty. The STALL event contains a pointer
to the stalled TRB, and "remaining" untransferred data length.

As there are no TRBs queued yet the STALL event will just point to first
TRB position of the empty ring, with '0' bytes remaining untransferred.

DbC driver is polling for events, and may not handle the STALL event
before /dev/ttyDBC0 is opened and incoming data TRBs are queued.

The DbC event handler will now assume the first queued TRB (length 1024)
has stalled with '0' bytes remaining untransferred, and copies the data

This race situation can be practically mitigated by making sure the event
handler handles all pending transfer events when DbC reaches configured
state, and only then create dev/ttyDbC0, and start queueing transfers.
The event handler can this way detect the STALL events on empty rings
and discard them before any transfers are queued.

This does in practice solve the issue, but still leaves a small possible
gap for the race to trigger.
We still need a way to distinguish spurious STALLs on empty rings with '0'
bytes remaing, from actual STALL events with all bytes transmitted.

Cc: stable <stable@kernel.org>
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 63edf2d8f245..023a8ec6f305 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -892,7 +892,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			dev_info(dbc->dev, "DbC configured\n");
 			portsc = readl(&dbc->regs->portsc);
 			writel(portsc, &dbc->regs->portsc);
-			return EVT_GSER;
+			ret = EVT_GSER;
+			break;
 		}
 
 		return EVT_DONE;
@@ -954,7 +955,8 @@ static enum evtreturn xhci_dbc_do_handle_events(struct xhci_dbc *dbc)
 			break;
 		case TRB_TYPE(TRB_TRANSFER):
 			dbc_handle_xfer_event(dbc, evt);
-			ret = EVT_XFER_DONE;
+			if (ret != EVT_GSER)
+				ret = EVT_XFER_DONE;
 			break;
 		default:
 			break;


