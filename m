Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668617035DA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243453AbjEORDh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243479AbjEORDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E721DA5F7
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C36AF62A77
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9891C433EF;
        Mon, 15 May 2023 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170076;
        bh=KfyS/YxF5LZLHZIgdO4TycYDLM86fZp8B4ciTUBLaT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISlDUt4Qip9ZrUqty2olIDYwHPXVPjPO+o1Ro/q2CR3WE79cAUtoEGA3XO1IwiUQV
         zoRJAOoQxOS6MsDyAzXENr1X4p/PXDrVp0hz1K+gbwZDUt15OEf5PZUgR/r118MtJ5
         +uAw+gPtBO8WTnsVYqEr0Sf0GFZ3XRnm+kOb85HI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tudor Ambarus <tudor.ambarus@linaro.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/239] mtd: spi-nor: spansion: Enable JFFS2 write buffer for Infineon s25hx SEMPER flash
Date:   Mon, 15 May 2023 18:24:40 +0200
Message-Id: <20230515161722.106915271@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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
index 581f209c27347..7e7c68fc7776d 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -260,13 +260,10 @@ static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
 
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



