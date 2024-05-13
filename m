Return-Path: <stable+bounces-43652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FFC8C4209
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20811F238EC
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC41534F5;
	Mon, 13 May 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="py7w7kSq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C91482F9
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607409; cv=none; b=qzvk6G0Z5KYLaV6P3H36yBk98sxBMZKZBwIhfHz2FI7cPLjRc8btYsmvmMyuyr7rZy/3kUYJDJq/Z+GqqOCsO+SSA/QG/wAQ9GSyNbjm9NW9VcppYPtosw1tllygbnxU+OyVyd21G9Yr2m0nt85uACfj/E57I7raMrN/0GeSFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607409; c=relaxed/simple;
	bh=ng/TpXK1O8QL9iAhDRIqedfBT/xxN3XiKod8+cXSFi4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F3eJJhDCfih7avDq8b/RMg7d5BN9TffH3FUTfoG4wXI4ro7O+TwLtKXXbHeidEPsO/udHWxNnkOh4ORazX9QeWaeWc9xV0h5zA50wLLTs4XVNupDSm39rQFvnKtIcsYBOrEZar6EF1KWaGYpIuuuoT/xLexu62dKm+dotxvs+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=py7w7kSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2606C32781;
	Mon, 13 May 2024 13:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715607409;
	bh=ng/TpXK1O8QL9iAhDRIqedfBT/xxN3XiKod8+cXSFi4=;
	h=Subject:To:Cc:From:Date:From;
	b=py7w7kSqfLyOgq3MP6TgTO5QbjJt+Au74/q5lV0peW1WdmiVlepKFzIO4cOt2tH4Y
	 QDAdXgjH8JL/7ooQ9eN7WIp5uqGbLk/Dj7Fxh+ruKB30lfl343tSJJ2pGP+rKZMiMe
	 h7UEQWhJMPxKOxj4YyK8KzrZ3jXaVyHYRsLoVrmg=
Subject: FAILED: patch "[PATCH] btrfs: add missing mutex_unlock in" failed to apply to 5.10-stable tree
To: dominique.martinet@atmark-techno.com,dsterba@suse.com,pavel@denx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:36:46 +0200
Message-ID: <2024051346-unvocal-magnetism-4ae1@gregkh>
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
git cherry-pick -x 9af503d91298c3f2945e73703f0e00995be08c30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051346-unvocal-magnetism-4ae1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

9af503d91298 ("btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()")
7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9af503d91298c3f2945e73703f0e00995be08c30 Mon Sep 17 00:00:00 2001
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
Date: Fri, 19 Apr 2024 11:22:48 +0900
Subject: [PATCH] btrfs: add missing mutex_unlock in
 btrfs_relocate_sys_chunks()

The previous patch that replaced BUG_ON by error handling forgot to
unlock the mutex in the error path.

Link: https://lore.kernel.org/all/Zh%2fHpAGFqa7YAFuM@duo.ucw.cz
Reported-by: Pavel Machek <pavel@denx.de>
Fixes: 7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()")
CC: stable@vger.kernel.org
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index dedec3d9b111..c72c351fe7eb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3419,6 +3419,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_fs_info *fs_info)
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->reclaim_bgs_lock);
 			goto error;
 		}
 


