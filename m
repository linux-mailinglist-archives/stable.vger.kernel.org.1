Return-Path: <stable+bounces-197959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 573BFC9872E
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFC354E2DF9
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27D30E0D4;
	Mon,  1 Dec 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZoDBUTul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E0F335BDC
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609133; cv=none; b=MzY37OO44bvYUV+r3G+vXR/ZcsEBEMvMnRQV82tokZ4y07UdOvYcaPuiRU0/5ozuSe3EYM8VGdhPha6w8Lmf9AwampyPdwiFxOVKUpyuYlMnL9JjVl9ATsmbeNDzjRosooxqP84Qp+znSVY6wulwFWvM/3Hk/i4WwBtLkU+lsGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609133; c=relaxed/simple;
	bh=TlAN2cItmErfGghtc2FK9E7jtd1uSoQF0QzkME/R2z0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kULD9akhi02TcHW7vUOgq1XzwBoWvkZV3w4EwTo81khI7GMtdT9CpgHMLICO+5rwjl+saztgQqqAPuIIB5qbm18RbRcCmXgedrFvzayy5k8pyYQZN63EK3N0O+JghPHI5jqCXwILH6PKKX84AqgmXCH+7PdBCkQ7SKKE/JnR5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZoDBUTul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CACC19422;
	Mon,  1 Dec 2025 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764609133;
	bh=TlAN2cItmErfGghtc2FK9E7jtd1uSoQF0QzkME/R2z0=;
	h=Subject:To:Cc:From:Date:From;
	b=ZoDBUTul9g7YeqUMJB/Janpq9rUZSy3Rgks9lfAt8G6mJcG4I1MUMuWnnFdaNH9+X
	 bkQC//4xdSHyBsvwbYNNpGXkhRd/qTeSRo7I3jE0T9SDitA8j5x0Titn7szibJZrON
	 5+BuM5CW6RzveT9BkIXsNANbjauMsg89xeWBXms4=
Subject: FAILED: patch "[PATCH] xhci: dbgtty: fix device unregister" failed to apply to 5.15-stable tree
To: ukaszb@chromium.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 18:12:10 +0100
Message-ID: <2025120110-deuce-arrange-e66c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1f73b8b56cf35de29a433aee7bfff26cea98be3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120110-deuce-arrange-e66c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


