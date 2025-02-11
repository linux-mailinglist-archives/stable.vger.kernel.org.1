Return-Path: <stable+bounces-114873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CEA30773
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06187A200A
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F921F1527;
	Tue, 11 Feb 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s78sw946"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DDE1C5D76
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267099; cv=none; b=TmWULKJ0Bixos4+9JxPIFA83cSkdZ02i8l5yG/RshGiYAbrNNHHZPyQmNu7/z7PjRtvMdCsAjvcGgcDue+8UxhYIqSHOEalGglxTM1fed3LK251E7/dGRX3fklmsm/Kn5znZm++HotfVXewQL2sGUpZEMQac/rTorm0y4viavwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267099; c=relaxed/simple;
	bh=nwI7fBaIzeMuZDm4yWxoakqBe4JreqG+yxTZU3s2H+k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tDTdPAlvy2LY8PUL7TM/NU3OT0eB+FRPlmJ9f6JztmedGZ9vvAdq/ZTdaf6WuZ8QQnLg3K1zvZ00DLgWMxZQZwBXW377Mci24EAtn6D290vhyfBFGeIvILx08QyRhenF02VWbRepUjwxocXqAiFKpr6q/UMd0p0jqiARRrKYrZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s78sw946; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE2AC4CEDD;
	Tue, 11 Feb 2025 09:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739267099;
	bh=nwI7fBaIzeMuZDm4yWxoakqBe4JreqG+yxTZU3s2H+k=;
	h=Subject:To:Cc:From:Date:From;
	b=s78sw946PmBfPbWqewj2hA26bmqOstkd/fdhDOnYg/G1M9ZG4iOuH/W3NEbgOIXZr
	 A5bFxiKCLLBb+UTpGMD5/QlVTEXI+G6fLC+Iudi2WeYOboLIcMMZMADmgISCuWbXQh
	 k1f9F8GmCcnFcxH1NsCvoxmC4gSzhT6kyhgCSrJg=
Subject: FAILED: patch "[PATCH] fs: fix adding security options to statmount.mnt_opt" failed to apply to 6.12-stable tree
To: mszeredi@redhat.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 10:44:42 +0100
Message-ID: <2025021142-spearmint-explain-70ac@gregkh>
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
git cherry-pick -x 5eb987105357cb7cfa7cf3b1e2f66d5c0977e412
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021142-spearmint-explain-70ac@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5eb987105357cb7cfa7cf3b1e2f66d5c0977e412 Mon Sep 17 00:00:00 2001
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 29 Jan 2025 16:12:53 +0100
Subject: [PATCH] fs: fix adding security options to statmount.mnt_opt

Prepending security options was made conditional on sb->s_op->show_options,
but security options are independent of sb options.

Fixes: 056d33137bf9 ("fs: prepend statmount.mnt_opts string with security_sb_mnt_opts()")
Fixes: f9af549d1fd3 ("fs: export mount options via statmount()")
Cc: stable@vger.kernel.org # v6.11
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Link: https://lore.kernel.org/r/20250129151253.33241-1-mszeredi@redhat.com
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index 9c4d307a82cd..8f1000f9f3df 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5087,31 +5087,30 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
 	struct super_block *sb = mnt->mnt_sb;
+	size_t start = seq->count;
 	int err;
 
+	err = security_sb_show_options(seq, sb);
+	if (err)
+		return err;
+
 	if (sb->s_op->show_options) {
-		size_t start = seq->count;
-
-		err = security_sb_show_options(seq, sb);
-		if (err)
-			return err;
-
 		err = sb->s_op->show_options(seq, mnt->mnt_root);
 		if (err)
 			return err;
-
-		if (unlikely(seq_has_overflowed(seq)))
-			return -EAGAIN;
-
-		if (seq->count == start)
-			return 0;
-
-		/* skip leading comma */
-		memmove(seq->buf + start, seq->buf + start + 1,
-			seq->count - start - 1);
-		seq->count--;
 	}
 
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
+
+	if (seq->count == start)
+		return 0;
+
+	/* skip leading comma */
+	memmove(seq->buf + start, seq->buf + start + 1,
+		seq->count - start - 1);
+	seq->count--;
+
 	return 0;
 }
 


