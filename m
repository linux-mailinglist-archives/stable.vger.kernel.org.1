Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF40F75AD6E
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGTLxn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 07:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGTLxm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 07:53:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22FDE4C
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 04:53:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso125729366b.3
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 04:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689854019; x=1690458819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=osOeIRkPl5bwotwbn2o0ova+vF1/doKY3VxZgsCroY4=;
        b=CrJcEsBiDv/lK0Cxe4k5PSDjDRlH3jgQHQwnFDsOnJbhgJkeXgecYtU+hvmhEw8SHM
         SaAtfGvI3DdvJrn+PTdMqksLGzCxf4jWhzS2bvK3u/F+V4MN/gihxXxIm4gukHLN0dJh
         523UhuCKkSDmfmMzS7fmXEKhGxyZ4EOVAR7fozV/+XA+APgfDeIdbPriL7+rvfJSxz7v
         GstBL+2AOiL8bwWBFtaWQ0Vx8oRWdYojDxIDyE8PT9TN37262nqlwiLC82T3yPbnRMD4
         f78Vz+uRKGd1mqOG1XSEKuI2XPX4laRVODgZYS1jZasFYeJD96inz5R21wuHom4VKFZA
         j5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854019; x=1690458819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osOeIRkPl5bwotwbn2o0ova+vF1/doKY3VxZgsCroY4=;
        b=f4F4pJzVx399f7LPprDOADlRiSNpG16BWTEF64A13YWPAS40P9uwF4lts2tn/JBj0w
         Dv9xjgEJqXYptNWGUFkjbGq7BS+b3U5z+ru9NcZx+9zs27u4vQz2dVkFUsbujCKTLyJR
         N1liBp7kG9W6GAwSx2Qbe8OW4OH89c4hqHdIh/8HUMhg7HWARul4fvjGQfkm7jMsIjxJ
         BNwZw8KzzAoz3OEEcw8+O4x5BAft3HXJZrh5mq+m+lfp0ykRxp+DY2VhwZqY+q0f4KCi
         JwwDEfLacTK4AK3RGVLrxq2Ef1mo1PPD34lkwUNrihggsW4CF/KgBJRUBvstwt0QRFrU
         03JA==
X-Gm-Message-State: ABy/qLbI16Bf0zQT1iH9fFiLv2zWjydksgCuub89mbLZsk+3YN8zntXA
        n8CIsJa7HhqgA/A49pNoclQxuA==
X-Google-Smtp-Source: APBJJlEjR9X1dO5vInrjyggUEFbzzVciWKz2wL5d0cDJB5Ywon2Yy3KLBgJiaRMgHMNBP/nMW5R81g==
X-Received: by 2002:a17:906:530c:b0:992:91ce:4509 with SMTP id h12-20020a170906530c00b0099291ce4509mr4083546ejo.57.1689854019285;
        Thu, 20 Jul 2023 04:53:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b00992b66e54e9sm587758ejb.214.2023.07.20.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:53:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gianluca Boiano <morf3089@gmail.com>,
        Eugene Lepshy <fekz115@gmail.com>, Luca Weiss <luca@z3ntu.xyz>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/6] arm64: dts: qcom: msm8953-vince: drop duplicated touschreen parent interrupt
Date:   Thu, 20 Jul 2023 13:53:30 +0200
Message-Id: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Interrupts extended already define a parent interrupt controller:

  msm8953-xiaomi-vince.dtb: touchscreen@20: Unevaluated properties are not allowed ('interrupts-parent' was unexpected)

Fixes: aa17e707e04a ("arm64: dts: qcom: msm8953: Add device tree for Xiaomi Redmi 5 Plus")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
index 0956c866d6cb..1a1d3f92a511 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts
@@ -132,7 +132,6 @@ &i2c_3 {
 	touchscreen@20 {
 		reg = <0x20>;
 		compatible = "syna,rmi4-i2c";
-		interrupts-parent = <&tlmm>;
 		interrupts-extended = <&tlmm 65 IRQ_TYPE_EDGE_FALLING>;
 
 		#address-cells = <1>;
-- 
2.34.1

