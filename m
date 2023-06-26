Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F93373E8A5
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjFZS2J (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjFZS1i (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:27:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595822D54
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:27:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACDC960F18
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3394C433C8;
        Mon, 26 Jun 2023 18:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804030;
        bh=En6cyVhig4P71uvHOkeVN2rB/1pzjjQFS9+3GOfF+0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JaBT4GIESkWTzUHLmNTX0+xxlgNfzChpLKwOkYzq8SYBqqqEz7N5/CgljW3BRu0k
         1eTnMv8CYHr2kIkHxcfONLOmtY1mIfFVW570LWwxhrL4arQgQlQsH9e4r/72o9/XBx
         EMhZx/4SnzSupEbz2p9XcXut5/MPw4BOaDHGd/Fc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Robert Hodaszi <robert.hodaszi@digi.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 005/170] tty: serial: fsl_lpuart: reduce RX watermark to 0 on LS1028A
Date:   Mon, 26 Jun 2023 20:09:34 +0200
Message-ID: <20230626180800.743009302@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Robert Hodaszi <robert.hodaszi@digi.com>

[ Upstream commit a82c3df955f8c1c726e4976527aa6ae924a67dd9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 82066f17bdfb1..1093c74b52840 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -302,7 +302,7 @@ static const struct lpuart_soc_data ls1021a_data = {
 static const struct lpuart_soc_data ls1028a_data = {
 	.devtype = LS1028A_LPUART,
 	.iotype = UPIO_MEM32,
-	.rx_watermark = 1,
+	.rx_watermark = 0,
 };
 
 static struct lpuart_soc_data imx7ulp_data = {
-- 
2.39.2



