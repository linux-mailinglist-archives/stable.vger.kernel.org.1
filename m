Return-Path: <stable+bounces-64429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA9941DD1
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A871F27B0C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319591A76C2;
	Tue, 30 Jul 2024 17:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WjaoYe9T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B31A76AE;
	Tue, 30 Jul 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360093; cv=none; b=IKW9+zGDTfzt6Hd+BSIpEJ8EkTg8TAoDLTM84XFTeS9TIor8G8litUXl52tk/zR91Ybd0H4JrrOGsr8USvDkqMXbp5a/Alu7vmkwNBRE4a4dk6kODcZVZkH2p8N+F49cIqTj5MGPze5Mu0tVEgVlNifQhinQbTYs1ECqbt2f+UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360093; c=relaxed/simple;
	bh=jALQrV5/zi6mjKxPEvd5xjLTnI0FEHw/BUneTx3nrcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohflvv7MLTTQWAAYxDBj7dzijOmN6/RHlaR+IfcrUFtI/0cJaPMuIbgTWxzUzwFjopfKntZRemxHjt7svrG7AhlQwhLzLF/JTc+mS/vOUxV3MMageuaO7VfzCjz8dz9vrh4MwK1QzZ8OHV3ZncdiwPl87qqvx1j/rxz3vxPgTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WjaoYe9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664BFC32782;
	Tue, 30 Jul 2024 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360092;
	bh=jALQrV5/zi6mjKxPEvd5xjLTnI0FEHw/BUneTx3nrcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WjaoYe9Tj54yyeE9a+4Y30+czdZCEXWXsDG5UDeThl8xVFk/EIDhPv0PhRaahoTRi
	 OP/qAt8nAtgFlDjR49yWiOTzyyKus27v1BPzn0BPHKskwGzCSa1fi41WFZ5/jnKcnj
	 fP60oVu8hLCzvy08uHiXpKy18UiAKSJL2ZFxhL4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 568/568] fs: dont allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT
Date: Tue, 30 Jul 2024 17:51:15 +0200
Message-ID: <20240730151702.357758677@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Seth Forshee (DigitalOcean) <sforshee@kernel.org>

[ Upstream commit e1c5ae59c0f22f7fe5c07fb5513a29e4aad868c9 ]

Christian noticed that it is possible for a privileged user to mount
most filesystems with a non-initial user namespace in sb->s_user_ns.
When fsopen() is called in a non-init namespace the caller's namespace
is recorded in fs_context->user_ns. If the returned file descriptor is
then passed to a process priviliged in init_user_ns, that process can
call fsconfig(fd_fs, FSCONFIG_CMD_CREATE), creating a new superblock
with sb->s_user_ns set to the namespace of the process which called
fsopen().

This is problematic. We cannot assume that any filesystem which does not
set FS_USERNS_MOUNT has been written with a non-initial s_user_ns in
mind, increasing the risk for bugs and security issues.

Prevent this by returning EPERM from sget_fc() when FS_USERNS_MOUNT is
not set for the filesystem and a non-initial user namespace will be
used. sget() does not need to be updated as it always uses the user
namespace of the current context, or the initial user namespace if
SB_SUBMOUNT is set.

Fixes: cb50b348c71f ("convenience helpers: vfs_get_super() and sget_fc()")
Reported-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Link: https://lore.kernel.org/r/20240724-s_user_ns-fix-v1-1-895d07c94701@kernel.org
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e6..576abb1ff0403 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -781,6 +781,17 @@ struct super_block *sget_fc(struct fs_context *fc,
 	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
 	int err;
 
+	/*
+	 * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
+	 * not set, as the filesystem is likely unprepared to handle it.
+	 * This can happen when fsconfig() is called from init_user_ns with
+	 * an fs_fd opened in another user namespace.
+	 */
+	if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
+		errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
+		return ERR_PTR(-EPERM);
+	}
+
 retry:
 	spin_lock(&sb_lock);
 	if (test) {
-- 
2.43.0




