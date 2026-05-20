Return-Path: <stable+bounces-252847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNFwGf8pDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-252847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:39:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB4759B28A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFE53288273
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672343EF0D7;
	Wed, 20 May 2026 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuvIfZ7N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F33D1CC6;
	Wed, 20 May 2026 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301746; cv=none; b=iEeNTlH8Sj1z53AAYG5PrukM5W3qsVyMnQl516isR0nKTnQ77GXay8LJ2Zyjtt+ujBgTEUPiXLWrcRFJvDOr4UHA88LEiiSzG5FQaVdltI6xNu0RIpL6iJH5AC7LFU9qCJspjYFkSv4nOXxwd5PlmmGi0rQD04DuqpFRmZcX2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301746; c=relaxed/simple;
	bh=aumo05n1nj9s+Hl/oPX7HfGLNOGRnElspchcyskp8Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inm1C9IRoT+0+rsCxFrkEeBjaZTBTWqL8bDUfoRJivQQV40dioMgfzNj7fPGOcb3sys341mP/Tr7pIzcW3FQE2bD4LQGZ5yxg7Y1rREmdBgbeXRIMai6J8EP9qtl1nu+qgsb9z6jfZIXeRRWbTe6FXOre4j27r+gZAQh1NnRsus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuvIfZ7N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DB41F00893;
	Wed, 20 May 2026 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301744;
	bh=OskyDKhikISSgIBLMQwzz51+OGBoIP8C/ke2lKzP+ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vuvIfZ7NUcFY6IXp6qyCYXXPXF5iBT9IzCO13MBHR/Ob6ai21POTgxeNcTz8nd5Ip
	 7s+FIO2miH6LdaiCNIbtcDs+UMf+QNxWe227XVP3+RpEuWb4tVEZ+K97idFv2c6hx+
	 BWcBv5LG4aP46bEVAqv8BsyQ9/J9/5bjvfIWGqmQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 660/666] f2fs: fix incorrect file address mapping when inline inode is unwritten
Date: Wed, 20 May 2026 18:24:31 +0200
Message-ID: <20260520162125.594705847@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252847-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BCB4759B28A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/inline.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -790,7 +790,7 @@ int f2fs_read_inline_dir(struct file *fi
 int f2fs_inline_data_fiemap(struct inode *inode,
 		struct fiemap_extent_info *fieinfo, __u64 start, __u64 len)
 {
-	__u64 byteaddr, ilen;
+	__u64 byteaddr = 0, ilen;
 	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
 		FIEMAP_EXTENT_LAST;
 	struct node_info ni;
@@ -823,9 +823,14 @@ int f2fs_inline_data_fiemap(struct inode
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



