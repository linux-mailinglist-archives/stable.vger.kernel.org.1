Return-Path: <stable+bounces-145742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB863ABE95A
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEAB8A06A3
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4927D221703;
	Wed, 21 May 2025 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HV4qy/rv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA3C221566;
	Wed, 21 May 2025 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792426; cv=none; b=pbitmzYHBw/hPHE8LAwlxoI7kTkqnzJcdmt30LE8aeWdrvxzu27+cRdV7k7pfxYRS/dGQmoT0vieTtFujzP61Egp5PzFGfSqWfspT8lgFadvshR8X6G8pEdWdrHgMNxHXL+uFSlpaQsyheLBCiozqxk42lG3h7IW+wYN7/nP35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792426; c=relaxed/simple;
	bh=sHb/J9Bj3RuS0R9Ns3i1O97fDwtUFjQVqaYU568TKLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAO8EaGOdFKi7nZ4JTvlM34EJzxgcxNARsHz4KcKcjl85KmVilv3sUPDrPWSQ3DOrlSxwoM+eh8XYuSPhwMesnsXdi8BRcU8cAHA0YbsAQB7xxD/AYxIyU4NtBgOspLrLcfQPSLzuJ0qd19eepsws702ZqDKx16Uyu99bXDbF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HV4qy/rv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f5cd984cso4627284a12.3;
        Tue, 20 May 2025 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747792424; x=1748397224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Korba43DFjEJPqDuJnEN7vEVXDmofbc7scbiwYjjmFI=;
        b=HV4qy/rvzQbgfFv36hasXCKyznv3tR69WsVVNaBvQ75RJZNeT5KkZceNCAZl3a8naM
         MGPoAG+Jt4IEGPbEbrytHOmcra81I9ErB/r2f2SgTfhzhSN+hH0bQwMJfDo+o8azN6v6
         PYcD+EZqTKSbHVP+z8JTBXP4uzV10bZnunl+/OexOa8mnUdjuZRb4iqE2oiI8QbbtpHd
         bTTyfHiVY+eDx1LnLYQJ2WYeWdVz4/uMmx3CHh3HuyKCtOTwv6DUiK+cDpe35cySDuvw
         3YqLeGPMM4JA5Su10fL0OSut8LEe6ZA6bCyBkSytacrGnkq51fZ6K79dIyC2hjzHhOei
         EvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747792424; x=1748397224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Korba43DFjEJPqDuJnEN7vEVXDmofbc7scbiwYjjmFI=;
        b=vQ2O488mhmfSIkcQOMTzzDi6DTZEW3QVCJYFzKm/7Ojo7+AL7W1cUTj0tmBV1QRoPc
         XXBOH71gjWX4u9k5hcnB0PKfVOgHB54qDJYeJuaABf/9A/yxv3TrNEIQ+aTp4LiQMxXY
         u4Oovg7B/1LrbqHBuqpb9QuzkAzaJTVJMuEkPLaxLTsmQveACYST9i3SwgyaeDtckXgG
         iG3cX3CfTNjK8vuWmAFGOK78ub83EP22Jwejy4PoM8+rQZh0ObFZClAwB5aZK1cru/o4
         bMRV4noUJj3dahaU1doAeWp6nfa0nFBFT6Irc1sGUIK7DW+z/mBEAZ9v/rEeUT3o8nWJ
         5gmg==
X-Forwarded-Encrypted: i=1; AJvYcCWUC2yeCaTkjfjdftZh/F898ft2cBb2icXtelG1nu5xKGmQeSFncsULT3DZrn5YW3hfTLqjaQdmUz7zPYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0TsrBZOUextr1dPERkjnnVE/hHNuWoh59bhE3ETpVOY6Dsl0
	ZdyaylcN7Vosn70/y+KFKgI6T9euca3iJyk/qfmtZzu+AMfPCnGmKRHKE5ZSLxD3lVQ=
