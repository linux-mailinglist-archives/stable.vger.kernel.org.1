Return-Path: <stable+bounces-170001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0AB29FCA
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023212A2A5C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE2830FF38;
	Mon, 18 Aug 2025 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/sAjRIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212A261B7D
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514596; cv=none; b=SPPixGTyiwY2iiIgfw9ooNW6Bam9LQe9B3DpSKf8/+LvfyIWsIZ7BkyERLXCqPok9+F+8BLBSxvhPUyvD/TjXJXbvgDHOapohPKxgRMnwQCpD4JboY7lwNNoNzZDwZU75QzYIkGpyH/e8l9i1bwh0cw57bRMGibpteqdPcs66ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514596; c=relaxed/simple;
	bh=bU8q2I7F8j/ioMN88E8WI8X71q9u2OZ8ayAzlRRfgls=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eP1J08iTBh79crzIQn0BpXEl+Fk2xd/Cp5oSnH2jXB4iXE+u5lvT6PwpOw9ZjwvaIkz2A7lBFjaaFknVH5qFODIIWrlpcJQ/RCJnj/C18ZaEwu2jCwj1HbQl9f+VQd2l3i/XdRIHGH1NRkQ1PZ76NDqkmlgQc/Aw0eeY/4bsV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/sAjRIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D1EC4CEEB;
	Mon, 18 Aug 2025 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755514596;
	bh=bU8q2I7F8j/ioMN88E8WI8X71q9u2OZ8ayAzlRRfgls=;
	h=Subject:To:Cc:From:Date:From;
	b=e/sAjRIQZ+kdJoRpStp4bqy1oRslqQ+ywSq9lJreX9WzCW2R//+54VeBSDYutkGO8
	 NTFTpy/g/kORcsi4Fo+9krLcrG1KWlBC2cpfUjiWaT+6jealFHIYnc/u+ndCjQo1iQ
	 R81x3vrv3VejtTURUn8L+wY86zv3t70hByM/Kn4c=
Subject: FAILED: patch "[PATCH] btrfs: zoned: requeue to unused block group list if zone" failed to apply to 6.12-stable tree
To: naohiro.aota@wdc.com,dsterba@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:55:53 +0200
Message-ID: <2025081853-parrot-skeleton-78e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 62be7afcc13b2727bdc6a4c91aefed6b452e6ecc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081853-parrot-skeleton-78e1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62be7afcc13b2727bdc6a4c91aefed6b452e6ecc Mon Sep 17 00:00:00 2001
From: Naohiro Aota <naohiro.aota@wdc.com>
Date: Sun, 29 Jun 2025 23:18:29 +0900
Subject: [PATCH] btrfs: zoned: requeue to unused block group list if zone
 finish failed

btrfs_zone_finish() can fail for several reason. If it is -EAGAIN, we need
to try it again later. So, put the block group to the retry list properly.

Failing to do so will keep the removable block group intact until remount
and can causes unnecessary ENOSPC.

Fixes: 74e91b12b115 ("btrfs: zoned: zone finish unused block group")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3ddf9fe52b9d..47c6d040176c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1639,8 +1639,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		ret = btrfs_zone_finish(block_group);
 		if (ret < 0) {
 			btrfs_dec_block_group_ro(block_group);
-			if (ret == -EAGAIN)
+			if (ret == -EAGAIN) {
+				btrfs_link_bg_list(block_group, &retry_list);
 				ret = 0;
+			}
 			goto next;
 		}
 


