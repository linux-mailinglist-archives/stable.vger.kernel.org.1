Return-Path: <stable+bounces-187966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4B4BEFD4D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003AD3E5E7C
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D12E1F13;
	Mon, 20 Oct 2025 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqYd5GKP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72EB2BE639
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947773; cv=none; b=BUW8QPVeHJHLhJJTyIOvO9ks1MUd1lzu2pceDIBp9T8W+zcBVe/RB1HZjve0J1YrouHYzpL+DpWZjuy9VGHCDuji3Wks186C5X0G7DhAvOImjwoICegezYIfdBiUFDE5rJ3vHoO+D845ZNnk6ymX4WiIUGTMuCli0PivGMm0qHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947773; c=relaxed/simple;
	bh=2AwcA/cBa0ueOaGeke9qzadk/ZFtOnIJ6pWoHI10utw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jWjRepMQEyGltT3rNsf6DHzaDbjUmjvDw8v3SNcqKNV5JXaL/X3FG7tLQoSj+mfk1ffXe90piBqzNS/oNrpwNb617Bn6pTC+jA7XnG8dZCI9y/zpwMcqotzulXsbLfpvWU0QCrUkTK7GlCLqDtzwBmLi4dKMBi+rqjPB0Aq1Hvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqYd5GKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14637C4CEF9;
	Mon, 20 Oct 2025 08:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760947773;
	bh=2AwcA/cBa0ueOaGeke9qzadk/ZFtOnIJ6pWoHI10utw=;
	h=Subject:To:Cc:From:Date:From;
	b=fqYd5GKP6dCkfdUI9N/ZRx6pJ/gjZarO/bQ9V0yW8a7IZ5d4oThGn++igMt71HTIk
	 j92YdqtBguwGGsDh8mfrdtqh+uuf/130HCL4vqB6RRlfbleAWvbutOIPiizHHUBBgu
	 Q6etaNnmyZ/Y8Ldt3pBDFw+rEeG0tC3A85T5ds1I=
Subject: FAILED: patch "[PATCH] jbd2: ensure that all ongoing I/O complete before freeing" failed to apply to 5.4-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Oct 2025 10:09:30 +0200
Message-ID: <2025102030-hurt-surplus-ab8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 3c652c3a71de1d30d72dc82c3bead8deb48eb749
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025102030-hurt-surplus-ab8e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3c652c3a71de1d30d72dc82c3bead8deb48eb749 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Tue, 16 Sep 2025 17:33:36 +0800
Subject: [PATCH] jbd2: ensure that all ongoing I/O complete before freeing
 blocks

When releasing file system metadata blocks in jbd2_journal_forget(), if
this buffer has not yet been checkpointed, it may have already been
written back, currently be in the process of being written back, or has
not yet written back.  jbd2_journal_forget() calls
jbd2_journal_try_remove_checkpoint() to check the buffer's status and
add it to the current transaction if it has not been written back. This
buffer can only be reallocated after the transaction is committed.

jbd2_journal_try_remove_checkpoint() attempts to lock the buffer and
check its dirty status while holding the buffer lock. If the buffer has
already been written back, everything proceeds normally. However, there
are two issues. First, the function returns immediately if the buffer is
locked by the write-back process. It does not wait for the write-back to
complete. Consequently, until the current transaction is committed and
the block is reallocated, there is no guarantee that the I/O will
complete. This means that ongoing I/O could write stale metadata to the
newly allocated block, potentially corrupting data. Second, the function
unlocks the buffer as soon as it detects that the buffer is still dirty.
If a concurrent write-back occurs immediately after this unlocking and
before clear_buffer_dirty() is called in jbd2_journal_forget(), data
corruption can theoretically still occur.

Although these two issues are unlikely to occur in practice since the
undergoing metadata writeback I/O does not take this long to complete,
it's better to explicitly ensure that all ongoing I/O operations are
completed.

Fixes: 597599268e3b ("jbd2: discard dirty data when forgetting an un-journalled buffer")
Cc: stable@kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Message-ID: <20250916093337.3161016-2-yi.zhang@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index c7867139af69..3e510564de6e 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1659,6 +1659,7 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 	int drop_reserve = 0;
 	int err = 0;
 	int was_modified = 0;
+	int wait_for_writeback = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1782,18 +1783,22 @@ int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
 		}
 
 		/*
-		 * The buffer is still not written to disk, we should
-		 * attach this buffer to current transaction so that the
-		 * buffer can be checkpointed only after the current
-		 * transaction commits.
+		 * The buffer has not yet been written to disk. We should
+		 * either clear the buffer or ensure that the ongoing I/O
+		 * is completed, and attach this buffer to current
+		 * transaction so that the buffer can be checkpointed only
+		 * after the current transaction commits.
 		 */
 		clear_buffer_dirty(bh);
+		wait_for_writeback = 1;
 		__jbd2_journal_file_buffer(jh, transaction, BJ_Forget);
 		spin_unlock(&journal->j_list_lock);
 	}
 drop:
 	__brelse(bh);
 	spin_unlock(&jh->b_state_lock);
+	if (wait_for_writeback)
+		wait_on_buffer(bh);
 	jbd2_journal_put_journal_head(jh);
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */


