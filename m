Return-Path: <stable+bounces-62376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F34F593EEF7
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3D22834BB
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B257A126F2A;
	Mon, 29 Jul 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eb9H6K+Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14812D1FA
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239368; cv=none; b=D60RiIwCNyeeI+cez8P7HOg8OSUmf42ybkc0PLHDH69QN9vsZNGrPQkt7emSr32ShWOZSLiCdVdokFK2SSmj8DwVUP+ZwZl0YejDm0RQ2AbYLX33Cq3P1YcLgVxJgP6NgSjcTzd5ZyjXoUsEhCwg4l/60xrXcjoGxpheQHNaLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239368; c=relaxed/simple;
	bh=PqUXEmUWLvn27sQjOw/odBpraYTGv/ejI8sZIrCIwKU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hME0IGuS0FBshswoQkTYR6gWyFLC3lBv0nA9TY0SfzAaFZf+IKMBjIFVwen1gjq2fDr2iQvEB+Ej+IFjNMmsC8xjXviC0JsxRoI6l19MeFgZQRuqoP3Y7WUfjn2qIgvpSs642O5xd7weomyWNq6d/wG31Z+uPbMiA1ILMEObwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eb9H6K+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9713CC4AF0A;
	Mon, 29 Jul 2024 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239368;
	bh=PqUXEmUWLvn27sQjOw/odBpraYTGv/ejI8sZIrCIwKU=;
	h=Subject:To:Cc:From:Date:From;
	b=Eb9H6K+Y5xxRBc+ec9tNufhXpYnUU+ceMtPbeJ/LVtjMk/CgVF14Uc6bRxE/ChNZC
	 Y6vWzYcV32E+ffwwDvJgQEN0ltZugGOgqGd8HJI4T2F/fHAyS0wini5T0VHk3Eg+LN
	 YWNNRMqpTuw5nlzh9XAgN6WpN7Emmms5r0zIpdhs=
Subject: FAILED: patch "[PATCH] btrfs: fix extent map use-after-free when adding pages to" failed to apply to 6.1-stable tree
To: fdmanana@suse.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:49:24 +0200
Message-ID: <2024072924-overact-drainable-8abb@gregkh>
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
git cherry-pick -x 8e7860543a94784d744c7ce34b78a2e11beefa5c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072924-overact-drainable-8abb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

8e7860543a94 ("btrfs: fix extent map use-after-free when adding pages to compressed bio")
b7d463a1d125 ("btrfs: store a pointer to the original btrfs_bio in struct compressed_bio")
690834e47cf7 ("btrfs: pass a btrfs_bio to btrfs_submit_compressed_read")
7edb9a3e7200 ("btrfs: move zero filling of compressed read bios into common code")
32586c5bca72 ("btrfs: factor out a btrfs_free_compressed_pages helper")
10e924bc320a ("btrfs: factor out a btrfs_add_compressed_bio_pages helper")
d7294e4deeb9 ("btrfs: use the bbio file offset in add_ra_bio_pages")
e7aff33e3161 ("btrfs: use the bbio file offset in btrfs_submit_compressed_read")
798c9fc74d03 ("btrfs: remove redundant free_extent_map in btrfs_submit_compressed_read")
544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")
35a8d7da3ca8 ("btrfs: remove now spurious bio submission helpers")
285599b6fe15 ("btrfs: remove the fs_info argument to btrfs_submit_bio")
48253076c3a9 ("btrfs: open code submit_encoded_read_bio")
30493ff49f81 ("btrfs: remove stripe boundary calculation for compressed I/O")
2380220e1e13 ("btrfs: remove stripe boundary calculation for buffered I/O")
67d669825090 ("btrfs: pass the iomap bio to btrfs_submit_bio")
852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
69ccf3f4244a ("btrfs: handle recording of zoned writes in the storage layer")
f8a53bb58ec7 ("btrfs: handle checksum generation in the storage layer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e7860543a94784d744c7ce34b78a2e11beefa5c Mon Sep 17 00:00:00 2001
From: Filipe Manana <fdmanana@suse.com>
Date: Thu, 4 Jul 2024 16:11:20 +0100
Subject: [PATCH] btrfs: fix extent map use-after-free when adding pages to
 compressed bio

At add_ra_bio_pages() we are accessing the extent map to calculate
'add_size' after we dropped our reference on the extent map, resulting
in a use-after-free. Fix this by computing 'add_size' before dropping our
extent map reference.

Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000038144061c6d18f2@google.com/
Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index a149f3659b15..a8e2c461aff7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -515,6 +515,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			put_page(page);
 			break;
 		}
+		add_size = min(em->start + em->len, page_end + 1) - cur;
 		free_extent_map(em);
 
 		if (page->index == end_index) {
@@ -527,7 +528,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			}
 		}
 
-		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
 			unlock_extent(tree, cur, page_end, NULL);


