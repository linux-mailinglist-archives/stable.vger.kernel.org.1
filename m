Return-Path: <stable+bounces-120298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B76A4E788
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6178460080
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5627EC69;
	Tue,  4 Mar 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHuqvm8o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72027BF6F
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106068; cv=none; b=EnO7w0eQ+Qfrp+LS617lvju3WEYQEa8ALi2OlxCHmUbi0BTDgBzerdarOBKkA5MA2ebOkm8kDO9pgM21t1I9cHi1ISHvn701/n4kitwIreYw+yQ/NZNIO+aBpiAGA7AgcL7CZlNQFpYXXHzQ+kwPyw0EzL7FJ883I0qMIaTyOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106068; c=relaxed/simple;
	bh=uv1wx+vSNUwLhVKaEiofGwkwiUReBGMgGBkIM1/+5Es=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RXV6dvncS1+saYLkNd9AG28eIOWtcumbgVGU6/P8P6fPdHpbDy/WouZgXVN799a2L8NgtRvBV1zsMppnFN5vArDO8rwJQ8IsFAIhPsC9W5ECSZuhanAuJSH7L5RSm4IZasy2yn46PpPmgY0uaTLIu+iYXCGwpQzv1fNJeq66W74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHuqvm8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C66C4CEE5;
	Tue,  4 Mar 2025 16:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741106067;
	bh=uv1wx+vSNUwLhVKaEiofGwkwiUReBGMgGBkIM1/+5Es=;
	h=Subject:To:Cc:From:Date:From;
	b=VHuqvm8o/hwCSpUs8y5CDsPOJVERgkl4sElP+yM1vbpw3yBtsnYKL4DN14EtqE9+k
	 caea45mY6A1aHlzW+4iFqj7GBihIk1iGfmX/VcXLi9rQTbNMYAlLWRyQdXDCz7EdhE
	 fjO4cEnZpgUWB0F7H4pXuQu++F12V7Ds90Bzw+XQ=
Subject: FAILED: patch "[PATCH] btrfs: fix data overwriting bug during buffered write when" failed to apply to 5.4-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Mar 2025 17:34:20 +0100
Message-ID: <2025030420-underfeed-siren-2384@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x efa11fd269c139e29b71ec21bc9c9c0063fde40d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030420-underfeed-siren-2384@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From efa11fd269c139e29b71ec21bc9c9c0063fde40d Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 19 Feb 2025 09:06:33 +1030
Subject: [PATCH] btrfs: fix data overwriting bug during buffered write when
 block size < page size

[BUG]
When running generic/418 with a btrfs whose block size < page size
(subpage cases), it always fails.

And the following minimal reproducer is more than enough to trigger it
reliably:

workload()
{
        mkfs.btrfs -s 4k -f $dev > /dev/null
        dmesg -C
        mount $dev $mnt
        $fsstree_dir/src/dio-invalidate-cache -r -b 4096 -n 3 -i 1 -f $mnt/diotest
        ret=$?
        umount $mnt
        stop_trace
        if [ $ret -ne 0 ]; then
                fail
        fi
}

for (( i = 0; i < 1024; i++)); do
        echo "=== $i/$runtime ==="
        workload
done

[CAUSE]
With extra trace printk added to the following functions:
- btrfs_buffered_write()
  * Which folio is touched
  * The file offset (start) where the buffered write is at
  * How many bytes are copied
  * The content of the write (the first 2 bytes)

- submit_one_sector()
  * Which folio is touched
  * The position inside the folio
  * The content of the page cache (the first 2 bytes)

- pagecache_isize_extended()
  * The parameters of the function itself
  * The parameters of the folio_zero_range()

Which are enough to show the problem:

  22.158114: btrfs_buffered_write: folio pos=0 start=0 copied=4096 content=0x0101
  22.158161: submit_one_sector: r/i=5/257 folio=0 pos=0 content=0x0101
  22.158609: btrfs_buffered_write: folio pos=0 start=4096 copied=4096 content=0x0101
  22.158634: btrfs_buffered_write: folio pos=0 start=8192 copied=4096 content=0x0101
  22.158650: pagecache_isize_extended: folio=0 from=4096 to=8192 bsize=4096 zero off=4096 len=8192
  22.158682: submit_one_sector: r/i=5/257 folio=0 pos=4096 content=0x0000
  22.158686: submit_one_sector: r/i=5/257 folio=0 pos=8192 content=0x0101

The tool dio-invalidate-cache will start 3 threads, each doing a buffered
write with 0x01 at offset 0, 4096 and 8192, do a fsync, then do a direct read,
and compare the read buffer with the write buffer.

Note that all 3 btrfs_buffered_write() are writing the correct 0x01 into
the page cache.

But at submit_one_sector(), at file offset 4096, the content is zeroed
out, by pagecache_isize_extended().

The race happens like this:
 Thread A is writing into range [4K, 8K).
 Thread B is writing into range [8K, 12k).

               Thread A              |         Thread B
-------------------------------------+------------------------------------
btrfs_buffered_write()               | btrfs_buffered_write()
|- old_isize = 4K;                   | |- old_isize = 4096;
|- btrfs_inode_lock()                | |
|- write into folio range [4K, 8K)   | |
|- pagecache_isize_extended()        | |
|  extend isize from 4096 to 8192    | |
|  no folio_zero_range() called      | |
|- btrfs_inode_lock()                | |
                                     | |- btrfs_inode_lock()
				     | |- write into folio range [8K, 12K)
				     | |- pagecache_isize_extended()
				     | |  calling folio_zero_range(4K, 8K)
				     | |  This is caused by the old_isize is
				     | |  grabbed too early, without any
				     | |  inode lock.
				     | |- btrfs_inode_unlock()

The @old_isize is grabbed without inode lock, causing race between two
buffered write threads and making pagecache_isize_extended() to zero
range which is still containing cached data.

And this is only affecting subpage btrfs, because for regular blocksize
== page size case, the function pagecache_isize_extended() will do
nothing if the block size >= page size.

[FIX]
Grab the old i_size while holding the inode lock.
This means each buffered write thread will have a stable view of the
old inode size, thus avoid the above race.

CC: stable@vger.kernel.org # 5.15+
Fixes: 5e8b9ef30392 ("btrfs: move pos increment and pagecache extension to btrfs_buffered_write")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ed3c0d6546c5..0b568c8d24cb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1090,7 +1090,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	u64 lockend;
 	size_t num_written = 0;
 	ssize_t ret;
-	loff_t old_isize = i_size_read(inode);
+	loff_t old_isize;
 	unsigned int ilock_flags = 0;
 	const bool nowait = (iocb->ki_flags & IOCB_NOWAIT);
 	unsigned int bdp_flags = (nowait ? BDP_ASYNC : 0);
@@ -1103,6 +1103,13 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * We can only trust the isize with inode lock held, or it can race with
+	 * other buffered writes and cause incorrect call of
+	 * pagecache_isize_extended() to overwrite existing data.
+	 */
+	old_isize = i_size_read(inode);
+
 	ret = generic_write_checks(iocb, i);
 	if (ret <= 0)
 		goto out;


