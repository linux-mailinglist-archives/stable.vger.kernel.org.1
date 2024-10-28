Return-Path: <stable+bounces-88414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E20F9B25E2
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7191F2199E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2D18E36C;
	Mon, 28 Oct 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I0P0TGuE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9E15B10D;
	Mon, 28 Oct 2024 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097277; cv=none; b=J7QCLRfx8BwqqpE/V/Np8aFSQ71p7HOV4xPkW6LR7EfVTOZaEg0ZtLYlprA6CnkjFH92JacVOInCxSg4gb4Rz4p4C1aeA+P9YaIxGCjiV/YLh3fk0GxaKF8/CidjBP+LPEdNlj8Zb5Qlbi5OeHinpILfB3tV+meV5eOHnxVGxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097277; c=relaxed/simple;
	bh=RcI/SI6RCnEvROeyM0L/js1hX60VMvFAvEpVmx1OC8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVMzMKIZHQ+AaFlSghL0iddKRP5O7G1KZnOaBMdTJUQFRx84s9WGUb1zYRdNapW0NrHkby05lVrkuO6N340X1ufxi1Fw1ezPQ3FqVdClVCPY7anaxSJZBWR6RH21+vvYzBLw7MDTGUiyWvk9HHqLhzGc3CoxYzLMXLcXOYfktvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I0P0TGuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0803EC4CEC7;
	Mon, 28 Oct 2024 06:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097277;
	bh=RcI/SI6RCnEvROeyM0L/js1hX60VMvFAvEpVmx1OC8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0P0TGuEdWK4i4PxdArcz1LKKphBDEumDFM2vOjU73aCjSfr85hsjFwvqM2TvagUf
	 rawDzo/BI02H6gM07VwMq52QMB7l+MFVlEAttZ72N0YE9Q5OSiUYf8XlNY2s/bnA4E
	 0E0ZR3ye+JW9HzGAauZN0trpddNRnkp5obytyetU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-usb@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 059/137] xhci: dbgtty: remove kfifo_out() wrapper
Date: Mon, 28 Oct 2024 07:24:56 +0100
Message-ID: <20241028062300.380087554@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
References: <20241028062258.708872330@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

[ Upstream commit 2b217514436744dd98c4d9fa48d60610f9f67d61 ]

There is no need to check against kfifo_len() before kfifo_out(). Just
ask the latter for data and it tells how much it retrieved. Or returns 0
in case there are no more.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Link: https://lore.kernel.org/r/20240808103549.429349-5-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 30c9ae5ece8e ("xhci: dbc: honor usb transfer size boundaries.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-dbgtty.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index d3acc0829ee5a..43d3c95eb8ddb 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -24,19 +24,6 @@ static inline struct dbc_port *dbc_to_port(struct xhci_dbc *dbc)
 	return dbc->priv;
 }
 
-static unsigned int
-dbc_send_packet(struct dbc_port *port, char *packet, unsigned int size)
-{
-	unsigned int		len;
-
-	len = kfifo_len(&port->write_fifo);
-	if (len < size)
-		size = len;
-	if (size != 0)
-		size = kfifo_out(&port->write_fifo, packet, size);
-	return size;
-}
-
 static int dbc_start_tx(struct dbc_port *port)
 	__releases(&port->port_lock)
 	__acquires(&port->port_lock)
@@ -49,7 +36,7 @@ static int dbc_start_tx(struct dbc_port *port)
 
 	while (!list_empty(pool)) {
 		req = list_entry(pool->next, struct dbc_request, list_pool);
-		len = dbc_send_packet(port, req->buf, DBC_MAX_PACKET);
+		len = kfifo_out(&port->write_fifo, req->buf, DBC_MAX_PACKET);
 		if (len == 0)
 			break;
 		do_tty_wake = true;
-- 
2.43.0




