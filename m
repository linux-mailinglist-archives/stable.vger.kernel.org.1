Return-Path: <stable+bounces-203603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B8CE6F82
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB0F3010CCC
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9A226D1E;
	Mon, 29 Dec 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tUe7/Dhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3885D137750
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016951; cv=none; b=UIDCFHp+wEtQqHXplatuu3sb4zXj70XWKbG+FkVmAUIIqCiz1rByryAgIvVF9GZts7tJ1DcrScR+YfmB4wDkKxY3Nn0gloug3v3eJMfTWNdZ+tnjkLSVlk0oXsQMrfnXCviaKJ7TOdVIykqP/k/yHgucEXJ0AsIyLsUaEB1+Fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016951; c=relaxed/simple;
	bh=bJalr4yEADqR3BcB/4bIqet4JwoRhgzwHf26SHubLjA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QsWus7LFUylzxoV9TVUJTo71EKUfWBQRrXdevmTBGVu8ppOpNQs6drcnHqwn+uYC1USc8ecB6FvBKLmqnRU3c/RqoDspu1D9r4t3zcjERTKVw9ziBuIfkWsp8gjqZZnT8o5qD+pAfbgN0vBGBufB2JfQ776XnTIIN94B8sh0OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tUe7/Dhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC51CC4CEF7;
	Mon, 29 Dec 2025 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016951;
	bh=bJalr4yEADqR3BcB/4bIqet4JwoRhgzwHf26SHubLjA=;
	h=Subject:To:Cc:From:Date:From;
	b=tUe7/Dhnv+szNo+M3g8GKoW2J/xK3UOeZDXToE5ZVVH5t4/74myf7jvEy0Hu6Muof
	 tfvcraKXHrFmJ1ielifZ5CdWzhZekAyMo9//e5XqeKwm/X/ps7Q0CMbJ/hDxXi/RtN
	 RMA0qShg3cO49tz6Vrk4iilX+rpNdU2h3rw4zDjc=
Subject: FAILED: patch "[PATCH] xhci: dbgtty: fix device unregister: fixup" failed to apply to 6.1-stable tree
To: ukaszb@chromium.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 15:02:18 +0100
Message-ID: <2025122918-sagging-divisible-a4a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 74098cc06e753d3ffd8398b040a3a1dfb65260c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122918-sagging-divisible-a4a4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


