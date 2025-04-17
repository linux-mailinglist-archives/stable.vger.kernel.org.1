Return-Path: <stable+bounces-133039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726BA91AAE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B8719E58E5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC2B23C385;
	Thu, 17 Apr 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nx3Z70hn"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A5227B83
	for <Stable@vger.kernel.org>; Thu, 17 Apr 2025 11:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889052; cv=none; b=FfKh9sRhJN+WGunvFjTRZsqwdlD6afuFg9MlttEsS50OnKLX2Dpy/1g6oLMqC0NWnvrbCbq/J3SJOlxqLDXMe1QBDgqcI3oCmueqMWq986LDNO+CmpLWZ/X048z0lDoGeLSdhpAdn0UbWXUQWzCMobsWL4mAf1jgCngNUyzSbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889052; c=relaxed/simple;
	bh=OcLx7XXUyycGfZ1C6jn6ENfFqNo3LgCv4eNVX5WE7As=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MFKP4u+Ok4Qjw9PLJQq0rC6IKfIhyciU1UeVygwfD/aFqDr7X+FvdZcoABPP+S1QHHnjYjJmKA+kqBPLlh8aWrxke57fRjum08Pt6GuJqaP4BT12tRgKkI2VW3g0X0W5X2afj3TqfrlXmLEK9TN0cq2QGp5mCG7g0pUIZdvmdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nx3Z70hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2974C4CEE4;
	Thu, 17 Apr 2025 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889052;
	bh=OcLx7XXUyycGfZ1C6jn6ENfFqNo3LgCv4eNVX5WE7As=;
	h=Subject:To:Cc:From:Date:From;
	b=Nx3Z70hnmjNZa4/oRX/FmIArwrp8fnY2uU4aMZajVagaXvUL6mK3+UxkwlRooX5Mb
	 oFNNtLxSubRai91SoNr0m+vD87ZenIUYfDGbVAa41Yl0CjfGhedSSD87cB7uNL/EYh
	 hvOUzciplJmArJOHVXoy/rZvLeBBEv8OYWlbl9T4=
Subject: FAILED: patch "[PATCH] iio: adc: ad7768-1: Fix conversion result sign" failed to apply to 5.10-stable tree
To: sergiu.cuciurean@analog.com,Jonathan.Cameron@huawei.com,Jonathan.Santos@analog.com,Stable@vger.kernel.org,dlechner@baylibre.com,marcelo.schmitt@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:05:59 +0200
Message-ID: <2025041759-dreamlike-hardener-e878@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8236644f5ecb180e80ad92d691c22bc509b747bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-dreamlike-hardener-e878@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8236644f5ecb180e80ad92d691c22bc509b747bb Mon Sep 17 00:00:00 2001
From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Date: Thu, 6 Mar 2025 18:00:29 -0300
Subject: [PATCH] iio: adc: ad7768-1: Fix conversion result sign

The ad7768-1 ADC output code is two's complement, meaning that the voltage
conversion result is a signed value.. Since the value is a 24 bit one,
stored in a 32 bit variable, the sign should be extended in order to get
the correct representation.

Also the channel description has been updated to signed representation,
to match the ADC specifications.

Fixes: a5f8c7da3dbe ("iio: adc: Add AD7768-1 ADC basic support")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <Stable@vger.kernel.org>
Link: https://patch.msgid.link/505994d3b71c2aa38ba714d909a68e021f12124c.1741268122.git.Jonathan.Santos@analog.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index ea829c51e80b..09e7cccfd51c 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -142,7 +142,7 @@ static const struct iio_chan_spec ad7768_channels[] = {
 		.channel = 0,
 		.scan_index = 0,
 		.scan_type = {
-			.sign = 'u',
+			.sign = 's',
 			.realbits = 24,
 			.storagebits = 32,
 			.shift = 8,
@@ -373,7 +373,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 		iio_device_release_direct(indio_dev);
 		if (ret < 0)
 			return ret;
-		*val = ret;
+		*val = sign_extend32(ret, chan->scan_type.realbits - 1);
 
 		return IIO_VAL_INT;
 


