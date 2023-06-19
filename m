Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D436B7352AB
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjFSKhP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjFSKgx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFD310E0
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55A7D60B51
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69134C433C0;
        Mon, 19 Jun 2023 10:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171010;
        bh=Olwgj9eY2SNfH3XHF3SH4Qps8YjLfnS5iSIB3vQxqLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFu8DseA3RXeYkaeRCs6pYg/EXfL1eCooiok7OXOyFjeLBQLkUb6gBZxksn5dGNHh
         LQ0cLLSbNWSOlichCyh2OjBGpVHvBozsMN+BK7lheTzNxMKUVT1/oF9if4le0glC9C
         SCOETST3bLfOVvSaRGWuZljZqMLcq8hm2jpdS5tk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 115/187] regulator: qcom-rpmh: add support for pmm8654au regulators
Date:   Mon, 19 Jun 2023 12:28:53 +0200
Message-ID: <20230619102203.123653658@linuxfoundation.org>
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 65f1b1dc0cc90236ed9be3970f4a763e853f3aab ]

Add the RPMH regulators exposed by the PMM8654au PMIC and its variants.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230406192811.460888-3-brgl@bgdev.pl
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: b00de0000a69 ("regulator: qcom-rpmh: Fix regulators for PM8550")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 55 +++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index ae6021390143c..4c07ec15aff20 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -694,6 +694,16 @@ static const struct rpmh_vreg_hw_data pmic5_pldo_lv = {
 	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_pldo515_mv = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(1800000, 0, 187, 8000),
+	.n_voltages = 188,
+	.hpm_min_load_uA = 10000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_nldo = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_drms_ops,
@@ -704,6 +714,16 @@ static const struct rpmh_vreg_hw_data pmic5_nldo = {
 	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_nldo515 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_drms_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 210, 8000),
+	.n_voltages = 211,
+	.hpm_min_load_uA = 30000,
+	.pmic_mode_map = pmic_mode_map_pmic5_ldo,
+	.of_map_mode = rpmh_regulator_pmic4_ldo_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_hfsmps510 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
@@ -749,6 +769,15 @@ static const struct rpmh_vreg_hw_data pmic5_ftsmps525_mv = {
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_ftsmps527 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(320000, 0, 215, 8000),
+	.n_voltages = 215,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_ops,
@@ -937,6 +966,28 @@ static const struct rpmh_vreg_init_data pmm8155au_vreg_data[] = {
 	{}
 };
 
+static const struct rpmh_vreg_init_data pmm8654au_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps527,  "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps527,  "vdd-s2"),
+	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps527,  "vdd-s3"),
+	RPMH_VREG("smps4",  "smp%s4",  &pmic5_ftsmps527,  "vdd-s4"),
+	RPMH_VREG("smps5",  "smp%s5",  &pmic5_ftsmps527,  "vdd-s5"),
+	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps527,  "vdd-s6"),
+	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps527,  "vdd-s7"),
+	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps527,  "vdd-s8"),
+	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps527,  "vdd-s9"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo515,    "vdd-s9"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo515,    "vdd-l2-l3"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo515,    "vdd-l2-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo515,    "vdd-s9"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo515,    "vdd-s9"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo515,    "vdd-l6-l7"),
+	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_nldo515,    "vdd-l6-l7"),
+	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_pldo515_mv, "vdd-l8-l9"),
+	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_pldo,       "vdd-l8-l9"),
+	{}
+};
+
 static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
@@ -1431,6 +1482,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pmm8155au-rpmh-regulators",
 		.data = pmm8155au_vreg_data,
 	},
+	{
+		.compatible = "qcom,pmm8654au-rpmh-regulators",
+		.data = pmm8654au_vreg_data,
+	},
 	{
 		.compatible = "qcom,pmx55-rpmh-regulators",
 		.data = pmx55_vreg_data,
-- 
2.39.2



