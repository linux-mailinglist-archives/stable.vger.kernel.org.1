Return-Path: <stable+bounces-245774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKRVFG5CA2pV2QEAu9opvQ
	(envelope-from <stable+bounces-245774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:08:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64C52351A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00B9B305C74C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630FD3A7D78;
	Tue, 12 May 2026 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VlMppLAp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268CE39AD34
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595803; cv=none; b=q/vu8TJIOeX1lIx42idHwzIXAWrceXPfGwuQbhUwX8+r3k/XaaMphv8dUwRYOuGJMziwXdyQcOJTehDwjU4xvY9047NGgfJSmDotybmQB49eHs8lnQiCOge4GPR3PTJMeK6D5kejWcVWii8YEAP5hAHwBxm8kajGyjU7czB0AEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595803; c=relaxed/simple;
	bh=IF7Pdvp5/4FdajWnooQ63iKqBsDW0ujbwPUsTKTPpDo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Moryx2gUpy+hPLdp0qV1RCUrzNKATErXSfMFZD4CfToyq+OXGQouUuudzU9/ohghooiFfNNj+Zqf6YRMOotfUFA5B0bWSrFF3UUjw4pxYrc8SW45gxbs+I4xTxL4MZ9zPgcfHNwaSc3DA5CQn8Lqvc7yDOc0tc+gVFkuzod61kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VlMppLAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6143C2BCF5;
	Tue, 12 May 2026 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595803;
	bh=IF7Pdvp5/4FdajWnooQ63iKqBsDW0ujbwPUsTKTPpDo=;
	h=Subject:To:Cc:From:Date:From;
	b=VlMppLApeVJMBrD3wTCgEdE1qBW+J+Y3G9Y7XrG5eOE8EGCXq3oOmSZWz+lctTrF2
	 Mt831WTWDxdE2gJDVzZ73e/7qTzKlU3B8hpLww+2cP/RQOAN/utAaVvkFYJ0WicaBF
	 haPYrQS64CJxaq4Hai/MoIAyu//OGmNxgDBmdtro=
Subject: FAILED: patch "[PATCH] f2fs: fix incorrect file address mapping when inline inode is" failed to apply to 5.15-stable tree
To: yangyongpeng@xiaomi.com,chao@kernel.org,jaegeuk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:23:15 +0200
Message-ID: <2026051215-chive-imperial-8666@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F64C52351A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245774-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xiaomi.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,vm:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 68a0178981a0f493295afa29f8880246e561494c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051215-chive-imperial-8666@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68a0178981a0f493295afa29f8880246e561494c Mon Sep 17 00:00:00 2001
From: Yongpeng Yang <yangyongpeng@xiaomi.com>
Date: Tue, 3 Feb 2026 21:36:35 +0800
Subject: [PATCH] f2fs: fix incorrect file address mapping when inline inode is
 unwritten

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

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0a1052d5ee62..86d2abbb40ff 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -792,7 +792,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 int f2fs_inline_data_fiemap(struct inode *inode,
 		struct fiemap_extent_info *fieinfo, __u64 start, __u64 len)
 {
-	__u64 byteaddr, ilen;
+	__u64 byteaddr = 0, ilen;
 	__u32 flags = FIEMAP_EXTENT_DATA_INLINE | FIEMAP_EXTENT_NOT_ALIGNED |
 		FIEMAP_EXTENT_LAST;
 	struct node_info ni;
@@ -825,9 +825,14 @@ int f2fs_inline_data_fiemap(struct inode *inode,
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


