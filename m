Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2738178891F
	for <lists+stable@lfdr.de>; Fri, 25 Aug 2023 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245306AbjHYNza (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 25 Aug 2023 09:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbjHYNzW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 25 Aug 2023 09:55:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E04213E
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 06:55:19 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5236b2b4cdbso1435803a12.3
        for <stable@vger.kernel.org>; Fri, 25 Aug 2023 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692971718; x=1693576518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4OQDi/sFthYDrzyBFtYWst4OZy6IfZiLAmOykugLGc=;
        b=VbIOoeFjX1650zgbcbcJkTrwyzmUHlArVvfCWsJv2batLsxPCO5RBOJQpwpx09DC5H
         qETI1jIlm/k5Hs79WLxD/xiuy+Kx82UL676gRPwRpq9hyK+mErKI8IgkM1Ab2gxJ7tmI
         iu8LJxVt+Y+ZRCzQv6T2eCAv/ljYj/JV52kkU8Q1APv9LyRkhYEVpsG1sbEM5eoaCQLz
         WPuFdYq5vPfDUFL/sg9Pj4bfDHjEKDt1nVdPcgd5DcVuH0I3/wxZewumtSDltzQfwrEr
         NeG3TRQq2lFKka1ShA7rjrFVzQdEFqEfk2MRYyRMqXh9Bh6Z1Eie+9CdFBc/0t3atYB7
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971718; x=1693576518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4OQDi/sFthYDrzyBFtYWst4OZy6IfZiLAmOykugLGc=;
        b=Oc39g0pHjKVRTQF9nRGwhmUmPXKcTUWfXk0aZN2xZYUfJYhSbVoGFbXWux+nLZSYT9
         tmtXT8piz4MMa0dqKogozb9n4JiEUxtYETCUfJQhKk49yeHTBX/dK0EBs9VSZjisGoc2
         bYoDxpuSFBTIHPNr6XJNg395WcRUl1H9gixym97D/1JTYlMNdL7cfkauzYGM5PMgTERf
         O6jFJMdheTOU6ibhJz/PdS/7bpVgc6HZaT04mO9h5/7F+rE5YUO2I6BPf3zDhLDtebWX
         N+2viOvPsqXSUVLLd9dXil8ZrtvKX5kqb0751uP00noofw+ewkKSu3E13tcuDt0xDwji
         1g6w==
X-Gm-Message-State: AOJu0Yytc6QziLkrQLJWy7DyzbpyL70qui6/7JQdr/yghy5zKmNHC4Fm
        o7/Qkt4jdAoTqpOfruXbAuVM9w==
X-Google-Smtp-Source: AGHT+IEkq63It/ry4mHQBYS8/cIH56V4AtHcFAdvj4JI6BUGBIs0N+ChYGqXiI/ZpYr2vi7ZdEq1pQ==
X-Received: by 2002:aa7:d952:0:b0:523:ae0a:a447 with SMTP id l18-20020aa7d952000000b00523ae0aa447mr15361501eds.13.1692971718331;
        Fri, 25 Aug 2023 06:55:18 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7d615000000b005256aaa6e7asm1019660edr.78.2023.08.25.06.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:55:17 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: correct minimum number of clocks
Date:   Fri, 25 Aug 2023 15:55:02 +0200
Message-Id: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In the TXT binding before conversion, the "xo" clock was listed as
optional.  Conversion kept it optional in "clock-names", but not in
"clocks".  This fixes dbts_check warnings like:

  qcom-sdx65-mtp.dtb: mmc@8804000: clocks: [[13, 59], [13, 58]] is too short

Cc: <stable@vger.kernel.org>
Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to yaml")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 80141eb7fc6b..10f34aa8ba8a 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -69,7 +69,7 @@ properties:
     maxItems: 4
 
   clocks:
-    minItems: 3
+    minItems: 2
     items:
       - description: Main peripheral bus clock, PCLK/HCLK - AHB Bus clock
       - description: SDC MMC clock, MCLK
-- 
2.34.1

