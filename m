Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C61713C1A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjE1TEm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjE1TEl (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C90290
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:04:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFC3F614FF
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F60C433D2;
        Sun, 28 May 2023 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300679;
        bh=U8RhwrNdYIYmkSHzQJX7YwDImy0uaquifSPlLW0tXxo=;
        h=Subject:To:From:Date:From;
        b=eHKwPhw9na5APv8OaWuZZZb2pfbdBMrcLo1pfN/T0tnuuyXPfi2kn7odc8sHa6vFz
         sJpgEuHIZ4naIQGe0NkkQlhoSZngdDA+4xT8V5qEkG845iy4XegZxxRPbPukQiGfMx
         gd6AEIAflcLDa3VXX3VbxVfawbDpv9qDK9mKhq7U=
Subject: patch "iio: ad4130: Make sure clock provider gets removed" added to char-misc-linus
To:     lars@metafoo.de, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:32 +0100
Message-ID: <2023052832-revocable-gnarly-12c0@gregkh>
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

    iio: ad4130: Make sure clock provider gets removed

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 28f73ded19d403697f87473c9b85a27eb8ed9cf2 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 14 Apr 2023 08:07:02 -0700
Subject: iio: ad4130: Make sure clock provider gets removed

The ad4130 driver registers a clock provider, but never removes it. This
leaves a stale clock provider behind that references freed clocks when the
device is unbound.

Register a managed action to remove the clock provider when the device is
removed.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Link: https://lore.kernel.org/r/20230414150702.518441-1-lars@metafoo.de
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad4130.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 38394341fd6e..5a5dd5e87ffc 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1817,6 +1817,11 @@ static const struct clk_ops ad4130_int_clk_ops = {
 	.unprepare = ad4130_int_clk_unprepare,
 };
 
+static void ad4130_clk_del_provider(void *of_node)
+{
+	of_clk_del_provider(of_node);
+}
+
 static int ad4130_setup_int_clk(struct ad4130_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1824,6 +1829,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 	struct clk_init_data init;
 	const char *clk_name;
 	struct clk *clk;
+	int ret;
 
 	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
 	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
@@ -1843,7 +1849,11 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
+	ret = of_clk_add_provider(of_node, of_clk_src_simple_get, clk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad4130_clk_del_provider, of_node);
 }
 
 static int ad4130_setup(struct iio_dev *indio_dev)
-- 
2.40.1


