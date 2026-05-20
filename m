Return-Path: <stable+bounces-249895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHvGCx2kDWq10QUAu9opvQ
	(envelope-from <stable+bounces-249895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:07:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC258D4B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4459D31004E1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F83128B2;
	Wed, 20 May 2026 11:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr7x0ji5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2C343891
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277617; cv=none; b=WHKWZ1Flw1Gqzqjy/NYD77t6r8twthx2GpDj+5BpGCLvmzzeeU7Y657BNtiNHwMKry/rR+VkdEpZbSh+tU2VX1aIQtEb4J/Q4dN9rZ4j7LpXsHFWvTCpjW3Whq06+ICYfKMNM6HKs5RmE1O7kieQfPYcl2w76ckO9z67hBFLAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277617; c=relaxed/simple;
	bh=pQz3SvRNHx44aFYyUybS7t6iZMMC5cO/jJdBQ94GPfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9n4+C+YWhScBuFv530Nenm8Mr9iwYEBpLoYZlIUG3tcO5B5PWWN2IPOI50AuIFucKSTQ3FNJoSkQ0nXKjvaDyGIZnoyyrHznNTki3pd49XDTF4rX/OzyTlyZBAMl8SgTf3yGRzNELGoYS/xhdpSRkhymKqAPpcskV69MZC/jAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr7x0ji5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EF11F000E9;
	Wed, 20 May 2026 11:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779277615;
	bh=BJMUt0G9LjdvXAwVo7MXapqUzCwTKri2787Ese9IClY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fr7x0ji5d8PpmWyNmAGL5U+fIckCysWicNf8JhW+Z2jKHSYeMdfNp6pM572Gdm5FM
	 Itm/WfyZpHrp/AkDXMF7Bqxv9z3d3/4gqJWyrK+VHbOCZzxuuH5uoJFEYRiDckAYBj
	 VFAowGIM2ha0WBIVzVtBJOg/L0LfngORN0RoeSXtpQfRfeeJhodXxLAUC5SnwuGQBV
	 MQ35DSkBDU/rjMJmerYdZ8+CruIW2TsZ00Tt9cBP7EiKs/zstGRzXDHJiOUbuPN23h
	 jmvd1duLWLRft8ft40yzaRlfUGbOJYvohjJmSO/PSCE3txX59J1yL3MhlZmiuWa1mI
	 mJXY8BMBRfhPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] f2fs: fix incorrect file address mapping when inline inode is unwritten
Date: Wed, 20 May 2026 07:46:53 -0400
Message-ID: <20260520114653.3469848-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051215-vigorous-emboss-d417@gregkh>
References: <2026051215-vigorous-emboss-d417@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249895-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vm:email]
X-Rspamd-Queue-Id: 7EFC258D4B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

[ Upstream commit 68a0178981a0f493295afa29f8880246e561494c ]

When `fileinfo->fi_flags` does not have the `FIEMAP_FLAG_SYNC` bit set
and inline data has not been persisted yet, the physical address of the
extent is calculated incorrectly for unwritten inline inodes.

root@vm:/mnt/f2fs# dd if=/dev/zero of=data.3k bs=3k count=1
root@vm:/mnt/f2fs# f2fs_io fiemap 0 100 data.3k
Fiemap: offset = 0 len = 100
	logical addr.    physical addr.   length           flags
0	0000000000000000 00000ffffffff16c 0000000000000c00 00000301

This patch fixes the issue by checking if the inode's address is valid.
If the inline inode is unwritten, set the physical address to 0 and
mark the extent with `FIEMAP_EXTENT_UNKNOWN | FIEMAP_EXTENT_DELALLOC`
flags.

Cc: stable@kernel.org
Fixes: 67f8cf3cee6f ("f2fs: support fiemap for inline_data")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[ renamed `ifolio` to `ipage` in `inline_data_addr()` and `F2FS_INODE()` calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inline.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index df1a0cbfa1be4..8cd6383be3325 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -761,7 +761,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 int f2fs_inline_data_fiemap(struct inode *inode,
 		struct fiemap_extent_info *fieinfo, __u64 start, __u64 len)
 {
-	__u64 byteaddr, ilen;
+	__u64 byteaddr = 0, ilen;
 	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
 		FIEMAP_EXTENT_LAST;
 	struct node_info ni;
@@ -794,9 +794,14 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	if (err)
 		goto out;
 
-	byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
-	byteaddr += (char *)inline_data_addr(inode, ipage) -
-					(char *)F2FS_INODE(ipage);
+	if (__is_valid_data_blkaddr(ni.blk_addr)) {
+		byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
+		byteaddr += (char *)inline_data_addr(inode, ipage) -
+						(char *)F2FS_INODE(ipage);
+	} else {
+		f2fs_bug_on(F2FS_I_SB(inode), ni.blk_addr != NEW_ADDR);
+		flags |= FIEMAP_EXTENT_DELALLOC | FIEMAP_EXTENT_UNKNOWN;
+	}
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
-- 
2.53.0


