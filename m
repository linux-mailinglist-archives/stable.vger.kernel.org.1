Return-Path: <stable+bounces-23633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2FF867133
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B275B1C21080
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC70200A0;
	Mon, 26 Feb 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+y4LovX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489D1F959
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942903; cv=none; b=N4X8J5W5TD77x9lVOAIYPzVC/ESmwyQAd5e1nltP5FzLM5gyiVKB32KKz2uNjCSH/A1As78e9/W3XdLl7QuY1Oq5Jc1EEFyhmYzF0CD8j6nQuFjGapYjBe4sOeqE+Lf7ALVSWJRM5dkf7pb75MexM36SXGCIUUw0EDYynYt2uIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942903; c=relaxed/simple;
	bh=MsO90I0HfQVBxGEJeqDwX399rKqR6aiM+DOpRo48t80=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qO6tyVABodQy4p+xx7H5upAA0Eo8gpVlJpXOw3yVaB60sjpiCcYURGpyFkzZMCYqn35adoSva/YsLiwvCBRyq4tMcE+uZqI1Ynjb03CJ2nfLU2D8UaCti1MANpufntw7LkL0O0eeQ2r+aovlB0GxW1XSgSUBO3Qnn1YVmnbI80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+y4LovX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF342C43390;
	Mon, 26 Feb 2024 10:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708942903;
	bh=MsO90I0HfQVBxGEJeqDwX399rKqR6aiM+DOpRo48t80=;
	h=Subject:To:Cc:From:Date:From;
	b=N+y4LovXWnNtDs3HLbminNcMgD3CYEaxykxWgkw515K+L2JWi+L6Nszsu0y4nZ4Sb
	 Lvc2zbt93WDrgA2pn3gpqI5jTkl1Relp95TsF1tbARgmMknKp8qIgoTI0P/1Pq/lK0
	 8dgRPlMveL57v1GRJAcTVTcMply+S6UfkpHdT9gY=
Subject: FAILED: patch "[PATCH] btrfs: defrag: avoid unnecessary defrag caused by incorrect" failed to apply to 6.1-stable tree
To: wqu@suse.com,boris@bur.io,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:21:40 +0100
Message-ID: <2024022640-deepness-manatee-1a30@gregkh>
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
git cherry-pick -x e42b9d8b9ea2672811285e6a7654887ff64d23f3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022640-deepness-manatee-1a30@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e42b9d8b9ea2 ("btrfs: defrag: avoid unnecessary defrag caused by incorrect extent size")
a6a01ca61f49 ("btrfs: move the file defrag code into defrag.c")
6e3df18ba7e8 ("btrfs: move the auto defrag code to defrag.c")
07e81dc94474 ("btrfs: move accessor helpers into accessors.h")
ad1ac5012c2b ("btrfs: move btrfs_map_token to accessors")
55e5cfd36da5 ("btrfs: remove fs_info::pending_changes and related code")
7966a6b5959b ("btrfs: move fs_info::flags enum to fs.h")
fc97a410bd78 ("btrfs: move mount option definitions to fs.h")
0d3a9cf8c306 ("btrfs: convert incompat and compat flag test helpers to macros")
ec8eb376e271 ("btrfs: move BTRFS_FS_STATE* definitions and helpers to fs.h")
9b569ea0be6f ("btrfs: move the printk helpers out of ctree.h")
e118578a8df7 ("btrfs: move assert helpers out of ctree.h")
c7f13d428ea1 ("btrfs: move fs wide helpers out of ctree.h")
63a7cb130718 ("btrfs: auto enable discard=async when possible")
7a66eda351ba ("btrfs: move the btrfs_verity_descriptor_item defs up in ctree.h")
956504a331a6 ("btrfs: move trans_handle_cachep out of ctree.h")
f1e5c6185ca1 ("btrfs: move flush related definitions to space-info.h")
ed4c491a3db2 ("btrfs: move BTRFS_MAX_MIRRORS into scrub.c")
4300c58f8090 ("btrfs: move btrfs on-disk definitions out of ctree.h")
d60d956eb41f ("btrfs: remove unused set/clear_pending_info helpers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e42b9d8b9ea2672811285e6a7654887ff64d23f3 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 7 Feb 2024 10:00:42 +1030
Subject: [PATCH] btrfs: defrag: avoid unnecessary defrag caused by incorrect
 extent size

[BUG]
With the following file extent layout, defrag would do unnecessary IO
and result more on-disk space usage.

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # xfs_io -f -c "pwrite 0 40m" $mnt/foobar
  # sync
  # xfs_io -f -c "pwrite 40m 16k" $mnt/foobar
  # sync

Above command would lead to the following file extent layout:

        item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
                generation 7 type 1 (regular)
                extent data disk byte 298844160 nr 41943040
                extent data offset 0 nr 41943040 ram 41943040
                extent compression 0 (none)
        item 7 key (257 EXTENT_DATA 41943040) itemoff 15763 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 13631488 nr 16384
                extent data offset 0 nr 16384 ram 16384
                extent compression 0 (none)

Which is mostly fine. We can allow the final 16K to be merged with the
previous 40M, but it's upon the end users' preference.

But if we defrag the file using the default parameters, it would result
worse file layout:

 # btrfs filesystem defrag $mnt/foobar
 # sync

        item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
                generation 7 type 1 (regular)
                extent data disk byte 298844160 nr 41943040
                extent data offset 0 nr 8650752 ram 41943040
                extent compression 0 (none)
        item 7 key (257 EXTENT_DATA 8650752) itemoff 15763 itemsize 53
                generation 9 type 1 (regular)
                extent data disk byte 340787200 nr 33292288
                extent data offset 0 nr 33292288 ram 33292288
                extent compression 0 (none)
        item 8 key (257 EXTENT_DATA 41943040) itemoff 15710 itemsize 53
                generation 8 type 1 (regular)
                extent data disk byte 13631488 nr 16384
                extent data offset 0 nr 16384 ram 16384
                extent compression 0 (none)

Note the original 40M extent is still there, but a new 32M extent is
created for no benefit at all.

[CAUSE]
There is an existing check to make sure we won't defrag a large enough
extent (the threshold is by default 32M).

But the check is using the length to the end of the extent:

	range_len = em->len - (cur - em->start);

	/* Skip too large extent */
	if (range_len >= extent_thresh)
		goto next;

This means, for the first 8MiB of the extent, the range_len is always
smaller than the default threshold, and would not be defragged.
But after the first 8MiB, the remaining part would fit the requirement,
and be defragged.

Such different behavior inside the same extent caused the above problem,
and we should avoid different defrag decision inside the same extent.

[FIX]
Instead of using @range_len, just use @em->len, so that we have a
consistent decision among the same file extent.

Now with this fix, we won't touch the extent, thus not making it any
worse.

Reported-by: Filipe Manana <fdmanana@suse.com>
Fixes: 0cb5950f3f3b ("btrfs: fix deadlock when reserving space during defrag")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index c276b136ab63..5b0b64571418 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1046,7 +1046,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			goto add;
 
 		/* Skip too large extent */
-		if (range_len >= extent_thresh)
+		if (em->len >= extent_thresh)
 			goto next;
 
 		/*


