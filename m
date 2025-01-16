Return-Path: <stable+bounces-109264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4CBA13A30
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 13:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFAC18892F0
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E33A1DE89B;
	Thu, 16 Jan 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a4AvWYvF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F89D1DE892
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737031614; cv=none; b=QSap3bjtA0S0Xeu19kfH9UV5CsM29IZll4xZAyqT6Et4j7AOabzytctBNWoHWxtRXFeweqW0AKzpKNMgUjFY3yMuWUDHPMaNRsp/35VC0ShW8uL9amX++BDcJTFN4/R7l7OqQDuDfJm/l1RUtDSNOrP8rK72S2yicWKNt9jdupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737031614; c=relaxed/simple;
	bh=iGB0mjgfGz02lJERVrFhyVvNez/tA1ojYkrYMtOx1JQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=P8Ave8mQyDYyX8Waq690HPlXSmxQMMM/BrGJl2UXdL/wAPJ5SLAmpD9y93SimfX4nj/QWOKMScij29g9Cx3lib9ug6pa7LbBe9faitEBlFUYjKdIUnOUjXeGzBoFDhbkP1+6v9qjckP4FaK2evunS4vZUJisePqXbT88LvQWUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a4AvWYvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872DAC4CED6;
	Thu, 16 Jan 2025 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737031613;
	bh=iGB0mjgfGz02lJERVrFhyVvNez/tA1ojYkrYMtOx1JQ=;
	h=Subject:To:From:Date:From;
	b=a4AvWYvFM7F6TL7YKD+6FdksiWk8sSw9rney5raXkDfEiVWY/BFxF/ISko6rIuThf
	 7v05SJcGEKF9zNVJdnoofx6ro5FGAf+mNDLtubA1tkEyqkONNH3/hRNrEUikNHX/aB
	 U+XZsxomR7LSHJqeoa4wHM4wlGdUYIVryYJj+NOA=
Subject: patch "iio: chemical: bme680: Fix uninitialized variable in" added to char-misc-next
To: dan.carpenter@linaro.org,Jonathan.Cameron@huawei.com,stable@vger.kernel.org,vassilisamir@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jan 2025 13:46:38 +0100
Message-ID: <2025011638-retrace-symphony-9325@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: bme680: Fix uninitialized variable in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 20eb1fae4145bc45717aa8a6d05fcd6a64ed856a Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Wed, 8 Jan 2025 12:37:22 +0300
Subject: iio: chemical: bme680: Fix uninitialized variable in
 __bme680_read_raw()

The bme680_read_temp() function takes a pointer to s16 but we're passing
an int pointer to it.  This will not work on big endian systems and it
also means that the other 16 bits are uninitialized.

Pass an s16 type variable.

Fixes: f51171ce2236 ("iio: chemical: bme680: Add SCALE and RAW channels")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://patch.msgid.link/4addb68c-853a-49fc-8d40-739e78db5fa1@stanley.mountain
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index d12270409c8a..a2949daf9467 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -874,11 +874,11 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
 		case IIO_TEMP:
-			ret = bme680_read_temp(data, (s16 *)&chan_val);
+			ret = bme680_read_temp(data, &temp_chan_val);
 			if (ret)
 				return ret;
 
-			*val = chan_val;
+			*val = temp_chan_val;
 			return IIO_VAL_INT;
 		case IIO_PRESSURE:
 			ret = bme680_read_press(data, &chan_val);
-- 
2.48.1



