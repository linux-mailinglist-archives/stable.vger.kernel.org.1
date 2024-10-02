Return-Path: <stable+bounces-78642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D135098D264
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19281C21AC9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43717DA81;
	Wed,  2 Oct 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r+diG6sU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BFD1E492A
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869540; cv=none; b=h0vVaP7uG+Kh27Yayvrg5N9QiDELxM6MksS+Z0i1wLhJTPlo/q9PwssBmv1MKLtvBRiFn/fO1uvEKIeanuhsl0b8oWJQZsrZKHecdxOPRvZWNpka3T+mCKJUMdhOXPaywLgX2vV7vibDBIdWWez3eLyiauu9uEkNXE+84JVdyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869540; c=relaxed/simple;
	bh=cimU70s8f/klXKS8VxQz0rgK/rj9YwqvC88vkYZ2Mfw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fpsDkmKFSIN7ztiKcuanCusEl8SBj09CbIC7smR+JeEnWuUmcOWevF5Tt+J5rKza0K56WaT9xdbKXg4Wbqfli8XgHiKktAQUXcDggoXbj10PlUwLcilf29htqnfKp/RuRj2q4BJozaXfSkUkdZomMnd5BaHlRlFdNncROuqZVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r+diG6sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49BBC4CEC5;
	Wed,  2 Oct 2024 11:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727869540;
	bh=cimU70s8f/klXKS8VxQz0rgK/rj9YwqvC88vkYZ2Mfw=;
	h=Subject:To:Cc:From:Date:From;
	b=r+diG6sUbS3THSvWEqUU5TjISiXRDyhyUkwkvvTIsjgv/sHPWQ9e6hMHfwiYQgEyJ
	 EeJulyZFR7L54qKdGrCZgIvwUJznomEpeD6DPhaOcVRreNR2dgoGAT0aqo2Iyc3tgQ
	 V/D3Fxewa67Kwh0EkR2QpN3zI/RAlfEDtehgqE7Q=
Subject: FAILED: patch "[PATCH] block, bfq: fix procress reference leakage for bfqq in merge" failed to apply to 6.1-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 13:45:29 +0200
Message-ID: <2024100229-lazy-atonable-fd03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 73aeab373557fa6ee4ae0b742c6211ccd9859280
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100229-lazy-atonable-fd03@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

73aeab373557 ("block, bfq: fix procress reference leakage for bfqq in merge chain")
9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
246cf66e300b ("block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq")
337366e02b37 ("block, bfq: replace 0/1 with false/true in bic apis")
64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 73aeab373557fa6ee4ae0b742c6211ccd9859280 Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Mon, 9 Sep 2024 21:41:49 +0800
Subject: [PATCH] block, bfq: fix procress reference leakage for bfqq in merge
 chain
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Original state:

        Process 1       Process 2       Process 3       Process 4
         (BIC1)          (BIC2)          (BIC3)          (BIC4)
          Λ                |               |               |
           \--------------\ \-------------\ \-------------\|
                           V               V               V
          bfqq1--------->bfqq2---------->bfqq3----------->bfqq4
    ref    0               1               2               4

After commit 0e456dba86c7 ("block, bfq: choose the last bfqq from merge
chain in bfq_setup_cooperator()"), if P1 issues a new IO:

Without the patch:

        Process 1       Process 2       Process 3       Process 4
         (BIC1)          (BIC2)          (BIC3)          (BIC4)
          Λ                |               |               |
           \------------------------------\ \-------------\|
                                           V               V
          bfqq1--------->bfqq2---------->bfqq3----------->bfqq4
    ref    0               0               2               4

bfqq3 will be used to handle IO from P1, this is not expected, IO
should be redirected to bfqq4;

With the patch:

          -------------------------------------------
          |                                         |
        Process 1       Process 2       Process 3   |   Process 4
         (BIC1)          (BIC2)          (BIC3)     |    (BIC4)
                           |               |        |      |
                            \-------------\ \-------------\|
                                           V               V
          bfqq1--------->bfqq2---------->bfqq3----------->bfqq4
    ref    0               0               2               4

IO is redirected to bfqq4, however, procress reference of bfqq3 is still
2, while there is only P2 using it.

Fix the problem by calling bfq_merge_bfqqs() for each bfqq in the merge
chain. Also change bfqq_merge_bfqqs() to return new_bfqq to simplify
code.

Fixes: 0e456dba86c7 ("block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20240909134154.954924-3-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d5d39974c674..f4192d5411d2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3129,10 +3129,12 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_put_queue(bfqq);
 }
 
-static void
-bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
-		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
+static struct bfq_queue *bfq_merge_bfqqs(struct bfq_data *bfqd,
+					 struct bfq_io_cq *bic,
+					 struct bfq_queue *bfqq)
 {
+	struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+
 	bfq_log_bfqq(bfqd, bfqq, "merging with queue %lu",
 		(unsigned long)new_bfqq->pid);
 	/* Save weight raising and idle window of the merged queues */
@@ -3226,6 +3228,8 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	bfq_reassign_last_bfqq(bfqq, new_bfqq);
 
 	bfq_release_process_ref(bfqd, bfqq);
+
+	return new_bfqq;
 }
 
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
@@ -3261,14 +3265,8 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 		 * fulfilled, i.e., bic can be redirected to new_bfqq
 		 * and bfqq can be put.
 		 */
-		bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq,
-				new_bfqq);
-		/*
-		 * If we get here, bio will be queued into new_queue,
-		 * so use new_bfqq to decide whether bio and rq can be
-		 * merged.
-		 */
-		bfqq = new_bfqq;
+		while (bfqq != new_bfqq)
+			bfqq = bfq_merge_bfqqs(bfqd, bfqd->bio_bic, bfqq);
 
 		/*
 		 * Change also bqfd->bio_bfqq, as
@@ -5705,9 +5703,7 @@ bfq_do_early_stable_merge(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * state before killing it.
 	 */
 	bfqq->bic = bic;
-	bfq_merge_bfqqs(bfqd, bic, bfqq, new_bfqq);
-
-	return new_bfqq;
+	return bfq_merge_bfqqs(bfqd, bic, bfqq);
 }
 
 /*
@@ -6162,6 +6158,7 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 	bool waiting, idle_timer_disabled = false;
 
 	if (new_bfqq) {
+		struct bfq_queue *old_bfqq = bfqq;
 		/*
 		 * Release the request's reference to the old bfqq
 		 * and make sure one is taken to the shared queue.
@@ -6178,18 +6175,18 @@ static bool __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 		 * new_bfqq.
 		 */
 		if (bic_to_bfqq(RQ_BIC(rq), true,
-				bfq_actuator_index(bfqd, rq->bio)) == bfqq)
-			bfq_merge_bfqqs(bfqd, RQ_BIC(rq),
-					bfqq, new_bfqq);
+				bfq_actuator_index(bfqd, rq->bio)) == bfqq) {
+			while (bfqq != new_bfqq)
+				bfqq = bfq_merge_bfqqs(bfqd, RQ_BIC(rq), bfqq);
+		}
 
-		bfq_clear_bfqq_just_created(bfqq);
+		bfq_clear_bfqq_just_created(old_bfqq);
 		/*
 		 * rq is about to be enqueued into new_bfqq,
 		 * release rq reference on bfqq
 		 */
-		bfq_put_queue(bfqq);
+		bfq_put_queue(old_bfqq);
 		rq->elv.priv[1] = new_bfqq;
-		bfqq = new_bfqq;
 	}
 
 	bfq_update_io_thinktime(bfqd, bfqq);


