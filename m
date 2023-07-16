Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3201C755592
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjGPUmR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjGPUmR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C266A4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:42:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBC8960EB8
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060BCC433C7;
        Sun, 16 Jul 2023 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540135;
        bh=PCQJoRyvc3R9c05aNNHl4zZ12+ROAwrohTuJcYOv/Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaVjPEm8l+7ymsIFrx8rkMJhZzt/9hFwyIKSeI7ga0DprPNBbypUjSU6IAHwB5uhZ
         8WOCPVbqXYiC/d0lhDcWTOLkvlj7M7IViurkmcbhgq1PVgf6jsYQV3qC65js7cy/R/
         3tKYQaJivWLJLZIayxsddloFJ4gzNnNDppsdqjXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 228/591] Input: pm8941-powerkey - fix debounce on gen2+ PMICs
Date:   Sun, 16 Jul 2023 21:46:07 +0200
Message-ID: <20230716194929.771150959@linuxfoundation.org>
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

From: Caleb Connolly <caleb.connolly@linaro.org>

[ Upstream commit 8c9cce9cb81b5fdc6e66bf3f129727b89e8daab7 ]

Since PM8998/PM660, the power key debounce register was redefined to
support shorter debounce times. On PM8941 the shortest debounce time
(represented by register value 0) was 15625us, on PM8998 the shortest
debounce time is 62us, with the default being 2ms.

Adjust the bit shift to correctly program debounce on PM8998 and newer.

Fixes: 68c581d5e7d8 ("Input: add Qualcomm PM8941 power key driver")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
Link: https://lore.kernel.org/r/20230529-pm8941-pwrkey-debounce-v1-2-c043a6d5c814@linaro.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/pm8941-pwrkey.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 549df01b6ee33..5dd68a02c4451 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -50,7 +50,10 @@
 #define  PON_RESIN_PULL_UP		BIT(0)
 
 #define PON_DBC_CTL			0x71
-#define  PON_DBC_DELAY_MASK		0x7
+#define  PON_DBC_DELAY_MASK_GEN1	0x7
+#define  PON_DBC_DELAY_MASK_GEN2	0xf
+#define  PON_DBC_SHIFT_GEN1		6
+#define  PON_DBC_SHIFT_GEN2		14
 
 struct pm8941_data {
 	unsigned int	pull_up_bit;
@@ -247,7 +250,7 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 	struct device *parent;
 	struct device_node *regmap_node;
 	const __be32 *addr;
-	u32 req_delay;
+	u32 req_delay, mask, delay_shift;
 	int error;
 
 	if (of_property_read_u32(pdev->dev.of_node, "debounce", &req_delay))
@@ -336,12 +339,20 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 	pwrkey->input->phys = pwrkey->data->phys;
 
 	if (pwrkey->data->supports_debounce_config) {
-		req_delay = (req_delay << 6) / USEC_PER_SEC;
+		if (pwrkey->subtype >= PON_SUBTYPE_GEN2_PRIMARY) {
+			mask = PON_DBC_DELAY_MASK_GEN2;
+			delay_shift = PON_DBC_SHIFT_GEN2;
+		} else {
+			mask = PON_DBC_DELAY_MASK_GEN1;
+			delay_shift = PON_DBC_SHIFT_GEN1;
+		}
+
+		req_delay = (req_delay << delay_shift) / USEC_PER_SEC;
 		req_delay = ilog2(req_delay);
 
 		error = regmap_update_bits(pwrkey->regmap,
 					   pwrkey->baseaddr + PON_DBC_CTL,
-					   PON_DBC_DELAY_MASK,
+					   mask,
 					   req_delay);
 		if (error) {
 			dev_err(&pdev->dev, "failed to set debounce: %d\n",
-- 
2.39.2



