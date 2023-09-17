Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994117A398F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240018AbjIQTu7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbjIQTuv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:50:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412CE7
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:50:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BEFC433C9;
        Sun, 17 Sep 2023 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980245;
        bh=XOTKxfj42CFeblWeB+0+qoA3/FNifzJPsH35X1RwJQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yAkU44BcMjJEoDCY18hhZhUGucmLbmJLqNC6VmS0ibphUjQZgQhaSRuGEwlpacOmg
         nnINqK42QwS+UeYiLgeY2YtsiqbkVV2c6PRabwGafNTlLw4T+Q6CN9+jUsqWCcty8J
         TfgYdzh5zbHUSm/yb+1DbTjMWsPY32KCEj47wfuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 099/285] regulator: tps6287x: Fix n_voltages
Date:   Sun, 17 Sep 2023 21:11:39 +0200
Message-ID: <20230917191055.109582420@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit c69290557c7571dff3d995fa27619b965915e8a1 ]

There are 256 possible voltage settings for each range, not 256 possible
voltage settings in total.

Fixes: 15a1cd245d5b ("regulator: tps6287x: Fix missing .n_voltages setting")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com
Link: https://lore.kernel.org/r/20230829-tps-voltages-v1-1-7ba4f958a194@axis.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/tps6287x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index b1c0963586ace..e45579a4498c6 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -119,7 +119,7 @@ static struct regulator_desc tps6287x_reg = {
 	.ramp_mask = TPS6287X_CTRL1_VRAMP,
 	.ramp_delay_table = tps6287x_ramp_table,
 	.n_ramp_values = ARRAY_SIZE(tps6287x_ramp_table),
-	.n_voltages = 256,
+	.n_voltages = 256 * ARRAY_SIZE(tps6287x_voltage_ranges),
 	.linear_ranges = tps6287x_voltage_ranges,
 	.n_linear_ranges = ARRAY_SIZE(tps6287x_voltage_ranges),
 	.linear_range_selectors = tps6287x_voltage_range_sel,
-- 
2.40.1



