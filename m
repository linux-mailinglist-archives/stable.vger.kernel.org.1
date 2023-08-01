Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5B876AD53
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjHAJ2Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjHAJ1u (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68972728
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C1F5614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D3FC433C9;
        Tue,  1 Aug 2023 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882006;
        bh=v/YyHskIMONw7W8OYh+x6h1qcGTm1Mgs/t4Mnf22p58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5w1IvYL2qtfkaIo33iUyDk9lrMgJR9T99BeFkaK77N+0ysnRFkoEGltGxaTNZ9ZJ
         sqdMIeP02SCqah+RNWmAM6N/UDj9X50VrITkAEn+i3/GXX4Z3i+gy0u6zS0pQnSQ3R
         RyD+/qs8TDKpZ3XsYapcNy0KSJCRdj/zGTPkbIDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ruihong Luo <colorsu1922@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.15 107/155] serial: 8250_dw: Preserve original value of DLF register
Date:   Tue,  1 Aug 2023 11:20:19 +0200
Message-ID: <20230801091914.055118170@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ruihong Luo <colorsu1922@gmail.com>

commit 748c5ea8b8796ae8ee80b8d3a3d940570b588d59 upstream.

Preserve the original value of the Divisor Latch Fraction (DLF) register.
When the DLF register is modified without preservation, it can disrupt
the baudrate settings established by firmware or bootloader, leading to
data corruption and the generation of unreadable or distorted characters.

Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
Cc: stable <stable@kernel.org>
Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>
Link: https://lore.kernel.org/stable/20230713004235.35904-1-colorsu1922%40gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20230713004235.35904-1-colorsu1922@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dwlib.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -80,7 +80,7 @@ static void dw8250_set_divisor(struct ua
 void dw8250_setup_port(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, old_dlf;
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -93,9 +93,11 @@ void dw8250_setup_port(struct uart_port
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
 
 	if (reg) {
 		struct dw8250_port_data *d = p->private_data;


