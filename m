Return-Path: <stable+bounces-163422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A57B0AE8F
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE8A16C3EF
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A222069A;
	Sat, 19 Jul 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SzgKRj/K"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546B533EC
	for <Stable@vger.kernel.org>; Sat, 19 Jul 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752912754; cv=none; b=OY8JdSfk9WNJwnRiGV/CN1mnCXFOU2jg/ykkOhoTDivI83GnUDS3FBVnjJKIDSMPp9UD9HoplFP7T6fLXoc5FrPR1oQMjDcl2SQfFw0TlKb/LlAFYawofC9mcEZK9jbeWESk4VdtorhT4TWoyu+g/mnkcO//eQHj/w8C8Vq4nv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752912754; c=relaxed/simple;
	bh=HfJfM1N/ptwks5oHyfkSwcjpWxDH52dduGY+nka/ukc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=hw1fG6pC2IoMis7/w+A5/aWHP1s1vAt14s9Qb6NlbZXgiTY9eK+1VwBB1H4CVT8khNrGACgVgm1EKtaVh1jbszOogNg/rSmktxftTeZhRg97t5qnGvJQGghzVd8hlnirGqz+AvFfaC1GsJWXENj9q4hW846TvBLx+8+V56sTLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SzgKRj/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7C2C4CEE3;
	Sat, 19 Jul 2025 08:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752912753;
	bh=HfJfM1N/ptwks5oHyfkSwcjpWxDH52dduGY+nka/ukc=;
	h=Subject:To:From:Date:From;
	b=SzgKRj/KTzPonVE8xTlseOj0foY6SqIm7LocoecK6CFJjtYhgR6qphQiu9nPmfPEl
	 +y8KAk7WxfhHu1L4CKVK2h/URT82SZHakt4g5y59tXXN8f0vCG+7Z2SPyY28Se9+ab
	 fXbVKOe6Hcg5dCbvctXCdyyHlOzNnzfF79Kp3wN8=
Subject: patch "iio: adc: ad7173: fix channels index for syscalib_mode" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 19 Jul 2025 09:51:42 +0200
Message-ID: <2025071942-dandy-swagger-f9d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7173: fix channels index for syscalib_mode

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 0eb8d7b25397330beab8ee62c681975b79f37223 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 3 Jul 2025 14:51:17 -0500
Subject: iio: adc: ad7173: fix channels index for syscalib_mode

Fix the index used to look up the channel when accessing the
syscalib_mode attribute. The address field is a 0-based index (same
as scan_index) that it used to access the channel in the
ad7173_channels array throughout the driver. The channels field, on
the other hand, may not match the address field depending on the
channel configuration specified in the device tree and could result
in an out-of-bounds access.

Fixes: 031bdc8aee01 ("iio: adc: ad7173: add calibration support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-v1-1-7fdaedb9cac0@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7173.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index dd9fa35555c7..03412895f6dc 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -318,7 +318,7 @@ static int ad7173_set_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 
-	st->channels[chan->channel].syscalib_mode = mode;
+	st->channels[chan->address].syscalib_mode = mode;
 
 	return 0;
 }
@@ -328,7 +328,7 @@ static int ad7173_get_syscalib_mode(struct iio_dev *indio_dev,
 {
 	struct ad7173_state *st = iio_priv(indio_dev);
 
-	return st->channels[chan->channel].syscalib_mode;
+	return st->channels[chan->address].syscalib_mode;
 }
 
 static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
@@ -347,7 +347,7 @@ static ssize_t ad7173_write_syscalib(struct iio_dev *indio_dev,
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
-	mode = st->channels[chan->channel].syscalib_mode;
+	mode = st->channels[chan->address].syscalib_mode;
 	if (sys_calib) {
 		if (mode == AD7173_SYSCALIB_ZERO_SCALE)
 			ret = ad_sd_calibrate(&st->sd, AD7173_MODE_CAL_SYS_ZERO,
-- 
2.50.1



