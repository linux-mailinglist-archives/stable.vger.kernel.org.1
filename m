Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0A7611F5
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjGYK6c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjGYK5b (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1542D71
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7673F6165C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852C4C433C9;
        Tue, 25 Jul 2023 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282490;
        bh=HboF+4v05ushogV5yKXmiced3Q7m/2nac8pU+/lWLCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tjr39rSpxkTgVRtwAgkOHFMCzoTRufRH2dQaBLa5FpWeNs099xmAFB0YdqXQN2yZf
         ooRzIoQnioskVafaeYwhDUl5uxt7vvCf5XgzhziEEAonlyAAvbBLMYUBCE9i4A2Fwi
         2vbayJZQWjxbbWEFZC4YROHB4Y+YR4Uoy4AD6oMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jaewon Kim <jaewon02.kim@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 148/227] spi: s3c64xx: clear loopback bit after loopback test
Date:   Tue, 25 Jul 2023 12:45:15 +0200
Message-ID: <20230725104521.020123270@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Jaewon Kim <jaewon02.kim@samsung.com>

[ Upstream commit 9ec3c5517e22a12d2ff1b71e844f7913641460c6 ]

When SPI loopback transfer is performed, S3C64XX_SPI_MODE_SELF_LOOPBACK
bit still remained. It works as loopback even if the next transfer is
not spi loopback mode.
If not SPI_LOOP, needs to clear S3C64XX_SPI_MODE_SELF_LOOPBACK bit.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Fixes: ffb7bcd3b27e ("spi: s3c64xx: support loopback mode")
Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Link: https://lore.kernel.org/r/20230711082020.138165-1-jaewon02.kim@samsung.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-s3c64xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 7ac17f0d18a95..1a8b31e20baf2 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -668,6 +668,8 @@ static int s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
 
 	if ((sdd->cur_mode & SPI_LOOP) && sdd->port_conf->has_loopback)
 		val |= S3C64XX_SPI_MODE_SELF_LOOPBACK;
+	else
+		val &= ~S3C64XX_SPI_MODE_SELF_LOOPBACK;
 
 	writel(val, regs + S3C64XX_SPI_MODE_CFG);
 
-- 
2.39.2



