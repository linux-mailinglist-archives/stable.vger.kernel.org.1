Return-Path: <stable+bounces-139327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9CAA60EE
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 17:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C5464084
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7015B1BF37;
	Thu,  1 May 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WUkNM0ZF"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140C2045AD
	for <Stable@vger.kernel.org>; Thu,  1 May 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746114611; cv=none; b=RnkO/UHi9GCI5eu19DVxff50KGFOnnmyJ/RZYoadMSP36JLUtTZOBt8um7JX1oeUR3XKOxBpYK84/x+TSvF13uRzJMXvTCYhonRILIBfzRB4dNWs1NdOAzQdjVJZON9GeNEzd88ZBMs7x35bdUYFm6dc6zqMTZBlUB5/ZQh2Tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746114611; c=relaxed/simple;
	bh=Y8ABU3Q1SrL9dj/yVHyPPlQrghcdMrBk3sm3JYWwPGM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=b2oz3KB4IiLAzlM0nVkPBb7+IhJamACjZv7V69MQ2ndnts1Xl++5MnYGUSWEZs4a6HlT0/X871za4+ZbCKqj0GlIzHooobKs3iPcb0vQAoWVMGmV7YEMRDXw6xAhLGkboKKqfIkdkc0ziV4q1V+Kw7GXX+JDpoRLy29UVtdhT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WUkNM0ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92195C4CEED;
	Thu,  1 May 2025 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746114611;
	bh=Y8ABU3Q1SrL9dj/yVHyPPlQrghcdMrBk3sm3JYWwPGM=;
	h=Subject:To:From:Date:From;
	b=WUkNM0ZFabjKAPgzVJ30/XAFbV9YJPTlCBRFBlkJb1rOXB85HM8xwpAwE7OcNS0j+
	 gNznm2W5qpEu1FcsMC0yqiCgbWoXuPL+xmUt1etcRNhWMjQu01Vgrb1MmpUpZ++WLS
	 R9MUVo41W/py9Vyty1TB+I9s/8y8y1mpLxeR8AI8=
Subject: patch "iio: imu: adis16550: align buffers for timestamp" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 01 May 2025 17:49:02 +0200
Message-ID: <2025050102-embezzle-primal-43ed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: imu: adis16550: align buffers for timestamp

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e4570f4bb231f01e32d44fd38841665f340d6914 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 11:17:13 -0500
Subject: iio: imu: adis16550: align buffers for timestamp

Align the buffers used with iio_push_to_buffers_with_timestamp() to
ensure the s64 timestamp is aligned to 8 bytes.

Fixes: bac4368fab62 ("iio: imu: adis16550: add adis16550 support")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250418-iio-more-timestamp-alignment-v2-1-d6a5d2b1c9fe@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/imu/adis16550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index b14ea8937c7f..28f0dbd0226c 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -836,7 +836,7 @@ static irqreturn_t adis16550_trigger_handler(int irq, void *p)
 	u16 dummy;
 	bool valid;
 	struct iio_poll_func *pf = p;
-	__be32 data[ADIS16550_MAX_SCAN_DATA];
+	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16550 *st = iio_priv(indio_dev);
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
-- 
2.49.0



