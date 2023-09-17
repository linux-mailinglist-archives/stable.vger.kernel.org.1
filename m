Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECBB7A384C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjIQTdy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239723AbjIQTdr (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:33:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38AFD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:33:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83EBC433C8;
        Sun, 17 Sep 2023 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979222;
        bh=UFCBPIShBwDpwwYjbRE4VeiYtAHClrvk4hhZgLL7bjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eq3/hDEMhJ5wPvbmt2U3+Sa72RFf1yLL5eg/y+3AFOVouMIPMnad16n0oRZ1cVL6J
         /YTPH/0saEwqjpJF7xfkQZvmUYneZ6zPztLxMETJz/J0aRbMDGcWabAYsleMJ1j0I1
         oIkMJZ+U5oso2B2CtjTcrZV8ByYZeNtR+r02QRco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 223/406] serial: sprd: Assign sprd_port after initialized to avoid wrong access
Date:   Sun, 17 Sep 2023 21:11:17 +0200
Message-ID: <20230917191107.066415287@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

[ Upstream commit f9608f1887568b728839d006024585ab02ef29e5 ]

The global pointer 'sprd_port' may not zero when sprd_probe returns
failure, that is a risk for sprd_port to be accessed afterward, and
may lead to unexpected errors.

For example:

There are two UART ports, UART1 is used for console and configured in
kernel command line, i.e. "console=";

The UART1 probe failed and the memory allocated to sprd_port[1] was
released, but sprd_port[1] was not set to NULL;

In UART2 probe, the same virtual address was allocated to sprd_port[2],
and UART2 probe process finally will go into sprd_console_setup() to
register UART1 as console since it is configured as preferred console
(filled to console_cmdline[]), but the console parameters (sprd_port[1])
belong to UART2.

So move the sprd_port[] assignment to where the port already initialized
can avoid the above issue.

Fixes: b7396a38fb28 ("tty/serial: Add Spreadtrum sc9836-uart driver support")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Link: https://lore.kernel.org/r/20230725064053.235448-1-chunyan.zhang@unisoc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 9a7ae6384edfa..144c03ca3366a 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1133,7 +1133,7 @@ static bool sprd_uart_is_console(struct uart_port *uport)
 static int sprd_clk_init(struct uart_port *uport)
 {
 	struct clk *clk_uart, *clk_parent;
-	struct sprd_uart_port *u = sprd_port[uport->line];
+	struct sprd_uart_port *u = container_of(uport, struct sprd_uart_port, port);
 
 	clk_uart = devm_clk_get(uport->dev, "uart");
 	if (IS_ERR(clk_uart)) {
@@ -1176,22 +1176,22 @@ static int sprd_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct uart_port *up;
+	struct sprd_uart_port *sport;
 	int irq;
 	int index;
 	int ret;
 
 	index = of_alias_get_id(pdev->dev.of_node, "serial");
-	if (index < 0 || index >= ARRAY_SIZE(sprd_port)) {
+	if (index < 0 || index >= UART_NR_MAX) {
 		dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
 		return -EINVAL;
 	}
 
-	sprd_port[index] = devm_kzalloc(&pdev->dev, sizeof(*sprd_port[index]),
-					GFP_KERNEL);
-	if (!sprd_port[index])
+	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
+	if (!sport)
 		return -ENOMEM;
 
-	up = &sprd_port[index]->port;
+	up = &sport->port;
 	up->dev = &pdev->dev;
 	up->line = index;
 	up->type = PORT_SPRD;
@@ -1222,7 +1222,7 @@ static int sprd_probe(struct platform_device *pdev)
 	 * Allocate one dma buffer to prepare for receive transfer, in case
 	 * memory allocation failure at runtime.
 	 */
-	ret = sprd_rx_alloc_buf(sprd_port[index]);
+	ret = sprd_rx_alloc_buf(sport);
 	if (ret)
 		return ret;
 
@@ -1233,14 +1233,23 @@ static int sprd_probe(struct platform_device *pdev)
 			return ret;
 		}
 	}
+
 	sprd_ports_num++;
+	sprd_port[index] = sport;
 
 	ret = uart_add_one_port(&sprd_uart_driver, up);
 	if (ret)
-		sprd_remove(pdev);
+		goto clean_port;
 
 	platform_set_drvdata(pdev, up);
 
+	return 0;
+
+clean_port:
+	sprd_port[index] = NULL;
+	if (--sprd_ports_num == 0)
+		uart_unregister_driver(&sprd_uart_driver);
+	sprd_rx_free_buf(sport);
 	return ret;
 }
 
-- 
2.40.1



