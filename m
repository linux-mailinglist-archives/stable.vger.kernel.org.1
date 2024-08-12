Return-Path: <stable+bounces-66949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A84D94F338
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4B61C21B5A
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5362C1A5;
	Mon, 12 Aug 2024 16:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zY8WJiS1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1316187335;
	Mon, 12 Aug 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479309; cv=none; b=DkpaJsP4Diwdw6EUZBKi0POaTtRg0+dNLv/MEsNy7UTUcg/zWEn+VEPPWAENaD5684xG8Vpk7eSvP4RhAj97l25VO9ondOiTF7tp1U/2qSe7wS8T7AP4TiGFDtkEt2rXYGf8j2H8wzqTfbT3T6oPNQqeNNHyEXzoDM4lIaaNJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479309; c=relaxed/simple;
	bh=DSMJYBidrOT0yLOZDWH3tBi/hRIu9dE8bYC3a1L259c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyd3qakKUvLR7xE71Ji5+o9QfVNc80CRlNi3fg7ToOZPjYIRz0f1/F93qRy+Ro1CfTgzsbrl7604TSNReQAHKn4Rdl0ljL5bfcjbcML2FrvDMexDduiqIbfLE7CJOVKFEL8KXcnx69zssLHAyKmdN4cnrx0AN+wiSz0irzBGw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zY8WJiS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCF5C32782;
	Mon, 12 Aug 2024 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479308;
	bh=DSMJYBidrOT0yLOZDWH3tBi/hRIu9dE8bYC3a1L259c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zY8WJiS1RHCMZ/cxUzp2o489KxbJHWuWiUGFNhQKLJOac5ENDcliwIVp5oIpq/IMr
	 JVIM3daR4josP/t8h0NatTX/A9ePUXmyrWNIaaBFKq0q5hUK14Jv9H8kq2UgiE/u0u
	 TbJ6dI3LOL4PlLf9L8sx5tLDBMOaKzYZSfjsXPns=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 046/189] btrfs: do not clear page dirty inside extent_write_locked_range()
Date: Mon, 12 Aug 2024 18:01:42 +0200
Message-ID: <20240812160133.918515515@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 97713b1a2ced1e4a2a6c40045903797ebd44d7e0 ]

[BUG]
For subpage + zoned case, the following workload can lead to rsv data
leak at unmount time:

  # mkfs.btrfs -f -s 4k $dev
  # mount $dev $mnt
  # fsstress -w -n 8 -d $mnt -s 1709539240
  0/0: fiemap - no filename
  0/1: copyrange read - no filename
  0/2: write - no filename
  0/3: rename - no source filename
  0/4: creat f0 x:0 0 0
  0/4: creat add id=0,parent=-1
  0/5: writev f0[259 1 0 0 0 0] [778052,113,965] 0
  0/6: ioctl(FIEMAP) f0[259 1 0 0 224 887097] [1294220,2291618343991484791,0x10000] -1
  0/7: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 224 887097] return 25, fallback to stat()
  0/7: dwrite f0[259 1 0 0 224 887097] [696320,102400] 0
  # umount $mnt

The dmesg includes the following rsv leak detection warning (all call
trace skipped):

  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 4528 at fs/btrfs/inode.c:8653 btrfs_destroy_inode+0x1e0/0x200 [btrfs]
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 4528 at fs/btrfs/inode.c:8654 btrfs_destroy_inode+0x1a8/0x200 [btrfs]
  ---[ end trace 0000000000000000 ]---
  ------------[ cut here ]------------
  WARNING: CPU: 2 PID: 4528 at fs/btrfs/inode.c:8660 btrfs_destroy_inode+0x1a0/0x200 [btrfs]
  ---[ end trace 0000000000000000 ]---
  BTRFS info (device sda): last unmount of filesystem 1b4abba9-de34-4f07-9e7f-157cf12a18d6
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 4528 at fs/btrfs/block-group.c:4434 btrfs_free_block_groups+0x338/0x500 [btrfs]
  ---[ end trace 0000000000000000 ]---
  BTRFS info (device sda): space_info DATA has 268218368 free, is not full
  BTRFS info (device sda): space_info total=268435456, used=204800, pinned=0, reserved=0, may_use=12288, readonly=0 zone_unusable=0
  BTRFS info (device sda): global_block_rsv: size 0 reserved 0
  BTRFS info (device sda): trans_block_rsv: size 0 reserved 0
  BTRFS info (device sda): chunk_block_rsv: size 0 reserved 0
  BTRFS info (device sda): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device sda): delayed_refs_rsv: size 0 reserved 0
  ------------[ cut here ]------------
  WARNING: CPU: 3 PID: 4528 at fs/btrfs/block-group.c:4434 btrfs_free_block_groups+0x338/0x500 [btrfs]
  ---[ end trace 0000000000000000 ]---
  BTRFS info (device sda): space_info METADATA has 267796480 free, is not full
  BTRFS info (device sda): space_info total=268435456, used=131072, pinned=0, reserved=0, may_use=262144, readonly=0 zone_unusable=245760
  BTRFS info (device sda): global_block_rsv: size 0 reserved 0
  BTRFS info (device sda): trans_block_rsv: size 0 reserved 0
  BTRFS info (device sda): chunk_block_rsv: size 0 reserved 0
  BTRFS info (device sda): delayed_block_rsv: size 0 reserved 0
  BTRFS info (device sda): delayed_refs_rsv: size 0 reserved 0

