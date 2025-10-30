Return-Path: <stable+bounces-191767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F0C2213D
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 20:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C4F3A6ED7
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1202FF171;
	Thu, 30 Oct 2025 19:51:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B7126C3BE
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761853875; cv=none; b=WhF6RD5/DGdF9I1zPOpmBnG/K7LqVdYtY0zkLNtLAOilw98KA3k6Nc1Y5HJgO12/ccTJu6K7wY4D+gKJ8kEsE9KoXBFT0JnuZsBrMhV7xCkG1OXyzyZhtKZbkhev56WhAdDLNBa1esmKprkPzbUP6k9lyWEF83DkiHZ7ERvDBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761853875; c=relaxed/simple;
	bh=Dtw0kTMtyUyCt7bxGYSHlWQ3H7dmKf8F2x3Mtd0OMtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cyxuDxkuCVXrhR3TE2i2KqvuONybgqvyxqae8t6Wg1Pcw8SqNGfLdTUT94SpgfAyyVv3G/KRvwJxwWMX8wPqKl2iOKHBKElP1Y1TBnxjsVxfc/JYTeY/XTgZ+DA/cSpYtSctPtCujnSVoLi0vTpeFQHgyXM0hIdh2LivzDqcC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id F3EFE233B3;
	Thu, 30 Oct 2025 22:51:09 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10] clone_private_mnt(): make sure that caller has CAP_SYS_ADMIN in the right userns
Date: Thu, 30 Oct 2025 22:51:09 +0300
Message-Id: <20251030195109.406989-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

commit c28f922c9dcee0e4876a2c095939d77fe7e15116 upstream.

What we want is to verify there is that clone won't expose something
hidden by a mount we wouldn't be able to undo.  "Wouldn't be able to undo"
may be a result of MNT_LOCKED on a child, but it may also come from
lacking admin rights in the userns of the namespace mount belongs to.

clone_private_mnt() checks the former, but not the latter.

There's a number of rather confusing CAP_SYS_ADMIN checks in various
userns during the mount, especially with the new mount API; they serve
different purposes and in case of clone_private_mnt() they usually,
but not always end up covering the missing check mentioned above.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Reported-by: "Orlando, Noah" <Noah.Orlando@deshaw.com>
Fixes: 427215d85e8d ("ovl: prevent private clone if bind mount is not allowed")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[ merge conflict resolution: clone_private_mount() was reworked in
  db04662e2f4f ("fs: allow detached mounts in clone_private_mount()").
  Tweak the relevant ns_capable check so that it works on older kernels ]
Signed-off-by: Noah Orlando <Noah.Orlando@deshaw.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 36fecd740de2d542d2091d65d36554ee2bcf9c65)
[ kovalev: bp to fix CVE-2025-38499 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index e9b8d516f191..b6d9250e1b38 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1965,6 +1965,11 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	if (!check_mnt(old_mnt))
 		goto invalid;
 
+	if (!ns_capable(old_mnt->mnt_ns->user_ns, CAP_SYS_ADMIN)) {
+		up_read(&namespace_sem);
+		return ERR_PTR(-EPERM);
+	}
+
 	if (has_locked_children(old_mnt, path->dentry))
 		goto invalid;
 
-- 
2.50.1


