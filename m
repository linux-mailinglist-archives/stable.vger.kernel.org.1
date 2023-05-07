Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA96F9848
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjEGKxu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 06:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjEGKxt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 06:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4E61AB
        for <stable@vger.kernel.org>; Sun,  7 May 2023 03:53:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB03A60E73
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAFAC433EF;
        Sun,  7 May 2023 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683456827;
        bh=kJPuunNYrQH89putJNlvccX4zMM90aZnrV3uLrX0wVI=;
        h=Subject:To:Cc:From:Date:From;
        b=MQh9QeJli0kcsVf+lSOf4enAMcVuUqgzqqJGDnlOoGZyQyVFx1XdT4Z5NtFGh8XGd
         JCOdhqYteBe3+je/ywQR9VhMsmH/2FqJhemZAIWnAgVKQPCEQfsA8lySKUrEHXN7Va
         hyBaO8pnbMsdzc1eK/Bw5zNw6hQbcx47nNqhw32w=
Subject: FAILED: patch "[PATCH] mtd: spi-nor: spansion: Enable JFFS2 write buffer for" failed to apply to 6.1-stable tree
To:     Takahiro.Kuwano@infineon.com, tudor.ambarus@linaro.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 12:53:37 +0200
Message-ID: <2023050737-slacker-grafted-b278@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a9180c298d3527f43563d02a62cb9e7e145642c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050737-slacker-grafted-b278@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

a9180c298d35 ("mtd: spi-nor: spansion: Enable JFFS2 write buffer for S25FS256T")
6afcc84080c4 ("mtd: spi-nor: spansion: Add support for Infineon S25FS256T")

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

