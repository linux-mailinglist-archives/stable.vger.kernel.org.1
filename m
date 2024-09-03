Return-Path: <stable+bounces-72818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58EFA969A72
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F22D1F2423B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F511B984E;
	Tue,  3 Sep 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+HTKN7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C291B9849
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360132; cv=none; b=rzVNXvuIDzhZasmDkaayxNW/8hU/VhEq5Q9cC12PWBjax+hQXGBo9Ux+uclFY+R14ezvaawI1SG0ccor0I8kmOy46o+7p0vy01wHLa9bITZ9vA23znsm2D2lXTA3K9jX2GmHHpf+VdzI2La3Qhs9HydXWqhzKMwIGpkbYMXKOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360132; c=relaxed/simple;
	bh=TsMgtBXeweQhwX54HU7gOknGM1YulXcSvsz8l6VOsY8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=i/CTGyXuVAdt8DRifDIW/KdDO2j7s+Y2xcQPZwDhXV6i2Yyf20DOt6Uv2ir+I7Fyft3q7IZNr4f52hC+zBE9OqgZuW4ec1iNaMu6QZk9wymajC2CreiUxgLlGdwu29760VOAlXZTLzuZRO/LL9FxftFYHVsnvONBE5TP1bJH2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+HTKN7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0424C4CEC4;
	Tue,  3 Sep 2024 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360132;
	bh=TsMgtBXeweQhwX54HU7gOknGM1YulXcSvsz8l6VOsY8=;
	h=Subject:To:From:Date:From;
	b=N+HTKN7TRvCYTdDFE0Qcw2fTz1Be4bqPV1DYGNbaFSfnRMFmcGtrLMkJH0uwoviwp
	 U2OnnFRm0x5jm86Rk/VB8MJ5bwfZgW0fneGfJ2sFFfXMogs5hDc5GmFnpmJIATjyYI
	 TGqUUYn2YBICv0pGFxJqIbIVtLpVFo8a+BNTqF5s=
Subject: patch "iio: adc: ad_sigma_delta: fix irq_flags on irq request" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:06 +0200
Message-ID: <2024090306-seismic-refute-1108@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad_sigma_delta: fix irq_flags on irq request

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From e81bb580ec08d7503c14c92157d810d306290003 Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 6 Aug 2024 17:40:49 +0200
Subject: iio: adc: ad_sigma_delta: fix irq_flags on irq request

With commit 7b0c9f8fa3d2 ("iio: adc: ad_sigma_delta: Add optional irq
selection"), we can get the irq line from struct ad_sigma_delta_info
instead of the spi device. However, in devm_ad_sd_probe_trigger(), when
getting the irq_flags with irq_get_trigger_type() we are still using
the spi device irq instead of the one used for devm_request_irq().

Fixes: 7b0c9f8fa3d2 ("iio: adc: ad_sigma_delta: Add optional irq selection")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://patch.msgid.link/20240806-dev-fix-ad-sigma-delta-v1-1-aa25b173c063@analog.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 8c062b0d26e3..dcd557e93586 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -569,7 +569,7 @@ EXPORT_SYMBOL_NS_GPL(ad_sd_validate_trigger, IIO_AD_SIGMA_DELTA);
 static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
-	unsigned long irq_flags = irq_get_trigger_type(sigma_delta->spi->irq);
+	unsigned long irq_flags = irq_get_trigger_type(sigma_delta->irq_line);
 	int ret;
 
 	if (dev != &sigma_delta->spi->dev) {
-- 
2.46.0



