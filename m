Return-Path: <stable+bounces-186320-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35669BE8AEF
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22CF74F2028
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF991E1A3D;
	Fri, 17 Oct 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWIzLZ/z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1232F755
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706010; cv=none; b=X81EfMxV9S8M8cjIFhWGHGPLXYrQu6JTqF+dTeiefyQnhlGELPJvjyflKZG47sAhtT4Sz2JyKmpxJRY/X6Vs9hIycnVhrVwSx6SRwZbJ0r+HnsyouYJXNN1XAFhzkgP3CGLaAY/ASpU4cZ2oiTYZRBoj/GKEW/G7NjoMx+FgVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706010; c=relaxed/simple;
	bh=cp4hvE/rmOyAFBHjUqUqtn+hULJRxgIP7GeLhAWv5us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+h3M9o+Zz2Evvl+8LK9X3KR1gW08eItYgao1uDBZTpDYOY2cY+KBgIbvDdfno3YX7MZXN7Mo8UptWBu5zkHqOz+P7kIDSPRBSTjhzCrjFTRXm7DkOEdQ9nENDgNbAv5uU51nxiesXl4DQA/3sqdlCk4GlGKewkVb2U69mzIBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWIzLZ/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5203CC4CEF9;
	Fri, 17 Oct 2025 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760706009;
	bh=cp4hvE/rmOyAFBHjUqUqtn+hULJRxgIP7GeLhAWv5us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FWIzLZ/zRh6/gpT6MjLgy8E0CGC/8k4yeXdEPNlzrF970OSQgpjFdVi0AAdMiVBnz
	 jabaYYTjfPbyErO5IkjD1Fch8QzwDuchtKDeHe6zanl0/INq1Zbi7+0i0mZpe1f4Mw
	 UR2r9Ikunrztdo/xdy1aHPdzZux6ur0UYP0wyZF+7/BDYxHHNevjTnENtbWfDQE9xl
	 W/9q23GR06VGfmpXhL/Hd1rRGNjJoerSvZNmYNNOQwUySDDEFceey45tfoEPakaTVr
	 X1ujCzeG5Zksi0YnOkPvXR0dZ27vX8pjmpUJfhaYe9LVVPOPrKMJOsI5QDn+uYfUbq
	 SOd+Ct94BpbhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: cx18: Add missing check after DMA map
Date: Fri, 17 Oct 2025 09:00:06 -0400
Message-ID: <20251017130006.3904918-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130006.3904918-1-sashal@kernel.org>
References: <2025101641-clutter-scruffy-a000@gregkh>
 <20251017130006.3904918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit 23b53639a793477326fd57ed103823a8ab63084f ]

The DMA map functions can fail and should be tested for errors.
If the mapping fails, dealloc buffers, and return.

Fixes: 1c1e45d17b66 ("V4L/DVB (7786): cx18: new driver for the Conexant CX23418 MPEG encoder chip")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx18/cx18-queue.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index 013694bfcb1c1..7cbb2d5869320 100644
--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -379,15 +379,22 @@ int cx18_stream_alloc(struct cx18_stream *s)
 			break;
 		}
 
+		buf->dma_handle = dma_map_single(&s->cx->pci_dev->dev,
+						 buf->buf, s->buf_size,
+						 s->dma);
+		if (dma_mapping_error(&s->cx->pci_dev->dev, buf->dma_handle)) {
+			kfree(buf->buf);
+			kfree(mdl);
+			kfree(buf);
+			break;
+		}
+
 		INIT_LIST_HEAD(&mdl->list);
 		INIT_LIST_HEAD(&mdl->buf_list);
 		mdl->id = s->mdl_base_idx; /* a somewhat safe value */
 		cx18_enqueue(s, mdl, &s->q_idle);
 
 		INIT_LIST_HEAD(&buf->list);
-		buf->dma_handle = dma_map_single(&s->cx->pci_dev->dev,
-						 buf->buf, s->buf_size,
-						 s->dma);
 		cx18_buf_sync_for_cpu(s, buf);
 		list_add_tail(&buf->list, &s->buf_pool);
 	}
-- 
2.51.0


