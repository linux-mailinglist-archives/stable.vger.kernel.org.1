Return-Path: <stable+bounces-43647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C63AA8C41ED
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8346D2856EF
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD668153563;
	Mon, 13 May 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="asINo4Ns"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38415351A
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607003; cv=none; b=EzjN8c/tNxMlo+mhQK+TqH+kDHgM8u/l56573JTVcjsU8vvwcTokeQGZuXJrp3J31GylYj6+ujw/usJ0m+hrfIoXUERf9WiMsYji+IKUZ+Rn4VUw06X26XAx+j48l+suvJipI3RjlsIcrNdkkqp5TPJxipcmqx9Gw3wp8WiX2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607003; c=relaxed/simple;
	bh=j3WAIZu+QFQgEJpojBrMf3DSSJyULb3js9yApDXuGcw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XeKaL8WA6XJFPivwDlEcXuh4hdjCGdWwe/K3Z02v05jCuveBdGjzyMXdVIw/JAxx/YkIkSepJJMxOVGfuB6xi45fs+K+jOmnTqScRWKVr/huxht+Cpbfn1TVsyuT/gO+cnkG8x2c/WpMADyLM6SV/KQCokrRcckQI//y1eEUKhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=asINo4Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4542C113CC;
	Mon, 13 May 2024 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607003;
	bh=j3WAIZu+QFQgEJpojBrMf3DSSJyULb3js9yApDXuGcw=;
	h=Subject:To:Cc:From:Date:From;
	b=asINo4NsQ1KDlU+e2IK9gBolid4ZP3wd/nMsEQW4/ts56JSGnnOjBKt/U8LsvtoOf
	 UmLPekpsjntQbsEX/EIz2ylDXVu85itHMwyhOnvBN2wRvdtbhF9lArXlCOsjIxWgaw
	 Kq4pDT4gfIUf+WVbUsUO0d86tPfqG1C0THh4XYbc=
Subject: FAILED: patch "[PATCH] btrfs: set correct ram_bytes when splitting ordered extent" failed to apply to 5.15-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:28:56 +0200
Message-ID: <2024051356-giggling-footnote-3212@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 63a6ce5a1a6261e4c70bad2b55c4e0de8da4762e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051356-giggling-footnote-3212@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

63a6ce5a1a62 ("btrfs: set correct ram_bytes when splitting ordered extent")
52b1fdca23ac ("btrfs: handle completed ordered extents in btrfs_split_ordered_extent")
816f589b8d43 ("btrfs: atomically insert the new extent in btrfs_split_ordered_extent")
b0307e28642e ("btrfs: return the new ordered_extent from btrfs_split_ordered_extent")
ebdb44a00e25 ("btrfs: reorder conditions in btrfs_extract_ordered_extent")
f0f5329a00ba ("btrfs: don't split NOCOW extent_maps in btrfs_extract_ordered_extent")
7edd339c8a41 ("btrfs: pass an ordered_extent to btrfs_extract_ordered_extent")
2e38a84bc6ab ("btrfs: simplify extent map splitting and rename split_zoned_em")
f0792b792dbe ("btrfs: fold btrfs_clone_ordered_extent into btrfs_split_ordered_extent")
8f4af4b8e122 ("btrfs: sink parameter len to btrfs_split_ordered_extent")
11d33ab6c1f3 ("btrfs: simplify splitting logic in btrfs_extract_ordered_extent")
e44ca71cfe07 ("btrfs: move ordered_extent internal sanity checks into btrfs_split_ordered_extent")
2cef0c79bb81 ("btrfs: make btrfs_split_bio work on struct btrfs_bio")
ae42a154ca89 ("btrfs: pass a btrfs_bio to btrfs_submit_bio")
34f888ce3a35 ("btrfs: cleanup main loop in btrfs_encoded_read_regular_fill_pages")
10e924bc320a ("btrfs: factor out a btrfs_add_compressed_bio_pages helper")
e7aff33e3161 ("btrfs: use the bbio file offset in btrfs_submit_compressed_read")
798c9fc74d03 ("btrfs: remove redundant free_extent_map in btrfs_submit_compressed_read")
544fe4a903ce ("btrfs: embed a btrfs_bio into struct compressed_bio")
d5e4377d5051 ("btrfs: split zone append bios in btrfs_submit_bio")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63a6ce5a1a6261e4c70bad2b55c4e0de8da4762e Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Tue, 16 Apr 2024 08:07:00 +0930
Subject: [PATCH] btrfs: set correct ram_bytes when splitting ordered extent

[BUG]
When running generic/287, the following file extent items can be
generated:

        item 16 key (258 EXTENT_DATA 2682880) itemoff 15305 itemsize 53
                generation 9 type 1 (regular)
                extent data disk byte 1378414592 nr 462848
                extent data offset 0 nr 462848 ram 2097152
                extent compression 0 (none)

Note that file extent item is not a compressed one, but its ram_bytes is
way larger than its disk_num_bytes.

According to btrfs on-disk scheme, ram_bytes should match disk_num_bytes
if it's not a compressed one.

[CAUSE]
Since commit b73a6fd1b1ef ("btrfs: split partial dio bios before
submit"), for partial dio writes, we would split the ordered extent.

However the function btrfs_split_ordered_extent() doesn't update the
ram_bytes even it has already shrunk the disk_num_bytes.

Originally the function btrfs_split_ordered_extent() is only introduced
for zoned devices in commit d22002fd37bd ("btrfs: zoned: split ordered
extent when bio is sent"), but later commit b73a6fd1b1ef ("btrfs: split
partial dio bios before submit") makes non-zoned btrfs affected.

Thankfully for un-compressed file extent, we do not really utilize the
ram_bytes member, thus it won't cause any real problem.

[FIX]
Also update btrfs_ordered_extent::ram_bytes inside
btrfs_split_ordered_extent().

Fixes: d22002fd37bd ("btrfs: zoned: split ordered extent when bio is sent")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index b749ba45da2b..c2a42bcde98e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1188,6 +1188,7 @@ struct btrfs_ordered_extent *btrfs_split_ordered_extent(
 	ordered->disk_bytenr += len;
 	ordered->num_bytes -= len;
 	ordered->disk_num_bytes -= len;
+	ordered->ram_bytes -= len;
 
 	if (test_bit(BTRFS_ORDERED_IO_DONE, &ordered->flags)) {
 		ASSERT(ordered->bytes_left == 0);


