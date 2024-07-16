Return-Path: <stable+bounces-60199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEFF932DD6
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F7B1C2159B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 16:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E2E19AD72;
	Tue, 16 Jul 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pEBgo8aT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A21DDCE;
	Tue, 16 Jul 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721146183; cv=none; b=Xthbh/NCn6VUzWzwPkqUEnhSd2bLz+fmJkErIDReGNTbNLO+ITsK2V65qGWSjxkRQmjJACz4i3kIT3VjGoYZ2M6OrWqFtvbZplhMuWBqfOSGXnZt+lyF6doYT2xlZEKz18BH0hPaJmdnC+V1JImuS3XIWWOqVrc6cJg8esGiMBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721146183; c=relaxed/simple;
	bh=f8CJbxT+SzDO/MuTlzIHBhKnG2R3r+Ot/CdXBhjKSmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ayv4miCvK/pjXlRcHtG1IfV3MR3erIqVlBSNBvNxkr2rnX+qs0GdY4bCEOC0nRgw4gSA1/mcT/BilDrexGexGIHcqeCTV7wiL/WAF238UA0I0bHpI0IpM+iqdsdKMXM7MFpoRaNw8gIiuzt3U3K+gzxxrdb6T8NlgNgMdl3RCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pEBgo8aT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CAAC116B1;
	Tue, 16 Jul 2024 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721146182;
	bh=f8CJbxT+SzDO/MuTlzIHBhKnG2R3r+Ot/CdXBhjKSmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEBgo8aTfotDNJZ85imvK/+FgLIU8aqf6hdc91Fby2bQ5Upf0z+w10LU5598+vDVf
	 BuD4eBkM+TDju1/H/qxlfS8Wtm9XDFE0s2hutaNsqNtwLVT0bWZbZf1yB+G4qD2JW0
	 gNJ1rPgLoYveTkaUa/6zsq7RV1BNpVtEsZfAT2sM=
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
Subject: [PATCH 5.15 082/144] vfs: dont mod negative dentry count when on shrinker list
Date: Tue, 16 Jul 2024 17:32:31 +0200
Message-ID: <20240716152755.695242298@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152752.524497140@linuxfoundation.org>
References: <20240716152752.524497140@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index f2ff73fe2b619..9a29cfdaa5416 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -331,7 +331,11 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
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
 
@@ -1975,9 +1979,11 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 
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




