Return-Path: <stable+bounces-143198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D2AB3472
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD441897D3C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6B25A33C;
	Mon, 12 May 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U8wDgfKC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC9255239
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044278; cv=none; b=kA1Yd8KBI0Am6q01c2zhntgJB7rYIXMxIYYKklHd9YbR/7Q3fZ6QidASaUVehdw999ISksiZfW/XRj9Qd++Bpr01WvWvFXrLpcpRn9GIvoyc0XrUM01dr7fgJ78SlAtI7qZXUEynCv9H952ouZjgiSy3U6v3oYCVhiyW0J997V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044278; c=relaxed/simple;
	bh=vhiLOjhg2O/N21geQT4JoJ/B+ASaEjc1JAP4vCTtWEo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hSxINdEnBtO7CoQgu/XTagZTevrGok6X6Nk2tyrct9HT5nSEvGkIAkXcjPwb/DO6AJjcvFuxatVQkuPWayFGMKXn8gqI5IbHAabyuUk87JWiTeLVD3s/kB8trtbXJX9VDmhANN8uUtbzRBKOdBNOB7BtvXn6J+daLZ23WNQAmq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U8wDgfKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3961AC4CEE7;
	Mon, 12 May 2025 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044277;
	bh=vhiLOjhg2O/N21geQT4JoJ/B+ASaEjc1JAP4vCTtWEo=;
	h=Subject:To:Cc:From:Date:From;
	b=U8wDgfKCmLBZ5EYnZxvHkIrUu2jHSbU1WxfrA5pIMVO1iyub2StspkHRfYuqEmk4O
	 4Jlw4oCi5Gdly8Tne9+toxF2CqGR/Ils3S1nEq34nRGx9B5IapFeDuqO4GpGFpOr2I
	 qQU1jbRu4la7VJY6Z40VWparzKDTqMtJraIfoEPQ=
Subject: FAILED: patch "[PATCH] iio: hid-sensor-prox: Fix incorrect OFFSET calculation" failed to apply to 5.4-stable tree
To: lixu.zhang@intel.com,Jonathan.Cameron@huawei.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:04:18 +0200
Message-ID: <2025051218-opponent-tarmac-061d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 79dabbd505210e41c88060806c92c052496dd61c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051218-opponent-tarmac-061d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79dabbd505210e41c88060806c92c052496dd61c Mon Sep 17 00:00:00 2001
From: Zhang Lixu <lixu.zhang@intel.com>
Date: Mon, 31 Mar 2025 13:50:22 +0800
Subject: [PATCH] iio: hid-sensor-prox: Fix incorrect OFFSET calculation

The OFFSET calculation in the prox_read_raw() was incorrectly using the
unit exponent, which is intended for SCALE calculations.

Remove the incorrect OFFSET calculation and set it to a fixed value of 0.

Cc: stable@vger.kernel.org
Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250331055022.1149736-4-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 941508e58286..4c65b32d34ce 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -124,8 +124,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision[chan->scan_index];
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-			prox_state->prox_attr[chan->scan_index].unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:


