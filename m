Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A642A72BEE3
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjFLK0m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjFLK0W (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:26:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D035767
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:05:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-65292f79456so3115128b3a.2
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686564274; x=1689156274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0VY0Q3ApyLxdpEDzILGqzd2oQcIxU2jFNLg6s5sntM=;
        b=FHM/3MaciLF7PBJkC0YSctJxq6oQ4DCE98r/ko0iF9WXnPjMRZai7eOKEQU4xGG9Zs
         M45npj6SBvjE9usRpW/cqGXbFyYjNMOuy/M2XSSZUfYq4Mn7XjrCub9+AeI8aG6LLXij
         FMRbFyZkuqkNxl6zHiuUSGoEr/apW9ykjHUbvY4IBtxnjJD1kGIok+sHlAB9tsnZV/HU
         xoqhgAKMZKbqZJkY6NtwH/BqOtn55KuWa1kqIF+fSfvLi42x3xY8vrJhuxL6+Vj7K84G
         2XyjbaHSxzS+CpHzeKlLm4jq7fgoAp7uWDxgoqfAQL2tZEizqFT+hOaC6RYgCM50tMDL
         KFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686564274; x=1689156274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0VY0Q3ApyLxdpEDzILGqzd2oQcIxU2jFNLg6s5sntM=;
        b=RVc+jm831kB+HQIhnzYP2Cjo8WjP9Er+Vz7CzE1SgZX2+lXWeYKlVa9we4w/NKOkwz
         GspxzhpD5MlR5q8pA7U5u1xaWRS5O1e0lme+6l4NpaP+mpdVLZw7vq9WQdBixeeypAP0
         GmBts12Satq3MVRxOTfrRV/onAraCQML04GURzdhtMHlXAXn6R9rT51we/6X/0qkWQJ/
         WZzUfX7sbOKBVjmLMAKogsi8mb4d2HLTla+tbh0JSZ363pvrXa3Q0He6hWc9xh2tVIw8
         yfBNhzMXGDzGy2BLmlrsICs/VoZqWAfTLk+KxCL+Rpoeccb9cW8+AqZ+oAhcfpR80twn
         KPnw==
X-Gm-Message-State: AC+VfDywjb3aW0EkAZm1W+Na8kNUD663TwphijqMBICvac3QvFuHFAD+
        bsSc2mJZ4fC+ebUUHI/9IrI=
X-Google-Smtp-Source: ACHHUZ7TEN4loybZyX3QyPSzRRQQ3AMVpukZNADpZz5u0fwFg1RN3L2Xl+tuS7Bx7Cof7VS8p/tlTQ==
X-Received: by 2002:a05:6a00:2d88:b0:652:bf4c:b5de with SMTP id fb8-20020a056a002d8800b00652bf4cb5demr9509909pfb.20.1686564274449;
        Mon, 12 Jun 2023 03:04:34 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79211000000b00662610cf7a8sm6723376pfo.172.2023.06.12.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:04:34 -0700 (PDT)
From:   tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To:     linux-mtd@lists.infradead.org
Cc:     tudor.ambarus@linaro.org, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        d-gole@ti.com, tkuw584924@gmail.com, Bacem.Daassi@infineon.com,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/5] mtd: spi-nor: spansion: Preserve CFR2V[7] when writing MEMLAT
Date:   Mon, 12 Jun 2023 19:04:05 +0900
Message-Id: <15d87d29e53945739e7c2b3f58e2f623e2a77f08.1686557139.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1686557139.git.Takahiro.Kuwano@infineon.com>
References: <cover.1686557139.git.Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

CFR2V[7] is assigned to Flash's address mode (3- or 4-ybte) and must not
be changed when writing MEMLAT (CFR2V[3:0]). CFR2V must be read first,
modified only CFR2V[3:0], then written back.

Fixes: c3266af101f2 ("mtd: spi-nor: spansion: add support for Cypress Semper flash")
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Cc: stable@vger.kernel.org
---
 drivers/mtd/spi-nor/spansion.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index f2f4bc060f5e..7804be3a9f2a 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -27,6 +27,7 @@
 #define SPINOR_REG_CYPRESS_CFR2			0x3
 #define SPINOR_REG_CYPRESS_CFR2V					\
 	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR2)
+#define SPINOR_REG_CYPRESS_CFR2_MEMLAT_MASK	GENMASK(3, 0)
 #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
 #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
 #define SPINOR_REG_CYPRESS_CFR3			0x4
@@ -162,8 +163,17 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
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
+	*buf |= SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24;
 	op = (struct spi_mem_op)
 		CYPRESS_NOR_WR_ANY_REG_OP(addr_mode_nbytes,
 					  SPINOR_REG_CYPRESS_CFR2V, 1, buf);
-- 
2.34.1

