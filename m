Return-Path: <stable+bounces-62749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD6940F02
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD894B23BB9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A97197A90;
	Tue, 30 Jul 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IK6o1cNC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB445195B28
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335145; cv=none; b=VO1sZ+xa17pU9N1s0e3nbwGbdgBHMALIS5u4mbGH4Ik8frdUTx1G/jSSqFlKslmpY1wB1fBYndf63XM2DGoqtx2qdhjoK5HfYIwwGVoqvuQWYbx391sFZ+ol+XmwXScDFdXbXv6uoSCfPMKhyUsh7rFwONMsoUxbiO9jS2PYSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335145; c=relaxed/simple;
	bh=eo9OI4ZC+y6kG+8h3zwsXkgm7LXs/65a5pGRMy+tw9w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U1g9ptGmZzsNeJU7+aUroGLuDMDhuL85Jm/kWhLOxUyjhMuJnMhQj12Uw7uiUH1GIY5g0ecP8PyDhzIQvF0eea49X6XShhu1ShY3h8khdbAJil/M+FIn8TMP6Ixod6rMGrn7t14LBVBS2tyZPxIG2E4qweqeUqdrCT8qxr2Of88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IK6o1cNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B1CC32782;
	Tue, 30 Jul 2024 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335145;
	bh=eo9OI4ZC+y6kG+8h3zwsXkgm7LXs/65a5pGRMy+tw9w=;
	h=Subject:To:Cc:From:Date:From;
	b=IK6o1cNC3thRDSUyA4XDA0uqmwYLdB7sA0b3SNkpEPqpgb8+Y7/pxI1375K5xW/qE
	 rg2aybxwBu4lRSF6CzMuPqjAbnS9vKrEboBSGiRfz5LU38bxotozBtUVtdV7a5lhWa
	 J/HReOW/ThLOk80QwRt3+AmpCM3GgM38/bUROtuE=
Subject: FAILED: patch "[PATCH] rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive" failed to apply to 4.19-stable tree
To: idryomov@gmail.com,dongsheng.yang@easystack.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:25:29 +0200
Message-ID: <2024073029-defog-revolt-64f0@gregkh>
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
git cherry-pick -x 2237ceb71f89837ac47c5dce2aaa2c2b3a337a3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073029-defog-revolt-64f0@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

2237ceb71f89 ("rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive mappings")
ded080c86b3f ("rbd: don't move requests to the running list on errors")
637cd060537d ("rbd: new exclusive lock wait/wake code")
e1fddc8fdd22 ("rbd: quiescing lock should wait for image requests")
a2b1da09793d ("rbd: lock should be quiesced on reacquire")
0192ce2ee68b ("rbd: introduce image request state machine")
85b5e6d11898 ("rbd: move OSD request submission into object request state machines")
0ad5d953548f ("rbd: get rid of RBD_OBJ_WRITE_{FLAT,GUARD}")
a9b67e69949d ("rbd: replace obj_req->tried_parent with obj_req->read_state")
54ab3b24c536 ("rbd: get rid of obj_req->xferred, obj_req->result and img_req->xferred")
9b17eb2ce102 ("rbd: whole-object write and zeroout should copyup when snapshots exist")
89a59c1ca73b ("rbd: copyup with an empty snapshot context (aka deep-copyup)")
3a482501cf70 ("rbd: introduce rbd_obj_issue_copyup_ops()")
13488d53775b ("rbd: stop copying num_osd_ops in rbd_obj_issue_copyup()")
356889c49d84 ("rbd: clear ->xferred on error from rbd_obj_issue_copyup()")
0c93e1b7a26b ("rbd: round off and ignore discards that are too small")
6484cbe987e0 ("rbd: handle DISCARD and WRITE_ZEROES separately")
fd7e3f0d8f25 ("rbd: get rid of obj_req->obj_request_count")
26f887e0a3c4 ("libceph, rbd, ceph: move ceph_osdc_alloc_messages() calls")
39e58c3425b1 ("libceph: introduce alloc_watch_request()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2237ceb71f89837ac47c5dce2aaa2c2b3a337a3c Mon Sep 17 00:00:00 2001
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 23 Jul 2024 18:07:59 +0200
Subject: [PATCH] rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive
 mappings

Every time a watch is reestablished after getting lost, we need to
update the cookie which involves quiescing exclusive lock.  For this,
we transition from RBD_LOCK_STATE_LOCKED to RBD_LOCK_STATE_QUIESCING
roughly for the duration of rbd_reacquire_lock() call.  If the mapping
is exclusive and I/O happens to arrive in this time window, it's failed
with EROFS (later translated to EIO) based on the wrong assumption in
rbd_img_exclusive_lock() -- "lock got released?" check there stopped
making sense with commit a2b1da09793d ("rbd: lock should be quiesced on
reacquire").

To make it worse, any such I/O is added to the acquiring list before
EROFS is returned and this sets up for violating rbd_lock_del_request()
precondition that the request is either on the running list or not on
any list at all -- see commit ded080c86b3f ("rbd: don't move requests
to the running list on errors").  rbd_lock_del_request() ends up
processing these requests as if they were on the running list which
screws up quiescing_wait completion counter and ultimately leads to

    rbd_assert(!completion_done(&rbd_dev->quiescing_wait));

being triggered on the next watch error.

Cc: stable@vger.kernel.org # 06ef84c4e9c4: rbd: rename RBD_LOCK_STATE_RELEASING and releasing_wait
Cc: stable@vger.kernel.org
Fixes: 637cd060537d ("rbd: new exclusive lock wait/wake code")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c30d227753d7..ea6c592e015c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3457,6 +3457,7 @@ static void rbd_lock_del_request(struct rbd_img_request *img_req)
 	lockdep_assert_held(&rbd_dev->lock_rwsem);
 	spin_lock(&rbd_dev->lock_lists_lock);
 	if (!list_empty(&img_req->lock_item)) {
+		rbd_assert(!list_empty(&rbd_dev->running_list));
 		list_del_init(&img_req->lock_item);
 		need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_QUIESCING &&
 			       list_empty(&rbd_dev->running_list));
@@ -3476,11 +3477,6 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
 	if (rbd_lock_add_request(img_req))
 		return 1;
 
-	if (rbd_dev->opts->exclusive) {
-		WARN_ON(1); /* lock got released? */
-		return -EROFS;
-	}
-
 	/*
 	 * Note the use of mod_delayed_work() in rbd_acquire_lock()
 	 * and cancel_delayed_work() in wake_lock_waiters().
@@ -4601,6 +4597,10 @@ static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
 			rbd_warn(rbd_dev, "failed to update lock cookie: %d",
 				 ret);
 
+		if (rbd_dev->opts->exclusive)
+			rbd_warn(rbd_dev,
+			     "temporarily releasing lock on exclusive mapping");
+
 		/*
 		 * Lock cookie cannot be updated on older OSDs, so do
 		 * a manual release and queue an acquire.


