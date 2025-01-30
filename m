Return-Path: <stable+bounces-111396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352C9A22EF5
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F061888C1F
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E411E7C25;
	Thu, 30 Jan 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XqgcHtmp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58EC383;
	Thu, 30 Jan 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246615; cv=none; b=fWH/ypG6I5wXT57kOKvtbV/dnms/Hc4bdU4ZgIhPHw4waiAH6KYZrfI+WOWZBh3msZBVWU/kOCqzJcMLMxcofTnwVHJS2tsecV2l2K6rMRFhgfqYrnLkB/tj0mo0yeImNwhGsLvsckQrFK3INCLqJS2BTcEK+V3ihVHOf8XZhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246615; c=relaxed/simple;
	bh=wKjOASAGi2hVUYoAy8Be70JZmjgVFJ6H5kwgi+ySfDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7AuXMJ/rOev3MX+v3bXIKl4Vya0xBmK45vaYz7S4Hb24sSh0qLfCKumhty5bCWu2WnLeq9VlUT2zZevWogUMPtAWdfs9/lMWOZk385PFO9zAQII/MdEEOEUjvIvskOvHW6QhFWBx/7OnhrJP8GnS1y301mwq5S5TqfBjpzUsbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XqgcHtmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE97C4CED2;
	Thu, 30 Jan 2025 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246615;
	bh=wKjOASAGi2hVUYoAy8Be70JZmjgVFJ6H5kwgi+ySfDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XqgcHtmpdvcMqjTYFyKBdWTn/vXFkvStWcYdGI/J2h4lddSZcpQZR2KripTPY6UE/
	 0pATO1U1b8rb+h9KCKm4YDWMC41u0vPnF7ZZxkmQ2S9b/YREjYxL8Ye3wS6IflOSgn
	 /A2SuT8db+aaUWorci9ea/KAfWlKXdo77vj6pjJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 01/91] jbd2: flush filesystem device before updating tail sequence
Date: Thu, 30 Jan 2025 15:00:20 +0100
Message-ID: <20250130140133.723945042@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140133.662535583@linuxfoundation.org>
References: <20250130140133.662535583@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit a0851ea9cd555c333795b85ddd908898b937c4e1 ]

When committing transaction in jbd2_journal_commit_transaction(), the
disk caches for the filesystem device should be flushed before updating
the journal tail sequence. However, this step is missed if the journal
is not located on the filesystem device. As a result, the filesystem may
become inconsistent following a power failure or system crash. Fix it by
ensuring that the filesystem device is flushed appropriately.

Fixes: 3339578f0578 ("jbd2: cleanup journal tail after transaction commit")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://lore.kernel.org/r/20241203014407.805916-3-yi.zhang@huaweicloud.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 255026497b8c..8c435c11664d 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -770,9 +770,9 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	/* 
 	 * If the journal is not located on the file system device,
 	 * then we must flush the file system device before we issue
-	 * the commit record
+	 * the commit record and update the journal tail sequence.
 	 */
-	if (commit_transaction->t_need_data_flush &&
+	if ((commit_transaction->t_need_data_flush || update_tail) &&
 	    (journal->j_fs_dev != journal->j_dev) &&
 	    (journal->j_flags & JBD2_BARRIER))
 		blkdev_issue_flush(journal->j_fs_dev, GFP_NOFS, NULL);
-- 
2.39.5




