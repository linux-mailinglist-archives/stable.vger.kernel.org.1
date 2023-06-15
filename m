Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3B1731636
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjFOLN5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 15 Jun 2023 07:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241004AbjFOLN4 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Thu, 15 Jun 2023 07:13:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26D272E
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 04:13:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A94E62264
        for <Stable@vger.kernel.org>; Thu, 15 Jun 2023 11:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414BBC433C0;
        Thu, 15 Jun 2023 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686827634;
        bh=rpV4TVeAfNRDeqIFaGrTy1KNE0tF6uWcyYlYCdWSYEA=;
        h=Subject:To:From:Date:From;
        b=pIqzUeNIp+SZKYO1wsAN9h5qIpdt+QjsAl6vgxBLpUWP3T3EF84O6sWgAW9J8dsmC
         dkTOl8Cy3A7I46ihXvgxWPurnPUjSO/1vj0LF1hiiKnp0iBTbp7S0Rld6LaYRDqgdt
         AE0jCkNo6GK/qjf7sdzzRhA1/XIcZ25rKKlltSdM=
Subject: patch "dt-bindings: iio: ad7192: Add mandatory reference voltage source" added to char-misc-next
To:     fl.scratchpad@gmail.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, conor.dooley@microchip.com
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 15 Jun 2023 13:11:41 +0200
Message-ID: <2023061541-scheming-pointless-57de@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    dt-bindings: iio: ad7192: Add mandatory reference voltage source

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From c6dab7245604862d86f0b6d764919f470584d24f Mon Sep 17 00:00:00 2001
From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date: Tue, 30 May 2023 09:53:10 +0200
Subject: dt-bindings: iio: ad7192: Add mandatory reference voltage source

Add required reference voltage (VRef) supply regulator.

AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
(on REFINx pin pairs).

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230530075311.400686-5-fl.scratchpad@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
index d521d516088b..16def2985ab4 100644
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
-- 
2.41.0


