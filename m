Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876FD775E1C
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjHILsz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjHILb7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:31:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E8010DC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C11FD633D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11EDC433C8;
        Wed,  9 Aug 2023 11:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580718;
        bh=pFwcqOxC1k1i0g2pBgJtjgqBUOwZpmUTeyc0/d/RYZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BTlyO57jiTSk0QAmASMvpY8xNDG+U7ATUQZ5N0zZn2LiGkijA64kAUPO3ADx4lJ6W
         m4TpRiYitlVRRdBlrTU0m3H3vehXMuZiIYiEliSFe7f1BWSd80n0IOSqDuh56SyNaw
         fLY6MfjsDkiWQiyF656sS6A2yKSbmzsKXhsrD/IY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Olivier Maignial <olivier.maignial@hotmail.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 125/154] mtd: spinand: toshiba: Fix ecc_get_status
Date:   Wed,  9 Aug 2023 12:42:36 +0200
Message-ID: <20230809103641.038392372@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Olivier Maignial <olivier.maignial@hotmail.fr>

commit 8544cda94dae6be3f1359539079c68bb731428b1 upstream.

Reading ECC status is failing.

tx58cxgxsxraix_ecc_get_status() is using on-stack buffer
for SPINAND_GET_FEATURE_OP() output. It is not suitable
for DMA needs of spi-mem.

Fix this by using the spi-mem operations dedicated buffer
spinand->scratchbuf.

See
spinand->scratchbuf:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mtd/spinand.h?h=v6.3#n418
spi_mem_check_op():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/spi-mem.c?h=v6.3#n199

Fixes: 10949af1681d ("mtd: spinand: Add initial support for Toshiba TC58CVG2S0H")
Cc: stable@vger.kernel.org
Signed-off-by: Olivier Maignial <olivier.maignial@hotmail.fr>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/DB4P250MB1032553D05FBE36DEE0D311EFE23A@DB4P250MB1032.EURP250.PROD.OUTLOOK.COM
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/spi/toshiba.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/nand/spi/toshiba.c
+++ b/drivers/mtd/nand/spi/toshiba.c
@@ -60,7 +60,7 @@ static int tc58cxgxsx_ecc_get_status(str
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 	u8 mbf = 0;
-	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, &mbf);
+	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(0x30, spinand->scratchbuf);
 
 	switch (status & STATUS_ECC_MASK) {
 	case STATUS_ECC_NO_BITFLIPS:
@@ -79,7 +79,7 @@ static int tc58cxgxsx_ecc_get_status(str
 		if (spi_mem_exec_op(spinand->spimem, &op))
 			return nand->eccreq.strength;
 
-		mbf >>= 4;
+		mbf = *(spinand->scratchbuf) >> 4;
 
 		if (WARN_ON(mbf > nand->eccreq.strength || !mbf))
 			return nand->eccreq.strength;


