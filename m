Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7A7C9AA8
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJOSP7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 14:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJOSP6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 14:15:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7244FDA
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 11:15:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D3BC433C8;
        Sun, 15 Oct 2023 18:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697393757;
        bh=8eO8wm0D6A2dZfK6apb3dfTKmWq3GrvzUFPGDbjaIRM=;
        h=Subject:To:Cc:From:Date:From;
        b=jxSzfcWcXOmk7xgPavzb21R+nuT4LdYUX0TrXVtKcpgNTU9YrYaM8vrPyzJc3XZNH
         UDyPfL1RbHiiF92YnN1ztIBmqVOxgN7T5QEvCKA6eKVVYKI61hOOpaKbghkonkCGuE
         mHXWpSCplA9eJ2IFrDXlLA5ooj2CyW6qSqZfLUig=
Subject: FAILED: patch "[PATCH] serial: 8250_omap: Fix errors with no_console_suspend" failed to apply to 6.1-stable tree
To:     tony@atomide.com, d-gole@ti.com, gregkh@linuxfoundation.org,
        stable@kernel.org, thomas.richard@bootlin.com, u-kumar1@ti.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 15 Oct 2023 20:15:52 +0200
Message-ID: <2023101552-trifle-ashy-52c1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 560706eff7c8e5621b0d63afe0866e0e1906e87e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101552-trifle-ashy-52c1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 560706eff7c8e5621b0d63afe0866e0e1906e87e Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 26 Sep 2023 09:13:17 +0300
Subject: [PATCH] serial: 8250_omap: Fix errors with no_console_suspend

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

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 26dd089d8e82..ca972fd37725 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1617,7 +1617,7 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
-	int err;
+	int err = 0;
 
 	serial8250_suspend_port(priv->line);
 
@@ -1627,7 +1627,8 @@ static int omap8250_suspend(struct device *dev)
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	err = pm_runtime_force_suspend(dev);
+	if (uart_console(&up->port) && console_suspend_enabled)
+		err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
 
 	return err;
@@ -1636,11 +1637,15 @@ static int omap8250_suspend(struct device *dev)
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
@@ -1717,16 +1722,6 @@ static int omap8250_runtime_suspend(struct device *dev)
 
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

