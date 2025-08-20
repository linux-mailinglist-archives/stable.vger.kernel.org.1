Return-Path: <stable+bounces-171881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F3EB2D78B
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 11:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D8E189792B
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5267283153;
	Wed, 20 Aug 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B+zh0VzU"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653361DF74F
	for <Stable@vger.kernel.org>; Wed, 20 Aug 2025 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680763; cv=none; b=hXmty+c6XFeDO4j/NZu27NZaffaACLXagEFUUkcWrX+BPGwq+83PidP+hDg1QNM7fEYn4XGxEkVh5wFh6yvoSE8WpNG/WhfG/tyUdRInuMFF+OZ+WT5coTc0cqtCTwZhUf1artjwAS+iwWZpe474BFF3kCN9R6BUd9lrAc6Ubls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680763; c=relaxed/simple;
	bh=NQELbs/h8hw0O6nTsi9p955iFd7hqt/8Dov8jDzXn2o=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=uFkrMTDKZHX/DR7qYvu/K5k5cP76nvEkBm7n/Yt5XdfS8ozxTg3WsGzHBhojYBQIQ+30/hnoAMe99yC1s/jzTpyUGlZ8pBy15iBCMkXqwStCkl9nhTfWg8EcVGtsW+8mzA2qDfWhsIjcYdQlWxmdb+ZJJsVIWs6+uDNxLuKW6eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B+zh0VzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7991C4CEEB;
	Wed, 20 Aug 2025 09:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755680763;
	bh=NQELbs/h8hw0O6nTsi9p955iFd7hqt/8Dov8jDzXn2o=;
	h=Subject:To:From:Date:From;
	b=B+zh0VzUwq3AXXvJ5Q1PmNCbYbSDdT+zk2LNJg7Ym0r0uDT1fY3d0NM7pU+71VI4i
	 axFJ5YKVtnDqhy/dp8+KVpv3gkX+sBKmjkkb9H2a4kuFokPHB+ZKPd8Epy0rEQCkxD
	 z1yU2I/FCMR5Dq1SvE6EDtbyzoFkwSHZde+MIvcs=
Subject: patch "iio: adc: rzg2l_adc: Set driver data before enabling runtime PM" added to char-misc-linus
To: claudiu.beznea.uj@bp.renesas.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 Aug 2025 11:05:36 +0200
Message-ID: <2025082036-chaplain-scientist-87b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From c69e13965f26b8058f538ea8bdbd2d7718cf1fbe Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Sun, 10 Aug 2025 15:33:28 +0300
Subject: iio: adc: rzg2l_adc: Set driver data before enabling runtime PM

When stress-testing the system by repeatedly unbinding and binding the ADC
device in a loop, and the ADC is a supplier for another device (e.g., a
thermal hardware block that reads temperature through the ADC), it may
happen that the ADC device is runtime-resumed immediately after runtime PM
is enabled, triggered by its consumer. At this point, since drvdata is not
yet set and the driver's runtime PM callbacks rely on it, a crash can
occur. To avoid this, set drvdata just after it was allocated.

Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250810123328.800104-3-claudiu.beznea.uj@bp.renesas.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/rzg2l_adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 0cb5a67fd497..cadb0446bc29 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -427,6 +427,8 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (!indio_dev)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, indio_dev);
+
 	adc = iio_priv(indio_dev);
 
 	adc->hw_params = device_get_match_data(dev);
@@ -459,8 +461,6 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, indio_dev);
-
 	ret = rzg2l_adc_hw_init(dev, adc);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
-- 
2.50.1



