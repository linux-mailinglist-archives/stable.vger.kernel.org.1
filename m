Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1137352AC
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjFSKhS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFSKg4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821F810F2
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0BA60B51
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C006C433C9;
        Mon, 19 Jun 2023 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171013;
        bh=wrssw8w20jDlCMNVfa6ZH8QXAyh84y8ElqIhudLW4l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQVsLWc3OjCL8yzwfM5g9iyRVX0EJswTiI1+nAjnurESK1jgtvHN3UWZyd6p599eZ
         L5LuIPiJX8ZC8eEqgZwKtz/HG100ONx+tws08mUPJse2VdT1e/zqQAU6jOFck8NeUB
         8X8JDMnkLvPOOngC+hlco+C1ONm0XtEPmWx8GZCs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Abel Vesa <abel.vesa@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 116/187] regulator: qcom-rpmh: Fix regulators for PM8550
Date:   Mon, 19 Jun 2023 12:28:54 +0200
Message-ID: <20230619102203.166843400@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit b00de0000a69579f4d730077fe3ea8ca31404255 ]

The PM8550 uses only NLDOs 515 and the LDO 6 through 8 are low voltage
type, so fix accordingly.

Fixes: e6e3776d682d ("regulator: qcom-rpmh: Add support for PM8550 regulators")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Link: https://lore.kernel.org/r/20230605115607.921308-1-abel.vesa@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 4c07ec15aff20..1e2455fc1967b 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1057,21 +1057,21 @@ static const struct rpmh_vreg_init_data pm8450_vreg_data[] = {
 };
 
 static const struct rpmh_vreg_init_data pm8550_vreg_data[] = {
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_pldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
 	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,    "vdd-l2-l13-l14"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,    "vdd-l3"),
-	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-l1-l4-l10"),
 	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,    "vdd-l5-l16"),
-	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo_lv, "vdd-l6-l7"),
-	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv, "vdd-l6-l7"),
-	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo_lv, "vdd-l8-l9"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo, "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo, "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo, "vdd-l8-l9"),
 	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,    "vdd-l8-l9"),
-	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo,    "vdd-l1-l4-l10"),
-	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,    "vdd-l11"),
+	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_nldo515,    "vdd-l1-l4-l10"),
+	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo515,    "vdd-l11"),
 	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo,    "vdd-l12"),
 	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,    "vdd-l2-l13-l14"),
 	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo,    "vdd-l2-l13-l14"),
-	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo,    "vdd-l15"),
+	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_nldo515,    "vdd-l15"),
 	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,    "vdd-l5-l16"),
 	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,    "vdd-l17"),
 	RPMH_VREG("bob1",   "bob%s1",  &pmic5_bob,     "vdd-bob1"),
@@ -1086,9 +1086,9 @@ static const struct rpmh_vreg_init_data pm8550vs_vreg_data[] = {
 	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps525_lv, "vdd-s4"),
 	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps525_lv, "vdd-s5"),
 	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps525_mv, "vdd-s6"),
-	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,   "vdd-l1"),
-	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,   "vdd-l2"),
-	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,   "vdd-l3"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,   "vdd-l1"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,   "vdd-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,   "vdd-l3"),
 	{}
 };
 
@@ -1101,9 +1101,9 @@ static const struct rpmh_vreg_init_data pm8550ve_vreg_data[] = {
 	RPMH_VREG("smps6", "smp%s6", &pmic5_ftsmps525_lv, "vdd-s6"),
 	RPMH_VREG("smps7", "smp%s7", &pmic5_ftsmps525_lv, "vdd-s7"),
 	RPMH_VREG("smps8", "smp%s8", &pmic5_ftsmps525_lv, "vdd-s8"),
-	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo,   "vdd-l1"),
-	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo,   "vdd-l2"),
-	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo,   "vdd-l3"),
+	RPMH_VREG("ldo1",  "ldo%s1", &pmic5_nldo515,   "vdd-l1"),
+	RPMH_VREG("ldo2",  "ldo%s2", &pmic5_nldo515,   "vdd-l2"),
+	RPMH_VREG("ldo3",  "ldo%s3", &pmic5_nldo515,   "vdd-l3"),
 	{}
 };
 
-- 
2.39.2



