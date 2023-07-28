Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56A0767290
	for <lists+stable@lfdr.de>; Fri, 28 Jul 2023 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjG1Q7a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Jul 2023 12:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjG1Q73 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Jul 2023 12:59:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB5F100
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 09:59:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe078dcc3aso9225285e9.2
        for <stable@vger.kernel.org>; Fri, 28 Jul 2023 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690563567; x=1691168367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPB6Zeg9uXKljdUTCujmlGSCtIgPff/6E7o4lT+WLLY=;
        b=A4qlcK5wsi1H/p3dUGzF7qhl8S1SS58cbJpGbIQ7zCqc6LV539c4j9eW5fu5qomPoA
         1d+zqKi0V9iPNDTArvF6aQUUNNqjXiyz4RYsL2BWhbZRAWo2GYIV6aDKe4aCi50y2Cew
         OHI/ONTP+GbnfW0YvLyJTqa7VUEIe1ifJ6dE9vanrxa/mk5Ih0H31npk47OcE4AJMtxb
         8SMPMTAzFkotx9dxeunylfsInKsplrMOyVNOT6trTOxgOsVYzmQDNZo+64rVqTXyqlsH
         RFQG7EiZRGPPvfNDowPSt+ISFWA0qmbyd0ig7Lm6soJiK+9FXSBBYrEws4N84LZPc+Y5
         Ps1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690563567; x=1691168367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPB6Zeg9uXKljdUTCujmlGSCtIgPff/6E7o4lT+WLLY=;
        b=Kw3umFHkBlDFX+7aud+O1wUq6YhGPn/H+R3nQSenHeCrAuHphgi0tpRATMWur/DMsB
         eFXJpJGvbi8i8E955rWg+WuboVa+tAhY36ZBgX2r+Mh9og86E6yNThfIDrgOvM/2bRSp
         RUbNHYWK0VtlM5slC78RhcVXm6dMNTbxjphTZwojoPUNBhc0SngP9lJKy3eRk4LM1EBu
         1fypqdxvAycZFrS6EN08CRiyofjcdf8JQ/BcUa9N6fAZgYWfWcA2lcJ39kaXi7hs8E0w
         5/0D1zycIKsRszj3rX6cC9MMtjansUeEfs/1hqnbQklqs3tuCdnpq3Q6VzyP8tgVeLlB
         QpBQ==
X-Gm-Message-State: ABy/qLZg7zrgVW+Z1qd5kMUCEVJLZNJJXmAxNLWrkZjZthhXawrc4eAk
        IKdqPkVkzWIrIM576J8sFb/tQA==
X-Google-Smtp-Source: APBJJlE4kigzGgz+YXKTvNYunKRWlL0qH+VsPevZCbjdnQuQYwII4IhJbeRelgw6a74DDnOgo7lLWA==
X-Received: by 2002:a1c:7712:0:b0:3f9:82f:bad1 with SMTP id t18-20020a1c7712000000b003f9082fbad1mr2284411wmi.40.1690563566826;
        Fri, 28 Jul 2023 09:59:26 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v24-20020a1cf718000000b003fc05b89e5bsm4532874wmh.34.2023.07.28.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:59:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH] dt-bindings: clock: xlnx,versal-clk: drop select:false
Date:   Fri, 28 Jul 2023 18:59:23 +0200
Message-Id: <20230728165923.108589-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

select:false makes the schema basically ignored and not effective, which
is clearly not what we want for a device binding.

Fixes: 352546805a44 ("dt-bindings: clock: Add bindings for versal clock driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
index e9cf747bf89b..04ea327d5313 100644
--- a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
@@ -14,8 +14,6 @@ description: |
   reads required input clock frequencies from the devicetree and acts as clock
   provider for all clock consumers of PS clocks.
 
-select: false
-
 properties:
   compatible:
     oneOf:
-- 
2.34.1

