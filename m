Return-Path: <stable+bounces-20704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB985AB5E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1011C211D3
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653341C78;
	Mon, 19 Feb 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eCqgp4OI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF8FBED
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368446; cv=none; b=YWXKtg/zPToltGT0uyhWW76pDqMV5NocjnochnnsmLDOZoGca7WzYYeuGsCGwvBatve9DMDrzcDaDEY+UBjMflF6Del4sMmoBG8L/vDGbVZvqQNOyiuSnKpolxjhMNsk2CKTdqplhC6OOlRSu2cWFduucNpwxOCDwxTL/VW6W6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368446; c=relaxed/simple;
	bh=lGxA2zjace+kKhGR0jWGbWwvXqDh7EwGXZu+1Jm5P04=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UGKe8x7ZPq7WAOszV3w8p7TRx9BvgKH5iCJWX2D0BAcig179ZcFuqgRoCG2OVxOWQcQxo36vYpoEJqzb9IiiCshd2EsGIFvPx1YbYyUsYJmGOzE9y4rJVS6C0rHGwWkVgOjGOaFYOTaWraJFYgPVvm0aIRV8oM2jhcD/Kn5/PI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eCqgp4OI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF03C433C7;
	Mon, 19 Feb 2024 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368446;
	bh=lGxA2zjace+kKhGR0jWGbWwvXqDh7EwGXZu+1Jm5P04=;
	h=Subject:To:Cc:From:Date:From;
	b=eCqgp4OIh1OEqCCO5ari8ipyKYZLRxkz1B7sJtKKZwlLs1+V6e4EZjs9wRi5DEx+0
	 XQILy8kAkMs1K+Pyp/OGShHXwde2Z/vkPsF+sSlICGgsDxLfcpVaRcJeUL7ymrtzeK
	 1Mpi074Ytq7eUhmE4BUOBgbvNTTJ1Rt19yhi/A/E=
Subject: FAILED: patch "[PATCH] fs: relax mount_setattr() permission checks" failed to apply to 5.15-stable tree
To: brauner@kernel.org,jack@suse.cz,kzak@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:47:22 +0100
Message-ID: <2024021922-repugnant-crafter-ce03@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 46f5ab762d048dad224436978315cbc2fa79c630
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021922-repugnant-crafter-ce03@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

46f5ab762d04 ("fs: relax mount_setattr() permission checks")
87bb5b60019c ("fs: clean up mount_setattr control flow")
a26f788b6e7a ("fs: add mnt_allow_writers() and simplify mount_setattr_prepare()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46f5ab762d048dad224436978315cbc2fa79c630 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 6 Feb 2024 11:22:09 +0100
Subject: [PATCH] fs: relax mount_setattr() permission checks

When we added mount_setattr() I added additional checks compared to the
legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
mount(2). If that mount had a parent then verify that the caller and the
mount namespace the mount is attached to match and if not make sure that
it's an anonymous mount.

The real rootfs falls into neither category. It is neither an anoymous
mount because it is obviously attached to the initial mount namespace
but it also obviously doesn't have a parent mount. So that means legacy
mount(2) allows changing mount properties on the real rootfs but
mount_setattr(2) blocks this. I never thought much about this but of
course someone on this planet of earth changes properties on the real
rootfs as can be seen in [1].

Since util-linux finally switched to the new mount api in 2.39 not so
long ago it also relies on mount_setattr() and that surfaced this issue
when Fedora 39 finally switched to it. Fix this.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2256843
Link: https://lore.kernel.org/r/20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Reported-by: Karel Zak <kzak@redhat.com>
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index 437f60e96d40..5a51315c6678 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4472,10 +4472,15 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	/*
 	 * If this is an attached mount make sure it's located in the callers
 	 * mount namespace. If it's not don't let the caller interact with it.
-	 * If this is a detached mount make sure it has an anonymous mount
-	 * namespace attached to it, i.e. we've created it via OPEN_TREE_CLONE.
+	 *
+	 * If this mount doesn't have a parent it's most often simply a
+	 * detached mount with an anonymous mount namespace. IOW, something
+	 * that's simply not attached yet. But there are apparently also users
+	 * that do change mount properties on the rootfs itself. That obviously
+	 * neither has a parent nor is it a detached mount so we cannot
+	 * unconditionally check for detached mounts.
 	 */
-	if (!(mnt_has_parent(mnt) ? check_mnt(mnt) : is_anon_ns(mnt->mnt_ns)))
+	if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
 		goto out;
 
 	/*


