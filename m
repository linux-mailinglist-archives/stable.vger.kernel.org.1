Return-Path: <stable+bounces-180845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F1B8E967
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 01:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979333BC007
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7A118A6A7;
	Sun, 21 Sep 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoHAAFdf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9C72625
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758496553; cv=none; b=pPZwIPZsHl15fWwDX8lgZRFATKo6XU49MeptfdNjVN+1gzFZV1Su6zKAUkttdG1Gq42Yz0V7gnS4G12D8puvHGHSQ1Pvig2sRkoTrr1Iasn553a8R29uc2/9dUld0/OIkVhETkcn3zMkK13Fcsz5qKGezMxWit1NYwFsU6TWUwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758496553; c=relaxed/simple;
	bh=2P9Exa62P25gPl2T1wwFnbIb1EbG3HNpRjCG3rQLQWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LzQMGwB4QCpwbz5RRk8Z5mUgKvjnKQrQ7MvAuWX81hP2yEu8UpXVPusxIPkDkqQQ2OjLNGiRTJYpEDk0k+htFVpNUgbGhRiQfBKVnI1Kt3Z1ABrd1vge9gFtmdBP8igkYUKrXNK/+Cq6wXfvQW/TtB7v31ZK1jr8vbVV+iD9psw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoHAAFdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7043C4CEE7;
	Sun, 21 Sep 2025 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758496553;
	bh=2P9Exa62P25gPl2T1wwFnbIb1EbG3HNpRjCG3rQLQWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoHAAFdf5w6DZgh60cnNKMoSkqVoyWe8YG+8qy8QpW9rFJM1dfwdVyKcdemcv45xK
	 LuLwd4y+1cFAYntYRbR8PDu1iboiO2TkCb/XAaMfnFO31WBwOZQDGqHgGqRHLik1+c
	 Rn45RGM5T/F5OzJizAhWfLDHKzOPBQziH4zoPtF+P/bD/x9mc9QYEUEjHR/18qZvt0
	 RhojE3vdEIElLm/jqnP0CqA6+vZCZA5qIi5GiW0YcZ1Po1GEqk4EiFTU0up6Oj2d9y
	 BplV12l1n/ZtSMNylKUsggwwGBsh4u+VBwnmd79SZ9t+sD/r2mm7l09EP3PClHPkM5
	 1GoeQiwz0vvYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] btrfs: tree-checker: fix the incorrect inode ref size check
Date: Sun, 21 Sep 2025 19:15:50 -0400
Message-ID: <20250921231550.3032338-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092135-stinky-correct-5051@gregkh>
References: <2025092135-stinky-correct-5051@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 96fa515e70f3e4b98685ef8cac9d737fc62f10e1 ]

[BUG]
Inside check_inode_ref(), we need to make sure every structure,
including the btrfs_inode_extref header, is covered by the item.  But
our code is incorrectly using "sizeof(iref)", where @iref is just a
pointer.

This means "sizeof(iref)" will always be "sizeof(void *)", which is much
smaller than "sizeof(struct btrfs_inode_extref)".

This will allow some bad inode extrefs to sneak in, defeating tree-checker.

[FIX]
Fix the typo by calling "sizeof(*iref)", which is the same as
"sizeof(struct btrfs_inode_extref)", and will be the correct behavior we
want.

Fixes: 71bf92a9b877 ("btrfs: tree-checker: Add check for INODE_REF")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Added unlikely() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/tree-checker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 35b94fe5e78e7..c28bb37688c61 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1545,10 +1545,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	while (ptr < end) {
 		u16 namelen;
 
-		if (ptr + sizeof(iref) > end) {
+		if (unlikely(ptr + sizeof(*iref) > end)) {
 			inode_ref_err(leaf, slot,
 			"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
-				ptr, end, sizeof(iref));
+				ptr, end, sizeof(*iref));
 			return -EUCLEAN;
 		}
 
-- 
2.51.0


