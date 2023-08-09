Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921A775DCB
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjHILlW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjHILlV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2301FEE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9C2C63677
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DC1C433C8;
        Wed,  9 Aug 2023 11:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581280;
        bh=XlbgVCpjLjBcuC5CO9oQMBvE6AsXTStywk+HeY1I650=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTVpar1gC5btoXy66uPVfl5KfXNTX/T3fVU2qFHZl+tEBoM3KLaazdEJ0F+MQuq5c
         sSmaZq5WW6z1BpavsJZy2xHOxwsWfU5lsN8gjE/Z40SrYtjUfMp1FjhcF2O0eZMyEj
         CdvYsoMWr0d00M+tmM02mtAhmkyDs2meNlmeRon4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stable@vger.kernel.org,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.10 169/201] mtd: rawnand: meson: fix OOB available bytes for ECC
Date:   Wed,  9 Aug 2023 12:42:51 +0200
Message-ID: <20230809103649.391360802@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
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

From: Arseniy Krasnov <AVKrasnov@sberdevices.ru>

commit 7e6b04f9238eab0f684fafd158c1f32ea65b9eaa upstream.

It is incorrect to calculate number of OOB bytes for ECC engine using
some "already known" ECC step size (1024 bytes here). Number of such
bytes for ECC engine must be whole OOB except 2 bytes for bad block
marker, while proper ECC step size and strength will be selected by
ECC logic.

Fixes: 8fae856c5350 ("mtd: rawnand: meson: add support for Amlogic NAND flash controller")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230705065211.293500-1-AVKrasnov@sberdevices.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/meson_nand.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1180,7 +1180,6 @@ static int meson_nand_attach_chip(struct
 	struct meson_nfc *nfc = nand_get_controller_data(nand);
 	struct meson_nfc_nand_chip *meson_chip = to_meson_nand(nand);
 	struct mtd_info *mtd = nand_to_mtd(nand);
-	int nsectors = mtd->writesize / 1024;
 	int ret;
 
 	if (!mtd->name) {
@@ -1198,7 +1197,7 @@ static int meson_nand_attach_chip(struct
 	nand->options |= NAND_NO_SUBPAGE_WRITE;
 
 	ret = nand_ecc_choose_conf(nand, nfc->data->ecc_caps,
-				   mtd->oobsize - 2 * nsectors);
+				   mtd->oobsize - 2);
 	if (ret) {
 		dev_err(nfc->dev, "failed to ECC init\n");
 		return -EINVAL;


