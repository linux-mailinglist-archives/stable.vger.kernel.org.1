Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BE713C28
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjE1TFb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjE1TFb (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19690C9
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:05:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9A596160D
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84D0C433EF;
        Sun, 28 May 2023 19:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300729;
        bh=K+V2rj3uwd8VOd6oWMonK0mJrUAgCGyRCMoJKHrohfY=;
        h=Subject:To:From:Date:From;
        b=ONj6SDOwJ/I5Ard8WlaHvSs6FuUjJL/VqYd9KVK69sZ/F4l74p3Pja2O2ww8mMEhg
         yo/slRyIOWAlU3W7XakYDOtG/d14XEVYWpwFP6mWx9v3BO35nZf5OW26pXzfatgpdp
         9A2orqacosn2ny+fAgm2pF7XcUwxTWZJal1Bldko=
Subject: patch "dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476" added to char-misc-linus
To:     geert+renesas@glider.be, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        marek.vasut+renesas@mailbox.org, wsa+renesas@sang-engineering.com
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:44 +0100
Message-ID: <2023052844-pusher-disparity-63b6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


This is a note to let you know that I've just added the patch titled

    dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 55720d242052e860b9fde445e302e0425722e7f1 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 9 May 2023 14:34:22 +0200
Subject: dt-bindings: iio: adc: renesas,rcar-gyroadc: Fix adi,ad7476
 compatible value

The conversion to json-schema accidentally dropped the "ad" part prefix
from the compatible value.

Fixes: 8c41245872e2 ("dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/6b328a3f52657c20759f3a5bb2fe033d47644ba8.1683635404.git.geert+renesas@glider.be
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
index 1c7aee5ed3e0..36dff3250ea7 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
@@ -90,7 +90,7 @@ patternProperties:
             of the MAX chips to the GyroADC, while MISO line of each Maxim
             ADC connects to a shared input pin of the GyroADC.
         enum:
-          - adi,7476
+          - adi,ad7476
           - fujitsu,mb88101a
           - maxim,max1162
           - maxim,max11100
-- 
2.40.1


