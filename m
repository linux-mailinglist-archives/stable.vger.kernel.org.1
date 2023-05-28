Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED6713C1C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjE1TEr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjE1TEq (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 28 May 2023 15:04:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A11D90
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 12:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17121618A8
        for <Stable@vger.kernel.org>; Sun, 28 May 2023 19:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3626DC433D2;
        Sun, 28 May 2023 19:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685300684;
        bh=zwvIX9kvowo4wj41nqNR9RqfY+k6M3ADAcCDObDYXEo=;
        h=Subject:To:From:Date:From;
        b=wDTipzqEG9tBZYV5lmhx2Nu9K4LDmZoXbPALpXn/ObiWiMfSDyUU1Su8ipQxcy0+Y
         NZH1ti5dB1hwc8ZQF5MywatvH8D8aOASpta2NccaPGitBSzE7V52HX6ZwQnrBzmaPE
         Sh8M6yG+wihoHIso7MrjGe6ZVTsbXVfq8uTzHOEk=
Subject: patch "iio: adc: mxs-lradc: fix the order of two cleanup operations" added to char-misc-linus
To:     jkluo@hust.edu.cn, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, dzm91@hust.edu.cn
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 20:04:33 +0100
Message-ID: <2023052833-stubbly-coping-67a9@gregkh>
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

    iio: adc: mxs-lradc: fix the order of two cleanup operations

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 27b2ed5b6d53cd62fc61c3f259ae52f5cac23b66 Mon Sep 17 00:00:00 2001
From: Jiakai Luo <jkluo@hust.edu.cn>
Date: Sat, 22 Apr 2023 06:34:06 -0700
Subject: iio: adc: mxs-lradc: fix the order of two cleanup operations

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
---
 drivers/iio/adc/mxs-lradc-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index bca79a93cbe4..a50f39143d3e 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -757,13 +757,13 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
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
 
@@ -801,9 +801,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
 
 err_dev:
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
-err_trig:
 	iio_triggered_buffer_cleanup(iio);
+err_trig:
+	mxs_lradc_adc_trigger_remove(iio);
 	return ret;
 }
 
@@ -814,8 +814,8 @@ static int mxs_lradc_adc_remove(struct platform_device *pdev)
 
 	iio_device_unregister(iio);
 	mxs_lradc_adc_hw_stop(adc);
-	mxs_lradc_adc_trigger_remove(iio);
 	iio_triggered_buffer_cleanup(iio);
+	mxs_lradc_adc_trigger_remove(iio);
 
 	return 0;
 }
-- 
2.40.1


