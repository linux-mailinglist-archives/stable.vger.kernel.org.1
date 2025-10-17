Return-Path: <stable+bounces-187627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4C8BEACF3
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0644960FCA
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5E330B35;
	Fri, 17 Oct 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TTb598jF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672E330B2B;
	Fri, 17 Oct 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716618; cv=none; b=NPpdIsoUsvClrLhjh013wrVoSz5bHVnLgShtydgCmyNAQp1pa13SU+/L3ge1du8R0vQiVOap6py3+bLTpaMNp/xUtOkJSGGA7xwH2tQVdUfX0uMTH2Y6v5eJj++o6JVWpSYrvTDKG48ndnHYSTzR0+eM7h/DZc9bm8se3xAfGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716618; c=relaxed/simple;
	bh=xTZVvGMi4Rks5HTYdVCTEvt4C3FoevR8I1gnCyrUpQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGt2i58dpjwle6D5ZnyJjPr/amxvROQKWGGHu6yI/EM8PldNXPGkW9ZUqu86yBnEqN1gE1ObmQu49vJdLlMri1k6V9PpbQ/MvVCeKj0A7WFoPRm1p/lV0B4BDpgiNWpzlb8O26V9c0BocluG09wIRJgn04gY9DBYzJZE8wpVNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TTb598jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882D5C4CEE7;
	Fri, 17 Oct 2025 15:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760716617;
	bh=xTZVvGMi4Rks5HTYdVCTEvt4C3FoevR8I1gnCyrUpQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTb598jFc1W6y/DyzdXW6rHYQ+XV6sKUvOX+7SHXu83a8cX0w1NCbAxmj8nPyvnO8
	 DkWVFp+h9rarV5fQircPgt9iu2ChsqT3VYoi6WwEseUnKKhkPkMWVKMrmeS+zHtlXb
	 tiXLpfqETmfDZ2wxStuj47QG+LuFynf30vr8t2SA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com,
	stable@kernel.org,
	Jan Kara <jack@suse.cz>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.15 219/276] ext4: verify orphan file size is not too big
Date: Fri, 17 Oct 2025 16:55:12 +0200
Message-ID: <20251017145150.458385666@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Jan Kara <jack@suse.cz>

commit 0a6ce20c156442a4ce2a404747bb0fb05d54eeb3 upstream.

In principle orphan file can be arbitrarily large. However orphan replay
needs to traverse it all and we also pin all its buffers in memory. Thus
filesystems with absurdly large orphan files can lead to big amounts of
memory consumed. Limit orphan file size to a sane value and also use
kvmalloc() for allocating array of block descriptor structures to avoid
large order allocations for sane but large orphan files.

Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
Cc: stable@kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Message-ID: <20250909112206.10459-2-jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/orphan.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -584,9 +584,20 @@ int ext4_init_orphan_info(struct super_b
 		ext4_msg(sb, KERN_ERR, "get orphan inode failed");
 		return PTR_ERR(inode);
 	}
+	/*
+	 * This is just an artificial limit to prevent corrupted fs from
+	 * consuming absurd amounts of memory when pinning blocks of orphan
+	 * file in memory.
+	 */
+	if (inode->i_size > 8 << 20) {
+		ext4_msg(sb, KERN_ERR, "orphan file too big: %llu",
+			 (unsigned long long)inode->i_size);
+		ret = -EFSCORRUPTED;
+		goto out_put;
+	}
 	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
 	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
-	oi->of_binfo = kmalloc_array(oi->of_blocks,
+	oi->of_binfo = kvmalloc_array(oi->of_blocks,
 				     sizeof(struct ext4_orphan_block),
 				     GFP_KERNEL);
 	if (!oi->of_binfo) {



