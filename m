Return-Path: <stable+bounces-76499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C596897A42C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D2B28DFF2
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E0156F30;
	Mon, 16 Sep 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aENSRwPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DEC15699D;
	Mon, 16 Sep 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726497113; cv=none; b=lqB4uhbmvpRz6C/Kle1WnlEQEE0fJoj2/nLx4943Bv6u1ZdlIe0tcTCPb4Ut73bmFBTLvHBJo6qbHKwyZMDhmxQooLj+yYtUVt5b5pH30u7x8u8ceVpVVTftM5AtXvh7+wxU/629rx92ORYA/K8Ca6xVNtPoJl+JaUgNhOaJbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726497113; c=relaxed/simple;
	bh=lDBtsvLQUNZTfpzlsOEd8knVS6+0a5p8O57LtksjSM4=;
	h=Date:To:From:Subject:Message-Id; b=CnDeGzS1E3YaVxt2O36ZCkwqelwtdlOhHpCffuqNhA/BV+9OI4Mf9nDogdst9EZn6VmttxeBJTCFqRU2jzojBjhBzqfM6q6q99c8EwOqZ6i1uI/eKtLwC2lz77dkJZWDWOT/F9/GqwyLxd3v+cB4f3ALvXTIDZNAYu6H2ZXvDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aENSRwPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DA3C4CEC4;
	Mon, 16 Sep 2024 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1726497113;
	bh=lDBtsvLQUNZTfpzlsOEd8knVS6+0a5p8O57LtksjSM4=;
	h=Date:To:From:Subject:From;
	b=aENSRwPek9INLSmFhRGIKWn6iAEpvk5BFe9y3QocIeaVqcOXC+9XFbu/iAWlm5qYS
	 h+z9HbGHiD95w4V/WXcKT62Tdgm/2iNi471CLHSiXCDAhhGRFctn7W1WWHsXKQOZrf
	 DbRZkeWAZuiRd0jAEeU6JtEpvAtHHEBKh8aKdAoQ=
Date: Mon, 16 Sep 2024 07:31:49 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,piaojun@huawei.com,mark@fasheh.com,junxiao.bi@oracle.com,joseph.qi@linux.alibaba.com,jlbec@evilplan.org,ghe@suse.com,gechangwei@live.cn,gautham.ananthakrishna@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + ocfs2-reserve-space-for-inline-xattr-before-attaching-reflink-tree.patch added to mm-hotfixes-unstable branch
Message-Id: <20240916143152.C0DA3C4CEC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: ocfs2: reserve space for inline xattr before attaching reflink tree
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     ocfs2-reserve-space-for-inline-xattr-before-attaching-reflink-tree.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/ocfs2-reserve-space-for-inline-xattr-before-attaching-reflink-tree.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Subject: ocfs2: reserve space for inline xattr before attaching reflink tree
Date: Thu, 12 Sep 2024 06:47:20 +0000

One of our customers reported a crash and a corrupted ocfs2 filesystem. 
The crash was due to the detection of corruption.  Upon troubleshooting,
the fsck -fn output showed the below corruption

[EXTENT_LIST_FREE] Extent list in owner 33080590 claims 230 as the next free chain record,
but fsck believes the largest valid value is 227.  Clamp the next record value? n

The stat output from the debugfs.ocfs2 showed the following corruption
where the "Next Free Rec:" had overshot the "Count:" in the root metadata
block.

        Inode: 33080590   Mode: 0640   Generation: 2619713622 (0x9c25a856)
        FS Generation: 904309833 (0x35e6ac49)
        CRC32: 00000000   ECC: 0000
        Type: Regular   Attr: 0x0   Flags: Valid
        Dynamic Features: (0x16) HasXattr InlineXattr Refcounted
        Extended Attributes Block: 0  Extended Attributes Inline Size: 256
        User: 0 (root)   Group: 0 (root)   Size: 281320357888
        Links: 1   Clusters: 141738
        ctime: 0x66911b56 0x316edcb8 -- Fri Jul 12 06:02:30.829349048 2024
        atime: 0x66911d6b 0x7f7a28d -- Fri Jul 12 06:11:23.133669517 2024
        mtime: 0x66911b56 0x12ed75d7 -- Fri Jul 12 06:02:30.317552087 2024
        dtime: 0x0 -- Wed Dec 31 17:00:00 1969
        Refcount Block: 2777346
        Last Extblk: 2886943   Orphan Slot: 0
        Sub Alloc Slot: 0   Sub Alloc Bit: 14
        Tree Depth: 1   Count: 227   Next Free Rec: 230
        ## Offset        Clusters       Block#
        0  0             2310           2776351
        1  2310          2139           2777375
        2  4449          1221           2778399
        3  5670          731            2779423
        4  6401          566            2780447
        .......          ....           .......
        .......          ....           .......

