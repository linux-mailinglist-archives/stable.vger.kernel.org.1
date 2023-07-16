Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5774755370
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjGPUTG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjGPUTG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:19:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A7AC0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:19:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB1A160EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A31C433C8;
        Sun, 16 Jul 2023 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538744;
        bh=kLTvxJc1uDb7VTx6/ZOdc/wyvbrfBrGbXRw+vJP+hv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMWs9IZOoQIzO+X60kNlSm67D+Q6q611s2nDDsCZw7zqTybfm/rVdo+aLEtEbNSkN
         v5qdPMl3UumW4mEG5kwDjVGPfqJFK5iGZwTMgHcD8VukMEkmHJcxHRZ37Sm25LdFN0
         qmUV/bLzBvXQg6sM5NpZ4hIfEZImcp+4/BHJZpzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 559/800] interconnect: qcom: rpm: Dont use clk_get_optional for bus clocks anymore
Date:   Sun, 16 Jul 2023 21:46:52 +0200
Message-ID: <20230716195002.073408858@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 1ff7aedcdcdd4fe02201269ab428b09491e5cf6e ]

Commit dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
relaxed the requirements around probing bus clocks. This was a decent
solution for making sure MSM8996 would still boot with old DTs, but
now that there's a proper fix in place that both old and new DTs
will be happy about, revert back to the safer variant of the
function.

Fixes: dd42ec8ea5b9 ("interconnect: qcom: rpm: Use _optional func for provider clocks")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230228-topic-qos-v8-7-ee696a2c15a9@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ec39861c1764c..8d3138e8c1ee3 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -494,7 +494,7 @@ int qnoc_probe(struct platform_device *pdev)
 	}
 
 regmap_done:
-	ret = devm_clk_bulk_get_optional(dev, qp->num_bus_clks, qp->bus_clks);
+	ret = devm_clk_bulk_get(dev, qp->num_bus_clks, qp->bus_clks);
 	if (ret)
 		return ret;
 
-- 
2.39.2



