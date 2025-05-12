Return-Path: <stable+bounces-143223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157F1AB34A2
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9682C17D19C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD3255E33;
	Mon, 12 May 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UYtmpZdj"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E86378C91
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044985; cv=none; b=mufLrNxMRsCfdW5pH8jQBwPcrLyyRGCPxF85bTuWQzMMkbdioRH5NgzgRYlp2KqpdTluDWAqx0UPiTx70kP9hVlOVM+zvfCLJ1I2oEQZLVeYUuLsrVvVzigdNYCl44l3ZX0WSQS/Z+3Bv9o3qAQJEk36JdA7jrnNy0txIzAKP7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044985; c=relaxed/simple;
	bh=B7bIaujXhzYPVtTY23Tu2l7edTluNJl9Q9VTngS/etY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tb90MeY5+DGownOSAB1L1R9m+ekqjUB6DcPQAw1tro/22ANw2E2/CFdO7jDv4Eoqs8jTvoLLWbJSK7bI4lsozGZdD4zQMcGbBiTUNHkI9afQ7XbyNNAVrEb4HEXo/eIrx1O3fmk7Yb9ST+qO2U0y3FnV8WHSkDl3MSg5TMPN5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UYtmpZdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE60C4CEE7;
	Mon, 12 May 2025 10:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044984;
	bh=B7bIaujXhzYPVtTY23Tu2l7edTluNJl9Q9VTngS/etY=;
	h=Subject:To:Cc:From:Date:From;
	b=UYtmpZdjXJpn7uQmq2kwKz9QU2yygUMpZ8LDXTM2A4cYGDzp0TebSfKtlD34TaAR4
	 L0xjg5qzNaXRb2N2Fg5qFgwAHW5PMTIB1V5sa4ntax1aXxwtyM0bmg/Ng2quB6/yyj
	 dnX7j0fd9rf7Xncy5dnkgWXUQvKUVOQLhV51sYOI=
Subject: FAILED: patch "[PATCH] iio: adc: ad7266: Fix potential timestamp alignment issue." failed to apply to 5.15-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:16:10 +0200
Message-ID: <2025051210-january-gallstone-4417@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 52d349884738c346961e153f195f4c7fe186fcf4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051210-january-gallstone-4417@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52d349884738c346961e153f195f4c7fe186fcf4 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Sun, 13 Apr 2025 11:34:24 +0100
Subject: [PATCH] iio: adc: ad7266: Fix potential timestamp alignment issue.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On architectures where an s64 is only 32-bit aligned insufficient padding
would be left between the earlier elements and the timestamp. Use
aligned_s64 to enforce the correct placement and ensure the storage is
large enough.

Fixes: 54e018da3141 ("iio:ad7266: Mark transfer buffer as __be16") # aligned_s64 is much newer.
Reported-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 18559757f908..7fef2727f89e 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -45,7 +45,7 @@ struct ad7266_state {
 	 */
 	struct {
 		__be16 sample[2];
-		s64 timestamp;
+		aligned_s64 timestamp;
 	} data __aligned(IIO_DMA_MINALIGN);
 };
 


