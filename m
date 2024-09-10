Return-Path: <stable+bounces-75138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91935973314
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8C6287D53
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C401922E8;
	Tue, 10 Sep 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7JpiS3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB6018A6B9;
	Tue, 10 Sep 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963860; cv=none; b=FDeQGXOCtfRefqseqU0QvCo8k3di0Tn486Wrf1J+BqRJZ7rnzgCXjhnCVg3t4i8/x/LGkGikJTKVwDhgyTLzGvhGpUEOdQ3Do9dUPRgpxF6tRhKAuxh0yYfNTzGn6yWHuccR2obSidnyBKc+RFHl4eZCkzZ682cdfTWfFKxesbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963860; c=relaxed/simple;
	bh=G9TFs1UOY1WdbrGbN5hJmDx8y8pvVGBFLxMAhsNjQv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sj+/zJFDqb82B0tKkXWpXGEbgB2FkhIG3byuxOKMgZ/crKvGoyikVID0a8DDDwyTf1xucTERhfY5VmQ8XM7i5RWLcS2ycTvSS8IfjvJPMiQwTqL0O6Dpo+Pu18vUPLOKam9ZXeiQ02E8NnDSPe0d/WcUxEi3V/QJlsbLefTWbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7JpiS3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34805C4CEC3;
	Tue, 10 Sep 2024 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725963860;
	bh=G9TFs1UOY1WdbrGbN5hJmDx8y8pvVGBFLxMAhsNjQv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7JpiS3WGqH3gzap1NsPcHYh7cVOc7pTTkI9SUBOnWTqZOkNqL2TNqMBZInULN6CY
	 Qju9SlOMFexpNbVqBKXELKAuaiI/QJLH5zPYjoZ4vRe4MhlYvX8+x95TF3OBBMB6Ux
	 K6ZrR2eKobyIGMbfmgUeWHzpb97pwTEezw8oG1wg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 175/214] iio: buffer-dmaengine: fix releasing dma channel on error
Date: Tue, 10 Sep 2024 11:33:17 +0200
Message-ID: <20240910092605.861101832@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092558.714365667@linuxfoundation.org>
References: <20240910092558.714365667@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Lechner <dlechner@baylibre.com>

commit 84c65d8008764a8fb4e627ff02de01ec4245f2c4 upstream.

If dma_get_slave_caps() fails, we need to release the dma channel before
returning an error to avoid leaking the channel.

Fixes: 2d6ca60f3284 ("iio: Add a DMAengine framework based buffer")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20240723-iio-fix-dmaengine-free-on-error-v1-1-2c7cbc9b92ff@baylibre.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -180,7 +180,7 @@ static struct iio_buffer *iio_dmaengine_
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_free;
+		goto err_release;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -206,6 +206,8 @@ static struct iio_buffer *iio_dmaengine_
 
 	return &dmaengine_buffer->queue.buffer;
 
+err_release:
+	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);



