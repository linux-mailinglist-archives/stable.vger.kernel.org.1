Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6197D35A5
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbjJWLu3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjJWLu2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:50:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72407E8
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCEBC433C8;
        Mon, 23 Oct 2023 11:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061826;
        bh=bhS1fa7fIhYM4MaWGEBo/w4BKfSwDoI7G1zinIKVTD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IelAY9Q+zhcmMYgDt6VO4h5O1/8pwmcigXqWE7D0SaqItfDmrlzLZ+a4nGMWXkl3z
         Exm+IfPxWfOHDZVuFAvthT3okSZcg0AjL4BF2qPmaKvuwiDE5wlOoMR5Paon+x8n2L
         81cjmX27UeghejuQ4u4W6eoZ1E6fpzTVMC/g5gMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.10 177/202] mtd: spinand: micron: correct bitmask for ecc status
Date:   Mon, 23 Oct 2023 12:58:04 +0200
Message-ID: <20231023104831.642704025@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kurbanov <mmkurbanov@sberdevices.ru>

commit 9836a987860e33943945d4b257729a4f94eae576 upstream.

Valid bitmask is 0x70 in the status register.

Fixes: a508e8875e13 ("mtd: spinand: Add initial support for Micron MT29F2G01ABAGD")
Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230905145637.139068-1-mmkurbanov@sberdevices.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/spi/micron.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/nand/spi/micron.c
+++ b/drivers/mtd/nand/spi/micron.c
@@ -12,7 +12,7 @@
 
 #define SPINAND_MFR_MICRON		0x2c
 
-#define MICRON_STATUS_ECC_MASK		GENMASK(7, 4)
+#define MICRON_STATUS_ECC_MASK		GENMASK(6, 4)
 #define MICRON_STATUS_ECC_NO_BITFLIPS	(0 << 4)
 #define MICRON_STATUS_ECC_1TO3_BITFLIPS	(1 << 4)
 #define MICRON_STATUS_ECC_4TO6_BITFLIPS	(3 << 4)


