Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168A7A385E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjIQTe4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239725AbjIQTe3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:34:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EABD9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:34:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFF6C433CB;
        Sun, 17 Sep 2023 19:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979263;
        bh=Bhnitx0QGB2byprSZoc86jE/lwSfMTPaayiWrEK7DGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yQAukjD444nVmnCCnBJ9NA+h31WRowMXQuU34bM/qaGqrCX/LePhf5EoPHw9UWaTb
         wplQTdP6L0MTLwuQ1vgXzcGAWPhWiT8x402VlnqV6ZauL0r/0GLk4pGNqOHwB1F5XS
         45ly40p0dOYgP64QzB9siwg3uPc/g+7MZq+SV8ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 262/406] mtd: spi-nor: Check bus width while setting QE bit
Date:   Sun, 17 Sep 2023 21:11:56 +0200
Message-ID: <20230917191108.126558712@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hsin-Yi Wang <hsinyi@chromium.org>

[ Upstream commit f01d8155a92e33cdaa85d20bfbe6c441907b3c1f ]

spi_nor_write_16bit_sr_and_check() should also check if bus width is
4 before setting QE bit.

Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()")
Suggested-by: Michael Walle <michael@walle.cc>
Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20230818064524.1229100-2-hsinyi@chromium.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3422152319321..09e112f376918 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -800,21 +800,22 @@ static int spi_nor_write_16bit_sr_and_check(struct spi_nor *nor, u8 sr1)
 		ret = spi_nor_read_cr(nor, &sr_cr[1]);
 		if (ret)
 			return ret;
-	} else if (nor->params->quad_enable) {
+	} else if (spi_nor_get_protocol_width(nor->read_proto) == 4 &&
+		   spi_nor_get_protocol_width(nor->write_proto) == 4 &&
+		   nor->params->quad_enable) {
 		/*
 		 * If the Status Register 2 Read command (35h) is not
 		 * supported, we should at least be sure we don't
 		 * change the value of the SR2 Quad Enable bit.
 		 *
-		 * We can safely assume that when the Quad Enable method is
-		 * set, the value of the QE bit is one, as a consequence of the
-		 * nor->params->quad_enable() call.
+		 * When the Quad Enable method is set and the buswidth is 4, we
+		 * can safely assume that the value of the QE bit is one, as a
+		 * consequence of the nor->params->quad_enable() call.
 		 *
-		 * We can safely assume that the Quad Enable bit is present in
-		 * the Status Register 2 at BIT(1). According to the JESD216
-		 * revB standard, BFPT DWORDS[15], bits 22:20, the 16-bit
-		 * Write Status (01h) command is available just for the cases
-		 * in which the QE bit is described in SR2 at BIT(1).
+		 * According to the JESD216 revB standard, BFPT DWORDS[15],
+		 * bits 22:20, the 16-bit Write Status (01h) command is
+		 * available just for the cases in which the QE bit is
+		 * described in SR2 at BIT(1).
 		 */
 		sr_cr[1] = SR2_QUAD_EN_BIT1;
 	} else {
-- 
2.40.1



