Return-Path: <stable+bounces-114872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B1A30772
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D68161477
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39191F152B;
	Tue, 11 Feb 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjRzf0VV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F981F0E5D
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267086; cv=none; b=Dia7QKuVFMeXvYOyp35WTycCqpFJgwIjdqYZcUfLG+GdhPefQN24ATT92I3+67j7vPHLzozSfFzkE0N2VBBiD1ZcuusEIKXkVq8+WLSAcL0GwcZgSjORCZTxyNtwSMOGJfJpBFLbEDsC3GWht9QVam7zobbftegcFeckRAlqcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267086; c=relaxed/simple;
	bh=JWE3kyD9Fastr7n2c9rVYYLfXCbKQ0Ohg+vnoZJSoP4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rbD3eVfwcWGH03kyP+R0WzkokO9CUg+ycEcdP981g6XHgwuS++H296LD3NYONjtWO7ZSlrDZQuTzdC5W4uWokbYMW2Q0MJe/7YL6ZcSl9z8hMfH+4qF9GCrlhhKsgcQFKuhxtsU92o+J6PfWo8OYqwuikSzZfYPcE9ugH6axLlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjRzf0VV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DA3C4CEDD;
	Tue, 11 Feb 2025 09:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739267085;
	bh=JWE3kyD9Fastr7n2c9rVYYLfXCbKQ0Ohg+vnoZJSoP4=;
	h=Subject:To:Cc:From:Date:From;
	b=TjRzf0VVpGfoXa0NckCc3D6kHUZkFI+ygW3P2lTKCWTuM/7GiJQSxVxlNhuthsbFs
	 S+TVjJorszCxtu1Yd22kp+7BUttzybwupp6HKtBRNj0XlftbbTUgprkMPlm+mPD3NZ
	 SoQRxG6IMzmPDd0+uZUk3zkyn2kDJaLPSR6+QPwE=
Subject: FAILED: patch "[PATCH] fs: fix adding security options to statmount.mnt_opt" failed to apply to 6.13-stable tree
To: mszeredi@redhat.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 10:44:42 +0100
Message-ID: <2025021142-whoops-explicit-4d75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x 5eb987105357cb7cfa7cf3b1e2f66d5c0977e412
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021142-whoops-explicit-4d75@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

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
 


