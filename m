Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B36D77AD36
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjHMVsO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjHMVrG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:47:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E058D2D66
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75CFE60CA3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865BDC433C8;
        Sun, 13 Aug 2023 21:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963224;
        bh=EnlOqSZzYVL4gqDBVzyfLjHH9R2SKtoMEjbfxtC1vEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFMWGEm2XdQjNk/sK06R3eG7ex7nSt2iYJmIFet7deru/GL2l1tiNEUjk/yPvhRPH
         5YfnM2XtyY8TGM7gbmcthueyxfAWduljEVMHI6jIjCBCt5Iy04nctAsyMwkJUf88ok
         M5I2L/oUX9Tup4VaBtOFFKCQ0hq7J3udmXAXG4dg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergei Antonov <saproj@gmail.com>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 01/39] mmc: moxart: read scr register without changing byte order
Date:   Sun, 13 Aug 2023 23:19:52 +0200
Message-ID: <20230813211704.854081646@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Sergei Antonov <saproj@gmail.com>

commit d44263222134b5635932974c6177a5cba65a07e8 upstream.

Conversion from big-endian to native is done in a common function
mmc_app_send_scr(). Converting in moxart_transfer_pio() is extra.
Double conversion on a LE system returns an incorrect SCR value,
leads to errors:

mmc0: unrecognised SCR structure version 8

Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
Signed-off-by: Sergei Antonov <saproj@gmail.com>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230627120549.2400325-1-saproj@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/moxart-mmc.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -339,13 +339,7 @@ static void moxart_transfer_pio(struct m
 				return;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
-				/* SCR data must be read in big endian. */
-				if (data->mrq->cmd->opcode == SD_APP_SEND_SCR)
-					*sgp = ioread32be(host->base +
-							  REG_DATA_WINDOW);
-				else
-					*sgp = ioread32(host->base +
-							REG_DATA_WINDOW);
+				*sgp = ioread32(host->base + REG_DATA_WINDOW);
 				sgp++;
 				len += 4;
 			}


