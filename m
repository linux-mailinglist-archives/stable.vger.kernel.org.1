Return-Path: <stable+bounces-208353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10067D1E605
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E85C0300CEFB
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72438B983;
	Wed, 14 Jan 2026 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQ0jWCR6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B0387573
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389954; cv=none; b=GmNyETtX5lcfok/VMw+qy9uqtoLu4gyTdHjankGuoxO/EHb0b3IPtKwP/gh9eoGxdr6+qBPViv+gd0EF4tLD/Ly+0kFhT41sThihxIZG0h5QaprOb9AOw+/XRpRZz1j+F1YHQZIzKEBy8XG0piWPH1W+H/4r7c4FrjrA0BoEVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389954; c=relaxed/simple;
	bh=YnW1T5dv+zhFD5/Igz9S46EtP8pAJvWGRw2LUld34eU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=YgsrAr7NRuR0pUsWVPIDhxu+2Ra1bbO1B/Z0BZqcRYuKtRnpDHgIjnLZkzK3N+fZD73DqJCRk/IdH7ZTLfjE7wTRUoazHuxjuC8dmVdz7CrJ0mh7LVjY5tuFvADH/+LUb0u7lA1WR+mDUkjK9BSyqqigwO4IIar8ZgpbZHQFy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQ0jWCR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FCEC4CEF7;
	Wed, 14 Jan 2026 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768389953;
	bh=YnW1T5dv+zhFD5/Igz9S46EtP8pAJvWGRw2LUld34eU=;
	h=Subject:To:From:Date:From;
	b=rQ0jWCR6V2luSWdJrjxYutfRj7DM2LUBO/bgxujzt+lMxvl1rx2r5OeEUKDxJkw/6
	 BclJTrzNoZJyMcBApyE7g7JjvvntfahM+DJFS+PaWZO7/qSDL5XSLyAWI4KWiSY+rG
	 c9+9pSsC4w8LQN7NJBPD2YSKgJoPOCx1gkCqeI9Q=
Subject: patch "iio: chemical: scd4x: fix reported channel endianness" added to char-misc-linus
To: fiona.klute@gmx.de,Jonathan.Cameron@huawei.com,dlechner@baylibre.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Jan 2026 12:25:07 +0100
Message-ID: <2026011407-snugness-tiptop-efbd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: scd4x: fix reported channel endianness

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 81d5a5366d3c20203fb9d7345e1aa46d668445a2 Mon Sep 17 00:00:00 2001
From: Fiona Klute <fiona.klute@gmx.de>
Date: Sat, 13 Dec 2025 17:32:26 +0100
Subject: iio: chemical: scd4x: fix reported channel endianness

The driver converts values read from the sensor from BE to CPU
endianness in scd4x_read_meas(). The result is then pushed into the
buffer in scd4x_trigger_handler(), so on LE architectures parsing the
buffer using the reported BE type gave wrong results.

scd4x_read_raw() which provides sysfs *_raw values is not affected, it
used the values returned by scd4x_read_meas() without further
conversion.

Fixes: 49d22b695cbb6 ("drivers: iio: chemical: Add support for Sensirion SCD4x CO2 sensor")
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/chemical/scd4x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 8859f89fb2a9..0fd839176e26 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -584,7 +584,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -599,7 +599,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 	{
@@ -612,7 +612,7 @@ static const struct iio_chan_spec scd4x_channels[] = {
 			.sign = 'u',
 			.realbits = 16,
 			.storagebits = 16,
-			.endianness = IIO_BE,
+			.endianness = IIO_CPU,
 		},
 	},
 };
-- 
2.52.0



