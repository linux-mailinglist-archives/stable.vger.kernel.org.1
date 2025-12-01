Return-Path: <stable+bounces-197960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 197ABC9873A
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A494E416D
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19E336ECB;
	Mon,  1 Dec 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBlBWXVn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5073336EC8
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609141; cv=none; b=qWtpQzRqUHq7FvLnsBsaiLrVci8dL4Fc+WZfDZseb8XAf1v6+eXTZP3sX5AiFONuqSbpaZXc0Izf+LDwUWM9e92CfsXyMTXgIuQTz1rykGAoIllLnHqhQQTU8jEhtk4zmM3NDhycAXMl4qma9JbbRxNPJdgi18PPee+EshIXHn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609141; c=relaxed/simple;
	bh=808iOgUlLiqYTFfK0U373Sta2EyyPA29sNC5SFEkts4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LN5dBDmuXFvBanW8e1xbndmflgU5+XeCWl6gQVT3IaEs8mVktxbRKUEkLAQceZvFgcWa2jQfPkrUnWIhP3nxToMuDwBtE4+LL/K+B14qrngXSZJ4KDshSfk7snXmNzZHExPx6Fxv8YLD5xBnh+4t7++pwFHcO2wb4uSu2zwV64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBlBWXVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A06C19422;
	Mon,  1 Dec 2025 17:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764609141;
	bh=808iOgUlLiqYTFfK0U373Sta2EyyPA29sNC5SFEkts4=;
	h=Subject:To:Cc:From:Date:From;
	b=vBlBWXVnxEsHBALWKU9oWGyENtFzui9VmrbzSE1WSyhfAW7Gn4cPzHv3N/oxA1cAd
	 zc+PU8P1fTq7aP9gOtEenjWnLG9NqJc9b+/D+YkjYYmTnIjeNFhZ6KDSXU9xhKzqE+
	 b8nNw3/QYr+E67ZEEZZNof0Gp1Sf/+IakKwuf4SY=
Subject: FAILED: patch "[PATCH] xhci: dbgtty: fix device unregister" failed to apply to 5.10-stable tree
To: ukaszb@chromium.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 18:12:10 +0100
Message-ID: <2025120110-coastal-litigator-8952@gregkh>
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
git cherry-pick -x 1f73b8b56cf35de29a433aee7bfff26cea98be3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120110-coastal-litigator-8952@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1f73b8b56cf35de29a433aee7bfff26cea98be3f Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Date: Wed, 19 Nov 2025 21:29:09 +0000
Subject: [PATCH] xhci: dbgtty: fix device unregister
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When DbC is disconnected then xhci_dbc_tty_unregister_device()
is called. However if there is any user space process blocked
on write to DbC terminal device then it will never be signalled
and thus stay blocked indifinitely.

This fix adds a tty_vhangup() call in xhci_dbc_tty_unregister_device().
The tty_vhangup() wakes up any blocked writers and causes subsequent
write attempts to DbC terminal device to fail.

Cc: stable <stable@kernel.org>
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://patch.msgid.link/20251119212910.1245694-1-ukaszb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index b7f95565524d..57cdda4e09c8 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -550,6 +550,12 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 
 	if (!port->registered)
 		return;
+	/*
+	 * Hang up the TTY. This wakes up any blocked
+	 * writers and causes subsequent writes to fail.
+	 */
+	tty_vhangup(port->port.tty);
+
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);
 	port->registered = false;


