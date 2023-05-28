Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB45713EA7
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjE1Thf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjE1The (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:37:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6DEEC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:37:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 068AB61E50
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267F8C433D2;
        Sun, 28 May 2023 19:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302650;
        bh=bF7lEOqT3yekHkyP14fUjvax/9aHSuMW7UK22MW/Nqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4b/t6CeTU6vph2xkFzGFHiDYqm/UNkfaUXLJY9dAnrPfGvxX/XJIauWGRt7CfoCZ
         ECSzpdkkTzPhnYGW6u7DqhtKMUllSs8Wm1oj+JJYe10qfE5be2wlx5nBBrw34vS1hj
         XxAPICT2Zkn3rTtCFfc+hHX+uJePLQAVTE12H3pg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 6.1 089/119] regulator: pca9450: Fix BUCK2 enable_mask
Date:   Sun, 28 May 2023 20:11:29 +0100
Message-Id: <20230528190838.506714676@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit d67dada3e2524514b09496b9ee1df22d4507a280 upstream.

This fixes a copy & paste error.
No functional change intended, BUCK1_ENMODE_MASK equals BUCK2_ENMODE_MASK.

Fixes: 0935ff5f1f0a ("regulator: pca9450: add pca9450 pmic driver")
Originally-from: Robin Gong <yibin.gong@nxp.com
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de
Link: https://lore.kernel.org/r/20230512081935.2396180-1-alexander.stein@ew.tq-group.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/pca9450-regulator.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -264,7 +264,7 @@ static const struct pca9450_regulator_de
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
@@ -502,7 +502,7 @@ static const struct pca9450_regulator_de
 			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
 			.vsel_mask = BUCK2OUT_DVS0_MASK,
 			.enable_reg = PCA9450_REG_BUCK2CTRL,
-			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_mask = BUCK2_ENMODE_MASK,
 			.ramp_reg = PCA9450_REG_BUCK2CTRL,
 			.ramp_mask = BUCK2_RAMP_MASK,
 			.ramp_delay_table = pca9450_dvs_buck_ramp_table,


