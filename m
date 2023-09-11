Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3A179C075
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355477AbjIKWAB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbjIKPRL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:17:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24271FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:17:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E85DC433C7;
        Mon, 11 Sep 2023 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445426;
        bh=kptVLudJ3aSCT33N/3xHBsj76JDqQe9fAOsoCHCL9DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Khk/cUINr5Qplx6LY0QVjagGiG0KYBO1njXMA9RZ31KuSOAx6bTSkdhsy8prj/Uae
         MpJiNAtPLJpGlcUx7JCqj6joya2FCj0shpOfvr2rzKrcAPWs5pZVKc6xQ1UMxzLuHC
         KYoaiauPjuwnx+2GDApnOv2Q/IYW1owcOIVIDDKo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan ODonoghue <bryan.odonoghue@linaro.org>,
        Patrick Whewell <patrick.whewell@sightlineapplications.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 344/600] clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src
Date:   Mon, 11 Sep 2023 15:46:17 +0200
Message-ID: <20230911134643.842985910@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Whewell <patrick.whewell@sightlineapplications.com>

[ Upstream commit 783cb693828ce487cf0bc6ad16cbcf2caae6f8d9 ]

GPLL9 is not on by default, which causes a "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error when booting. Set .flags =
CLK_OPS_PARENT_ENABLE to fix the error.

Fixes: 3e5770921a88 ("clk: qcom: gcc: Add global clock controller driver for SM8250")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Patrick Whewell <patrick.whewell@sightlineapplications.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Link: https://lore.kernel.org/r/20230802210359.408-1-patrick.whewell@sightlineapplications.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sm8250.c b/drivers/clk/qcom/gcc-sm8250.c
index a0ba37656b07b..30bd561461074 100644
--- a/drivers/clk/qcom/gcc-sm8250.c
+++ b/drivers/clk/qcom/gcc-sm8250.c
@@ -721,6 +721,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_4,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.40.1



