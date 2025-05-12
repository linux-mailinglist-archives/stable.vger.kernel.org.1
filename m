Return-Path: <stable+bounces-143229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3542AAB34B1
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D063AA0A7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CF625A341;
	Mon, 12 May 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EExWaT2R"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6B255E33
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045070; cv=none; b=DiA2Meb8hBmF9LC6ymbCChoZ81j5oOuhcG76b5MjTfMX2oSXO1QpSW3ca20DWXZ5oqyx71qHGUtKWohzKw9piL1bjKppcrAwMSaL6vUX1Lqym7CwQ5VkUjeoTEz2ctGbKNjN4MeHKMDAmrYX+flcvWAdaF/L/CjIrqsufqsMbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045070; c=relaxed/simple;
	bh=sxJaQgrQ0sNwfbUO1RL6ub0oZ0MMCGheA1U/Ay9sdkw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M4niWO0Roz9jV6s4DvhUUONtA2c/V/LHstGYywIYmZppFUxXsfv68MFgmIyAMCwssGo1k22PG5eJNml7F6s1tDBlSBZ7olmIOS86cJPsSzQUBdYABEXmvQ+E9DymsE4kSnkEULpmUV/nTs3ABpWo6PQ43lE8jQD9614CNXMqSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EExWaT2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A10C4CEE7;
	Mon, 12 May 2025 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747045070;
	bh=sxJaQgrQ0sNwfbUO1RL6ub0oZ0MMCGheA1U/Ay9sdkw=;
	h=Subject:To:Cc:From:Date:From;
	b=EExWaT2Ro97HL2UnJm27FkX4PmOiKnRev4N2qWfzm0cp2XXetzJBWNG3/Z5+69JHC
	 Ld7F9ESXcFDAB5FEW7xadS473497gkVPD4A6Tv3PmEQTHM0nvIF8J6f+y8Z5r/C733
	 98ZFNVYIiWPMhigiNPblWXz7GKIVS5VhXduu76CM=
Subject: FAILED: patch "[PATCH] iio: chemical: sps30: use aligned_s64 for timestamp" failed to apply to 5.10-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:17:34 +0200
Message-ID: <2025051234-respect-outgrow-ba49@gregkh>
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
git cherry-pick -x bb49d940344bcb8e2b19e69d7ac86f567887ea9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051234-respect-outgrow-ba49@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb49d940344bcb8e2b19e69d7ac86f567887ea9a Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 17 Apr 2025 11:52:37 -0500
Subject: [PATCH] iio: chemical: sps30: use aligned_s64 for timestamp
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure that the timestamp is correctly aligned on
all architectures.

Fixes: a5bf6fdd19c3 ("iio:chemical:sps30: Fix timestamp alignment")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250417-iio-more-timestamp-alignment-v1-5-eafac1e22318@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 6f4f2ba2c09d..a7888146188d 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -108,7 +108,7 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
 	int ret;
 	struct {
 		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
-		s64 ts;
+		aligned_s64 ts;
 	} scan;
 
 	mutex_lock(&state->lock);


