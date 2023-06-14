Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC618726F0F
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjFGUz1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjFGUzA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:55:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871651BF0
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46367647D2
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558CAC433D2;
        Wed,  7 Jun 2023 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171290;
        bh=qzghPzn5owh9oOXDzKJvjnYDhVsb9PppkdpJMhHF/j8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mj6Hgj+Eu39WJrjBgUoosKytW42AuRjLTzZq/s9ttvrDVVA4ssrfnGX9VSgUO7/sO
         hxNyFi3onqhKevkVJ866XzHXy9NLverN9KLsvfm8YF147rJpb5WXTh77/EqdK44tOb
         j9WrBhTruFixXyHaeJ8ABR+8+OiBc6wVpgpZcjoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiakai Luo <jkluo@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 61/99] iio: adc: mxs-lradc: fix the order of two cleanup operations
Date:   Wed,  7 Jun 2023 22:16:53 +0200
Message-ID: <20230607200902.154891843@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiakai Luo <jkluo@hust.edu.cn>

commit 27b2ed5b6d53cd62fc61c3f259ae52f5cac23b66 upstream.

Smatch reports:
drivers/iio/adc/mxs-lradc-adc.c:766 mxs_lradc_adc_probe() warn:
missing unwind goto?

the order of three init operation:
1.mxs_lradc_adc_trigger_init
2.iio_triggered_buffer_setup
3.mxs_lradc_adc_hw_init

thus, the order of three cleanup operation should be:
1.mxs_lradc_adc_hw_stop
2.iio_triggered_buffer_cleanup
3.mxs_lradc_adc_trigger_remove

we exchange the order of two cleanup operations,
introducing the following differences:
1.if mxs_lradc_adc_trigger_init fails, returns directly;
2.if trigger_init succeeds but iio_triggered_buffer_setup fails,
goto err_trig and remove the trigger.

In addition, we also reorder the unwind that goes on in the
remove() callback to match the new ordering.

Fixes: 6dd112b9f85e ("iio: adc: mxs-lradc: Add support for ADC driver")
Signed-off-by: Jiakai Luo <jkluo@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Link: https://lore.kernel.org/r/20230422133407.72908-1-jkluo@hust.edu.cn
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/mxs-lradc-adc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -760,13 +760,13 @@ static int mxs_lradc_adc_probe(struct pl
 
 	ret = mxs_lradc_adc_trigger_init(iio);
 	if (ret)
-		goto err_trig;
+		return ret;
 
 	ret = iio_triggered_buffer_setup(iio, &iio_pollfunc_store_time,
 					 &mxs_lradc_adc_trigger_handler,
 					 &mxs_lradc_adc_buffer_ops);
 	if (ret)
-		return ret;
+		goto err_trig;
 
 	adc->vref_mv = mxs_lradc_adc_vref_mv[lradc->soc];
 
@@ -804,9 +804,9 @@ static int mxs_lradc_adc_probe(struct pl
 
 err_dev:
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
-err_trig:
 	iio_triggered_buffer_cleanup(iio);
+err_trig:
+	mxs_lradc_adc_trigger_remove(iio);
 	return ret;
 }
 
@@ -817,8 +817,8 @@ static int mxs_lradc_adc_remove(struct p
 
 	iio_device_unregister(iio);
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
 	iio_triggered_buffer_cleanup(iio);
+	mxs_lradc_adc_trigger_remove(iio);
 
 	return 0;
 }


