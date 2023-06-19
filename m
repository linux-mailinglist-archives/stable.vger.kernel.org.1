Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4377352B5
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjFSKha (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjFSKhU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE39DE7C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C82160B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637E5C433C0;
        Mon, 19 Jun 2023 10:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171038;
        bh=/MPlHWjlQW5MauXPUuGP9Q+pqdMIAd0lNprvRFnitZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gO4ADa5ZyON2VkLLWijR3WxVOmCf4VpKMsyXySSuwdGCp1+uXD+g5rNcjWoZMlZ3J
         x2Y6d7sZzJwZVsZf4IQt3185eNNEyo4za+C9Wju5xwYt+KS+uq42QkbsXyC7yOhg+A
         Bh1FAOyi2o/nWm9EzX4+DV8xXravvXXpqLU23E+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Robert Hodaszi <robert.hodaszi@digi.com>
Subject: [PATCH 6.3 099/187] tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A
Date:   Mon, 19 Jun 2023 12:28:37 +0200
Message-ID: <20230619102202.386067478@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Robert Hodaszi <robert.hodaszi@digi.com>

commit a82c3df955f8c1c726e4976527aa6ae924a67dd9 upstream.

LS1028A is using DMA with LPUART. Having RX watermark set to 1, means
DMA transactions are started only after receiving the second character.

On other platforms with newer LPUART IP, Receiver Idle Empty function
initiates the DMA request after the receiver is idling for 4 characters.
But this feature is missing on LS1028A, which is causing a 1-character
delay in the RX direction on this platform.

Set RX watermark to 0 to initiate RX DMA after each character.

Link: https://lore.kernel.org/linux-serial/20230607103459.1222426-1-robert.hodaszi@digi.com/
Fixes: 9ad9df844754 ("tty: serial: fsl_lpuart: Fix the wrong RXWATER setting for rx dma case")
Cc: stable <stable@kernel.org>
Signed-off-by: Robert Hodaszi <robert.hodaszi@digi.com>
Message-ID: <20230609121334.1878626-1-robert.hodaszi@digi.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/fsl_lpuart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -310,7 +310,7 @@ static const struct lpuart_soc_data ls10
 static const struct lpuart_soc_data ls1028a_data = {
 	.devtype = LS1028A_LPUART,
 	.iotype = UPIO_MEM32,
-	.rx_watermark = 1,
+	.rx_watermark = 0,
 };
 
 static struct lpuart_soc_data imx7ulp_data = {


