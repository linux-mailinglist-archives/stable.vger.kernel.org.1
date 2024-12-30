Return-Path: <stable+bounces-106263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1D49FE3C7
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 09:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414643A210A
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3BE1A0B15;
	Mon, 30 Dec 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6wmMeA2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F51A0B06
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735547952; cv=none; b=L/QU0NvDSHL7Ry3+0npwixYFYxZ62y8H3MMemAZDBx+OTA2kq6QyZp8IIWIZLgSVfxRowhAArrgILYHs/aiwnCwZmfVFIx5E62tvPw4gW9YGi4n3uDd0oIuipSZFBIbNOGWZaJyq9m2uuBpHHWrNuEMS837zxKTKQi5UwEDrBao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735547952; c=relaxed/simple;
	bh=yGwKhvNInKl0DXeVyrVVI1EYTQNhUNiVKB5QEHBIcrM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=p/428geMG3AUNJsXGO3kdoEQqN5uc8ctE+Il+nw8Ozyw6BZYWvgqqaKEpN53gfm4sBd2LQzA/K56P95W6TX+6dppgTJRtAOPTUQY1wmKf4pivakvOZrrc/4ihPOmRGW7/YeoGkJYgIb3Y0jw5089eMZiovOHC2ujVlAK/Vwb1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6wmMeA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A23EC4CED0;
	Mon, 30 Dec 2024 08:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735547952;
	bh=yGwKhvNInKl0DXeVyrVVI1EYTQNhUNiVKB5QEHBIcrM=;
	h=Subject:To:Cc:From:Date:From;
	b=N6wmMeA2xwIayhwp7ejW7ldVdZJKqsgTNnXSiQb/Kla2vgo3uFBPSma38jcDw7J8v
	 Fe7MJuCLwXwSfd7T2aF6F/+IwZaCFKSN55K4PTRyCdkw/eizKw7HHy4Lyk/UEeh0M1
	 6FbEiYyG/6qQ/0tH4KuJ/AYClny79a9TbjvxqaTU=
Subject: FAILED: patch "[PATCH] btrfs: sysfs: fix direct super block member reads" failed to apply to 5.4-stable tree
To: wqu@suse.com,dsterba@suse.com,johannes.thumshirn@wdc.com,naohiro.aota@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Dec 2024 09:39:06 +0100
Message-ID: <2024123006-unhappy-grudge-df18@gregkh>
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
git cherry-pick -x fca432e73db2bec0fdbfbf6d98d3ebcd5388a977
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024123006-unhappy-grudge-df18@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


