Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD86F9844
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 12:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjEGKxj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGKxi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 06:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B002A59EE
        for <stable@vger.kernel.org>; Sun,  7 May 2023 03:53:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4433260C86
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:53:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542BFC433EF;
        Sun,  7 May 2023 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683456815;
        bh=b7wGWnVPBgarvVjsnP/V2VJrkB4Digvj0zHQp3k+erg=;
        h=Subject:To:Cc:From:Date:From;
        b=RzcB1Z1cRwUJBO/i3AA0pUpi3dRvhre/LvGRL2vEJu49nDQgMcCvadbkzXeXajrs+
         N3nHDagiAqo5KhuJ462B9Be0Ezz1uB512UqBJj6w11rolv9nojzL/+jTpE2+qUIQSL
         WwNBBccN2kuxVCZbFLkpMtXw9txCpbGLuYKvx91c=
Subject: FAILED: patch "[PATCH] mtd: spi-nor: spansion: Enable JFFS2 write buffer for" failed to apply to 6.2-stable tree
To:     Takahiro.Kuwano@infineon.com, tudor.ambarus@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 12:53:25 +0200
Message-ID: <2023050724-power-yippee-10d9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x 9fd0945fe6fadfb6b54a9cd73be101c02b3e8134
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050724-power-yippee-10d9@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

9fd0945fe6fa ("mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s28hx SEMPER flash")
4eddee70140b ("mtd: spi-nor: Add a RWW flag")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9fd0945fe6fadfb6b54a9cd73be101c02b3e8134 Mon Sep 17 00:00:00 2001
From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Thu, 6 Apr 2023 15:17:44 +0900
Subject: [PATCH] mtd: spi-nor: spansion: Enable JFFS2 write buffer for
 Infineon s28hx SEMPER flash

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

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1e30737b607b..143ca3c9b477 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3407,6 +3407,9 @@ static void spi_nor_set_mtd_info(struct spi_nor *nor)
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
index ea9033cb0a01..8cfa82ed06c7 100644
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
index e200f5b9234c..082c0c5a8626 100644
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
index 352c40dd3864..19b1436f36ea 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -332,6 +332,17 @@ static int cypress_nor_set_page_size(struct spi_nor *nor)
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
 s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 			  const struct sfdp_parameter_header *bfpt_header,
@@ -506,7 +517,7 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 static void s28hx_t_late_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = cypress_nor_octal_dtr_enable;
-	nor->params->writesize = 16;
+	cypress_nor_ecc_init(nor);
 }
 
 static const struct spi_nor_fixups s28hx_t_fixups = {

