Return-Path: <stable+bounces-7850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956E81801F
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 04:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3C287994
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 03:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B918A469D;
	Tue, 19 Dec 2023 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="lz8/gz2I"
X-Original-To: stable@vger.kernel.org
Received: from cyan.elm.relay.mailchannels.net (cyan.elm.relay.mailchannels.net [23.83.212.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CD65235
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id BE7CE941958
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 03:11:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a284.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5A62E9419B6
	for <stable@vger.kernel.org>; Tue, 19 Dec 2023 03:11:07 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1702955467; a=rsa-sha256;
	cv=none;
	b=tw86QBe3eY9kXauT6BGreG8bJxHmBRcPaXI6HvUyeXoOhhi/xZr5A8cEEqLQbmaE79p2+f
	IvSqi4Y0f54tfT7viecOzKniOI23OKj6NLOVz1tLfVg4iwOenfj6ujmOnTTTddNdhEbG1b
	b5aTXLosdGmycZbrJvGaFwkdR+ql0B9QzABuX48YJ722+FjwkPC4GDxHOGQKH5NEdnTFHc
	CKgy5CzFKAOL0nF5Q7x+AnWsMDArg41s9kfh8WF71D3rYJ8c4zfJ5jq7DFiJaPMb1wecWo
	geInSBqcAYtmbkSwm2Yog/Kf6yIklatFw9nkmJqg36WssJx8EBsvoPTqGBmijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1702955467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RDeSFrPo4QpkkbZHDimJaYXm2rAX/T1+vvhxCCNkbLc=;
	b=Zi2m1XBkUU8cTddcdMasNBdStegeyw/JNK+i1Y+OJq3pRfmCO0OI6IU7xVPZtJtb5iQHTO
	NaWZkjkxqKZIZx6q9x6bLHTT0SqK2lX4aBRr+nJE9tZC2a/VNMnv/Pl9a4tvXtESIKq9+p
	VBK3cNz4SfCM3Bqkb6SqJqaHePnQk0xewUhnR7VosuHdutwFKr2R6R1kA6QYdRs733Ogtz
	YPvm9RuxhKmnomnpEaUHtgNfsH3xaqOHezDSL1gwvSJ7Y7Yk3N2n5RDAwFhMc7KROyHd+8
	A7E1jR9P5yAFdtnssrC1Lfj7EchFQBX7vp6mi0qO7Lb2dvIJdzy4oaAS2C1gfw==
ARC-Authentication-Results: i=1;
	rspamd-659dcc87c8-jfhgx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Language-Glossy: 0e8dfa0036f9bf90_1702955467596_3728054773
X-MC-Loop-Signature: 1702955467596:226872270
X-MC-Ingress-Time: 1702955467595
Received: from pdx1-sub0-mail-a284.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.237.60 (trex/6.9.2);
	Tue, 19 Dec 2023 03:11:07 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a284.dreamhost.com (Postfix) with ESMTPSA id 4SvMCb0j5JzK7
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 19:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1702955467;
	bh=RDeSFrPo4QpkkbZHDimJaYXm2rAX/T1+vvhxCCNkbLc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lz8/gz2IoNKJBEAH3jrV3958ToJvP/Czp9/XRDP5bEKMP2PwVj0LQBX+IgXNR5LwV
	 j3aRdWb/ioXTRpzs0BOuwVzCyiPDHBZKG4NWsAax3o0vyIGoZR+Cy/riM6jglPOFOn
	 /Trx6NeX3qkKHXkhQAKj6KtBEDvucWp29uMhYhflOddSpegNR2ydczM3wwgvRR/XPO
	 rf6QlKTDAAWJVxkAepXchYw6pq9mQG1pJI0Vbx7m30KYMAgEcFV5YKHN3kFHusaSmC
	 qD9svdJbsNrbdZNlO6LQHVHppruptYQAAGxWUqDfVkBG2jGI9X+XBpcs0LaxxGuNjU
	 GVABSroqIg/xw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e01c0
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Mon, 18 Dec 2023 19:10:33 -0800
Date: Mon, 18 Dec 2023 19:10:33 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mszeredi@redhat.com
Subject: [PATCH 6.1.y] fuse: share lookup state between submount and its
 parent
Message-ID: <20231219031033.GA2608@templeofstupid.com>
References: <2023121707-fidgety-tingle-3302@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121707-fidgety-tingle-3302@gregkh>

commit c4d361f66ac91db8fc65061a9671682f61f4ca9d upstream.

Fuse submounts do not perform a lookup for the nodeid that they inherit
from their parent.  Instead, the code decrements the nlookup on the
submount's fuse_inode when it is instantiated, and no forget is
performed when a submount root is evicted.

Trouble arises when the submount's parent is evicted despite the
submount itself being in use.  In this author's case, the submount was
in a container and deatched from the initial mount namespace via a
MNT_DEATCH operation.  When memory pressure triggered the shrinker, the
inode from the parent was evicted, which triggered enough forgets to
render the submount's nodeid invalid.

Since submounts should still function, even if their parent goes away,
solve this problem by sharing refcounted state between the parent and
its submount.  When all of the references on this shared state reach
zero, it's safe to forget the final lookup of the fuse nodeid.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 fs/fuse/fuse_i.h | 15 ++++++++++
 fs/fuse/inode.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 98a9cf531873..a9681fecbd91 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,19 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/* Submount lookup tracking */
+struct fuse_submount_lookup {
+	/** Refcount */
+	refcount_t count;
+
+	/** Unique ID, which identifies the inode between userspace
+	 * and kernel */
+	u64 nodeid;
+
+	/** The request used for sending the FORGET message */
+	struct fuse_forget_link *forget;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -155,6 +168,8 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+	/** Submount specific lookup tracking */
+	struct fuse_submount_lookup *submount_lookup;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bc3c3e76c646..f81000d96887 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -68,6 +68,24 @@ struct fuse_forget_link *fuse_alloc_forget(void)
 	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUNT);
 }
 
+static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
+{
+	struct fuse_submount_lookup *sl;
+
+	sl = kzalloc(sizeof(struct fuse_submount_lookup), GFP_KERNEL_ACCOUNT);
+	if (!sl)
+		return NULL;
+	sl->forget = fuse_alloc_forget();
+	if (!sl->forget)
+		goto out_free;
+
+	return sl;
+
+out_free:
+	kfree(sl);
+	return NULL;
+}
+
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
@@ -83,6 +101,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->attr_version = 0;
 	fi->orig_ino = 0;
 	fi->state = 0;
+	fi->submount_lookup = NULL;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
@@ -113,6 +132,17 @@ static void fuse_free_inode(struct inode *inode)
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
+static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
+					 struct fuse_submount_lookup *sl)
+{
+	if (!refcount_dec_and_test(&sl->count))
+		return;
+
+	fuse_queue_forget(fc, sl->forget, sl->nodeid, 1);
+	sl->forget = NULL;
+	kfree(sl);
+}
+
 static void fuse_evict_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -132,6 +162,11 @@ static void fuse_evict_inode(struct inode *inode)
 					  fi->nlookup);
 			fi->forget = NULL;
 		}
