Return-Path: <stable+bounces-114879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4FCA307AA
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204551887AD8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58491F0E35;
	Tue, 11 Feb 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjVdmOgj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C9F1D90CD
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739267539; cv=none; b=U/sjRspNur54ctPjNqugGFV1zKMfZn/hHkVqHP95VIac59Aje13fE0rniJm53GDSnkmw72UQU3WPz36PzogJe/NEF1MSVpYzpF3zLBW8PAWsNywE1donFRmyluTWsNwxrrkrfHufh4X+BO1AauhgWwhwJ0FKgbSHoQbPz6Ii37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739267539; c=relaxed/simple;
	bh=1h9po6Ud8+upZWkbtk+agPyhshYS10XuFge5GuStD6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M1kpFF2lGel1rckK+nPUNo34q+eXoRxmn9p0+hNqZXUYbUtyRGxN3e0blpdwm5RouQw6Vd1vXfpYrpFKUsRhS6BDBW1WM1nwFXFDT+cGJiDeB//+VKYMeUo9p1laIjKKAZHoTf/KaAvd1CUWVRCDEVCwv0qeqod3fH+QwuWaN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjVdmOgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1D0C4CEDD;
	Tue, 11 Feb 2025 09:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739267538;
	bh=1h9po6Ud8+upZWkbtk+agPyhshYS10XuFge5GuStD6c=;
	h=Subject:To:Cc:From:Date:From;
	b=XjVdmOgjKLZaUdwGjYml3JCkA8xuVfpEiWKcEzjc8RvYJ0iLDKbNoygFxjKz6X5Kr
	 pKYxipPi4PLJIiTyHQRD9rUwdejWqBKcdQDB+LroJQLmn/GBjqc/AMG41dnPJ4V9+c
	 ZnDrdSLWFG4duOCaXLkcdZvVbBWZLmvxB4/Cd3SQ=
Subject: FAILED: patch "[PATCH] statmount: let unset strings be empty" failed to apply to 6.12-stable tree
To: mszeredi@redhat.com,brauner@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 11 Feb 2025 10:52:10 +0100
Message-ID: <2025021110-demeaning-mushroom-9922@gregkh>
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
git cherry-pick -x e52e97f09fb66fd868260d05bd6b74a9a3db39ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021110-demeaning-mushroom-9922@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e52e97f09fb66fd868260d05bd6b74a9a3db39ee Mon Sep 17 00:00:00 2001
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 30 Jan 2025 13:15:00 +0100
Subject: [PATCH] statmount: let unset strings be empty

Just like it's normal for unset values to be zero, unset strings should be
empty instead of containing random values.

It seems to be a typical mistake that the mask returned by statmount is not
checked, which can result in various bugs.

With this fix, these bugs are prevented, since it is highly likely that
userspace would just want to turn the missing mask case into an empty
string anyway (most of the recently found cases are of this type).

Link: https://lore.kernel.org/all/CAJfpegsVCPfCn2DpM8iiYSS5DpMsLB8QBUCHecoj6s0Vxf4jzg@mail.gmail.com/
Fixes: 68385d77c05b ("statmount: simplify string option retrieval")
Fixes: 46eae99ef733 ("add statmount(2) syscall")
Cc: stable@vger.kernel.org # v6.8
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Link: https://lore.kernel.org/r/20250130121500.113446-1-mszeredi@redhat.com
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index a3ed3f2980cb..9c4d307a82cd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5191,39 +5191,45 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 	size_t kbufsize;
 	struct seq_file *seq = &s->seq;
 	struct statmount *sm = &s->sm;
-	u32 start = seq->count;
+	u32 start, *offp;
+
+	/* Reserve an empty string at the beginning for any unset offsets */
+	if (!seq->count)
+		seq_putc(seq, 0);
+
+	start = seq->count;
 
 	switch (flag) {
 	case STATMOUNT_FS_TYPE:
-		sm->fs_type = start;
+		offp = &sm->fs_type;
 		ret = statmount_fs_type(s, seq);
 		break;
 	case STATMOUNT_MNT_ROOT:
-		sm->mnt_root = start;
+		offp = &sm->mnt_root;
 		ret = statmount_mnt_root(s, seq);
 		break;
 	case STATMOUNT_MNT_POINT:
-		sm->mnt_point = start;
+		offp = &sm->mnt_point;
 		ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
-		sm->mnt_opts = start;
+		offp = &sm->mnt_opts;
 		ret = statmount_mnt_opts(s, seq);
 		break;
 	case STATMOUNT_OPT_ARRAY:
-		sm->opt_array = start;
+		offp = &sm->opt_array;
 		ret = statmount_opt_array(s, seq);
 		break;
 	case STATMOUNT_OPT_SEC_ARRAY:
-		sm->opt_sec_array = start;
+		offp = &sm->opt_sec_array;
 		ret = statmount_opt_sec_array(s, seq);
 		break;
 	case STATMOUNT_FS_SUBTYPE:
-		sm->fs_subtype = start;
+		offp = &sm->fs_subtype;
 		statmount_fs_subtype(s, seq);
 		break;
 	case STATMOUNT_SB_SOURCE:
-		sm->sb_source = start;
+		offp = &sm->sb_source;
 		ret = statmount_sb_source(s, seq);
 		break;
 	default:
@@ -5251,6 +5257,7 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 
 	seq->buf[seq->count++] = '\0';
 	sm->mask |= flag;
+	*offp = start;
 	return 0;
 }
 


