Return-Path: <stable+bounces-12950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCA7837A9A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EAC8B277B1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8CE482ED;
	Tue, 23 Jan 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0/vA6qD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D71272D1;
	Tue, 23 Jan 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968679; cv=none; b=n0diD7eT213injjs7TglVn0Hx9Dsei5qLuNJV1PprD5nmVCSLBDN8EQ9uD1g66/7JcW1jpZZFzFeG0B8j/qAMyH5w9f5lA7m0MyuUbs4wUMtk8Y2eTQ/GSeB/NXpAuOMC01ZWAO8rwMg6DSUvFz9T07v8SjqdMWkXa7nMw7ZEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968679; c=relaxed/simple;
	bh=uU4PSb/2H/aPMQ7Z+JyCSFFFKHh5Bsu0T9Abq2hTnh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbuez7ooZPo3z1wPFuM89DrxjIGB/KYr71gV7sEmsY3w/9cHvlx6++WhFvzeLTCCjygvBBioltD34QSL+Jox66Srh5JrPXNS/OTJuAwWq4aJ+1v+mJGn5YnaD2fpn/yEGbln1rQPNMLVGW/S7iYuXqHMXNASpmS8w1i7qY/LjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y0/vA6qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943C7C43394;
	Tue, 23 Jan 2024 00:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968679;
	bh=uU4PSb/2H/aPMQ7Z+JyCSFFFKHh5Bsu0T9Abq2hTnh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0/vA6qDiKzazdcmjSfGvqvZAVLgl7oWgJFRv5EB+EcEQegE1AtzdddH1uaZkCieW
	 /+IGPMd0ENzQgygQn+GL4nNHH3M+lCu/b9MtKMK92jzZPVw2MhOcTOjkBhVr4+9/12
	 YJS8Vrh1qeOnvKjtdK8CiHtKbf0HoIqJ9mENAAAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/148] media: cx231xx: fix a memleak in cx231xx_init_isoc
Date: Mon, 22 Jan 2024 15:57:36 -0800
Message-ID: <20240122235716.443246533@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit 5d3c8990e2bbf929cb211563dadd70708f42e4e6 ]

The dma_q->p_left_data alloced by kzalloc should be freed in all the
following error handling paths. However, it hasn't been freed in the
allocation error paths of dev->video_mode.isoc_ctl.urb and
dev->video_mode.isoc_ctl.transfer_buffer.

On the other hand, the dma_q->p_left_data did be freed in the
error-handling paths after that of dev->video_mode.isoc_ctl.urb and
dev->video_mode.isoc_ctl.transfer_buffer, by calling
cx231xx_uninit_isoc(dev). So the same free operation should be done in
error-handling paths of those two allocation.

Fixes: 64fbf4445526 ("[media] cx231xx: Added support for Carraera, Shelby, RDx_253S and VIDEO_GRABBER")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/cx231xx/cx231xx-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/cx231xx/cx231xx-core.c b/drivers/media/usb/cx231xx/cx231xx-core.c
index 493c2dca6244..cd60473a981c 100644
--- a/drivers/media/usb/cx231xx/cx231xx-core.c
+++ b/drivers/media/usb/cx231xx/cx231xx-core.c
@@ -1040,6 +1040,7 @@ int cx231xx_init_isoc(struct cx231xx *dev, int max_packets,
 	if (!dev->video_mode.isoc_ctl.urb) {
 		dev_err(dev->dev,
 			"cannot alloc memory for usb buffers\n");
+		kfree(dma_q->p_left_data);
 		return -ENOMEM;
 	}
 
@@ -1049,6 +1050,7 @@ int cx231xx_init_isoc(struct cx231xx *dev, int max_packets,
 		dev_err(dev->dev,
 			"cannot allocate memory for usbtransfer\n");
 		kfree(dev->video_mode.isoc_ctl.urb);
+		kfree(dma_q->p_left_data);
 		return -ENOMEM;
 	}
 
-- 
2.43.0




