Return-Path: <stable+bounces-110154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2D0A190C4
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBD9164121
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7330E189902;
	Wed, 22 Jan 2025 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="HmfKgzt8"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18A211A2B;
	Wed, 22 Jan 2025 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545981; cv=none; b=OVH33wu+EzsjW9gg+tKWevVxD61mvcnSZPr+kOaZAzHfKMSLSdv2HHDIAavXePTnWte/hNDd4jvwbY5d42tix/UDLGzSr3hzrKbUSy9cOJa3cxzgvSPku0V9Z8CSA2wsfaGHe8cOtGo+piTcWn1p89mL17R6l5WFi4aK2KPFp0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545981; c=relaxed/simple;
	bh=+dVhSQUvLzcvSSYXfU/4UkSbcl4EP9qLyCUDk1YeA8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3ikXjh0sEnColZcUPn6ekQSzBoNz3BqBf4+YdealxCbyUruEERCiS/S5zumCxH5l1HQio97etlL2l9VQD5QlEY1e+BH1RA23mYTnr4IznIgQGlR+iIzh04fJ1NIivuVXwZVifj24eZysd8pI0Rbh3RlorRV/fOCONOlHO8Ob88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=HmfKgzt8; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1737545967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uvXoMozXSUq7ECwRvOIW2A8tWpZ7jbIGzymPHm6Jvjg=;
	b=HmfKgzt8BUKnKCByrmvAc7jYejozQtTKXhFPQO2ZlaDjE7uqLoeulo4MU1o6x/B6pG0CUS
	iLq8RCru4oNQnLHQ1cGUDLn3n/l6wkTF2itevxnVifj6jgvyEnrF9PwiLvYWP2NsJWAJpW
	lxFrZti5R9Fa4NOmuXh1UQE7g+ma0cs=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Esben Haabendal <esben@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 5.10] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed, 22 Jan 2025 14:39:26 +0300
Message-ID: <20250122113927.301596-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Esben Haabendal <esben@geanix.com>

commit e533e4c62e9993e62e947ae9bbec34e4c7ae81c2 upstream. 

By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
deadlock.

In case of the timeout, there is not much we can do, so we simply ignore
the transmitter state and optimistically try to continue.

Signed-off-by: Esben Haabendal <esben@geanix.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/r/919647898c337a46604edcabaf13d42d80c0915d.1712837613.git.esben@geanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Denis: minor fix to resolve merge conflict.]                                           
Signed-off-by: Denis Arefev <arefev@swemel.ru>                                    
---
Backport fix for CVE-2024-40967
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-40967
---
 drivers/tty/serial/imx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 6e49928bb864..5abf6685fe3c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
@@ -2006,8 +2007,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
-	unsigned int ucr1;
-	unsigned long flags = 0;
+	unsigned long flags;
+	unsigned int ucr1, usr2;
 	int locked = 1;
 
 	if (sport->port.sysrq)
@@ -2038,8 +2039,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore UCR1/2/3
 	 */
-	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC));
-
+	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
+				 0, USEC_PER_SEC, false, sport, USR2);
 	imx_uart_ucrs_restore(sport, &old_ucr);
 
 	if (locked)
-- 
2.43.0


