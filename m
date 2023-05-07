Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85F56F984A
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjEGKx4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjEGKxz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 06:53:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39985B88
        for <stable@vger.kernel.org>; Sun,  7 May 2023 03:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4694E60B01
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:53:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBB9C433EF;
        Sun,  7 May 2023 10:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683456832;
        bh=y8RHHTwRBnEWV+7U8rOnQ5EJaA74VLv9du7zmu+8THY=;
        h=Subject:To:Cc:From:Date:From;
        b=LyQas8JYQATkKk5nT9NebGqCuSZ2JyiGNcE5SzR9Jmy0zRtfMURI8khnIZcEsgaw/
         7RCTn7r0FCW/OStGkzFYAsXxU0uuEsBVfgdvEWgnEkxmlSY/y+/rknSIF2YdqYOvWO
         av8gKi0ZfrzN7nOYf0OZsYyvbAwTcbP37IqBMQ9o=
Subject: FAILED: patch "[PATCH] mtd: spi-nor: spansion: Enable JFFS2 write buffer for" failed to apply to 5.15-stable tree
To:     Takahiro.Kuwano@infineon.com, tudor.ambarus@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 12:53:38 +0200
Message-ID: <2023050738-mobilize-unwrapped-91ca@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a9180c298d3527f43563d02a62cb9e7e145642c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050738-mobilize-unwrapped-91ca@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a9180c298d35 ("mtd: spi-nor: spansion: Enable JFFS2 write buffer for S25FS256T")
6afcc84080c4 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")
b6b23833fc42 ("mtd: spi-nor: spansion: Add s25hl-t/s25hs-t IDs and fixups")
a6b50aa12796 ("mtd: spi-nor: spansion: Add local function to discover page size")
c0abb861c5d0 ("mtd: spi-nor: Introduce templates for SPI NOR operations")
27ff0d34fb7e ("mtd: spi-nor: spansion: Rework spi_nor_cypress_octal_dtr_enable()")
4629adaff7bc ("mtd: spi-nor: micron-st: Rework spi_nor_micron_octal_dtr_enable()")
a007d81aa525 ("mtd: spi-nor: manufacturers: Use spi_nor_read_id() core method")
86b6b55ffbbc ("mtd: spi-nor: core: Introduce method for RDID op")
bffabd1c727d ("mtd: spi-nor: core: Use auto-detection only once")
837d5181beef ("mtd: spi-nor: move all spansion specifics into spansion.c")
6235ff040c13 ("mtd: spi-nor: spansion: slightly rework control flow in late_init()")
c770abe52d81 ("mtd: spi-nor: move all micron-st specifics into micron-st.c")
8b7a2e00d117 ("mtd: spi-nor: xilinx: rename vendor specific functions and defines")
8b4195cd6dc3 ("mtd: spi-nor: move all xilinx specifics into xilinx.c")
9fb4beb1b051 ("mtd: spi-nor: guard _page_size parameter in S3AN_INFO()")
4cf1c7bdc55c ("mtd: spi-nor: allow a flash to define its own ready() function")
b44aa9ac6bb4 ("mtd: spi-nor: slightly refactor the spi_nor_setup()")
45acce2099c5 ("mtd: spi-nor: xilinx: unify function names")
fedd0cbf3e93 ("mtd: spi-nor: spansion: unify function names")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a9180c298d3527f43563d02a62cb9e7e145642c6 Mon Sep 17 00:00:00 2001
From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Thu, 6 Apr 2023 15:17:46 +0900
Subject: [PATCH] mtd: spi-nor: spansion: Enable JFFS2 write buffer for
 S25FS256T

Infineon(Cypress) SEMPER NOR flash family has on-die ECC and its program
granularity is 16-byte ECC data unit size. JFFS2 supports write buffer
mode for ECC'd NOR flash. Provide a way to clear the MTD_BIT_WRITEABLE
flag in order to enable JFFS2 write buffer mode support. Drop the
comment as the same info is now specified in cypress_nor_ecc_init().

Fixes: 6afcc84080c4 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")
Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/641bfb26c6e059915ae920117b7ec278df1a6f0a.1680760742.git.Takahiro.Kuwano@infineon.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 4d0cc10e3d85..ffeede78700d 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -384,13 +384,7 @@ static void s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
 
 static void s25fs256t_late_init(struct spi_nor *nor)
 {
-	/*
-	 * Programming is supported only in 16-byte ECC data unit granularity.
-	 * Byte-programming, bit-walking, or multiple program operations to the
-	 * same ECC data unit without an erase are not allowed. See chapter
-	 * 5.3.1 and 5.6 in the datasheet.
-	 */
-	nor->params->writesize = 16;
+	cypress_nor_ecc_init(nor);
 }
 
 static struct spi_nor_fixups s25fs256t_fixups = {

