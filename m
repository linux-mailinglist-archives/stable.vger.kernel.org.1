Return-Path: <stable+bounces-152464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A07AD6091
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C43F1BC22D4
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E602BDC2C;
	Wed, 11 Jun 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWTA873g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA72BD586
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675707; cv=none; b=A0Kgt+Dz0wXhpWi/dusfibyJiS907cdF/VsEr1wh1GEULJdtEFf9MLEvShTONU3/1dCHWmxP8eM+WE6430p7FLFyKBuDHaJnxeisHneprbDFUXDPaqjOSaZnZD1uTE8ZmUJPhwGSRZ6qTDAIFjsXqJhUt4u3weYWbVnq6c4xzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675707; c=relaxed/simple;
	bh=HbuJZ2IFd8dZWxp8GYIXjtdG7AAEKxjGJOGedY0qpzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W74pROsff2yhQQJ/nnvjO7GIGVwG0cD15Rshpuh2tGOo/WS0lXx9wKY1wGH77ostXAQnsCncD7MnfL+yu1r93AwwXOMPj0J32MnaxovKA5Gwi6dEojbZx0riV9aM09qh18tJR0l0KMFs5YUwZt3yxZ3nnal+3jSTuHSpOQfWhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWTA873g; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234fcadde3eso3586735ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675704; x=1750280504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zClHOlJldVHWmybRTWFgpR6dPn99BDyDolET+1N29do=;
        b=JWTA873geFpX2KtqbXY9t992/2BJd+6agJyM4Ts8F9kCpPs3rBUPwfVAo81uyzetkt
         8C2CQOigj0PTagJxwtdUjJRoii5eqFPrgUjOiBLbsMx1/SXV84pOZOJvOn5qHOLd7H6p
         b1gQItaFaCPNszdUYLV5xWlQ8IhsK7CXLfVURIyCz9LgpdwKRKkDApaHG6W1XIpT/pNr
         K3QAS7ddLTk4ZbOcqwxP5f5WozxCpBqe8AGi+yHfTojtd0TBF7ORhs7exbXwSV0D57pW
         V/58WBSAed+mivpx9KDlYtIgsh4WlstwX0VGHiWyor/IQLsPpZYYz6kAmDlBjro6SyFN
         WlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675704; x=1750280504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zClHOlJldVHWmybRTWFgpR6dPn99BDyDolET+1N29do=;
        b=T3Etrg2cYQMI/j8qAILIZ3zYWihp945+bjB/Ic8oxy6qxX51bMwlrlGHZidd9USMC/
         LSVS12tusgh8WC80Ukvhw/qjZXFr0wYi9CoJBfWMxS16kgSHWVm7O7d+AYeUb8zb+uk5
         UtwQ5jW+/jkSEqEbAJpy2Xd4BojAm/0lvBzqBA49MrQCRzTxgxxcAqoKU8VHq5yaTUdo
         YJsfCtFL+svFzT6tUFgNkSO8OfJxb502AEohFXIC3tcnY8P3ATmQT/LKF3k5ZyQhh9N1
         4drmiI1uXLC4OcGdt9ZwA3xrYhA1JkW0HW9s9emhP0iQx72uy4oFLaLKtr6u1JJW7VMk
         CEzQ==
X-Gm-Message-State: AOJu0YyYW/AkHGKkWqFr0DOWbNjzHu/GdTI8LgQpUnei3i3W9SsIcGA4
	JvKUJpP5ZfjyqrcslJLU38/Y8Ykk30kYBqlJkme+48FgG7Yzftocw4SHtNAJhLGQ
X-Gm-Gg: ASbGncuX82Ad+nkVt59BYs9yVZHS0/7xMyTXawoO4+cT26gpEf90QWHZXKrMV4tIipz
	rQJJ6+bsc0rgk+4UYGJMwF17SVctHVefcQ4zvigIJHO5yLlr20F2Nhx604MPVrSGHSZMbR2hJIq
	EaudAYhY1b5M0jBXFLqv1NRSxQlMSQK2ldX3s4+XumrVgvEG/bOfHhyOBQD7C7oHA012CkSwIXY
	5vFGOk0wTMwzuaJg9pl17oeq7m2K2kbx0mDCnf+nCSzu3g6nu0yvZ7cd9NQWvK0bgwzgLrr9CbO
	Uzt4fWS1md5prJlKLaQaS+I56vQvZfn3HzQ4AnMnljGY11YdYLISo507R+zOFmZlm+Axgd3yoqu
	19ZaxEGgZf0U=
