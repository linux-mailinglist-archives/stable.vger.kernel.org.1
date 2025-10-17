Return-Path: <stable+bounces-186327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A6BE9123
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2CCA19A51B2
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DD350D6D;
	Fri, 17 Oct 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqWO7E0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17450231C9F
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709342; cv=none; b=uXRP6PZj3QKgh2WuNZFftrUNi/3RpeIYpPLl+dQDnrAl75BcHYSivv6DmPVTGe/gYlA45P7fpXz9DWScylawRJ8STl1aU/nnAKVWn6JkIzWu5s5lgj99y85qO/N1rXURRi/wGJ8M1wIimOZ3KLSEhxJETW/mAXck3g2TF11bjjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709342; c=relaxed/simple;
	bh=sd2km+7BP8WkoxfL2nECXgNvS9LYvCn7i2puj3KCEPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYJJXV++9eHbs8BjTyGFuTlZPSqVxyZD3/n8fMspec6UfzlvkvyvpPiFFQ/IK0SvfR4fh+cf6oVlbHPGndPyW/xvcToO24GWMmdBjlZ9eo6c/dzqLuJYFdLeiXsDZOXS+rrvYKqs0mgz4N0babD57tlC0mDORYvxBsyiMYbdMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqWO7E0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BDAC4CEE7;
	Fri, 17 Oct 2025 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760709341;
	bh=sd2km+7BP8WkoxfL2nECXgNvS9LYvCn7i2puj3KCEPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqWO7E0jo9FZwNMZZp7yXtKfNTXHpZMcGpiuWAE5siXCUaGszgQlQId1UbVlu6jF8
	 XNaK1tov3FaXvcssdT7oiuU7fx/odnEefjlgF9ciNn2mjOsv8FYEgRhr+pk4PKVxUY
	 n3ehp19V5mRmeNA3sXsv13ORtUElek49tnclhnYeWi3icNvTG9lzYlmMmnSu+QnFJy
	 3kRQsvF6J8kI1OB87jU6DDqrFHyREqQUZLZ13HMpw6Md2q2MpwMKa2fQVL3Z/e4dLX
	 EUfCPpgPwHnqhfXaNRCnJtgV3jFfBKcnwdJHbw5PDW5Tr36BuhmzjvyH2as+ttVRYn
	 81cqRpiZF58Jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] media: cx18: Add missing check after DMA map
Date: Fri, 17 Oct 2025 09:55:39 -0400
Message-ID: <20251017135539.3964005-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101641-palpitate-pesticide-3ad4@gregkh>
References: <2025101641-palpitate-pesticide-3ad4@gregkh>
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
[ removed pci_map_single() replaced by dma_map_single() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx18/cx18-queue.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index 2f5df471dada6..9b247ecf48d5c 100644
--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -379,14 +379,22 @@ int cx18_stream_alloc(struct cx18_stream *s)
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
-		buf->dma_handle = pci_map_single(s->cx->pci_dev,
-				buf->buf, s->buf_size, s->dma);
 		cx18_buf_sync_for_cpu(s, buf);
 		list_add_tail(&buf->list, &s->buf_pool);
 	}
-- 
2.51.0


