Return-Path: <stable+bounces-106262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076819FE3C6
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176B43A1FCE
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93641A2391;
	Mon, 30 Dec 2024 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bALRQIIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792A1A0B06
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547949; cv=none; b=QAXVysBlMfxQI8vg8y0+rvuhXHTWn0iEeXq0mcl7S/UIqOGJpjzgDA4O8JNkVyQZQnhbVfPj0McvaH/ePv6LHqbYHGjYc6HLO497CZEahKqEuuUwLkJnJnNO9TIpiEsjBvedy5Sr/3AGd+Z6csk+GTmWRpG+zEFC5wjMuFHckbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547949; c=relaxed/simple;
	bh=e/+DLy3e+QUYy9hhmDcKduwZ1yg6c4ciYoRu/F3OFOU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yw9/GswlRzBMpcZ0rnRFlMYtGEkiuqm5l44412t2E+8jZ7dL1JV7Kwdplvj5rjDGdUODi39Iq+qbIcRqH78O1HJ7QWh4TEi+Mv4RN/UVvCzi2Ees87r2T0alXaI1RN7+Z/iFoLQrONcr81tXTtcP+r3dPliB82218U1O69jySt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bALRQIIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107D0C4CEDC;
	Mon, 30 Dec 2024 08:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547949;
	bh=e/+DLy3e+QUYy9hhmDcKduwZ1yg6c4ciYoRu/F3OFOU=;
	h=Subject:To:Cc:From:Date:From;
	b=bALRQIIFbut1nxpcRp8073tcaqilWfdEEyacCY8plSDz5LKFWPJnxuWxPg6lW1fAy
	 +GmiWKME9Au21j5TrWqxYQVsa4UCqa/Z/jlIyrRVhSaXMMMpcTih8ZHNLq6LooQClD
	 ft9WjdX4oM39X1sUDOg1xxJsQUEdV3pWSNLHxVxE=
Subject: FAILED: patch "[PATCH] btrfs: sysfs: fix direct super block member reads" failed to apply to 5.10-stable tree
To: wqu@suse.com,dsterba@suse.com,johannes.thumshirn@wdc.com,naohiro.aota@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:39:04 +0100
Message-ID: <2024123004-opt-riot-9e91@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fca432e73db2bec0fdbfbf6d98d3ebcd5388a977
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123004-opt-riot-9e91@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fca432e73db2bec0fdbfbf6d98d3ebcd5388a977 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 18 Dec 2024 17:00:56 +1030
Subject: [PATCH] btrfs: sysfs: fix direct super block member reads

The following sysfs entries are reading super block member directly,
which can have a different endian and cause wrong values:

- sys/fs/btrfs/<uuid>/nodesize
- sys/fs/btrfs/<uuid>/sectorsize
- sys/fs/btrfs/<uuid>/clone_alignment

Thankfully those values (nodesize and sectorsize) are always aligned
inside the btrfs_super_block, so it won't trigger unaligned read errors,
just endian problems.

Fix them by using the native cached members instead.

Fixes: df93589a1737 ("btrfs: export more from FS_INFO to sysfs")
CC: stable@vger.kernel.org
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index fdcbf650ac31..7f09b6c9cc2d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1118,7 +1118,7 @@ static ssize_t btrfs_nodesize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->nodesize);
+	return sysfs_emit(buf, "%u\n", fs_info->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -1128,7 +1128,7 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -1180,7 +1180,7 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);


