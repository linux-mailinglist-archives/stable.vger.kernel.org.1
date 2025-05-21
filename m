Return-Path: <stable+bounces-145829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D21ABF425
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 14:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7BD4E00EB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 12:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAD9267B00;
	Wed, 21 May 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="futF1SDO"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E4267F66
	for <Stable@vger.kernel.org>; Wed, 21 May 2025 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829837; cv=none; b=iEoJo0AoWP4/sQ5FWzELU4E5DjU9bO4iXh8oPuHG7jIL1wxf7S9pnLC7ptrtmMiKh1s30le5DGutlF5ioICiHeVRD7oSrOyJa5TQHA6FQtkB3TP0GGzMiD0P5S8npC3pvkXBk8Y2ZF3QmOfJD2e4GtTaye21yHPhbXCXGvFyz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829837; c=relaxed/simple;
	bh=KwdXM5HE/qOMVbh9nX81WSdxTbNMwIYN7e1S99toLQI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=fhqIN1eK7XkQXhFQNJ1+5bhhq2mT/mV3cjOoiZBl482KnV1wXUDaLF6FV4VyhmmtPPae11NSRiUons5SRM23V00Ph2eISrh9RbTpmzuXHl5WIyrGZ6mN9eL8xxqdRUwr7LAMLTn1VmsviqNHhDV5Lfl7C7ieawZvIfgURaMQ9P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=futF1SDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EECC4CEE4;
	Wed, 21 May 2025 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829837;
	bh=KwdXM5HE/qOMVbh9nX81WSdxTbNMwIYN7e1S99toLQI=;
	h=Subject:To:From:Date:From;
	b=futF1SDOk6yzEoNkAjBBg40stYnYPiNlaxiYpbuUbkMf8imj1wWJCIeg3mxwLhV68
	 U077DmZDAA2bHZChxD/ahTubk6CbJD8MMRLNcrbp9uEvND1vlWbGnBXV5jm92nunB/
	 /0t9YfWfRWaH4AuEgREtiAWL/zJLbPjME8ENpyjg=
Subject: patch "iio: adc: ad7944: mask high bits on direct read" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 May 2025 14:16:15 +0200
Message-ID: <2025052115-stadium-morphing-2dec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7944: mask high bits on direct read

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 7cdfbc0113d087348b8e65dd79276d0f57b89a10 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 5 May 2025 13:28:40 -0500
Subject: iio: adc: ad7944: mask high bits on direct read
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Apply a mask to the raw value received over the SPI bus for unsigned
direct reads. As we found recently, SPI controllers may not set unused
bits to 0 when reading with bits_per_word != {8,16,32}. The ad7944 uses
bits_per_word of 14 and 18, so we need to mask the value to be sure we
returning the correct value to userspace during a direct read.

Fixes: d1efcf8871db ("iio: adc: ad7944: add driver for AD7944/AD7985/AD7986")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250505-iio-adc-ad7944-max-high-bits-on-direct-read-v1-1-b173facceefe@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7944.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 2f949fe55873..37a137bd8357 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -377,6 +377,8 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 
 	if (chan->scan_type.sign == 's')
 		*val = sign_extend32(*val, chan->scan_type.realbits - 1);
+	else
+		*val &= GENMASK(chan->scan_type.realbits - 1, 0);
 
 	return IIO_VAL_INT;
 }
-- 
2.49.0



