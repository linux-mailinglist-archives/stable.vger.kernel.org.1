Return-Path: <stable+bounces-203602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE44CE6F7F
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD672300E786
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A601397;
	Mon, 29 Dec 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xW2mXNl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27CA137750
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016948; cv=none; b=jcklvbBQgHowbq5sAP+hqVwhiQxHRf7KqgT2JUO35VaIdgEOV17P5MmJZxXBkixiw1wSh2epP+UJjW5N2+N+EoDnLADqruC28oVIH9bh/vSjn/DYqX3Kl9TpkhiFChWJWST5meX9Q2Ku0j6yXO37rReGM4b1gh/uRIQU1oM13QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016948; c=relaxed/simple;
	bh=4NSkk35Qy03vW8BoRzYfSydTee7xawEpeVuvVg+ZdII=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y5BPFaK/Gs2CLdjRHhlw4mnNDA8qCQAedGDmSChu8v9kavMJV6uY4yhNxYHZagfHhgYeMxiKqckOjN8TB3G2znUawaxWb1efjUiBwkgeuE5VwfV3NxhPx/EDnZFqFNnztxEnqIHbmHimOTdyKfXyfUSpZgQp14Ry1owkXnZbA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xW2mXNl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56CDC4CEF7;
	Mon, 29 Dec 2025 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016948;
	bh=4NSkk35Qy03vW8BoRzYfSydTee7xawEpeVuvVg+ZdII=;
	h=Subject:To:Cc:From:Date:From;
	b=xW2mXNl++GFaME8oxMd6Mnb/oTOm0cS+9s9WjGUdAh/dDhLWS6dRmURPLDXJcxBve
	 R7yX/MIc4on9L8pH0TDaM1ca/AvduvZZq92Z27HzIigsZZvWGgjkLizex3gnrZ2RSC
	 NdXc6rIUNvxetw9z2m7Wmw+R2jMawi7Hr9NdgkiA=
Subject: FAILED: patch "[PATCH] xhci: dbgtty: fix device unregister: fixup" failed to apply to 6.6-stable tree
To: ukaszb@chromium.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:02:17 +0100
Message-ID: <2025122917-keenly-greyhound-4fa6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 74098cc06e753d3ffd8398b040a3a1dfb65260c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122917-keenly-greyhound-4fa6@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74098cc06e753d3ffd8398b040a3a1dfb65260c0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Date: Thu, 27 Nov 2025 11:16:44 +0000
Subject: [PATCH] xhci: dbgtty: fix device unregister: fixup
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixup replaces tty_vhangup() call with call to
tty_port_tty_vhangup(). Both calls hangup tty device
synchronously however tty_port_tty_vhangup() increases
reference count during the hangup operation using
scoped_guard(tty_port_tty).

Cc: stable <stable@kernel.org>
Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 57cdda4e09c8..90282e51e23e 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -554,7 +554,7 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	 * Hang up the TTY. This wakes up any blocked
 	 * writers and causes subsequent writes to fail.
 	 */
-	tty_vhangup(port->port.tty);
+	tty_port_tty_vhangup(&port->port);
 
 	tty_unregister_device(dbc_tty_driver, port->minor);
 	xhci_dbc_tty_exit_port(port);


