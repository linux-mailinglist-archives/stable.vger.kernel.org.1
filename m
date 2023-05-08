Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B574E6FA918
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjEHKrx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbjEHKrY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD622F6D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:46:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98287628DF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FA3C433EF;
        Mon,  8 May 2023 10:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542818;
        bh=4/r6S3nk3nNQWbXQ8F8pRY6MCg4DY4sR9acxwIW4fDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpM3C6/hq95zrTptp5P/k2WbcT6aFcVyKX0Phk6MB5m57qWriR6thMdCvdGvcTaU0
         HYU3dI9FFPqJsobZWSeluJ2Il8Ff4/ycnNGVMXbdPQKfK/PH2slBRBOFPYhv/xMNi+
         ZOsoLmHjVjnGD7dkvOanHYAl1htXjSkBUnLYgN9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 526/663] clk: qcom: gcc-qcm2290: Fix up gcc_sdcc2_apps_clk_src
Date:   Mon,  8 May 2023 11:45:52 +0200
Message-Id: <20230508094445.934131151@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 1bf088a9f0e50acd175ba8deef0db11c099fa26e ]

Add the PARENT_ENABLE flag to prevent  the clock from getting stuck
at boot and use floor_ops to avoid SDHCI overclocking.

Fixes: 496d1a13d405 ("clk: qcom: Add Global Clock Controller driver for QCM2290")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230315173048.3497655-1-konrad.dybcio@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-qcm2290.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-qcm2290.c b/drivers/clk/qcom/gcc-qcm2290.c
index 7792b8f237047..096deff2ba257 100644
--- a/drivers/clk/qcom/gcc-qcm2290.c
+++ b/drivers/clk/qcom/gcc-qcm2290.c
@@ -1243,7 +1243,8 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parents_12,
 		.num_parents = ARRAY_SIZE(gcc_parents_12),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
+		.flags = CLK_OPS_PARENT_ENABLE,
 	},
 };
 
-- 
2.39.2