The issue was in the reflink workfow while reserving space for inline
xattr.  The problematic function is ocfs2_reflink_xattr_inline().  By the
time this function is called the reflink tree is already recreated at the
destination inode from the source inode.  At this point, this function
reserves space for inline xattrs at the destination inode without even
checking if there is space at the root metadata block.  It simply reduces
the l_count from 243 to 227 thereby making space of 256 bytes for inline
xattr whereas the inode already has extents beyond this index (in this
case upto 230), thereby causing corruption.

The fix for this is to reserve space for inline metadata at the
destination inode before the reflink tree gets recreated.  The customer
has verified the fix.

Link: https://lkml.kernel.org/r/20240912064720.898600-1-gautham.ananthakrishna@oracle.com
Fixes: ef962df057aa ("ocfs2: xattr: fix inlined xattr reflink")
Signed-off-by: Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/ocfs2/refcounttree.c |   26 ++++++++++++++++++++++++--
 fs/ocfs2/xattr.c        |   11 +----------
 2 files changed, 25 insertions(+), 12 deletions(-)

--- a/fs/ocfs2/refcounttree.c~ocfs2-reserve-space-for-inline-xattr-before-attaching-reflink-tree
+++ a/fs/ocfs2/refcounttree.c
@@ -25,6 +25,7 @@
 #include "namei.h"
 #include "ocfs2_trace.h"
 #include "file.h"
+#include "symlink.h"
 
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -4155,8 +4156,9 @@ static int __ocfs2_reflink(struct dentry
 	int ret;
 	struct inode *inode = d_inode(old_dentry);
 	struct buffer_head *new_bh = NULL;
+	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 
-	if (OCFS2_I(inode)->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
+	if (oi->ip_flags & OCFS2_INODE_SYSTEM_FILE) {
 		ret = -EINVAL;
 		mlog_errno(ret);
 		goto out;
@@ -4182,6 +4184,26 @@ static int __ocfs2_reflink(struct dentry
 		goto out_unlock;
 	}
 
+	if ((oi->ip_dyn_features & OCFS2_HAS_XATTR_FL) &&
+	    (oi->ip_dyn_features & OCFS2_INLINE_XATTR_FL)) {
+		/*
+		 * Adjust extent record count to reserve space for extended attribute.
+		 * Inline data count had been adjusted in ocfs2_duplicate_inline_data().
+		 */
+		struct ocfs2_inode_info *new_oi = OCFS2_I(new_inode);
+
+		if (!(new_oi->ip_dyn_features & OCFS2_INLINE_DATA_FL) &&
+		    !(ocfs2_inode_is_fast_symlink(new_inode))) {
+			struct ocfs2_dinode *new_di = new_bh->b_data;
+			struct ocfs2_dinode *old_di = old_bh->b_data;
+			struct ocfs2_extent_list *el = &new_di->id2.i_list;
+			int inline_size = le16_to_cpu(old_di->i_xattr_inline_size);
+
+			le16_add_cpu(&el->l_count, -(inline_size /
+					sizeof(struct ocfs2_extent_rec)));
+		}
+	}
+
 	ret = ocfs2_create_reflink_node(inode, old_bh,
 					new_inode, new_bh, preserve);
 	if (ret) {
@@ -4189,7 +4211,7 @@ static int __ocfs2_reflink(struct dentry
 		goto inode_unlock;
 	}
 
-	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_HAS_XATTR_FL) {
+	if (oi->ip_dyn_features & OCFS2_HAS_XATTR_FL) {
 		ret = ocfs2_reflink_xattrs(inode, old_bh,
 					   new_inode, new_bh,
 					   preserve);
--- a/fs/ocfs2/xattr.c~ocfs2-reserve-space-for-inline-xattr-before-attaching-reflink-tree
+++ a/fs/ocfs2/xattr.c
@@ -6520,16 +6520,7 @@ static int ocfs2_reflink_xattr_inline(st
 	}
 
 	new_oi = OCFS2_I(args->new_inode);
-	/*
-	 * Adjust extent record count to reserve space for extended attribute.
-	 * Inline data count had been adjusted in ocfs2_duplicate_inline_data().
-	 */
-	if (!(new_oi->ip_dyn_features & OCFS2_INLINE_DATA_FL) &&
-	    !(ocfs2_inode_is_fast_symlink(args->new_inode))) {
-		struct ocfs2_extent_list *el = &new_di->id2.i_list;
-		le16_add_cpu(&el->l_count, -(inline_size /
-					sizeof(struct ocfs2_extent_rec)));
-	}
+
 	spin_lock(&new_oi->ip_lock);
 	new_oi->ip_dyn_features |= OCFS2_HAS_XATTR_FL | OCFS2_INLINE_XATTR_FL;
 	new_di->i_dyn_features = cpu_to_le16(new_oi->ip_dyn_features);
_

Patches currently in -mm which might be from gautham.ananthakrishna@oracle.com are

ocfs2-reserve-space-for-inline-xattr-before-attaching-reflink-tree.patch


