Return-Path: <stable+bounces-48086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733108FCC32
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F9228A0A2
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4B1B3746;
	Wed,  5 Jun 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPo9/HEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA991B3732;
	Wed,  5 Jun 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588471; cv=none; b=DmUVK9HqV7wShPdEgzQqeeH+jPdgYO4+uI3WQuB1D8nhIiMcLyDer6u8RINosDxPgcAisC2znxS9TLeemOTds3U29Wz5RAGMRtXYiqPKRMEPTVXHR3MVHZYdk470oEw78m3U6bGVJ1/9SxYkieuUfV/isN97MJSg7JsptE6CwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588471; c=relaxed/simple;
	bh=mCP1odBp/E+seo1PF1EwA6/lK01Byu8F2UblPqk/58A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO/A2kef2vNYh26yWZ1IxX/U3CyvM7IrySmPSxIrdvZBb59GdpjD2auX+loJ8OI8bvD4SnUrcHJ0PkWovgKfmZp+Bwpwt++NufXQOf8EodbgXVjM2luXgatqYyTQYQKEgwI6Z5KDZFbEE96bhaIs7Ce30vazUNEjb4yUVc7PkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPo9/HEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CA7C3277B;
	Wed,  5 Jun 2024 11:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588471;
	bh=mCP1odBp/E+seo1PF1EwA6/lK01Byu8F2UblPqk/58A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPo9/HEj+ry7Umr7jE5I/yh7iRSPWHjHppcMFFDU001EuuE6tT54piyHEP5FtzxiZ
	 rBf/eXOpbHR7VLzuC2DLu/st34UWCs80qoEp9hxKyOQEag2ly9bhQNPqMtPyEeYktK
	 ul2+CTWAmzios4JCwfbrncdfsjCibpcmp+wdC4NiJjnkLXZ1s5Ljtk4GE/ikuudhHq
	 5StouwHMnh/oWuCKXdDvMMV6F514kxQfIMInr1Rkt2u9Vv5VmSN/QP04BGK90wfvM8
	 8xTZycELbCG1mgNaVUN+cCZ9q5CYaP6DHBpMXkP0t0AuE772NsGFFmgOkvMSadWWXG
	 85EaAutf5o6rg==
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
	cniedermaier@dh-electronics.com,
	l.sanfilippo@kunbus.com,
	frank.li@vivo.com,
	tglx@linutronix.de,
	rickaran@axis.com,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 7/9] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Wed,  5 Jun 2024 07:54:05 -0400
Message-ID: <20240605115415.2964165-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115415.2964165-1-sashal@kernel.org>
References: <20240605115415.2964165-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
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
index 0587beaaea08d..b9ef426d5aae3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
@@ -2024,7 +2025,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned long flags;
-	unsigned int ucr1;
+	unsigned int ucr1, usr2;
 	int locked = 1;
 
 	if (sport->port.sysrq)
@@ -2055,8 +2056,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
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


