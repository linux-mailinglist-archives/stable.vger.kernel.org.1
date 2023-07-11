Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF41574F8BA
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 22:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGKUGw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 16:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGKUGv (ORCPT
        <rfc822;Stable@vger.kernel.org>); Tue, 11 Jul 2023 16:06:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CC011D
        for <Stable@vger.kernel.org>; Tue, 11 Jul 2023 13:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C316615C1
        for <Stable@vger.kernel.org>; Tue, 11 Jul 2023 20:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB6CC433C7;
        Tue, 11 Jul 2023 20:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689106009;
        bh=7fCni+MriwnL+iPrSHgbqzTfYErhKGxrrbLAwpgH06g=;
        h=Subject:To:Cc:From:Date:From;
        b=2SJsDODBvd7W1O1bFuUMoBSMvJDxwJGePbU/4IQDITluh8oVkyyRxLg1/1cXGLVoy
         LIl0wtaA4em7ZWKiDXNTjGTkWiVLCoVQT3zyWECaXr+xmsf1sx2e36DOI/FBVkmljZ
         nAhUg1qb7WfqGdZYliGmpbBtIo/a3ssZHw9ywikg=
Subject: FAILED: patch "[PATCH] dt-bindings: iio: ad7192: Add mandatory reference voltage" failed to apply to 6.1-stable tree
To:     fl.scratchpad@gmail.com, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, conor.dooley@microchip.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 11 Jul 2023 22:06:46 +0200
Message-ID: <2023071145-unabashed-cruncher-fc14@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c6dab7245604862d86f0b6d764919f470584d24f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071145-unabashed-cruncher-fc14@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c6dab7245604862d86f0b6d764919f470584d24f Mon Sep 17 00:00:00 2001
From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Date: Tue, 30 May 2023 09:53:10 +0200
Subject: [PATCH] dt-bindings: iio: ad7192: Add mandatory reference voltage
 source

Add required reference voltage (VRef) supply regulator.

AD7192 requires three independent voltage sources: DVdd, AVdd and VRef
(on REFINx pin pairs).

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Cc: <Stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230530075311.400686-5-fl.scratchpad@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

