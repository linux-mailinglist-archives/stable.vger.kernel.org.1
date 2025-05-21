Return-Path: <stable+bounces-145741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB4ABE958
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001DC1BA742A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19F922129F;
	Wed, 21 May 2025 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irbx//Nb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30564221286;
	Wed, 21 May 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792423; cv=none; b=GwyFa07i1qc+mVK+80wx6xHCkAsvHqrXB3sf8J0lids4Ogrz3xaRZ7Qi1uTh7QciqXwuQ/eybIr8c+lXG1wAbzU3uojSPuJqxPJTXvqMwiOEOHY7td2pcUh2t2cr4M1UqNpmsvZn3IQ0T8sS6Czsfm//DaV8su1DlImg/nWvH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792423; c=relaxed/simple;
	bh=Gc2wLsdZJ4VVOoyDiAr1GedMXVn4tXBAilIiIQ/pmTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qine+MWKNQ/J/VXapeeydcxbLYwi7XskU2S3F6Dyz6J+abKAbFJycbjz4xz7xanpSvgurlSo8ECEJYa1acSucqg9uuWSbsU7agO3rkcf5pgA2Q8P90Cby4BguA6tVNPclR8Km8cMy6K6fVdl6GLO6Lv9ERvKg9h9Z/FxSnZrOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irbx//Nb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af908bb32fdso4876127a12.1;
        Tue, 20 May 2025 18:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747792421; x=1748397221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujs5YQiN17yXDchSOgu6Dh0Fh8aXzQ/St/pxD5vMTxg=;
        b=irbx//NbWjLpR9RJ5EFQ2E+AH5wk3CIi8eotcpl8/LiGIfGUgPKzCnZ9tUyKxOKh7E
         i1xjUUmw1G4jGfDX1ljYrklejZY7sc/4oSbDDdEcGrXOScJCpb7qg+U9xGmDkpA9dE0N
         V+rcfD9+Y2vj35YNVdVGDQe8z2Uf1e0oHGI8AcEkDk7EQkzw4sNG7BuCP6ULXseg0btM
         XQBk46ijbFjDh7+KYXLsKat5B97w7SXdYILgOxzVxGxyiJbEqAqnAceFcTteu5azjM1s
         x4eRQ7gij+dS6f7i1alupgdm0qJl8q7DWwNKO6Q4p9fQouHRc7pfcB7MQk45wWWMs168
         hrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747792421; x=1748397221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujs5YQiN17yXDchSOgu6Dh0Fh8aXzQ/St/pxD5vMTxg=;
        b=hbYkFDykYx8dsgtKmVc40bhh6yRL8TtjfVq5Dzbq21r0jIQFndoKgqsKvgC9jB+CBY
         DGDP4x38vtQVZN6GuCr6X00Db7o99SkE0zmUnmuW0GlnjvccUmCPTPvjfxNt5kEqnf36
         G9S839T7cMg1rMyOVuFl94ihoQry/kjeIAn5cv3buZfkg/q/HukY57sY7BAMt9arguu9
         S1nBC3acTqIpB5B0/LV2/4rH0OzVb9biGFVVBX/yHDY5pcpeATgWhBciflDPZ1KS88yd
         oTHufOjb2FHoTcuRO7+GwadvdZa64XCJBdGlf8Fl/uIZWaIPkwF7/GkZY/UnVRO7zUvg
         CVyA==
X-Forwarded-Encrypted: i=1; AJvYcCU7IOcqEtvBeYazr4vbl+KYSnRgNRBUJT6AOapBcWWOQXEj6qSVWmH8uLKuCjt+bxNO2Os9Z+FSkM6Joik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxliyw/tPxkkJUt1xH5Wc4nxs2xoMXteQwndpSg0/Ct9uTNs2uP
	0gMl6JciyK21zfqYRjetE8iw6XaQqIs2zZFOUDT2yy7PYwnoIE2lnKFzjM71OWdKkYU=
X-Gm-Gg: ASbGncto1Mttf7emcNVA2wpgguM8GhRlmTeOkTGlEPty0GjEMTIvH5YMvJf9Cjg2/yA
	JCjKOTQne3WfNDW0xNe5OvyfckYqE6ED5JwpBr2C3Fs0sRRvTXk09Uhe/eDjCDWp5hffz4+n7Rj
	qFIRIiKGexKXNjC+ocYaju62IK7YhXOERfWiNxs/9dHfNDsAajwTEmIJOSZsaFYZfzrOW3XHwAY
	j7fFvRbk3JPbgOdeG7e1v7IlLIcwBOzZaahLd+03lI13ptuV8H6tM7KVugfQDnh4167wghYmTCO
	IXZ+df+/7nbPIkaPvmgzj1zVoZMaR+i6cAEAmPYKZB7F
