Return-Path: <stable+bounces-7612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C9817357
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF3BAB23548
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19B3787B;
	Mon, 18 Dec 2023 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SzAZj8KB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71041D148;
	Mon, 18 Dec 2023 14:15:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A368C433C7;
	Mon, 18 Dec 2023 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908934;
	bh=ZceK/LYpt7eg1DUTZH+1kPQ3Rrzzm0fLzGxjYEK/kPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SzAZj8KBoB1kbZq946OzY+0Ptz0U51XLVJawSLfz6q0nSeeEW7c/yaG3gnhmWLZ4u
	 BzIMVsI17BxZSJIbEpLPbIMA653BEFHy8lTnB+DOdl1E3q4LvK2MXiUH5T1SRzmyy2
	 VPtS3oU4GJq6H5CYU9lkfW/w1+WTicySGHknCcYU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Michaelis <code@mgjm.de>,
	Neal Gompa <neal@gompa.dev>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 63/83] btrfs: do not allow non subvolume root targets for snapshot
Date: Mon, 18 Dec 2023 14:52:24 +0100
Message-ID: <20231218135052.505523359@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <josef@toxicpanda.com>

commit a8892fd71933126ebae3d60aec5918d4dceaae76 upstream.

Our btrfs subvolume snapshot <source> <destination> utility enforces
that <source> is the root of the subvolume, however this isn't enforced
in the kernel.  Update the kernel to also enforce this limitation to
avoid problems with other users of this ioctl that don't have the
appropriate checks in place.

Reported-by: Martin Michaelis <code@mgjm.de>
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1855,6 +1855,15 @@ static noinline int __btrfs_ioctl_snap_c
 			 * are limited to own subvolumes only
 			 */
 			ret = -EPERM;
+		} else if (btrfs_ino(BTRFS_I(src_inode)) != BTRFS_FIRST_FREE_OBJECTID) {
+			/*
+			 * Snapshots must be made with the src_inode referring
+			 * to the subvolume inode, otherwise the permission
+			 * checking above is useless because we may have
+			 * permission on a lower directory but not the subvol
+			 * itself.
+			 */
+			ret = -EINVAL;
 		} else {
 			ret = btrfs_mksnapshot(&file->f_path, mnt_userns,
 					       name, namelen,



