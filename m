Return-Path: <stable+bounces-1799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAAA7F8168
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E896B20AE1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1B53418B;
	Fri, 24 Nov 2023 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VcsK7f9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220442E64F;
	Fri, 24 Nov 2023 18:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D46C433C8;
	Fri, 24 Nov 2023 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852303;
	bh=ILHGn/0rQ1b23KrEn3FNjDRQBjvd24O/fqR0Zx8VrnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VcsK7f9aXBq3pcOa3fpKbOB5fvbWvSQT+1C6jQab+cK/VUxPW02iSXY2D4bSpJE7i
	 4qr9iH/74J2pLw9cQ0o7sBaaeyRB8zFyTd1HZyq+eJaw5H5+xk401AhU1zNzKDS2p6
	 RqSdWMAXxY91p6fWHUTE4fEyQm9DM9ZMLibkF+2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 277/372] btrfs: zoned: wait for data BG to be finished on direct IO allocation
Date: Fri, 24 Nov 2023 17:51:04 +0000
Message-ID: <20231124172019.691022360@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Naohiro Aota <naohiro.aota@wdc.com>

commit 776a838f1fa95670c1c1cf7109a898090b473fa3 upstream.

Running the fio command below on a ZNS device results in "Resource
temporarily unavailable" error.

  $ sudo fio --name=w --directory=/mnt --filesize=1GB --bs=16MB --numjobs=16 \
        --rw=write --ioengine=libaio --iodepth=128 --direct=1

  fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: write offset=117440512, buflen=16777216
  fio: io_u error on file /mnt/w.2.0: Resource temporarily unavailable: write offset=134217728, buflen=16777216
  ...

This happens because -EAGAIN error returned from btrfs_reserve_extent()
called from btrfs_new_extent_direct() is spilling over to the userland.

btrfs_reserve_extent() returns -EAGAIN when there is no active zone
available. Then, the caller should wait for some other on-going IO to
finish a zone and retry the allocation.

This logic is already implemented for buffered write in cow_file_range(),
but it is missing for the direct IO counterpart. Implement the same logic
for it.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 2ce543f47843 ("btrfs: zoned: wait until zone is finished when allocation didn't progress")
CC: stable@vger.kernel.org # 6.1+
Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7166,8 +7166,15 @@ static struct extent_map *btrfs_new_exte
 	int ret;
 
 	alloc_hint = get_extent_allocation_hint(inode, start, len);
+again:
 	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
 				   0, alloc_hint, &ins, 1, 1);
+	if (ret == -EAGAIN) {
+		ASSERT(btrfs_is_zoned(fs_info));
+		wait_on_bit_io(&inode->root->fs_info->flags, BTRFS_FS_NEED_ZONE_FINISH,
+			       TASK_UNINTERRUPTIBLE);
+		goto again;
+	}
 	if (ret)
 		return ERR_PTR(ret);
 



