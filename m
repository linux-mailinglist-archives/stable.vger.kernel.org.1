Return-Path: <stable+bounces-144801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9D7ABBDFE
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE04317DD91
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7326D4E3;
	Mon, 19 May 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uZqF9/g8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058826AA93
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658215; cv=none; b=EWzCClIo0D4aU9qiGSXkSqsHXnWxxo+ZEq6FvueXFyfd7IFVv/BrXUl2B2ODFylMYg8HXMioEBhyqYcKewixVPI8AR2FcTycuhQC8dLRHozfdHRJtECRdi31bUmCPbqvFxnzDpVIYp0w5AKQGKUMuygKPWDiHTYm/bFfIUBnLJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658215; c=relaxed/simple;
	bh=ImF+LRswfLxaEVTGzQNDk0qr3TqQKC5CVDtRkSa35RM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lr6bWc5wFS/E4Zz8W2FAPSpyMWu0kScvaOnOYNY4eWiTw+4zsf5ZrGgNurfffepnbIPH2PGaBOOWZDDDwqjCbPi5whRZA6gF+ol+5kxJeAQufPkrkU5c5eHVSVHK+zrRHxOZ4EKxNpvzORCN4pjxUH49hN2N1wjUgp6uVqsAn58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uZqF9/g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2663C4CEE4;
	Mon, 19 May 2025 12:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747658215;
	bh=ImF+LRswfLxaEVTGzQNDk0qr3TqQKC5CVDtRkSa35RM=;
	h=Subject:To:Cc:From:Date:From;
	b=uZqF9/g8MkGFp9J/KGhEfSZhLLnpyC+M/gpzSxwpwC+4GtD2VZYqUIzRPu7tiH1h8
	 SQt4v+atJrPmRjZRzryWckuFN0HHywskKg8kgcgn+vBOVp70yqVO3yWxMrRNsYdYZz
	 Gh4nL4tqxE8YXewRAjnVOhIvMJGAoSnw14en3hvY=
Subject: FAILED: patch "[PATCH] dma-buf: insert memory barrier before updating num_fences" failed to apply to 5.10-stable tree
To: hjeong.choi@samsung.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 14:35:49 +0200
Message-ID: <2025051949-keep-opposing-04c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 72c7d62583ebce7baeb61acce6057c361f73be4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051949-keep-opposing-04c8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72c7d62583ebce7baeb61acce6057c361f73be4a Mon Sep 17 00:00:00 2001
From: Hyejeong Choi <hjeong.choi@samsung.com>
Date: Mon, 12 May 2025 21:06:38 -0500
Subject: [PATCH] dma-buf: insert memory barrier before updating num_fences
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

smp_store_mb() inserts memory barrier after storing operation.
It is different with what the comment is originally aiming so Null
pointer dereference can be happened if memory update is reordered.

Signed-off-by: Hyejeong Choi <hjeong.choi@samsung.com>
Fixes: a590d0fdbaa5 ("dma-buf: Update reservation shared_count after adding the new fence")
CC: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20250513020638.GA2329653@au1-maretx-p37.eng.sarc.samsung.com
Signed-off-by: Christian König <christian.koenig@amd.com>

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index 5f8d010516f0..b1ef4546346d 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -320,8 +320,9 @@ void dma_resv_add_fence(struct dma_resv *obj, struct dma_fence *fence,
 	count++;
 
 	dma_resv_list_set(fobj, i, fence, usage);
-	/* pointer update must be visible before we extend the num_fences */
-	smp_store_mb(fobj->num_fences, count);
+	/* fence update must be visible before we extend the num_fences */
+	smp_wmb();
+	fobj->num_fences = count;
 }
 EXPORT_SYMBOL(dma_resv_add_fence);
 


