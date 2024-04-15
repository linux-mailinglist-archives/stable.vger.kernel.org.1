Return-Path: <stable+bounces-39420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45098A4F18
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9BE283D9A
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF13EEBB;
	Mon, 15 Apr 2024 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MycRRC6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF914502E
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184479; cv=none; b=UJeYpkw6tjlzIPjJF3E2oV9FPwOUQjos1o/LANKHfVfRDjVsLwyqivrysaoNgNk7wlkVrvuAkWlJ7ChuRH+V4cycUkeWFeCxdDMoshg6C8Sq3Un2KErItXV9YcWbHiCh6udmsrkiuIueImOcEF174fXtv+WhZYyuuXSRrtigj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184479; c=relaxed/simple;
	bh=a5mMxmyPs6MzpFp8GWuDZLKYeNxMUnIe1bvJaIX5vHA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=b9fp3+vos0nhiv+lhPM3g7VrSIa8tlN0mg5pGYZn27FDCE1rZ8aO2a2fN1Z88kSroel3a4i4nS/xVk/JSQLP9ge+GuIxmo2P2SA+vxLEX2zFgQXQh+KPQs6660a+EOjJiQmsSaTGC89+p7NCfq18IR2B/cjPeRXGZiW8a19NhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MycRRC6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BFDC113CC;
	Mon, 15 Apr 2024 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713184477;
	bh=a5mMxmyPs6MzpFp8GWuDZLKYeNxMUnIe1bvJaIX5vHA=;
	h=Subject:To:Cc:From:Date:From;
	b=MycRRC6QFSgddh1QVWN50PELXcyAjH5slUuZkMlRbBWPDho8wwwNZFhWcrOZ5M4Ar
	 +ab3L8FUgB8EE9egvtn/5gExdvPRiiQQHEODLHqzyvBBf6EFeMeW7Wp2hlFMOruQFU
	 YLRx9BTSdyLizWD3Xn9VVKBZHWTIoUbdJKSaj7No=
Subject: FAILED: patch "[PATCH] btrfs: qgroup: correctly model root qgroup rsv in convert" failed to apply to 4.19-stable tree
To: boris@bur.io,dsterba@suse.com,wqu@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Apr 2024 14:34:34 +0200
Message-ID: <2024041534-compel-iguana-50ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 141fb8cd206ace23c02cd2791c6da52c1d77d42a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041534-compel-iguana-50ce@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

141fb8cd206a ("btrfs: qgroup: correctly model root qgroup rsv in convert")
4fd786e6c3d6 ("btrfs: Remove 'objectid' member from struct btrfs_root")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 141fb8cd206ace23c02cd2791c6da52c1d77d42a Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Tue, 19 Mar 2024 10:54:22 -0700
Subject: [PATCH] btrfs: qgroup: correctly model root qgroup rsv in convert

We use add_root_meta_rsv and sub_root_meta_rsv to track prealloc and
pertrans reservations for subvolumes when quotas are enabled. The
convert function does not properly increment pertrans after decrementing
prealloc, so the count is not accurate.

Note: we check that the fs is not read-only to mirror the logic in
qgroup_convert_meta, which checks that before adding to the pertrans rsv.

Fixes: 8287475a2055 ("btrfs: qgroup: Use root::qgroup_meta_rsv_* to record qgroup meta reserved space")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5f90f0605b12..cf8820ce7aa2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4495,6 +4495,8 @@ void btrfs_qgroup_convert_reserved_meta(struct btrfs_root *root, int num_bytes)
 				      BTRFS_QGROUP_RSV_META_PREALLOC);
 	trace_qgroup_meta_convert(root, num_bytes);
 	qgroup_convert_meta(fs_info, root->root_key.objectid, num_bytes);
+	if (!sb_rdonly(fs_info->sb))
+		add_root_meta_rsv(root, num_bytes, BTRFS_QGROUP_RSV_META_PERTRANS);
 }
 
 /*


