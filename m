Return-Path: <stable+bounces-87002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930949A5D82
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2BC1F21639
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27E1E0DE6;
	Mon, 21 Oct 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xj1UR7ba"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776C1D0947
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496986; cv=none; b=B8XQ0glgJSXO25qDzSK8Qs46tvDd2jVid8Y4eLqNnx0bcND5KeDx4sdlowqHjtkHzH4uYrWiGGuYywB8kZimR9nJ9XtLkQfxAYNagrJAPyQJ7eE/C2K/JPEnunmxyyUAuzpVCGM2sivvqNFdlQo/tsvno7qFD/xlKzpCLLb+6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496986; c=relaxed/simple;
	bh=WwzmyuPpD7AR1MGFLY52Y5yMQbez6SCKQxRGnbNoe8U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cyTf72VOKM0nSntUb+aA4M/1yesQiq8/UZ2BY4o7EZjhv79g/wiRVKo6Uik6hEzhLb8oqN6i81I1uKgVEuGWuGy/p+7/vaajI7rZWbDnwaL8E1HgibOE/wRdaB8xUuuYym7GRTzYo1a5Khc81kMPdQ0e3jyL+dvXbrkMMb+ZQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xj1UR7ba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BB4C4CEC3;
	Mon, 21 Oct 2024 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729496985;
	bh=WwzmyuPpD7AR1MGFLY52Y5yMQbez6SCKQxRGnbNoe8U=;
	h=Subject:To:Cc:From:Date:From;
	b=xj1UR7bayX5kmDGMz4YH96fkTQFHoUgbEpzlKPdXOVMorjKGtjP8GYjyioW2wweO2
	 G5oNUfwaWghhQb7jbTmhZUsfaTCmfWe9wPUyYU2QWSf2ipm489sBujvk2Yq8bJ6ECv
	 CQn+geUsVE5FRomskp0Z/53l7PZDP14kxgIDGAPs=
Subject: FAILED: patch "[PATCH] xhci: dbc: honor usb transfer size boundaries." failed to apply to 6.11-stable tree
To: mathias.nyman@linux.intel.com,gregkh@linuxfoundation.org,uday.m.bhat@intel.com,ukaszb@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 09:49:42 +0200
Message-ID: <2024102142-eskimo-lumber-a654@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 30c9ae5ece8ecd69d36e6912c2c0896418f2468c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102142-eskimo-lumber-a654@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30c9ae5ece8ecd69d36e6912c2c0896418f2468c Mon Sep 17 00:00:00 2001
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Date: Wed, 16 Oct 2024 17:00:00 +0300
Subject: [PATCH] xhci: dbc: honor usb transfer size boundaries.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Treat each completed full size write to /dev/ttyDBC0 as a separate usb
transfer. Make sure the size of the TRBs matches the size of the tty
write by first queuing as many max packet size TRBs as possible up to
the last TRB which will be cut short to match the size of the tty write.

This solves an issue where userspace writes several transfers back to
back via /dev/ttyDBC0 into a kfifo before dbgtty can find available
request to turn that kfifo data into TRBs on the transfer ring.

The boundary between transfer was lost as xhci-dbgtty then turned
everyting in the kfifo into as many 'max packet size' TRBs as possible.

DbC would then send more data to the host than intended for that
transfer, causing host to issue a babble error.

Refuse to write more data to kfifo until previous tty write data is
turned into properly sized TRBs with data size boundaries matching tty
write size

Tested-by: Uday M Bhat <uday.m.bhat@intel.com>
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20241016140000.783905-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 8ec813b6e9fd..9dc8f4d8077c 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -110,6 +110,7 @@ struct dbc_port {
 	struct tasklet_struct		push;
 
 	struct list_head		write_pool;
+	unsigned int			tx_boundary;
 
 	bool				registered;
 };
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index b8e78867e25a..d719c16ea30b 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -24,6 +24,29 @@ static inline struct dbc_port *dbc_to_port(struct xhci_dbc *dbc)
 	return dbc->priv;
 }
 
+static unsigned int
+dbc_kfifo_to_req(struct dbc_port *port, char *packet)
+{
+	unsigned int	len;
+
+	len = kfifo_len(&port->port.xmit_fifo);
+
+	if (len == 0)
+		return 0;
+
+	len = min(len, DBC_MAX_PACKET);
+
+	if (port->tx_boundary)
+		len = min(port->tx_boundary, len);
+
+	len = kfifo_out(&port->port.xmit_fifo, packet, len);
+
+	if (port->tx_boundary)
+		port->tx_boundary -= len;
+
+	return len;
+}
+
 static int dbc_start_tx(struct dbc_port *port)
 	__releases(&port->port_lock)
 	__acquires(&port->port_lock)
@@ -36,7 +59,7 @@ static int dbc_start_tx(struct dbc_port *port)
 
 	while (!list_empty(pool)) {
 		req = list_entry(pool->next, struct dbc_request, list_pool);
-		len = kfifo_out(&port->port.xmit_fifo, req->buf, DBC_MAX_PACKET);
+		len = dbc_kfifo_to_req(port, req->buf);
 		if (len == 0)
 			break;
 		do_tty_wake = true;
@@ -200,14 +223,32 @@ static ssize_t dbc_tty_write(struct tty_struct *tty, const u8 *buf,
 {
 	struct dbc_port		*port = tty->driver_data;
 	unsigned long		flags;
+	unsigned int		written = 0;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	if (count)
-		count = kfifo_in(&port->port.xmit_fifo, buf, count);
-	dbc_start_tx(port);
+
+	/*
+	 * Treat tty write as one usb transfer. Make sure the writes are turned
+	 * into TRB request having the same size boundaries as the tty writes.
+	 * Don't add data to kfifo before previous write is turned into TRBs
+	 */
+	if (port->tx_boundary) {
+		spin_unlock_irqrestore(&port->port_lock, flags);
+		return 0;
+	}
+
+	if (count) {
+		written = kfifo_in(&port->port.xmit_fifo, buf, count);
+
+		if (written == count)
+			port->tx_boundary = kfifo_len(&port->port.xmit_fifo);
+
+		dbc_start_tx(port);
+	}
+
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
-	return count;
+	return written;
 }
 
 static int dbc_tty_put_char(struct tty_struct *tty, u8 ch)
@@ -241,6 +282,10 @@ static unsigned int dbc_tty_write_room(struct tty_struct *tty)
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	room = kfifo_avail(&port->port.xmit_fifo);
+
+	if (port->tx_boundary)
+		room = 0;
+
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return room;


