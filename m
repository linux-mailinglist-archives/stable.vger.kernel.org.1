Return-Path: <stable+bounces-86503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB99A0C0D
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE21C22520
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F8420C007;
	Wed, 16 Oct 2024 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ti4ZmQVl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097D20C000;
	Wed, 16 Oct 2024 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087086; cv=none; b=IisAmP10QM76Sn3KrkVJV5U/YOcmas185Dv6m9yPXdba8/V/9zDWR6YzHZrHouVYh+hmEebxeyF9iMsK1OGWhx9b47tZxP45OZMysaYrUz8D7sU+44zs6HFGxD1vbzkq/59Z7xmI6hNJ3mKxwfuovCsqTrU4eSTFswpVxyA0O1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087086; c=relaxed/simple;
	bh=CNhKFwL3hrGpnciMqwCTYZJcQC1POF4XejApSmQzBg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpBYsoviG1BQiVPTIZHf5C+/Qix9803UbBaLkV3FBpzocLuEz8r1XHL1adKf9trFTrVvGoWDk33i14qbwNipsGJfpqGoM1Sg29V/ctzLOgm0/7SINNvEy2e3ByGzAqOhMXUQ/PrKKjnj9G3NHWHzWChOWAsCOk43QgSVKqdjzlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ti4ZmQVl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729087085; x=1760623085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNhKFwL3hrGpnciMqwCTYZJcQC1POF4XejApSmQzBg4=;
  b=Ti4ZmQVlbOGWLNF2meVcjTeLREwDtYG6VRW6ah5uLk1ybFsvvfKAFvJj
   eXwbg0sCzHAofQ5D9pZEgpYdbqG9Idy59zgbPOOy3Dd5qpI67cIqB6qXC
   MK7mpIXt1rM8GGB2U23AfInYFTySpSGKVnUdbStLqxdbzz6d4Ss8iOqcN
   w+KLgCeS8azZmCR2Izom0tFkvzg2mgCv88feXW6jwp7j+/wxTMZYqUpsE
   XHRKBPVA0H8SMeAJimhYXpXkenr202ojLsdIIIlwGiuAcUtkNRb/T80iE
   GkVFWLh5hd74I9VqYR199Fatv+LikNLQ4Snq6VvcrBU5o/ICyLbFpph+6
   w==;
X-CSE-ConnectionGUID: +xFbyDECRNOG0FJnkbaDug==
X-CSE-MsgGUID: M+47JckCQkehGUiRe/UmPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28664031"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28664031"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:58:04 -0700
X-CSE-ConnectionGUID: 8fqjvmOfT06QbzPHiOM3bA==
X-CSE-MsgGUID: xxuISZWUTZ+WQRp/S8w9gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82776245"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 16 Oct 2024 06:58:02 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Uday M Bhat <uday.m.bhat@intel.com>,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] xhci: dbc: honor usb transfer size boundaries.
Date: Wed, 16 Oct 2024 17:00:00 +0300
Message-Id: <20241016140000.783905-5-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016140000.783905-1-mathias.nyman@linux.intel.com>
References: <20241016140000.783905-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.h |  1 +
 drivers/usb/host/xhci-dbgtty.c | 55 ++++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 5 deletions(-)

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
-- 
2.25.1


