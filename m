Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B99769590
	for <lists+stable@lfdr.de>; Mon, 31 Jul 2023 14:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjGaMGM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 31 Jul 2023 08:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjGaMGL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 31 Jul 2023 08:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEEE1702
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 05:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F596105A
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 12:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444D7C433C9;
        Mon, 31 Jul 2023 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690805149;
        bh=jv1sYuzx25Uu4/olrs3IdjxV+P8tz2RcWyuxz+X8GrI=;
        h=Subject:To:Cc:From:Date:From;
        b=yetMigi+4uQ2605nWz+j9pFGwuxMNVEeqdW5mRLSJWCSHnHUZ23fkd0hWSptvwu8j
         DOPR1hzOAQFx998eYgsT8SnuESvkvXMk22GjiEduSN/02QRslRTgC+jshrLzth1z5V
         hCGtL5g2B4riUlRATX5lg/zFz01hEGwhy3oinH40=
Subject: FAILED: patch "[PATCH] serial: 8250_dw: Preserve original value of DLF register" failed to apply to 4.19-stable tree
To:     colorsu1922@gmail.com, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        stable@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 31 Jul 2023 14:05:41 +0200
Message-ID: <2023073141-suspend-gloss-a42a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 748c5ea8b8796ae8ee80b8d3a3d940570b588d59
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023073141-suspend-gloss-a42a@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

748c5ea8b879 ("serial: 8250_dw: Preserve original value of DLF register")
136e0ab99b22 ("serial: 8250_dw: split Synopsys DesignWare 8250 common functions")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 748c5ea8b8796ae8ee80b8d3a3d940570b588d59 Mon Sep 17 00:00:00 2001
From: Ruihong Luo <colorsu1922@gmail.com>
Date: Thu, 13 Jul 2023 08:42:36 +0800
Subject: [PATCH] serial: 8250_dw: Preserve original value of DLF register
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 75f32f054ebb..84843e204a5e 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
 	struct dw8250_port_data *pd = p->private_data;
 	struct dw8250_data *data = to_dw8250_data(pd);
 	struct uart_8250_port *up = up_to_u8250p(p);
-	u32 reg;
+	u32 reg, old_dlf;
 
 	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
 	if (pd->hw_rs485_support) {
@@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/* Preserve value written by firmware or bootloader  */
+	old_dlf = dw8250_readl_ext(p, DW_UART_DLF);
 	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
 	reg = dw8250_readl_ext(p, DW_UART_DLF);
-	dw8250_writel_ext(p, DW_UART_DLF, 0);
+	dw8250_writel_ext(p, DW_UART_DLF, old_dlf);
 
 	if (reg) {
 		pd->dlf_size = fls(reg);

