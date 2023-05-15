Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A277035DC
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243523AbjEOREB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243527AbjEORDl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752A55254
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:01:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 567FE62A9C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C00CC433EF;
        Mon, 15 May 2023 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170107;
        bh=8gA+FrxBHHsj8cHBn5RFiWYzsmy/JYn4zH6q97BQksQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8aR5YOSNc2CaoulQ7GUHK5XHK1GcvrxSmcRAdqA33TM/rm8SOmFwGkf/GJQ/8jw6
         ZLecGksaK8Tcq5BMlpe2frtwru9BWFfp47xfNLbQ1doLtLeip+ZipHgLlZ7q8kh9cY
         aAdgRDYYiLlyDvulpCoO6BZjUUQWLKTmjepvgrFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 009/239] mtd: spi-nor: spansion: Remove NO_SFDP_FLAGS from s28hs512t info
Date:   Mon, 15 May 2023 18:24:32 +0200
Message-Id: <20230515161721.867501087@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

[ Upstream commit db391efe765cc6cfc0ffc8d8ef146dc8e6816a7e ]

Read, Page Program, and Sector Erase settings are done in SFDP so we can
remove NO_SFDP_FLAGS from s28hs512t info. Since the default_init() is no
longer called after removing NO_SFDP_FLAGS, the initialization in the
default_init() is moved to late_init().

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/12e468992f5d0cbd474abff3203100cc8163d4e5.1661915569.git.Takahiro.Kuwano@infineon.com
Stable-dep-of: 9fd0945fe6fa ("mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx SEMPER flash")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/spansion.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 7ac2ad1a8d576..6bbbfc9c215b8 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -280,12 +280,6 @@ static int cypress_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 			cypress_nor_octal_dtr_dis(nor);
 }
 
-static void s28hs512t_default_init(struct spi_nor *nor)
-{
-	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
-	nor->params->writesize = 16;
-}
-
 static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
 {
 	/*
@@ -321,10 +315,16 @@ static int s28hs512t_post_bfpt_fixup(struct spi_nor *nor,
 	return cypress_nor_set_page_size(nor);
 }
 
+static void s28hs512t_late_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
+	nor->params->writesize = 16;
+}
+
 static const struct spi_nor_fixups s28hs512t_fixups = {
-	.default_init = s28hs512t_default_init,
 	.post_sfdp = s28hs512t_post_sfdp_fixup,
 	.post_bfpt = s28hs512t_post_bfpt_fixup,
+	.late_init = s28hs512t_late_init,
 };
 
 static int
@@ -459,8 +459,7 @@ static const struct flash_info spansion_nor_parts[] = {
 	{ "cy15x104q",  INFO6(0x042cc2, 0x7f7f7f, 512 * 1024, 1)
 		FLAGS(SPI_NOR_NO_ERASE) },
 	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256)
-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_OCTAL_DTR_READ |
-			      SPI_NOR_OCTAL_DTR_PP)
+		PARSE_SFDP
 		.fixups = &s28hs512t_fixups,
 	},
 };
-- 
2.39.2



