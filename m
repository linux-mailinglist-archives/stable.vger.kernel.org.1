Return-Path: <stable+bounces-143242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CDAB34CD
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F433AF319
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D672586E7;
	Mon, 12 May 2025 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PX8Ikf5/"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9B2AF14
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045319; cv=none; b=rn9H7mFoAAtQq4UyuCmGRoADjx4iCmwgZ+Zl6iXNJixvirb052C/XDiZFjbXiZtnO6j87a0oQRLX4iMfA5Lg6LxUKFpmUgGwRzTHyISuXJnEBaXCUB3j9Kaz3hPgNjnPC6x7MeZ1X8vpNZGFbNLEGIRZn5WexP2AHzp8CgizFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045319; c=relaxed/simple;
	bh=q1Mp+KUee5nIdDQmiJFtPVT2XOzfdQgu4m7uHYFc0bA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N6IoAlJsdBk3k7zeRTSkhRZp5yU7xzZqQCg3yamkqJ9JCQV63z2JvRmtnqeA9zQXT726qTRUYNRGcyr1KNvZ3lo5IbkFaSGHNpIw5uUG5FD/0bl6mtt5jN7fExcy5QpMp9Z7Z2zrcIVZPdow6E8Lx+gX4uM8gJZQnyDmE+Yw23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PX8Ikf5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2369EC4CEE7;
	Mon, 12 May 2025 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747045318;
	bh=q1Mp+KUee5nIdDQmiJFtPVT2XOzfdQgu4m7uHYFc0bA=;
	h=Subject:To:Cc:From:Date:From;
	b=PX8Ikf5/XXdADwVLivTU2Mm6KVkGQXu3LRPKPm5uwOVXuPCFlZoLGrtG3YPGfXmfe
	 UfuEIsN/hoypmOyiWVANoClpsgAoJC7kWXrdV+0EkG0gnmmOvJCjgfHaishNfUxi1a
	 aW1Bf8k6UmbDiSVkVuxNcOuw3buRQ2dJW2ACBx8Q=
Subject: FAILED: patch "[PATCH] iio: pressure: mprls0025pa: use aligned_s64 for timestamp" failed to apply to 6.12-stable tree
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:21:55 +0200
Message-ID: <2025051255-frequency-concept-f9f5@gregkh>
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
git cherry-pick -x ffcd19e9f4cca0c8f9e23e88f968711acefbb37b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051255-frequency-concept-f9f5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffcd19e9f4cca0c8f9e23e88f968711acefbb37b Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 18 Apr 2025 11:17:14 -0500
Subject: [PATCH] iio: pressure: mprls0025pa: use aligned_s64 for timestamp

Follow the pattern of other drivers and use aligned_s64 for the
timestamp. This will ensure the struct itself it also 8-byte aligned.

While touching this, convert struct mpr_chan to an anonymous struct
to consolidate the code a bit to make it easier for future readers.

Fixes: 713337d9143e ("iio: pressure: Honeywell mprls0025pa pressure sensor")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250418-iio-more-timestamp-alignment-v2-2-d6a5d2b1c9fe@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index 9d5c30afa9d6..d62a018eaff3 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -34,16 +34,6 @@ struct iio_dev;
 struct mpr_data;
 struct mpr_ops;
 
-/**
- * struct mpr_chan
- * @pres: pressure value
- * @ts: timestamp
- */
-struct mpr_chan {
-	s32 pres;
-	s64 ts;
-};
-
 enum mpr_func_id {
 	MPR_FUNCTION_A,
 	MPR_FUNCTION_B,
@@ -69,6 +59,8 @@ enum mpr_func_id {
  *       reading in a loop until data is ready
  * @completion: handshake from irq to read
  * @chan: channel values for buffered mode
+ * @chan.pres: pressure value
+ * @chan.ts: timestamp
  * @buffer: raw conversion data
  */
 struct mpr_data {
@@ -87,7 +79,10 @@ struct mpr_data {
 	struct gpio_desc	*gpiod_reset;
 	int			irq;
 	struct completion	completion;
-	struct mpr_chan		chan;
+	struct {
+		s32 pres;
+		aligned_s64 ts;
+	} chan;
 	u8	    buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
 };
 


