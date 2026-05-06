Return-Path: <stable+bounces-244332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDlZFfbw+mmKUgMAu9opvQ
	(envelope-from <stable+bounces-244332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010D4D759A
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 09:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC021301DE59
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 07:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604F3CF02C;
	Wed,  6 May 2026 07:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="fwBbkKlG"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256CA3CD8B0;
	Wed,  6 May 2026 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053362; cv=none; b=dM1u1c9dErxYUoElOW4GeT86El6tcXaBFk8Tmk7ms/oRC6mh/WvRLb9VU5YzbLqEP/vRxjIlyHU/0SrVIF/heOClrP3cyRrJculY2v3T1MB5dHNeNdnfcuf5iX3+T+qSPwlvosx9GYPzTXL26XMR97vX5tKPVbx3Mqv/ybl5w7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053362; c=relaxed/simple;
	bh=11b2/E0gGbHX23KwzLPWPFB3sibNjo20Sx2wEo1NKfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibsQUn7iCB4uRenFKndhJ0jENHPFaC5OOnXvIaCTP91IA6T9VkK3+5UwweB+9mruMEOcnDnwEY11TcOiScijc5pE2YRR8QrtUW62BN1+Jo9Znh3wyFVzFJ+5v8XyCOYYKOcCj1My2XobymdLQbx/1FJ7IFpRhcehOjYH6c5B7pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=fwBbkKlG; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=fwBbkKlGSq9DDyjmGsC9g3310opdF4YFkLw3fLZvAEFyMT8w5DHBnE4d1XJGCMRQF3xs8dY4ohOfF
	 FRNl13gh5Ves4/l+9cA0XJTDerxg9RaSKRVIEgqOLBASG3Y+Qho4yTe7mbkUA+4/vmA/kgZiVpGuW9
	 Aw4ezTl+T+Y+wKm0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-139-kernel-team (unknown[47.95.114.252])
	by rmsmtp-lg-appmail-05-12083 (RichMail) with SMTP id 2f3369faf0287eb-0686a;
	Wed, 06 May 2026 15:39:24 +0800 (CST)
X-RM-TRANSID:2f3369faf0287eb-0686a
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com,
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	stable@kernel.org,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 5.15.y] ext4: avoid infinite loops caused by residual data
Date: Wed,  6 May 2026 15:38:35 +0800
Message-ID: <20260506073835.32481-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0010D4D759A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244332-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com,syzkaller.appspotmail.com,suse.cz,mit.edu,kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,512459401510e2a9a39f,1659aaaaa8d9d11265d7];
	NEURAL_SPAM(0.00)[0.193];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qq.com:email,139.com:mid,139.com:email,suse.cz:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 5422fe71d26d42af6c454ca9527faaad4e677d6c ]

On the mkdir/mknod path, when mapping logical blocks to physical blocks,
if inserting a new extent into the extent tree fails (in this example,
because the file system disabled the huge file feature when marking the
inode as dirty), ext4_ext_map_blocks() only calls ext4_free_blocks() to
reclaim the physical block without deleting the corresponding data in
the extent tree. This causes subsequent mkdir operations to reference
the previously reclaimed physical block number again, even though this
physical block is already being used by the xattr block. Therefore, a
situation arises where both the directory and xattr are using the same
buffer head block in memory simultaneously.

The above causes ext4_xattr_block_set() to enter an infinite loop about
"inserted" and cannot release the inode lock, ultimately leading to the
143s blocking problem mentioned in [1].

If the metadata is corrupted, then trying to remove some extent space
can do even more harm. Also in case EXT4_GET_BLOCKS_DELALLOC_RESERVE
was passed, remove space wrongly update quota information.
Jan Kara suggests distinguishing between two cases:

1) The error is ENOSPC or EDQUOT - in this case the filesystem is fully
consistent and we must maintain its consistency including all the
accounting. However these errors can happen only early before we've
inserted the extent into the extent tree. So current code works correctly
for this case.

2) Some other error - this means metadata is corrupted. We should strive to
do as few modifications as possible to limit damage. So I'd just skip
freeing of allocated blocks.

[1]
INFO: task syz.0.17:5995 blocked for more than 143 seconds.
Call Trace:
 inode_lock_nested include/linux/fs.h:1073 [inline]
 __start_dirop fs/namei.c:2923 [inline]
 start_dirop fs/namei.c:2934 [inline]

Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1659aaaaa8d9d11265d7
Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Reported-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Link: https://patch.msgid.link/tencent_43696283A68450B761D76866C6F360E36705@qq.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
[ Minor context conflict resolved. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 fs/ext4/extents.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 80b7783c65b4..b2ab5d849672 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4377,9 +4377,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 
 	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
 	if (err) {
-		if (allocated_clusters) {
+		/*
+		 * Gracefully handle out of space conditions. If the filesystem
+		 * is inconsistent, we'll just leak allocated blocks to avoid
+		 * causing even more damage.
+		 */
+		if (allocated_clusters && (err == -EDQUOT || err == -ENOSPC)) {
 			int fb_flags = 0;
-
 			/*
 			 * free data blocks we just allocated.
 			 * not a good idea to call discard here directly,
-- 
2.43.0