Above $dev is a tcmu-runner emulated zoned HDD, which has a max zone
append size of 64K, and the system has 64K page size.

[CAUSE]
I have added several trace_printk() to show the events (header skipped):

  > btrfs_dirty_pages: r/i=5/259 dirty start=774144 len=114688
  > btrfs_dirty_pages: r/i=5/259 dirty part of page=720896 off_in_page=53248 len_in_page=12288
  > btrfs_dirty_pages: r/i=5/259 dirty part of page=786432 off_in_page=0 len_in_page=65536
  > btrfs_dirty_pages: r/i=5/259 dirty part of page=851968 off_in_page=0 len_in_page=36864

The above lines show our buffered write has dirtied 3 pages of inode
259 of root 5:

  704K             768K              832K              896K
  I           |////I/////////////////I///////////|     I
              756K                               868K

  |///| is the dirtied range using subpage bitmaps. and 'I' is the page
  boundary.

  Meanwhile all three pages (704K, 768K, 832K) have their PageDirty
  flag set.

  > btrfs_direct_write: r/i=5/259 start dio filepos=696320 len=102400

Then direct IO write starts, since the range [680K, 780K) covers the
beginning part of the above dirty range, we need to writeback the
two pages at 704K and 768K.

  > cow_file_range: r/i=5/259 add ordered extent filepos=774144 len=65536
  > extent_write_locked_range: r/i=5/259 locked page=720896 start=774144 len=65536

Now the above 2 lines show that we're writing back for dirty range
[756K, 756K + 64K).
We only writeback 64K because the zoned device has max zone append size
as 64K.

  > extent_write_locked_range: r/i=5/259 clear dirty for page=786432

!!! The above line shows the root cause. !!!

We're calling clear_page_dirty_for_io() inside extent_write_locked_range(),
for the page 768K.
This is because extent_write_locked_range() can go beyond the current
locked page, here we hit the page at 768K and clear its page dirt.

In fact this would lead to the desync between subpage dirty and page
dirty flags.  We have the page dirty flag cleared, but the subpage range
[820K, 832K) is still dirty.

After the writeback of range [756K, 820K), the dirty flags look like
this, as page 768K no longer has dirty flag set.

  704K             768K              832K              896K
  I                I      |          I/////////////|   I
                          820K                     868K

This means we will no longer writeback range [820K, 832K), thus the
reserved data/metadata space would never be properly released.

  > extent_write_cache_pages: r/i=5/259 skip non-dirty folio=786432

Now even though we try to start writeback for page 768K, since the
page is not dirty, we completely skip it at extent_write_cache_pages()
time.

  > btrfs_direct_write: r/i=5/259 dio done filepos=696320 len=0

Now the direct IO finished.

  > cow_file_range: r/i=5/259 add ordered extent filepos=851968 len=36864
  > extent_write_locked_range: r/i=5/259 locked page=851968 start=851968 len=36864

Now we writeback the remaining dirty range, which is [832K, 868K).
Causing the range [820K, 832K) never to be submitted, thus leaking the
reserved space.

This bug only affects subpage and zoned case.  For non-subpage and zoned
case, we have exactly one sector for each page, thus no such partial dirty
cases.

For subpage and non-zoned case, we never go into run_delalloc_cow(), and
normally all the dirty subpage ranges would be properly submitted inside
__extent_writepage_io().

[FIX]
Just do not clear the page dirty at all inside extent_write_locked_range().
As __extent_writepage_io() would do a more accurate, subpage compatible
clear for page and subpage dirty flags anyway.

Now the correct trace would look like this:

  > btrfs_dirty_pages: r/i=5/259 dirty start=774144 len=114688
  > btrfs_dirty_pages: r/i=5/259 dirty part of page=720896 off_in_page=53248 len_in_page=12288
  > btrfs_dirty_pages: r/i=5/259 dirty part of page=786432 off_in_page=0 len_in_page=65536
  > btrfs_dirty_pages: r/i=5/259 dirty part of page=851968 off_in_page=0 len_in_page=36864

The page dirty part is still the same 3 pages.

  > btrfs_direct_write: r/i=5/259 start dio filepos=696320 len=102400
  > cow_file_range: r/i=5/259 add ordered extent filepos=774144 len=65536
  > extent_write_locked_range: r/i=5/259 locked page=720896 start=774144 len=65536

And the writeback for the first 64K is still correct.

  > cow_file_range: r/i=5/259 add ordered extent filepos=839680 len=49152
  > extent_write_locked_range: r/i=5/259 locked page=786432 start=839680 len=49152

Now with the fix, we can properly writeback the range [820K, 832K), and
properly release the reserved data/metadata space.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9fbffd84b16c5..c6a95dfa59c81 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2172,10 +2172,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 
 		page = find_get_page(mapping, cur >> PAGE_SHIFT);
 		ASSERT(PageLocked(page));
-		if (pages_dirty && page != locked_page) {
+		if (pages_dirty && page != locked_page)
 			ASSERT(PageDirty(page));
-			clear_page_dirty_for_io(page);
-		}
 
 		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
 					    i_size, &nr);
-- 
2.43.0




