Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5075570D
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjGPU4w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjGPU4v (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB15E73
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD83760E9E
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4E1C433C7;
        Sun, 16 Jul 2023 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689541005;
        bh=7rEibQ5YmuAqqDQYxCbxtVddeAgT4Zv5EKxTXfHNkII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtOFMYOhg6ieN+NDK7+2k3BQQtDe/sJhNliH3ZziF6JxcVVcdWmtt9lKW0xVDdJTo
         EkSYGUMGKmoc2pKnrZjTzT1q99/Wv3IgKHF53sLbLDb/ZdpfplVf0NSZ0Z3SwZ9XQe
         2Sok7VFyrPRKDpvX+jmB5ODIdBXztzdluW52Qtu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 6.1 566/591] regulator: tps65219: Fix matching interrupts for their regulators
Date:   Sun, 16 Jul 2023 21:51:45 +0200
Message-ID: <20230716194938.501910849@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit f050e56de80591fee55bedbdf5b6b998c740cd0c upstream.

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
Cc: <stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com
Link: https://lore.kernel.org/r/20230507144656.192800-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/tps65219-regulator.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -289,13 +289,13 @@ static irqreturn_t tps65219_regulator_ir
 
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
@@ -348,7 +348,7 @@ static int tps65219_regulator_probe(stru
 		irq_data[i].dev = tps->dev;
 		irq_data[i].type = irq_type;
 
-		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, rdev);
+		tps65219_get_rdev_by_name(irq_type->regulator_name, rdevtbl, &rdev);
 		if (IS_ERR(rdev)) {
 			dev_err(tps->dev, "Failed to get rdev for %s\n",
 				irq_type->regulator_name);


