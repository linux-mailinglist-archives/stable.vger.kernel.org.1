Return-Path: <stable+bounces-2476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B237F8454
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9FF2881D9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468537170;
	Fri, 24 Nov 2023 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qIuT9aAA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C028DBB;
	Fri, 24 Nov 2023 19:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF54C433C8;
	Fri, 24 Nov 2023 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853977;
	bh=zw28BlohxHWuk7qoxS1AlRLObfoaY6tkAUImzuk6pNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qIuT9aAAalE0soXPutJ+94KoCBrOJUwgrEnj08ez+02Ibm0lBGAZoJg5gszlfl+H9
	 iKYgfjAVsHzzn3hCNjO6c6Nz2w2CkTHS38izdr4Mpswgp4oOuwi5uQk3bnvJaCte0X
	 1S9CZduXsv4FZF5w+M5i3BMsRjVhevqTYwmOCMOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Hilman <khilman@baylibre.com>,
	Neil Armstrong <narmstrong@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 107/159] tty: serial: meson: retrieve port FIFO size from DT
Date: Fri, 24 Nov 2023 17:55:24 +0000
Message-ID: <20231124171946.340888863@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
References: <20231124171941.909624388@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 27d44e05d7b85d9d4cfe0a3c0663ea49752ece93 ]

Now the DT bindings has a property to get the FIFO size for a particular port,
retrieve it and use to setup the FIFO interrupts threshold.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lore.kernel.org/r/20210518075833.3736038-3-narmstrong@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2a1d728f20ed ("tty: serial: meson: fix hard LOCKUP on crtscts mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/meson_uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 6a74a31231ebf..7563fd215d816 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -663,6 +663,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 {
 	struct resource *res_mem, *res_irq;
 	struct uart_port *port;
+	u32 fifosize = 64; /* Default is 64, 128 for EE UART_0 */
 	int ret = 0;
 
 	if (pdev->dev.of_node)
@@ -690,6 +691,8 @@ static int meson_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
+	of_property_read_u32(pdev->dev.of_node, "fifo-size", &fifosize);
+
 	if (meson_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
 		return -EBUSY;
@@ -719,7 +722,7 @@ static int meson_uart_probe(struct platform_device *pdev)
 	port->type = PORT_MESON;
 	port->x_char = 0;
 	port->ops = &meson_uart_ops;
-	port->fifosize = 64;
+	port->fifosize = fifosize;
 
 	meson_ports[pdev->id] = port;
 	platform_set_drvdata(pdev, port);
-- 
2.42.0




