Return-Path: <stable+bounces-171876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A479B2D77E
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B6E5E4255
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D6C2D7813;
	Wed, 20 Aug 2025 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1nt/Imd9"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5239620B80B
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680740; cv=none; b=Jrk6TJKq1fqgVZISBqp2aIaaQTvdF5IZDTA7YG92asGYTNIG4zNcwtSXBDWkkC6Z4R0aN1SIiz5MJe3dGxwzxBvUGCZRm173ReQH65sPc+vYVLqotxTNDYwP72Vug+z2l8K00rQ5VHAHo8tS/gsNcO8rSqHVCMHCT3ecUuT7e6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680740; c=relaxed/simple;
	bh=Z7niuZyp+/U453rKYsmO28JvLQrunUwYRQbUCe25d2Y=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=exu6wD+EbPO9jztND0f+NDPdxrYRqMJojJIWiL2RrfSn85nrA8jC8axPWQIrcdSQcgOmQ4UkVgto/zPWM7lK6+igo5TdWducZNAA0nn6oh0dXIbGMhb1coK6nkUNjId/Q9oj9tcjyENnzYR+oUsfViq7KY9QwLYX8hA1y5dsnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1nt/Imd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59667C4CEEB;
	Wed, 20 Aug 2025 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680739;
	bh=Z7niuZyp+/U453rKYsmO28JvLQrunUwYRQbUCe25d2Y=;
	h=Subject:To:From:Date:From;
	b=1nt/Imd9wio6qQnJOM1dhSALybv43ldZJEda2xwaRJSDCiPvjhZb0dDO6lnxzFLnl
	 XXNdc2AYWqVisG0isc69WeRyCRUrfi1mKobVq5pzQI+tyf0bAvK9sDwIr6SYRB1MeY
	 1KZgI1Znyc57Sw+730e2GNreDNGQ8i9W7NPbtrlY=
Subject: patch "iio: adc: ad7173: prevent scan if too many setups requested" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:33 +0200
Message-ID: <2025082033-mummified-brim-8f08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: prevent scan if too many setups requested

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 1cfb22c277c7274f54babaa5b416dfbc00181e16 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 14:20:07 -0500
Subject: iio: adc: ad7173: prevent scan if too many setups requested

Add a check to ad7173_update_scan_mode() to ensure that we didn't exceed
the maximum number of unique channel configurations.

