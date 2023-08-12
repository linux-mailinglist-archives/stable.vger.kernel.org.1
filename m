Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD577A110
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 18:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHLQeq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHLQeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 12:34:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316D51702
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 09:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0C8A6258C
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 16:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CA1C433C7;
        Sat, 12 Aug 2023 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691858088;
        bh=CgVcmhF00vqEliy9XqvAdtEp6zYRFgDLL3c8a6KjXeE=;
        h=Subject:To:Cc:From:Date:From;
        b=pAGLW8HJZ9GXrDWaujGE1eSKMPvhdcVpReQYMDTphdDP4g9g3wsYOINBdZXk5xuHw
         4PsrV6GlxToPROpeSHkeDrX92s1CJ0ed79zEG+BZsRTm26D0GKb9teKkDXx9DFJt4E
         69J/gV/fbOnRv8HpaQ9oxLSV+IRRNf6ohbhgj80A=
Subject: FAILED: patch "[PATCH] iio: adc: ad7192: Fix ac excitation feature" failed to apply to 5.10-stable tree
To:     alisa.roman@analog.com, Jonathan.Cameron@huawei.com,
        nuno.sa@analog.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 18:34:37 +0200
Message-ID: <2023081237-turf-wok-df09@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6bc471b6c3aeaa7b95d1b86a1bb8d91a3c341fa5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081237-turf-wok-df09@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6bc471b6c3aeaa7b95d1b86a1bb8d91a3c341fa5 Mon Sep 17 00:00:00 2001
From: Alisa Roman <alisa.roman@analog.com>
Date: Wed, 14 Jun 2023 18:52:43 +0300
Subject: [PATCH] iio: adc: ad7192: Fix ac excitation feature

AC excitation enable feature exposed to user on AD7192, allowing a bit
which should be 0 to be set. This feature is specific only to AD7195. AC
excitation attribute moved accordingly.

In the AD7195 documentation, the AC excitation enable bit is on position
22 in the Configuration register. ACX macro changed to match correct
register and bit.

Note that the fix tag is for the commit that moved the driver out of
staging.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa Roman <alisa.roman@analog.com>
Cc: stable@vger.kernel.org
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230614155242.160296-1-alisa.roman@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8685e0b58a83..7bc3ebfe8081 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -62,7 +62,6 @@
 #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
 #define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
-#define AD7192_MODE_ACX		BIT(14) /* AC excitation enable(AD7195 only)*/
 #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
 #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
 #define AD7192_MODE_SCYCLE	BIT(11) /* Single cycle conversion */
@@ -91,6 +90,7 @@
 /* Configuration Register Bit Designations (AD7192_REG_CONF) */
 
 #define AD7192_CONF_CHOP	BIT(23) /* CHOP enable */
+#define AD7192_CONF_ACX		BIT(22) /* AC excitation enable(AD7195 only) */
 #define AD7192_CONF_REFSEL	BIT(20) /* REFIN1/REFIN2 Reference Select */
 #define AD7192_CONF_CHAN(x)	((x) << 8) /* Channel select */
 #define AD7192_CONF_CHAN_MASK	(0x7FF << 8) /* Channel select mask */
@@ -472,7 +472,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
+	return sysfs_emit(buf, "%d\n", !!(st->conf & AD7192_CONF_ACX));
 }
 
 static ssize_t ad7192_show_bridge_switch(struct device *dev,
@@ -513,13 +513,13 @@ static ssize_t ad7192_set(struct device *dev,
 
 		ad_sd_write_reg(&st->sd, AD7192_REG_GPOCON, 1, st->gpocon);
 		break;
-	case AD7192_REG_MODE:
+	case AD7192_REG_CONF:
 		if (val)
-			st->mode |= AD7192_MODE_ACX;
+			st->conf |= AD7192_CONF_ACX;
 		else
-			st->mode &= ~AD7192_MODE_ACX;
+			st->conf &= ~AD7192_CONF_ACX;
 
-		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
 		break;
 	default:
 		ret = -EINVAL;
@@ -579,12 +579,11 @@ static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 
 static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       ad7192_show_ac_excitation, ad7192_set,
-		       AD7192_REG_MODE);
+		       AD7192_REG_CONF);
 
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
-	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
 };
 
@@ -595,6 +594,7 @@ static const struct attribute_group ad7192_attribute_group = {
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
 };
 

