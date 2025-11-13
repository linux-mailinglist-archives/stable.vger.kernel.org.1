Return-Path: <stable+bounces-194747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7065C5A56A
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 23:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E0B74EF93D
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 22:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627032D6E78;
	Thu, 13 Nov 2025 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nlaf+pu6"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694F76026
	for <Stable@vger.kernel.org>; Thu, 13 Nov 2025 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073300; cv=none; b=CXgjq5w6v77rQMvaK2qWGWvcpaPzYSBXgE6DQzF+UaizplSIARDMkwyK//jI01p4OXzhAdna+WLy37mtIBRIB0uIX2qQJXlaLbrJn4DnK0E9Xt8lNIvT2rVy30fcKSskPVtQHN5h7GexEsBFRxqf7fO7v/cLGx4oFfXe8eQXQ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073300; c=relaxed/simple;
	bh=8/g5ZpRnIWc30BHkbs/Oba9D+xDSKzoitO+ai2r7XI8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=jpC3Esh86yQBV+4sYiLks5gvaiZwGqR8ZyYl68W7woX22kkCE2N0trmd5aiVRdY1urW4IpqnkUQo+YVjonOwNMPZSoVG85hTntK8PxiPMIiS2MNNWOu7E1Q8RJ0BdyfNXiuuJglVTV7HUxcAsD8yLJP3XJ5S7aI7cJvHxIpPW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nlaf+pu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D19C4CEF7;
	Thu, 13 Nov 2025 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763073299;
	bh=8/g5ZpRnIWc30BHkbs/Oba9D+xDSKzoitO+ai2r7XI8=;
	h=Subject:To:From:Date:From;
	b=Nlaf+pu6JJ5IqXdhvaRp2kGHEQ8VWJ+IPqos6WD+bmzoJZDifVUcAE5mxA7XdHocY
	 c5N0ywJJGJM/lK4Mjq0C8Sac/C/8FfObPshiNQZC50Q1VGEa1KQk5K1y0hJFSY2VT1
	 MYnKrdo3IWbaAfxGPEWcUJE1pT7Aj0U8bK8s4WfY=
Subject: patch "iio: buffer-dmaengine: enable .get_dma_dev()" added to char-misc-linus
To: nuno.sa@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,dlechner@baylibre.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Nov 2025 17:34:51 -0500
Message-ID: <2025111351-epidermal-creed-5e44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: buffer-dmaengine: enable .get_dma_dev()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 3db847df994d475db7812dde90376f2848bcd30a Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 7 Oct 2025 10:15:23 +0100
Subject: iio: buffer-dmaengine: enable .get_dma_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index e9d9a7d39fe1..27dd56334345 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -177,6 +177,8 @@ static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
 	.lock_queue = iio_dma_buffer_lock_queue,
 	.unlock_queue = iio_dma_buffer_unlock_queue,
 
+	.get_dma_dev = iio_dma_buffer_get_dma_dev,
+
 	.modes = INDIO_BUFFER_HARDWARE,
 	.flags = INDIO_BUFFER_FLAG_FIXED_WATERMARK,
 };
-- 
2.51.2



