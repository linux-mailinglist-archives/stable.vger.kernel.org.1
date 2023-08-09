Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C5D775962
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjHILAG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjHILAE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684F81724
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0847A63118
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173F9C433C8;
        Wed,  9 Aug 2023 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578803;
        bh=XlbgVCpjLjBcuC5CO9oQMBvE6AsXTStywk+HeY1I650=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CGeFcrsXVPI7NUtpJNvo2XLJ3n2yMX/m5eqwjdoSUHsb7qD4QEclRfhblbUGzwAVS
         0F/iMmYnfH2vScHBD9ZgDGJaVimOXFeYbT96r87z7zolq5IXIrpd222pbATpV5LXtE
         ciC5kZOKaxgJKp6j/hq4fbVhW6hTW7NnncmQ6sN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stable@vger.kernel.org,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.15 63/92] mtd: rawnand: meson: fix OOB available bytes for ECC
Date:   Wed,  9 Aug 2023 12:41:39 +0200
Message-ID: <20230809103635.772775097@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
References: <20230809103633.485906560@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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


