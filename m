Return-Path: <stable+bounces-48056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA08FCBCC
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18E81F24D85
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68090188CDC;
	Wed,  5 Jun 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEqjDiQ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209581ACAED;
	Wed,  5 Jun 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588370; cv=none; b=DJ9QNGa31vrwewA2iGjD9zJF5bF9n8n0TaZ/AqzbGqJ3eYHc9BmgJEeG6F7EJPLArvPtG5ND7Q+48S7BuywwM25IiOiTkL+8ZWaBWU4Eg5++DE6dKPmMAB3gJRHzK/mcJCzHWCX4nOJHNuZSJnL3UgEGXc+uq0A7bHaRMc6VtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588370; c=relaxed/simple;
	bh=NJFTVtrYvnLF1VTPy4CYKSB9Or0i1HT1MkKZ6bHtDg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T//OTVMU8qoKmuBO+m8cH1SaP0r86GGitYxaezS2W5hVU4w9JFdGd21j+xq1SOPeGTkMdw5DGk5lY1/qeWjSZuQAPbEi5NOGFAaSFDTC/x6M5Ml9dudofrPScVc97O8qZ6GCHbt6kZZB7OskAPOGOy59B+HrzytJStivdqy4K6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEqjDiQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11471C32781;
	Wed,  5 Jun 2024 11:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588370;
	bh=NJFTVtrYvnLF1VTPy4CYKSB9Or0i1HT1MkKZ6bHtDg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEqjDiQ9IJkYAOXQzb/GUyteQJ4+jFM0zhZ059+8m+GoegxSgUO5Z0xjdYTxteWpx
	 z52CPQhsb6uAG8+I2r4P8Sqg8/pZskdutgvVLHJ8Rv34Tthj/6CUpsHQZ4OPncz3fD
	 kppVFwmGWAhG2qJsIz37WWYKwJZEtX9pVsUykKIi27lCxO3lb+1/W2LPEgiJX/3FPP
	 OsTIYAqta+2m+4PmWzm+eu1wJwkPjkVBCjbhRUKtgruXOz9rRImLT5MEbCRs+OsFzl
	 lAOn7uwZv9hRvrz5NaW8fPBvXtLOzcAbSPY32KBGPKPEEjYLtUyfTsR4MCcOhZO+MS
	 wnPsklbPC3Vug==
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
	christophe.jaillet@wanadoo.fr,
	tglx@linutronix.de,
	rickaran@axis.com,
	martin.fuzzey@flowbird.group,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 11/20] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed,  5 Jun 2024 07:51:54 -0400
Message-ID: <20240605115225.2963242-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index c77831e91ec20..a1476e47c6aab 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
@@ -2009,7 +2010,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned long flags;
-	unsigned int ucr1;
+	unsigned int ucr1, usr2;
 	int locked = 1;
 
 	if (sport->port.sysrq)
@@ -2040,8 +2041,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
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


