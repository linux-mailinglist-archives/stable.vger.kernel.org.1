Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FB8761788
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjGYLsu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjGYLsL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:48:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11ED6A0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:48:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E0F61698
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF696C433C7;
        Tue, 25 Jul 2023 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285690;
        bh=ALuuFORp7ly3nMO52QnZZHv3Z5lhBmOL9ISmcn8vGFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/nRbqkokf7N289bI6fBeJMpRh44N2q7F7A/PfSePiJ36nrnQ9ZZ3TZK+Mod/wGa0
         3h2u7VdGDzFQedo76WmpU7WVsJx0iAiHEdRqsHWnfq4SEF/eHItQrRA5h8MukVQv+S
         kxS1rklKP31yI4Yhwwr5UviIOTEN3Vn4LF5Rri0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 296/313] spi: bcm63xx: fix max prepend length
Date:   Tue, 25 Jul 2023 12:47:29 +0200
Message-ID: <20230725104533.948839667@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index fdd7eaa0b8ede..ff27596168732 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -125,7 +125,7 @@ enum bcm63xx_regs_spi {
 	SPI_MSG_DATA_SIZE,
 };
 
-#define BCM63XX_SPI_MAX_PREPEND		15
+#define BCM63XX_SPI_MAX_PREPEND		7
 
 #define BCM63XX_SPI_MAX_CS		8
 #define BCM63XX_SPI_BUS_NUM		0
-- 
2.39.2



