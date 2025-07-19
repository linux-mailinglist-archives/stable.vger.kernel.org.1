Return-Path: <stable+bounces-163423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AFEB0AE90
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D33116BE9A
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011C723314B;
	Sat, 19 Jul 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O9r2OQIx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F033EC
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752912757; cv=none; b=JEx92e2XmJqwmd2Dxo+BJa567EO3+3T4AGhiE7H/PGy9xlobvFzgXfZjNRzY4/DoNISQMX7fYT7orjLOI5UQBfs7V79Jct21uWh0XGWwFpr4e93NQ9SjuDHvDuEoOCYth4GR5zcE+/YyIQ99jMWsc68C9KFTGA7s2GTiqCrdJBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752912757; c=relaxed/simple;
	bh=jXRt0wUprr6Mt1p+GMpcI1pu7SYnCeyhxPnXId62Mag=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jx9a9qDaDn+2hO393nXEKhgJZ8fhoONSqCwjZx+wVvppYBevN9AV+z1PobnNKPWzY3Md8d1OU4/W5j3QiRIQxyrWRnYYebLWDc99uXsdbTNGLKPC5bNfx5kNzeklGClbbAEuU2AFdz+xUaL8fRG5oM6eq8YeQhQDP32mRnhYQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O9r2OQIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C045CC4CEE3;
	Sat, 19 Jul 2025 08:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752912757;
	bh=jXRt0wUprr6Mt1p+GMpcI1pu7SYnCeyhxPnXId62Mag=;
	h=Subject:To:From:Date:From;
	b=O9r2OQIxYV1tNwXihqndInLeMZSp/5CXUmdufTkUVRdFF8ItQBYIZ4tjIOh7/lOkg
	 xgVC8KSIuL3MWYcvIOeNJYzJmIYviCzqGaMWbB0TnhD/wsB4wE6jPFaDhZzEjGKi4Q
	 9iwL6Bxz7O5D7Xhzwy+XGpihJindSsTbbBMQEuOs=
Subject: patch "iio: adc: ad_sigma_delta: change to buffer predisable" added to char-misc-next
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,nuno.sa@analog.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 19 Jul 2025 09:51:42 +0200
Message-ID: <2025071942-occultist-impurity-8fb5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad_sigma_delta: change to buffer predisable

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 66d4374d97f85516b5a22418c5e798aed2606dec Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 3 Jul 2025 16:07:44 -0500
Subject: iio: adc: ad_sigma_delta: change to buffer predisable
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change the buffer disable callback from postdisable to predisable.
This balances the existing posteanble callback. Using postdisable
with posteanble can be problematic, for example, if update_scan_mode
fails, it would call postdisable without ever having called posteanble,
so the drivers using this would be in an unexpected state when
postdisable was called.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250703-iio-adc-ad_sigma_delta-buffer-predisable-v1-1-f2ab85138f1f@baylibre.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 9d2dba0a0ee6..7852884703b0 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -582,7 +582,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
+static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
@@ -682,7 +682,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned l
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.postdisable = &ad_sd_buffer_postdisable,
+	.predisable = &ad_sd_buffer_predisable,
 	.validate_scan_mask = &ad_sd_validate_scan_mask,
 };
 
-- 
2.50.1



