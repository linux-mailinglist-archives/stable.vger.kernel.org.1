Return-Path: <stable+bounces-163416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D33B0AE86
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 09:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B2C5871E9
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 07:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851E51CBEB9;
	Sat, 19 Jul 2025 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1YpmwEXR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444ED3597C
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752911987; cv=none; b=a7cx8F5DCnZgQFDaN2urj/V0xfq0SlWfIGHfpCdaBQtxB7oOdtrO3hM0pCwCbm+kFoJmXWzNIiviO/Oc5LIp1zxhu+O0Sff1FHHTi3qpV5d8FDziMNo9WWzJQeIxsdzB8DRbMMlaK6APhQ2C4JY6kFK4i98snTt8xzkGHxZH2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752911987; c=relaxed/simple;
	bh=89TIggVK9O67QnnvJdtBfrcV0WHLm/azw7RBvqt+j00=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=L6uhignjc86BmVXkOpCsoIqJ6ee76JnyMqztPnmFAcVGg3SLuKQ4tjEz1vL1U6DYeuu4k01jnYHz/jooiOfDA2mn6RLtEqWZWjTN8o9v7xaPwHWvWHNlpesCjP+GdSsDZRMReUtPkWsfNj+2mRPYXbu7XMydZyTo1zRYxIDpgkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1YpmwEXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660AEC4CEE3;
	Sat, 19 Jul 2025 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752911986;
	bh=89TIggVK9O67QnnvJdtBfrcV0WHLm/azw7RBvqt+j00=;
	h=Subject:To:From:Date:From;
	b=1YpmwEXRcZX2J8HXSj7l8O4KFpXjkotuootdxQZLuvtJhDUwBJuAE/5kR55eXgKQ0
	 cvC4z8YOVSLSljqceeG4DLS6RAGnqzeasgN1GZOjHrTEAkUEpiv+F2Mga/sHiEO0j0
	 eiiX/G54NBpQqyNbzKjrPYTXwSYfWW0qDMVsJRTk=
Subject: patch "iio: adc: ad_sigma_delta: change to buffer predisable" added to char-misc-testing
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,nuno.sa@analog.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sat, 19 Jul 2025 09:49:34 +0200
Message-ID: <2025071934-decimal-aroma-f2c6@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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



