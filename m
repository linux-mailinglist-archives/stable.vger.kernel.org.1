Return-Path: <stable+bounces-194675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D976AC56BD6
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 11:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EA3ACF2C
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8881C2DF6E9;
	Thu, 13 Nov 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="v9XKwzWy"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069A2DF154
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027940; cv=none; b=PpS4Nmz3m20WX3A/evOGDafGH52x+5xHFtocvjBqxeCK79g6KXLNcNoRhezEMZvCAjF4OZv7O/G2m/CMfFBFceos39dyopBoWvt7bzSPOESwToVyNu4z2zglfohNNIHm2CLTfIlis4cSq2v56OlL5JALaGvsnxMVyqfcw9sFOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027940; c=relaxed/simple;
	bh=j3zNURYAKH0pT2IA6JJkVM2VF8F9CMavm6vqAKenlAI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=N3RCxiKSs0S+Kb1QTs1CFUB0A/XyJiMcGUxRgHp68iORAMguhujfhM8ChDjzXo/OjH2kmAMbqVwD1VRsxXqUKVQKfkq4tgLX0KIIeLl65f6Esr/kfbaSy7zvWUytAbUqOJrmVgtcPEKv6+ld/zIZX0viDJdslx3grB5ee173OuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=v9XKwzWy; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=v9XKwzWyrBSQlA8Z22zsUpFy7dM5oJ8fOAdYPBy8kdZsMmTnWf3zJBHwL0wMTXKiKZmyk8c9R3Wbu
	 U0oXTgyvJmKItToDAE3RZytP5B1WUGExloQQI61f1u9hxztTDXHJu/mpBJy7SWeXok+hQygahlSKcY
	 cVCDtWCkQg9HwrDo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[117.129.7.61])
	by rmsmtp-lg-appmail-39-12053 (RichMail) with SMTP id 2f156915ab1e329-3054e;
	Thu, 13 Nov 2025 17:55:45 +0800 (CST)
X-RM-TRANSID:2f156915ab1e329-3054e
From: Rajani Kantha <681739313@139.com>
To: yebin10@huawei.com,
	jack@suse.cz,
	tytso@mit.edu,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 2/2] ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
Date: Thu, 13 Nov 2025 17:55:37 +0800
Message-Id: <20251113095537.1831-3-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251113095537.1831-1-681739313@139.com>
References: <20251113095537.1831-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 5701875f9609b000d91351eaa6bfd97fe2f157f4 ]

There's issue as follows:
BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172

CPU: 3 PID: 15172 Comm: syz-executor.0
Call Trace:
 __dump_stack lib/dump_stack.c:82 [inline]
 dump_stack+0xbe/0xfd lib/dump_stack.c:123
 print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
 __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
 kasan_report+0x3a/0x50 mm/kasan/report.c:585
 ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
 ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
 ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
 evict+0x39f/0x880 fs/inode.c:622
 iput_final fs/inode.c:1746 [inline]
 iput fs/inode.c:1772 [inline]
 iput+0x525/0x6c0 fs/inode.c:1758
 ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
 ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
 mount_bdev+0x355/0x410 fs/super.c:1446
 legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
 do_new_mount fs/namespace.c:2983 [inline]
 path_mount+0x119a/0x1ad0 fs/namespace.c:3316
 do_mount+0xfc/0x110 fs/namespace.c:3329
 __do_sys_mount fs/namespace.c:3540 [inline]
 __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Memory state around the buggy address:
 ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Above issue happens as ext4_xattr_delete_inode() isn't check xattr
is valid if xattr is in inode.
To solve above issue call xattr_check_inode() check if xattr if valid
in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
so that there is no divergent verification.

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250208063141.1539283-3-yebin@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 fs/ext4/inode.c |  5 +++++
 fs/ext4/xattr.c | 26 +-------------------------
 fs/ext4/xattr.h |  7 +++++++
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4ad34eba00a7..ae513b14fd08 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4688,6 +4688,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
 	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
 		int err;
 
+		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
+					ITAIL(inode, raw_inode));
+		if (err)
+			return err;
+
 		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
 		err = ext4_find_inline_data_nolock(inode);
 		if (!err && ext4_has_inline_data(inode))
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index cfc2229370b6..7a0469ba1464 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -312,7 +312,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
 	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
 
 
-static inline int
+int
 __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			 void *end, const char *function, unsigned int line)
 {
@@ -320,9 +320,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
 			    function, line);
 }
 
-#define xattr_check_inode(inode, header, end) \
-	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
-
 static int
 xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
 		 void *end, int name_index, const char *name, int sorted)
@@ -654,9 +651,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
 	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	entry = IFIRST(header);
 	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
 	if (error)
@@ -787,7 +781,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_inode *raw_inode;
 	struct ext4_iloc iloc;
-	void *end;
 	int error;
 
 	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
@@ -797,14 +790,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
 		return error;
 	raw_inode = ext4_raw_inode(&iloc);
 	header = IHDR(inode, raw_inode);
-	end = ITAIL(inode, raw_inode);
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
 	error = ext4_xattr_list_entries(dentry, IFIRST(header),
 					buffer, buffer_size);
 
-cleanup:
 	brelse(iloc.bh);
 	return error;
 }
@@ -872,7 +860,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 	struct ext4_xattr_ibody_header *header;
 	struct ext4_xattr_entry *entry;
 	qsize_t ea_inode_refs = 0;
-	void *end;
 	int ret;
 
 	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
@@ -883,10 +870,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
 			goto out;
 		raw_inode = ext4_raw_inode(&iloc);
 		header = IHDR(inode, raw_inode);
-		end = ITAIL(inode, raw_inode);
-		ret = xattr_check_inode(inode, header, end);
-		if (ret)
-			goto out;
 
 		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
 		     entry = EXT4_XATTR_NEXT(entry))
@@ -2251,9 +2234,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 	is->s.here = is->s.first;
 	is->s.end = ITAIL(inode, raw_inode);
 	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
-		error = xattr_check_inode(inode, header, is->s.end);
-		if (error)
-			return error;
 		/* Find the named attribute. */
 		error = xattr_find_entry(inode, &is->s.here, is->s.end,
 					 i->name_index, i->name, 0);
@@ -2804,10 +2784,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 	min_offs = end - base;
 	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
 
-	error = xattr_check_inode(inode, header, end);
-	if (error)
-		goto cleanup;
-
 	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
 	if (ifree >= isize_diff)
 		goto shift;
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 5197f17ffd9a..1fedf44d4fb6 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -209,6 +209,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
 extern struct mb_cache *ext4_xattr_create_cache(void);
 extern void ext4_xattr_destroy_cache(struct mb_cache *);
 
+extern int
+__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
+		    void *end, const char *function, unsigned int line);
+
+#define xattr_check_inode(inode, header, end) \
+	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
+
 #ifdef CONFIG_EXT4_FS_SECURITY
 extern int ext4_init_security(handle_t *handle, struct inode *inode,
 			      struct inode *dir, const struct qstr *qstr);
-- 
2.17.1