+
+		if (fi->submount_lookup) {
+			fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
+			fi->submount_lookup = NULL;
+		}
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(!list_empty(&fi->write_files));
@@ -311,6 +346,13 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
+static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
+				      u64 nodeid)
+{
+	sl->nodeid = nodeid;
+	refcount_set(&sl->count, 1);
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr)
 {
 	inode->i_mode = attr->mode & S_IFMT;
@@ -368,12 +410,22 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	 */
 	if (fc->auto_submounts && (attr->flags & FUSE_ATTR_SUBMOUNT) &&
 	    S_ISDIR(attr->mode)) {
+		struct fuse_inode *fi;
+
 		inode = new_inode(sb);
 		if (!inode)
 			return NULL;
 
 		fuse_init_inode(inode, attr);
-		get_fuse_inode(inode)->nodeid = nodeid;
+		fi = get_fuse_inode(inode);
+		fi->nodeid = nodeid;
+		fi->submount_lookup = fuse_alloc_submount_lookup();
+		if (!fi->submount_lookup) {
+			iput(inode);
+			return NULL;
+		}
+		/* Sets nlookup = 1 on fi->submount_lookup->nlookup */
+		fuse_init_submount_lookup(fi->submount_lookup, nodeid);
 		inode->i_flags |= S_AUTOMOUNT;
 		goto done;
 	}
@@ -396,11 +448,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		iput(inode);
 		goto retry;
 	}
-done:
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
+done:
 	fuse_change_attributes(inode, attr, attr_valid, attr_version);
 
 	return inode;
@@ -1439,6 +1491,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
 	struct inode *root;
+	struct fuse_submount_lookup *sl;
+	struct fuse_inode *fi;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1461,12 +1515,27 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * its nlookup should not be incremented.  fuse_iget() does
 	 * that, though, so undo it here.
 	 */
-	get_fuse_inode(root)->nlookup--;
+	fi = get_fuse_inode(root);
+	fi->nlookup--;
+
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
 		return -ENOMEM;
 
+	/*
+	 * Grab the parent's submount_lookup pointer and take a
+	 * reference on the shared nlookup from the parent.  This is to
+	 * prevent the last forget for this nodeid from getting
+	 * triggered until all users have finished with it.
+	 */
+	sl = parent_fi->submount_lookup;
+	WARN_ON(!sl);
+	if (sl) {
+		refcount_inc(&sl->count);
+		fi->submount_lookup = sl;
+	}
+
 	return 0;
 }
 
-- 
2.25.1


