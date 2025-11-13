Return-Path: <stable+bounces-194749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DFEC5A570
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D74B74E7BC7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5632E427C;
	Thu, 13 Nov 2025 22:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HuO36wM0"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF52DEA83
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073306; cv=none; b=psRSyMjslfw/Fyum9TYs9ORRmoPvKWK3FVqUMTPCcR29vodgv8Ig4+Kh7at5ccXdsi8PFK1+cARjNYnuvprYfggJOTN8DDub5AZ7jEUV5/yCVuCPgkhTHUdoFu9wERui1JMEOmZqSI/iOSTrkMg66naiuT5QCyLQawJUFgNkBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073306; c=relaxed/simple;
	bh=mABrEOxdCyAK7mMzoDqzwzKWxC/hFrrtbojXj1EwAZ8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BtLtgoQ7pLYp0iThSfyagP2mKyR4PycQx2Gh5LTV8hyOcXbiRtK/K5yEtBM5pklIKSC9nYhfQw9Ps5+51t39nVwxrbCG9VUwj4aPKrb0F0uJjdxYPPZaSNcL3pYkVx+PUby5fEAl6CyBtZ4ooyo5ZPw2biFUb2tt5I2fj0+7Yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HuO36wM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4026C2BCB1;
	Thu, 13 Nov 2025 22:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073304;
	bh=mABrEOxdCyAK7mMzoDqzwzKWxC/hFrrtbojXj1EwAZ8=;
	h=Subject:To:From:Date:From;
	b=HuO36wM0L0Y+w+H+eVbs5L2dEbA40ksVQdvGqA+xXpiIH+A+eBYi/XtCv88bpjW50
	 LWWKLUhUS3lAEKdwyBViuaHFerbf9sN8lr7DFxoSopgOGQylEwpQsdZNIexWoKVt6o
	 DcdUQa3EMT6AIsjTnD19c7M2AEnjvYwVYJc5dhzk=
Subject: patch "iio: adc: ad7280a: fix ad7280_store_balance_timer()" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:52 -0500
Message-ID: <2025111352-collision-gooey-8da7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7280a: fix ad7280_store_balance_timer()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From bd886cdcbf9e746f61c74035a3acd42e9108e115 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Oct 2025 10:44:45 -0500
Subject: iio: adc: ad7280a: fix ad7280_store_balance_timer()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use correct argument to iio_str_to_fixpoint() to parse 3 decimal places.

iio_str_to_fixpoint() has a bit of an unintuitive API where the
fract_mult parameter is the multiplier of the first decimal place as if
it was already an integer.  So to get 3 decimal places, fract_mult must
be 100 rather than 1000.

Fixes: 96ccdbc07a74 ("staging:iio:adc:ad7280a: Standardize extended ABI naming")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7280a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7280a.c b/drivers/iio/adc/ad7280a.c
index dda2986ccda0..50a6ff7c8b1c 100644
--- a/drivers/iio/adc/ad7280a.c
+++ b/drivers/iio/adc/ad7280a.c
@@ -541,7 +541,7 @@ static ssize_t ad7280_store_balance_timer(struct iio_dev *indio_dev,
 	int val, val2;
 	int ret;
 
-	ret = iio_str_to_fixpoint(buf, 1000, &val, &val2);
+	ret = iio_str_to_fixpoint(buf, 100, &val, &val2);
 	if (ret)
 		return ret;
 
-- 
2.51.2



