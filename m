Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFAB75538A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjGPUUI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjGPUUH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA69C0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96EDF60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41F3C433C8;
        Sun, 16 Jul 2023 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538806;
        bh=UowwgpEwkT+uFVqkVPgYQjRJpRBSRfmaJHUk/KLsd0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKv1PnKUOW6NGEu6eC21hUi6ec/ueHKyqQqf/I9CcthGRMqN/sqwS/ce9ajVbcyP4
         afZ/+rcSyUuZIX3vpb8VTScJeg0rnoUWi/c+YmBfOm9Jx58JsrH6bW3siyrV1bZK9U
         XHDMUC7ksGTAiZ+u3xrCZFPtbsM+7TcCSATXssB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Devi Priya <quic_devipriy@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 582/800] clk: qcom: ipq5332: fix the order of SLEEP_CLK and XO clock
Date:   Sun, 16 Jul 2023 21:47:15 +0200
Message-ID: <20230716195002.603238366@linuxfoundation.org>
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

From: Kathiravan T <quic_kathirav@quicinc.com>

[ Upstream commit 7510e80f4ac707efc7e964120525ef759a02f171 ]

The order of DT_SLEEP_CLK and DT_XO are swapped and it is incorrect.
Due to which the clocks for which the parent should be XO is having parent
as SLEEP_CLK and vice versa. So fix the same by re-ordering the entries.

Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
Reported-by: Devi Priya <quic_devipriy@quicinc.com>
Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230417105607.4091-1-quic_kathirav@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-ipq5332.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
index b9ab67649130a..a75ab88ed14c6 100644
--- a/drivers/clk/qcom/gcc-ipq5332.c
+++ b/drivers/clk/qcom/gcc-ipq5332.c
@@ -20,8 +20,8 @@
 #include "reset.h"
 
 enum {
-	DT_SLEEP_CLK,
 	DT_XO,
+	DT_SLEEP_CLK,
 	DT_PCIE_2LANE_PHY_PIPE_CLK,
 	DT_PCIE_2LANE_PHY_PIPE_CLK_X1,
 	DT_USB_PCIE_WRAPPER_PIPE_CLK,
-- 
2.39.2



