Return-Path: <stable+bounces-25230-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1926A869853
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9217B1F22CDF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7985146E9B;
	Tue, 27 Feb 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JilWpBsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9620C145FF5;
	Tue, 27 Feb 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044222; cv=none; b=KQtXjBniCyCSxujU+QsagWnYItzCN6+Bdow5ZmjyrsM5/8Al4JCYk3CAo8mjjpoqlXsYym4yoUfNOWx/Nj77uw70RYzveajp95lMYyncSmOkcV9BZnYRZx7V13Y6/DxB59RNyhSDcKxRMSssY2ciCQ8GbLzLkLDkapN6soRay+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044222; c=relaxed/simple;
	bh=IstF2YbezF7Fibhaoq+dcThHABSOt5BAc8dvpkYcgnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edtnidrfjPTv5JNRXn2BERIhpSQqZJbAik4Fa6Q9VgC9jxhkEGKFfe/hckGKrAGycdE2lgbp0ZAJntbNXyo730n43hw0I7PI26nQK39OJ5ZxVD6TpBLHxkyTTALdazBTe/qKMQHBnAHEPNAjXGEkd6JLDFv8JY+TrWq97YPX1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JilWpBsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA5C433F1;
	Tue, 27 Feb 2024 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709044222;
	bh=IstF2YbezF7Fibhaoq+dcThHABSOt5BAc8dvpkYcgnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JilWpBsKGqz0MNGWxEUTl70Ttco6BZYUDPElIPInOmrPdeeq0DxvL85awJUTMWAnp
	 0cJeVJT+q6i+qitLJw1zo7K+qMWWgEvbudG1oP5l00VdtZn8DVLkkUYzqIyV3jYJtP
	 zITlHAsSnkdD0gwbJ+lmTqCYE0RE/A+g7ltdmX6A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 069/122] jbd2: remove redundant buffer io error checks
Date: Tue, 27 Feb 2024 14:27:10 +0100
Message-ID: <20240227131600.961244216@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>
References: <20240227131558.694096204@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 214eb5a4d8a2032fb9f0711d1b202eb88ee02920 ]

Now that __jbd2_journal_remove_checkpoint() can detect buffer io error
and mark journal checkpoint error, then we abort the journal later
before updating log tail to ensure the filesystem works consistently.
So we could remove other redundant buffer io error checkes.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20210610112440.3438139-5-yi.zhang@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: e34c8dd238d0 ("jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 472932b9e6bca..ea08adcea84c3 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -91,8 +91,7 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
 	int ret = 0;
 	struct buffer_head *bh = jh2bh(jh);
 
-	if (jh->b_transaction == NULL && !buffer_locked(bh) &&
-	    !buffer_dirty(bh) && !buffer_write_io_error(bh)) {
+	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
 		JBUFFER_TRACE(jh, "remove from checkpoint list");
 		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
 	}
@@ -228,7 +227,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	 * OK, we need to start writing disk blocks.  Take one transaction
 	 * and write it.
 	 */
-	result = 0;
 	spin_lock(&journal->j_list_lock);
 	if (!journal->j_checkpoint_transactions)
 		goto out;
@@ -295,8 +293,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			goto restart;
 		}
 		if (!buffer_dirty(bh)) {
-			if (unlikely(buffer_write_io_error(bh)) && !result)
-				result = -EIO;
 			BUFFER_TRACE(bh, "remove from checkpoint");
 			if (__jbd2_journal_remove_checkpoint(jh))
 				/* The transaction was released; we're done */
@@ -356,8 +352,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 			spin_lock(&journal->j_list_lock);
 			goto restart2;
 		}
-		if (unlikely(buffer_write_io_error(bh)) && !result)
-			result = -EIO;
 
 		/*
 		 * Now in whatever state the buffer currently is, we
@@ -369,10 +363,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 	}
 out:
 	spin_unlock(&journal->j_list_lock);
-	if (result < 0)
-		jbd2_journal_abort(journal, result);
-	else
-		result = jbd2_cleanup_journal_tail(journal);
+	result = jbd2_cleanup_journal_tail(journal);
 
 	return (result < 0) ? result : 0;
 }
-- 
2.43.0




