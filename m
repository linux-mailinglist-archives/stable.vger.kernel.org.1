Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD606726FD0
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbjFGVCO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjFGVBx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE032702
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 102BD64946
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FD9C4339B;
        Wed,  7 Jun 2023 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171681;
        bh=J4Q16PpKOIVyLfg0nP6Acxk9no1ht883xExU0/J5DmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1UuR0sXw5EgK5vT9P+mhIZUJPTT67CC2xHWjQ1/E8ezlJNh9EtjxCIzr6cp/BSHiv
         6dudjeg4+/5AcOm6j7qoR+vAf+caNmBVemc5BbuWDyXPhtUwWMNHDPtniYjWh22d0m
         joSmisZAf8W3Ntmt0bx/Zp9KZguw7FO8w66lK8AQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Vasut <marex@denx.de>
Subject: [PATCH 5.15 109/159] dt-bindings: usb: snps,dwc3: Fix "snps,hsphy_interface" type
Date:   Wed,  7 Jun 2023 22:16:52 +0200
Message-ID: <20230607200907.244583626@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

commit 7b32040f6d7f885ffc09a6df7c17992d56d2eab8 upstream.

The "snps,hsphy_interface" is string, not u8. Fix the type.

Fixes: 389d77658801 ("dt-bindings: usb: Convert DWC USB3 bindings to DT schema")
Cc: stable <stable@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20230515172456.179049-1-marex@denx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/usb/snps,dwc3.yaml |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -240,7 +240,7 @@ properties:
     description:
       High-Speed PHY interface selection between UTMI+ and ULPI when the
       DWC_USB3_HSPHY_INTERFACE has value 3.
-    $ref: /schemas/types.yaml#/definitions/uint8
+    $ref: /schemas/types.yaml#/definitions/string
     enum: [utmi, ulpi]
 
   snps,quirk-frame-length-adjustment:


