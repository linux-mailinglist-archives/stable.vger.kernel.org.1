Return-Path: <stable+bounces-6420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34D80E682
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655781F22029
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CE3249FF;
	Tue, 12 Dec 2023 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RrfTRjaN"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BF5199D1
	for <Stable@vger.kernel.org>; Tue, 12 Dec 2023 08:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392C2C433C8;
	Tue, 12 Dec 2023 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702370661;
	bh=xXvkO38rCDPqQ9QaYC74LFwJO2lp1E3hW3Q0yU51mAs=;
	h=Subject:To:From:Date:From;
	b=RrfTRjaNug0kiY9zxkGjdOqekQxMtLiy0Md/ge/JD/khBi9z5zeHssg4aS3F+4Re2
	 45DkT69k/d3jZ/BI7omJeQmls7k/+Am4Ko+iN4mP0zRfXIr8xs1pblK3r4wH+B2CYP
	 6ApquE2Hk6mNKHcC9JT4y8Y5dVlL/EJVu9z+obUk=
Subject: patch "iio: adc: MCP3564: fix calib_bias and calib_scale range checks" added to char-misc-linus
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,marius.cristea@microchip.com
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Dec 2023 09:43:48 +0100
Message-ID: <2023121248-sizing-stegosaur-ef3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: MCP3564: fix calib_bias and calib_scale range checks

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 85ac6d92fdfd6097a16d9c61363fe1d0272c1604 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 1 Dec 2023 10:48:03 +0100
Subject: iio: adc: MCP3564: fix calib_bias and calib_scale range checks

The current implementation uses the AND (&&) operator to check if the
value to write for IIO_CHAN_INFO_CALIBBIAS and IIO_CHAN_INFO_CALIBSCALE
is within the valid ranges.
The evaluated values are the lower and upper limits of the ranges,
so this operation always evaluates to false.

The OR (||) operator must be used instead.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reviewed-by: Marius Cristea <marius.cristea@microchip.com>
Link: https://lore.kernel.org/r/20231201-mcp3564_range_checks-v1-1-68f4436e22b0@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/mcp3564.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index e3f1de5fcc5a..d5fb1cae8aeb 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -918,7 +918,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&adc->lock);
 		return ret;
 	case IIO_CHAN_INFO_CALIBBIAS:
-		if (val < mcp3564_calib_bias[0] && val > mcp3564_calib_bias[2])
+		if (val < mcp3564_calib_bias[0] || val > mcp3564_calib_bias[2])
 			return -EINVAL;
 
 		mutex_lock(&adc->lock);
@@ -928,7 +928,7 @@ static int mcp3564_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&adc->lock);
 		return ret;
 	case IIO_CHAN_INFO_CALIBSCALE:
-		if (val < mcp3564_calib_scale[0] && val > mcp3564_calib_scale[2])
+		if (val < mcp3564_calib_scale[0] || val > mcp3564_calib_scale[2])
 			return -EINVAL;
 
 		if (adc->calib_scale == val)
-- 
2.43.0



