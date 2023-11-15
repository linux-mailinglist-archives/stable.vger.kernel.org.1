Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A965E7DD417
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjJaRHB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjJaRGq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:06:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0D3D4D
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:05:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D10AC433C7;
        Tue, 31 Oct 2023 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698771928;
        bh=vcG6lDt4jd0dIn6DeGe6k2UmFaXRSy7t02dSUH8p6HQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DqeWmWQeibvxkzCgrdNtZZLL/oR5WtJh3Oy3QYTqIdP8wk+GQDKPZeFSrhsF+fDG
         JjIsaRU+MRkmT4dACUdX8kwlBnTMgtbXhLaAJiORFl30tiztQG5qGfmXT+RX1MuqYr
         +i/bUAlVJe+LQr6Du9DULYC3DNhd6Kn+Po7dzvdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Rosin <peda@axentia.se>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 60/86] iio: afe: rescale: Accept only offset channels
Date:   Tue, 31 Oct 2023 18:01:25 +0100
Message-ID: <20231031165920.449533199@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
References: <20231031165918.608547597@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>

commit bee448390e5166d019e9e037194d487ee94399d9 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/afe/iio-rescale.c |   19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -214,8 +214,18 @@ static int rescale_read_raw(struct iio_d
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
@@ -280,8 +290,9 @@ static int rescale_configure_channel(str
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


