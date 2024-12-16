Return-Path: <stable+bounces-104396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33D59F399F
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF9A16C361
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E029209F4C;
	Mon, 16 Dec 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="iKKecr74"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495D207A25;
	Mon, 16 Dec 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376733; cv=none; b=FQYnKS8ohf4tcS4NTPN9BknWKPWAxbdkF7SW7Ql9AvPK+XgWyLUU6CYEs3wjE+/laRiAQBmvvBRy7zjIUaGMIpsp6O7Xes4jrX5kgpo1dJ13kCqoO9eEZvABTfZ8xIqg6Ng0EdrY0s/OYDnBoGxpcsXOfrTNrpj56YWxshCxilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376733; c=relaxed/simple;
	bh=wcSq+lq6vK8t+Gk6gn7qMQFP+gluOvsTGaZKHwrPdII=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=nPIIExNwtHecMTtDWTVlAQkf6sQ/RoqPExfve66YiyGQHglbCZa+nxr7UIZ35e9cSqs2tmBl1LRh7oziuAtetzL9Hah0Joc66sPJ/VLLE6r3EHND+pqRGCcoiNsvel3nKIf3PLm7WCUMgtxDAzFh2GIGWVBrbw7Vzqq2eLcnepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=iKKecr74; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=LcPZWZ7nEbQi21b+dv55qNCO8wWbzlyxf4/DH86OpqE=; b=iKKecr74hUniSIDv0sTdrxqk+N
	G6aqoOoFLdge9FJ4dr+gBceCx3Lvv1MCmxCzF8/p934b1MnexZqMlM3J4JSoUKChFDzuFSuKNNV3V
	60qIEf7FvaY3Fk2gKmfM9u3Y6bqNbUCTEfFsAzG2HhKWn5IoP56X/r2TWcSLotwb0wMg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42958 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tNGc8-0002CS-U5; Mon, 16 Dec 2024 14:18:45 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jon Ringle <jringle@gridpoint.com>
Cc: hugo@hugovil.com,
	hui.wang@canonical.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Mon, 16 Dec 2024 14:18:18 -0500
Message-Id: <20241216191818.1553557-5-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216191818.1553557-1-hugo@hugovil.com>
References: <20241216191818.1553557-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 4/4] serial: sc16is7xx: fix invalid FIFO access with special register set
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

When enabling access to the special register set, Receiver time-out and
RHR interrupts can happen. In this case, the IRQ handler will try to read
from the FIFO thru the RHR register at address 0x00, but address 0x00 is
mapped to DLL register, resulting in erroneous FIFO reading.

Call graph example:
    sc16is7xx_startup(): entry
    sc16is7xx_ms_proc(): entry
    sc16is7xx_set_termios(): entry
    sc16is7xx_set_baud(): DLH/DLL = $009C --> access special register set
    sc16is7xx_port_irq() entry            --> IIR is 0x0C
    sc16is7xx_handle_rx() entry
    sc16is7xx_fifo_read(): --> unable to access FIFO (RHR) because it is
                               mapped to DLL (LCR=LCR_CONF_MODE_A)
    sc16is7xx_set_baud(): exit --> Restore access to general register set

Fix the problem by claiming the efr_lock mutex when accessing the Special
register set.

Reworked to fix conflicts when backporting to linux-5.15.y.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240723125302.1305372-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 928c701f0c35a..3b7c238793ef4 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -537,6 +537,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
 	/* Open the LCR divisors for configuration */
+	mutex_lock(&one->efr_lock);
+
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_A);
 
@@ -549,6 +551,8 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Put LCR back to the normal mode */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
+	mutex_unlock(&one->efr_lock);
+
 	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
-- 
2.39.5


