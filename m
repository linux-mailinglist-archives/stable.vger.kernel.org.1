Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29E5713E33
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjE1TdC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjE1Tc7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8019C9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8438461DC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F44FC433EF;
        Sun, 28 May 2023 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302378;
        bh=bF7lEOqT3yekHkyP14fUjvax/9aHSuMW7UK22MW/Nqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=be9v79+sCoatN0CnJFGYXhmCP4CJutPDNsfGMhw5ZwaWb4AIukpZJwbimrxktlpzN
         pZcofehUJXCpvil+DZtoRhh1sO245KZnzbQfh6LXNw3DZF7P792FwzQAQ5Ttvfrcv0
         iuo721c+StNJ+GExXD1GUwPafdXDtFTNA5yEb/Jo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 6.3 093/127] regulator: pca9450: Fix BUCK2 enable_mask
Date:   Sun, 28 May 2023 20:11:09 +0100
Message-Id: <20230528190839.340441387@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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


