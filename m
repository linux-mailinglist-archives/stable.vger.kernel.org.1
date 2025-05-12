Return-Path: <stable+bounces-143187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A84AB345E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E736188A3A4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F74259CAC;
	Mon, 12 May 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vi5bHz9n"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DA19E97C
	for <Stable@vger.kernel.org>; Mon, 12 May 2025 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044159; cv=none; b=OxZvq3ob8LO4ifYqroWg3YsuYzXu5bwdH0+/31uKrGwMBG/WZjigjJuVHapOJUKuPujZi98Dv6fqENyn6hHqVL5G3yjILdV+psysg1xEWtEoh0jwuVkxJ1/GUQoZLUHbFqO2S2bjoBKwT6GNCF0FslROlnQW2DK7Xt/rwZp4+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044159; c=relaxed/simple;
	bh=pkfJUoyXtk2pmJIXsLhzyHfpHH8MbI/LSa6FOS0vL0c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tmxO0wuzPeXCo3qtptB6C7DabypINcxYMvX7/cJ1w7FaQDl9PCltBUKkGmCHSmNefA1R464WzNQL3Dtw6LnNhM8kplkoW4xcgW6R/poGZ4GjiBuoXRUahcJWzcDgLNZ1YU0eLmD33myhDABM35+89otxbUIAmYG0XMLfle5jWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vi5bHz9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B807BC4CEE7;
	Mon, 12 May 2025 10:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044159;
	bh=pkfJUoyXtk2pmJIXsLhzyHfpHH8MbI/LSa6FOS0vL0c=;
	h=Subject:To:Cc:From:Date:From;
	b=Vi5bHz9nHZTnlE26aNCdCR4CTnBjsBHCGMvrAdiNtHMjis/FALTaeoUxZLKjNaX1T
	 Y6zH+z6PpC6EfUUsoCdrnASCeaqUVIYtXABdq+bBmQBDCLs4BF0x/2iTVXxquwDtbw
	 MhZLmo0hWq9977OZbD/zbsbcDSom8T7Wh39E8J2E=
Subject: FAILED: patch "[PATCH] iio: adc: ad7266: Fix potential timestamp alignment issue." failed to apply to 5.10-stable tree
To: Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:02:25 +0200
Message-ID: <2025051225-rind-sphinx-b9f1@gregkh>
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
git cherry-pick -x 52d349884738c346961e153f195f4c7fe186fcf4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051225-rind-sphinx-b9f1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


