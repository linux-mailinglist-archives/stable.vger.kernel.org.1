Return-Path: <stable+bounces-12805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A482A8373F6
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67EF1C26474
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883B3FB3D;
	Mon, 22 Jan 2024 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wZt3zLYt"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262E27715
	for <Stable@vger.kernel.org>; Mon, 22 Jan 2024 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955929; cv=none; b=fLI+jbCuMy3Ebjh9Lk/aXTRikMlDFG4G5oVxMxyIehUj0Ad/K3nyrI7jketquU68TVijXj0xs63TpgIAJJBMUPI0UCOb95j2N0ovm8wZeC3cm7MLBai55RzNt6PxefCm7uak9ccbJBOnEPpPPRlcrZakGaDpBVvunpi4L2c4K/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955929; c=relaxed/simple;
	bh=pqR97vW1kEh56tQyz+XhKYOHkzLgP0IEDfYv6gd5iZk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=abqy/grmn6c+NGzuxErAIoeNU6mGlokqIdI1lXet+o1xrx6RNhtLaXGr1fOl2kTGZyuiy3YfeZpa6zppja3rMETe+nBuEC6HZ4V32b14bNLxQTfEXeKTZE1Er2s12sygZ4FgMuym3HzGuqPOR4XbPx2ABIr1KfZYANASQ2qints=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wZt3zLYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32754C433C7;
	Mon, 22 Jan 2024 20:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705955928;
	bh=pqR97vW1kEh56tQyz+XhKYOHkzLgP0IEDfYv6gd5iZk=;
	h=Subject:To:Cc:From:Date:From;
	b=wZt3zLYtbsI2SxdY+IsmHpk84uTnep/LPmYGPphZgvFzB9mIhSSLzFfZJrc/OCB/G
	 Vx+pRzNmIKgslwicS8lidGlnFabGbkfkK+h4+b9xVCJvKu4GSKImp6SkcWsHQNGP4f
	 dALzrO+EoLI+LiehhiLgYb0eL0v4KkxSqt2JsZW8=
Subject: FAILED: patch "[PATCH] iio: adc: ad7091r: Enable internal vref if external vref is" failed to apply to 6.7-stable tree
To: marcelo.schmitt@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:38:45 -0800
Message-ID: <2024012245-silica-scrabble-5c66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x e71c5c89bcb165a02df35325aa13d1ee40112401
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012245-silica-scrabble-5c66@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

e71c5c89bcb1 ("iio: adc: ad7091r: Enable internal vref if external vref is not supplied")
020e71c7ffc2 ("iio: adc: ad7091r: Allow users to configure device events")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e71c5c89bcb165a02df35325aa13d1ee40112401 Mon Sep 17 00:00:00 2001
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Tue, 19 Dec 2023 17:26:27 -0300
Subject: [PATCH] iio: adc: ad7091r: Enable internal vref if external vref is
 not supplied

The ADC needs a voltage reference to work correctly.
Users can provide an external voltage reference or use the chip internal
reference to operate the ADC.
The availability of an in chip reference for the ADC saves the user from
having to supply an external voltage reference, which makes the external
reference an optional property as described in the device tree
documentation.
Though, to use the internal reference, it must be enabled by writing to
the configuration register.
Enable AD7091R internal voltage reference if no external vref is supplied.

Fixes: 260442cc5be4 ("iio: adc: ad7091r5: Add scale and external VREF support")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Link: https://lore.kernel.org/r/b865033fa6a4fc4bf2b4a98ec51a6144e0f64f77.1703013352.git.marcelo.schmitt1@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 6d93da154810..7ccc9b44dcd8 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -406,7 +406,14 @@ int ad7091r_probe(struct device *dev, const char *name,
 	if (IS_ERR(st->vref)) {
 		if (PTR_ERR(st->vref) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+
 		st->vref = NULL;
+		/* Enable internal vref */
+		ret = regmap_set_bits(st->map, AD7091R_REG_CONF,
+				      AD7091R_REG_CONF_INT_VREF);
+		if (ret)
+			return dev_err_probe(st->dev, ret,
+					     "Error on enable internal reference\n");
 	} else {
 		ret = regulator_enable(st->vref);
 		if (ret)
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 7a78976a2f80..b9e1c8bf3440 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -8,6 +8,8 @@
 #ifndef __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 #define __DRIVERS_IIO_ADC_AD7091R_BASE_H__
 
+#define AD7091R_REG_CONF_INT_VREF	BIT(0)
+
 /* AD7091R_REG_CH_LIMIT */
 #define AD7091R_HIGH_LIMIT		0xFFF
 #define AD7091R_LOW_LIMIT		0x0


