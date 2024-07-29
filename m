Return-Path: <stable+bounces-62496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AC93F3D2
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 13:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBDA1F225E0
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 11:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BF7145FEC;
	Mon, 29 Jul 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zOaoFHzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A249145B3F
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252021; cv=none; b=grago57PM53LXNVOPwTZwxy2ALixX4ARnvw7hprsIdVof97PXJSy1NcAGv5VFa4ZmvshTz/2wPZ4GM68/R9sN8H3SFeHQ0KV0sHySyYexy5qDXCdz0EPf62q6T0ga8elso4MYLEbXwhciM/0aw4e1r9cUL0+41iH6+GxNRG4y7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252021; c=relaxed/simple;
	bh=KYg1EYmKAfCHn06orEwHJHXpcT8AUlXNnondr0MxF3A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CLo6aiNDtegNJjiazlUX7UZu7RsmfEpvyFfcCW2lwuSNKVduJCwaNX8Bry4PMTkwH2pEFC8RpX6CDJ1B55yjD1tYapPhWT6TwKA0WzOtpCdqLOkPdgMbuK25pMSQlQVjbJugI/ZjmfqFr/jBWsQY8HzLdi20A36n3bphboZoszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zOaoFHzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5132EC4AF07;
	Mon, 29 Jul 2024 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722252020;
	bh=KYg1EYmKAfCHn06orEwHJHXpcT8AUlXNnondr0MxF3A=;
	h=Subject:To:Cc:From:Date:From;
	b=zOaoFHzH7Je/RdeMi0RxzpzWu75wiBPOQynUKUKVYPB03SU7nssAFF5HDZa2MDQId
	 pmEDITn1AJjDnf3iflOSdqLpQsjCIJiD5RdQK66xpJZiBONrKPdhpKUAPcoS0fbXA/
	 3VUhWyTqfsy+9QQ2H9wl1d79zsEtnauAmALHqu4E=
Subject: FAILED: patch "[PATCH] jbd2: avoid infinite transaction commit loop" failed to apply to 5.15-stable tree
To: jack@suse.cz,alex.coffin@maticrobots.com,tytso@mit.edu,yi.zhang@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 13:20:17 +0200
Message-ID: <2024072917-thirty-clay-7316@gregkh>
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
git cherry-pick -x 27ba5b67312a944576addc4df44ac3b709aabede
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072917-thirty-clay-7316@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


