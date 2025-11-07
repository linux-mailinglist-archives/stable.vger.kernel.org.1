Return-Path: <stable+bounces-192745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0FBC40E38
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53C2D4EE2F0
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27542F6582;
	Fri,  7 Nov 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ljrXlbMQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EBB2E54A3;
	Fri,  7 Nov 2025 16:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532923; cv=none; b=NIPBIKqrp4zfJP2IpPTzOGznP5R2GrFfRBP6hpiazeMCp7Y8CqI9SRCVAx7aI5v/H741h4wG/2nbVZw2VS5BCuO7xA0f0M5Jfl0T09o9kDuksBl9pWf+bseYLQc00d1aJ4XptjmEKeDTcTpunYGOxdCz26oN/x0IZLQ3YKCUNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532923; c=relaxed/simple;
	bh=Cb76fC+lUWQ32ALQ6e5p7MwF510eM9XnO8OYd2QZApA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzTP0/XlKdnVk44y7xk1UqyBYqI4vtnXEQoAnqoL6KwuLkgg73SrbmBXHRevjiyxzZlsHSeEaG8/dqftPgmCA9/7B18xiaZvB4e1YIBEj77MD2O3UGdDD+cQw+SqxYBQPfC5aSlQmWecPD7a64aijx41qjsZMolROSxQgFCjKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ljrXlbMQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762532920; x=1794068920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cb76fC+lUWQ32ALQ6e5p7MwF510eM9XnO8OYd2QZApA=;
  b=ljrXlbMQ72w8gyCifzjKOfY54CRGP/EqzaILkIJdnarqi/ITmYw2XulM
   5P+ciMErUILi3j6pRZRUhDSoIG3mWcGZrPvUZq/u0Hg/EzP+xuN0pcWok
   5YCOehHpJu6cCXJDHaUkXZIpWAZuL6XhJr8qkGY8JmMS5aa0+vrQqm+aS
   Y1DoRcsRinPJAJvY3T/r48VYVMrad/crwdVoom+l+pOeBGUXtYEM6WvuA
   JvDXXsdmMxRNUkmfmY051FjjjYZ8g3960QHHUOAYtSrIGvBaag/AT/8Mu
   2Btyw0GMuyU+xBrj2bgaghm6+SyjD8Cqrm30aiXi2Bpqp7MFdgGz5HW7g
   A==;
X-CSE-ConnectionGUID: jKp0RP09SCOIQOvoi8RmTA==
X-CSE-MsgGUID: xWUkiBioRRO67Zvv3I8ojw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="74979458"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="74979458"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:28:40 -0800
X-CSE-ConnectionGUID: 0jmfr3PlRwi/HoCwz7B0hg==
X-CSE-MsgGUID: z4ZytBr5RriuG/8mKv1IIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187328936"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.245.61])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:28:38 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
Subject: [PATCH 2/3] xhci: dbgtty: Fix data corruption when transmitting data form DbC to host
Date: Fri,  7 Nov 2025 18:28:17 +0200
Message-ID: <20251107162819.1362579-3-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107162819.1362579-1-mathias.nyman@linux.intel.com>
References: <20251107162819.1362579-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Data read from a DbC device may be corrupted due to a race between
ongoing write and write request completion handler both queuing new
transfer blocks (TRBs) if there are remining data in the kfifo.

TRBs may be in incorrct order compared to the data in the kfifo.

Driver fails to keep lock between reading data from kfifo into a
dbc request buffer, and queuing the request to the transfer ring.

This allows completed request to re-queue itself in the middle of
an ongoing transfer loop, forcing itself between a kfifo read and
request TRB write of another request

cpu0					cpu1 (re-queue completed req2)

lock(port_lock)
dbc_start_tx()
kfifo_out(fifo, req1->buffer)
unlock(port_lock)
					lock(port_lock)
					dbc_write_complete(req2)
					dbc_start_tx()
      					kfifo_out(fifo, req2->buffer)
					unlock(port_lock)
					lock(port_lock)
					req2->trb = ring->enqueue;
					ring->enqueue++
					unlock(port_lock)
lock(port_lock)
req1->trb = ring->enqueue;
ring->enqueue++
unlock(port_lock)

In the above scenario a kfifo containing "12345678" would read "1234" to
req1 and "5678" to req2, but req2 is queued before req1 leading to
data being transmitted as "56781234"

Solve this by adding a flag that prevents starting a new tx if we
are already mid dbc_start_tx() during the unlocked part.

The already running dbc_do_start_tx() will make sure the newly completed
request gets re-queued as it is added to the request write_pool while
holding the lock.

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.h |  1 +
 drivers/usb/host/xhci-dbgtty.c | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 47ac72c2286d..5426c971d2d3 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -114,6 +114,7 @@ struct dbc_port {
 	unsigned int			tx_boundary;
 
 	bool				registered;
+	bool				tx_running;
 };
 
 struct dbc_driver {
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d894081d8d15..b7f95565524d 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -47,7 +47,7 @@ dbc_kfifo_to_req(struct dbc_port *port, char *packet)
 	return len;
 }
 
-static int dbc_start_tx(struct dbc_port *port)
+static int dbc_do_start_tx(struct dbc_port *port)
 	__releases(&port->port_lock)
 	__acquires(&port->port_lock)
 {
@@ -57,6 +57,8 @@ static int dbc_start_tx(struct dbc_port *port)
 	bool			do_tty_wake = false;
 	struct list_head	*pool = &port->write_pool;
 
+	port->tx_running = true;
+
 	while (!list_empty(pool)) {
 		req = list_entry(pool->next, struct dbc_request, list_pool);
 		len = dbc_kfifo_to_req(port, req->buf);
@@ -77,12 +79,25 @@ static int dbc_start_tx(struct dbc_port *port)
 		}
 	}
 
+	port->tx_running = false;
+
 	if (do_tty_wake && port->port.tty)
 		tty_wakeup(port->port.tty);
 
 	return status;
 }
 
+/* must be called with port->port_lock held */
+static int dbc_start_tx(struct dbc_port *port)
+{
+	lockdep_assert_held(&port->port_lock);
+
+	if (port->tx_running)
+		return -EBUSY;
+
+	return dbc_do_start_tx(port);
+}
+
 static void dbc_start_rx(struct dbc_port *port)
 	__releases(&port->port_lock)
 	__acquires(&port->port_lock)
-- 
2.43.0


