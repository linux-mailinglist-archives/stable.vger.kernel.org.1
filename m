Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D37DAC5A
	for <lists+stable@lfdr.de>; Sun, 29 Oct 2023 13:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJ2MQV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 29 Oct 2023 08:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2MQV (ORCPT
        <rfc822;Stable@vger.kernel.org>); Sun, 29 Oct 2023 08:16:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8798C1
        for <Stable@vger.kernel.org>; Sun, 29 Oct 2023 05:16:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FA2C433C7;
        Sun, 29 Oct 2023 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698581778;
        bh=pnICplLWstLf8d44H49+sAUFv54h+QXXcEg/HkMHZM8=;
        h=Subject:To:Cc:From:Date:From;
        b=a6dAo2AXTMXqzUB30AYdqVBU2K7v8kEk38jwHQk9tauXO3cPR23Z9/9fKRLrzFyfb
         rKvnLLnAjh48BoeY/z3RsDOL8I2b02vdA+OtVsASWrEnR7hrAcgLPlZ2k9qge8OuNY
         288630d7dqoIIh95NtLz2seGgvAQICWPZj7oAPRc=
Subject: FAILED: patch "[PATCH] iio: afe: rescale: Accept only offset channels" failed to apply to 5.15-stable tree
To:     linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        Stable@vger.kernel.org, jic23@kernel.org, peda@axentia.se
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 29 Oct 2023 13:16:13 +0100
Message-ID: <2023102913-mutate-envelope-6e98@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bee448390e5166d019e9e037194d487ee94399d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102913-mutate-envelope-6e98@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bee448390e5166d019e9e037194d487ee94399d9 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 2 Sep 2023 21:46:20 +0200
Subject: [PATCH] iio: afe: rescale: Accept only offset channels

As noted by Jonathan Cameron: it is perfectly legal for a channel
to have an offset but no scale in addition to the raw interface.
The conversion will imply that scale is 1:1.

Make rescale_configure_channel() accept just scale, or just offset
to process a channel.

When a user asks for IIO_CHAN_INFO_OFFSET in rescale_read_raw()
we now have to deal with the fact that OFFSET could be present
but SCALE missing. Add code to simply scale 1:1 in this case.

Link: https://lore.kernel.org/linux-iio/CACRpkdZXBjHU4t-GVOCFxRO-AHGxKnxMeHD2s4Y4PuC29gBq6g@mail.gmail.com/
Fixes: 53ebee949980 ("iio: afe: iio-rescale: Support processed channels")
Fixes: 9decacd8b3a4 ("iio: afe: rescale: Fix boolean logic bug")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Peter Rosin <peda@axentia.se>
Link: https://lore.kernel.org/r/20230902-iio-rescale-only-offset-v2-1-988b807754c8@linaro.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 1f280c360701..56e5913ab82d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -214,8 +214,18 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 				return ret < 0 ? ret : -EOPNOTSUPP;
 		}
 
-		ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
-		return rescale_process_offset(rescale, ret, scale, scale2,
+		if (iio_channel_has_info(rescale->source->channel,
+					 IIO_CHAN_INFO_SCALE)) {
+			ret = iio_read_channel_scale(rescale->source, &scale, &scale2);
+			return rescale_process_offset(rescale, ret, scale, scale2,
+						      schan_off, val, val2);
+		}
+
+		/*
+		 * If we get here we have no scale so scale 1:1 but apply
+		 * rescaler and offset, if any.
+		 */
+		return rescale_process_offset(rescale, IIO_VAL_FRACTIONAL, 1, 1,
 					      schan_off, val, val2);
 	default:
 		return -EINVAL;
@@ -280,8 +290,9 @@ static int rescale_configure_channel(struct device *dev,
 	chan->type = rescale->cfg->type;
 
 	if (iio_channel_has_info(schan, IIO_CHAN_INFO_RAW) &&
-	    iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE)) {
-		dev_info(dev, "using raw+scale source channel\n");
+	    (iio_channel_has_info(schan, IIO_CHAN_INFO_SCALE) ||
+	     iio_channel_has_info(schan, IIO_CHAN_INFO_OFFSET))) {
+		dev_info(dev, "using raw+scale/offset source channel\n");
 	} else if (iio_channel_has_info(schan, IIO_CHAN_INFO_PROCESSED)) {
 		dev_info(dev, "using processed channel\n");
 		rescale->chan_processed = true;

