Return-Path: <stable+bounces-48033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822D8FCB75
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03021F24BFD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB591A01BE;
	Wed,  5 Jun 2024 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTZ4gbWC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710B1A01A9;
	Wed,  5 Jun 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588289; cv=none; b=ic8rVA8P5HqgJVx/FtmOzzh2IxbNCKP6SyM1JSyOR9JPEv5JRqCQ9NJKEbj/UIgULgln+/V3N+MdvvTU97Do2Nbdsx3T3Wy7gwDXjHt8iyo13TFGON98T/zoJx/MHpSOlmyOcPaiDK9PMaxs6MPO1CbDTU+wYxozUnV3uzveBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588289; c=relaxed/simple;
	bh=VDEC8kLvr3XTPKhCnFg4+8QeXod4zGth0hLIrG3ER0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5M7hD4nKrfu5uVeFW1t0DLG1qwwOjRphsUv34o3EE1P59B3KOUW4QFdZOUOH+5pi3Z9VdYnH5wA1LLKUDzgllKFM9aol5Vx2MI6FW6wO6x4l8DCmMWAUekvcuX2/sGGtRV7msidWFhVLdMMubqQM6A1nZM+L4ZuX63UNrddbO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTZ4gbWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E435BC3277B;
	Wed,  5 Jun 2024 11:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588288;
	bh=VDEC8kLvr3XTPKhCnFg4+8QeXod4zGth0hLIrG3ER0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTZ4gbWCxNN/2a5mHU5Vewwwd2nbQNRBjViEnzLa6vPRTmcWAt8GsZ1aAkXd8Ru05
	 OsPLOGYXA28moTdR4dH4E1qca5KBoESl3jBpKV5FzT0uI/Q7H9nsj7VSqfLd0Z4f/c
	 ZmWE6i62ufhizfdMORWHOLp0Xp4CMKcD94IdmrO6ih6pYeH6H7BnWppprQ5Z2Gz9oR
	 PPZW7lMtx2niHSkIwzR6YT4/lMnyM5lyAyViVwDyYdZo4zIdrUj4fCldruzRQhD04H
	 5wd16fDHHluOg/+hz2XP4wjbvqwFrb5htq27gYXq/ZlkOaNM5LOrGnFU65ib2fcCPT
	 XHjHn4Kfik+BQ==
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
	martin.fuzzey@flowbird.group,
	robh@kernel.org,
	tglx@linutronix.de,
	rickaran@axis.com,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 12/24] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed,  5 Jun 2024 07:50:22 -0400
Message-ID: <20240605115101.2962372-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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


