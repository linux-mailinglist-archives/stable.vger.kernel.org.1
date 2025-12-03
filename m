Return-Path: <stable+bounces-199703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C998CA0B26
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A1FF309DF06
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0E035F8CD;
	Wed,  3 Dec 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lVs3yT8t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2836C35E546;
	Wed,  3 Dec 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780662; cv=none; b=NiEEO2y9Y9liiygo6OAg+thrNoG0xOXhdIQmwrhQxcLUE9cnPtUFO6UItWXjCAzNnq6Nt7H9KKnSrs22dZ9qW/u/HduVIegNvxR8YUJ307NyNvzE00eoMWoscT7LZhtOGNQG2XeDJfFBL1qt71LgJ534HoacHRDTSwmA6r6+y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780662; c=relaxed/simple;
	bh=jWT9Cw9GXyqDrrWOt/fD0ijpyFbbdYhCroT3VsKdObQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meKJBdEZdF7Fsao6s6x+lKRkq+Pk1lO66lNzQ+ZL+trUGHHYz9E9hYPMjsYcxerJnDnE3YWwsTjbO0MVaPrcZqyCyKABO3Kzi0tua0EwZr6sc2g3LQ4ODGInOB9x5BvSayz+ETHCJ8gdBqWiXFaUQgBHN0X5ndF5lTjKuhMjNuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lVs3yT8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CA5C4CEF5;
	Wed,  3 Dec 2025 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780662;
	bh=jWT9Cw9GXyqDrrWOt/fD0ijpyFbbdYhCroT3VsKdObQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVs3yT8tBG0NwnZF72Ey+q4imJ1JaOJdKYR+KqqbFUYDG4zyYMOhE6jox44CVSo7c
	 IAwr8LURsej5r5SRQyD1yvbwKOLaI6aWO9V5mu+1A05ctWmndPmNzoNRYbCVTlM9S4
	 Pn8kn+8+bnvEIRTv8BBQWXofr7G+Y6OMpUWyySBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 052/132] iio: buffer-dmaengine: enable .get_dma_dev()
Date: Wed,  3 Dec 2025 16:28:51 +0100
Message-ID: <20251203152345.223890551@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152343.285859633@linuxfoundation.org>
References: <20251203152343.285859633@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sá <nuno.sa@analog.com>

commit 3db847df994d475db7812dde90376f2848bcd30a upstream.

Wire up the .get_dma_dev() callback to use the DMA buffer infrastructure's
implementation. This ensures that DMABUF operations use the correct DMA
device for mapping, which is essential for proper operation on systems
where memory is mapped above the 32-bit range.

Without this callback, the core would fall back to using the IIO device's
parent, which may not have the appropriate DMA mask configuration for
high memory access.

Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -177,6 +177,8 @@ static const struct iio_buffer_access_fu
 	.lock_queue = iio_dma_buffer_lock_queue,
 	.unlock_queue = iio_dma_buffer_unlock_queue,
 
+	.get_dma_dev = iio_dma_buffer_get_dma_dev,
+
 	.modes = INDIO_BUFFER_HARDWARE,
 	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
 };