In the AD7173 family of chips, there are some chips that have 16
CHANNELx registers but only 8 setups (combination of CONFIGx, FILTERx,
GAINx and OFFSETx registers). Since commit 92c247216918 ("iio: adc:
ad7173: fix num_slots"), it is possible to have more than 8 channels
enabled in a scan at the same time, so it is possible to get a bad
configuration when more than 8 channels are using unique configurations.
This happens because the algorithm to allocate the setup slots only
takes into account which slot has been least recently used and doesn't
know about the maximum number of slots available.

Since the algorithm to allocate the setup slots is quite complex, it is
simpler to check after the fact if the current state is valid or not.
So this patch adds a check in ad7173_update_scan_mode() after setting up
all of the configurations to make sure that the actual setup still
matches the requested setup for each enabled channel. If not, we prevent
the scan from being enabled and return an error.

The setup comparison in ad7173_setup_equal() is refactored to a separate
function since we need to call it in two places now.

Fixes: 92c247216918 ("iio: adc: ad7173: fix num_slots")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250722-iio-adc-ad7173-fix-setup-use-limits-v2-1-8e96bdb72a9c@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 87 ++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 4413207be28f..683146e83ab2 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -200,7 +200,7 @@ struct ad7173_channel_config {
 	/*
 	 * Following fields are used to compare equality. If you
 	 * make adaptations in it, you most likely also have to adapt
-	 * ad7173_find_live_config(), too.
+	 * ad7173_is_setup_equal(), too.
 	 */
 	struct_group(config_props,
 		bool bipolar;
@@ -561,12 +561,19 @@ static void ad7173_reset_usage_cnts(struct ad7173_state *st)
 	st->config_usage_counter = 0;
 }
 
-static struct ad7173_channel_config *
-ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
+/**
+ * ad7173_is_setup_equal - Compare two channel setups
+ * @cfg1: First channel configuration
+ * @cfg2: Second channel configuration
+ *
+ * Compares all configuration options that affect the registers connected to
+ * SETUP_SEL, namely CONFIGx, FILTERx, GAINx and OFFSETx.
+ *
+ * Returns: true if the setups are identical, false otherwise
+ */
+static bool ad7173_is_setup_equal(const struct ad7173_channel_config *cfg1,
+				  const struct ad7173_channel_config *cfg2)
 {
-	struct ad7173_channel_config *cfg_aux;
-	int i;
-
 	/*
 	 * This is just to make sure that the comparison is adapted after
 	 * struct ad7173_channel_config was changed.
@@ -579,14 +586,22 @@ ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *c
 				     u8 ref_sel;
 			     }));
 
+	return cfg1->bipolar == cfg2->bipolar &&
+	       cfg1->input_buf == cfg2->input_buf &&
+	       cfg1->odr == cfg2->odr &&
+	       cfg1->ref_sel == cfg2->ref_sel;
+}
+
+static struct ad7173_channel_config *
+ad7173_find_live_config(struct ad7173_state *st, struct ad7173_channel_config *cfg)
+{
+	struct ad7173_channel_config *cfg_aux;
+	int i;
+
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
-		if (cfg_aux->live &&
-		    cfg->bipolar == cfg_aux->bipolar &&
-		    cfg->input_buf == cfg_aux->input_buf &&
-		    cfg->odr == cfg_aux->odr &&
-		    cfg->ref_sel == cfg_aux->ref_sel)
+		if (cfg_aux->live && ad7173_is_setup_equal(cfg, cfg_aux))
 			return cfg_aux;
 	}
 	return NULL;
@@ -1228,7 +1243,7 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
-	int i, ret;
+	int i, j, k, ret;
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		if (test_bit(i, scan_mask))
@@ -1239,6 +1254,54 @@ static int ad7173_update_scan_mode(struct iio_dev *indio_dev,
 			return ret;
 	}
 
+	/*
+	 * On some chips, there are more channels that setups, so if there were
+	 * more unique setups requested than the number of available slots,
+	 * ad7173_set_channel() will have written over some of the slots. We
+	 * can detect this by making sure each assigned cfg_slot matches the
+	 * requested configuration. If it doesn't, we know that the slot was
+	 * overwritten by a different channel.
+	 */
+	for_each_set_bit(i, scan_mask, indio_dev->num_channels) {
+		const struct ad7173_channel_config *cfg1, *cfg2;
+
+		cfg1 = &st->channels[i].cfg;
+
+		for_each_set_bit(j, scan_mask, indio_dev->num_channels) {
+			cfg2 = &st->channels[j].cfg;
+
+			/*
+			 * Only compare configs that are assigned to the same
+			 * SETUP_SEL slot and don't compare channel to itself.
+			 */
+			if (i == j || cfg1->cfg_slot != cfg2->cfg_slot)
+				continue;
+
+			/*
+			 * If we find two different configs trying to use the
+			 * same SETUP_SEL slot, then we know that the that we
+			 * have too many unique configurations requested for
+			 * the available slots and at least one was overwritten.
+			 */
+			if (!ad7173_is_setup_equal(cfg1, cfg2)) {
+				/*
+				 * At this point, there isn't a way to tell
+				 * which setups are actually programmed in the
+				 * ADC anymore, so we could read them back to
+				 * see, but it is simpler to just turn off all
+				 * of the live flags so that everything gets
+				 * reprogramed on the next attempt read a sample.
+				 */
+				for (k = 0; k < st->num_channels; k++)
+					st->channels[k].cfg.live = false;
+
+				dev_err(&st->sd.spi->dev,
+					"Too many unique channel configurations requested for scan\n");
+				return -EINVAL;
+			}
+		}
+	}
+
 	return 0;
 }
 
-- 
2.50.1



