Return-Path: <stable+bounces-34045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C20D893DA1
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E95283217
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822CD4A99C;
	Mon,  1 Apr 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bUzV9tWE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4022301;
	Mon,  1 Apr 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986827; cv=none; b=RrKIxlIhCCE0suMObdzEhPxvYEVB3M4H/m5lTOYHfUu1BOmtbRU9vGv5qtXHxXjZHqLQtcs56XX4nf2yMgsrViaXk3o6gxqPxrnYrCuxIRgZEts38A+De6jgeDhEAHQkhRe3GV4ZuZaMhUF3+9QtpCoOdcp9oEpGznfReZNgy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986827; c=relaxed/simple;
	bh=8G1+xbGW02y0EIN6+blJQrnHjE5B0X20hIMBdRq57Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCaB/C63xSNoQ5/pmnUdmm+07BWpNnVdRYsk7TbXVGp0SCT0ZxVFWixtck/DBAC6jL96vOv7rPx/IL2yHI7fXKVMZunFd2X50HcO/QeK2FfAkvgGsDZ3BGRYx4ulekiXysiTzC3Ive06Nc0FAHC7dN3iapRBTHmIhTp/VKMnmws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bUzV9tWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F43FC433F1;
	Mon,  1 Apr 2024 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986825;
	bh=8G1+xbGW02y0EIN6+blJQrnHjE5B0X20hIMBdRq57Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bUzV9tWEb1UYJVaP2mkbuiLsEJ6+/JXQ8TM2neJMpvaIC4XJ8F/+n9N0USrMNtcT6
	 EG1xCqLj5X3FFsM9cCiMm3rmA8ly4i4q3lmbWmebHU4J+lrm1lWkUumZ0sGYFl/HTR
	 Eq+0wCyToosmorbfe9dyBHE+Re9B2tgNN0lKw5Qc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabian Vogt <fvogt@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 096/399] btrfs: qgroup: always free reserved space for extent records
Date: Mon,  1 Apr 2024 17:41:02 +0200
Message-ID: <20240401152552.049409270@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit d139ded8b9cdb897bb9539eb33311daf9a177fd2 ]

[BUG]
If qgroup is marked inconsistent (e.g. caused by operations needing full
subtree rescan, like creating a snapshot and assign to a higher level
qgroup), btrfs would immediately start leaking its data reserved space.

The following script can easily reproduce it:

  mkfs.btrfs -O quota -f $dev
  mount $dev $mnt
  btrfs subvolume create $mnt/subv1
  btrfs qgroup create 1/0 $mnt

  # This snapshot creation would mark qgroup inconsistent,
  # as the ownership involves different higher level qgroup, thus
  # we have to rescan both source and snapshot, which can be very
  # time consuming, thus here btrfs just choose to mark qgroup
  # inconsistent, and let users to determine when to do the rescan.
  btrfs subv snapshot -i 1/0 $mnt/subv1 $mnt/snap1

  # Now this write would lead to qgroup rsv leak.
  xfs_io -f -c "pwrite 0 64k" $mnt/file1

  # And at unmount time, btrfs would report 64K DATA rsv space leaked.
  umount $mnt

And we would have the following dmesg output for the unmount:

  BTRFS info (device dm-1): last unmount of filesystem 14a3d84e-f47b-4f72-b053-a8a36eef74d3
  BTRFS warning (device dm-1): qgroup 0/5 has unreleased space, type 0 rsv 65536

[CAUSE]
Since commit e15e9f43c7ca ("btrfs: introduce
BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting"),
we introduce a mode for btrfs qgroup to skip the timing consuming
backref walk, if the qgroup is already inconsistent.

But this skip also covered the data reserved freeing, thus the qgroup
reserved space for each newly created data extent would not be freed,
thus cause the leakage.

[FIX]
Make the data extent reserved space freeing mandatory.

The qgroup reserved space handling is way cheaper compared to the
backref walking part, and we always have the super sensitive leak
detector, thus it's definitely worth to always free the qgroup
reserved data space.

Reported-by: Fabian Vogt <fvogt@suse.com>
Fixes: e15e9f43c7ca ("btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
CC: stable@vger.kernel.org # 6.1+
Link: https://bugzilla.suse.com/show_bug.cgi?id=1216196
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5470e1cdf10c5..5df54f78db2b9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2959,11 +2959,6 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 				ctx.roots = NULL;
 			}
 
-			/* Free the reserved data space */
-			btrfs_qgroup_free_refroot(fs_info,
-					record->data_rsv_refroot,
-					record->data_rsv,
-					BTRFS_QGROUP_RSV_DATA);
 			/*
 			 * Use BTRFS_SEQ_LAST as time_seq to do special search,
 			 * which doesn't lock tree or delayed_refs and search
@@ -2987,6 +2982,11 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 			record->old_roots = NULL;
 			new_roots = NULL;
 		}
+		/* Free the reserved data space */
+		btrfs_qgroup_free_refroot(fs_info,
+				record->data_rsv_refroot,
+				record->data_rsv,
+				BTRFS_QGROUP_RSV_DATA);
 cleanup:
 		ulist_free(record->old_roots);
 		ulist_free(new_roots);
-- 
2.43.0




