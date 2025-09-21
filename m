Return-Path: <stable+bounces-180769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67DFB8DAD7
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A743B1D8D
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52B223DD6;
	Sun, 21 Sep 2025 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a4dYWWB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7EC192B66
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457539; cv=none; b=Ag7mjLUYV/JF5POfunAiX0qKgPeZY3d6FJibB8uvMwG+5PsbXop9Syztac5rOhhNY38c278UF1yTz3EAhHBc844nC/HDdQ9QN2QPBIkrlCHGVvPAPYONk7ul3aADSmHMe4oepGRz3ML90WuPa+lNvDcHgyhYvp8eo6neZlejCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457539; c=relaxed/simple;
	bh=kzdY9O6JuabUy5wnID04/Kr+Y6jbtvv4A7AXmLRTEjQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IYXbpG42KzBf9Sqag6HREDmd7FXtpoylS1q4ociOF7TO8lvC9VrItvnRKcdF6tn9FKpBxhDGFeWuBpLmhMGzSxVW/9fJhoG6Skx/x3qvonh/IGAHi4ODlj7aLKk0qZuIonX2G3/BX8MeNxhmYQH1hYhwLNxCzSacZtEebk0X3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a4dYWWB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAE8C4CEE7;
	Sun, 21 Sep 2025 12:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457537;
	bh=kzdY9O6JuabUy5wnID04/Kr+Y6jbtvv4A7AXmLRTEjQ=;
	h=Subject:To:Cc:From:Date:From;
	b=a4dYWWB6ImUh0fZJZNmP3dkSKO3lcwgXAV627R/SefzNhN5+xLWIw7Bc0xn360j5Z
	 OlTxyGtQ7X33G/LE5PdLRn6P/XNz0uY+YSU5NdYE5Jda/MLvwKJEJYI6v4h3JG5AbL
	 rknmm9f3z9HhxPvZd6b568iVLQIjQE8GsE2nF088=
Subject: FAILED: patch "[PATCH] btrfs: tree-checker: fix the incorrect inode ref size check" failed to apply to 5.10-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:25:35 +0200
Message-ID: <2025092135-stinky-correct-5051@gregkh>
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
git cherry-pick -x 96fa515e70f3e4b98685ef8cac9d737fc62f10e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092135-stinky-correct-5051@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 96fa515e70f3e4b98685ef8cac9d737fc62f10e1 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Tue, 16 Sep 2025 07:54:06 +0930
Subject: [PATCH] btrfs: tree-checker: fix the incorrect inode ref size check

[BUG]
Inside check_inode_ref(), we need to make sure every structure,
including the btrfs_inode_extref header, is covered by the item.  But
our code is incorrectly using "sizeof(iref)", where @iref is just a
pointer.

This means "sizeof(iref)" will always be "sizeof(void *)", which is much
smaller than "sizeof(struct btrfs_inode_extref)".

This will allow some bad inode extrefs to sneak in, defeating tree-checker.

[FIX]
Fix the typo by calling "sizeof(*iref)", which is the same as
"sizeof(struct btrfs_inode_extref)", and will be the correct behavior we
want.

Fixes: 71bf92a9b877 ("btrfs: tree-checker: Add check for INODE_REF")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 0f556f4de3f9..a997c7cc35a2 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1756,10 +1756,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	while (ptr < end) {
 		u16 namelen;
 
-		if (unlikely(ptr + sizeof(iref) > end)) {
+		if (unlikely(ptr + sizeof(*iref) > end)) {
 			inode_ref_err(leaf, slot,
 			"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
-				ptr, end, sizeof(iref));
+				ptr, end, sizeof(*iref));
 			return -EUCLEAN;
 		}
 


