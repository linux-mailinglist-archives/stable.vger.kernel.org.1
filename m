Return-Path: <stable+bounces-41664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C18B5688
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E54283DA2
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F343FB84;
	Mon, 29 Apr 2024 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kSSMiMi/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570523772
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390053; cv=none; b=RDs8KBuPAIo/QRjj9UfBBX5ZuDEp58IeO7KPB+VOESVSjBSaPwEpDLCqPv+Qe3wBTewWWItfL0uRg4aLjwwbh/u//QY95E2JzzBUn7OMKgXfzWBVe/kJfFKlkdmx3CHizH6n5T7rCzKY/VLLrU7mgmyzwBca+Tmau2sQvclgEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390053; c=relaxed/simple;
	bh=p/3h91v1M8cFflg3qNpP5nYGbnDFYkY2BLCGwwdCElk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S0cRViIUMWBlbr9N2pMiGTt8AsiX+W8LRKgNPsmhwO9c0FJkybTRY/TFafUcw7notvYb//imkUxLxEQpbgJYPZrE/Yk6PDJu+/eJ/bdvqVG3WX0f4fZybRCpfVBNozlQH0GTksAeIMV3o4U8czJBBcJvFtJsEgE8ZH78tyW5v1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kSSMiMi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1628C113CD;
	Mon, 29 Apr 2024 11:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714390053;
	bh=p/3h91v1M8cFflg3qNpP5nYGbnDFYkY2BLCGwwdCElk=;
	h=Subject:To:Cc:From:Date:From;
	b=kSSMiMi/mfSU9ntQOnqqz91mJxonXXBVo5eMsmY4IWnsEgMC9lbpQU1jbMfRR0Ci5
	 Mnuvsy6cFO6P2P0503AgRud+ObFi5Uy/jS1zWZCvSwRoEHthEzfxtbOP5Hqw/y5Fes
	 yQE0Z+ejn9RYDBbloeBu1/oEJxBEziCYSmnNC3gk=
Subject: FAILED: patch "[PATCH] btrfs: fallback if compressed IO fails for ENOSPC" failed to apply to 6.1-stable tree
To: sweettea-kernel@dorminy.me,dsterba@suse.com,neal@gompa.dev,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Apr 2024 13:27:25 +0200
Message-ID: <2024042924-filling-contact-97aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 131a821a243f89be312ced9e62ccc37b2cf3846c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042924-filling-contact-97aa@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

131a821a243f ("btrfs: fallback if compressed IO fails for ENOSPC")
a994310aa26f ("btrfs: remove PAGE_SET_ERROR")
99a01bd6388e ("btrfs: use btrfs_inode inside compress_file_range")
99a81a444448 ("btrfs: switch async_chunk::inode to btrfs_inode")
fd8d2951f478 ("btrfs: convert extent_io page op defines to enum bits")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 131a821a243f89be312ced9e62ccc37b2cf3846c Mon Sep 17 00:00:00 2001
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Date: Sat, 6 Apr 2024 04:45:02 -0400
Subject: [PATCH] btrfs: fallback if compressed IO fails for ENOSPC

In commit b4ccace878f4 ("btrfs: refactor submit_compressed_extents()"), if
an async extent compressed but failed to find enough space, we changed
from falling back to an uncompressed write to just failing the write
altogether. The principle was that if there's not enough space to write
the compressed version of the data, there can't possibly be enough space
to write the larger, uncompressed version of the data.

However, this isn't necessarily true: due to fragmentation, there could
be enough discontiguous free blocks to write the uncompressed version,
but not enough contiguous free blocks to write the smaller but
unsplittable compressed version.

This has occurred to an internal workload which relied on write()'s
return value indicating there was space. While rare, it has happened a
few times.

Thus, in order to prevent early ENOSPC, re-add a fallback to
uncompressed writing.

Fixes: b4ccace878f4 ("btrfs: refactor submit_compressed_extents()")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Co-developed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c65fe5de4022..7fed887e700c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1145,13 +1145,13 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 				   0, *alloc_hint, &ins, 1, 1);
 	if (ret) {
 		/*
-		 * Here we used to try again by going back to non-compressed
-		 * path for ENOSPC.  But we can't reserve space even for
-		 * compressed size, how could it work for uncompressed size
-		 * which requires larger size?  So here we directly go error
-		 * path.
+		 * We can't reserve contiguous space for the compressed size.
+		 * Unlikely, but it's possible that we could have enough
+		 * non-contiguous space for the uncompressed size instead.  So
+		 * fall back to uncompressed.
 		 */
-		goto out_free;
+		submit_uncompressed_range(inode, async_extent, locked_page);
+		goto done;
 	}
 
 	/* Here we're doing allocation and writeback of the compressed pages */
@@ -1203,7 +1203,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 out_free_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
-out_free:
 	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
 	extent_clear_unlock_delalloc(inode, start, end,
 				     NULL, EXTENT_LOCKED | EXTENT_DELALLOC |


