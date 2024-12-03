Return-Path: <stable+bounces-96256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092569E18E0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38C1280E92
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD531E0E0C;
	Tue,  3 Dec 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i7MMSxMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6CD1E0E05
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220626; cv=none; b=THHvZm2unPT7Me+B6D/n9TsUPBoK2xz43gYl8o2AZZqXxaQ2hFKUlxxBtYZZOoObJev14LyqoU0oASj2i2OpukGGE0k2W8CVWymOemE3tDrKaUll8f050oV0qrgCG6OX9I7g6mB5savpz4d12pjCMyCYXCJmrolgmGpzFAGL6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220626; c=relaxed/simple;
	bh=Xnh0x42v2OQxZk+aJLzpNd3RK5Oib+JsrBtUJgEozL0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ks4cBEn0UYXSbi8MS8OgxOXuHTVFsix69iVw3hgbvmR/QD/HWJxVMuk2lWXXZORY6kOAabhSGX7WBGpJfUfyJOg9dHK7/F58YRxJYGNqxtv3SBIV8l8iTwNbktotQOLaMw0LA4Or99RneNYEdAFZjiKaEA0h1CugOOLB9HWkHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i7MMSxMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D76C4CED6;
	Tue,  3 Dec 2024 10:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220626;
	bh=Xnh0x42v2OQxZk+aJLzpNd3RK5Oib+JsrBtUJgEozL0=;
	h=Subject:To:Cc:From:Date:From;
	b=i7MMSxMjJ1sia8lI49jBaNGFah98x7f3aWNAoWQUkQ9gBiWu7uRgUpOpPmJm2ylYP
	 NE3tWdQwV0g42522TeGk8s1yQExA/D+CrwuQ4O+N7AguThaAZbJ3kns3/5+881vzpn
	 JIjDHwlhEnaE9eBmooMOcKXJ4pQ/k31Nhln+SWkY=
Subject: FAILED: patch "[PATCH] block: fix missing dispatching request when queue is started" failed to apply to 6.1-stable tree
To: muchun.song@linux.dev,axboe@kernel.dk,ming.lei@redhat.com,songmuchun@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:10:23 +0100
Message-ID: <2024120322-cyclic-shadily-cc71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2003ee8a9aa14d766b06088156978d53c2e9be3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120322-cyclic-shadily-cc71@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2003ee8a9aa14d766b06088156978d53c2e9be3d Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Mon, 14 Oct 2024 17:29:32 +0800
Subject: [PATCH] block: fix missing dispatching request when queue is started
 or unquiesced

Supposing the following scenario with a virtio_blk driver.

CPU0                    CPU1                    CPU2

blk_mq_try_issue_directly()
  __blk_mq_issue_directly()
    q->mq_ops->queue_rq()
      virtio_queue_rq()
        blk_mq_stop_hw_queue()
                                                virtblk_done()
                        blk_mq_try_issue_directly()
                          if (blk_mq_hctx_stopped())
  blk_mq_request_bypass_insert()                  blk_mq_run_hw_queue()
  blk_mq_run_hw_queue()     blk_mq_run_hw_queue()
                            blk_mq_insert_request()
                            return

After CPU0 has marked the queue as stopped, CPU1 will see the queue is
stopped. But before CPU1 puts the request on the dispatch list, CPU2
receives the interrupt of completion of request, so it will run the
hardware queue and marks the queue as non-stopped. Meanwhile, CPU1 also
runs the same hardware queue. After both CPU1 and CPU2 complete
blk_mq_run_hw_queue(), CPU1 just puts the request to the same hardware
queue and returns. It misses dispatching a request. Fix it by running
the hardware queue explicitly. And blk_mq_request_issue_directly()
should handle a similar situation. Fix it as well.

Fixes: d964f04a8fde ("blk-mq: fix direct issue")
Cc: stable@vger.kernel.org
Cc: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20241014092934.53630-2-songmuchun@bytedance.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7d05a56e3639..5deb9dffca0a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2647,6 +2647,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return;
 	}
 
@@ -2677,6 +2678,7 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(rq->q)) {
 		blk_mq_insert_request(rq, 0);
+		blk_mq_run_hw_queue(hctx, false);
 		return BLK_STS_OK;
 	}
 


