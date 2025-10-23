Return-Path: <stable+bounces-189101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8EC00CBD
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E211A61FAE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7816730AD1E;
	Thu, 23 Oct 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MyxMWOyd"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B5530CDAB
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219504; cv=none; b=B/8Wt0fi7C215NOaeHO1yvdDgLgupMssMVeOaqDekcVu02rlcqGYUDGQJUMJxYR92C/k1uIkHnHHk5oISmr1x0gWVLWjRzulm8oz6Tsn6frOToSmILIH4wqH5A9GYESpKr5xNFrxulSLBQ/4b7mBzezL5fqDeQH3RpcfkubB0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219504; c=relaxed/simple;
	bh=JcnSMo9y3YxKtGUECkBGqRJ6L1ZRjv62tHSgnSjZjEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=BNC+yLvV4ZHTLh/2fv4RswKJj5cFMuAo50K4qmKI+XUk9NpDP6UAkGZO0HVLg1ZuY6aE0s6DdNFU9y/DidfJMj4h6c2iCdJDYzg4qWdCIUX19MhGMDajwnFQ1QHQ/npKilpXuC//blFsEieCqqA4lZoWmSum7D/fIGPUl0otX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MyxMWOyd; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251023113101euoutp028e088f4567a2084e5f76ead4900ac873~xG2fJUwFS1404214042euoutp02L
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:31:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251023113101euoutp028e088f4567a2084e5f76ead4900ac873~xG2fJUwFS1404214042euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1761219061;
	bh=Zx10uetxODgjiKwTb72B0FkSj8NfHGThGH35zw/9c/k=;
	h=From:To:Cc:Subject:Date:References:From;
	b=MyxMWOydrLm4P9vtJWZy9qjqZKcM90Rb+ffqBXikNI6dTkoAPV2JMO2VugVbaAbBP
	 Jn1EV96/W6+Ut7T6dIvy0/SVfVGHQ7LiLTfQ5UfcinytcjkgsPxWjhw0tMdgCUX2yA
	 t3M/3HTVDNrYEx8DiU29K5P0MYVEZMpUVI9Ss0y8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251023113101eucas1p2c227985b0198d888564cab00aeb94f01~xG2epxrmC0682306823eucas1p2M;
	Thu, 23 Oct 2025 11:31:01 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251023113100eusmtip2603dffa83e23648131d49e9f9b96ce67~xG2eKz9l00413304133eusmtip2C;
	Thu, 23 Oct 2025 11:31:00 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Tomasz Figa
	<tfiga@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Guennadi
	Liakhovetski <g.liakhovetski@gmx.de>, Benjamin Gaignard
	<benjamin.gaignard@collabora.com>, Hans Verkuil <hverkuil@kernel.org>,
	stable@vger.kernel.org, Shuangpeng Bai <SJB7183@psu.edu>
Subject: [PATCH v3] media: videobuf2: forbid remove_bufs when legacy fileio
 is active
Date: Thu, 23 Oct 2025 13:30:52 +0200
Message-Id: <20251023113052.1303082-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251023113101eucas1p2c227985b0198d888564cab00aeb94f01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251023113101eucas1p2c227985b0198d888564cab00aeb94f01
X-EPHeader: CA
X-CMS-RootMailID: 20251023113101eucas1p2c227985b0198d888564cab00aeb94f01
References: <CGME20251023113101eucas1p2c227985b0198d888564cab00aeb94f01@eucas1p2.samsung.com>

vb2_ioctl_remove_bufs() call manipulates queue internal buffer list,
potentially overwriting some pointers used by the legacy fileio access
mode. Add a vb2_verify_memory_type() check symmetrical to
vb2_ioctl_create_bufs() to forbid that ioctl when fileio is active to
protect internal queue state between subsequent read/write calls.

CC: stable@vger.kernel.org
Fixes: a3293a85381e ("media: v4l2: Add REMOVE_BUFS ioctl")
Reported-by: Shuangpeng Bai<SJB7183@psu.edu>
Suggested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index d911021c1bb0..a8a5b42a42d0 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -1000,13 +1000,15 @@ int vb2_ioctl_remove_bufs(struct file *file, void *priv,
 			  struct v4l2_remove_buffers *d)
 {
 	struct video_device *vdev = video_devdata(file);
-
-	if (vdev->queue->type != d->type)
-		return -EINVAL;
+	int res;
 
 	if (d->count == 0)
 		return 0;
 
+	res = vb2_verify_memory_type(vdev->queue, vdev->queue->memory, d->type);
+	if (res)
+		return res;
+
 	if (vb2_queue_is_busy(vdev->queue, file))
 		return -EBUSY;
 
-- 
2.34.1


