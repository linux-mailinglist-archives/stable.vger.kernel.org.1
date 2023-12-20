Return-Path: <stable+bounces-8175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F7981A675
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 18:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654B51C257DE
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 17:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCBF4777F;
	Wed, 20 Dec 2023 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6QGjwz1"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52CF482CB
	for <Stable@vger.kernel.org>; Wed, 20 Dec 2023 17:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4D5C433C7;
	Wed, 20 Dec 2023 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703093771;
	bh=c9LsYkTMvMzAHuof4HNSALb09CTsOylzrziN5owztiQ=;
	h=Subject:To:From:Date:From;
	b=u6QGjwz1GM3+y7FD4pEjsQg+/ZDdIvwVO2Td+rWTSjh/GWUhtJ73ZARQbEXnWvEYQ
	 T2BlgQw+kdqGiyy8w8zRLQ0QUd1ujUIb0PkpOzKkBzjRM9+CS//nneFZvhMLaNWTMP
	 Qabe7M9Cw9RW5o9oDhgAys7IBJCHHd6U0/0yC/P8=
Subject: patch "iio: adc: ad7091r: Pass iio_dev to event handler" added to char-misc-next
To: marcelo.schmitt@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Dec 2023 17:19:33 +0100
Message-ID: <2023122033-camping-glitter-55b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7091r: Pass iio_dev to event handler

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From a25a7df518fc71b1ba981d691e9322e645d2689c Mon Sep 17 00:00:00 2001
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Sat, 16 Dec 2023 14:46:11 -0300
Subject: iio: adc: ad7091r: Pass iio_dev to event handler

Previous version of ad7091r event handler received the ADC state pointer
and retrieved the iio device from driver data field with dev_get_drvdata().
However, no driver data have ever been set, which led to null pointer
dereference when running the event handler.

Pass the iio device to the event handler and retrieve the ADC state struct
from it so we avoid the null pointer dereference and save the driver from
filling the driver data field.

Fixes: ca69300173b6 ("iio: adc: Add support for AD7091R5 ADC")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Link: https://lore.kernel.org/r/5024b764107463de9578d5b3b0a3d5678e307b1a.1702746240.git.marcelo.schmitt1@gmail.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad7091r-base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 8e252cde735b..0e5d3d2e9c98 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -174,8 +174,8 @@ static const struct iio_info ad7091r_info = {
 
 static irqreturn_t ad7091r_event_handler(int irq, void *private)
 {
-	struct ad7091r_state *st = (struct ad7091r_state *) private;
-	struct iio_dev *iio_dev = dev_get_drvdata(st->dev);
+	struct iio_dev *iio_dev = private;
+	struct ad7091r_state *st = iio_priv(iio_dev);
 	unsigned int i, read_val;
 	int ret;
 	s64 timestamp = iio_get_time_ns(iio_dev);
@@ -234,7 +234,7 @@ int ad7091r_probe(struct device *dev, const char *name,
 	if (irq) {
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				ad7091r_event_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, st);
+				IRQF_TRIGGER_FALLING | IRQF_ONESHOT, name, iio_dev);
 		if (ret)
 			return ret;
 	}
-- 
2.43.0