X-Gm-Gg: ASbGnctJ1Sh0Ohyk1Y1QL1FEQO+6OFGjFAerjnH7AZNCgfA4K7HxGgBWu4FeI6J+8Nc
	G5+9Fq//Cbzd4TR6xGXrMU7P1fAI+f77C4HR7GHRiyAXeoUl+t1XmEtzH/6OiROAeInvAvqgt4y
	XPliprkQQrNMbXVYmfJYwkbXBhPa/hFzB16RUCD+d6ca21fsWW+gn0klVN2IS7SXHSU/0WlUirR
	1ZG9Poz4ytXLN8d2+pAFMX4DKuEUgiw7M8mEdXRbLHBk0kKiVolFM/sbBh78dkMKVZxE6i4L80o
	zUMAcWQ0UqODWnk1w3VtHYPxE76nzSKhAMYIEMUzBgad
X-Google-Smtp-Source: AGHT+IH0rXmolDEHltNkvlPgF/VomByzNWmKraPYTA/oCfbi2ipk4LtHCQKDIwoi9vpzvLT4wVI2eg==
X-Received: by 2002:a17:903:17cb:b0:229:1cef:4c83 with SMTP id d9443c01a7336-231d438b415mr276087975ad.4.1747792423616;
        Tue, 20 May 2025 18:53:43 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eedb59sm82796665ad.257.2025.05.20.18.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 18:53:43 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.10 1/5] kernfs: add a revision to identify directory node changes
Date: Wed, 21 May 2025 09:53:31 +0800
Message-ID: <20250521015336.3450911-2-dqfext@gmail.com>
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

Commit 895adbec302e92086359e6fd92611ac3be6d92c3 upstream.

Add a revision counter to kernfs directory nodes so it can be used
to detect if a directory node has changed during negative dentry
revalidation.

There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
on all architectures and as far as I know that assumption holds.

So adding a revision counter to the struct kernfs_elem_dir variant of
the kernfs_node type union won't increase the size of the kernfs_node
struct. This is because struct kernfs_elem_dir is at least
sizeof(pointer) smaller than the largest union variant. It's tempting
to make the revision counter a u64 but that would increase the size of
kernfs_node on archs where sizeof(pointer) is smaller than the revision
counter.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Link: https://lore.kernel.org/r/162642769895.63632.8356662784964509867.stgit@web.messagingengine.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c             |  2 ++
 fs/kernfs/kernfs-internal.h | 19 +++++++++++++++++++
 include/linux/kernfs.h      |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 0ba056e06e48..9bc73c8b6e3f 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -380,6 +380,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	/* successfully added, account subdir number */
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
+	kernfs_inc_rev(kn->parent);
 
 	return 0;
 }
@@ -402,6 +403,7 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
+	kernfs_inc_rev(kn->parent);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 7ee97ef59184..6a8d0ca26d03 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -81,6 +81,25 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 	return d_inode(dentry)->i_private;
 }
 
+static inline void kernfs_set_rev(struct kernfs_node *parent,
+				  struct dentry *dentry)
+{
+	dentry->d_time = parent->dir.rev;
+}
+
+static inline void kernfs_inc_rev(struct kernfs_node *parent)
+{
+	parent->dir.rev++;
+}
+
+static inline bool kernfs_dir_changed(struct kernfs_node *parent,
+				      struct dentry *dentry)
+{
+	if (parent->dir.rev != dentry->d_time)
+		return true;
+	return false;
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 89f6a4214a70..195afa63ab1c 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -98,6 +98,11 @@ struct kernfs_elem_dir {
 	 * better directly in kernfs_node but is here to save space.
 	 */
 	struct kernfs_root	*root;
+	/*
+	 * Monotonic revision counter, used to identify if a directory
+	 * node has changed during negative dentry revalidation.
+	 */
+	unsigned long		rev;
 };
 
 struct kernfs_elem_symlink {
-- 
2.43.0


