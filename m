Return-Path: <stable+bounces-73960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871D970EA7
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0380C1F22793
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 06:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABD1AC45F;
	Mon,  9 Sep 2024 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dv+YXuS7"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268911F95E
	for <Stable@vger.kernel.org>; Mon,  9 Sep 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864927; cv=none; b=rgHX1f37UfxoyfNeoCaRIW0664KzMEm8uzPF0gr3ID2s9EWezhHrV7Fn4XMdr+qi8NxJrf/GJem2oh7bbFBhmxFWgcYHTUI2Sgddxr40FDYxNU81JZlnbFKcDDgkLNWFOiESiFRHZCfEKJn5rksO/6xm1yJioRlhV1I0MqmZ/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864927; c=relaxed/simple;
	bh=qPmFX2DVko+K1tVImH2ATXskxfpCq7i7N37nrBJN5tw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RxWqtSkMjSxj0dCCAsHgYasJMS82PvGvZu6jF71+4zPWHnPLpOzcJyhI4R4AT7Lqq888MjVrSSxiT3/aDRwFFsbStiYykNpJ0V0+0KUd1wRQuG5gLy55aWF80wMFkQJ2C4zPpjNZC7NCtLZkJk+TixVF745djvVJf58IRhJ0YTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dv+YXuS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B2C4CEC5;
	Mon,  9 Sep 2024 06:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725864926;
	bh=qPmFX2DVko+K1tVImH2ATXskxfpCq7i7N37nrBJN5tw=;
	h=Subject:To:Cc:From:Date:From;
	b=dv+YXuS7BB5B82bRrXuIaKfxR0FKPxnkYBFI9eEj6+oW3LpmR8QlvkpTYG5/mNqmF
	 epvUWBQxsyUeJEfL7mypqP9CO1eYdT0ShCfgZaH8IHbPXGMyIO8Omx1mSc+CNRmSjS
	 KcrOqVISIu+RZTxmsAtuSeuz48zfjJCsqCPgFeqo=
Subject: FAILED: patch "[PATCH] iio: adc: ad7124: fix DT configuration parsing" failed to apply to 6.1-stable tree
To: mitrutzceclan@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dumitru.ceclan@analog.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Sep 2024 08:55:15 +0200
Message-ID: <2024090915-luridness-parameter-3447@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 61cbfb5368dd50ed0d65ce21d305aa923581db2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090915-luridness-parameter-3447@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

61cbfb5368dd ("iio: adc: ad7124: fix DT configuration parsing")
a6eaf02b8274 ("iio: adc: ad7124: Switch from of specific to fwnode based property handling")
1240c94ce819 ("iio: adc: Explicitly include correct DT includes")
4c077429b422 ("iio: mlx90614: Sort headers")
a99544c6c883 ("iio: adc: palmas: add support for iio threshold events")
2d48dbdfc7d4 ("iio: adc: palmas: move eventX_enable into palmas_adc_event")
7501a3a97e4f ("iio: adc: palmas: use iio_event_direction for threshold polarity")
d2ab4eea732d ("iio: adc: palmas: replace "wakeup" with "event"")
79d9622d622d ("iio: adc: palmas: remove adc_wakeupX_data")
6d52b0e70698 ("iio: adc: palmas: Take probe fully device managed.")
49f76c499d38 ("iio: adc: palmas_gpadc: fix NULL dereference on rmmod")
3a258747a01f ("iio: adc: ad7124: Silence no spi_device_id warnings")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 61cbfb5368dd50ed0d65ce21d305aa923581db2b Mon Sep 17 00:00:00 2001
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
Date: Tue, 6 Aug 2024 11:51:33 +0300
Subject: [PATCH] iio: adc: ad7124: fix DT configuration parsing

The cfg pointer is set before reading the channel number that the
configuration should point to. This causes configurations to be shifted
by one channel.
For example setting bipolar to the first channel defined in the DT will
cause bipolar mode to be active on the second defined channel.

Fix by moving the cfg pointer setting after reading the channel number.

Fixes: 7b8d045e497a ("iio: adc: ad7124: allow more than 8 channels")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240806085133.114547-1-dumitru.ceclan@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index afb5f4d741e6..108e9ccab1ef 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -844,8 +844,6 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 	st->channels = channels;
 
 	device_for_each_child_node_scoped(dev, child) {
-		cfg = &st->channels[channel].cfg;
-
 		ret = fwnode_property_read_u32(child, "reg", &channel);
 		if (ret)
 			return ret;
@@ -863,6 +861,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 		st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
 						  AD7124_CHANNEL_AINM(ain[1]);
 
+		cfg = &st->channels[channel].cfg;
 		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
 
 		ret = fwnode_property_read_u32(child, "adi,reference-select", &tmp);


