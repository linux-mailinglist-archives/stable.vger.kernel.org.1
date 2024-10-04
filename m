Return-Path: <stable+bounces-81010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6CE990DCB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8811F21A92
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E12212D35;
	Fri,  4 Oct 2024 18:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci5zrTaI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578A212D2D;
	Fri,  4 Oct 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066485; cv=none; b=mzY4R7+p4ShvEe+YiNgNqQcwAoCo79H7gZOFK/SisXf82MLmsazW6lD94FjwU0fvjsTO2YDat8mq3A7gnIzYC6wjV8KJAbJuCg3OClB+eN+JlkKNi7LKobcjBjqwBqw6w9i80w2E9qvi4+uF8/73Kt+GmxDz+IWH07FY0ks+lO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066485; c=relaxed/simple;
	bh=HFCayw3hHMoM1E/tZoqHCxajiCkACb4bK4W6hYZ6YKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcTLi4LPN/gtONoAodrxebdi2Mc+MPN+55c7EVIOs3UlccVxLey1E3AtdI1DbgPzuKBPIkcfu7I3izTT8H4cnuDdhIzdGPRy+cjEI/PxIjjbLjCqk3jQnev+gYk367PjLj3LhnQUBPZanp3fI+ISRVUV70BTma7xkZd+I8lgo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci5zrTaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951F5C4CECC;
	Fri,  4 Oct 2024 18:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066485;
	bh=HFCayw3hHMoM1E/tZoqHCxajiCkACb4bK4W6hYZ6YKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ci5zrTaIVNArsdmZ692VpHooPano5h2CrU2sGs2jQ0CSJ6r+HyR1HZjPen9ZvnuwS
	 X9F5KwAIVsySD0lxzmtfs3/THd/oiidY3+G/vOo/7snSEbhgxjjAD0qC0ngFpmcKnd
	 XV8u2vTDhnFMfK/RnTkQihuCEOmOIwsCMGKzUhwLvv6BemtmhgCmMNIu/ybQqXucjK
	 zdh9T0XYjwRSsyWwWurhJOTE0L3thw+ucQ77c1GRWRKDvJ8UznyzVfitm905mAIPlw
	 QmlOtT1e2EawxYOGNT2y04P/fFW7FlMUU8wq50abQs+abl4w9J7nrwldAK39h7M6N/
	 BcKFJ74NA0dqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunke Cao <yunkec@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 26/42] media: videobuf2-core: clear memory related fields in __vb2_plane_dmabuf_put()
Date: Fri,  4 Oct 2024 14:26:37 -0400
Message-ID: <20241004182718.3673735-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Yunke Cao <yunkec@chromium.org>

[ Upstream commit 6a9c97ab6b7e85697e0b74e86062192a5ffffd99 ]

Clear vb2_plane's memory related fields in __vb2_plane_dmabuf_put(),
including bytesused, length, fd and data_offset.

Remove the duplicated code in __prepare_dmabuf().

Signed-off-by: Yunke Cao <yunkec@chromium.org>
Acked-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 92efc4676df6d..a50a1f0a7342c 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -302,6 +302,10 @@ static void __vb2_plane_dmabuf_put(struct vb2_buffer *vb, struct vb2_plane *p)
 	p->mem_priv = NULL;
 	p->dbuf = NULL;
 	p->dbuf_mapped = 0;
+	p->bytesused = 0;
+	p->length = 0;
+	p->m.fd = 0;
+	p->data_offset = 0;
 }
 
 /*
@@ -1310,10 +1314,6 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
 
 		/* Release previously acquired memory if present */
 		__vb2_plane_dmabuf_put(vb, &vb->planes[plane]);
-		vb->planes[plane].bytesused = 0;
-		vb->planes[plane].length = 0;
-		vb->planes[plane].m.fd = 0;
-		vb->planes[plane].data_offset = 0;
 
 		/* Acquire each plane's memory */
 		mem_priv = call_ptr_memop(attach_dmabuf,
-- 
2.43.0


