Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4D6FAAAB
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbjEHLF3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjEHLEr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C08C2FCE4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B8862A8E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00490C433EF;
        Mon,  8 May 2023 11:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543843;
        bh=8mocWvcvdUZ5ubZVj/0PhRFG63l020FS4oz1RSDbcT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z3ztvWT+vVilFMQQ/ciPRoz/+rztPYTs5HOjratb4mSWDrNPCPhB5JRgYRIiC0Dtk
         g8AkNWyEhJ+0ua+fMoqIX0F0HoTRfHsm9qm8tiu2jCtfFlJ4P+OlhvPnQGj2b9yT0l
         7gnmwU/9+IumTLouDc+MV4+DJI+yGQpUbBVqumJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 220/694] arm64: dts: qcom: sm8250-xiaomi-elish: fix USB maximum speed property
Date:   Mon,  8 May 2023 11:40:55 +0200
Message-Id: <20230508094439.497814437@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 613f14a3a9d7e12a832ff822f85a33ad0ebee952 ]

Fix typo in USB DWC3 node maximum speed property.

Fixes: a41b617530bf ("arm64: dts: qcom: sm8250: Add device tree for Xiaomi Mi Pad 5 Pro")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230304130315.51595-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
index a85d47f7a9e82..7d2e18f3f432e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
@@ -595,7 +595,7 @@
 
 &usb_1_dwc3 {
 	dr_mode = "peripheral";
-	maximum-spped = "high-speed";
+	maximum-speed = "high-speed";
 	/* Remove USB3 phy */
 	phys = <&usb_1_hsphy>;
 	phy-names = "usb2-phy";
-- 
2.39.2



