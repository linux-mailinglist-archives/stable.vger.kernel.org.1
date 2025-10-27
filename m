Return-Path: <stable+bounces-189978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0D0C0DE61
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3DB3A95DB
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9203425784E;
	Mon, 27 Oct 2025 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg20eewu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAF524BD03
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570406; cv=none; b=mGlZmriodBq1Vs20xcfLhtKZCvOkZBIXGcSlg80rVu/xGHNCb4PpXfK8fCz7zjHN7Y6bgZ9Rhtyka4ZkufHs/rjCvZDXBURt5W6Kn1hAbsrR6lpOslGNt8wsdlCP57vDL+/rkGXba6/zM0tZ3FAFCdTE15beiln8pVP3sRQu0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570406; c=relaxed/simple;
	bh=BWcqAbM9z6t1HjdGNpyf0q26GXGRBkQkzcWNq3FrJa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZCnd3VigaPW6+fSJBPhr8yeScL7kNIYImzjZ0LIdXREIt0ZD3Ac5V0uweUWTsMTBtkQEHGoL6xpi8QyUMI7aGpxuar3fgKjO5FG12x3laNCq72uwx3cW/0gKiDHl4ZdWK/tX5lIPv3/1Yn6XstEBRuAWFHLf1a8gvzzhV5Mh+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg20eewu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7835321bc98so3701942b3a.2
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761570404; x=1762175204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAcB94rt1uG1utYxMaaRSmp/fSyUuxxZEyS4GrV5uxU=;
        b=Wg20eewuQbEUDIPNY8EAu+W5O8fvohPNiFDyG4ZFCkmcvQlv9dnb1+a8KxoR2XVqQD
         UAoClKB5+b/+dCP2wqx3Mxb9pXbWS0qvKXVEH0CTcL0obONjrr8br3amKQIMvS4W6LRy
         VrNe7BO3suvOSW5O/Z1NbJ0Q85T0sbD0MONHoTyGfTKrmQ6ilRUu/huwvav8lUWc/0XI
         haP/qSlgHiEdOGZcBgCjemBGux1Er0+ChS1gLzGFWKq8T9Hs4xJgbFrsN7t6WhwAw8wH
         8LDsROZWtqZWOEMR2Gg/zABYW5IhznGXjNE1zBYhBYUOA4Qkihh+IjDgQC+eVWDuiR7O
         lPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761570404; x=1762175204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAcB94rt1uG1utYxMaaRSmp/fSyUuxxZEyS4GrV5uxU=;
        b=Ln+jWtaA2hr4PrcqrlrGZkzKc4RGoDYU/52c6Vu+onqLNyzWXpMbh80o6Dpd+wgFLm
         UqDamKDWMqv73OlFbgYuBlVDq2p24Mjthnu1WLV28vEAZa1k5LVej47k6oCPSCjtr+7U
         al1vtl1HTA6BepadSsr7w4EJGbJNqd9j1osnyD7iMpWCN00MB8rEqJITghyQLrJJxAtR
         wdAg9le6r5qMGDQXs5O1CmCHRDYvV3qZ8Iig+U8MqsJRdRc6z92wGxZDUHh/wzW3c7Fl
         P2N6dfx0AZuaRkhnUh7dactFZcog0pWzFDp14GerdTA+9ww5nljWYoT9fkqqq+w2vrSG
         yOag==
X-Forwarded-Encrypted: i=1; AJvYcCW07YlyB8ZSdiJp7J3INe9xjbNbp/5T1oVXraW87HXP4uX1fkFibk9iXOI8LzUpUyrg57kpg+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSBtcTsBufc3AFTt4Sh5GK1qbpDrmCs0cp1CuefqMxpRcF+9u
	dn3BrU2PJWY7DsWA8Q6oKDwNJznBjaYz9lKS43hfEezxc9MZKOHDYdbL
X-Gm-Gg: ASbGncuC/VQ7GoxhIlFlPtOLVdw2YFxa5mI7GijcKMYwyTDwYrKsdG/3OjcDu0nYtsx
	nqTZYPnqpwiC2THSPDGo9/0jOUzrMLfmMouQzSLfbhysuAZ2o4AUmlwFGf926ALa/Uy24CkSuTN
	9cV0SFHfa8JKc4qk6oj0AAA4LPq+/qzy/0my/q7CjI9FHVtiz4YPH7Dc2yPVirEn/f3bC/k+F/u
	ggQGWe+9a/BhvBZ28NIxq98dTfYN1Ez33lQXevgGoPHWdGrQG0vx8Amqn64I6Q5OFjxqnwznqnZ
	YyW/sb9BHIYryeCmbLXkM1OGsb3AGVIm9nrTyUJ/rJ5armcuslSCdEL+VJqEPShtz9JB/FhLIHB
	N6NPBqIDD9Kx7r7dbtcO6BKk/rUFNPO017suVhMQOBbJwvwpC7vzxeOPbqoD6muNorK6QKHTj+U
	+UacsFukGZyQ3zHRc7mTO5gjw=
