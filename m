Return-Path: <stable+bounces-188281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A37BF449C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 03:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C55F835188C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 01:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A4B231C9F;
	Tue, 21 Oct 2025 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCUBEKlS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D7815D1
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761010945; cv=none; b=Q2FFYkoZEEwCKlYzFn/PrsUhMEPSAk4Bz1T/xWgkl1j6x1qzmt2Cg4OBTDHFRzzvlWKTHaRPfJ0b9Y8bcFuBHXRxyLjGrlMJph0BONzkakfzbqTRTDsinNgSQso3MRfkwFP8CFXuOHWrtaddrs1sI5crHbLmv6JaPMn330XOWI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761010945; c=relaxed/simple;
	bh=acJQVIGlGocxO7bOMGUg9aHn0yalZej7k4h23WBG4LU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COMLd8BcQp13wLqOl1K5DeFFDHZWUV7wxltO6TvmlzgvDvAtxzDK5QYYFIzEiHMIEG/g6Q506YJU6Aor1wYOi3hs+my6HwpEOqnPME28FiJOBEk0YRuabcUeYVpLRS6/BqCKaPMErC3zMR+uYOBm55ILCw3CXOBkEXMHdk0H0dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCUBEKlS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BADCC4CEFB;
	Tue, 21 Oct 2025 01:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761010945;
	bh=acJQVIGlGocxO7bOMGUg9aHn0yalZej7k4h23WBG4LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCUBEKlSRECCu9RjOoKqZWasdgCx0d6tKqVRc1nvnyHe3MRpW/FfUUnpBpWwp8poB
	 SYHyP7L8iVMdtU9q38ZrB7Eejzw16gYPlaHqQf7pMebtsBn0X9tc3tH1Ob42RsxP/x
	 GNaYLoQUTO5Q64zIcZGcFs59E+O9tSQd5+WaxwNFckyx9R2x7EsMUc8oqjngrrQpy4
	 CuJ9gevYLpMb1fyCOtU2WTJT5+aKJggW0jSvych4lBnvnHENftYkBg6iWcm/P0AVO8
	 P6MNHLqtO+Vgf0DUMijq/8hhHXRoH5SyMyt6MXkj5FbHzAgiGgPqpbiIhMklamEPsG
	 wDeNhfAejnyXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	stable@kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] jbd2: ensure that all ongoing I/O complete before freeing blocks
Date: Mon, 20 Oct 2025 21:42:22 -0400
Message-ID: <20251021014222.1974745-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102030-hurt-surplus-ab8e@gregkh>
References: <2025102030-hurt-surplus-ab8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 3c652c3a71de1d30d72dc82c3bead8deb48eb749 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/transaction.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 72e9297d6adcb..97ff68f90d573 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1550,6 +1550,7 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
 	int drop_reserve = 0;
 	int err = 0;
 	int was_modified = 0;
+	int wait_for_writeback = 0;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
@@ -1675,18 +1676,22 @@ int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
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
 
 	jbd_unlock_bh_state(bh);
 	__brelse(bh);
+	if (wait_for_writeback)
+		wait_on_buffer(bh);
 drop:
 	if (drop_reserve) {
 		/* no need to reserve log space for this block -bzzz */
-- 
2.51.0


