Return-Path: <stable+bounces-20185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 744EE854C9C
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301A1287ABF
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADAC5C8F8;
	Wed, 14 Feb 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NQZPqQpT"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4BA5C615
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924371; cv=none; b=ohssEDNpbDsjy8q6HsyETqHHMpcnJ0nqokhYDQrrr0o47LHZGEcYka3/RRykmXfxumsF/qRNK4lkk1gTFIM7jNPxGAMONayEdOL1aW8iMiX7HpK3Zl/ZcTvg0N4MHPrbYc1CK2jNa12R7O84Dfc4mBup8gpvU2cFkwpNVxgT0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924371; c=relaxed/simple;
	bh=kRgnwvZqGKzNNMdiuSizJCIAIKGvyoetADvESC248Vs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ZRxkmQ7UZb7OEw1mZkNs2siYG2rpSqbN0dktK1XTyWk/Ux3sU6ZATKYSCaPJA0ru7GPeZw5xly3nDHM1LhWrNmOxBS8s3U9FS5RtLgmihb/BkoKpaa6ktH+w0NJ3AzL+h8Bf8S2KZNnnAyTRTlbUfWdX0sjOdVKSSyTEk4apuoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NQZPqQpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE1DC433C7;
	Wed, 14 Feb 2024 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924369;
	bh=kRgnwvZqGKzNNMdiuSizJCIAIKGvyoetADvESC248Vs=;
	h=Subject:To:From:Date:From;
	b=NQZPqQpTh5ujygLE6EEcYgOOS9/zLn625v3Lyd7JKiFk0EWbjIJXO1/5UcTm9lSrg
	 AMfWUgfHbvPOC+2xgBdUABb33Y+oIWYvYfdkUJyz4Tutmr534nCyrfdA2dLVt+khtD
	 H9t9RUC/BG8c2huBLSTPMN5ka5Z4YNuGZ1IKI5WE=
Subject: patch "iio: magnetometer: rm3100: add boundary check for the value read from" added to char-misc-linus
To: zhili.liu@ucas.com.cn,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,zhouzhouyi@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:03 +0100
Message-ID: <2024021403-stature-negate-4fc0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: rm3100: add boundary check for the value read from

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 792595bab4925aa06532a14dd256db523eb4fa5e Mon Sep 17 00:00:00 2001
From: "zhili.liu" <zhili.liu@ucas.com.cn>
Date: Tue, 2 Jan 2024 09:07:11 +0800
Subject: iio: magnetometer: rm3100: add boundary check for the value read from
 RM3100_REG_TMRC

Recently, we encounter kernel crash in function rm3100_common_probe
caused by out of bound access of array rm3100_samp_rates (because of
underlying hardware failures). Add boundary check to prevent out of
bound access.

Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")
Suggested-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
Link: https://lore.kernel.org/r/1704157631-3814-1-git-send-email-zhouzhouyi@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 69938204456f..42b70cd42b39 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -530,6 +530,7 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	struct rm3100_data *data;
 	unsigned int tmp;
 	int ret;
+	int samp_rate_index;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
@@ -586,9 +587,14 @@ int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
 	if (ret < 0)
 		return ret;
+
+	samp_rate_index = tmp - RM3100_TMRC_OFFSET;
+	if (samp_rate_index < 0 || samp_rate_index >=  RM3100_SAMP_NUM) {
+		dev_err(dev, "The value read from RM3100_REG_TMRC is invalid!\n");
+		return -EINVAL;
+	}
 	/* Initializing max wait time, which is double conversion time. */
-	data->conversion_time = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2]
-				* 2;
+	data->conversion_time = rm3100_samp_rates[samp_rate_index][2] * 2;
 
 	/* Cycle count values may not be what we want. */
 	if ((tmp - RM3100_TMRC_OFFSET) == 0)
-- 
2.43.1



