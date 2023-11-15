Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9D47E2319
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjKFNIo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKFNIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:08:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE08125
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:08:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B144FC433C8;
        Mon,  6 Nov 2023 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276119;
        bh=cJcLip7nAjVxlJ4BTHmRPlJ9EnJE44dr6tTDZATH/TU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkT0G2YaXCLBd3hDtSk78Ok0mGrvQzqSLVG1DGEMRqyL/fBJ4ieWSQ9tpdN9FWYfe
         nINZOI5y/cTJcIp4ip+rAe7EzbopxgTO8c8W/i3aUjm0yjRkPG9/xE1mGDumu3rNQK
         h6xhNjo5XFak1n7KoLs05aN4LEE+xaMeMX4M6oNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
        stable <stable@kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6.6 26/30] dt-bindings: serial: rs485: Add rs485-rts-active-high
Date:   Mon,  6 Nov 2023 14:03:44 +0100
Message-ID: <20231106130258.819057330@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130257.903265688@linuxfoundation.org>
References: <20231106130257.903265688@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
 Documentation/devicetree/bindings/serial/rs485.yaml |    4 ++++
 1 file changed, 4 insertions(+)

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


