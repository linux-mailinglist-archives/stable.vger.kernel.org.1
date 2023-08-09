Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620CD775CB5
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjHILaF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjHILaE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:30:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B510DC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:30:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F4C763341
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:30:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E84FC433C8;
        Wed,  9 Aug 2023 11:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580603;
        bh=v/YyHskIMONw7W8OYh+x6h1qcGTm1Mgs/t4Mnf22p58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfogGAQFsH/b37AGirHJI599LqAq18jzppNdO3SzRU12sABITsbDLyXCTPpo+Vkcy
         1S2/G9i4Ukqr0fvay1WXciVOSczrdz/VqF6yccdIPerk3ULNFN9n9PhBDXY7qQSQep
         eXRYYEz+gMTRBaxwHvc21onz/Yrk7tafYqErrVy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Ruihong Luo <colorsu1922@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 055/154] serial: 8250_dw: Preserve original value of DLF register
Date:   Wed,  9 Aug 2023 12:41:26 +0200
Message-ID: <20230809103638.825058062@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


