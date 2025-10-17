Return-Path: <stable+bounces-187200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E565BEA0EC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2AF1886BD4
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D38335060;
	Fri, 17 Oct 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rhGS2B3M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DEC332907;
	Fri, 17 Oct 2025 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715398; cv=none; b=mQBLQeE5A6y2KLRLe7O2y73NfJLozzg/FjmIPrS5jfZuH+7sMsMjZL/A5AbK1001Jy4wwsfqcxBYprwny5CWOa3oACtTFkyxZCaFHxzLGuSEbuTEg34o6JuNmpwg/iZvcUijtcTPOr8LE+n2fKGmD+09sZb7PUbj/dhoQcjUr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715398; c=relaxed/simple;
	bh=iIFdI1EqcUfODXdCOM/mDp966i/1RfG2kK/vklta/fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM0JbezPmiqofgSHdWaBRdCbKFtz5/lecJAvirga3HGzHCpy0HVI6hkBZ442FqZjsxLXSP9iRCBDEZm0ew1/BwEzYTIfw9cJj1iHkzWG1hC5BeWAqFarjkB4cEHeQOMsvnQayyf2AEqvYNbN094p7mweiofpLo7RUC621yEqLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rhGS2B3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F423C4CEE7;
	Fri, 17 Oct 2025 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715398;
	bh=iIFdI1EqcUfODXdCOM/mDp966i/1RfG2kK/vklta/fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhGS2B3MJjSDwAcX/Szq9Y1HOwuwe5ikmIha4mBDO8/IbIRN2IyGYk5VfXTu3KDjO
	 8zOfzygaGtxuvRnEqJdQSbolCe76OGVYjeF+L02B0UC11alzRSDu26CIQoicNJl/vk
	 PCL5CTuf/swYLwCpgw2VMO/b2TFVUpR2PMW87NfY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.17 169/371] media: cx18: Add missing check after DMA map
Date: Fri, 17 Oct 2025 16:52:24 +0200
Message-ID: <20251017145208.046113950@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit 23b53639a793477326fd57ed103823a8ab63084f upstream.

The DMA map functions can fail and should be tested for errors.
If the mapping fails, dealloc buffers, and return.

Fixes: 1c1e45d17b66 ("V4L/DVB (7786): cx18: new driver for the Conexant CX23418 MPEG encoder chip")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx18/cx18-queue.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/media/pci/cx18/cx18-queue.c
+++ b/drivers/media/pci/cx18/cx18-queue.c
@@ -379,15 +379,22 @@ int cx18_stream_alloc(struct cx18_stream
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



