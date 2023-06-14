Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAC0726B36
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjFGUXy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjFGUXa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C68F269F
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE4A643F4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5456C433EF;
        Wed,  7 Jun 2023 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169335;
        bh=lQba0g0GOwP76HL9SmwXCE8zweSnZUAXBFtML6Vl5wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzu8AdC6ODRR92SiZlUe8KWW3LB4/fmhfCAuq+OzsBiN5NgOL7J0B19pp1X1OjOVY
         TKcgkN5v8MEsAkh7c4BV2/t8kf6BT/S6jVAi4XCWR33Zg4z1UjuzTD2ZP+L6SPblH4
         PYiV0wxrWfgvfo9R5Kz3i6DBW0aoOF4Btwdb7wYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 042/286] mtd: rawnand: ingenic: fix empty stub helper definitions
Date:   Wed,  7 Jun 2023 22:12:21 +0200
Message-ID: <20230607200924.416009014@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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



