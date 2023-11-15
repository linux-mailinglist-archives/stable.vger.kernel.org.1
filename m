Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782C87ECE2B
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbjKOTlS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbjKOTlS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:41:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B5AA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:41:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57B0C433C8;
        Wed, 15 Nov 2023 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077275;
        bh=usAA9rnf+nmUcV08udiBgAAY8hYpy6uzY2IvVBZHKyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJeP5IQEMowG9ZKvd+7+3Gq2FIRK2oMA+MC7Wu0lYOwVFI0NqwOESWb02yPvIOu+h
         6oJtnEiRjFp8nk85ci7QZduUy6a9uRYKcJL2Tla30mm3Wk2D1smxFJAtfO1BSiKGjL
         i8k96/W3IZmInv6OcvPqZVkMg6I+qXROZ/lu4+lg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abel Vesa <abel.vesa@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 202/603] regulator: qcom-rpmh: Fix smps4 regulator for pm8550ve
Date:   Wed, 15 Nov 2023 14:12:27 -0500
Message-ID: <20231115191627.234300764@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit bc00d9f3813a40bc2d854ae0edab14c6b43a3219 ]

The type of the smps4 regulator from pm8550ve is actually FTSMPS525
medium voltage. So fix it accordingly.

Fixes: e6e3776d682d ("regulator: qcom-rpmh: Add support for PM8550 regulators")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20231024134626.2364426-1-abel.vesa@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index d990ba19c50eb..b2e359ac31693 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1095,7 +1095,7 @@ static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
 	RPMH_VREG("smps1", "smp%s1", &pmic5_ftsmps525_lv, "vdd-s1"),
 	RPMH_VREG("smps2", "smp%s2", &pmic5_ftsmps525_lv, "vdd-s2"),
 	RPMH_VREG("smps3", "smp%s3", &pmic5_ftsmps525_lv, "vdd-s3"),
-	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_lv, "vdd-s4"),
+	RPMH_VREG("smps4", "smp%s4", &pmic5_ftsmps525_mv, "vdd-s4"),
 	RPMH_VREG("smps5", "smp%s5", &pmic5_ftsmps525_lv, "vdd-s5"),
 	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
 	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
-- 
2.42.0



