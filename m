Return-Path: <stable+bounces-172065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D304B2FA3A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E40621658
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA332C30E;
	Thu, 21 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="za9SFu0p"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D263277AA
	for <Stable@vger.kernel.org>; Thu, 21 Aug 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782210; cv=none; b=Qk2x9TVb6ryj+eRqB3/eLw5enKniv52a8RrF82SwL/ft5qo7kRdWYqkndCR7EDVMcPPtVbtOCnALTf4XQWNen55AFiosLpGXdJpU0PEhF/+KYvo7CIxSRlL+iTTym6FOMNqMDY2281/eHz9QGCbYcU/NzzHQP6epHUJBMyNbMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782210; c=relaxed/simple;
	bh=KLd+n4RzpbEAwRa3A2QB0iGgTJmOHXolkFu0MgEoFjw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mIARJ4SvfnzdbSpsZ6+LVmXcutyyrSGuXEc5TANewt7pyk9wgVJGVgjbv0kS3TmIx0unZsAmQQ5/E5ccjYDEbyhmy9S3qpR8JwRa4KCDdvOwQo9VPi5gJC7BwjzDq26KAJRnqjm96voQbzMatb96Nhx432uafAzmB9oqFKra+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=za9SFu0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4558C113CF;
	Thu, 21 Aug 2025 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782210;
	bh=KLd+n4RzpbEAwRa3A2QB0iGgTJmOHXolkFu0MgEoFjw=;
	h=Subject:To:Cc:From:Date:From;
	b=za9SFu0pX1uwiof6e5ee0ckNPFIqdhh9py0pzJtsgf5S9krYwhYBne7W4mOm2CJxE
	 eL29rrT2lxC4cB3hgvMROYXyomSINGXzGoXoeTg4V4J7NT7cATAADVujO0WNCSIZxN
	 9ObhxJo59g4HnQSZRnTgXb8hLYC9QAX5Lo7Y1vNc=
Subject: FAILED: patch "[PATCH] iio: adc: ad7173: fix setting ODR in probe" failed to apply to 6.12-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:14:35 +0200
Message-ID: <2025082135-slept-video-cdcc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6fa908abd19cc35c205f343b79c67ff38dbc9b76
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082135-slept-video-cdcc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6fa908abd19cc35c205f343b79c67ff38dbc9b76 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 10 Jul 2025 15:43:40 -0500
Subject: [PATCH] iio: adc: ad7173: fix setting ODR in probe

Fix the setting of the ODR register value in the probe function for
AD7177. The AD7177 chip has a different ODR value after reset than the
other chips (0x7 vs. 0x0) and 0 is a reserved value on that chip.

The driver already has this information available in odr_start_value
and uses it when checking valid values when writing to the
sampling_frequency attribute, but failed to set the correct initial
value in the probe function.

Fixes: 37ae8381ccda ("iio: adc: ad7173: add support for additional models")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250710-iio-adc-ad7173-fix-setting-odr-in-probe-v1-1-78a100fec998@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 2173455c0169..4413207be28f 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1589,6 +1589,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 		if (st->info->data_reg_only_16bit)
@@ -1655,7 +1656,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->scan_index = chan_index;
 		chan->channel = ain[0];
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
-		chan_st_priv->cfg.odr = 0;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 		chan_st_priv->cfg.openwire_comp_chan = -1;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");


