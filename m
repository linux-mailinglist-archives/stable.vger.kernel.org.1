Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC36FA928
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbjEHKs5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235146AbjEHKsd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C51A12A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:47:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED41962836
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3444C433D2;
        Mon,  8 May 2023 10:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542867;
        bh=IZEgaRIaxIfcMamfLugvk7FgPFzcCz3PuZZj/kiup4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmNGGRORjLd3bKSN1bI/aOtbDVTLBFugH0nzqwpaTDkX6Lk/cp5N0Lfc7XJxV6DQ5
         y+jl9oZ44kZjgA7IG0CBTtWiEJvDmkHmR2Pxi6aSOsAbWkDpQI4tszDRXiBuaRExEV
         Xam0vbCtIBEmQ6agQ1wutxMYq7jDp03Xrfi6GimI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 557/663] clk: qcom: lpassaudiocc-sc7280: Add required gdsc power domain clks in lpass_cc_sc7280_desc
Date:   Mon,  8 May 2023 11:46:23 +0200
Message-Id: <20230508094447.212517897@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

[ Upstream commit aad09fc7c4a522892eb64a79627b17a3869936cb ]

Add GDSCs in lpass_cc_sc7280_desc struct.
When qcom,adsp-pil-mode is enabled, GDSCs required to solve
dependencies in lpass_audiocc probe().

Fixes: 0cbcfbe50cbf ("clk: qcom: lpass: Handle the regmap overlap of lpasscc and lpass_aon")
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230407092255.119690-4-quic_mohs@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/lpassaudiocc-sc7280.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/qcom/lpassaudiocc-sc7280.c b/drivers/clk/qcom/lpassaudiocc-sc7280.c
index 1339f9211a149..134eb1529ede2 100644
--- a/drivers/clk/qcom/lpassaudiocc-sc7280.c
+++ b/drivers/clk/qcom/lpassaudiocc-sc7280.c
@@ -696,6 +696,8 @@ static const struct qcom_cc_desc lpass_cc_sc7280_desc = {
 	.config = &lpass_audio_cc_sc7280_regmap_config,
 	.clks = lpass_cc_sc7280_clocks,
 	.num_clks = ARRAY_SIZE(lpass_cc_sc7280_clocks),
+	.gdscs = lpass_aon_cc_sc7280_gdscs,
+	.num_gdscs = ARRAY_SIZE(lpass_aon_cc_sc7280_gdscs),
 };
 
 static const struct qcom_cc_desc lpass_audio_cc_sc7280_desc = {
-- 
2.39.2



