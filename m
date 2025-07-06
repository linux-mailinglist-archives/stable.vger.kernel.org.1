Return-Path: <stable+bounces-159615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAD0AF7980
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5393B4A2B80
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3752E2EE98F;
	Thu,  3 Jul 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F9ELKPRW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CF82EE96B;
	Thu,  3 Jul 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554790; cv=none; b=PDNSQPWDRlC5yFyBdw99pbfcLNzrUgr8c/NTYKoX4E/dF7sS2sRRdiQmH3/WVYYUr6/S5iZ1FsQ/lMPcjoBaiC/iDnmXXg9wx1hFnf/ZrapJKu6g0s/LrJGqvc5OSo03FN47GhReo2W/71bsMribHfSAntdYAoKSIoENdTr0x/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554790; c=relaxed/simple;
	bh=UaChHF/UcbesRsdNxf22DRLEEhaqQxN8mtKtJrb/6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rw+VcwPmEjrgco52DcUAO+SHXcVkiA3eXHtDSjWI/jwS7rMliY7tBTgY0B3LcmCBdtict0m7gyRtTHJfBjSmcJteLTXM7u5X02a+aWn3vciOmzk25ZeiYXfmDA4Cd6HmznHa7j0wkwCNeVkPKTRQClZppcD/vncEQvl3PLNceL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F9ELKPRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D92C4CEE3;
	Thu,  3 Jul 2025 14:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554789;
	bh=UaChHF/UcbesRsdNxf22DRLEEhaqQxN8mtKtJrb/6ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F9ELKPRWVFLLUCCSWwwsj+sKcEVBl4kCEC9XBqG1Ufa3jbj0yMEysAz9Q2guv5zDk
	 vhF/Fh7/PWesSPW9QGqUn+3gGrObKg35crlqjqIBbDSbTSVdXJmgFAiF+qEp2otoTn
	 zKaY/S6QA07eq22pHNPCCfFTbLUKweAog4B30KIg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiyu Zhang <zhiyuzhang999@gmail.com>,
	Longxing Li <coregee2000@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 079/263] btrfs: handle csum tree error with rescue=ibadroots correctly
Date: Thu,  3 Jul 2025 16:39:59 +0200
Message-ID: <20250703144007.466691943@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 547e836661554dcfa15c212a3821664e85b4191a ]

[BUG]
There is syzbot based reproducer that can crash the kernel, with the
following call trace: (With some debug output added)

 DEBUG: rescue=ibadroots parsed
 BTRFS: device fsid 14d642db-7b15-43e4-81e6-4b8fac6a25f8 devid 1 transid 8 /dev/loop0 (7:0) scanned by repro (1010)
 BTRFS info (device loop0): first mount of filesystem 14d642db-7b15-43e4-81e6-4b8fac6a25f8
 BTRFS info (device loop0): using blake2b (blake2b-256-generic) checksum algorithm
 BTRFS info (device loop0): using free-space-tree
 BTRFS warning (device loop0): checksum verify failed on logical 5312512 mirror 1 wanted 0xb043382657aede36608fd3386d6b001692ff406164733d94e2d9a180412c6003 found 0x810ceb2bacb7f0f9eb2bf3b2b15c02af867cb35ad450898169f3b1f0bd818651 level 0
 DEBUG: read tree root path failed for tree csum, ret=-5
 BTRFS warning (device loop0): checksum verify failed on logical 5328896 mirror 1 wanted 0x51be4e8b303da58e6340226815b70e3a93592dac3f30dd510c7517454de8567a found 0x51be4e8b303da58e634022a315b70e3a93592dac3f30dd510c7517454de8567a level 0
 BTRFS warning (device loop0): checksum verify failed on logical 5292032 mirror 1 wanted 0x1924ccd683be9efc2fa98582ef58760e3848e9043db8649ee382681e220cdee4 found 0x0cb6184f6e8799d9f8cb335dccd1d1832da1071d12290dab3b85b587ecacca6e level 0
 process 'repro' launched './file2' with NULL argv: empty string added
 DEBUG: no csum root, idatacsums=0 ibadroots=134217728
 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000041: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000208-0x000000000000020f]
 CPU: 5 UID: 0 PID: 1010 Comm: repro Tainted: G           OE       6.15.0-custom+ #249 PREEMPT(full)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 RIP: 0010:btrfs_lookup_csum+0x93/0x3d0 [btrfs]
 Call Trace:
  <TASK>
  btrfs_lookup_bio_sums+0x47a/0xdf0 [btrfs]
  btrfs_submit_bbio+0x43e/0x1a80 [btrfs]
  submit_one_bio+0xde/0x160 [btrfs]
  btrfs_readahead+0x498/0x6a0 [btrfs]
  read_pages+0x1c3/0xb20
  page_cache_ra_order+0x4b5/0xc20
  filemap_get_pages+0x2d3/0x19e0
  filemap_read+0x314/0xde0
  __kernel_read+0x35b/0x900
  bprm_execve+0x62e/0x1140
  do_execveat_common.isra.0+0x3fc/0x520
  __x64_sys_execveat+0xdc/0x130
  do_syscall_64+0x54/0x1d0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 ---[ end trace 0000000000000000 ]---

[CAUSE]
Firstly the fs has a corrupted csum tree root, thus to mount the fs we
have to go "ro,rescue=ibadroots" mount option.

Normally with that mount option, a bad csum tree root should set
BTRFS_FS_STATE_NO_DATA_CSUMS flag, so that any future data read will
ignore csum search.

But in this particular case, we have the following call trace that
caused NULL csum root, but not setting BTRFS_FS_STATE_NO_DATA_CSUMS:

load_global_roots_objectid():

		ret = btrfs_search_slot();
		/* Succeeded */
		btrfs_item_key_to_cpu()
		found = true;
		/* We found the root item for csum tree. */
		root = read_tree_root_path();
		if (IS_ERR(root)) {
			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
			/*
			 * Since we have rescue=ibadroots mount option,
			 * @ret is still 0.
			 */
			break;
	if (!found || ret) {
		/* @found is true, @ret is 0, error handling for csum
		 * tree is skipped.
		 */
	}

This means we completely skipped to set BTRFS_FS_STATE_NO_DATA_CSUMS if
the csum tree is corrupted, which results unexpected later csum lookup.

[FIX]
If read_tree_root_path() failed, always populate @ret to the error
number.

As at the end of the function, we need @ret to determine if we need to
do the extra error handling for csum tree.

Fixes: abed4aaae4f7 ("btrfs: track the csum, extent, and free space trees in a rb tree")
Reported-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Reported-by: Longxing Li <coregee2000@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 87501762d81fb..321feb99c1797 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2164,8 +2164,7 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		found = true;
 		root = read_tree_root_path(tree_root, path, &key);
 		if (IS_ERR(root)) {
-			if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
-				ret = PTR_ERR(root);
+			ret = PTR_ERR(root);
 			break;
 		}
 		set_bit(BTRFS_ROOT_TRACK_DIRTY, &root->state);
-- 
2.39.5




