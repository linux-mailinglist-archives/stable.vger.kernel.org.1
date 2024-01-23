Return-Path: <stable+bounces-15355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C54A0838594
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6218B2E093
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDF77F03;
	Tue, 23 Jan 2024 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XHNKgSH1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC877F00;
	Tue, 23 Jan 2024 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975522; cv=none; b=n27arF+rgDjAFA9K/+QUt4t73dnlqwNytguxpT5eKo5n17465V7Q7TcxHWyCtnAKJ9rYfZGLDzADiI3g+65x1ErkmSvVhcwlSRUYUVA8cV1P93HIQSXVeIh3v6+Z15XRl4O12ByyUNIWhqexLwA/rOlXdp57P4pW11B/CdaScZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975522; c=relaxed/simple;
	bh=btxgK08gQgro3Ges+RVe7NdhR/bwjlOaHYvnH40e9PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piF25ULtGyxcjlf+e7mzTSj9vU+aLFiQaHLyBcE+FJreNO4uLrCFu2lUJx/BvJNdVatbyZ0irSAyZ1VzqKZSpUsNFhl7gSpbWqDCiAUp5eZ1tAKmjHq3h0J3T3KHBvf5yqVd4AhJnaZ+gaMBVhHnxpMmiOr286F41RwFwY3+KRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XHNKgSH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B45C43399;
	Tue, 23 Jan 2024 02:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975522;
	bh=btxgK08gQgro3Ges+RVe7NdhR/bwjlOaHYvnH40e9PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHNKgSH1h1v2crXRtuL69ERtCXZQ5Y80y7lzhG9afPJAVakaGJ4EoLRrjvRZq5I1G
	 8pofDBc6Z1eZUyURwhRCQr0c46OQtGNYQw5YD8iXpoqQmLg5uBESPS77GWkfKhb+BD
	 FU+j4toQVLhNc/iHS1M+bon/BmcQEllRbqaAYwr0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Geurts <paul_geurts@live.nl>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Eberhard Stoll <eberhard.stoll@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 474/583] serial: imx: fix tx statemachine deadlock
Date: Mon, 22 Jan 2024 15:58:45 -0800
Message-ID: <20240122235826.490312506@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

From: Paul Geurts <paul_geurts@live.nl>

[ Upstream commit 78d60dae9a0c9f09aa3d6477c94047df2fe6f7b0 ]

When using the serial port as RS485 port, the tx statemachine is used to
control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
TTY port is closed in the middle of a transmission (for instance during
userland application crash), imx_uart_shutdown disables the interface
and disables the Transmission Complete interrupt. afer that,
imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
by the TC interrupt. This interrupt is disabled and therefore the tx
statemachine never transitions out of SEND. The statemachine is in
deadlock now, and the TX_EN remains low, making the interface useless.

imx_uart_stop_tx now checks for incomplete transmission AND whether TC
interrupts are enabled before bailing to be retriggered. This makes sure
the state machine handling is reached, and is properly set to
WAIT_AFTER_SEND.

Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
Signed-off-by: Paul Geurts <paul_geurts@live.nl>
Tested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Tested-by: Eberhard Stoll <eberhard.stoll@gmx.de>
Link: https://lore.kernel.org/r/AM0PR09MB26758F651BC1B742EB45775995B8A@AM0PR09MB2675.eurprd09.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 2e85c77e7c0d..c084ac3bb441 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -421,13 +421,13 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	ucr1 = imx_uart_readl(sport, UCR1);
 	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
 
+	ucr4 = imx_uart_readl(sport, UCR4);
 	usr2 = imx_uart_readl(sport, USR2);
-	if (!(usr2 & USR2_TXDC)) {
+	if ((!(usr2 & USR2_TXDC)) && (ucr4 & UCR4_TCEN)) {
 		/* The shifter is still busy, so retry once TC triggers */
 		return;
 	}
 
-	ucr4 = imx_uart_readl(sport, UCR4);
 	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
-- 
2.43.0




