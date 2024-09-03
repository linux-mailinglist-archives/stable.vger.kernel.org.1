Return-Path: <stable+bounces-72811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74A2969A60
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494EEB22030
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3CB1A4E7C;
	Tue,  3 Sep 2024 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qOqmGOV9"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58919CC3F
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360104; cv=none; b=Sz0UYs+//CrIXEksHtGlXEj3n1BNDbK8zP1Agzov1+Jmzwo9YPI1Y7KUm0q4zGiyauOCGYZhnbfHUwAYZsOL2jLsEZ+KxQcoxP67pnOBRS1jmrchYjdN38FuK2VHvuTfNrx1DoegBItQ4M80zsyJ5sQsKBm0O87Qts7lpvMT0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360104; c=relaxed/simple;
	bh=AkFZyHKQwlV/sQpD5xruzAMVGzmCIxLl1RPUxcYtJRw=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=LulDHh2hP5sKNEpli8QP2qUgzuSalDeMz499vHb4F87X4PdgmV7SGSEc1Hk9V6IaDAY82pmYLf3hbze/ND/qYyjJl/qF9YsPqohwIW2ogSho7RatutBqrIn51bwM1FO9fDjH3fNhD4+xbGkL+QaQvKF0UQklEgmOhzr1zP3qU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qOqmGOV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B1CC4CEC4;
	Tue,  3 Sep 2024 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360103;
	bh=AkFZyHKQwlV/sQpD5xruzAMVGzmCIxLl1RPUxcYtJRw=;
	h=Subject:To:From:Date:From;
	b=qOqmGOV9GuDRgs0kl2/4nzZGmGE8FIzN+QdvbQ5pFVlJLBoGX/5NxK8eOI4h0PwfR
	 U0Y7izeo9Fiabk7WLl0DDTZ7COtnrfzGtxjYEDCN9jTxi8bjoywfDgZYOagqEsl9kg
	 T/HARaCKG7L48wWIfgyk87EdQumSbBW18yOEmf3I=
Subject: patch "staging: iio: frequency: ad9834: Validate frequency parameter value" added to char-misc-linus
To: amishin@t-argos.ru,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dan.carpenter@linaro.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:01 +0200
Message-ID: <2024090301-donut-depletion-a67e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    staging: iio: frequency: ad9834: Validate frequency parameter value

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b48aa991758999d4e8f9296c5bbe388f293ef465 Mon Sep 17 00:00:00 2001
From: Aleksandr Mishin <amishin@t-argos.ru>
Date: Wed, 3 Jul 2024 18:45:06 +0300
Subject: staging: iio: frequency: ad9834: Validate frequency parameter value

In ad9834_write_frequency() clk_get_rate() can return 0. In such case
ad9834_calc_freqreg() call will lead to division by zero. Checking
'if (fout > (clk_freq / 2))' doesn't protect in case of 'fout' is 0.
ad9834_write_frequency() is called from ad9834_write(), where fout is
taken from text buffer, which can contain any value.

Modify parameters checking.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://patch.msgid.link/20240703154506.25584-1-amishin@t-argos.ru
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/frequency/ad9834.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index a7a5cdcc6590..47e7d7e6d920 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -114,7 +114,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	clk_freq = clk_get_rate(st->mclk);
 
-	if (fout > (clk_freq / 2))
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);
-- 
2.46.0



