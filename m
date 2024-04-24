Return-Path: <stable+bounces-41322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF948B0082
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 06:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9A5B23063
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 04:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333F13E8B2;
	Wed, 24 Apr 2024 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/7ie6yv"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5B13D886
	for <Stable@vger.kernel.org>; Wed, 24 Apr 2024 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932856; cv=none; b=I9XPYCd45unm6HHwIl0sKF+q+LZAfhF12VEBMwjYckPsJUE2Y/vBC94RS3utvcRTh9yw4zMkr9K7WBA2n/1ri+pBAbBNzIMsncHIyix4kw3DSdCTCCujqurOTnTBm/vb30+xGx/XEOqm1TE7H9Uq94RYVYy11XLywJriZUdbpn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932856; c=relaxed/simple;
	bh=wh+AOjSzhsRkH2Jhs0PuwiAvexZsTWn+csa4/WzrGZQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=e1tKjYOKEzxJSZnNK0X+gOn92JERTDYNs3/2cjGEWVR4nNuvNnAv4J32zvtRX7As3fPajLcqApl8Lz4aEbSQwY6rHdNfVv5RH0gC6LSW1rgcXV5NWu+KsEpS+BWFsdTnoX+Tm00k7C5l6AkBVJOVXiyRc41Pew7vD7w5vtEq9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/7ie6yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE955C3277B;
	Wed, 24 Apr 2024 04:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713932856;
	bh=wh+AOjSzhsRkH2Jhs0PuwiAvexZsTWn+csa4/WzrGZQ=;
	h=Subject:To:From:Date:From;
	b=W/7ie6yvGXwWlTMy+dSeVf87LkPV0sJ4ouxI+7dCzdOz8grDb+Xk1tBKDS/P+40ZB
	 TSlslWk3oHAq5DCkB5gxaS5q6G0naUy1nPmUrSn0USX6vUbK+78qAtUrC5tN3XI6TC
	 rfumOLMnNdC9+hj0QHxzlT94720D4BWGhP4TtpRc=
Subject: patch "iio: accel: mxc4005: Interrupt handling fixes" added to char-misc-linus
To: hdegoede@redhat.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 21:27:26 -0700
Message-ID: <2024042326-stuffing-yippee-5f58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: mxc4005: Interrupt handling fixes

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 57a1592784d622ecee0b71940c65429173996b33 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Mar 2024 12:36:59 +0100
Subject: iio: accel: mxc4005: Interrupt handling fixes

There are 2 issues with interrupt handling in the mxc4005 driver:

1. mxc4005_set_trigger_state() writes MXC4005_REG_INT_MASK1_BIT_DRDYE
(0x01) to INT_MASK1 to enable the interrupt, but to disable the interrupt
it writes ~MXC4005_REG_INT_MASK1_BIT_DRDYE which is 0xfe, so it enables
all other interrupt sources in the INT_SRC1 register. On the MXC4005 this
is not an issue because only bit 0 of the register is used. On the MXC6655
OTOH this is a problem since bit7 is used as TC (Temperature Compensation)
disable bit and writing 1 to this disables Temperature Compensation which
should only be done when running self-tests on the chip.

Write 0 instead of ~MXC4005_REG_INT_MASK1_BIT_DRDYE to disable
the interrupts to fix this.

2. The datasheets for the MXC4005 / MXC6655 do not state what the reset
value for the INT_MASK0 and INT_MASK1 registers is and since these are
write only we also cannot learn this from the hw. Presumably the reset
value for both is all 0, which means all interrupts disabled.

Explicitly set both registers to 0 from mxc4005_chip_init() to ensure
both masks are actually set to 0.

Fixes: 79846e33aac1 ("iio: accel: mxc4005: add support for mxc6655")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240326113700.56725-2-hdegoede@redhat.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mxc4005.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 61839be501c2..111f4bcf24ad 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -27,9 +27,13 @@
 #define MXC4005_REG_ZOUT_UPPER		0x07
 #define MXC4005_REG_ZOUT_LOWER		0x08
 
+#define MXC4005_REG_INT_MASK0		0x0A
+
 #define MXC4005_REG_INT_MASK1		0x0B
 #define MXC4005_REG_INT_MASK1_BIT_DRDYE	0x01
 
+#define MXC4005_REG_INT_CLR0		0x00
+
 #define MXC4005_REG_INT_CLR1		0x01
 #define MXC4005_REG_INT_CLR1_BIT_DRDYC	0x01
 
@@ -113,7 +117,9 @@ static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
 static bool mxc4005_is_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case MXC4005_REG_INT_CLR0:
 	case MXC4005_REG_INT_CLR1:
+	case MXC4005_REG_INT_MASK0:
 	case MXC4005_REG_INT_MASK1:
 	case MXC4005_REG_CONTROL:
 		return true;
@@ -330,17 +336,13 @@ static int mxc4005_set_trigger_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct mxc4005_data *data = iio_priv(indio_dev);
+	unsigned int val;
 	int ret;
 
 	mutex_lock(&data->mutex);
-	if (state) {
-		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
-				   MXC4005_REG_INT_MASK1_BIT_DRDYE);
-	} else {
-		ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1,
-				   ~MXC4005_REG_INT_MASK1_BIT_DRDYE);
-	}
 
+	val = state ? MXC4005_REG_INT_MASK1_BIT_DRDYE : 0;
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, val);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		dev_err(data->dev, "failed to update reg_int_mask1");
@@ -382,6 +384,14 @@ static int mxc4005_chip_init(struct mxc4005_data *data)
 
 	dev_dbg(data->dev, "MXC4005 chip id %02x\n", reg);
 
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK0, 0);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "writing INT_MASK0\n");
+
+	ret = regmap_write(data->regmap, MXC4005_REG_INT_MASK1, 0);
+	if (ret < 0)
+		return dev_err_probe(data->dev, ret, "writing INT_MASK1\n");
+
 	return 0;
 }
 
-- 
2.44.0



