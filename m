Return-Path: <stable+bounces-174554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFFDB363A9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF51BC6F56
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2D2F6564;
	Tue, 26 Aug 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2r96K1JV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648A1494D9;
	Tue, 26 Aug 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214701; cv=none; b=M3a2fw2fz7PRDmB7pDLV4kfw8pkfI53BoIFes6GITVmD5RGpuQJxqcCMBna+cwkNOzNdaZONLaz6XrOL2A8e4PHFwIYvQQSyuP1rSfFUwVMu0gjYD+NSVFULDjlvoihBfwd4glm01sGsL7OU7eTD4qwhjCA/kftOBvm0auWVDsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214701; c=relaxed/simple;
	bh=FdOEW0pL4jHbfkXh+CVaC8FzIZOhcj6waPoQxGaj52s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuuiFYjHCYjZgzbj73UGJzmRim0Qyb4pRxT2nGSeeuWNXzNHt/cTAwFmKZSnS2EnBH0bAl0rXROWNFk3Bc3+l6kcPB2Qn6ScICeo2Soxpgb3n/dHnHvp4gMErt0CPbrfGd2rBWeYDVdKC11FdWBrfj9zJWn3Gg412VJgfs0JNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2r96K1JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94CCC4CEF1;
	Tue, 26 Aug 2025 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214701;
	bh=FdOEW0pL4jHbfkXh+CVaC8FzIZOhcj6waPoQxGaj52s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2r96K1JVYW2KSfR0S8xvsT0r8yE+cGlrKTv8rrrnGiILI33w5X6/m1r+TEbRUilUV
	 TP+q0slEyNMctz4Dwet3zCptG1j0xe+J8+NgkHLAdTOCdqrMFb4zu2BtMqxKIdsyiI
	 63tkbi/GSVSLyg35Y4MfZByFewSCI3hGalsnIfDw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 236/482] pNFS: Fix uninited ptr deref in block/scsi layout
Date: Tue, 26 Aug 2025 13:08:09 +0200
Message-ID: <20250826110936.603368449@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit 9768797c219326699778fba9cd3b607b2f1e7950 ]

The error occurs on the third attempt to encode extents. When function
ext_tree_prepare_commit() reallocates a larger buffer to retry encoding
extents, the "layoutupdate_pages" page array is initialized only after the
retry loop. But ext_tree_free_commitdata() is called on every iteration
and tries to put pages in the array, thus dereferencing uninitialized
pointers.

An additional problem is that there is no limit on the maximum possible
buffer_size. When there are too many extents, the client may create a
layoutcommit that is larger than the maximum possible RPC size accepted
by the server.

During testing, we observed two typical scenarios. First, one memory page
for extents is enough when we work with small files, append data to the
end of the file, or preallocate extents before writing. But when we fill
a new large file without preallocating, the number of extents can be huge,
and counting the number of written extents in ext_tree_encode_commit()
does not help much. Since this number increases even more between
unlocking and locking of ext_tree, the reallocated buffer may not be
large enough again and again.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250630183537.196479-2-sergeybashirov@gmail.com
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/blocklayout/extent_tree.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
index 8f7cff7a4293..0add0f329816 100644
--- a/fs/nfs/blocklayout/extent_tree.c
+++ b/fs/nfs/blocklayout/extent_tree.c
@@ -552,6 +552,15 @@ static int ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
 	return ret;
 }
 
+/**
+ * ext_tree_prepare_commit - encode extents that need to be committed
+ * @arg: layout commit data
+ *
+ * Return values:
+ *   %0: Success, all required extents are encoded
+ *   %-ENOSPC: Some extents are encoded, but not all, due to RPC size limit
+ *   %-ENOMEM: Out of memory, extents not encoded
+ */
 int
 ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 {
@@ -568,12 +577,12 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	start_p = page_address(arg->layoutupdate_page);
 	arg->layoutupdate_pages = &arg->layoutupdate_page;
 
-retry:
-	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size, &count, &arg->lastbytewritten);
+	ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+			&count, &arg->lastbytewritten);
 	if (unlikely(ret)) {
 		ext_tree_free_commitdata(arg, buffer_size);
 
-		buffer_size = ext_tree_layoutupdate_size(bl, count);
+		buffer_size = NFS_SERVER(arg->inode)->wsize;
 		count = 0;
 
 		arg->layoutupdate_pages =
@@ -588,7 +597,8 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 			return -ENOMEM;
 		}
 
-		goto retry;
+		ret = ext_tree_encode_commit(bl, start_p + 1, buffer_size,
+				&count, &arg->lastbytewritten);
 	}
 
 	*start_p = cpu_to_be32(count);
@@ -608,7 +618,7 @@ ext_tree_prepare_commit(struct nfs4_layoutcommit_args *arg)
 	}
 
 	dprintk("%s found %zu ranges\n", __func__, count);
-	return 0;
+	return ret;
 }
 
 void
-- 
2.39.5




