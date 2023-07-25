Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857576135E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjGYLKT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjGYLJz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:09:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA0C448B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:08:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0846361689
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B61C433C7;
        Tue, 25 Jul 2023 11:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283330;
        bh=ObqO7+00nlkMK6KGGi4EGZ9qP/vawE+7zD57CJhjyFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oCEbV7dYmrxieregvfSJ8VJKhZe9ATFnEKLPa4vOCYsyc14rz60KlCk+2Fe+fntaE
         U+TXZAxgQ4N9e/sU0sPyHaUneHhy3feMm/n79miXznxgHV6igmKqaGxsk2/DiKfwif
         s0FvWOmLf/L1xAd8r6XqrTXQuADJIFU2oLOLKVxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 38/78] spi: bcm63xx: fix max prepend length
Date:   Tue, 25 Jul 2023 12:46:29 +0200
Message-ID: <20230725104452.782368253@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104451.275227789@linuxfoundation.org>
References: <20230725104451.275227789@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 5158814cbb37bbb38344b3ecddc24ba2ed0365f2 ]

The command word is defined as following:

    /* Command */
    #define SPI_CMD_COMMAND_SHIFT           0
    #define SPI_CMD_DEVICE_ID_SHIFT         4
    #define SPI_CMD_PREPEND_BYTE_CNT_SHIFT  8
    #define SPI_CMD_ONE_BYTE_SHIFT          11
    #define SPI_CMD_ONE_WIRE_SHIFT          12

If the prepend byte count field starts at bit 8, and the next defined
bit is SPI_CMD_ONE_BYTE at bit 11, it can be at most 3 bits wide, and
thus the max value is 7, not 15.

Fixes: b17de076062a ("spi/bcm63xx: work around inability to keep CS up")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://lore.kernel.org/r/20230629071453.62024-1-jonas.gorski@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 80fa0ef8909ca..147199002df1e 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -126,7 +126,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
-- 
2.39.2



