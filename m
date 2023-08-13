Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0B77AC11
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjHMV26 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjHMV25 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:28:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3558310E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE0762A63
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D421CC433C7;
        Sun, 13 Aug 2023 21:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962136;
        bh=WQ0K6i234s5LG7UDnWebyg2Erp5Zlj6q0D8OMhPCbPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Up51dCffbLtB+ptMXXoFa1uTWk9jB2ITE7LVUNVdLsO+LAnyOpcu0vNYXneIhpfo5
         4tGO0rrMZyCeUdUvcYmRgzPOs4z8jT1aR0Rw3mBtmjXyzD5Gl3yhRkiZsy9x7uZHsx
         MWScdKqjrIb3w2gyzeEVuIXHyyCJz7FuKqkucZro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.4 096/206] iio: light: bu27034: Fix scale format
Date:   Sun, 13 Aug 2023 23:17:46 +0200
Message-ID: <20230813211727.810011019@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matti Vaittinen <mazziesaccount@gmail.com>

commit d47b9b84292706784482a661324bbc178153781f upstream.

The driver is expecting accuracy of NANOs for intensity scale in
raw_write. The IIO core is however defaulting to MICROs. This leads the
raw-write of smallest scales to never succeed as correct selector(s) are
not found.

Fix this by implementing the .write_raw_get_fmt callback to use NANO
accuracy for writes of IIO_CHAN_INFO_SCALE.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
Link: https://lore.kernel.org/r/5369117315cf05b88cf0ccb87373fd77190f6ca2.1686648422.git.mazziesaccount@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/light/rohm-bu27034.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index e63ef5789cde..bf3de853a811 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -575,7 +575,7 @@ static int bu27034_set_scale(struct bu27034_data *data, int chan,
 		return -EINVAL;
 
 	if (chan == BU27034_CHAN_ALS) {
-		if (val == 0 && val2 == 1000)
+		if (val == 0 && val2 == 1000000)
 			return 0;
 
 		return -EINVAL;
@@ -587,7 +587,7 @@ static int bu27034_set_scale(struct bu27034_data *data, int chan,
 		goto unlock_out;
 
 	ret = iio_gts_find_gain_sel_for_scale_using_time(&data->gts, time_sel,
-						val, val2 * 1000, &gain_sel);
+						val, val2, &gain_sel);
 	if (ret) {
 		/*
 		 * Could not support scale with given time. Need to change time.
@@ -624,7 +624,7 @@ static int bu27034_set_scale(struct bu27034_data *data, int chan,
 
 			/* Can we provide requested scale with this time? */
 			ret = iio_gts_find_gain_sel_for_scale_using_time(
-				&data->gts, new_time_sel, val, val2 * 1000,
+				&data->gts, new_time_sel, val, val2,
 				&gain_sel);
 			if (ret)
 				continue;
@@ -1217,6 +1217,21 @@ static int bu27034_read_raw(struct iio_dev *idev,
 	}
 }
 
+static int bu27034_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bu27034_write_raw(struct iio_dev *idev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
@@ -1267,6 +1282,7 @@ static int bu27034_read_avail(struct iio_dev *idev,
 static const struct iio_info bu27034_info = {
 	.read_raw = &bu27034_read_raw,
 	.write_raw = &bu27034_write_raw,
+	.write_raw_get_fmt = &bu27034_write_raw_get_fmt,
 	.read_avail = &bu27034_read_avail,
 };
 
-- 
2.41.0



