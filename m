Return-Path: <stable+bounces-172064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24BB2F9F0
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344B77B9BA8
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CB53277BF;
	Thu, 21 Aug 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWyJ+mG5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4E32A3DC
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782208; cv=none; b=mKRQsJZEcTCXK5hdD7RFITnAzET0CpGZgp/fWHLc7/kMbk8Ds1Gm21ofrV6Gjpft9/Nw6q6fMC9MqvVD8bMzNGC5D6tROKLKjNbzRXWsznumCG1vnzCZK12D7eGR6rmxBHtV6SEBpAu/vtSOReujMCdv8bdZxqZw8CFWBBuSayM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782208; c=relaxed/simple;
	bh=IklE4ZRJyWqI3BFstIZrFzWXJjKejJcnnmHXy2Rv0DY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iVR43gM8Nn2ClfKZuCbeA7ZgHjE3Mh9gPNNwCfvEdfL0gWGUQRpBuKIszWviTknR1doxlaj/bjlNlXiI81iGvud3bjnBELnu4XjvB/ZfyFMsC7os22VkcNMhWxaQHAY4imMN7RsYLUHUgfpRNBE/EPeL+fLqXUstOs08RrHr/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWyJ+mG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23397C4CEEB;
	Thu, 21 Aug 2025 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755782207;
	bh=IklE4ZRJyWqI3BFstIZrFzWXJjKejJcnnmHXy2Rv0DY=;
	h=Subject:To:Cc:From:Date:From;
	b=vWyJ+mG5Xo9392XFwxssDkXPRwO/rjKmmJjB4JBBrefpkjlzI98LvZDRbdI3uDD6R
	 sBVFPlt8E+LJymlc6EGRD1sizPZOnUpUg2hF5pFn4f2kng+nEFrQdosYDYlpUA9vIv
	 kbA7GUtfmA/Q93CdjJ/UjuNKU9tTugfppWNU8ndA=
Subject: FAILED: patch "[PATCH] iio: adc: ad_sigma_delta: change to buffer predisable" failed to apply to 5.4-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,nuno.sa@analog.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:14:09 +0200
Message-ID: <2025082109-mutual-easily-fafd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 66d4374d97f85516b5a22418c5e798aed2606dec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082109-mutual-easily-fafd@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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
 


