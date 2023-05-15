Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B5270380B
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244217AbjEOR05 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbjEOR0f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:26:35 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFA812083;
        Mon, 15 May 2023 10:25:16 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 711ED86065;
        Mon, 15 May 2023 19:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684171511;
        bh=XV+2Gebwur2daq+O9s5byj0Uz04kWhlx7VGxC+IjJ6Q=;
        h=From:To:Cc:Subject:Date:From;
        b=tBleERXDQwQYDSP0G/qGkg+cfn+9fBkHfUX4YxDyIZ+b9bKv8MuJZtdyOJ6zxHZS+
         fa0C1jBak7M8C/gwtdsPVkcaPUL8NWzD5fRyYtWvJCQ9UytqSyiXhNIuaJYZvozALb
         cw1wjcVL28hRySGWIQGNhYO0STUKrgHG1EMbF5iwe2130QPr7pjj6I5AFR6cYd5pDi
         2iZ2VQEasFS5SNGOouCxwvhvh2RgVrxsE9opPFHu1gpzC2qWG4D7Co/XKbcPcpaAtJ
         xV8qc0xmXUphB3es2MflUIogh4m1P1jbhy4uOTdG3FzRBzc/mScWlWYqxnju2xXsJM
         J+OfCut3ddGew==
From:   Marek Vasut <marex@denx.de>
To:     devicetree@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] dt-bindings: usb: snps,dwc3: Fix "snps,hsphy_interface" type
Date:   Mon, 15 May 2023 19:24:56 +0200
Message-Id: <20230515172456.179049-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The "snps,hsphy_interface" is string, not u8. Fix the type.

Fixes: 389d77658801 ("dt-bindings: usb: Convert DWC USB3 bindings to DT schema")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: stable@vger.kernel.org
---
V2: Add Fixes, RB from Krzysztof, CC stable
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index 50edc4da780e9..4f7625955cccc 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -287,7 +287,7 @@ properties:
     description:
       High-Speed PHY interface selection between UTMI+ and ULPI when the
       DWC_USB3_HSPHY_INTERFACE has value 3.
-    $ref: /schemas/types.yaml#/definitions/uint8
+    $ref: /schemas/types.yaml#/definitions/string
     enum: [utmi, ulpi]
 
   snps,quirk-frame-length-adjustment:
-- 
2.39.2

