Return-Path: <stable+bounces-246278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNEPK1RtA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:11:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3A7526FD2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E835F310FEA3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B7334405B;
	Tue, 12 May 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bCaE2tP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1D34572B;
	Tue, 12 May 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608815; cv=none; b=rH3DyhCAslDBg46B/pwYtZYCtb85CzZ0utZ3v2G1MDfnwaZ2JntrhpDAT1P5JckH569YhEI5eUrmjReAupq+mcLa7wqfePYFp9YrYhBuYKfgsu09R8g0ON9yO3Q4I1Me8KbISeUHMCcEc6LgYPyWMwPtvZ7XFoJS1LlBMc+aTsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608815; c=relaxed/simple;
	bh=1uFWT+pRLIYI6sWpanDGU4B6aTrSFZTSfSZhZYicD/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbNGxf89y4Hyg+LHNXMlz6BJrWqaHtLkDlTvwUBxkMeBI3OrieT0QRSxUIwiIAde69reeANiJ2nD6hXVdctky46ZhhB8KHSh2vUHUZkP6NvMeGJpWNmOxc7X30djzfyscftrfHrABSAxrtB8zYMIIWvSnAEG8UIneDmOjl5dFNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bCaE2tP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929E6C2BCB0;
	Tue, 12 May 2026 18:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608814;
	bh=1uFWT+pRLIYI6sWpanDGU4B6aTrSFZTSfSZhZYicD/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCaE2tP163uFaL+SJJqFRfgOu+X/QbYMHVe6Ggd/ILm9aPcCC7lsMk6SN59V6JdND
	 utlM5HBqoPEZjXmv5cyMyBNVVtfApWB7C5IBAXW0GdkC49TTcz+nmlzredvdTmbYEr
	 LRBlte1/hkVB9wLHn51nzSyjtfROp780GUSMsT+g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.18 226/270] f2fs: fix incorrect file address mapping when inline inode is unwritten
Date: Tue, 12 May 2026 19:40:27 +0200
Message-ID: <20260512173943.204563803@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3E3A7526FD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246278-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xiaomi.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,vm:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

commit 68a0178981a0f493295afa29f8880246e561494c upstream.

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
-	byteaddr += (char *)inline_data_addr(inode, ifolio) -
-					(char *)F2FS_INODE(ifolio);
+	if (__is_valid_data_blkaddr(ni.blk_addr)) {
+		byteaddr = (__u64)ni.blk_addr << inode->i_sb->s_blocksize_bits;
+		byteaddr += (char *)inline_data_addr(inode, ifolio) -
+						(char *)F2FS_INODE(ifolio);
+	} else {
+		f2fs_bug_on(F2FS_I_SB(inode), ni.blk_addr != NEW_ADDR);
+		flags |= FIEMAP_EXTENT_DELALLOC | FIEMAP_EXTENT_UNKNOWN;
+	}
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
 	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:



