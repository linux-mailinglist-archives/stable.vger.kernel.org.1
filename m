Return-Path: <stable+bounces-45591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D879C8CC57A
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 19:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382E7B2298B
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F5F1420CC;
	Wed, 22 May 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="MD3YR4Ix"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8349D2B9C3;
	Wed, 22 May 2024 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398740; cv=none; b=BTfwDm9zHYmgw7SOJTvxd33s2gGKRMQECSv+hDW1kb3myvJmR035tVvzfwqOOvLNVc2NxAFiwu2kJokZvimbLEVXh/rAO0XIOq/+YV0ZdiSds+nkN1k8BFuqD/y5GMpWgHfjmXflAoGoM9VzH0/qcwAPp5jgDTT1EoBAflhqj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398740; c=relaxed/simple;
	bh=iMNRZ7+0rdrHnxvP4fjqemrREgUEcpP0yPTxazQ+uZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frLmEccHmhvqCpo0S9Mqmqx52/IkSeE1zRlY6LWLn30S8hm2Xty7nkjp0EDRBJxuSLDAABEQ+qLB2SnRVR1S9RIsuGGcnkLWn2TU6yXKNTe+Ql2+4TehYYUN80IEsMiamrxW8tCsVIN8lzixQhcyrTWrmE9/aIqKqj3ICq/omGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=MD3YR4Ix; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 6E59714C2DB;
	Wed, 22 May 2024 19:25:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1716398729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MjYx+oNvZPdABC1fXs5E8e+EjlgfWp0VoNQKSmEu+fQ=;
	b=MD3YR4Ixj7oVgewBNwgIsxglU5w4112AoNmfjYY1jtMl8C7k2cBzw4AbcIgQk7rh4jB1LG
	Us+7l55fj/p3iepLENOckJxNGoa/GP37ZV2FGxExEZGI89/AHadkWdExALrgZQ5aGy8v72
	zT0G0dMYmUNfuZue8NN+qdT0+gcL71KVq/Y8uGQXTENOCK/bqjjYjJcUqMPdbdPcGL83vZ
	fsxJ3m09AFHJxHQxoFvVJOpiiNnqMD6BE9S2niC4YWDlmBWiXBNmqUA0ZObA3a2J0JdEZa
	FyYMUUunbaKNKJAn3nGCFp7rqem7TEltF9YtISKD8oWkBGHDb4aB1K/KgyIItw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 4bffc3c6;
	Wed, 22 May 2024 17:25:21 +0000 (UTC)
Date: Thu, 23 May 2024 02:25:06 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
	Jianyong Wu <jianyong.wu@arm.com>, stable@vger.kernel.org,
	Eric Van Hensbergen <ericvh@gmail.com>, v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: add missing locking around taking dentry fid list
Message-ID: <Zk4qcmtot6WEC1Xx@codewreck.org>
References: <20240521122947.1080227-1-asmadeus@codewreck.org>
 <1738699.kjPCCGL2iY@silver>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1738699.kjPCCGL2iY@silver>

Christian Schoenebeck wrote on Wed, May 22, 2024 at 04:35:19PM +0200:

Thanks for the review!

> On Tuesday, May 21, 2024 2:29:46 PM CEST Dominique Martinet wrote:
> > Fix a use-after-free on dentry's d_fsdata fid list when a thread
> > lookups a fid through dentry while another thread unlinks it:
> 
> I guess that's "looks up". :)

Err, I guess.

> > UAF thread:
> > refcount_t: addition on 0; use-after-free.
> >  p9_fid_get linux/./include/net/9p/client.h:262
> >  v9fs_fid_find+0x236/0x280 linux/fs/9p/fid.c:129
> >  v9fs_fid_lookup_with_uid linux/fs/9p/fid.c:181
> >  v9fs_fid_lookup+0xbf/0xc20 linux/fs/9p/fid.c:314
> >  v9fs_vfs_getattr_dotl+0xf9/0x360 linux/fs/9p/vfs_inode_dotl.c:400
> >  vfs_statx+0xdd/0x4d0 linux/fs/stat.c:248
> > 
> > Freed by:
> >  p9_client_clunk+0xb0/0xe0 linux/net/9p/client.c:1456
> 
> That line number looks weird.

I have a p9_fid_destroy there (as of a v6.9-rc5 tree); might have moved
a bit though.
Unfortunately it's inlined so the stack trace only has kfree() next
which is why I cut the trace there; I don't think it really matters?

> >  p9_fid_put linux/./include/net/9p/client.h:278
> >  v9fs_dentry_release+0xb5/0x140 linux/fs/9p/vfs_dentry.c:55
> >  v9fs_remove+0x38f/0x620 linux/fs/9p/vfs_inode.c:518
> >  vfs_unlink+0x29a/0x810 linux/fs/namei.c:4335
> > 
> > The problem is that d_fsdata was not accessed under d_lock, because
> > d_release() normally is only called once the dentry is otherwise no
> > longer accessible but since we also call it explicitly in v9fs_remove
> > that lock is required:
> > move the hlist out of the dentry under lock then unref its fids once
> > they are no longer accessible.
> > 
> > Fixes: 154372e67d40 ("fs/9p: fix create-unlink-getattr idiom")
> > Cc: stable@vger.kernel.org
> > Reported-by: Meysam Firouzi
> > Reported-by: Amirmohammad Eftekhar
> > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > ---
> >  fs/9p/vfs_dentry.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> > index f16f73581634..01338d4c2d9e 100644
> > --- a/fs/9p/vfs_dentry.c
> > +++ b/fs/9p/vfs_dentry.c
> > @@ -48,12 +48,17 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
> >  static void v9fs_dentry_release(struct dentry *dentry)
> >  {
> >  	struct hlist_node *p, *n;
> > +	struct hlist_head head;
> >  
> >  	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
> >  		 dentry, dentry);
> > -	hlist_for_each_safe(p, n, (struct hlist_head *)&dentry->d_fsdata)
> > +
> > +	spin_lock(&dentry->d_lock);
> > +	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
> > +	spin_unlock(&dentry->d_lock);
> > +
> > +	hlist_for_each_safe(p, n, &head)
> >  		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
> > -	dentry->d_fsdata = NULL;
> >  }
> 
> I'm not sure if that works out. So you are moving the list from dentry to a
> local variable. But if you look at v9fs_fid_find() [fs/9p/fid.c#123] it reads
> dentry->d_fsdata (twice) and holds it as local variable before taking a
> lock. So the lock in v9fs_fid_find() should happen earlier, no?

The comment still works -- if detry->d_fsdata is NULL then
hlist_for_each_entry will stop short and not iterate over anything (it
won't bug out), so that part is fine in my opinion.

What should be improved though is that if dentry->d_inode we can still
look by inode even if there was a d_fsdata as log as fid wasn't found,
e.g.:
-----
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..c72825fb0ece 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -131,9 +131,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 			}
 		}
 		spin_unlock(&dentry->d_lock);
-	} else {
-		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
+	}
+	if (!ret && dentry->d_inode)
+		ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
 	}
 
 	return ret;
----

I don't think that has to be part of this commit though, the worst that
can happen here is an extra lookup to server instead of a use after
free; I'll send a separate patch for this.

-- 
Dominique Martinet | Asmadeus

