Return-Path: <stable+bounces-145743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE131ABE95C
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29661BA74BD
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC84221738;
	Wed, 21 May 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6VXUa/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD8221717;
	Wed, 21 May 2025 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747792428; cv=none; b=AhTQjTvSX9aIr+V9qfLrgX6ob0AFmyljDhFfrmakJ36Jphh/N9kfVGev7Y22akoJ+zX9vQVeNs5dA4JM/4Lg1kT7Ok3p7lhN9O1fd+OUaog+NomtQkXrLDkufQrVWIOgVLaphOacLrZhRt1gp/Gc3g4H7dfLVfY4L+8k+VrLFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747792428; c=relaxed/simple;
	bh=C+afvCMn4IIFunrreI/koJIOT0K0utwIdt4vaVSFAZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpfFzlOrMwVgrOoenkgFmwDU8oBkT1cdVKR4uBW4SbK2Vp907XyK7uX+VX7jjT/oPvFT2mKofwGcF2LO/048Nf3nrEZZ72k5dlcGeZHkgHacmXJVxjeD3ECYWDFHV9kftImlOT/rb69Z32HmviMWo+CPldlMaaJxKJQ86GMcFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6VXUa/e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-231e8553248so40197245ad.1;
        Tue, 20 May 2025 18:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747792426; x=1748397226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmazB8SGFETg58gqzeNKFWu1xciTSNCHPNcLrwlPpjc=;
        b=J6VXUa/e+Cnma+/wdULh8f4VqO7bzk0QPyh9cfkKavOhui7FDE5X04whc4FcHa22sH
         socehdXU6idvs4iG40xZKhwKt34//azPrfJxwoOiHGAov/+aurePFYs89Ok+i3zcDY9N
         p8P44Vn3f0mKBfO7RoY+CbohB0rTXCw7I2IuYFU4O0qUfX+x5aGqxX6+sxJGJeRq2Q5H
         GnAQYRTwtsWQbY2ncLV4gIXC6AECqhOjEjTijtIRRvvDwvdJ6PlIGGLZTBY8L24hTDot
         z147Q+feMywS+1G1KJsnTSYp/dC4+ECwFvv4EWxM9mhuV7D3MqLntaWUlw9zpF5cPGmO
         qH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747792426; x=1748397226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmazB8SGFETg58gqzeNKFWu1xciTSNCHPNcLrwlPpjc=;
        b=XAQTJUAvx42b77HxJ4TTQWwA0/nDNVeBUHsH0UaNBqYulbgtIJ17XKaRxbdCoNe+SL
         6XT/zQGVax6D/KLaaUNU57mInXdNVdNy1TNo0q0ES1nlhU+RN62GzblEnVeOSC01UGUI
         wE3VVLtbSKCFufJfNf2tuibYTFPT9F/XmX7QOzOqfHww41IPR9UB0uWOnYO+cVuJ3hTU
         vt5O6q5oOg3XbKWVhQQ95A/8VPM65udXWV3kDwTDP6Tu7LOslnjXN7wUTLQQb+kQpwXC
         Bjy9NTi8vpaSGB6ngGSNMtjI8DyNtzIB5we3E+I1CeXDa/tdGeQJn8dTWv1C9K0vrFyr
         jF6w==
X-Forwarded-Encrypted: i=1; AJvYcCXJdCT5rk3n5rzkJGJUiQVM4NaSmM/wp6LnfNUzi7A9Z6rTrAdeUVzcGkFbWnuLkIhWqsbMMl8RzDbbpco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTzQ4jOXlsVJvIfbTmbRsHp//xuICQmpzI1q0IA08U2jvAwSw2
	8TYl2m9QmL5OyRtQ8p2kaAFvti132ZCW74NP95/WRiruzDW+uxGove805m72VlwsO9o=
X-Gm-Gg: ASbGncuJy1RIrXW9tR/2MlqQ9fCx7//jEvhsqOc80YKtbozx7U342V+t7cdOUT0eaWf
	8gu9xHWHAoU7HWWR06/mSFohC3RTHqzWK7gBgVLR0bC+9W2E960KLbIN+6otcx4CpDyk4SzyEEU
	148smJFxx0s3WGZG4CjnuCDiCjR8TxDlYshaym9yRTdrx0fSc3B2XkFHpwVdM7ggRbl+bA+VXNx
	Rn3r9YTiThs3k1fNBk8ZbksPHYy/InT2Rz7dMPEpiYQLXY+ipTp0wTaCv6AqXdluq1Q1oYtYgAJ
	iMXBcz1aOtrR2dU8IOJ9gGkbl00dAbqEPhj4Dv2PnA09
