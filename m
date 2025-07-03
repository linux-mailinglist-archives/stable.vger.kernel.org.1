Return-Path: <stable+bounces-159933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F655AF7B6B
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E5C565FEA
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5409D2EE5E4;
	Thu,  3 Jul 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HW1LFQ3y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174522069F;
	Thu,  3 Jul 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555825; cv=none; b=OLoyACMvtv4XTiaMDq6d6XjUReEBSc9H7eAE5P6ffyWWYSqA1Nh2YjP6PezfetmxWU46ejv8gMaPuY0Iq9XTPQSHiCZ2dEaFIz/0Ebrgfpdy2A7zspRu77g5xF2L90D3eQb0NuMB0Q9ZhpqeYmIrg8tq33Ojs78lmyYVGjzVWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555825; c=relaxed/simple;
	bh=qCRLFREFGQEaoYo+qoRoyAoOc/SKKLUk9gzDMaLWbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHWZ7FZ8WHk/2R6KZRjNbruBerxpnvcimGpQcU7QUsCv2xvMyASFLVGpFclgcc2QYs6v1kST+OqSs3EXPC0NrXr79v/iwzxmRc3B5qwRWBGtoq/y/7A45UOq8eRXZHh1FgG1PECSmoAEbT40+qskBNkNiry8EAoLg5P9D9kQbkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HW1LFQ3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871A5C4CEE3;
	Thu,  3 Jul 2025 15:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555824;
	bh=qCRLFREFGQEaoYo+qoRoyAoOc/SKKLUk9gzDMaLWbgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HW1LFQ3yZlxYV7Of+37DSN5/AIGg/K4ZgEhYDnaKyjEYwF+OPRCgfAXHtMYRUV3Aq
	 v8GFatJN0NBnZVvYjz4SMSIeXY0ICHTXq1gDdbJ7Fp5mLHkSHwlUdk2AftkFl4x2s4
	 oQrIRo3UbwmkDkpD2e0V8S7MIzs2veprY7x8mEbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Mark Harmstone <maharmstone@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 102/139] btrfs: update superblocks device bytes_used when dropping chunk
Date: Thu,  3 Jul 2025 16:42:45 +0200
Message-ID: <20250703143945.157991474@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Harmstone <maharmstone@fb.com>

commit ae4477f937569d097ca5dbce92a89ba384b49bc6 upstream.

Each superblock contains a copy of the device item for that device. In a
transaction which drops a chunk but doesn't create any new ones, we were
correctly updating the device item in the chunk tree but not copying
over the new bytes_used value to the superblock.

This can be seen by doing the following:

  # dd if=/dev/zero of=test bs=4096 count=2621440
  # mkfs.btrfs test
  # mount test /root/temp

  # cd /root/temp
  # for i in {00..10}; do dd if=/dev/zero of=$i bs=4096 count=32768; done
  # sync
  # rm *
  # sync
  # btrfs balance start -dusage=0 .
  # sync

  # cd
  # umount /root/temp
  # btrfs check test

For btrfs-check to detect this, you will also need my patch at
https://github.com/kdave/btrfs-progs/pull/991.

Change btrfs_remove_dev_extents() so that it adds the devices to the
fs_info->post_commit_list if they're not there already. This causes
btrfs_commit_device_sizes() to be called, which updates the bytes_used
value in the superblock.

Fixes: bbbf7243d62d ("btrfs: combine device update operations during transaction commit")
CC: stable@vger.kernel.org # 5.10+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Mark Harmstone <maharmstone@fb.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3174,6 +3174,12 @@ int btrfs_remove_chunk(struct btrfs_tran
 					device->bytes_used - dev_extent_len);
 			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
 			btrfs_clear_space_info_full(fs_info);
+
+			if (list_empty(&device->post_commit_list)) {
+				list_add_tail(&device->post_commit_list,
+					      &trans->transaction->dev_update_list);
+			}
+
 			mutex_unlock(&fs_info->chunk_mutex);
 		}
 	}



