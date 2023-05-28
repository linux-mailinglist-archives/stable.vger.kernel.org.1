Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F75713F99
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjE1TrG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjE1TrF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40539B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51E8C61F95
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E80DC433D2;
        Sun, 28 May 2023 19:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303223;
        bh=13EWjuzTJApsiuJgJd6xjKrPoe+NAYeq+CeNOEM6KZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeLKzriAU4FWoxhiw9zf0xg8Wffjf1erpxQaONi3C55o+9bd2kIXn2iL7MNdKvDYY
         GvGg4M44zcQQ+bV7AV1sY2eIylEdX8Kp4LtUiXXsFc43DMRnV3mofdTKnpMD4ahFNN
         g0Wnm6z7vAlGsNATVhSe9jf93elwIRk0c4/xH+To=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.10 177/211] dt-binding: cdns,usb3: Fix cdns,on-chip-buff-size type
Date:   Sun, 28 May 2023 20:11:38 +0100
Message-Id: <20230528190847.893166875@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Frank Li <Frank.Li@nxp.com>

commit 50a1726b148ff30778cb8a6cf3736130b07c93fd upstream.

In cdns3-gadget.c, 'cdns,on-chip-buff-size' was read using
device_property_read_u16(). It resulted in 0 if a 32bit value was used
in dts. This commit fixes the dt binding doc to declare it as u16.

Cc: stable@vger.kernel.org
Fixes: 68989fe1c39d ("dt-bindings: usb: Convert cdns-usb3.txt to YAML schema")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/usb/cdns,usb3.yaml |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -59,7 +59,7 @@ properties:
     description:
       size of memory intended as internal memory for endpoints
       buffers expressed in KB
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint16
 
   cdns,phyrst-a-enable:
     description: Enable resetting of PHY if Rx fail is detected


