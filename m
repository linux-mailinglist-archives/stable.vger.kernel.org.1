Return-Path: <stable+bounces-172062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18482B2FA39
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C635E2823
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4937B3375A1;
	Thu, 21 Aug 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9gD6+AV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0922632BF36
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782202; cv=none; b=p1BZ1StS/C8TzgoPoAXnH+de7b8qrVZK+T8kECk3E6FHRsRPU/9hcVtDAnv61i7+KQNLwoymmC815kWW11A0uwszD/TwJ/3nBllvIBevM97eKR4CkvOdVOEfDyRb45bZnTQYMLTpdKoZUuJZB0W10rmmD4XS5tsHxZGrULmi9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782202; c=relaxed/simple;
	bh=/Nl7GWSyUBTnvtP3ptMOvrtr0CTlEHZKE/GQV8Bo21g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lhRIekhj2t7nwfcUv8VLzTyug+111BkwJSeAF6VUXp26QB/MOpaTNrp2cwEN+87DdP1PSjjv2iwe8ScqDiM/xp6CyEqYj/MXy7d8eND6OoTW/F5E+5sQlDcfJY0T0DuyVtBGJ7jaM7CoIcVEDYA93gbUBcR2GFgHo8EN1qtNde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S9gD6+AV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47285C4CEED;
	Thu, 21 Aug 2025 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782201;
	bh=/Nl7GWSyUBTnvtP3ptMOvrtr0CTlEHZKE/GQV8Bo21g=;
	h=Subject:To:Cc:From:Date:From;
	b=S9gD6+AVbfrlvIvGKoVbVspuP7NmLuFu33OfAQsGXvtBUbr+DFXuuigMYnKXkery/
	 TrwZqfG5U0eDxG8BZqYHkBE9rwvLFq8lYEHKJuWdEYJp9NL6flVTkITwQyLuAwre9P
	 N1SiSzzI4zBTjSSaxP1cknLn2fiDb7eOioLVe9zo=
Subject: FAILED: patch "[PATCH] iio: adc: ad_sigma_delta: change to buffer predisable" failed to apply to 5.10-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,nuno.sa@analog.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:14:08 +0200
Message-ID: <2025082108-ointment-anthology-2c2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 66d4374d97f85516b5a22418c5e798aed2606dec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082108-ointment-anthology-2c2a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 66d4374d97f85516b5a22418c5e798aed2606dec Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 3 Jul 2025 16:07:44 -0500
Subject: [PATCH] iio: adc: ad_sigma_delta: change to buffer predisable
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
 


