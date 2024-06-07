Return-Path: <stable+bounces-50002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C079900C3F
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8327B22469
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2325E13E8BE;
	Fri,  7 Jun 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kuLZY/zC"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735061FF6
	for <Stable@vger.kernel.org>; Fri,  7 Jun 2024 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787210; cv=none; b=UWXMmWvhFkhWjNgLYyHmuhIYavMN+lyXSijRA42Xkn55rVE4nMWtbKf7tgWxXxyWOBmDiPCjDufhbRWJ4ZGeqBjACsOwx2KcdJycDmsroAB6WdTiX/NZawOl4vhzuzTZJQcgQXU7wUnYSeiqYcc6y+HjqndfS82SM9HJxlI3nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787210; c=relaxed/simple;
	bh=gQEMazL5tEeC6AZUPPc68RbwLd0tUxL569yE/5fWAaY=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jlzn3DR36qbz0RnWy70r8WJGlPCxYBqshVJXCYVzWDikN/PxPGN44AICS2MvYP370n5M7OErdX9eOzVYuKc2gHhurt+wzVe8pubTbcGIP3hUk2ls+rkCuntWr/63kPoW9qZtb2Zh9woh9B0imqZ0CjQxQYo6jwPzurlOjaQGM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kuLZY/zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACF7C32781;
	Fri,  7 Jun 2024 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787210;
	bh=gQEMazL5tEeC6AZUPPc68RbwLd0tUxL569yE/5fWAaY=;
	h=Subject:To:From:Date:From;
	b=kuLZY/zCOp9M0bHQaKUdJWXmlp/pmED0Zp+4i98GGdySCH4wQfdMHxuHrKf/ZgHJh
	 9gjHBRYg0o168PIe/zWaB1GD3mfPII3V8+UxhnNdjuaZf0i9D4JxvN6ISlO/qgMauB
	 P7+tidf4yEHO8T5GKffd+C3Fe6HkQhxCImi2XZhY=
Subject: patch "iio: dac: ad5592r: fix temperature channel scaling value" added to char-misc-linus
To: marc.ferland@sonatest.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Jun 2024 21:06:48 +0200
Message-ID: <2024060748-compost-refueling-740b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad5592r: fix temperature channel scaling value

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 279428df888319bf68f2686934897301a250bb84 Mon Sep 17 00:00:00 2001
From: Marc Ferland <marc.ferland@sonatest.com>
Date: Wed, 1 May 2024 11:05:54 -0400
Subject: iio: dac: ad5592r: fix temperature channel scaling value

The scale value for the temperature channel is (assuming Vref=2.5 and
the datasheet):

    376.7897513

When calculating both val and val2 for the temperature scale we
use (3767897513/25) and multiply it by Vref (here I assume 2500mV) to
obtain:

  2500 * (3767897513/25) ==> 376789751300

Finally we divide with remainder by 10^9 to get:

    val = 376
    val2 = 789751300

However, we return IIO_VAL_INT_PLUS_MICRO (should have been NANO) as
the scale type. So when converting the raw temperature value to the
'processed' temperature value we will get (assuming raw=810,
offset=-753):

    processed = (raw + offset) * scale_val
              = (810 + -753) * 376
	      = 21432

    processed += div((raw + offset) * scale_val2, 10^6)
              += div((810 + -753) * 789751300, 10^6)
	      += 45015
    ==> 66447
    ==> 66.4 Celcius

instead of the expected 21.5 Celsius.

Fix this issue by changing IIO_VAL_INT_PLUS_MICRO to
IIO_VAL_INT_PLUS_NANO.

Fixes: 56ca9db862bf ("iio: dac: Add support for the AD5592R/AD5593R ADCs/DACs")
Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
Link: https://lore.kernel.org/r/20240501150554.1871390-1-marc.ferland@sonatest.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 076bc9ecfb49..4763402dbcd6 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -415,7 +415,7 @@ static int ad5592r_read_raw(struct iio_dev *iio_dev,
 			s64 tmp = *val * (3767897513LL / 25LL);
 			*val = div_s64_rem(tmp, 1000000000LL, val2);
 
-			return IIO_VAL_INT_PLUS_MICRO;
+			return IIO_VAL_INT_PLUS_NANO;
 		}
 
 		mutex_lock(&st->lock);
-- 
2.45.2



