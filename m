Return-Path: <stable+bounces-143194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A84EAB346D
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09F318977FB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A6255F5A;
	Mon, 12 May 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fq/pPB8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712C825A34F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044259; cv=none; b=cT9wQ5akgNgsgwgpSnNnk/tlPJ6MZK86eimFWUU7QMf0klYVkkrTYVuutP6j0T9SQUcPoTtygK+mCqSmMJocf4HP0spg2JJkZm+hxcOWKaFLtcwNx+0M02kuXp0TSBQXIYqpfoN+9cl+DqtCf4ttR4mpDKnNGZDp4foLISNKnPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044259; c=relaxed/simple;
	bh=l9I8Uh7Desxwat/6P9NYTgc63ewMiIQdPKamhFvHB7Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QzVZWAQvmAgDmdj3l5F23X/LNxbhDMg3QfXxDygaYI5jXf2ze3taYF7z+NAij4WpZqdr/5cv1106hMIIV5iwHxd9TyANmIQg63vDqIut57RinojhTuPylBxqVrotbNj/i5mbSkwXe3pA/svQjVKXLGT2mOtFyKoKTAHAJA3LCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fq/pPB8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1801C4CEF3;
	Mon, 12 May 2025 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044259;
	bh=l9I8Uh7Desxwat/6P9NYTgc63ewMiIQdPKamhFvHB7Y=;
	h=Subject:To:Cc:From:Date:From;
	b=fq/pPB8UJiQtBgUvmSoS0QnY/V2AwGRVqaSjuHV+hOxH4Y5wAV7L4iOveTAoEiRv9
	 NxnouzrPm3EOYujKop/gT3NPvuyau592hXQYiqA8mUNaVn033L4qJqlO+Tohc79+kB
	 YVeNoYdpCe5gZwH+Sd29S/lCnBnOqKscK7RzcnAU=
Subject: FAILED: patch "[PATCH] iio: hid-sensor-prox: Fix incorrect OFFSET calculation" failed to apply to 6.12-stable tree
To: lixu.zhang@intel.com,Jonathan.Cameron@huawei.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:04:16 +0200
Message-ID: <2025051216-fantasy-preschool-858d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 79dabbd505210e41c88060806c92c052496dd61c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051216-fantasy-preschool-858d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