X-Google-Smtp-Source: AGHT+IE/fM9Dhokgf8e/cW4T9LW4ZBUzfphuRhX5MPSmDDLthJi5DSrQ807/7jyljfnvW9DIAdVrLA==
X-Received: by 2002:a17:903:17c7:b0:215:58be:3349 with SMTP id d9443c01a7336-231d4d24ec5mr289947695ad.14.1747792421183;
        Tue, 20 May 2025 18:53:41 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eedb59sm82796665ad.257.2025.05.20.18.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 18:53:40 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>
Subject: [PATCH 5.10 0/5] kernfs: backport locking and concurrency improvement
Date: Wed, 21 May 2025 09:53:30 +0800
Message-ID: <20250521015336.3450911-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN reports concurrent accesses to inode->i_mode:

==================================================================
BUG: KCSAN: data-race in generic_permission / kernfs_iop_permission

write to 0xffffffe001129590 of 2 bytes by task 2477 on cpu 1:
 kernfs_iop_permission+0x72/0x1a0
 link_path_walk.part.0.constprop.0+0x348/0x420
 path_openat+0xee/0x10f0
 do_filp_open+0xaa/0x160
 do_sys_openat2+0x252/0x380
 sys_openat+0x4c/0xa0
 ret_from_syscall+0x0/0x2

read to 0xffffffe001129590 of 2 bytes by task 3902 on cpu 3:
 generic_permission+0x26/0x120
 kernfs_iop_permission+0x150/0x1a0
 link_path_walk.part.0.constprop.0+0x348/0x420
 path_lookupat+0x58/0x280
 filename_lookup+0xae/0x1f0
 user_path_at_empty+0x3a/0x70
 vfs_statx+0x82/0x170
 __do_sys_newfstatat+0x36/0x70
 sys_newfstatat+0x2e/0x50
 ret_from_syscall+0x0/0x2

Reported by Kernel Concurrency Sanitizer on:
CPU: 3 PID: 3902 Comm: ls Not tainted 5.10.104+ #0
==================================================================

kernfs_iop_permission+0x72/0x1a0:

kernfs_refresh_inode at fs/kernfs/inode.c:174
 169 	
 170 	static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 171 	{
 172 		struct kernfs_iattrs *attrs = kn->iattr;
 173 	
>174<		inode->i_mode = kn->mode;
 175 		if (attrs)
 176 			/*
 177 			 * kernfs_node has non-default attributes get them from
 178 			 * persistent copy in kernfs_node.
 179 			 */

(inlined by) kernfs_iop_permission at fs/kernfs/inode.c:285
 280 			return -ECHILD;
 281 	
 282 		kn = inode->i_private;
 283 	
 284 		mutex_lock(&kernfs_mutex);
>285<		kernfs_refresh_inode(kn, inode);
 286 		mutex_unlock(&kernfs_mutex);
 287 	
 288 		return generic_permission(inode, mask);
 289 	}
 290 	

generic_permission+0x26/0x120:

acl_permission_check at fs/namei.c:298
 293 	 * Note that the POSIX ACL check cares about the MAY_NOT_BLOCK bit,
 294 	 * for RCU walking.
 295 	 */
 296 	static int acl_permission_check(struct inode *inode, int mask)
 297 	{
>298<		unsigned int mode = inode->i_mode;
 299 	
 300 		/* Are we the owner? If so, ACL's don't matter */
 301 		if (likely(uid_eq(current_fsuid(), inode->i_uid))) {
 302 			mask &= 7;
 303 			mode >>= 6;

(inlined by) generic_permission at fs/namei.c:353
 348 		int ret;
 349 	
 350 		/*
 351 		 * Do the basic permission checks.
 352 		 */
>353<		ret = acl_permission_check(inode, mask);
 354 		if (ret != -EACCES)
 355 			return ret;
 356 	
 357 		if (S_ISDIR(inode->i_mode)) {
 358 			/* DACs are overridable for directories */

Backport the series from 5.15 to fix the concurrency bug.
https://lore.kernel.org/all/162642752894.63632.5596341704463755308.stgit@web.messagingengine.com

Ian Kent (5):
  kernfs: add a revision to identify directory node changes
  kernfs: use VFS negative dentry caching
  kernfs: switch kernfs to use an rwsem
  kernfs: use i_lock to protect concurrent inode updates
  kernfs: dont call d_splice_alias() under kernfs node lock

 fs/kernfs/dir.c             | 153 ++++++++++++++++++++----------------
 fs/kernfs/file.c            |   4 +-
 fs/kernfs/inode.c           |  26 +++---
 fs/kernfs/kernfs-internal.h |  24 +++++-
 fs/kernfs/mount.c           |  12 +--
 fs/kernfs/symlink.c         |   4 +-
 include/linux/kernfs.h      |   7 +-
 7 files changed, 138 insertions(+), 92 deletions(-)

-- 
2.43.0



