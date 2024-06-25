Return-Path: <stable+bounces-55496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455C49163DD
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CBE1C225AC
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A51494CF;
	Tue, 25 Jun 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YHJNMGYu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF90146015;
	Tue, 25 Jun 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309075; cv=none; b=FQWR+bcdWEflOlaIC79T0l1iRalLuLQl7pfdvA7JwO6Rmg8zzV24yenHb7EgnoVl+dePitLGT7zAsoCcW4fhl1pzz+yU0NVNo6PY+WTeShU1b8FJr41+FO3Z/spGt5YWHJApkmcrOzYfaUpUo5LF1TFyUt84StWm+kTQ4heNjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309075; c=relaxed/simple;
	bh=xNuHNOOmjxsFtQ7jLMFVbHE00E8rtPy3ijCRUAohiIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpM6q5eI2WPiCDJeHyXspSne+1d2hX+bc5ai0lX+GDLlN18IZngLTyMFuW+rdk4csimKLH3OCRGzbCMQIqYd8miua9fnUuhiiylNP5kTmIIBf4WVpMtZqffm5PcAgiXaU3bcjnrVeMhR31Bqy1mUOFo+7xcOMYs6FFBouRuxA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YHJNMGYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBFFC32781;
	Tue, 25 Jun 2024 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309074;
	bh=xNuHNOOmjxsFtQ7jLMFVbHE00E8rtPy3ijCRUAohiIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YHJNMGYu915CyY2yuW5xBVIOJczU94UGqbaeaYyhmQiEfMW+05tQQkcrZIp1hty3n
	 h9pb/plqbILHtjDJ0vcHkdB5/+EpKh9t0nhj+lKo/tA2WrQxLqeHWHbKjRCDlRe24p
	 cIF6UQUsoF/FP+4Qz3ldAmY4oQ/zqYcwIu69EocU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Esben Haabendal <esben@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 055/192] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Tue, 25 Jun 2024 11:32:07 +0200
Message-ID: <20240625085539.283227461@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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




