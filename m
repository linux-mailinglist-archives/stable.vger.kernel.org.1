Return-Path: <stable+bounces-186161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B2BBE3DB5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CFA2408217
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B18433CEA9;
	Thu, 16 Oct 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VCGGOBLx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFB1D5CE8
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760624086; cv=none; b=S4a2gH0mT98xpE5xdUUnbO9XHXqXzPOZzl+b+KUXGqFlvHeXUJq5qP0VfgJAjjMD3sZKMSFFEzEc6q3WW9GyIoM0R/U0G908tJNGq/ZUYfkPJhjpRufCG5OCmWpYbjt69eMXzYDtjfDJWKzsnMt1fX9XP0GFfBAsdVT59vkeOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760624086; c=relaxed/simple;
	bh=kFaf3Mj4n+pHR4Dh2FT/okWyXeIpz2Mxx53jIwqR030=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rN20Yd6BohCRyXZNLx4/HN8E2FZtU9gi8DEOsWt0ZG8cYncRYixl0akPvR7wRQvcK+gW7gY67DpGWdK+ewDLmWON7FASaci/oOJJr9n0D0bOt1M30G9/d4BkiSeQATyMRsEfNO39futnbeVtkyVD3uRVtgycnJnuK9+K8m7CUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VCGGOBLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 700BCC4CEF1;
	Thu, 16 Oct 2025 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760624086;
	bh=kFaf3Mj4n+pHR4Dh2FT/okWyXeIpz2Mxx53jIwqR030=;
	h=Subject:To:Cc:From:Date:From;
	b=VCGGOBLxrN10HCf5mTTlO1xOcOL3VL7v0rims7QKCoiaYP6bCp0+5XHwh/NafIKSq
	 sommIwQIrOPPaJXmzhHK68nCzIWP8l/9FWySvmZ1OacaagdpcNdbw55SHL30XiBSUe
	 uK45ArqsYqWeZcqNrUIUh1hdnkxmW5fW16k8Sne8=
Subject: FAILED: patch "[PATCH] ext4: avoid potential buffer over-read in" failed to apply to 5.4-stable tree
To: tytso@mit.edu,djwong@kernel.org,jack@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Oct 2025 16:14:35 +0200
Message-ID: <2025101635-twitch-preoccupy-ad1d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8ecb790ea8c3fc69e77bace57f14cf0d7c177bd8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101635-twitch-preoccupy-ad1d@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ecb790ea8c3fc69e77bace57f14cf0d7c177bd8 Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Tue, 16 Sep 2025 23:22:47 -0400
Subject: [PATCH] ext4: avoid potential buffer over-read in
 parse_apply_sb_mount_options()

Unlike other strings in the ext4 superblock, we rely on tune2fs to
make sure s_mount_opts is NUL terminated.  Harden
parse_apply_sb_mount_options() by treating s_mount_opts as a potential
__nonstring.

Cc: stable@vger.kernel.org
Fixes: 8b67f04ab9de ("ext4: Add mount options in superblock")
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20250916-tune2fs-v2-1-d594dc7486f0@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d26e5c0731e5..488f4c281a3f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2469,7 +2469,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2477,15 +2477,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-				sizeof(sbi->s_es->s_mount_opts),
-				GFP_KERNEL);
-	if (!s_mount_opts)
-		return ret;
+	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		return -ENOMEM;
 
 	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2517,11 +2513,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	ret = 0;
 
 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
-	kfree(s_mount_opts);
+	ext4_fc_free(fc);
+	kfree(fc);
 	return ret;
 }
 


