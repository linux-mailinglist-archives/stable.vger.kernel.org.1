Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EDB6F8F00
	for <lists+stable@lfdr.de>; Sat,  6 May 2023 07:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjEFF7b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 6 May 2023 01:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjEFF73 (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sat, 6 May 2023 01:59:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E173C59F1
        for <Stable@vger.kernel.org>; Fri,  5 May 2023 22:59:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5D861269
        for <Stable@vger.kernel.org>; Sat,  6 May 2023 05:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70293C433EF;
        Sat,  6 May 2023 05:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683352767;
        bh=oiPrwKf1vt3J+nptl898IdsIZeUepJHqxQVeSKHNjIY=;
        h=Subject:To:Cc:From:Date:From;
        b=xlIWuY9sPHEwnMkeH0IDKQSx3TVcdB0fZOATjgF01iELOabc/8NvytgFMPPihOE7j
         JZGkqYJ5HuPjHsH9HU7lpp7vOcTXXGbiCdD3wOF2zR/qLg8AOz3G36tSeMIlvCUbr1
         qyKaAQLUCT/AM7kJTum+QkL44FZAmFkyQpVcBM7s=
Subject: FAILED: patch "[PATCH] iio: addac: stx104: Fix race condition for stx104_write_raw()" failed to apply to 4.19-stable tree
To:     william.gray@linaro.org, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 06 May 2023 11:15:19 +0900
Message-ID: <2023050619-swapping-saga-797e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 9740827468cea80c42db29e7171a50e99acf7328
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050619-swapping-saga-797e@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9740827468cea80c42db29e7171a50e99acf7328 Mon Sep 17 00:00:00 2001
From: William Breathitt Gray <william.gray@linaro.org>
Date: Thu, 6 Apr 2023 10:40:10 -0400
Subject: [PATCH] iio: addac: stx104: Fix race condition for stx104_write_raw()

The priv->chan_out_states array and actual DAC value can become
mismatched if stx104_write_raw() is called concurrently. Prevent such a
race condition by utilizing a mutex.

Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/r/c95c9a77fcef36b2a052282146950f23bbc1ebdc.1680790580.git.william.gray@linaro.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index e45b70aa5bb7..4239aafe42fc 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -69,10 +70,12 @@ struct stx104_reg {
 
 /**
  * struct stx104_iio - IIO device private data structure
+ * @lock: synchronization lock to prevent I/O race conditions
  * @chan_out_states:	channels' output states
  * @reg:		I/O address offset for the device registers
  */
 struct stx104_iio {
+	struct mutex lock;
 	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
 	struct stx104_reg __iomem *reg;
 };
@@ -178,9 +181,12 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 			if ((unsigned int)val > 65535)
 				return -EINVAL;
 
+			mutex_lock(&priv->lock);
+
 			priv->chan_out_states[chan->channel] = val;
 			iowrite16(val, &priv->reg->dac[chan->channel]);
 
+			mutex_unlock(&priv->lock);
 			return 0;
 		}
 		return -EINVAL;
@@ -351,6 +357,8 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	indio_dev->name = dev_name(dev);
 
+	mutex_init(&priv->lock);
+
 	/* configure device for software trigger operation */
 	iowrite8(0, &priv->reg->acr);
 

