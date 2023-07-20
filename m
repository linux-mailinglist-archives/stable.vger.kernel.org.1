Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE3C75AD7A
	for <lists+stable@lfdr.de>; Thu, 20 Jul 2023 13:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjGTLx6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 20 Jul 2023 07:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjGTLxv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 20 Jul 2023 07:53:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553781705
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 04:53:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99364ae9596so127208166b.1
        for <stable@vger.kernel.org>; Thu, 20 Jul 2023 04:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689854025; x=1690458825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXcLrziLtHnshw8zPX9D7poqnSp9AC67qEwkCzePKg0=;
        b=Z//YvlCPez7mOac5kzkyL+oyVbxJ9K/xeSNPLeSZe3V48sxa8duQQqzrzyP0fFiIcF
         902ZQ7pmG5gdtIp/yYo3jcrmpgyq7eXrrHrBbaLQcdmq+HAreH/Wvfv2ZMy19BHNzJME
         WbZS8bJmkhzgGvfteEPlZ7aDuvzi1yAZewggKaamNbenpNRB/0Daw6rEph2JhO8xCYgl
         6bmwHUmYs7SXBgINITi2ao+IZgF7rM1yP/8/U+nk3DLEsS0aaTX8so7Edf3uyMQdKby2
         hXvrCjcuQjqcUY8j7KLv/6IIfbRKdT9ezWEzdVO8ftFauVSjxY9GlubHJKOgZhlBIl8p
         mT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689854025; x=1690458825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXcLrziLtHnshw8zPX9D7poqnSp9AC67qEwkCzePKg0=;
        b=EGmi1jODBPU6DE+5UGJUsJhnzroGBwRHlN8u9imPPl4hJsZx8GqltX18VzyQF6NSqI
         AzQ4PNd84G16W2VVqvhmmN+al0DzqEcw2G7gGlObKfaaIwprSyG4OvGlIA7Y/PNsRzvK
         UAD5jaVBOcqsnxIAIz5fDtsE56xuYhAMHViZfCThc0eY9+T+M0+2Z5UNx5FhXZibOQQs
         DButjGFi+wyrmrb1g4OG0ov3fBlFcFuUNkzoALqK8YTjr5Np2M8uC0HAwbf3818jJodp
         NixDSPznXE7gGKPZnYSsjKwz51dx7jdZDDgH775cmyczUsrTsWpbMeSeSWQ5Dtm/gqQ9
         a/VA==
X-Gm-Message-State: ABy/qLZubLPkmjIG2xnoNYn/aOEg2fr+zA2gF0vC40HFtCjlnwRAzJ7s
        KHLNep3qJrx49nLjYz7qTH/Xxw==
X-Google-Smtp-Source: APBJJlF0vrPscthV/oeuC4Zsd5wylTCllvaTJodEEnsC+uGGcCLg3lw1wva6igh6GaO0aySnxGV7WQ==
X-Received: by 2002:a17:906:7e5a:b0:974:55a2:cb0b with SMTP id z26-20020a1709067e5a00b0097455a2cb0bmr4187059ejr.55.1689854025775;
        Thu, 20 Jul 2023 04:53:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id qp7-20020a170907206700b00992b66e54e9sm587758ejb.214.2023.07.20.04.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 04:53:45 -0700 (PDT)
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
Subject: [PATCH 4/6] ARM: dts: qcom: msm8974pro-castor: correct inverted X of touchscreen
Date:   Thu, 20 Jul 2023 13:53:33 +0200
Message-Id: <20230720115335.137354-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
References: <20230720115335.137354-1-krzysztof.kozlowski@linaro.org>
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

There is no syna,f11-flip-x property, so assume intention was to use
touchscreen-inverted-x.

Fixes: ab80661883de ("ARM: dts: qcom: msm8974: Add Sony Xperia Z2 Tablet")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 154639d56f35..c41e25367bc9 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -132,8 +132,8 @@ rmi-f01@1 {
 
 		rmi-f11@11 {
 			reg = <0x11>;
-			syna,f11-flip-x = <1>;
 			syna,sensor-type = <1>;
+			touchscreen-inverted-x;
 		};
 	};
 };
-- 
2.34.1

