Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB81B728289
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 16:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbjFHOVk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjFHOVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 10:21:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA562728
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 07:21:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5147f5efeb5so1203154a12.0
        for <stable@vger.kernel.org>; Thu, 08 Jun 2023 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686234096; x=1688826096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFkhR/nDDeZj3WU6Lo1Y6tuS2XYosQh6K+Nbpj2dhnU=;
        b=qxlisgdHqBeEhwNLBpWcPgpovCr6Y95mAfrZh87SswHzpMTNNzslwV3f2fT6fzmuqH
         LcbUF0BRW2XWlyJ7W6eHIN5VLrRZEVHA1nIbXm3Lh27vbcB2bdkylZ9uQ9YCbxEozAN3
         8+Gu6SCPI+apwJPWGiJjZCdTOXBDycrax4kgIEzCo69KcelqZMaEn5tzi2JfjlyIk/rO
         gxiHGz+FiQmwVW/VfOkadpvOBf9JLBopfol6/lMDJnA6z/fgbnD0wx4M7rMZ2fg9Q/q4
         0snRl1/McNlBNEZiHwK7amJDEVk/eZyxFjc4xF8xOOq1ua1OC2IXVomgesQja+jTLVBV
         7gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686234096; x=1688826096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFkhR/nDDeZj3WU6Lo1Y6tuS2XYosQh6K+Nbpj2dhnU=;
        b=irvwZXf+JyqWwtshmhslFjRqgzFKLw6R9VPEcN+K7UA+kXxntJ/hcBDGXprmYLWl03
         1+6D3Rfd10+7E67TKhvs+XSMN/fjiivL5izgjvkpeQ+w6UtNlbdyxfF5H3eQ5dFYRFHG
         N3PXquvGEYVtswAy8/4hp2d7j4RczpHFIBSO7PZh3bzxrNC+mvfeiOM38NTlduUMppHD
         mA8W5oMbPjEqhxsK+27URu+wNcwFPbDcEC1yRBsgLbkDxI5SE5NkyeC0fOoEFk6sL0Nu
         D9mSsvuvY36cfw3NdV2AAWKAVc3kclqr2AhAmTwzbdQRYV8lyiaS/oFbrqrKQT0fQNEm
         7/YQ==
X-Gm-Message-State: AC+VfDwVtYsuMoK77n0FQKSljAVdXRSH1h3KYKicOZUepqa4ORVLWyZ7
        1fXWEeKGy5OcIAwqRjlUWr7SEA==
X-Google-Smtp-Source: ACHHUZ7i7rJ4brnAidm+bbFk1+QBPpUKU7+0GYUHz0CLGipYiUtH1+5j5CMhK7fU+bULYsqiVWARfg==
X-Received: by 2002:a17:907:1c85:b0:96f:45cd:6c21 with SMTP id nb5-20020a1709071c8500b0096f45cd6c21mr11013812ejc.30.1686234096275;
        Thu, 08 Jun 2023 07:21:36 -0700 (PDT)
Received: from jerome-BL.. (192.201.68.85.rev.sfr.net. [85.68.201.192])
        by smtp.gmail.com with ESMTPSA id l8-20020a7bc448000000b003f42328b5d9sm2159912wmi.39.2023.06.08.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 07:21:35 -0700 (PDT)
From:   Jerome Neanne <jneanne@baylibre.com>
To:     linux-patch-review@list.ti.com
Cc:     s.sharma@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, jpanis@baylibre.com,
        khilman@baylibre.com, d-gole@ti.com, vigneshr@ti.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [tiL6.1-P PATCH] regulator: tps65219: fix matching interrupts for their regulators
Date:   Thu,  8 Jun 2023 16:21:32 +0200
Message-Id: <20230608142132.3728511-1-jneanne@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The driver's probe() first registers regulators in a loop and then in a
second loop passes them as irq data to the interrupt handlers.  However
the function to get the regulator for given name
tps65219_get_rdev_by_name() was a no-op due to argument passed by value,
not pointer, thus the second loop assigned always same value - from
previous loop.  The interrupts, when fired, where executed with wrong
data.  Compiler also noticed it:

  drivers/regulator/tps65219-regulator.c: In function ‘tps65219_get_rdev_by_name’:
  drivers/regulator/tps65219-regulator.c:292:60: error: parameter ‘dev’ set but not used [-Werror=unused-but-set-parameter]

Fixes: c12ac5fc3e0a ("regulator: drivers: Add TI TPS65219 PMIC regulators support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---

Notes:
    This is backport of upstream fix in TI mainline:
    Link: https://lore.kernel.org/all/20230507144656.192800-1-krzysztof.kozlowski@linaro.org/

 drivers/regulator/tps65219-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index 58f6541b6417..b0d8d6fed24d 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -289,13 +289,13 @@ static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
 
 static int tps65219_get_rdev_by_name(const char *regulator_name,
 				     struct regulator_dev *rdevtbl[7],
-				     struct regulator_dev *dev)
+				     struct regulator_dev **dev)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
 		if (strcmp(regulator_name, regulators[i].name) == 0) {
-			dev = rdevtbl[i];
+			*dev = rdevtbl[i];
 			return 0;
 		}
 	}
@@ -348,7 +348,7 @@ static int tps65219_regulator_probe(struct platform_device *pdev)
 		irq_data[i].dev = tps->dev;
 		irq_data[i].type = irq_type;
 
-		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
+		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, &rdev);
 		if (IS_ERR(rdev)) {
 			dev_err(tps->dev, "Failed to get rdev for %s\n",
 				irq_type->regulator_name);
-- 
2.34.1

