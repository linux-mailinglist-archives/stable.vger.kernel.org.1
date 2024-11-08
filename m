Return-Path: <stable+bounces-91943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA39C2143
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D8E1F23D47
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ACF21A712;
	Fri,  8 Nov 2024 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xbJcvIpc"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312AA1F5820
	for <Stable@vger.kernel.org>; Fri,  8 Nov 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081404; cv=none; b=rTqTnAJMYOwk+pg1xwP9zWB500HStl5UkkH4o9/YSDH/p+dvm1oenVTZpD89FVRPN2FbPM+Nlwt8LImrdt78HthVYftcLmFudLxrpqHe0+2Ta0XBIkiHMSXwvmIxGYzBN48iM9M8oz2EqIMIiPbdlu1CU+NmqbUgAx1t7lxgQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081404; c=relaxed/simple;
	bh=RrBV4c/5dFj7qrrTWMoOD/YsdvuV/x0ewJ+wkcD3gGM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=nbJSuxle47u6r6A3t4R2KR7AbU75NOos53GFZaiphbZhNO8F3ENu4OpbaO4gWc4iw0/iB5vSzNjJ3fLA7oPCU7NkKcEB6LHunUskmdyPq1tpx44lyyF47RY7/FiwxYHjpGbcu0y+I0Vxiws7yjjuxquJ9l9Tiwd5i9KeV/wtepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xbJcvIpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540E8C4CECD;
	Fri,  8 Nov 2024 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081403;
	bh=RrBV4c/5dFj7qrrTWMoOD/YsdvuV/x0ewJ+wkcD3gGM=;
	h=Subject:To:From:Date:From;
	b=xbJcvIpcfxMF4bsNRbNUkvRyyOwvPppMy3wwmIDOSlgY3APjNUdo7bP16osXFpICz
	 k6bacJ2T4VmISl2ExDaaCAM9Uxbh6HDJ8Ed6PbF841FL+K4Z0A8fTIW/5KcnKQLp57
	 73WFdzNyYt4wjlniEI6HUXH5QBsElARKxhFZPTxI=
Subject: patch "iio: accel: kx022a: Fix raw read format" added to char-misc-next
To: mazziesaccount@gmail.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,kaleposti@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 08 Nov 2024 16:56:06 +0100
Message-ID: <2024110806-swell-entitle-e8df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: accel: kx022a: Fix raw read format

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From b7d2bc99b3bdc03fff9b416dd830632346d83530 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Wed, 30 Oct 2024 15:16:11 +0200
Subject: iio: accel: kx022a: Fix raw read format

The KX022A provides the accelerometer data in two subsequent registers.
The registers are laid out so that the value obtained via bulk-read of
these registers can be interpreted as signed 16-bit little endian value.
The read value is converted to cpu_endianes and stored into 32bit integer.
The le16_to_cpu() casts value to unsigned 16-bit value, and when this is
assigned to 32-bit integer the resulting value will always be positive.

This has not been a problem to users (at least not all users) of the sysfs
interface, who know the data format based on the scan info and who have
converted the read value back to 16-bit signed value. This isn't
compliant with the ABI however.

This, however, will be a problem for those who use the in-kernel
interfaces, especially the iio_read_channel_processed_scale().

The iio_read_channel_processed_scale() performs multiplications to the
returned (always positive) raw value, which will cause strange results
when the data from the sensor has been negative.

Fix the read_raw format by casting the result of the le_to_cpu() to
signed 16-bit value before assigning it to the integer. This will make
the negative readings to be correctly reported as negative.

This fix will be visible to users by changing values returned via sysfs
to appear in correct (negative) format.

Reported-by: Kalle Niemi <kaleposti@gmail.com>
Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Tested-by: Kalle Niemi <kaleposti@gmail.com>
Cc: <Stable@vger.kernel.org>
Link: https://patch.msgid.link/ZyIxm_zamZfIGrnB@mva-rohm
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 53d59a04ae15..b6a828a6df93 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -594,7 +594,7 @@ static int kx022a_get_axis(struct kx022a_data *data,
 	if (ret)
 		return ret;
 
-	*val = le16_to_cpu(data->buffer[0]);
+	*val = (s16)le16_to_cpu(data->buffer[0]);
 
 	return IIO_VAL_INT;
 }
-- 
2.47.0



