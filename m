Return-Path: <stable+bounces-228797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGBuNVRXwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40A2F5D36
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51AF73213633
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FB23B612;
	Mon, 23 Mar 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="py7FehYS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DD23EAB2;
	Mon, 23 Mar 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277154; cv=none; b=oXfBnXYEET2pz/FHlWOfqnOH8SzYh7szFX0EhEp0eFth1WdKMnVqCivSaUiOlZhuQ2/JtJfqxF9pG07Tp7ow3RwnpLW0N2nFLw8dhqWNxq5/WjO86AtK59vBVtvPm6chOj17cCw4wWJ1fSbTWoFrFhaaeX+YmsJYsvNq97Msk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277154; c=relaxed/simple;
	bh=+ATbq+qCFPP4NibcyHkuqUbWD8ijHN4mFi3OMfEoKyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkKHsP/LnUTTm4n+0anzIBcRgU659o9+LNaOw3q804rrHPD8jzVj4/mOyOfNZCWRvk6fZ00trkgZx5qrsyhVdCpTbjnQCzDqkMwL+VxaY3awecKS7S2HXANfqG7D+yJGErWK2/Ky+K+eFEGLQRN12g31UFUFf/QslLIHFYdl+pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=py7FehYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BF0C2BC9E;
	Mon, 23 Mar 2026 14:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277153;
	bh=+ATbq+qCFPP4NibcyHkuqUbWD8ijHN4mFi3OMfEoKyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=py7FehYSSrXGy12KTT6M7htK/DK7rA+DKUR62qd2LEjM/jNW3400HZMSRKJBmoJYU
	 wDlJj+S1fX3Al+cyGithnqP3fq6UwZf/zAn5XV2qxDex/iyVHKEQ7zzZZNg5p18s+k
	 G8lygBCAI4+/K+CI/F6CYNza4B8WJgEe5tITSz+c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6.12 294/460] erofs: fix inline data read failure for ztailpacking pclusters
Date: Mon, 23 Mar 2026 14:44:50 +0100
Message-ID: <20260323134533.712241610@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228797-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6A40A2F5D36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit c134a40f86efb8d6b5a949ef70e06d5752209be5 ]

Compressed folios for ztailpacking pclusters must be valid before adding
these pclusters to I/O chains. Otherwise, z_erofs_decompress_pcluster()
may assume they are already valid and then trigger a NULL pointer
dereference.

It is somewhat hard to reproduce because the inline data is in the same
block as the tail of the compressed indexes, which are usually read just
before. However, it may still happen if a fatal signal arrives while
read_mapping_folio() is running, as shown below:

 erofs: (device dm-1): z_erofs_pcluster_begin: failed to get inline data -4
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008

 ...

 pc : z_erofs_decompress_queue+0x4c8/0xa14
 lr : z_erofs_decompress_queue+0x160/0xa14
 sp : ffffffc08b3eb3a0
 x29: ffffffc08b3eb570 x28: ffffffc08b3eb418 x27: 0000000000001000
 x26: ffffff8086ebdbb8 x25: ffffff8086ebdbb8 x24: 0000000000000001
 x23: 0000000000000008 x22: 00000000fffffffb x21: dead000000000700
 x20: 00000000000015e7 x19: ffffff808babb400 x18: ffffffc089edc098
 x17: 00000000c006287d x16: 00000000c006287d x15: 0000000000000004
 x14: ffffff80ba8f8000 x13: 0000000000000004 x12: 00000006589a77c9
 x11: 0000000000000015 x10: 0000000000000000 x9 : 0000000000000000
 x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
 x5 : 0000000000000040 x4 : ffffffffffffffe0 x3 : 0000000000000020
 x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
 Call trace:
  z_erofs_decompress_queue+0x4c8/0xa14
  z_erofs_runqueue+0x908/0x97c
  z_erofs_read_folio+0x128/0x228
  filemap_read_folio+0x68/0x128
  filemap_get_pages+0x44c/0x8b4
  filemap_read+0x12c/0x5b8
  generic_file_read_iter+0x4c/0x15c
  do_iter_readv_writev+0x188/0x1e0
  vfs_iter_read+0xac/0x1a4
  backing_file_read_iter+0x170/0x34c
  ovl_read_iter+0xf0/0x140
  vfs_read+0x28c/0x344
  ksys_read+0x80/0xf0
  __arm64_sys_read+0x24/0x34
  invoke_syscall+0x60/0x114
  el0_svc_common+0x88/0xe4
  do_el0_svc+0x24/0x30
  el0_svc+0x40/0xa8
  el0t_64_sync_handler+0x70/0xbc
  el0t_64_sync+0x1bc/0x1c0

Fix this by reading the inline data before allocating and adding
the pclusters to the I/O chains.

Fixes: cecf864d3d76 ("erofs: support inline data decompression")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-and-tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zdata.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -787,6 +787,7 @@ static int z_erofs_pcluster_begin(struct
 	struct super_block *sb = fe->inode->i_sb;
 	erofs_blk_t blknr = erofs_blknr(sb, map->m_pa);
 	struct z_erofs_pcluster *pcl = NULL;
+	void *ptr = NULL;
 	int ret;
 
 	DBG_BUGON(fe->pcl);
@@ -807,6 +808,14 @@ static int z_erofs_pcluster_begin(struct
 	} else if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
 		DBG_BUGON(1);
 		return -EFSCORRUPTED;
+	} else {
+		ptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
+		if (IS_ERR(ptr)) {
+			erofs_err(sb, "failed to read inline data %pe @ pa %llu of nid %llu",
+				  ptr, map->m_pa, EROFS_I(fe->inode)->nid);
+			return PTR_ERR(ptr);
+		}
+		ptr = map->buf.page;
 	}
 
 	if (pcl) {
@@ -836,16 +845,8 @@ static int z_erofs_pcluster_begin(struct
 		/* bind cache first when cached decompression is preferred */
 		z_erofs_bind_cache(fe);
 	} else {
-		void *mptr;
-
-		mptr = erofs_read_metabuf(&map->buf, sb, map->m_pa, EROFS_NO_KMAP);
-		if (IS_ERR(mptr)) {
-			ret = PTR_ERR(mptr);
-			erofs_err(sb, "failed to get inline data %d", ret);
-			return ret;
-		}
-		get_page(map->buf.page);
-		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, map->buf.page);
+		get_page((struct page *)ptr);
+		WRITE_ONCE(fe->pcl->compressed_bvecs[0].page, ptr);
 		fe->pcl->pageofs_in = map->m_pa & ~PAGE_MASK;
 		fe->mode = Z_EROFS_PCLUSTER_FOLLOWED_NOINPLACE;
 	}



