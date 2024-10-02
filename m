Return-Path: <stable+bounces-78646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564B98D267
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B673B2845B2
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727F6200121;
	Wed,  2 Oct 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iz1lJff6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB01E4924
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869552; cv=none; b=eQj4Q9kNPY8iUSDsxydkUrPWnf/mDxW5V6fc7GnuQdeVj2skjNpp/78lAU5pXqhpm7L/h3New5uVtzUqkVASQPQrS4iaRaOq+fNLPYNwbeF8zOPGhiKcZGBKIkRwsHPaHtknZa5qGUGS1hRexrgogvSjr2cE2tB8JRplLp0W3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869552; c=relaxed/simple;
	bh=Vro/iY6IOMYaRP9k8X8Q2e35AzaTy0Vy0XVf9dHpFDw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NqbbMcuvFXBDeoCouUufMXnseGNQS6jVUq7grnmGC2RWLtCIlaUrUW8pIVpbrBhwK8VA/lqUSMUWHnB8CHBesIfO2rK8kfgbdO93A2zhje/0b+2TDekkcecWsnCFBnTg0TLdeQqRg1Kqtr4lEd1ImIRYtfbObEVtG0Qzdv1ct8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iz1lJff6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1F8C4CEC5;
	Wed,  2 Oct 2024 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727869551;
	bh=Vro/iY6IOMYaRP9k8X8Q2e35AzaTy0Vy0XVf9dHpFDw=;
	h=Subject:To:Cc:From:Date:From;
	b=Iz1lJff60KV1s2N3KuOI9Dvi9WdxhDuecBBNB3Act1T30XtKUkFyDhk3P0XIg9dQa
	 c11O4L9foL0w11Pm0TbEfOROQ3WpovEuTsHFBrjabauN5Oxw2PvO0oEEe6OR66uwnt
	 /ggjc6Bma1ySkruNntu3Db1eczwU6wsqBS2/dzaU=
Subject: FAILED: patch "[PATCH] block, bfq: fix procress reference leakage for bfqq in merge" failed to apply to 4.19-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 13:45:34 +0200
Message-ID: <2024100234-dizzy-backlands-30eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 73aeab373557fa6ee4ae0b742c6211ccd9859280
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100234-dizzy-backlands-30eb@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

73aeab373557 ("block, bfq: fix procress reference leakage for bfqq in merge chain")
9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
246cf66e300b ("block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq")
337366e02b37 ("block, bfq: replace 0/1 with false/true in bic apis")
64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
dc469ba2e790 ("block/bfq: Use the new blk_opf_t type")
4e54a2493e58 ("bfq: Get rid of __bio_blkcg() usage")
09f871868080 ("bfq: Track whether bfq_group is still online")
ea591cd4eb27 ("bfq: Update cgroup information before merging bio")
3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
f6bad159f5d5 ("block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"")
a0725c22cd84 ("bfq: use bfq_bic_lookup in bfq_limit_depth")
1f18b7005b49 ("bfq: Limit waker detection in time")
76f1df88bbc2 ("bfq: Limit number of requests consumed by each cgroup")
44dfa279f117 ("bfq: Store full bitmap depth in bfq_data")
ae0f1a732f4a ("blk-mq: Stop using pointers for blk_mq_tags bitmap tags")
e155b0c238b2 ("blk-mq: Use shared tags for shared sbitmap support")
645db34e5050 ("blk-mq: Refactor and rename blk_mq_free_map_and_{requests->rqs}()")
63064be150e4 ("blk-mq: Add blk_mq_alloc_map_and_rqs()")
a7e7388dced4 ("blk-mq: Add blk_mq_tag_update_sched_shared_sbitmap()")

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