X-Google-Smtp-Source: AGHT+IFDBFQhu6H8WRS3G5jmj6Lqwp/4wmrDvIHwDdiFCiGPdJW6/tnWwumkgtAM7uP2nl3Z20LJrw==
X-Received: by 2002:a05:6a00:9501:b0:783:7de9:d3c5 with SMTP id d2e1a72fcca58-7a220d377d9mr45674430b3a.29.1761570403480;
        Mon, 27 Oct 2025 06:06:43 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:fac6:8aa5:82e:7fef])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012899sm8253997b3a.0.2025.10.27.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:06:42 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] f2fs: invalidate dentry cache on failed whiteout creation
Date: Mon, 27 Oct 2025 18:36:34 +0530
Message-ID: <20251027130635.13739-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

F2FS can mount filesystems with corrupted directory depth values that
get runtime-clamped to MAX_DIR_HASH_DEPTH. When RENAME_WHITEOUT
operations are performed on such directories, f2fs_rename performs
directory modifications (updating target entry and deleting source
entry) before attempting to add the whiteout entry via f2fs_add_link.

If f2fs_add_link fails due to the corrupted directory structure, the
function returns an error to VFS, but the partial directory
modifications have already been committed to disk. VFS assumes the
entire rename operation failed and does not update the dentry cache,
leaving stale mappings.

In the error path, VFS does not call d_move() to update the dentry
cache. This results in new_dentry still pointing to the old inode
(new_inode) which has already had its i_nlink decremented to zero.
The stale cache causes subsequent operations to incorrectly reference
the freed inode.

This causes subsequent operations to use cached dentry information that
no longer matches the on-disk state. When a second rename targets the
same entry, VFS attempts to decrement i_nlink on the stale inode, which
may already have i_nlink=0, triggering a WARNING in drop_nlink().

Example sequence:
1. First rename (RENAME_WHITEOUT): file2 → file1
   - f2fs updates file1 entry on disk (points to inode 8)
   - f2fs deletes file2 entry on disk
   - f2fs_add_link(whiteout) fails (corrupted directory)
   - Returns error to VFS
   - VFS does not call d_move() due to error
   - VFS cache still has: file1 → inode 7 (stale!)
   - inode 7 has i_nlink=0 (already decremented)

2. Second rename: file3 → file1
   - VFS uses stale cache: file1 → inode 7
   - Tries to drop_nlink on inode 7 (i_nlink already 0)
   - WARNING in drop_nlink()

Fix this by explicitly invalidating old_dentry and new_dentry when
f2fs_add_link fails during whiteout creation. This forces VFS to
refresh from disk on subsequent operations, ensuring cache consistency
even when the rename partially succeeds.

Reproducer:
1. Mount F2FS image with corrupted i_current_depth
2. renameat2(file2, file1, RENAME_WHITEOUT)
3. renameat2(file3, file1, 0)
4. System triggers WARNING in drop_nlink()

Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
Reported-by: syzbot+632cf32276a9a564188d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=632cf32276a9a564188d
Suggested-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/all/20251022233349.102728-1-kartikey406@gmail.com/ [v1]
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Added detailed explanation about VFS not calling d_move() in error path,
  resulting in new_dentry still pointing to inode with zeroed i_nlink
  (suggested by Chao Yu)
- Added Fixes tag pointing to commit 7e01e7ad746b
- Added Cc: stable@vger.kernel.org for backporting to stable kernels
---
 fs/f2fs/namei.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..712479b7b93d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -1053,9 +1053,11 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	if (whiteout) {
 		set_inode_flag(whiteout, FI_INC_LINK);
 		err = f2fs_add_link(old_dentry, whiteout);
-		if (err)
+		if (err) {
+			d_invalidate(old_dentry);
+			d_invalidate(new_dentry);
 			goto put_out_dir;
-
+		}
 		spin_lock(&whiteout->i_lock);
 		whiteout->i_state &= ~I_LINKABLE;
 		spin_unlock(&whiteout->i_lock);
-- 
2.43.0


