Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A042755138
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjGPTyD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjGPTyC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B396199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:54:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908A160E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B98CC433C7;
        Sun, 16 Jul 2023 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537241;
        bh=ICxOysXMmltZ/S/DUyfb5SH8ZwZzMSqRHDVO8Nd5UNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zxPnKQvudS4vSEHYIbIeCIIuKE12sv6Q+wSPqRicoNMbl+B63c67bmnXZJBAfd/UZ
         U1I3jdUhcnf8HxiCf2pVFoiyTvvyh+DxVTjXAhFcZR4DrrvosqwZdTe247ML1f32H5
         U5b/sK1hcjjMdaePnIBzSvOlej+gsesPNO5ZdXmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Fabrizio Lamarque <fl.scratchpad@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.4 006/800] dt-bindings: iio: ad7192: Add mandatory reference voltage source
Date:   Sun, 16 Jul 2023 21:37:39 +0200
Message-ID: <20230716194949.255312839@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Fabrizio Lamarque <fl.scratchpad@gmail.com>

commit c6dab7245604862d86f0b6d764919f470584d24f upstream.

Add required reference voltage (VRef) supply regulator.

AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
(on REFINx pin pairs).

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230530075311.400686-5-fl.scratchpad@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml |    5 +++++
 1 file changed, 5 insertions(+)

--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
@@ -47,6 +47,9 @@ properties:
   avdd-supply:
     description: AVdd voltage supply
 
+  vref-supply:
+    description: VRef voltage supply
+
   adi,rejection-60-Hz-enable:
     description: |
       This bit enables a notch at 60 Hz when the first notch of the sinc
@@ -89,6 +92,7 @@ required:
   - interrupts
   - dvdd-supply
   - avdd-supply
+  - vref-supply
   - spi-cpol
   - spi-cpha
 
@@ -115,6 +119,7 @@ examples:
             interrupt-parent = <&gpio>;
             dvdd-supply = <&dvdd>;
             avdd-supply = <&avdd>;
+            vref-supply = <&vref>;
 
             adi,refin2-pins-enable;
             adi,rejection-60-Hz-enable;


