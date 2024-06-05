Return-Path: <stable+bounces-48074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBB38FCC1A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B45A287060
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246B1B150D;
	Wed,  5 Jun 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOMt5wew"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0101B1505;
	Wed,  5 Jun 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588431; cv=none; b=Wyug/VjRiUVeHXSyz5kY0B5PzoALjklOQB2N03hehnRasVpmOSWmizuTBBHHaHgxNakZ/7RNxA8iynxRNzw73Czfv3T/sNBpq6ETnsapRoCa9M55pRkAII0LiYQ67tnL7e5DaUN60prexx32fjWF9ghcorgP414SPiNhPclvjnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588431; c=relaxed/simple;
	bh=sUkdikgKfLk5y9/mJjMHHqkh3/heA3hP590SNrGrPxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL0SHy6Mbd8wNeTeG0JtA8oJNtfGentIdNeNFaYmLAurF/l9sEg7jQfQhP312AS60kAmAs0RkhZ+fR0SzRrKuLDpN3RIhs0vfbm22fht9VWQi8JI+vATp8AysLADNcuHuvtzNoq++tnptu/5s6wlxutEB2OCKYmGooCB7Fyyxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOMt5wew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB72C3277B;
	Wed,  5 Jun 2024 11:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588431;
	bh=sUkdikgKfLk5y9/mJjMHHqkh3/heA3hP590SNrGrPxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NOMt5wewDqBowuaONGKH8dS6rec9aJDfORN3K2TPPpvjUul4a5+g4z77pWtTO98sC
	 T43HjrkIqM+1sCorOP13noJ7mRNaTCOPKjdL+y8WrOa0IeQGUhYtMtWeIKJk2VoEGa
	 erG1LepzhI2pXzNLIwslLlMdlNysr5+VV33WwBg5g+5fHSWxUytDxeVZXiGSdRsEFg
	 bmlAM7WloedcWD6k8op7OqU1lYLQ4H1ilWWbveStKsshpH5YQuJMVXCKON1r9wlJRp
	 Ou1tiJY6foY4os5fp/7RfEPk1MWo79WUBGgayusj0y/xr4fZFbn7i1bH18KNLdXjg4
	 wt9cU21HWu3sA==
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
	cniedermaier@dh-electronics.com,
	l.sanfilippo@kunbus.com,
	ilpo.jarvinen@linux.intel.com,
	rickaran@axis.com,
	matthias.schiffer@ew.tq-group.com,
	tglx@linutronix.de,
	martin.fuzzey@flowbird.group,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 08/12] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed,  5 Jun 2024 07:53:13 -0400
Message-ID: <20240605115334.2963803-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115334.2963803-1-sashal@kernel.org>
References: <20240605115334.2963803-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
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
index 573bf7e9b7978..b20abaa9ef150 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
@@ -2028,7 +2029,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned long flags;
-	unsigned int ucr1;
+	unsigned int ucr1, usr2;
 	int locked = 1;
 
 	if (sport->port.sysrq)
@@ -2059,8 +2060,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
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


