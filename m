Return-Path: <stable+bounces-78638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0397498D260
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353611C21A0A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 11:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F697205E16;
	Wed,  2 Oct 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bRMHlprw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB71EC017
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727869527; cv=none; b=qE1FLPAs6eilwRygF0MqgOkTHm4KNvTqP2yTaveENljZSItfU/BFZQ/E8A/UT2DELOAvZBXT9C54NYjHcYla0FlH757jzcK8xKP7lfetYer9QD0F0VPWyKkXOMb1Cb5EpgGUmIDHLsF0RFdQkQ5B/qfNBswN5eo+oa2Wn/nfa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727869527; c=relaxed/simple;
	bh=u9wGlJSKjAX9YlBbb38czA/NaooxjVWuFBdcD4WnDAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Tul7+zi9yp2+0NzQwgr+v3mTL3CXPYJhBU1pLilnhurBokSRISKVO3j3BVoELUk9s5Qxe5LSXlJxA2QY0+H2XB7uQeN0Ex/YnOlAV1wtbe2tH8hWMfTeUcZ51vH+UZESxL9kXxcBuWWA99M9s9YHYXOmkxMurYJnuP7EzUKIBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bRMHlprw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E59C4CEC5;
	Wed,  2 Oct 2024 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727869526;
	bh=u9wGlJSKjAX9YlBbb38czA/NaooxjVWuFBdcD4WnDAI=;
	h=Subject:To:Cc:From:Date:From;
	b=bRMHlprwk7NHTCXrk/4JK54KIYCE2ls9+S6Z8dwyGSt9dAxbPfqfHUGOepRygcWQY
	 YCNEfJH+4va99nBkd3vkDM+ywc8lWcBG+YOSguzo68xgt3MhzvMIohrDNSuFC4qVLI
	 fDoRP68BU3OZYv4iOH4fqlLWtaIoPIaXnKQXRFTU=
Subject: FAILED: patch "[PATCH] block, bfq: fix uaf for accessing waker_bfqq after splitting" failed to apply to 5.15-stable tree
To: yukuai3@huawei.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 13:45:21 +0200
Message-ID: <2024100221-pang-residue-68ad@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1ba0403ac6447f2d63914fb760c44a3b19c44eaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100221-pang-residue-68ad@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


