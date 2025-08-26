Return-Path: <stable+bounces-176240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2BDB36AF7
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59BF84E2AE3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A79435FC36;
	Tue, 26 Aug 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jSGZQHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091335FC29;
	Tue, 26 Aug 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219141; cv=none; b=qxovpvysC2iQ3Ugmn8F8B+wp2QxwgqICKUNIL5I2APtBMRp+caUImwRiYbPv7I++UhSznO8+L69M0jlMsxylO5P3QY4wKhBZddEkO6KRGvL1glWzcNAsjIIQaTR3TmFskGKcmyQycQApUnewAWbYXgUtG6PZ/J4V556v/tIBBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219141; c=relaxed/simple;
	bh=Z12DYYH302f3N+6GY/W+2q/mqgXe6REwFughrGmKito=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C78XtSVoZnPIUdEVYHkOA4GY/40RB19ulHAmZSCebUIVp/ieHlOlOd1g8Gkyl3BoHS2WOVAj4mppsHz7QVMep/lDGqFIZtGVxyetqzaxRc352tNRt0PJ0W8oCQU5X3lGGIBz8GHrgiJ+j4ssVTy7d8vPsdX0JTxBBtfaY6uCutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jSGZQHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1A1C4CEF1;
	Tue, 26 Aug 2025 14:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219141;
	bh=Z12DYYH302f3N+6GY/W+2q/mqgXe6REwFughrGmKito=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1jSGZQHwT1EXYzEI2QXBCk+7sOmn9ZYs2OCsHpwrzBsImnoETqZglgEbfTMRGSTtt
	 uuMpcZC0PkMcYBA1+Uvtm+xhouvxqKdnQdnyLWz5hma0LZWko8dEDBamBTrP96pOFa
	 8D8pqMAieCQ6T83ow83Jq2ZykkhdsQjVx8IuBeVw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 269/403] pNFS: Handle RPC size limit for layoutcommits
Date: Tue, 26 Aug 2025 13:09:55 +0200
Message-ID: <20250826110914.235530279@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit d897d81671bc4615c80f4f3bd5e6b218f59df50c ]

When there are too many block extents for a layoutcommit, they may not
all fit into the maximum-sized RPC. This patch allows the generic pnfs
code to properly handle -ENOSPC returned by the block/scsi layout driver
and trigger additional layoutcommits if necessary.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250630183537.196479-5-sergeybashirov@gmail.com
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pnfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index d91576a587e4..992cdac8dbe9 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -3047,6 +3047,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t end_pos;
 	int status;
+	bool mark_as_dirty = false;
 
 	if (!pnfs_layoutcommit_outstanding(inode))
 		return 0;
@@ -3098,19 +3099,23 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	if (ld->prepare_layoutcommit) {
 		status = ld->prepare_layoutcommit(&data->args);
 		if (status) {
-			put_cred(data->cred);
+			if (status != -ENOSPC)
+				put_cred(data->cred);
 			spin_lock(&inode->i_lock);
 			set_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags);
 			if (end_pos > nfsi->layout->plh_lwb)
 				nfsi->layout->plh_lwb = end_pos;
-			goto out_unlock;
+			if (status != -ENOSPC)
+				goto out_unlock;
+			spin_unlock(&inode->i_lock);
+			mark_as_dirty = true;
 		}
 	}
 
 
 	status = nfs4_proc_layoutcommit(data, sync);
 out:
-	if (status)
+	if (status || mark_as_dirty)
 		mark_inode_dirty_sync(inode);
 	dprintk("<-- %s status %d\n", __func__, status);
 	return status;
-- 
2.39.5




