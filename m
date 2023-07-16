Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735367553D4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjGPUX1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGPUX0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:23:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD099F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7EB60EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6657C433C7;
        Sun, 16 Jul 2023 20:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539005;
        bh=HSL/msk+JLwq7zXwr37qM52G9lNmY8bmms+Lczo0zhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgaNqgCLwpBopjsh4H7BySR7XFAnq00cQUjG4B4nXEysKWoqN7JkAXbzg14ab0Rw+
         Q+vxCI4h9Ew7qQx+Hb3M6C/9q3yZiJcvPCjNg0TQS3CIZeCulNxr2XyBBNfCBSc+NA
         Sj4IuWy6+FzsYi4t0dztPltkmYzoSW8J74TYVEAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Dhruva Gole <d-gole@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 626/800] serial: 8250_omap: Use force_suspend and resume for system suspend
Date:   Sun, 16 Jul 2023 21:47:59 +0200
Message-ID: <20230716195003.651898648@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 20a41a62618df85f3a2981008edec5cadd785e0a ]

We should not rely on autosuspend timeout for system suspend. Instead,
let's use force_suspend and force_resume functions. Otherwise the serial
port controller device may not be idled on suspend.

As we are doing a register write on suspend to configure the serial port,
we still need to runtime PM resume the port on suspend.

While at it, let's switch to pm_runtime_resume_and_get() and check for
errors returned. And let's add the missing line break before return to the
suspend function while at it.

Fixes: 09d8b2bdbc5c ("serial: 8250: omap: Provide ability to enable/disable UART as wakeup source")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-by: Dhruva Gole <d-gole@ti.com>
Message-ID: <20230614045922.4798-1-tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 0a90ddc0bdf66..b758e9b613c74 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1584,25 +1584,35 @@ static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
 	struct uart_8250_port *up = serial8250_get_port(priv->line);
+	int err;
 
 	serial8250_suspend_port(priv->line);
 
-	pm_runtime_get_sync(dev);
+	err = pm_runtime_resume_and_get(dev);
+	if (err)
+		return err;
 	if (!device_may_wakeup(dev))
 		priv->wer = 0;
 	serial_out(up, UART_OMAP_WER, priv->wer);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-
+	err = pm_runtime_force_suspend(dev);
 	flush_work(&priv->qos_work);
-	return 0;
+
+	return err;
 }
 
 static int omap8250_resume(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	int err;
 
+	err = pm_runtime_force_resume(dev);
+	if (err)
+		return err;
 	serial8250_resume_port(priv->line);
+	/* Paired with pm_runtime_resume_and_get() in omap8250_suspend() */
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	return 0;
 }
 #else
-- 
2.39.2



