Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E79F703722
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbjEORRL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243818AbjEORQv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:16:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A23A10E7E
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B936662BDA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE992C433A7;
        Mon, 15 May 2023 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170931;
        bh=1JrCvhACJG3XIdoGF23okqvudLlr2PKQ40wi+gkY0zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DFZaMkstn7As5wFuVQ0u0yuCpBt/pvfCmc+m3I/fzzYgwlInnfULV0WxbBgbSlx47
         0HUH08rb6q6tp92PYPA24QOSng/jURBKe+b3YaAfuKSUovzcJC51QWV+99yPS0vDDz
         gIjZ8JD8/bmoKSujqobSywx+83G8uJGUovWtPCPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tudor Ambarus <tudor.ambarus@linaro.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 007/242] mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx SEMPER flash
Date:   Mon, 15 May 2023 18:25:33 +0200
Message-Id: <20230515161722.033603276@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

[ Upstream commit 9fd0945fe6fadfb6b54a9cd73be101c02b3e8134 ]

Infineon(Cypress) SEMPER NOR flash family has on-die ECC and its program
granularity is 16-byte ECC data unit size. JFFS2 supports write buffer
mode for ECC'd NOR flash. Provide a way to clear the MTD_BIT_WRITEABLE
flag in order to enable JFFS2 write buffer mode support.

A new SNOR_F_ECC flag is introduced to determine if the part has on-die
ECC and if it has, MTD_BIT_WRITEABLE is unset.

In vendor specific driver, a common cypress_nor_ecc_init() helper is
added. This helper takes care for ECC related initialization for SEMPER
flash family by setting up params->writesize and SNOR_F_ECC.

Fixes: c3266af101f2 ("mtd: spi-nor: spansion: add support for Cypress Semper flash")
Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/d586723f6f12aaff44fbcd7b51e674b47ed554ed.1680760742.git.Takahiro.Kuwano@infineon.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/core.c     |  3 +++
 drivers/mtd/spi-nor/core.h     |  1 +
 drivers/mtd/spi-nor/debugfs.c  |  1 +
 drivers/mtd/spi-nor/spansion.c | 13 ++++++++++++-
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 767b1faa32b0e..d75db50767938 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2983,6 +2983,9 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
 		mtd->name = dev_name(dev);
 	mtd->type = MTD_NORFLASH;
 	mtd->flags = MTD_CAP_NORFLASH;
+	/* Unset BIT_WRITEABLE to enable JFFS2 write buffer for ECC'd NOR */
+	if (nor->flags & SNOR_F_ECC)
+		mtd->flags &= ~MTD_BIT_WRITEABLE;
 	if (nor->info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
 	else
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 57e8916965ea8..75ec2e5604247 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -131,6 +131,7 @@ enum spi_nor_option_flags {
 	SNOR_F_SOFT_RESET	= BIT(12),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(13),
 	SNOR_F_RWW		= BIT(14),
+	SNOR_F_ECC		= BIT(15),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index bd8a18da49c04..285bdcbaa1134 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -26,6 +26,7 @@ static const char *const snor_f_names[] = {
 	SNOR_F_NAME(SOFT_RESET),
 	SNOR_F_NAME(SWP_IS_VOLATILE),
 	SNOR_F_NAME(RWW),
+	SNOR_F_NAME(ECC),
 };
 #undef SNOR_F_NAME
 
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 07fe0f6fdfe3e..f4e9a1738234a 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -218,6 +218,17 @@ static int cypress_nor_set_page_size(struct spi_nor *nor)
 	return 0;
 }
 
+static void cypress_nor_ecc_init(struct spi_nor *nor)
+{
+	/*
+	 * Programming is supported only in 16-byte ECC data unit granularity.
+	 * Byte-programming, bit-walking, or multiple program operations to the
+	 * same ECC data unit without an erase are not allowed.
+	 */
+	nor->params->writesize = 16;
+	nor->flags |= SNOR_F_ECC;
+}
+
 static int
 s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 			const struct sfdp_parameter_header *bfpt_header,
@@ -324,7 +335,7 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 static void s28hx_t_late_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
-	nor->params->writesize = 16;
+	cypress_nor_ecc_init(nor);
 }
 
 static const struct spi_nor_fixups s28hx_t_fixups = {
-- 
2.39.2



