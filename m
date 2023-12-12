Return-Path: <stable+bounces-6414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D968280E683
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4761F22016
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C85E38FB2;
	Tue, 12 Dec 2023 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w+IxtxYK"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B1249FF
	for <Stable@vger.kernel.org>; Tue, 12 Dec 2023 08:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AEAC433C8;
	Tue, 12 Dec 2023 08:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370630;
	bh=675F6gFF3FY9cRuA3Hu3m5X6CEqj0eQ1uHbvmVoi4o8=;
	h=Subject:To:From:Date:From;
	b=w+IxtxYKBv4W1LWtIq6t4qIKbLk8DgCr0b+DuacjCjLWt+MclpyhtUHjnXdsFI1q1
	 WqC1DZETMhvvB4fFfOFglL3GpVqZFk1ReuN31IUVfKTTpyShxhm9dl8Xwj0sK3x760
	 fef9rX9srHkp8+/EhooTgGOAtzVWCnyOTkhz8m/E=
Subject: patch "iio: tmag5273: fix temperature offset" added to char-misc-linus
To: javier.carrasco@wolfvision.net,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:43:42 +0100
Message-ID: <2023121241-radiation-flatware-565a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: tmag5273: fix temperature offset

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3b8157ec4573e304a29b7bced627e144dbc3dfdb Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Tue, 21 Nov 2023 06:48:39 +0100
Subject: iio: tmag5273: fix temperature offset

The current offset has the scale already applied to it. The ABI
documentation defines the offset parameter as "offset to be added
to <type>[Y]_raw prior to scaling by <type>[Y]_scale in order to
obtain value in the <type> units as specified in <type>[Y]_raw
documentation"

The right value is obtained at 0 degrees Celsius by the formula provided
in the datasheet:

T = Tsens_t0 + (Tadc_t - Tadc_t0) / Tadc_res

where:
T = 0 degrees Celsius
Tsens_t0 (reference temperature) = 25 degrees Celsius
Tadc_t0 (16-bit format for Tsens_t0) = 17508
Tadc_res = 60.1 LSB/degree Celsius

The resulting offset is 16005.5, which has been truncated to 16005 to
provide an integer value with a precision loss smaller than the 1-LSB
measurement precision.

Fix the offset to apply its value prior to scaling.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
Link: https://lore.kernel.org/r/9879beec-05fc-4fc6-af62-d771e238954e@wolfvision.net
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/magnetometer/tmag5273.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index c5e5c4ad681e..e8c4ca142d21 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -356,7 +356,7 @@ static int tmag5273_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = -266314;
+			*val = -16005;
 			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
-- 
2.43.0