X-Google-Smtp-Source: AGHT+IG0Zo1HpterVv9+DVON0WlhnzTyegJfE0fnvclWPcmXuPaTn+KyY8eAJ1oi4H7dWAGvVrW8/Q==
X-Received: by 2002:a17:902:f610:b0:215:9bc2:42ec with SMTP id d9443c01a7336-231de37f1e3mr222057535ad.47.1747792425935;
        Tue, 20 May 2025 18:53:45 -0700 (PDT)
Received: from gmail.com ([116.237.135.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eedb59sm82796665ad.257.2025.05.20.18.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 18:53:45 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.10 2/5] kernfs: use VFS negative dentry caching
Date: Wed, 21 May 2025 09:53:32 +0800
Message-ID: <20250521015336.3450911-3-dqfext@gmail.com>
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

Commit c7e7c04274b13f98f758fb69b03f2ab61976ea80 upstream.

If there are many lookups for non-existent paths these negative lookups
can lead to a lot of overhead during path walks.

The VFS allows dentries to be created as negative and hashed, and caches
them so they can be used to reduce the fairly high overhead alloc/free
cycle that occurs during these lookups.

Use the kernfs node parent revision to identify if a change has been
made to the containing directory so that the negative dentry can be
discarded and the lookup redone.

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Link: https://lore.kernel.org/r/162642770420.63632.15791924970508867106.stgit@web.messagingengine.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/kernfs/dir.c | 55 +++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9bc73c8b6e3f..1756f7e43aac 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -565,9 +565,31 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
-	/* Always perform fresh lookup for negatives */
-	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
+	/* Negative hashed dentry? */
+	if (d_really_is_negative(dentry)) {
+		struct kernfs_node *parent;
+
+		/* If the kernfs parent node has changed discard and
+		 * proceed to ->lookup.
+		 */
+		mutex_lock(&kernfs_mutex);
+		spin_lock(&dentry->d_lock);
+		parent = kernfs_dentry_node(dentry->d_parent);
+		if (parent) {
+			if (kernfs_dir_changed(parent, dentry)) {
+				spin_unlock(&dentry->d_lock);
+				mutex_unlock(&kernfs_mutex);
+				return 0;
+			}
+		}
+		spin_unlock(&dentry->d_lock);
+		mutex_unlock(&kernfs_mutex);
+
+		/* The kernfs parent node hasn't changed, leave the
+		 * dentry negative and return success.
+		 */
+		return 1;
+	}
 
 	kn = kernfs_dentry_node(dentry);
 	mutex_lock(&kernfs_mutex);
@@ -593,7 +615,6 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	return 1;
 out_bad:
 	mutex_unlock(&kernfs_mutex);
-out_bad_unlocked:
 	return 0;
 }
 
@@ -1104,33 +1125,27 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	const void *ns = NULL;
 
 	mutex_lock(&kernfs_mutex);
-
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
-
-	/* no such entry */
-	if (!kn || !kernfs_active(kn)) {
-		ret = NULL;
-		goto out_unlock;
-	}
-
 	/* attach dentry and inode */
-	inode = kernfs_get_inode(dir->i_sb, kn);
-	if (!inode) {
-		ret = ERR_PTR(-ENOMEM);
-		goto out_unlock;
+	if (kn && kernfs_active(kn)) {
+		inode = kernfs_get_inode(dir->i_sb, kn);
+		if (!inode)
+			inode = ERR_PTR(-ENOMEM);
 	}
-
-	/* instantiate and hash dentry */
+	/* Needed only for negative dentry validation */
+	if (!inode)
+		kernfs_set_rev(parent, dentry);
+	/* instantiate and hash (possibly negative) dentry */
 	ret = d_splice_alias(inode, dentry);
- out_unlock:
 	mutex_unlock(&kernfs_mutex);
+
 	return ret;
 }
 
-- 
2.43.0


