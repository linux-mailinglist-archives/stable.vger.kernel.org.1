Return-Path: <stable+bounces-145745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EA3ABE960
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C4D8A0D38
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AC221DBD;
	Wed, 21 May 2025 01:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XplQ3WWI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8898221DB0;
	Wed, 21 May 2025 01:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792433; cv=none; b=qQ2lalGpfmuRzAHDO+/vgKkKJsix5pFtLsgsMClAzM5VotKprY5CylltFXDlvqyN8DOVK55j602QsF2655osLVUCddNkflOvXXmDnWvPBnuS3fG0Y4oiaNh6O8f9w0ML/nFRwtFFuNfhcPHyBhaAUmLlva/mqe0hD/qOYlTV+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792433; c=relaxed/simple;
	bh=Jmqb0qfzmckFPdhbVbqdMz2SzJYxVZTMfB26alyr/T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfY2YRvgml/2LesAtZZxVBtZKoW4prShLCEGrSOPDiYXvTAgJpVMGDao0xLQdROgUj999YP0iCrTsPGKG+rYqvS0HZ+gb82qt4Liy2LTmoQHxHaUZVtFtzahic9WKbdiDGt3/oP/A27f7A+fpX7/CTn3BXb154X6UwUYhDCDK9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XplQ3WWI; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so4769661a12.2;
        Tue, 20 May 2025 18:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747792431; x=1748397231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk7hGdbueTM/XeD7quVK27Y9jexgacMzkbIco6Hgcyk=;
        b=XplQ3WWIwg5AdiTE6f1/XgVmqtJ7gZYOvuJ9Gs3VhxhS5d1jtd8BcUwKSI2OCOoJsx
         Kbc1tVuy/dCb+r9f8K/ZZnjXeq00L6Di9llByCDqstjXc+o/BvGBd4wiULjZxXchZvma
         RcBjJCuqcNeN7ItnVoImJzoxc1n315B2rjU7u0rKPRU2fNUUg9/g8Myft6z441K2M1+Z
         KUzmei8YGzzls1fp8Jo9Mnj3409ghK3WNLgSV/qWob/DPKo6NJfeMxiBdKQ0d3HD2vuV
         MG4FIYspRrkX+9NhiDasyr2ee82qbEBS4I5YNiSr1QebE7S1oieeEkFro3PjnzUwHe7A
         x+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747792431; x=1748397231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk7hGdbueTM/XeD7quVK27Y9jexgacMzkbIco6Hgcyk=;
        b=q52Wy4yP/yPqmgnfq9agMVUSyhO4ahulN6ZmDZSMqEQYtXxFNu6LgFL+9Bq75IA9cS
         IzPYazWIYtHSSTyTV5ZfJTrCaxDAgFw6uDRukI3d8NfCydTyDZZd+3aA+zaAPEKN5cG8
         pAk+MrHpFIQ7jTHUx/1R6I6sBmii/GI6o7M6K++4zsKXeK8wMleyF/fn5y+FyUM4+Re0
         iMlSVsFlYDBDWdaZFXYKtyszjLbWsy8KkunRqlnGKXUacLSAL5Yf9n5Fgxh6CMFeS543
         hm6AzEi9jnkEk8RUMOQx/vIIB1/cSGplNfl1gKBkqOnbAnkbKx93NdWgZpK3pcwtB/xC
         nrRw==
X-Forwarded-Encrypted: i=1; AJvYcCV7MgLZiqpFQw7VazhLO/Bq8bCYhqbk8BOYb7kj6lFlESOxmUjyyIlKy/SY0HhhDjGiaVf16jmqeJpcKQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6U4vGtEfn7RmFIel8xw+G9r+V6Ou0JRk/Fv1pKgXPcSagl0w
	TznZ3iSzceKX7o6rHpGlo7nTBXvs0+oEgpFXy1qotMNCd0UiRR3SLGiwIaLywYyToFc=
X-Gm-Gg: ASbGncsrlokvI+srTTApyKX3PZe7e3QNajC7tYE3XSOy35w2XaqkRyC0GPX4SlZQcq2
	g6gc8LVVr65oETPEeVyZsa1JsKYqHkQ2aoQPdpWCZ3RcobyrBQfdtsuOVciCq3isuvx7FAvKx+B
	ZXhVmU3z44P8LtnUeqnDZ3b1AgOL8cRVDMJD1F1oGkMSWbc2Uz7oeNHVZ3hJiT1te9aLwB+pNXA
	+8cPGN0eAnMzqpqWSOQFc2iTT9pgMVADB1c/QwUb53yGaQR6Q+8lUrOBnASWecPjpxWiEy4S2hj
	0zca4qu8pjBvZNRw0cxYB9witKMD2Pz1iq4D2rwiIorAhiRJWZuHmDQ=
X-Google-Smtp-Source: AGHT+IH6lYx4FVOHg5TaGuxx99FiGF29bNGDqe6QIzkNykPL9egSxg4wMfSRAq3/FRMwd9DOOaDIOg==
X-Received: by 2002:a17:903:1acf:b0:224:255b:c934 with SMTP id d9443c01a7336-231d4583e46mr245108885ad.51.1747792430928;
        Tue, 20 May 2025 18:53:50 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eedb59sm82796665ad.257.2025.05.20.18.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 18:53:50 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.10 4/5] kernfs: use i_lock to protect concurrent inode updates
Date: Wed, 21 May 2025 09:53:34 +0800
Message-ID: <20250521015336.3450911-5-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521015336.3450911-1-dqfext@gmail.com>
References: <20250521015336.3450911-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Kent <raven@themaw.net>

Commit 47b5c64d0ab5e7136db2b78c6ec710e0d8a5a36b upstream.

The inode operations .permission() and .getattr() use the kernfs node
write lock but all that's needed is the read lock to protect against
partial updates of these kernfs node fields which are all done under
the write lock.

And .permission() is called frequently during path walks and can cause
quite a bit of contention between kernfs node operations and path
walks when the number of concurrent walks is high.

To change kernfs_iop_getattr() and kernfs_iop_permission() to take
the rw sem read lock instead of the write lock an additional lock is
needed to protect against multiple processes concurrently updating
the inode attributes and link count in kernfs_refresh_inode().

The inode i_lock seems like the sensible thing to use to protect these
inode attribute updates so use it in kernfs_refresh_inode().

The last hunk in the patch, applied to kernfs_fill_super(), is possibly
not needed but taking the lock was present originally. I prefer to
continue to take it to protect against a partial update of the source
kernfs fields during the call to kernfs_refresh_inode() made by
kernfs_get_inode().

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Link: https://lore.kernel.org/r/162642771474.63632.16295959115893904470.stgit@web.messagingengine.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/inode.c | 18 ++++++++++++------
 fs/kernfs/mount.c |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index ddaf18198935..73d7d4a24c51 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -189,11 +189,13 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
-
 	generic_fillattr(inode, stat);
+	spin_unlock(&inode->i_lock);
+	up_read(&kernfs_rwsem);
+
 	return 0;
 }
 
@@ -275,17 +277,21 @@ void kernfs_evict_inode(struct inode *inode)
 int kernfs_iop_permission(struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
+	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	ret = generic_permission(inode, mask);
+	spin_unlock(&inode->i_lock);
+	up_read(&kernfs_rwsem);
 
-	return generic_permission(inode, mask);
+	return ret;
 }
 
 int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index baa4155ba2ed..f2f909d09f52 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -255,9 +255,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;
-- 
2.43.0


