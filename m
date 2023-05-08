Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF36FA9D0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjEHK4U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjEHKzR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:55:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FCA2DD5A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C9762988
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD61C433D2;
        Mon,  8 May 2023 10:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543277;
        bh=sXB2VzvqV8lZY4Fd5ULxR3iga7hLhUnsZRdA96+J/cY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vW9RlUnQx9b8VUTakWU9Dje+RD9bHaEIkWUYI3a+njf22hHdH8CFId5CtqM6bViTi
         PvTfzGdMCG2sM/mqQAKIwnHVoASJ3HRNbt3jNVWucxwcaYEaEmNGVUsumIBrOcmgup
         gLCW5IpYYz0pIciclI98bwM8F+jJU8CEOIVgWNv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William Breathitt Gray <william.gray@linaro.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.3 038/694] iio: addac: stx104: Fix race condition for stx104_write_raw()
Date:   Mon,  8 May 2023 11:37:53 +0200
Message-Id: <20230508094433.870612409@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: William Breathitt Gray <william.gray@linaro.org>

commit 9740827468cea80c42db29e7171a50e99acf7328 upstream.

The priv->chan_out_states array and actual DAC value can become
mismatched if stx104_write_raw() is called concurrently. Prevent such a
race condition by utilizing a mutex.

Fixes: 97a445dad37a ("iio: Add IIO support for the DAC on the Apex Embedded Systems STX104")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/r/c95c9a77fcef36b2a052282146950f23bbc1ebdc.1680790580.git.william.gray@linaro.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/addac/stx104.c |    8 ++++++++
 1 file changed, 8 insertions(+)

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
@@ -182,9 +185,12 @@ static int stx104_write_raw(struct iio_d
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
@@ -355,6 +361,8 @@ static int stx104_probe(struct device *d
 
 	indio_dev->name = dev_name(dev);
 
+	mutex_init(&priv->lock);
+
 	/* configure device for software trigger operation */
 	iowrite8(0, &priv->reg->acr);
 


