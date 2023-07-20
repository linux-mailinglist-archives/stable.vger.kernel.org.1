Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BB75A76D
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 09:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGTHL6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 03:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjGTHLd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 03:11:33 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6692733
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 00:10:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b89cfb4571so3408885ad.3
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 00:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689837026; x=1690441826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZiOti2rSZYWbFsWA6OHv4fYxFNp7o8241gPXk8Ck/Q=;
        b=rqU1Na7VrWUQpawH3Invx0ALCoQ5EFfYxLPqnwK3A/L0VIEaGb+v7XVDCSPackKODU
         gFrBwqx3Okco8wd+JryWSeAlRucEnQ0d8z4b1LF6imYrmyxuyTMN0dE+EPM0VTcGsuS4
         ftpjrdCsLvRlH9wRKyzsm3KJm/vWcgUlPEFxEUUG+iAE93WK2F7EOizrYlQzcSysy1dE
         /W2wnBOItOIYwPHZgcaLk+CbJS9TjXL8cAff4KvEUhRQrrlYLaEOmGrelMitXt7vnJ7J
         9F3UbRd3p9lz0vxh1zSUoBC4drAGM425pLyZrHavoo4Iw2Gt4BzLFcgdYg73FhcgNtNw
         3wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689837026; x=1690441826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZiOti2rSZYWbFsWA6OHv4fYxFNp7o8241gPXk8Ck/Q=;
        b=VU2K7F30RHzLgYIAPdLNDqd6t/F42FKcsiWIzD4PuWOeIHlDPg6NlqNzVjK4V8t5Yc
         smT2+JypwYBWSCtOZHXjlyu4VcqsSdyScnsT6988eCQUyGcDpBkJVjnqV2KbHxqpxfMH
         PSMbpd1dmzZPR/mwThCG45DfNWEqvYjvPubZ+OEcg3q2bOyxISeCVjlOTmY1K0ko/qtK
         g1Ctuch2A9zli57Ean5wwpbWCcqjgzPdozCNzWi1yIU2Hu0ZF830pbgVN190UgDJMidn
         NDNKrM3VdpsdAm3hCH+7NxW2utPt6U18Ov84NerJ9TMRc2cozwwrnrizIs8aZTSQk04R
         +7oA==
X-Gm-Message-State: ABy/qLZN8JijrIshUDpYuW7JPa4tZs14+gHEmilnKkvWUFIEu5dkYH26
        Zb+++jG09o3BnmlTU3dAoE0CqXx1Yj0=
X-Google-Smtp-Source: APBJJlEyvcd7oT4FKPciBjWLfXUhZlvCq1DIHB78hlMWM3DxEdynxfZ6AqxEaXV1TbFBqCDbR9CuNw==
X-Received: by 2002:a17:902:ea86:b0:1bb:3498:9caa with SMTP id x6-20020a170902ea8600b001bb34989caamr4586214plb.58.1689837026251;
        Thu, 20 Jul 2023 00:10:26 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm515821pld.13.2023.07.20.00.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:10:25 -0700 (PDT)
From:   tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To:     linux-mtd@lists.infradead.org
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        d-gole@ti.com, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/8] mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
Date:   Thu, 20 Jul 2023 16:09:57 +0900
Message-Id: <a8e94532d0d64631e6068845e29c4eea273b2871.1689836066.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689836065.git.Takahiro.Kuwano@infineon.com>
References: <cover.1689836065.git.Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

CFR2V[7] is assigned to Flash's address mode (3- or 4-ybte) and must not
be changed when writing MEMLAT (CFR2V[3:0]). CFR2V shall be used in a read,
update, write back fashion.

Fixes: c3266af101f2 ("mtd: spi-nor: spansion: add support for Cypress Semper flash")
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: stable@vger.kernel.org
---
 drivers/mtd/spi-nor/spansion.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index f40d4ede4093..8515f7e56715 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2014, Freescale Semiconductor, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/mtd/spi-nor.h>
 
@@ -28,6 +29,7 @@
 #define SPINOR_REG_CYPRESS_CFR2			0x3
 #define SPINOR_REG_CYPRESS_CFR2V					\
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR2)
+#define SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK	GENMASK(3, 0)
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3			0x4
@@ -161,8 +163,18 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
 	int ret;
 	u8 addr_mode_nbytes = nor->params->addr_mode_nbytes;
 
+	op = (struct spi_mem_op)
+		CYPRESS_NOR_RD_ANY_REG_OP(addr_mode_nbytes,
+					  SPINOR_REG_CYPRESS_CFR2V, 0, buf);
+
+	ret = spi_nor_read_any_reg(nor, &op, nor->reg_proto);
+	if (ret)
+		return ret;
+
 	/* Use 24 dummy cycles for memory array reads. */
-	*buf = SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
+	*buf &= ~SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK;
+	*buf |= FIELD_PREP(SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK,
+			   SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24);
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
 					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);
-- 
2.34.1

