Return-Path: <stable+bounces-145822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D52ABF419
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9933C1899724
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C0267392;
	Wed, 21 May 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PG6Jyi3o"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCF1267AF6
	for <Stable@vger.kernel.org>; Wed, 21 May 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829794; cv=none; b=H55/fIWgDKL6RbG2vEPixaWw05ult+xBTfPgKfEST7CcnJeLY+1T5QhpVvFxaWnZ3R4CQFwCVvjCFgi5LKXDnw+l3c09aZF2jg3tKn+mtEv7bCV6LYvMmcHXL4rqyDz6m4zcdnUKHiMjCbuTdjuvLTb/Qfi6H/YQ9u9NrF9dVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829794; c=relaxed/simple;
	bh=pH5m1q/gVUkxTuEL4pm5iOgVe5AmXSaihc81W0lDtcI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=IQTPzkfuZnJlCenJge/KYO12G8bZ5JQ5R8Z+CYAtJ77F+YnQdtmARsHeTcdsnOYr8ucfWjBGM+b93F1ygue+9aXSqObvPrpj2DbEur8v7MwP5AkAzYfPwv1Y4Kfye6gaCgKZi8BVwBoXJFKRMpDJ4COgTqvOKFYZGXeofAYbLQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PG6Jyi3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7CC4CEE4;
	Wed, 21 May 2025 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829793;
	bh=pH5m1q/gVUkxTuEL4pm5iOgVe5AmXSaihc81W0lDtcI=;
	h=Subject:To:From:Date:From;
	b=PG6Jyi3oZJJ4f4ahBrw3ZyWnPFvWY+z/sIcey9WF518a6Mv9QBawErG/p6Ck/eGSZ
	 PE8urFcSXgB5cFB+EOk7KEB6TGk1qh0av3mcNOFHD8WH6nECSwj6Of9eD5mUUDQ1lJ
	 AK55Na+iydChZf32ELV72IqbJSXMLPbbJWf2Y1aI=
Subject: patch "iio: adc: ad7606: fix raw read for 18-bit chips" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 14:16:09 +0200
Message-ID: <2025052109-handwash-duchess-2936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7606: fix raw read for 18-bit chips

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 3f5fd1717ae9497215f22aa748fc2c09df88b0e3 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 2 May 2025 10:04:30 -0500
Subject: iio: adc: ad7606: fix raw read for 18-bit chips

Fix 18-bit raw read for 18-bit chips by applying a mask to the value
we receive from the SPI controller.

SPI controllers either return 1, 2 or 4 bytes per word depending on the
bits_per_word. For 16-bit chips, there was no problem since they raw
data fit exactly in the 2 bytes received from the SPI controller. But
now that we have 18-bit chips and we are using bits_per_word = 18, we
cannot assume that the extra bits in the 32-bit word are always zero.
In fact, with the AXI SPI Engine controller, these bits are not always
zero which caused the raw values to read 10s of 1000s of volts instead
of the correct value. Therefore, we need to mask the value we receive
from the SPI controller to ensure that only the 18 bits of real data
are used.

Fixes: f3838e934dff ("iio: adc: ad7606: add support for AD7606C-{16,18} parts")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7606.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 703556eb7257..8ed65a35b486 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -727,17 +727,16 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 		goto error_ret;
 
 	chan = &indio_dev->channels[ch + 1];
-	if (chan->scan_type.sign == 'u') {
-		if (realbits > 16)
-			*val = st->data.buf32[ch];
-		else
-			*val = st->data.buf16[ch];
-	} else {
-		if (realbits > 16)
-			*val = sign_extend32(st->data.buf32[ch], realbits - 1);
-		else
-			*val = sign_extend32(st->data.buf16[ch], realbits - 1);
-	}
+
+	if (realbits > 16)
+		*val = st->data.buf32[ch];
+	else
+		*val = st->data.buf16[ch];
+
+	*val &= GENMASK(realbits - 1, 0);
+
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(*val, realbits - 1);
 
 error_ret:
 	if (!st->gpio_convst) {
-- 
2.49.0



