Return-Path: <stable+bounces-45640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3870F8CCE38
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 10:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F22C1C216CB
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3426613C68E;
	Thu, 23 May 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="BAiXQTea"
X-Original-To: stable@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD546AF;
	Thu, 23 May 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453269; cv=none; b=pCGhR4FJmKEexTtqAKQBtriMqZapxSGmfVJjSODQgxy+kzQGK9fDDUaml6sdfFaZMm2NAcwmhdn3CfLSZ7FsuCN5Xz4a97vO1tgy257RACY4hAWxXbAURMXI3iTYzACfE2tkHTM9ha6ogLOSWR8s00DAYgV/4+5/AMYqlp0sgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453269; c=relaxed/simple;
	bh=OT5GpYkvqi359dkHE/K6vDw27Z7JCQ5cw7qP+eM0VBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPsWT6FQwK78nqFLSwcMUIKq32RncR01MD+Br6vfzB/JH55HRJ2vSVmY+YBCfCb7kuSJ0xW0xPb6qnJXjKhTXv6RWlcCw4WU+ILZE3vQKTXGooMJESqCs2mK7WnDFY2wH5HFFztxTwJ9YdZA++u++uif+dfXy76nZ5tT4tBJYiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=BAiXQTea; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=HKvZu/1Th/zFJANW3u9Wq82PwjCTymeIwMTRRihlSXg=; b=BAiXQTeaAHv2tk7ig3BINtVaQD
	XphEVhbeOAJ1ZuPEJVz8yqT1gw9LdsEeY1zBQmzicSAejqwAOXIzwi86Nt4i0GxOHsDECDROHbz3T
	8qVgg2/tVtfbQGLYalCVe9umV+/b0gvd/L0VCKfTExbgD1hppCXCusuIdQwQTRh5c0FcK1yt70liw
	zVnmsx6dDXMUEcBdyyAGfRDOf00E/kFa56rY8NjHzNa/CHjezDM1BV1zEUjlpc1szcdOnEKerBYC1
	BH59yzuLk9Yeg0V5129f0rYfUBervxunNbmdKZBeVsIN8o44hI165x2n6pzA2iZOMZ1pmCrvRyNkH
	h/HRLjX7UrFXtI59ZIFmVARZMJu5IW7gza5sul01u7vKpc00SkGRuh/apcosk5XkEYSmG9YmRX1Qg
	oK91vhofiEP8Ne3a0GOooJRy94fAwMrLgx6qR9iCZmxrUEavnZ/7eBvBaYgp+TbnG53klFwwWcr44
	giZONdxRT67iNgOZgRjbEJd+MgA2qsHi/+7oxU1I9wIwE7ILrI+fxQ4H912VOV3VZFgEMIPMnp2wf
	jz2p+YUV/m3tivjNMKVmHpYHg+0hwbWFr1VRj9PHtlOsXQuK56lDiNweKWmkjznl44faZJyemwo48
	hmu8+h7Ai5Unk6KuHYDHKzVLAmS/9p1OfY4cI6zxE=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>, Greg Kurz <groug@kaod.org>,
 Jianyong Wu <jianyong.wu@arm.com>, stable@vger.kernel.org,
 Eric Van Hensbergen <ericvh@gmail.com>, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p: add missing locking around taking dentry fid list
Date: Thu, 23 May 2024 10:34:14 +0200
Message-ID: <3116644.1xDzT5uuKM@silver>
In-Reply-To: <Zk4qcmtot6WEC1Xx@codewreck.org>
References:
 <20240521122947.1080227-1-asmadeus@codewreck.org> <1738699.kjPCCGL2iY@silver>
 <Zk4qcmtot6WEC1Xx@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 22, 2024 7:25:06 PM CEST Dominique Martinet wrote:
> Christian Schoenebeck wrote on Wed, May 22, 2024 at 04:35:19PM +0200:
[...]
> > > diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> > > index f16f73581634..01338d4c2d9e 100644
> > > --- a/fs/9p/vfs_dentry.c
> > > +++ b/fs/9p/vfs_dentry.c
> > > @@ -48,12 +48,17 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
> > >  static void v9fs_dentry_release(struct dentry *dentry)
> > >  {
> > >  	struct hlist_node *p, *n;
> > > +	struct hlist_head head;
> > >  
> > >  	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
> > >  		 dentry, dentry);
> > > -	hlist_for_each_safe(p, n, (struct hlist_head *)&dentry->d_fsdata)
> > > +
> > > +	spin_lock(&dentry->d_lock);
> > > +	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
> > > +	spin_unlock(&dentry->d_lock);
> > > +
> > > +	hlist_for_each_safe(p, n, &head)
> > >  		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
> > > -	dentry->d_fsdata = NULL;
> > >  }
> > 
> > I'm not sure if that works out. So you are moving the list from dentry to a
> > local variable. But if you look at v9fs_fid_find() [fs/9p/fid.c#123] it reads
> > dentry->d_fsdata (twice) and holds it as local variable before taking a
> > lock. So the lock in v9fs_fid_find() should happen earlier, no?
> 
> The comment still works -- if detry->d_fsdata is NULL then
> hlist_for_each_entry will stop short and not iterate over anything (it
> won't bug out), so that part is fine in my opinion.

I meant the opposite: dentry->d_fsdata not being NULL. In this case
v9fs_fid_find() takes a local copy of the list head pointer as `h` without
taking a lock before.

Then v9fs_fid_find() takes the lock to run hlist_for_each_entry(), but at this
point `h` could already point at garbage.

/Christian



