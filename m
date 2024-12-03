Return-Path: <stable+bounces-96257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DFC9E18E1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D51166DF4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E101E0E13;
	Tue,  3 Dec 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qRV3XDD9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C451E0E0B
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220629; cv=none; b=gL/hokCDM9yu015nv5JouTTBdUWF51k6HrZsINoiDQC9pkZuCVG7T6SMQ1hw/mQ/mWi8dhwpv6UcNrm1rhLO6+D7vISkeo5A8kuyUnCUxHMbXwDE4DTaEy/YYGVIJ19faaQ4o330Z9SOoo92KCH4oyt17Bb0bG46AOYf6Fw1Nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220629; c=relaxed/simple;
	bh=HhzTNllRGaZKmmMOb1Zy5XPTOCE1X/+489WRShfLzRE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fhc459WocQ8Kx4lOWNFLxZ3Yq+k+dp32uiQc9pfWykMY0X8rbb/ilZc9UXFaDaaYL7/WxfU4VLDyoOGw9QpixXZjtne+XpXP1QAHiGRHNw/1odtG93aTO8gx0pSqwk8T4lqlMsOtbfcAHBYARZnTsR+PI+aq0GB58BjdpEkB7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qRV3XDD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32010C4CED6;
	Tue,  3 Dec 2024 10:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733220629;
	bh=HhzTNllRGaZKmmMOb1Zy5XPTOCE1X/+489WRShfLzRE=;
	h=Subject:To:Cc:From:Date:From;
	b=qRV3XDD93wvP7Z2hro6VuYqGRZRpsGQu+6pPPOE/0udfC9qnP4N9E2dLaoRBmvR1Q
	 kv6uKlhPnG6IuI3sskblhdrg+1dGTDYvINaxkakM/PARhJ6Yx8pt6j+erKtQVZO8s+
	 4OoUlnvvMpAy3Gb6/JUSZ3dbhkXIKeq3mxTavvH0=
Subject: FAILED: patch "[PATCH] block: fix missing dispatching request when queue is started" failed to apply to 5.10-stable tree
To: muchun.song@linux.dev,axboe@kernel.dk,ming.lei@redhat.com,songmuchun@bytedance.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 11:10:24 +0100
Message-ID: <2024120324-eating-amid-74df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 2003ee8a9aa14d766b06088156978d53c2e9be3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120324-eating-amid-74df@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
 


