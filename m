Return-Path: <stable+bounces-48006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA88FCB0B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A951F24578
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C74188CC5;
	Wed,  5 Jun 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTBACd71"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18171188CB7;
	Wed,  5 Jun 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588196; cv=none; b=BX/blZwE9eflCQhluIJx3I9M4lnAu7IR7YC0qznNcqtR5O5jbfFzs0NVRFRFNrYJg0XF7/eXh5qcKb9gBx8/RitIAc+D+aIIxOklVZTxOeBspjd8f4Vl5ivQkEgHgOpKg3Gbr69rBIQgorcAXzg82pO5bWDay2xmXiUmbp0UIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588196; c=relaxed/simple;
	bh=VDEC8kLvr3XTPKhCnFg4+8QeXod4zGth0hLIrG3ER0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKlO75L41Z2lZtPnJ7cmqmCdkbuoy9XlaeChcsStqqMrGlsyC3nGCNAYJKNunuLSxygoZ3RXlsoqTOu4lzBaUFQTgy7hwhJ12ROEC23A6v9qfc3QiDIFGm38RAOAW+ZlhBJo3y/VbveNQdqfcinkT2wmICwAisrMnVWUeiD55qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTBACd71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEA1C32781;
	Wed,  5 Jun 2024 11:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588195;
	bh=VDEC8kLvr3XTPKhCnFg4+8QeXod4zGth0hLIrG3ER0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTBACd71Ma//AdFE+/FDWc2WFdHsi8WVuXJcrLT78fnE9wUaOuM4m3HD56Sk1uBPu
	 78+jtyLDUyXgmE08bTS2ciVvj9VN9qbZsi0dDc72g6Ro+h7amtQn9ShvOl660CkqhU
	 hpuCdOSU0Osh6tTiYBePlU74NyeJIy5OJ1MD7RIP17IVJsb8Boke7FJXhZhfQ2xHxx
	 2LCXHnv1qHlGIqx5FF2EiUbgZdqBmhPOhBx3EgfYuFV4H8CLRPYvtjC+bRpiMv0I1N
	 24wNGGNi3KW1ZeeL0r1xxIGiYX8jFs0m454L+IIE++kWstgk70uvzaUt+V0tUXr/FK
	 LwBbXk82Mdy4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	u.kleine-koenig@pengutronix.de,
	ilpo.jarvinen@linux.intel.com,
	l.sanfilippo@kunbus.com,
	cniedermaier@dh-electronics.com,
	tglx@linutronix.de,
	matthias.schiffer@ew.tq-group.com,
	rickaran@axis.com,
	martin.fuzzey@flowbird.group,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.9 13/28] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed,  5 Jun 2024 07:48:42 -0400
Message-ID: <20240605114927.2961639-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Esben Haabendal <esben@geanix.com>

[ Upstream commit e533e4c62e9993e62e947ae9bbec34e4c7ae81c2 ]

By waiting at most 1 second for USR2_TXDC to be set, we avoid a potential
deadlock.

In case of the timeout, there is not much we can do, so we simply ignore
the transmitter state and optimistically try to continue.

Signed-off-by: Esben Haabendal <esben@geanix.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/r/919647898c337a46604edcabaf13d42d80c0915d.1712837613.git.esben@geanix.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index e148132506161..09c1678ddfd49 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
@@ -2010,7 +2011,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned long flags;
-	unsigned int ucr1;
+	unsigned int ucr1, usr2;
 	int locked = 1;
 
 	if (sport->port.sysrq)
@@ -2041,8 +2042,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
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


