Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AC1703480
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbjEOQtQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbjEOQtA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961359CA
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF1BF6293C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1859C4339B;
        Mon, 15 May 2023 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169338;
        bh=KSWoIp/fqUhbfbJrdcU2UXGl33rwz5zbp+H/RsfZLaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYydwscWAZi3mDUKV22fl8Mu9T77y+hamqMAKZk81GqptAVpFVMXl5w2hr9bIvKtE
         MavebJG1mOZ/vIWT/23yIzdUVA6qPBHt15hTBuMPuwc3rCNY6foU1lCuIqlLBgjcQW
         /DscwxsQd5vhv/YxQgWbmOOmnHWUYS8wajsFWmpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tudor Ambarus <tudor.ambarus@linaro.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 008/246] mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s25hx SEMPER flash
Date:   Mon, 15 May 2023 18:23:40 +0200
Message-Id: <20230515161722.869713012@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

[ Upstream commit 4199c1719e24e73be0acc8b0146fc31ad8af9771 ]

Infineon(Cypress) SEMPER NOR flash family has on-die ECC and its program
granularity is 16-byte ECC data unit size. JFFS2 supports write buffer
mode for ECC'd NOR flash. Provide a way to clear the MTD_BIT_WRITEABLE
flag in order to enable JFFS2 write buffer mode support.

Fixes: b6b23833fc42 ("mtd: spi-nor: spansion: Add s25hl-t/s25hs-t IDs and fixups")
Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/a1cc128e094db4ec141f85bd380127598dfef17e.1680760742.git.Takahiro.Kuwano@infineon.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/spansion.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 4c34077f12162..27a3634762ad3 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -266,13 +266,10 @@ static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 
 static void s25hx_t_late_init(struct spi_nor *nor)
 {
-	struct spi_nor_flash_parameter *params = nor->params;
-
 	/* Fast Read 4B requires mode cycles */
-	params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
+	nor->params->reads[SNOR_CMD_READ_FAST].num_mode_clocks = 8;
 
-	/* The writesize should be ECC data unit size */
-	params->writesize = 16;
+	cypress_nor_ecc_init(nor);
 }
 
 static struct spi_nor_fixups s25hx_t_fixups = {
-- 
2.39.2



