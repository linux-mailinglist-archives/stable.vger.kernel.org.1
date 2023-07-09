Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF6374C305
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjGIL1U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjGIL1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4FC0
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B188960C01
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:27:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF16C433C9;
        Sun,  9 Jul 2023 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902038;
        bh=75/PENnJQurpQEeV0E6sOjQokwS3+3Z8XpXyhIwANY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ynXfPFoz6wYvZVd6kH7JufTpAlEe/f0DWRcoN7SYG+z/a637/W9NLMRtRGBrsGAMw
         ZE58tzkfL+EACcklqYcPnYOQvrBcp5pea40vqFFau9ToldzeGKYjsFWPrgeTtjVh0N
         2OIgU0SdiiNp12hdiQM+DSBQLcHyfvCwNgEjUhDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 233/431] arm64: dts: qcom: sdm630: correct camss unit address
Date:   Sun,  9 Jul 2023 13:13:01 +0200
Message-ID: <20230709111456.626622811@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c8b7faa7e9913a94444b3f00b6480e53a174fcfd ]

Match unit-address to reg entry to fix dtbs W=1 warnings:

  Warning (simple_bus_reg): /soc/camss@ca00000: simple-bus unit address format error, expected "ca00020"

Fixes: f3d5d3cc6971 ("arm64: dts: qcom: sdm630: Configure the camera subsystem")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230419211856.79332-10-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 5827cda270a0e..07c720c5721d4 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -1893,7 +1893,7 @@ pil-reloc@94c {
 			};
 		};
 
-		camss: camss@ca00000 {
+		camss: camss@ca00020 {
 			compatible = "qcom,sdm660-camss";
 			reg = <0x0ca00020 0x10>,
 			      <0x0ca30000 0x100>,
-- 
2.39.2



