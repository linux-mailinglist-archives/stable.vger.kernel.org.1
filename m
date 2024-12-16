Return-Path: <stable+bounces-104370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525279F348D
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 726CA7A0420
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA000136345;
	Mon, 16 Dec 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESh8QwyX"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE40847B
	for <Stable@vger.kernel.org>; Mon, 16 Dec 2024 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363127; cv=none; b=k+NMCf0EjLVQaoOm1nOoeeO+GQgbVpbKbvohUvBuuc6OsGMVk4U4T9GKJO60Re7w5GT6D9s3mMSshGG3wvIkHT91oT8WHJSfEuTwuRu5f+5uqPJg3ufhVOz4xKAEwwVMAox3w3daCCLIt3G2+AgDqd0Oki9Oy3nBDYCKd/C0lxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363127; c=relaxed/simple;
	bh=m4KF27S/6h1OdHoYguTD+hSBXielCKDIc5gnRj946Sk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=RQmWtkTXt/ih3jXC4eu5niekgvHtJjhOQmVp4z+Synn6a4kpZc+j5Fbzoyom3uLcFmsxoR/fh34SZHw1YCJ+66ERpM2gTVTOnLE81sVUWR3Arp37BCTgz4wXKsSZivbNqjM5ZETqiiWmN305reEQqCc21JFty2IZZ/2C1GC7Q/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESh8QwyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E939C4CED4;
	Mon, 16 Dec 2024 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363127;
	bh=m4KF27S/6h1OdHoYguTD+hSBXielCKDIc5gnRj946Sk=;
	h=Subject:To:From:Date:From;
	b=ESh8QwyX2l4BKGzvw3qnLPNKCVzdTsXFjBTBX8hVyH4VhzglmcFnSEJ4UtbdCMdFV
	 phlW0pHdY4Gwe9+DZ8S1z2OlN5+zBY5xDecsK1eVIlrYuHIqYX55T0/AXmaZAS5Vec
	 f50wX7C607xcMSifAOi1wQTGTSCIPT8CdFxF3zaY=
Subject: patch "iio: adc: ti-ads1298: Add NULL check in ads1298_init" added to char-misc-linus
To: hanchunchao@inspur.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 16 Dec 2024 16:31:36 +0100
Message-ID: <2024121636-pectin-contend-fda2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1298: Add NULL check in ads1298_init

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From bcb394bb28e55312cace75362b8e489eb0e02a30 Mon Sep 17 00:00:00 2001
From: Charles Han <hanchunchao@inspur.com>
Date: Mon, 18 Nov 2024 17:02:08 +0800
Subject: iio: adc: ti-ads1298: Add NULL check in ads1298_init

devm_kasprintf() can return a NULL pointer on failure. A check on the
return value of such a call in ads1298_init() is missing. Add it.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
Link: https://patch.msgid.link/20241118090208.14586-1-hanchunchao@inspur.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 36d43495f603..03f762415fa5 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -613,6 +613,8 @@ static int ads1298_init(struct iio_dev *indio_dev)
 	}
 	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
 					 indio_dev->num_channels, suffix);
+	if (!indio_dev->name)
+		return -ENOMEM;
 
 	/* Enable internal test signal, double amplitude, double frequency */
 	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
-- 
2.47.1



