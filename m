Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDD726E24
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjFGUsZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjFGUsO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF31B19BB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC9766436B
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08C7C433D2;
        Wed,  7 Jun 2023 20:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170853;
        bh=lQba0g0GOwP76HL9SmwXCE8zweSnZUAXBFtML6Vl5wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBsHVUWhpKGDW3uOOu4bnHfGdLV7Y0F8Oi7JZW9s6BFUfqOiUeeg+PpcCDsXmJE58
         5cyA7I768JHPZwct48wzNxfcBkobrIi9HEphJMoh6ZuonjKG7pOXWzfYgb9c/Wd6nt
         gijEDz/Ndyy+O/LD86B4nKNdqKaVGaKJBLy2KGf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 017/120] mtd: rawnand: ingenic: fix empty stub helper definitions
Date:   Wed,  7 Jun 2023 22:15:33 +0200
Message-ID: <20230607200901.459150550@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 650a8884a364ff2568b51cde9009cfd43cdae6ad ]

A few functions provide an empty interface definition when
CONFIG_MTD_NAND_INGENIC_ECC is disabled, but they are accidentally
defined as global functions in the header:

drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:39:5: error: no previous prototype for 'ingenic_ecc_calculate'
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:46:5: error: no previous prototype for 'ingenic_ecc_correct'
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:53:6: error: no previous prototype for 'ingenic_ecc_release'
drivers/mtd/nand/raw/ingenic/ingenic_ecc.h:57:21: error: no previous prototype for 'of_ingenic_ecc_get'

Turn them into 'static inline' definitions instead.

Fixes: 15de8c6efd0e ("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230516202133.559488-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
index 2cda439b5e11b..017868f59f222 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
@@ -36,25 +36,25 @@ int ingenic_ecc_correct(struct ingenic_ecc *ecc,
 void ingenic_ecc_release(struct ingenic_ecc *ecc);
 struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np);
 #else /* CONFIG_MTD_NAND_INGENIC_ECC */
-int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
+static inline int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
 			  struct ingenic_ecc_params *params,
 			  const u8 *buf, u8 *ecc_code)
 {
 	return -ENODEV;
 }
 
-int ingenic_ecc_correct(struct ingenic_ecc *ecc,
+static inline int ingenic_ecc_correct(struct ingenic_ecc *ecc,
 			struct ingenic_ecc_params *params, u8 *buf,
 			u8 *ecc_code)
 {
 	return -ENODEV;
 }
 
-void ingenic_ecc_release(struct ingenic_ecc *ecc)
+static inline void ingenic_ecc_release(struct ingenic_ecc *ecc)
 {
 }
 
-struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
+static inline struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.39.2



