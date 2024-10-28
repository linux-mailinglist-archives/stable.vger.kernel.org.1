Return-Path: <stable+bounces-88821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D59B27A6
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D098CB21379
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A82818F2C3;
	Mon, 28 Oct 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LITScBYh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A162AF07;
	Mon, 28 Oct 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098198; cv=none; b=dj4r8POvILcyygGQO+2BGvSswCM6RTps9fy/y4w/Pn4960aOk0k1DBUd3H6o5bQMyIdqfJb2CCDlj1+BtdeqVKAZXy2AjMdCqHuzmI0epdwh1EV405srSuuxqLoYti5Vr0dLy2cJJeB77JRTRcFJWDYrqQR1DH+ZLLyxMBBpntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098198; c=relaxed/simple;
	bh=wAXbvXJH304xUZpANwbjq9oJ0o3cJUabWj8T6NHHJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcW3FGSfiMoWgGqZrO2Wg5V3k5sieZn085PVrxwZ5wmZ21OWUeB7Nxln3B7q2eCK+IukWYAX71zuQVmGMjwkCuMgppqkrbO5RdqOzhg28OJ+0nJyf6v3uOXb2DtxTfCAEO580ujny6OM8OsuRj0aaCwmYAZ370KZ95Z+L8QwIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LITScBYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EB7C4CEC3;
	Mon, 28 Oct 2024 06:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098198;
	bh=wAXbvXJH304xUZpANwbjq9oJ0o3cJUabWj8T6NHHJd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LITScBYhJoHNtnvMNQVt3SBCjx6n7CmYpz8Ng3o4jKbzW+mIC4tiVh5kuNke91C1q
	 QoDzfgroTCXvpEuSWyRqB4ypw9yd+PazWcQlNXPT1KTpdVuc0NrRL/i9auwvVetsLk
	 U0I6a7XyshVEkegIbOlt2iEPGYReQVu2Vn0Y9ko8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Uday M Bhat <uday.m.bhat@intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 120/261] xhci: dbc: honor usb transfer size boundaries.
Date: Mon, 28 Oct 2024 07:24:22 +0100
Message-ID: <20241028062315.036685457@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 30c9ae5ece8ecd69d36e6912c2c0896418f2468c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgcap.h |  1 +
 drivers/usb/host/xhci-dbgtty.c | 55 ++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 8ec813b6e9fda..9dc8f4d8077cc 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -110,6 +110,7 @@ struct dbc_port {
 	struct tasklet_struct		push;
 
 	struct list_head		write_pool;
+	unsigned int			tx_boundary;
 
 	bool				registered;
 };
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 881f5a7e6e0e1..0266c2f5bc0d8 100644
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
-- 
2.43.0




