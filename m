Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001879AD0D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbjIKVOO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbjIKOp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:45:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5125812A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:45:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CD8C433C7;
        Mon, 11 Sep 2023 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443554;
        bh=92w0w1a/TXZMI9PT8llNX3hRwoDz2EtWaXlNivzP28E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oc0F+92ZEJbC7jy0fW1mgXrEEwFQkQBQurJbcYbI6V5NZDogF3v7Eva5cka3ALZln
         d+g473VgfUuonwjBhRPGwKXYPrkPdg8Tsd+65Ogo1snnF3z66lFt/Ga3Sdg1hsCHwd
         EhW34l0efFMmMglV2jXoqhilu9Y7Y2EgpwSsV9Hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Wronek <davidwronek@gmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 391/737] arm64: dts: qcom: msm8996: Fix dsi1 interrupts
Date:   Mon, 11 Sep 2023 15:44:10 +0200
Message-ID: <20230911134701.515153922@linuxfoundation.org>
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

From: David Wronek <davidwronek@gmail.com>

[ Upstream commit bd3b4ac11845b428996cfd2c7b8302ba6a07340d ]

Fix IRQ flags mismatch which was keeping dsi1 from probing by changing
interrupts = <4> to interrupts = <5>.

Fixes: 2752bb7d9b58 ("arm64: dts: qcom: msm8996: add second DSI interface")
Signed-off-by: David Wronek <davidwronek@gmail.com>
Acked-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230805130936.359860-2-davidwronek@gmail.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 157d2a2ec32ad..61da7fc281b32 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1075,7 +1075,7 @@ dsi1: dsi@996000 {
 				reg-names = "dsi_ctrl";
 
 				interrupt-parent = <&mdss>;
-				interrupts = <4>;
+				interrupts = <5>;
 
 				clocks = <&mmcc MDSS_MDP_CLK>,
 					 <&mmcc MDSS_BYTE1_CLK>,
-- 
2.40.1



