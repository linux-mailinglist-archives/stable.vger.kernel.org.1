Return-Path: <stable+bounces-64090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DBE941C12
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CF71C2312E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABE1189502;
	Tue, 30 Jul 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qcLxyOR1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A481A6192;
	Tue, 30 Jul 2024 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358958; cv=none; b=IgOdO8n8DktNJnDe3rwS6zRkiPlGH59w44F+RqYx6czdkvVK8+LIMKsREyKXcEMdsNXP5ZJvvJPOSviCmabcr+vOZIdrFh3TLkqPXjtHFxkMOzrTy9Q0a5JgDuPnXAOnAPfWWa7dCbULo1T6oXb71X5FFcy+4DQWwGQl5W6NUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358958; c=relaxed/simple;
	bh=W18sHSEX+pfb7/XjmGI49i9vO0Ri8f+PTMc3m0tYOiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBQQ8eYSDjq6fMqA5smpWqoq1i3+V7apS+seN6TbAcydSX49mfWjUwzXJfNl3B5nNoQWH7/nlLCVkO5OP5IOAtq8p13xyPAD9BbfEx04lk19I7yIg10lDA5qFCWR3BuN/YFjH5hI02r/eeWb3WykCdxFSsNGMenfz7OWzkT8mkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qcLxyOR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4A6C32782;
	Tue, 30 Jul 2024 17:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358958;
	bh=W18sHSEX+pfb7/XjmGI49i9vO0Ri8f+PTMc3m0tYOiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcLxyOR1z+9/itcGXkhlQgEyFvQsrcMeoVtKw2NPsIL44xLOtt5vm3SY94cLFUkdg
	 ho1kdnsX3p8xHHghkBUOfX0PY1xDDGpiEnHedLahkK4EUvAicPlbKbWZh+enRDc8NN
	 cVWdwERvHRIUi5fwM+Aed3pRf/OBuNIzwp531L3w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Coffin <alex.coffin@maticrobots.com>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.6 412/568] jbd2: avoid infinite transaction commit loop
Date: Tue, 30 Jul 2024 17:48:39 +0200
Message-ID: <20240730151655.971322064@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 27ba5b67312a944576addc4df44ac3b709aabede upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/jbd2/transaction.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -191,6 +191,13 @@ static void sub_reserved_credits(journal
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
@@ -322,12 +329,12 @@ static int start_this_handle(journal_t *
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



