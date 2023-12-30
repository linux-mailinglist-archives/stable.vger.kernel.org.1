Return-Path: <stable+bounces-8717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D8820465
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB552820C4
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44B01FCF;
	Sat, 30 Dec 2023 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dR7XXVDp"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E023AE
	for <Stable@vger.kernel.org>; Sat, 30 Dec 2023 10:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C357C433C8;
	Sat, 30 Dec 2023 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703933826;
	bh=ljmCpZ8NNzdQMTMo4yZOLJOBsB0/6l9LhBaTWGezPhw=;
	h=Subject:To:Cc:From:Date:From;
	b=dR7XXVDpO00+acDXLREQ95PZEEFGc48D0gWHNCWa/wGCWYbCl/YKxwXXZXiLay9xU
	 c0LYcVsP06DEbpNfOfQ30b9I9Ej1pQoztRGOHpTQubCqzITnd+dfLUieY61CQZwxfa
	 g09KSregPMNRHnJ/PyYJAmls+wuXqfbGk0nl3wfQ=
Subject: FAILED: patch "[PATCH] iio: adc: MCP3564: fix calib_bias and calib_scale range" failed to apply to 6.6-stable tree
To: javier.carrasco.cruz@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,marius.cristea@microchip.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 30 Dec 2023 10:57:04 +0000
Message-ID: <2023123004-hangup-empirical-5092@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 85ac6d92fdfd6097a16d9c61363fe1d0272c1604
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023123004-hangup-empirical-5092@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

85ac6d92fdfd ("iio: adc: MCP3564: fix calib_bias and calib_scale range checks")
33ec3e5fc1ea ("iio: adc: adding support for MCP3564 ADC")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85ac6d92fdfd6097a16d9c61363fe1d0272c1604 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 1 Dec 2023 10:48:03 +0100
Subject: [PATCH] iio: adc: MCP3564: fix calib_bias and calib_scale range
 checks

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


