Return-Path: <stable+bounces-108226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA3A09977
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 19:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E30D3A478F
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2C213E70;
	Fri, 10 Jan 2025 18:32:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA8206F37;
	Fri, 10 Jan 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533952; cv=none; b=Ws8/O0PxNiODqrp1rjDn3IImTxh0q3qNq7wNwQCBG9nGKsdpRTkQ01Xy8cZ9w+btcDoks/M4o3d4XdcCb/+Xaly0TMI0D/qLf1fOGKwCGc07OO2EfetFcxEiBEWGqyjBp/mYVzFH1oO7VXjaJYImHs1c31FBKM89NZaiYqx/ZRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533952; c=relaxed/simple;
	bh=As80Mt2rdNKYY6TChTefkBCZAsji4oShiG/EViFW1R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERhayzE4RY6IgVtK33MRBhKAGZMw98RheX5ypuU5rnn0FqD4lemix7Hmg9scqUl5nVFMsdVeEv6VKGn0h2KUcuROWgfPjk/SIqmuiYVpe98ETEBRYu9mbPRhunlpZQjI77XV/bZTocogoW/chNjvIfxdZcgiCSJvxRJVXn2Z70E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 10242233A6;
	Fri, 10 Jan 2025 21:32:27 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-kernel@vger.kernel.org,
	Juntong Deng <juntong.deng@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Clayton Casciato <majortomtosourcecontrol@gmail.com>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10 1/2] gfs2: make function gfs2_make_fs_ro() to void type
Date: Fri, 10 Jan 2025 21:32:12 +0300
Message-Id: <20250110183213.105051-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20250110183213.105051-1-kovalev@altlinux.org>
References: <20250110183213.105051-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Li <yang.lee@linux.alibaba.com>

commit eb602521f43876b3f76c4686de596c9804977228 upstream.

It fixes the following warning detected by coccinelle:
./fs/gfs2/super.c:592:5-10: Unneeded variable: "error". Return "0" on
line 628

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/gfs2/ops_fstype.c |  4 +---
 fs/gfs2/super.c      | 10 ++--------
 fs/gfs2/super.h      |  2 +-
 fs/gfs2/util.c       |  2 +-
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 648f7336043f6a..9fcb86d1a922a8 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1564,9 +1564,7 @@ static int gfs2_reconfigure(struct fs_context *fc)
 			return -EINVAL;
 
 		if (fc->sb_flags & SB_RDONLY) {
-			error = gfs2_make_fs_ro(sdp);
-			if (error)
-				errorfc(fc, "unable to remount read-only");
+			gfs2_make_fs_ro(sdp);
 		} else {
 			error = gfs2_make_fs_rw(sdp);
 			if (error)
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 8cf4ef61cdc41d..a9e3956a5b4698 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -555,9 +555,8 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
  * Returns: errno
  */
 
-int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
+void gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 {
-	int error = 0;
 	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 
 	gfs2_flush_delete_work(sdp);
@@ -592,8 +591,6 @@ int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 
 	if (!log_write_allowed)
 		sdp->sd_vfs->s_flags |= SB_RDONLY;
-
-	return error;
 }
 
 /**
@@ -605,7 +602,6 @@ int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
 static void gfs2_put_super(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
-	int error;
 	struct gfs2_jdesc *jd;
 
 	/* No more recovery requests */
@@ -626,9 +622,7 @@ static void gfs2_put_super(struct super_block *sb)
 	spin_unlock(&sdp->sd_jindex_spin);
 
 	if (!sb_rdonly(sb)) {
-		error = gfs2_make_fs_ro(sdp);
-		if (error)
-			gfs2_io_error(sdp);
+		gfs2_make_fs_ro(sdp);
 	}
 	WARN_ON(gfs2_withdrawing(sdp));
 
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index c9fb2a65418137..c61586ca61ff9b 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -30,7 +30,7 @@ extern int gfs2_lookup_in_master_dir(struct gfs2_sbd *sdp, char *filename,
 				     struct gfs2_inode **ipp);
 
 extern int gfs2_make_fs_rw(struct gfs2_sbd *sdp);
-extern int gfs2_make_fs_ro(struct gfs2_sbd *sdp);
+extern void gfs2_make_fs_ro(struct gfs2_sbd *sdp);
 extern void gfs2_online_uevent(struct gfs2_sbd *sdp);
 extern int gfs2_statfs_init(struct gfs2_sbd *sdp);
 extern void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index d11152dedb803e..00cb912b4744c4 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -161,7 +161,7 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 				ret = 0;
 		}
 		if (!ret)
-			ret = gfs2_make_fs_ro(sdp);
+			gfs2_make_fs_ro(sdp);
 		gfs2_freeze_unlock(&freeze_gh);
 	}
 
-- 
2.33.8


