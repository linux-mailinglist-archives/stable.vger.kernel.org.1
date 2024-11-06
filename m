Return-Path: <stable+bounces-91350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FCA9BED95
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE81B1F2546E
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A81EBFF4;
	Wed,  6 Nov 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0X+5OCkh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327671922EF;
	Wed,  6 Nov 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898477; cv=none; b=Q3Zwlwg0gXyitcK6B+fTZUJd9LafyDaSUfS2qlEaXZYyrfgYNP8iqDXt2J+yDxaJTNPMt+S0B1VR6ybIOww5GwK3I8MYUKdvQ11N2FcTLVjGNEq5kbZcklg1XliVSQsBzkDmsJmvAw9Tck6SF8/MHKNKsn2DW/21jZ2P9dMRtsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898477; c=relaxed/simple;
	bh=9WmKZuaN885RgGF5U+qEjdRktaP+H+DfA3qYNq/WVaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLlVMSx8fPqPNCdMGE6qKGdkwpKnkTUFtBgUk7E5QPveDXgzaDz/KavZmEmlA+nuJM29KR7o7q9S9A/X84OZHQ2/GhKovnyvt+ZoCPI1PohPK3T9E7Kcfx3oTL4zMIzKLUS6tJTe2/uGduQZbexNQrwXZYe/oA1UnSHPkz3TPa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0X+5OCkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB375C4CECD;
	Wed,  6 Nov 2024 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898477;
	bh=9WmKZuaN885RgGF5U+qEjdRktaP+H+DfA3qYNq/WVaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0X+5OCkhZq9/GY39Mv1m6DoAZUKTHjKZmsO3tiJiqCXoAEZpRwWUUw4L6J7MUSnIt
	 SZx+UA+W8CkdDIqAsB2I8VEPkUebXBfS3dpma63ua8z5rvB6oMbVndLpGVi5iqx3LR
	 2rGN0u9ac4F9lT1IeoaMWCx/0T8lqe4lVvbExKWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	stable@kernel.org
Subject: [PATCH 5.4 251/462] ext4: fix incorrect tid assumption in ext4_wait_for_tail_page_commit()
Date: Wed,  6 Nov 2024 13:02:24 +0100
Message-ID: <20241106120337.723672382@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luis Henriques (SUSE) <luis.henriques@linux.dev>

commit dd589b0f1445e1ea1085b98edca6e4d5dedb98d0 upstream.

Function ext4_wait_for_tail_page_commit() assumes that '0' is not a valid
value for transaction IDs, which is incorrect.  Don't assume that and invoke
jbd2_log_wait_commit() if the journal had a committing transaction instead.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240724161119.13448-2-luis.henriques@linux.dev
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5575,8 +5575,9 @@ static void ext4_wait_for_tail_page_comm
 	struct page *page;
 	unsigned offset;
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
-	tid_t commit_tid = 0;
+	tid_t commit_tid;
 	int ret;
+	bool has_transaction;
 
 	offset = inode->i_size & (PAGE_SIZE - 1);
 	/*
@@ -5601,12 +5602,14 @@ static void ext4_wait_for_tail_page_comm
 		put_page(page);
 		if (ret != -EBUSY)
 			return;
-		commit_tid = 0;
+		has_transaction = false;
 		read_lock(&journal->j_state_lock);
-		if (journal->j_committing_transaction)
+		if (journal->j_committing_transaction) {
 			commit_tid = journal->j_committing_transaction->t_tid;
+			has_transaction = true;
+		}
 		read_unlock(&journal->j_state_lock);
-		if (commit_tid)
+		if (has_transaction)
 			jbd2_log_wait_commit(journal, commit_tid);
 	}
 }



