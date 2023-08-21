Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7E07832DD
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjHUUIw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjHUUIv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:08:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B79D131
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEBD564A4B
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEDEC433C8;
        Mon, 21 Aug 2023 20:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648528;
        bh=U+X3YHCDMSfutFfxTGuVSrLKdrjus8sxmRLfeDDWRo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snB/ekYsgFtGmRsP6/Wh0uUgmdkq27I22zLuSZ8iQFi7HcXQzYJBx3GGCloTT6Nwz
         GZheeSfoyTzUAS2Vsyn/0XeZssOvZRCi8A+cEZo1C8xgBCl4df8tLDzgy0A/78kOnC
         8d+RstGbHEWEeMY8FVpDPqdjeU1DEWYYeIgoPxVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 207/234] regulator: da9063: better fix null deref with partial DT
Date:   Mon, 21 Aug 2023 21:42:50 +0200
Message-ID: <20230821194138.014575590@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

commit 30c694fd4a99fbbc4115d180156ca01b60953371 upstream.

Two versions of the original patch were sent but V1 was merged instead
of V2 due to a mistake.

So update to V2.

The advantage of V2 is that it completely avoids dereferencing the pointer,
even just to take the address, which may fix problems with some compilers.
Both versions work on my gcc 9.4 but use the safer one.

Fixes: 98e2dd5f7a8b ("regulator: da9063: fix null pointer deref with partial DT config")
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Tested-by: Benjamin Bara <benjamin.bara@skidata.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230804083514.1887124-1-martin.fuzzey@flowbird.group
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/da9063-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index dfd5ec9f75c9..a0621665a6d2 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -778,9 +778,6 @@ static int da9063_check_xvp_constraints(struct regulator_config *config)
 	const struct notification_limit *uv_l = &constr->under_voltage_limits;
 	const struct notification_limit *ov_l = &constr->over_voltage_limits;
 
-	if (!config->init_data) /* No config in DT, pointers will be invalid */
-		return 0;
-
 	/* make sure that only one severity is used to clarify if unchanged, enabled or disabled */
 	if ((!!uv_l->prot + !!uv_l->err + !!uv_l->warn) > 1) {
 		dev_err(config->dev, "%s: at most one voltage monitoring severity allowed!\n",
@@ -1031,9 +1028,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			config.of_node = da9063_reg_matches[id].of_node;
 		config.regmap = da9063->regmap;
 
-		ret = da9063_check_xvp_constraints(&config);
-		if (ret)
-			return ret;
+		/* Checking constraints requires init_data from DT. */
+		if (config.init_data) {
+			ret = da9063_check_xvp_constraints(&config);
+			if (ret)
+				return ret;
+		}
 
 		regl->rdev = devm_regulator_register(&pdev->dev, &regl->desc,
 						     &config);
-- 
2.41.0



