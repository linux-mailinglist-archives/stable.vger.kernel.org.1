Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7F726C20
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjFGUa6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjFGUam (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE4C212E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 413E1644D5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C7C433D2;
        Wed,  7 Jun 2023 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169836;
        bh=Vf5bpZvMGHudPznYQxYqkJMqr00OB0bh8RaNt5HJTtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNPzEkBojo3Horo3bxZCvND4NYF9Y59mMEuP/ogEYv8qbLX23/rYNxrTOCogMFP2m
         N+MnlUhLldtWzDTRcjUExQpTtC3Ko6R6VzteTDR6YhEqRTmnaLMfY25wchS3cmExSH
         cJwzPx18EPOYoVf7peSvVIipzIoWCPp6ilM3ZqCE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.3 193/286] iio: ad4130: Make sure clock provider gets removed
Date:   Wed,  7 Jun 2023 22:14:52 +0200
Message-ID: <20230607200929.568029773@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Lars-Peter Clausen <lars@metafoo.de>

commit 28f73ded19d403697f87473c9b85a27eb8ed9cf2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/ad4130.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1817,6 +1817,11 @@ static const struct clk_ops ad4130_int_c
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
@@ -1824,6 +1829,7 @@ static int ad4130_setup_int_clk(struct a
 	struct clk_init_data init;
 	const char *clk_name;
 	struct clk *clk;
+	int ret;
 
 	if (st->int_pin_sel == AD4130_INT_PIN_CLK ||
 	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
@@ -1843,7 +1849,11 @@ static int ad4130_setup_int_clk(struct a
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


