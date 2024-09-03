Return-Path: <stable+bounces-72812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4C969A61
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFCA1C2340E
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D71AD259;
	Tue,  3 Sep 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nZu3jpjX"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573D1A3AA3
	for <Stable@vger.kernel.org>; Tue,  3 Sep 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360107; cv=none; b=mKLgfGIyzjk4nZmU2BVA08wmj228u87OOfUyI53XiKT+KyqFC5/eZHH8bGbjDofqn2O6SMIiwfJSiYn5uldpQk9WxUsfLfIzBf1XjLiI3v9GwvoLHsunbl+osXJ7JTH9fgIXdUMwENeGtjnckAe5bKwuLNOQ4LxA45Wcg3KFqxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360107; c=relaxed/simple;
	bh=Xei7iEIJKXNG7K+dSqqSdeyPIefPbo+L8jZKQBTCvWI=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=t4YIk9rPOSaiwQqzaVIeyiO3H/mywee6R5Z7SgNbeiFq0lST82I/QFH7NsLIyk7LD41KQ1N3ahyTPfMEcqbdcpm6FU/viQio3ye/QW3MJFpTHQptmqrzaOVsG8shTdwKcrEptOMD977NaoTOjC4zvBA8hVlSSsV3wRpq5dqTmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZu3jpjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84193C4CEC4;
	Tue,  3 Sep 2024 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725360106;
	bh=Xei7iEIJKXNG7K+dSqqSdeyPIefPbo+L8jZKQBTCvWI=;
	h=Subject:To:From:Date:From;
	b=nZu3jpjXpAp36ytgY0wawCjsmoeWciZKbpAVtv2c3JNJVqnzYLS4SmFAI0ydX5322
	 0f6gzodeQwhUnQHD6/HTtYl0L0zGoik4JHpF4mw0MlPUHZVcN7XX56CPORWk+o0e0U
	 7F1rChDRpXPPoHYrh3+l/BKXFzHtxwA2bB2YlYBo=
Subject: patch "iio: buffer-dmaengine: fix releasing dma channel on error" added to char-misc-linus
To: dlechner@baylibre.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Sep 2024 12:18:02 +0200
Message-ID: <2024090302-zoologist-casket-e7c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: buffer-dmaengine: fix releasing dma channel on error

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 84c65d8008764a8fb4e627ff02de01ec4245f2c4 Mon Sep 17 00:00:00 2001
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Jul 2024 11:32:21 -0500
Subject: iio: buffer-dmaengine: fix releasing dma channel on error

If dma_get_slave_caps() fails, we need to release the dma channel before
returning an error to avoid leaking the channel.

Fixes: 2d6ca60f3284 ("iio: Add a DMAengine framework based buffer")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20240723-iio-fix-dmaengine-free-on-error-v1-1-2c7cbc9b92ff@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 12aa1412dfa0..426cc614587a 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -237,7 +237,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_free;
+		goto err_release;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -263,6 +263,8 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return &dmaengine_buffer->queue.buffer;
 
+err_release:
+	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);
-- 
2.46.0



