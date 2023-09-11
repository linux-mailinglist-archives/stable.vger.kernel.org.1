Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FD079BF45
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbjIKVa6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbjIKOrJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:47:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6353B125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:47:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2F1C433C8;
        Mon, 11 Sep 2023 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443625;
        bh=I4mGcdF+k4T75ScZ9WYfWhu5zqw477iBlyeVqWSmOVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J0QPaGC90ULr8VqWFZXBtsCCMKfytAgjqmTrYdHlrxBR9tneeGCaEg6AsdeQ955eI
         T8+5mOFLPG03LLfuL0hShhtL8crUQ0VIKJu0zWLQXE++RESD3iGCp/i06HngAqRfbn
         c9m0dSyukJCs6QWpDxOnzu6bRGO26BlKfJ2YdCLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Imran Shaik <quic_imrashai@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 443/737] clk: qcom: gcc-qdu1000: Register gcc_gpll1_out_even clock
Date:   Mon, 11 Sep 2023 15:45:02 +0200
Message-ID: <20230911134702.971837545@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Imran Shaik <quic_imrashai@quicinc.com>

[ Upstream commit 06d71fa10f2e507444c6759328a6c19d38eab788 ]

gcc_gpll1_out_even clock is referenced as a parent, but not registered
with the clock framework. Hence add support to register the same.

Fixes: 1c9efb0bc040 ("clk: qcom: Add QDU1000 and QRU1000 GCC support")
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230803105741.2292309-5-quic_imrashai@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-qdu1000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-qdu1000.c b/drivers/clk/qcom/gcc-qdu1000.c
index 8df7b79839680..626c5afed7806 100644
--- a/drivers/clk/qcom/gcc-qdu1000.c
+++ b/drivers/clk/qcom/gcc-qdu1000.c
@@ -2521,6 +2521,7 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
 	[GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
 	[GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
 	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
+	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
 };
 
 static const struct qcom_reset_map gcc_qdu1000_resets[] = {
-- 
2.40.1



