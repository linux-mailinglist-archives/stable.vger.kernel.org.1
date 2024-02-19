Return-Path: <stable+bounces-20618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D922C85A97E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78B3EB202ED
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA2F3F9F8;
	Mon, 19 Feb 2024 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mdlwFMBd"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAB6383BE
	for <Stable@vger.kernel.org>; Mon, 19 Feb 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362110; cv=none; b=TTeCnlTB6kK51BhZp0BFySBuTNFav10131qTKt3ygwCv/LNh/cPZ3ov+ORZ6am+usnfzFzpy6z2HTSo2VEKq+2oO3o3KMH7yOz2OZW21El+0oqwpRiivZLzsr6ZVeYBgETrntDj4kqv8TpiKq0bd+1hr8Hjh0bxi90OB2BQBGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362110; c=relaxed/simple;
	bh=uSjzhEe4hieYRW0x88f27dqz0vmCau5S9JYQZRImRbM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c77sX/k07UZhEfUHQ1kouylFCggNeqzOrQGDwRkT99Ds18/frIzcve6NGs8mbFyJf/NtfdJs0ONagUNkhulaYwpXQSJVEzL7B7v3eTRsS8vKArAmGPtvC7LikJKYNyiyHWbKROre1VZAQvDyjoWkUvs62DKnDQKXv1s3lSONV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mdlwFMBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34966C433C7;
	Mon, 19 Feb 2024 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708362109;
	bh=uSjzhEe4hieYRW0x88f27dqz0vmCau5S9JYQZRImRbM=;
	h=Subject:To:Cc:From:Date:From;
	b=mdlwFMBdd1fj55vqRi+q0gB377xbeAWt8Uuy8/VXB+fnb0WqDogJKfiPfgYmYrYb/
	 doxSFjwN+h2bop4hEp0Q3EXOnSwaDiB/wwfIzyAroMJvbbRjbFSt0jkZMtY+ad26h4
	 Jq3B1WvQvEpHtgf8LqPfWGDQMWWKytUNJi4trmZM=
Subject: FAILED: patch "[PATCH] iio: adc: ad_sigma_delta: ensure proper DMA alignment" failed to apply to 5.10-stable tree
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 18:00:54 +0100
Message-ID: <2024021954-strict-prominent-60b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 59598510be1d49e1cff7fd7593293bb8e1b2398b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021954-strict-prominent-60b7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

59598510be1d ("iio: adc: ad_sigma_delta: ensure proper DMA alignment")
0fb6ee8d0b5e ("iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 59598510be1d49e1cff7fd7593293bb8e1b2398b Mon Sep 17 00:00:00 2001
From: Nuno Sa <nuno.sa@analog.com>
Date: Wed, 17 Jan 2024 13:41:03 +0100
Subject: [PATCH] iio: adc: ad_sigma_delta: ensure proper DMA alignment

Aligning the buffer to the L1 cache is not sufficient in some platforms
as they might have larger cacheline sizes for caches after L1 and thus,
we can't guarantee DMA safety.

That was the whole reason to introduce IIO_DMA_MINALIGN in [1]. Do the same
for the sigma_delta ADCs.

[1]: https://lore.kernel.org/linux-iio/20220508175712.647246-2-jic23@kernel.org/

Fixes: 0fb6ee8d0b5e ("iio: ad_sigma_delta: Don't put SPI transfer buffer on the stack")
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20240117-dev_sigma_delta_no_irq_flags-v1-1-db39261592cf@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 7852f6c9a714..719cf9cc6e1a 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -8,6 +8,8 @@
 #ifndef __AD_SIGMA_DELTA_H__
 #define __AD_SIGMA_DELTA_H__
 
+#include <linux/iio/iio.h>
+
 enum ad_sigma_delta_mode {
 	AD_SD_MODE_CONTINUOUS = 0,
 	AD_SD_MODE_SINGLE = 1,
@@ -99,7 +101,7 @@ struct ad_sigma_delta {
 	 * 'rx_buf' is up to 32 bits per sample + 64 bit timestamp,
 	 * rounded to 16 bytes to take into account padding.
 	 */
-	uint8_t				tx_buf[4] ____cacheline_aligned;
+	uint8_t				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
 	uint8_t				rx_buf[16] __aligned(8);
 };
 


