Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7C17876B8
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242540AbjHXRTG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242851AbjHXRSy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0019BA
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:18:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4D06674CE
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F87C433C8;
        Thu, 24 Aug 2023 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897532;
        bh=Loy9pJrvJHpaZ0s5DjlXnTgzYWMEm6nGQXGvqr8Jfx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guIDmn+dvcjXFW2IhaZlQDC+14FfwaEqTHflBI6lbqtUp4eMBnbbNXYUr8RZPuPrn
         S+0KK+0mHkcbCELnYIURwpLCmCbZtu50PUz2HdDBgqPrfVH3qEzeWwCJ6+bnidyE3z
         QZR9OX1r1HKJGL+pCnJJ2TECJXAtpcBX8VuHiHxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH 5.10 073/135] tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms
Date:   Thu, 24 Aug 2023 19:09:05 +0200
Message-ID: <20230824170620.379199251@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sherry Sun <sherry.sun@nxp.com>

commit 282069845af388b08d622ad192b831dcd0549c62 upstream.

Do not read the data register to clear the error flags for lpuart32
platforms, the additional read may cause the receive FIFO underflow
since the DMA has already read the data register.
Actually all lpuart32 platforms support write 1 to clear those error
bits, let's use this method to better clear the error flags.

Fixes: 42b68768e51b ("serial: fsl_lpuart: DMA support for 32-bit variant")
Cc: stable <stable@kernel.org>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Link: https://lore.kernel.org/r/20230801022304.24251-1-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/fsl_lpuart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1062,8 +1062,8 @@ static void lpuart_copy_rx_to_tty(struct
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
-			/* Read DR to clear the error flags */
-			lpuart32_read(&sport->port, UARTDATA);
+			/* Clear the error flags */
+			lpuart32_write(&sport->port, sr, UARTSTAT);
 
 			if (sr & UARTSTAT_PE)
 				sport->port.icount.parity++;


