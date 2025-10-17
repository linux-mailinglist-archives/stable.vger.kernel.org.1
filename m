Return-Path: <stable+bounces-186325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3425BE8F7C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886401AA6BAC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5BD2F6903;
	Fri, 17 Oct 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucjbJloF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DC2F6912
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708364; cv=none; b=QkzkXvQDT8lMXvpK0HPbgIRHcZTEW3zd9N8kWNLsUYrLOFJT73LjC2HhmRBT9aIItGk2X0LcuGriLreoZR7QiFH3cZugpSI7EusSAbYZm5F19RV5OAeSCljlV3qtzqzfH5NW0B5GLaU8S0eCFosGKXa16D2CaodjKAsQKBiiSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708364; c=relaxed/simple;
	bh=sd2km+7BP8WkoxfL2nECXgNvS9LYvCn7i2puj3KCEPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ln4Bd3haNOJwqSM+q51kxE2x77dkl9orAoK+obVFxm3oHJ5A4mcFp8oHsoz+BkS3IQbzlCzZuwIGoVe9QRcWT5Rev1Co3WmBc8C2Jz9KNNkqzFFWNJGtcZBACctE9QH9AK+oMjnk5yHImqZQuu2d/fTTmKTmCaRcheDNU8CbUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucjbJloF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C33C4CEE7;
	Fri, 17 Oct 2025 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760708363;
	bh=sd2km+7BP8WkoxfL2nECXgNvS9LYvCn7i2puj3KCEPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucjbJloF2+z8iaaajL3VCguFIWomM7wj/+96VQyE+H4y3ZkdytnQlOjI4r4CF+A7o
	 elWT+zraJ79s10xfgk4LGVV7Oglk6Mpap7tjohCRJpDrFNHu52aaYDflLIDV04qBIw
	 hdW5t0zgqLXXSovprmsnl2TudUA1/8UtsJqCOKXAClFle9mNH3hMmOfat6QHXvUOuY
	 pPnidQ1W/m+E/g/yuzRZR2HtjfgOlRDdOy2ycFjpmqb6AglhNBtPOtMn0hWC8yE9dd
	 wESPzFLmP0CW5uU5toSOAv9MvbNFxlLhJIeBtbzpOxQRPpKBLmQ2ML5rr2FerE9VCo
	 U20gSl6rYg6fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: cx18: Add missing check after DMA map
Date: Fri, 17 Oct 2025 09:39:17 -0400
Message-ID: <20251017133917.3955532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101641-imminent-rentable-bc13@gregkh>
References: <2025101641-imminent-rentable-bc13@gregkh>
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


