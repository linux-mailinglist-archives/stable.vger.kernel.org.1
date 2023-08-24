Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560D07872C2
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjHXO4q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241953AbjHXO4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7611BC6
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:56:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8E2F66F49
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E779AC433C8;
        Thu, 24 Aug 2023 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888987;
        bh=qVoMhibI+C3QGGEyfzHR2288OBTNPiFkQ/piapXIWH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nR2JDlm82G0XBOWzNjxc48UR7Bcy2quoW9veY2zwhx1tMUNKJV4t4TN39PZiLDh+e
         r8AwYoELy2+P/JRF9FqgqnnvGC41CutHIEA1FL3jSW605B+IPWspk8fihw4/9r2QYd
         lmEN+XierwsInwB5+c5Q5C4K6OtywD2yiUrjUQyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: [PATCH 5.15 075/139] tty: serial: fsl_lpuart: Clear the error flags by writing 1 for lpuart32 platforms
Date:   Thu, 24 Aug 2023 16:49:58 +0200
Message-ID: <20230824145026.912300440@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
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
@@ -1107,8 +1107,8 @@ static void lpuart_copy_rx_to_tty(struct
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
-			/* Read DR to clear the error flags */
-			lpuart32_read(&sport->port, UARTDATA);
+			/* Clear the error flags */
+			lpuart32_write(&sport->port, sr, UARTSTAT);
 
 			if (sr & UARTSTAT_PE)
 				sport->port.icount.parity++;


