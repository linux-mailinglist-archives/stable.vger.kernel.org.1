Return-Path: <stable+bounces-50499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B037906A84
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9286284DF5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18214265C;
	Thu, 13 Jun 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9lQrt9C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F914262B
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276170; cv=none; b=X+43bSx52EQXbL1OyhvT1PM+rdxIdJEqpm8ilffvfoKf4fgF+vmFNhPMaXHIbnvTAJ2uo/YzXbF3ITPyLcT8oZEfGLDk2VkfMHqN+yDxsYCQZQk9jR0vL/ZhwJM3Zmhu9oSPSV4QUIasZrIxviN0wEQkDoQfBvaBmI9Y9BjcZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276170; c=relaxed/simple;
	bh=bBSIq9KAVpDHLkBXWT+BAAJhv9YMI7eZGW281W2J5OQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rn6isy6LTW29yg0DFQs3W+KcdHBbTEAR8cQuYeJpOO6D/Q5lmK1N2cfBuEw/RhNxyY0H1uilnTQimI51G8g0I7/zw31w3/ixc7ve4Ae4BkfcbEQIOE3e6dBwvBWcoSqOTw0Z5UchVH2mtGJVgXuszT1skGwA8XvXcU4Bi7BSeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d9lQrt9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39C7C32786;
	Thu, 13 Jun 2024 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718276170;
	bh=bBSIq9KAVpDHLkBXWT+BAAJhv9YMI7eZGW281W2J5OQ=;
	h=Subject:To:Cc:From:Date:From;
	b=d9lQrt9Cbi7/qf6jFaaOYoRE03LU5wz1VM+L/981+iD3es2cRFUJUAHoVfwcCvVOj
	 TfZnfSVf+6suVDH/XQAtEetZCX8dVuUr8J7oc3vZuC6a6Yb9MDr62EEgps3zhxefds
	 hv0LF7nhajN4HXJt4COVBi9/1UpYZrsHd488D3hU=
Subject: FAILED: patch "[PATCH] btrfs: qgroup: update rescan message levels and error codes" failed to apply to 6.6-stable tree
To: dsterba@suse.com,boris@bur.io
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 12:56:07 +0200
Message-ID: <2024061307-gab-underfoot-f7db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1fa7603d569b9e738e9581937ba8725cd7d39b48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061307-gab-underfoot-f7db@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

1fa7603d569b ("btrfs: qgroup: update rescan message levels and error codes")
182940f4f4db ("btrfs: qgroup: add new quota mode for simple quotas")
6b0cd63bc75c ("btrfs: qgroup: introduce quota mode")
515020900d44 ("btrfs: read raid stripe tree from disk")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1fa7603d569b9e738e9581937ba8725cd7d39b48 Mon Sep 17 00:00:00 2001
From: David Sterba <dsterba@suse.com>
Date: Thu, 2 May 2024 22:45:58 +0200
Subject: [PATCH] btrfs: qgroup: update rescan message levels and error codes

On filesystems without enabled quotas there's still a warning message in
the logs when rescan is called. In that case it's not a problem that
should be reported, rescan can be called unconditionally.  Change the
error code to ENOTCONN which is used for 'quotas not enabled' elsewhere.

Remove message (also a warning) when rescan is called during an ongoing
rescan, this brings no useful information and the error code is
sufficient.

Change message levels to debug for now, they can be removed eventually.

CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index eb28141d5c37..f93354a96909 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3820,14 +3820,14 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		/* we're resuming qgroup rescan at mount time */
 		if (!(fs_info->qgroup_flags &
 		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
-			btrfs_warn(fs_info,
+			btrfs_debug(fs_info,
 			"qgroup rescan init failed, qgroup rescan is not queued");
 			ret = -EINVAL;
 		} else if (!(fs_info->qgroup_flags &
 			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
-			btrfs_warn(fs_info,
+			btrfs_debug(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
-			ret = -EINVAL;
+			ret = -ENOTCONN;
 		}
 
 		if (ret)
@@ -3838,14 +3838,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 
 	if (init_flags) {
 		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
-			btrfs_warn(fs_info,
-				   "qgroup rescan is already in progress");
 			ret = -EINPROGRESS;
 		} else if (!(fs_info->qgroup_flags &
 			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
-			btrfs_warn(fs_info,
+			btrfs_debug(fs_info,
 			"qgroup rescan init failed, qgroup is not enabled");
-			ret = -EINVAL;
+			ret = -ENOTCONN;
 		} else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
 			/* Quota disable is in progress */
 			ret = -EBUSY;


