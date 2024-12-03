Return-Path: <stable+bounces-97273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709F79E2379
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BDA286ECD
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543901F76BF;
	Tue,  3 Dec 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzXClzLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E42E1F756A;
	Tue,  3 Dec 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240010; cv=none; b=IRqeQKfYNOlJuv4ed64iIPlmbMbnSNp1pHpJSPADYCh4KK+hmomNvrI6tItkyJAMIhUOb1eiACvD9BPBLYS4Of4BLDeHqAHWB1Q/IX554cafBXM7AHwqCP56zwkUfdot0dNFLmq/nOuAAMFA0G9YTOpdlhKKLfuF0JVkY3+epsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240010; c=relaxed/simple;
	bh=0fwlhmVTpvtyJEtYUgFtHxhI4IMWcrvYEtEdkEKJdBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfHN0HacbzFcEsI5QxBkLGIkLIcFc4lD0a9Ima+jAuIoR9jRMEbs7mQkG40pLpiA+Y0QU5EYboJKXTK/L5GH0La5aw1xQwiE0HJZFxzFqUktg1CdGn2vXa5cOfWizxI40hHjU96LnxTZEAcYst4slSNRC9JRplJvuOOIhnyIqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzXClzLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC41C4CED6;
	Tue,  3 Dec 2024 15:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240009;
	bh=0fwlhmVTpvtyJEtYUgFtHxhI4IMWcrvYEtEdkEKJdBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WzXClzLKPsepPx1l8F5uNj/bBScB8yTm3isUL374No1wjKIz+BoX6A5i2zYvCt4ML
	 AiWxlIXwcoBArqHDz//ngxBQDO2RSuOWVtv/pw71qFdeEGe5bbm+DFqTW5JssMZfN0
	 y6bbKw2z4H9NUL2kNcW3wwvNX/SeO3Awxs0eRtcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Coddington <bcodding@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 809/817] nfs/blocklayout: Dont attempt unregister for invalid block device
Date: Tue,  3 Dec 2024 15:46:21 +0100
Message-ID: <20241203144028.030684217@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit 3a4ce14d9a6b868e0787e4582420b721c04ee41e ]

Since commit d869da91cccb ("nfs/blocklayout: Fix premature PR key
unregistration") an unmount of a pNFS SCSI layout-enabled NFS may
dereference a NULL block_device in:

  bl_unregister_scsi+0x16/0xe0 [blocklayoutdriver]
  bl_free_device+0x70/0x80 [blocklayoutdriver]
  bl_free_deviceid_node+0x12/0x30 [blocklayoutdriver]
  nfs4_put_deviceid_node+0x60/0xc0 [nfsv4]
  nfs4_deviceid_purge_client+0x132/0x190 [nfsv4]
  unset_pnfs_layoutdriver+0x59/0x60 [nfsv4]
  nfs4_destroy_server+0x36/0x70 [nfsv4]
  nfs_free_server+0x23/0xe0 [nfs]
  deactivate_locked_super+0x30/0xb0
  cleanup_mnt+0xba/0x150
  task_work_run+0x59/0x90
  syscall_exit_to_user_mode+0x217/0x220
  do_syscall_64+0x8e/0x160

This happens because even though we were able to create the
nfs4_deviceid_node, the lookup for the device was unable to attach the
block device to the pnfs_block_dev.

If we never found a block device to register, we can avoid this case with
the PNFS_BDEV_REGISTERED flag.  Move the deref behind the test for the
flag.

Fixes: d869da91cccb ("nfs/blocklayout: Fix premature PR key unregistration")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/blocklayout/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 6252f44479457..cab8809f0e0f4 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -20,9 +20,6 @@ static void bl_unregister_scsi(struct pnfs_block_dev *dev)
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 	int status;
 
-	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
-		return;
-
 	status = ops->pr_register(bdev, dev->pr_key, 0, false);
 	if (status)
 		trace_bl_pr_key_unreg_err(bdev, dev->pr_key, status);
@@ -58,7 +55,8 @@ static void bl_unregister_dev(struct pnfs_block_dev *dev)
 		return;
 	}
 
-	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
+	if (dev->type == PNFS_BLOCK_VOLUME_SCSI &&
+		test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
 		bl_unregister_scsi(dev);
 }
 
-- 
2.43.0




