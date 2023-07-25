Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9987611EC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjGYK5d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjGYK5E (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF1422B
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C513261655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37C8C433C7;
        Tue, 25 Jul 2023 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282474;
        bh=D8OvjMNbXf5I8VZ2grsUsdo7cqXlD7tyBnT5irW8Ngs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IN83s3dbBvEGke+JhPCOuOLxwVy2UnX5yambIjb1UxeFqjJhHn06ueTStRwLI49fZ
         gl66Q1LnVfrx7z+TzgtXEPlj6Oo6N8Y6wr7fDDar8E+SGrX1pDZ2qlDAYcO+BVttWA
         3dagf8AxJkdcDq5UTPYeS5d+TYrZl+ezdFcaZi7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 143/227] spi: bcm63xx: fix max prepend length
Date:   Tue, 25 Jul 2023 12:45:10 +0200
Message-ID: <20230725104520.803963296@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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
index 9aecb77c3d892..07b5b71b23520 100644
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



