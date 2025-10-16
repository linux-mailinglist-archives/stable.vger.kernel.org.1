Return-Path: <stable+bounces-185916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340ABE2433
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4056353300
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D7230F936;
	Thu, 16 Oct 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YsuKLoVg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302F030F932
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605195; cv=none; b=Icyg4LRC+wRJXv++XmiU9Lo0cigvtVBSQBdDxkDGoy/G/Tpxu/J5TALti3ElThB68Y3TxlNxIV2l2APmTxkTffW0iKauBh0hTI1OyvmJQrS/qC3wV2giphEmuXaklQ1W4aY/W/doG3J66sKRmHhLf+pNw7CSac+Aze2+iztdPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605195; c=relaxed/simple;
	bh=uVSi2d1aZspnmIM3zeLzJ7WEuAyqmbUbCP/Rcjpoy6I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kwnAQFQ5aT4UwoJHjiJE6uaWsZLzxX5G2qw3KQs80nZC+Sb307Ce0iDddwesBrz0u0RfQwT8PFNm+9ACn0OjLjpkwF4ilwrIvqn4v5r1TF8x9ydVv8ndIWWOiYlupX0SOUWb8JieoDofdqzVUjokHhgbJ88aLlzQij1vhgDIXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YsuKLoVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEF2C4CEF1;
	Thu, 16 Oct 2025 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760605194;
	bh=uVSi2d1aZspnmIM3zeLzJ7WEuAyqmbUbCP/Rcjpoy6I=;
	h=Subject:To:Cc:From:Date:From;
	b=YsuKLoVghW3/Ig+Lq/aDIpD1Ae272UTjzm/VBYEUmDnEhbfnL1rd5Sb6U82p2Ob5n
	 LlVq8maYbQnh9+ubSlwxX3JpqNLolLLF2op/JDitSd019O8IQNvCcQfM7rBfw2hbyv
	 5p1kGbZV4IQBx2TuPrb/PP4j2hbO/2rJfl5sUbDs=
Subject: FAILED: patch "[PATCH] media: cx18: Add missing check after DMA map" failed to apply to 5.4-stable tree
To: fourier.thomas@gmail.com,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 10:59:41 +0200
Message-ID: <2025101641-palpitate-pesticide-3ad4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 23b53639a793477326fd57ed103823a8ab63084f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101641-palpitate-pesticide-3ad4@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23b53639a793477326fd57ed103823a8ab63084f Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Wed, 9 Jul 2025 13:35:40 +0200
Subject: [PATCH] media: cx18: Add missing check after DMA map

The DMA map functions can fail and should be tested for errors.
If the mapping fails, dealloc buffers, and return.

Fixes: 1c1e45d17b66 ("V4L/DVB (7786): cx18: new driver for the Conexant CX23418 MPEG encoder chip")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/pci/cx18/cx18-queue.c b/drivers/media/pci/cx18/cx18-queue.c
index 013694bfcb1c..7cbb2d586932 100644
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


