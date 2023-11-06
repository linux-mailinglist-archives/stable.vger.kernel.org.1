Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E3C7E243C
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjKFNTr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjKFNTq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:19:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198DD8
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40417C433C9;
        Mon,  6 Nov 2023 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276783;
        bh=g7pfaC8N1A0QXRc8SM467+Rv3DX9v744LJwIUHLzco4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z982YYd9WQyy/5GjJUQWMU56ppWi3icClwt1LJRHWUNUuUfecpKnxGNFKdR+3qzDJ
         8pgrBZ6vrXTEyqQKCV4G7FXSAiFHkTzl3aBgez8EEDz1mbbPOflt8YUU+TuplKiZom
         SzmAx0o/0eyupfLOw3cGVUjYk1pVf4HgW8EJIxWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
        stable <stable@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6.5 84/88] dt-bindings: serial: rs485: Add rs485-rts-active-high
Date:   Mon,  6 Nov 2023 14:04:18 +0100
Message-ID: <20231106130308.886485417@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Dolcini <francesco.dolcini@toradex.com>

commit 0c01b20fb50ba63c03841aa83070dc59c3b1b02f upstream.

Add rs485-rts-active-high property, this is a legacy property
used by 8250_omap.

This fixes the following make dt_binding_check warning:

Documentation/devicetree/bindings/serial/8250_omap.yaml:
rs485-rts-active-high: missing type definition

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/all/CAMuHMdUkPiA=o_QLyuwsTYW7y1ksCjHAqyNSHFx2QZ-dP-HGsQ@mail.gmail.com/
Fixes: 403e97d6ab2c ("dt-bindings: serial: 8250_omap: add rs485-rts-active-high")
Cc: stable <stable@kernel.org>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231019154834.41721-1-francesco@dolcini.it
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 303a443d9e29..9418fd66a8e9 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -29,6 +29,10 @@ properties:
           default: 0
           maximum: 100
 
+  rs485-rts-active-high:
+    description: drive RTS high when sending (this is the default).
+    $ref: /schemas/types.yaml#/definitions/flag
+
   rs485-rts-active-low:
     description: drive RTS low when sending (default is high).
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.42.0



