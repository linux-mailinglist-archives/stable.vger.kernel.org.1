Return-Path: <stable+bounces-78641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B7A98D263
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45871C219D9
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8B6200111;
	Wed,  2 Oct 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KLenGjhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64A1E492A
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869535; cv=none; b=EcgVK1d649ETKhI1gSZdZqOdm5AYnA7Fq4nLG4hCbojHMlsatUWva2GoEU3fPQwtIiBJmTwZNZIPDsM+Lc813C9m5fN9CDA2djeK5dCvfHS7CGyrl7a1Fg8PSzwD2/rkOPCHNKDKvir6EIGGu7EkfPAIzeES4Ly+D7iifiUWveA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869535; c=relaxed/simple;
	bh=hChVM80Qj84vSusZ6yrH/b0ylIpqpl5MHEsgM5DoQP4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jpEu7DG6OoIYPuN9AKVOBQJYZwbflEATxrK4phnR+/s6lB2zu6NL11Btc+kJLj1B07B944E08j9ETpleKpJhq5FMjGpNRMdMbT/pWaGbIa4oaNCujoAT++l6UMPZfbNDfVnkqzOG+IGTypgoBikbpM8G3QLuC1kcs2CdIK1QmMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KLenGjhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD35C4CEC5;
	Wed,  2 Oct 2024 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727869535;
	bh=hChVM80Qj84vSusZ6yrH/b0ylIpqpl5MHEsgM5DoQP4=;
	h=Subject:To:Cc:From:Date:From;
	b=KLenGjhnzqDcZusP8sm3LG3RzBn9psOyAf7NQ98Q/Z951MvekAgxBauMdDN1x1dRE
	 aYaFPo3bDZgXRjC3uuTbcHmGAlcUuN4oDbw0Plz53y1KMrd7+UQ19EywHWvY67QmLI
	 0oxyfslAXBGqhaImyGOW4LPKtM8WrmKz6X9osrHs=
Subject: FAILED: patch "[PATCH] block, bfq: fix uaf for accessing waker_bfqq after splitting" failed to apply to 4.19-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 13:45:24 +0200
Message-ID: <2024100223-gutter-exchange-0c2b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 1ba0403ac6447f2d63914fb760c44a3b19c44eaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100223-gutter-exchange-0c2b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

1ba0403ac644 ("block, bfq: fix uaf for accessing waker_bfqq after splitting")
fd571df0ac5b ("block, bfq: turn bfqq_data into an array in bfq_io_cq")
a61230470c8c ("block, bfq: move io_cq-persistent bfqq data into a dedicated struct")
9778369a2d6c ("block, bfq: split sync bfq_queues on a per-actuator basis")
246cf66e300b ("block, bfq: fix uaf for bfqq in bfq_exit_icq_bfqq")
337366e02b37 ("block, bfq: replace 0/1 with false/true in bic apis")
64dc8c732f5c ("block, bfq: fix possible uaf for 'bfqq->bic'")
a1795c2ccb1e ("bfq: fix waker_bfqq inconsistency crash")
dc469ba2e790 ("block/bfq: Use the new blk_opf_t type")
f950667356ce ("bfq: Relax waker detection for shared queues")
4e54a2493e58 ("bfq: Get rid of __bio_blkcg() usage")
09f871868080 ("bfq: Track whether bfq_group is still online")
ea591cd4eb27 ("bfq: Update cgroup information before merging bio")
3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
70456e5210f4 ("bfq: Avoid false marking of bic as stably merged")
f6bad159f5d5 ("block/bfq-iosched.c: use "false" rather than "BLK_RW_ASYNC"")
a0725c22cd84 ("bfq: use bfq_bic_lookup in bfq_limit_depth")
1f18b7005b49 ("bfq: Limit waker detection in time")
76f1df88bbc2 ("bfq: Limit number of requests consumed by each cgroup")
44dfa279f117 ("bfq: Store full bitmap depth in bfq_data")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1ba0403ac6447f2d63914fb760c44a3b19c44eaf Mon Sep 17 00:00:00 2001
From: Yu Kuai <yukuai3@huawei.com>
Date: Mon, 9 Sep 2024 21:41:48 +0800
Subject: [PATCH] block, bfq: fix uaf for accessing waker_bfqq after splitting

After commit 42c306ed7233 ("block, bfq: don't break merge chain in
bfq_split_bfqq()"), if the current procress is the last holder of bfqq,
the bfqq can be freed after bfq_split_bfqq(). Hence recored the bfqq and
then access bfqq->waker_bfqq may trigger UAF. What's more, the waker_bfqq
may in the merge chain of bfqq, hence just recored waker_bfqq is still
not safe.

Fix the problem by adding a helper bfq_waker_bfqq() to check if
bfqq->waker_bfqq is in the merge chain, and current procress is the only
holder.

Fixes: 42c306ed7233 ("block, bfq: don't break merge chain in bfq_split_bfqq()")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20240909134154.954924-2-yukuai1@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index d1bf2b8a3576..d5d39974c674 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6825,6 +6825,31 @@ static void bfq_prepare_request(struct request *rq)
 	rq->elv.priv[0] = rq->elv.priv[1] = NULL;
 }
 
+static struct bfq_queue *bfq_waker_bfqq(struct bfq_queue *bfqq)
+{
+	struct bfq_queue *new_bfqq = bfqq->new_bfqq;
+	struct bfq_queue *waker_bfqq = bfqq->waker_bfqq;
+
+	if (!waker_bfqq)
+		return NULL;
+
+	while (new_bfqq) {
+		if (new_bfqq == waker_bfqq) {
+			/*
+			 * If waker_bfqq is in the merge chain, and current
+			 * is the only procress.
+			 */
+			if (bfqq_process_refs(waker_bfqq) == 1)
+				return NULL;
+			break;
+		}
+
+		new_bfqq = new_bfqq->new_bfqq;
+	}
+
+	return waker_bfqq;
+}
+
 /*
  * If needed, init rq, allocate bfq data structures associated with
  * rq, and increment reference counters in the destination bfq_queue
@@ -6886,7 +6911,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 		/* If the queue was seeky for too long, break it apart. */
 		if (bfq_bfqq_coop(bfqq) && bfq_bfqq_split_coop(bfqq) &&
 			!bic->bfqq_data[a_idx].stably_merged) {
-			struct bfq_queue *old_bfqq = bfqq;
+			struct bfq_queue *waker_bfqq = bfq_waker_bfqq(bfqq);
 
 			/* Update bic before losing reference to bfqq */
 			if (bfq_bfqq_in_large_burst(bfqq))
@@ -6906,7 +6931,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				bfqq_already_existing = true;
 
 			if (!bfqq_already_existing) {
-				bfqq->waker_bfqq = old_bfqq->waker_bfqq;
+				bfqq->waker_bfqq = waker_bfqq;
 				bfqq->tentative_waker_bfqq = NULL;
 
 				/*
@@ -6916,7 +6941,7 @@ static struct bfq_queue *bfq_init_rq(struct request *rq)
 				 * woken_list of the waker. See
 				 * bfq_check_waker for details.
 				 */
-				if (bfqq->waker_bfqq)
+				if (waker_bfqq)
 					hlist_add_head(&bfqq->woken_list_node,
 						       &bfqq->waker_bfqq->woken_list);
 			}


