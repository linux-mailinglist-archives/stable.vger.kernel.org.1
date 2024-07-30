Return-Path: <stable+bounces-62747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F85940EFF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005701C20CEF
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D60196DA1;
	Tue, 30 Jul 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NL6Kg+Nx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255B192B65
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335139; cv=none; b=FmU/Nirql6UAFJDCo/xAC1yw1mOU+QVE5rT7cSAoC+J4aee8NxYXKhm41d2oq3uA3fI4hIdXDVZZIpAw/UQFDUVTt67+Ac0RNKk8tS4zTeKDuqIXy/fiMCO4kW4HbSFcU6pJX0Wf6p4z04/tlcruY/hI/DjW/7Kb3zISnWgm8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335139; c=relaxed/simple;
	bh=u6Yv9kyyENeTnieqYSTkrUkSWd9z09CJw133l+ld+Dg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CP+TUxkT4Mua7iO1ogWWHrYuleYOenQRHihmXpFCvgw2qSToaeq/hEIGsJ/uyooEVw/Egm/u7+KWml2NTDpGPXtsbDelMTja/44PWiwYaxyh/Z8J9o1ChjOKESLDK+Rkj1pd6c+CsLTfGM0WKns+vBsx41CEDJRXWul2Iy/EZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NL6Kg+Nx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C225C32782;
	Tue, 30 Jul 2024 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335138;
	bh=u6Yv9kyyENeTnieqYSTkrUkSWd9z09CJw133l+ld+Dg=;
	h=Subject:To:Cc:From:Date:From;
	b=NL6Kg+NxQE3yMom5BKKSixVeY4A+yVAIsfnCtQYnPHTmfuq3UjmjMNgOMDVMyoPGF
	 KsPVfmiDkoZV7eFuU2AoaXImO0jv+Z4WIoSMgX/qRPJa6yc4wBlKk6VkPuvE3O1kGm
	 pNZ47V2as9MCVxf8OEQ48JJEifhU8ISWrjjTE9CM=
Subject: FAILED: patch "[PATCH] rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive" failed to apply to 5.10-stable tree
To: idryomov@gmail.com,dongsheng.yang@easystack.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:25:25 +0200
Message-ID: <2024073025-raffle-sadness-6e42@gregkh>
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
git cherry-pick -x 2237ceb71f89837ac47c5dce2aaa2c2b3a337a3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073025-raffle-sadness-6e42@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

2237ceb71f89 ("rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive mappings")
ded080c86b3f ("rbd: don't move requests to the running list on errors")

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


