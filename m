Return-Path: <stable+bounces-59704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF59932B5B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476AA1F21156
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2BA19A86F;
	Tue, 16 Jul 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E3BzzGcz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1701DDF5;
	Tue, 16 Jul 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144654; cv=none; b=cAuyb9PO5eCKk3eHB2mJ0pt5fx23ry8Y6sxh9dfuP0L0XjI5ACs7qaxMtmPT7J7s+buQJQU8uSBLruWYyXZNCT80B3vYmmNPX9RoNqKZgWSGnGRN7CfhCyZ+fGN7U7ozAQmwFq60s+09oWfOWVa/zvmuL4mKPxPEyaTOHBRsLRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144654; c=relaxed/simple;
	bh=df0MhfXjCXO7g/eE2I+DSIMVckteYcVE76shadLg2/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBAPXga3drCb7Q+587UCo7TM36gd3GoTMfIhR1OBG/GhDt0NE4Wp1Lva+vu8C1wdJ6dHQc3q6/bymVcJXKLpdRGRdNM+s58Vlb72oRdLqzN79a4C9rAxtj7dTvIoeQKCulk8l9zkYrUwQW3jajbXBS1qosSbyNVWha7sP7m2vvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E3BzzGcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE9BC116B1;
	Tue, 16 Jul 2024 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144654;
	bh=df0MhfXjCXO7g/eE2I+DSIMVckteYcVE76shadLg2/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E3BzzGczwwCk9zLH8kAevh9MaipXpe3fQXuGv9WUMLYsHZ2GuRJylsJ33UGWRbf+c
	 L6uUOH4QYAqXocIFL/QA7Uco2f5pcmB2wNf4ew4PpUz1D+QmWUhDdZBKRmDVAJMyZN
	 B1HdIgqfSvcXdKa44xVD41QDMAdyd8T3PEwDI1xY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Foster <bfoster@redhat.com>,
	Ian Kent <ikent@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Waiman Long <longman@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 061/108] vfs: dont mod negative dentry count when on shrinker list
Date: Tue, 16 Jul 2024 17:31:16 +0200
Message-ID: <20240716152748.326192571@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

From: Brian Foster <bfoster@redhat.com>

[ Upstream commit aabfe57ebaa75841db47ea59091ec3c5a06d2f52 ]

The nr_dentry_negative counter is intended to only account negative
dentries that are present on the superblock LRU. Therefore, the LRU
add, remove and isolate helpers modify the counter based on whether
the dentry is negative, but the shrinker list related helpers do not
modify the counter, and the paths that change a dentry between
positive and negative only do so if DCACHE_LRU_LIST is set.

The problem with this is that a dentry on a shrinker list still has
DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
shrink related list. Therefore if a relevant operation (i.e. unlink)
occurs while a dentry is present on a shrinker list, and the
associated codepath only checks for DCACHE_LRU_LIST, then it is
technically possible to modify the negative dentry count for a
dentry that is off the LRU. Since the shrinker list related helpers
do not modify the negative dentry count (because non-LRU dentries
should not be included in the count) when the dentry is ultimately
removed from the shrinker list, this can cause the negative dentry
count to become permanently inaccurate.

This problem can be reproduced via a heavy file create/unlink vs.
drop_caches workload. On an 80xcpu system, I start 80 tasks each
running a 1k file create/delete loop, and one task spinning on
drop_caches. After 10 minutes or so of runtime, the idle/clean cache
negative dentry count increases from somewhere in the range of 5-10
entries to several hundred (and increasingly grows beyond
nr_dentry_unused).

Tweak the logic in the paths that turn a dentry negative or positive
to filter out the case where the dentry is present on a shrink
related list. This allows the above workload to maintain an accurate
negative dentry count.

Fixes: af0c9af1b3f6 ("fs/dcache: Track & report number of negative dentries")
Signed-off-by: Brian Foster <bfoster@redhat.com>
Link: https://lore.kernel.org/r/20240703121301.247680-1-bfoster@redhat.com
Acked-by: Ian Kent <ikent@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index d2ebee3a120c4..406a71abb1b59 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -329,7 +329,11 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~(DCACHE_ENTRY_TYPE | DCACHE_FALLTHRU);
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (flags & DCACHE_LRU_LIST)
+	/*
+	 * The negative counter only tracks dentries on the LRU. Don't inc if
+	 * d_lru is on another list.
+	 */
+	if ((flags & (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_inc(nr_dentry_negative);
 }
 
@@ -1940,9 +1944,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 
 	spin_lock(&dentry->d_lock);
 	/*
-	 * Decrement negative dentry count if it was in the LRU list.
+	 * The negative counter only tracks dentries on the LRU. Don't dec if
+	 * d_lru is on another list.
 	 */
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if ((dentry->d_flags &
+	     (DCACHE_LRU_LIST|DCACHE_SHRINK_LIST)) == DCACHE_LRU_LIST)
 		this_cpu_dec(nr_dentry_negative);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	raw_write_seqcount_begin(&dentry->d_seq);
-- 
2.43.0




