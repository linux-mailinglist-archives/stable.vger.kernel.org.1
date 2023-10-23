Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F197D3333
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjJWL1s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjJWL1r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:27:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A293DF
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:27:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926EC433C9;
        Mon, 23 Oct 2023 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060464;
        bh=nwrsSvFp8BQ3WbiBXqGNtb/uzHBJ2GwqjrJiKq+6fEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3fFkse/sQgPsP9sGZE2HK+28eACn1TvhQcguSBFhB+xWsbzNJx/FZKqih+b0CgnL
         Fb6ja9iORupLtoGfOFqpdcKZ7+ouKJrLJiqs2cvBXmnv8UZiG2NHsUz74NGi/Nygz9
         YTWq4jVnztcQNY07uNcS30IoTN5HCXhnDUXFHFc4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, noreply@ellerman.id.au,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6.1 181/196] serial: 8250: omap: Move uart_write() inside PM section
Date:   Mon, 23 Oct 2023 12:57:26 +0200
Message-ID: <20231023104833.511515235@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert@linux-m68k.org>

commit c53aab20762255ee03e65dd66b3cba3887ad39d1 upstream.

If CONFIG_PM is not set (e.g. m68k/allmodconfig):

    drivers/tty/serial/8250/8250_omap.c:169:13: error: ‘uart_write’ defined but not used [-Werror=unused-function]
      169 | static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
	  |             ^~~~~~~~~~

Fix tis by moving uart_write() inside the existing section protected
by #ifdef CONFIG_PM.

Reported-by: noreply@ellerman.id.au
Link: http://kisskb.ellerman.id.au/kisskb/buildresult/14925095/
Fixes: 398cecc24846e867 ("serial: 8250: omap: Fix imprecise external abort for omap_8250_pm()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Link: https://lore.kernel.org/r/20230515065706.1723477-1-geert@linux-m68k.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_omap.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -159,11 +159,6 @@ static u32 uart_read(struct omap8250_pri
 	return readl(priv->membase + (reg << OMAP_UART_REGSHIFT));
 }
 
-static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
-{
-	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
-}
-
 /*
  * Called on runtime PM resume path from omap8250_restore_regs(), and
  * omap8250_set_mctrl().
@@ -1573,6 +1568,11 @@ static int omap8250_lost_context(struct
 	return 0;
 }
 
+static void uart_write(struct omap8250_priv *priv, u32 reg, u32 val)
+{
+	writel(val, priv->membase + (reg << OMAP_UART_REGSHIFT));
+}
+
 /* TODO: in future, this should happen via API in drivers/reset/ */
 static int omap8250_soft_reset(struct device *dev)
 {


