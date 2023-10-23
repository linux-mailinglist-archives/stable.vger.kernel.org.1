Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95997D3579
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjJWLsp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjJWLsp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:48:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A3DE
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:48:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEA0C433C9;
        Mon, 23 Oct 2023 11:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061722;
        bh=6h4UbNM3Fy6URnz+b++c/G90LrZRXVyKD4ww6zA9Fxg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WkcdaBAvpsnrlHZ4fqmA3RHKwoPmrXTp/twjm4OwOEyHwKKK9gId82+s61UxXVDzI
         TAJvKdJQPyqsJXG23qamDR6Q8QuPhe7iQFo8+u4YcxsMpq8/hraFOOLspIpLkGIEIA
         jv0UrzQWZqDe2x+BgCUVW3epABWq7bfxsmBJocvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Udit Kumar <u-kumar1@ti.com>,
        Thomas Richard <thomas.richard@bootlin.com>,
        Tony Lindgren <tony@atomide.com>, Dhruva Gole <d-gole@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 142/202] serial: 8250_omap: Fix errors with no_console_suspend
Date:   Mon, 23 Oct 2023 12:57:29 +0200
Message-ID: <20231023104830.689419873@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 560706eff7c8e5621b0d63afe0866e0e1906e87e ]

We now get errors on system suspend if no_console_suspend is set as
reported by Thomas. The errors started with commit 20a41a62618d ("serial:
8250_omap: Use force_suspend and resume for system suspend").

Let's fix the issue by checking for console_suspend_enabled in the system
suspend and resume path.

Note that with this fix the checks for console_suspend_enabled in
omap8250_runtime_suspend() become useless. We now keep runtime PM usage
count for an attached kernel console starting with commit bedb404e91bb
("serial: 8250_port: Don't use power management for kernel console").

Fixes: 20a41a62618d ("serial: 8250_omap: Use force_suspend and resume for system suspend")
Cc: stable <stable@kernel.org>
Cc: Udit Kumar <u-kumar1@ti.com>
Reported-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Thomas Richard <thomas.richard@bootlin.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/r/20230926061319.15140-1-tony@atomide.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a6f0a74858eab..e7e84aa2c5f84 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1532,7 +1532,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	int err;
+	int err = 0;
 
 	serial8250_suspend_port(priv->line);
 
@@ -1542,7 +1542,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1551,11 +1552,15 @@ static int omap8250_suspend(struct device *dev)
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 	int err;
 
-	err = pm_runtime_force_resume(dev);
-	if (err)
-		return err;
+	if (uart_console(&up->port) && console_suspend_enabled) {
+		err = pm_runtime_force_resume(dev);
+		if (err)
+			return err;
+	}
+
 	serial8250_resume_port(priv->line);
 	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
 	pm_runtime_mark_last_busy(dev);
@@ -1632,16 +1637,6 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 	if (priv->line >= 0)
 		up = serial8250_get_port(priv->line);
-	/*
-	 * When using 'no_console_suspend', the console UART must not be
-	 * suspended. Since driver suspend is managed by runtime suspend,
-	 * preventing runtime suspend (by returning error) will keep device
-	 * active during suspend.
-	 */
-	if (priv->is_suspending && !console_suspend_enabled) {
-		if (up && uart_console(&up->port))
-			return -EBUSY;
-	}
 
 	if (priv->habit & UART_ERRATA_CLOCK_DISABLE) {
 		int ret;
-- 
2.40.1



