Return-Path: <stable+bounces-16107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4183F055
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 22:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6BE283D0B
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A281B7FA;
	Sat, 27 Jan 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uZ/sGpco"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E533D5
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392687; cv=none; b=GAmKPjQSwaLfV5KYf8HhMSqC5R3/B/JdRrl+haC7pFOGOPpW58YFJmrb273wFD++yt2N+AY53xZF/MJMx+28N9QkZAEskY/Q5O4QqJgXBZ8NWntbjrBazpP+3b23UXnBlh1EToq8Nstv/OLVOV58hnzPsE9iApXMdXfBC0g6tWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392687; c=relaxed/simple;
	bh=VKaCrqYlA4WXOWyZ2s4AxAKqf+TS9Tjkc63dwoA15Qs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ITtIhtLqHn1UMFPosBpKR315VuB6ptRMDioCfOwSu/0X2vgrAVJb2ihoyxQ3pDwbh2m7WZOz3MDtunM3406orO0iYD23XPesO4vKUWHCs2sln3MujYzNuWg6RU/kj2TEfCXJKNUzcLS3h54IRDpOasKESYfoiEOsX4MkyZn1tZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uZ/sGpco; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD935C433C7;
	Sat, 27 Jan 2024 21:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706392687;
	bh=VKaCrqYlA4WXOWyZ2s4AxAKqf+TS9Tjkc63dwoA15Qs=;
	h=Subject:To:Cc:From:Date:From;
	b=uZ/sGpcoWgsvQRALYnOuRMpHiI7e58Xl85WqGZ5J12tQ5Cr2Iw0i62IIcycgJlBRD
	 Bv8geNjGQ+gMRJaLlgdvd4lu0sRB+eabg2ClSTg1zQ3BsKNXh4HcSFNhu9IvJqyxs5
	 bvVYR20e7fxleOu0GXE8etuVsEbFCG5zMmyZlMYE=
Subject: FAILED: patch "[PATCH] btrfs: zoned: optimize hint byte for zoned allocator" failed to apply to 6.1-stable tree
To: naohiro.aota@wdc.com,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 13:58:05 -0800
Message-ID: <2024012705-replace-mumble-78cc@gregkh>
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
git cherry-pick -x 02444f2ac26eae6385a65fcd66915084d15dffba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012705-replace-mumble-78cc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

02444f2ac26e ("btrfs: zoned: optimize hint byte for zoned allocator")
b271fee9a41c ("btrfs: zoned: factor out prepare_allocation_zoned()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 02444f2ac26eae6385a65fcd66915084d15dffba Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Tue, 19 Dec 2023 01:02:29 +0900
Subject: [PATCH] btrfs: zoned: optimize hint byte for zoned allocator

Writing sequentially to a huge file on btrfs on a SMR HDD revealed a
decline of the performance (220 MiB/s to 30 MiB/s after 500 minutes).

The performance goes down because of increased latency of the extent
allocation, which is induced by a traversing of a lot of full block groups.

So, this patch optimizes the ffe_ctl->hint_byte by choosing a block group
with sufficient size from the active block group list, which does not
contain full block groups.

After applying the patch, the performance is maintained well.

Fixes: 2eda57089ea3 ("btrfs: zoned: implement sequential extent allocation")
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d260b970bec7..6d680031211a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4311,6 +4311,24 @@ static int prepare_allocation_zoned(struct btrfs_fs_info *fs_info,
 		if (fs_info->data_reloc_bg)
 			ffe_ctl->hint_byte = fs_info->data_reloc_bg;
 		spin_unlock(&fs_info->relocation_bg_lock);
+	} else if (ffe_ctl->flags & BTRFS_BLOCK_GROUP_DATA) {
+		struct btrfs_block_group *block_group;
+
+		spin_lock(&fs_info->zone_active_bgs_lock);
+		list_for_each_entry(block_group, &fs_info->zone_active_bgs, active_bg_list) {
+			/*
+			 * No lock is OK here because avail is monotinically
+			 * decreasing, and this is just a hint.
+			 */
+			u64 avail = block_group->zone_capacity - block_group->alloc_offset;
+
+			if (block_group_bits(block_group, ffe_ctl->flags) &&
+			    avail >= ffe_ctl->num_bytes) {
+				ffe_ctl->hint_byte = block_group->start;
+				break;
+			}
+		}
+		spin_unlock(&fs_info->zone_active_bgs_lock);
 	}
 
 	return 0;


