Return-Path: <stable+bounces-62495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C093F3CF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7AA1C21680
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF947CF3E;
	Mon, 29 Jul 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r4Fa3Gxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8ED21373
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251993; cv=none; b=enTZf87iGLqPdH3Bd94mPIIeVNc3xTMkjraIeIc1Q6YmJmeczh25xcJnzRLfsCagIz0BHF8rl7W0Ex4+n5uurdSYNWRDaDgwpJzHOpbcW85qwdJ0dwDAXf0KjqFEDz7xAQIYfSmNzMgTOmsTGdorhpBemu5QHdMu0VQSmxjTjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251993; c=relaxed/simple;
	bh=jumy7BsmHglYXB7SUWQn7cvbtp2aFWbszqj6qkqRTrQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GX/6OPOpFh/6g81+VYvjDgfCXukbjjnOLUPdDMbN3jQQU3jXefCBzSD2U8tjDlW1QB+Ak32otN+mnM44SbEC/0FQ2TzdnYdw2MT6YTmkEOH2/sBxDhlFMiQYVbnKmZHJpCP5/k5nIH7LzovKJXlOZmDdvT6mmAG0BT0lO+4INhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r4Fa3Gxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1B8C32786;
	Mon, 29 Jul 2024 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722251993;
	bh=jumy7BsmHglYXB7SUWQn7cvbtp2aFWbszqj6qkqRTrQ=;
	h=Subject:To:Cc:From:Date:From;
	b=r4Fa3GxpkjZkg/3zv4LwS9bTbgcQ8bYKIBtG6hPkBMQtrv559W+DUKigih6wGDqR3
	 P3170OZ/eIJzX0o69fIznhqdgf37+1gfJRKGOmQtZI8WK8y6TckAzl6M34VEVUV9VV
	 J82U/e6hWeULPZp1Bf23/0HWq/yQOsnsxedQE2GE=
Subject: FAILED: patch "[PATCH] jbd2: avoid infinite transaction commit loop" failed to apply to 6.1-stable tree
To: jack@suse.cz,alex.coffin@maticrobots.com,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:19:50 +0200
Message-ID: <2024072949-unframed-extradite-14cf@gregkh>
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
git cherry-pick -x 27ba5b67312a944576addc4df44ac3b709aabede
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072949-unframed-extradite-14cf@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

27ba5b67312a ("jbd2: avoid infinite transaction commit loop")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27ba5b67312a944576addc4df44ac3b709aabede Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 24 Jun 2024 19:01:19 +0200
Subject: [PATCH] jbd2: avoid infinite transaction commit loop

Commit 9f356e5a4f12 ("jbd2: Account descriptor blocks into
t_outstanding_credits") started to account descriptor blocks into
transactions outstanding credits. However it didn't appropriately
decrease the maximum amount of credits available to userspace. Thus if
the filesystem requests a transaction smaller than
j_max_transaction_buffers but large enough that when descriptor blocks
are added the size exceeds j_max_transaction_buffers, we confuse
add_transaction_credits() into thinking previous handles have grown the
transaction too much and enter infinite journal commit loop in
start_this_handle() -> add_transaction_credits() trying to create
transaction with enough credits available.

Fix the problem by properly accounting for transaction space reserved
for descriptor blocks when verifying requested transaction handle size.

CC: stable@vger.kernel.org
Fixes: 9f356e5a4f12 ("jbd2: Account descriptor blocks into t_outstanding_credits")
Reported-by: Alexander Coffin <alex.coffin@maticrobots.com>
Link: https://lore.kernel.org/all/CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20240624170127.3253-3-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index a095f1a3114b..66513c18ca29 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -191,6 +191,13 @@ static void sub_reserved_credits(journal_t *journal, int blocks)
 	wake_up(&journal->j_wait_reserved);
 }
 
+/* Maximum number of blocks for user transaction payload */
+static int jbd2_max_user_trans_buffers(journal_t *journal)
+{
+	return journal->j_max_transaction_buffers -
+				journal->j_transaction_overhead_buffers;
+}
+
 /*
  * Wait until we can add credits for handle to the running transaction.  Called
  * with j_state_lock held for reading. Returns 0 if handle joined the running
@@ -240,12 +247,12 @@ __must_hold(&journal->j_state_lock)
 		 * big to fit this handle? Wait until reserved credits are freed.
 		 */
 		if (atomic_read(&journal->j_reserved_credits) + total >
-		    journal->j_max_transaction_buffers) {
+		    jbd2_max_user_trans_buffers(journal)) {
 			read_unlock(&journal->j_state_lock);
 			jbd2_might_wait_for_commit(journal);
 			wait_event(journal->j_wait_reserved,
 				   atomic_read(&journal->j_reserved_credits) + total <=
-				   journal->j_max_transaction_buffers);
+				   jbd2_max_user_trans_buffers(journal));
 			__acquire(&journal->j_state_lock); /* fake out sparse */
 			return 1;
 		}
@@ -285,14 +292,14 @@ __must_hold(&journal->j_state_lock)
 
 	needed = atomic_add_return(rsv_blocks, &journal->j_reserved_credits);
 	/* We allow at most half of a transaction to be reserved */
-	if (needed > journal->j_max_transaction_buffers / 2) {
+	if (needed > jbd2_max_user_trans_buffers(journal) / 2) {
 		sub_reserved_credits(journal, rsv_blocks);
 		atomic_sub(total, &t->t_outstanding_credits);
 		read_unlock(&journal->j_state_lock);
 		jbd2_might_wait_for_commit(journal);
 		wait_event(journal->j_wait_reserved,
 			 atomic_read(&journal->j_reserved_credits) + rsv_blocks
-			 <= journal->j_max_transaction_buffers / 2);
+			 <= jbd2_max_user_trans_buffers(journal) / 2);
 		__acquire(&journal->j_state_lock); /* fake out sparse */
 		return 1;
 	}
@@ -322,12 +329,12 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 	 * size and limit the number of total credits to not exceed maximum
 	 * transaction size per operation.
 	 */
-	if ((rsv_blocks > journal->j_max_transaction_buffers / 2) ||
-	    (rsv_blocks + blocks > journal->j_max_transaction_buffers)) {
+	if (rsv_blocks > jbd2_max_user_trans_buffers(journal) / 2 ||
+	    rsv_blocks + blocks > jbd2_max_user_trans_buffers(journal)) {
 		printk(KERN_ERR "JBD2: %s wants too many credits "
 		       "credits:%d rsv_credits:%d max:%d\n",
 		       current->comm, blocks, rsv_blocks,
-		       journal->j_max_transaction_buffers);
+		       jbd2_max_user_trans_buffers(journal));
 		WARN_ON(1);
 		return -ENOSPC;
 	}


