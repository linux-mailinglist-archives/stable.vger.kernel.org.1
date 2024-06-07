Return-Path: <stable+bounces-50000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC8A900C3C
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 21:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729E81C21BA6
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 19:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5261314036D;
	Fri,  7 Jun 2024 19:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="odwAGwD7"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CE513E3FD
	for <Stable@vger.kernel.org>; Fri,  7 Jun 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787208; cv=none; b=S7qv7VTloDutfDms13qfyOfaY0LkZGV2Q+TwtlWCUTRTCnfkci9mOqcre1TQff0SxQPP/64YTtnvBaANYBRWkVUzXZ8Gk4ZqA04mwO4MFBU/ABbJjYNZy4wFgXUS8G1gKoBKXzgrONtwydGZeSjV6V1XWVZG2hQwkSAQEFLNSo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787208; c=relaxed/simple;
	bh=RYGio//Kpb3oIRWoIX9Uhi2eXSWxc11UOfKenoBESJ0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=CU6r2EJVKbXeThtvEpZgy5frg/Et2TMl3kNo8ofrz4G26M9Rr0QcLSKwfNXluDKnmHDh1eNfFcHxTtRMqRtV17vkZW0SmPnfx5AlyBDH4N3B9Lf7PihFMw+f0ONr0/LHTEz9gpqB0gkXLBU6kaUpEXiGeZDmUUHLE1dWy7EUokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=odwAGwD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B65C2BBFC;
	Fri,  7 Jun 2024 19:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787207;
	bh=RYGio//Kpb3oIRWoIX9Uhi2eXSWxc11UOfKenoBESJ0=;
	h=Subject:To:From:Date:From;
	b=odwAGwD7igBYl5qrfNeLlNRxaZ/TGvo4vq0F019G3OZXtRwzgNnSkcyxahOhUWI2F
	 3JPN0lTwAnkQNuNNrq/zLK1dNkpcZAos8sPSF4vanbeoN5qgonMkz0/2n6kns9kZLX
	 1pNHc4+a8hXPczGBQF9+10mfWK1/5JztH7LzOqLw=
Subject: patch "iio: adc: ad9467: fix scan type sign" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Jun 2024 21:06:45 +0200
Message-ID: <2024060745-peroxide-curler-f43d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad9467: fix scan type sign

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 8a01ef749b0a632f0e1f4ead0f08b3310d99fcb1 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 3 May 2024 14:45:05 -0500
Subject: iio: adc: ad9467: fix scan type sign

According to the IIO documentation, the sign in the scan type should be
lower case. The ad9467 driver was incorrectly using upper case.

Fix by changing to lower case.

Fixes: 4606d0f4b05f ("iio: adc: ad9467: add support for AD9434 high-speed ADC")
Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://lore.kernel.org/r/20240503-ad9467-fix-scan-type-sign-v1-1-c7a1a066ebb9@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad9467.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index e85b763b9ffc..8f5b9c3f6e3d 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -243,11 +243,11 @@ static void __ad9467_get_scale(struct ad9467_state *st, int index,
 }
 
 static const struct iio_chan_spec ad9434_channels[] = {
-	AD9467_CHAN(0, 0, 12, 'S'),
+	AD9467_CHAN(0, 0, 12, 's'),
 };
 
 static const struct iio_chan_spec ad9467_channels[] = {
-	AD9467_CHAN(0, 0, 16, 'S'),
+	AD9467_CHAN(0, 0, 16, 's'),
 };
 
 static const struct ad9467_chip_info ad9467_chip_tbl = {
-- 
2.45.2