X-Google-Smtp-Source: AGHT+IFPco9TbOsYUTd9pc4lKvPqw6SQyvvJodyyrEEl6DppJCNrtAmUVXkl9Itdf7bCDF5gXH/IWA==
X-Received: by 2002:a17:902:f549:b0:234:b123:b4ff with SMTP id d9443c01a7336-2364d65e639mr7157945ad.21.1749675704562;
        Wed, 11 Jun 2025 14:01:44 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:44 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 11/23] xfs: use consistent uid/gid when grabbing dquots for inodes
Date: Wed, 11 Jun 2025 14:01:15 -0700
Message-ID: <20250611210128.67687-12-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit  24a4e1cb322e2bf0f3a1afd1978b610a23aa8f36 ]

[ 6.1: resolved conflicts in xfs_inode.c and xfs_symlink.c due to 6.1
not having switched to idmap yet ]

I noticed that callers of xfs_qm_vop_dqalloc use the following code to
compute the anticipated uid of the new file:

	mapped_fsuid(idmap, &init_user_ns);

whereas the VFS uses a slightly different computation for actually
assigning i_uid:

	mapped_fsuid(idmap, i_user_ns(inode));

Technically, these are not the same things.  According to Christian
Brauner, the only time that inode->i_sb->s_user_ns != &init_user_ns is
when the filesystem was mounted in a new mount namespace by an
unpriviledged user.  XFS does not allow this, which is why we've never
seen bug reports about quotas being incorrect or the uid checks in
xfs_qm_vop_create_dqattach tripping debug assertions.

However, this /is/ a logic bomb, so let's make the code consistent.

Link: https://lore.kernel.org/linux-fsdevel/20240617-weitblick-gefertigt-4a41f37119fa@brauner/
Fixes: c14329d39f2d ("fs: port fs{g,u}id helpers to mnt_idmap")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_inode.c   | 16 ++++++++++------
 fs/xfs/xfs_symlink.c |  8 +++++---
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index b26d26d29273..88d0a088fa86 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -981,14 +981,16 @@ xfs_create(
 		return -EIO;
 
 	prid = xfs_get_initial_prid(dp);
 
 	/*
-	 * Make sure that we have allocated dquot(s) on disk.
+	 * Make sure that we have allocated dquot(s) on disk.  The uid/gid
+	 * computation code must match what the VFS uses to assign i_[ug]id.
+	 * INHERIT adjusts the gid computation for setgid/grpid systems.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
-			mapped_fsgid(mnt_userns, &init_user_ns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, i_user_ns(VFS_I(dp))),
+			mapped_fsgid(mnt_userns, i_user_ns(VFS_I(dp))), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
 		return error;
 
@@ -1130,14 +1132,16 @@ xfs_create_tmpfile(
 		return -EIO;
 
 	prid = xfs_get_initial_prid(dp);
 
 	/*
-	 * Make sure that we have allocated dquot(s) on disk.
+	 * Make sure that we have allocated dquot(s) on disk.  The uid/gid
+	 * computation code must match what the VFS uses to assign i_[ug]id.
+	 * INHERIT adjusts the gid computation for setgid/grpid systems.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
-			mapped_fsgid(mnt_userns, &init_user_ns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, i_user_ns(VFS_I(dp))),
+			mapped_fsgid(mnt_userns, i_user_ns(VFS_I(dp))), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
 		return error;
 
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 8389f3ef88ef..78bd02a98aa5 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -189,14 +189,16 @@ xfs_symlink(
 	ASSERT(pathlen > 0);
 
 	prid = xfs_get_initial_prid(dp);
 
 	/*
-	 * Make sure that we have allocated dquot(s) on disk.
+	 * Make sure that we have allocated dquot(s) on disk.  The uid/gid
+	 * computation code must match what the VFS uses to assign i_[ug]id.
+	 * INHERIT adjusts the gid computation for setgid/grpid systems.
 	 */
-	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, &init_user_ns),
-			mapped_fsgid(mnt_userns, &init_user_ns), prid,
+	error = xfs_qm_vop_dqalloc(dp, mapped_fsuid(mnt_userns, i_user_ns(VFS_I(dp))),
+			mapped_fsgid(mnt_userns, i_user_ns(VFS_I(dp))), prid,
 			XFS_QMOPT_QUOTALL | XFS_QMOPT_INHERIT,
 			&udqp, &gdqp, &pdqp);
 	if (error)
 		return error;
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


