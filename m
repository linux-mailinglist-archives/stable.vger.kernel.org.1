Return-Path: <stable+bounces-203046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF61DCCEA14
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 07:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B9E33024CB0
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C91295DBD;
	Fri, 19 Dec 2025 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EijRxJkD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF7422126D
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766124991; cv=none; b=tWZsK5We4EfkQEk+xem4pxTSmKLZAE/liiWTBvji4+hQqFHjX5LtKSPFUug/XOSG6fYD5CINT09rWJ26WK5kbchCjNnES2dDybbuMKQpMXp3ArChHcqquQKh9djXt41SxGxlVRD0sg3Csato8R5raSgGnwk7AKa22002CagkkUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766124991; c=relaxed/simple;
	bh=OnrIFQUB4ExlEwB1YTATumAbARUFTj28yPXWy8+zlWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpib5v7dEAt2IN43YdhKeGV+UeJX5cC1nbUsWjjhxDUjkD65r3QJbqaPjm0hb9nnwGIgkru47pfWnvBXWStAU0BOv/GlHPPx1S4J7mmAES6S58j7PsFCEaWiuwufjM7czpn/tO02ifaUGZM8T8TvEPaXUjZ/N/4wuP/ZVdUk4HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EijRxJkD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7aab7623f42so1763982b3a.2
        for <stable@vger.kernel.org>; Thu, 18 Dec 2025 22:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766124989; x=1766729789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHzT4fbzJhXllsJLzXfqINlUIg8kKKYMhv+QaXph3dI=;
        b=EijRxJkDlhf5JZHIzN17ZdTrxRU43C4tt9HtekamCsTZXmlHeed/q1GbGJPhcuRHe4
         +IZUBIG3aAgsn1zGj7VqAHT6e1Jwp4nEkXbkPxHnW6n0bmI0le+UtXzScuSsr/XFuuOZ
         GPFlB+00tk0qZV0n/Jfn1CRPp45PbOmmbq8dXbb5pYiRimc04b2xq/TOWKvB+jr+xEet
         5y6Hn51g8dBx5uIj13zpIo7iAt/WxBOENq24LYGhHo8xtikIALEy6N0LkqzftwgWTWhW
         Z5DQ6YPmcp1TruRdIowI95tPOALD01hGMRe3wVlexfNSyYq6uwnut2OMicCz1OWRPi/g
         NBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766124989; x=1766729789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHzT4fbzJhXllsJLzXfqINlUIg8kKKYMhv+QaXph3dI=;
        b=ZQH8YB+H2rN98fRgJHrvPjDp36PrvRscOC56fNwZi6oe0uSCkRHpl878t0xlowf2U4
         B20+/xCenA8uX71KRQW/WH351IJ2Kl4h/ZyBMkfzENge/G6xOav2j3dCFETCsRh1UY0l
         YE4h1DKBj+/Ww8RycryvFBlix4is2KIti7AG09AEJzTyNF44dmEaWCjm9QxxXUtn4dlT
         g9BGEG4Ph+ElhOwNTOPShpaqPRgFumktEqDC4zLgvUPyPAkgGPmvMsBn7h+ewo4mwiFi
         NAwELyPjA4GqRitCaj73hDNnpsUKxoiisEeijze5NRoH9amBgL+uL7Fa8/bkp6sDahch
         XOpw==
X-Forwarded-Encrypted: i=1; AJvYcCU9g953+/qiIg3WVYSg404LoX+UI2PQTYumOkbHrLXgJ6bjeAJTDxkcDE58E82RcjZCJJEx4CI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SvwiHlTD3TtaNiM8D98xcI7MAre1D9E/u+tKoDOz3Z2UuN4o
	b9uIm8041ENIZxLGD3QSrgEdFomQLkVxLvJ460JhHBtkP6xLH5HLYHPU
X-Gm-Gg: AY/fxX5c3C+3/75mcURXPB9rmTbUEwN8zUHcB80AcI91UNa+qIZJJ6EiGi/c7iHaj/y
	bK3rVWw/vZ5NASFaDXauL4M0AcTWzCxxGr1HUi0b6mnpNwr1vvcmy9MRriglp4JqL+DA3cnoQaz
	d5pi+ET5WAz9nMtCMtu0vBJBSM7F4k/JMw0qGWfhQB4cm8EpTjlY+91UYHCcL8fgTPpITyn++cm
	428zpHlxUOJfO5zNBZyhhPUDREU4DUwv9tCxmrFHgno9CyxHS03fbjAU+ephG9kQY9r9XossNrY
	cL8Tx3BNFkCNapjiEPCWt5IMGOBNRWHF8SWXuAK39ftsYkkJQHQxLSjRhvHRl4PEUA8dPnsivKk
	LWS39QKFDoXAJJ8a1FJ/rxuY3XHBxGL4mYtFq0ctkXEpZjCY4qCEBaRDHpZriOL73Nezi3M6fEb
	XvkMHXWO8W8DwF
X-Google-Smtp-Source: AGHT+IGm+pTFWYSXcQQMWOucEyKVmnCmUebgq+Il8Pibic3B3tOz9LPo6oilZYuoVTiA/YryeB412w==
X-Received: by 2002:a05:6a00:a90e:b0:7a5:396d:76be with SMTP id d2e1a72fcca58-7ff64ad9e96mr1731687b3a.27.1766124988927;
        Thu, 18 Dec 2025 22:16:28 -0800 (PST)
Received: from prithvi-HP ([103.47.105.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a84368dsm1229348b3a.2.2025.12.18.22.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 22:16:28 -0800 (PST)
Date: Fri, 19 Dec 2025 11:46:21 +0530
From: Prithvi <activprithvi@gmail.com>
To: Heming Zhao <heming.zhao@suse.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	khalid@kernel.org, syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: handle OCFS2_SUPER_BLOCK_FL flag in system dinode
Message-ID: <l6ksp2hk72pzciidqnzjmaupocngobj6e44exuko565jtrepwn@f7f42tby5oov>
References: <20251216200544.4114-1-activprithvi@gmail.com>
 <njikmwfpnsdzalxump7dj7wnlvkwfmvuqwxhpwzly45v7ioj5l@yckvd3veaifi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <njikmwfpnsdzalxump7dj7wnlvkwfmvuqwxhpwzly45v7ioj5l@yckvd3veaifi>

On Fri, Dec 19, 2025 at 12:07:56AM +0800, Heming Zhao wrote:
> On Wed, Dec 17, 2025 at 01:35:44AM +0530, Prithvi Tambewagh wrote:
> > When ocfs2_populate_inode() is called during mount process, if the flag
> > OCFS2_SUPER_BLOCK_FL is set in on-disk system dinode, then BUG() is
> > triggered, causing kernel to panic. This is indicative of metadata
> > corruption.
> > 
> > This is fixed by calling ocfs2_error() to print the error log and the
> > corresponding inode is marked as 'bad', so that it is not used further
> > during the mount process. It is ensured that the fact of that inode being
> > bad is propagated to caller ocfs2_populate_inode() i.e.
> > ocfs2_read_locked_inode() using is_bad_inode() and further behind along
> > the call trace as well.
> > 
> > Reported-by: syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=779d072a1067a8b1a917
> > Tested-by: syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > ---
> >  fs/ocfs2/inode.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> > index 12e5d1f73325..f439dc801845 100644
> > --- a/fs/ocfs2/inode.c
> > +++ b/fs/ocfs2/inode.c
> > @@ -347,7 +347,12 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
> >  	} else if (fe->i_flags & cpu_to_le32(OCFS2_SUPER_BLOCK_FL)) {
> >  		/* we can't actually hit this as read_inode can't
> >  		 * handle superblocks today ;-) */
> > -		BUG();
> > +		ocfs2_error(sb,
> > +			    "System Inode %llu has "
> > +			    "OCFS2_SUPER_BLOCK_FL set",
> > +			    (unsigned long long)le64_to_cpu(fe->i_blkno));
> > +		make_bad_inode(inode);
> > +		return;
> >  	}
> >  
> >  	switch (inode->i_mode & S_IFMT) {
> > @@ -555,6 +560,11 @@ static int ocfs2_read_locked_inode(struct inode *inode,
> >  
> >  	ocfs2_populate_inode(inode, fe, 0);
> >  
> > +	if (is_bad_inode(inode)) {
> > +		status = -EIO;
> > +		goto bail;
> > +	}
> > +
> >  	BUG_ON(args->fi_blkno != le64_to_cpu(fe->i_blkno));
> >  
> >  	if (buffer_dirty(bh) && !buffer_jbd(bh)) {
> > @@ -576,7 +586,7 @@ static int ocfs2_read_locked_inode(struct inode *inode,
> >  	if (can_lock)
> >  		ocfs2_inode_unlock(inode, lock_level);
> >  
> > -	if (status < 0)
> > +	if (status < 0 && !is_bad_inode(inode))
> >  		make_bad_inode(inode);
> >  
> >  	brelse(bh);
> > 
> > base-commit: d76bb1ebb5587f66b0f8b8099bfbb44722bc08b3
> > -- 
> > 2.43.0
> > 
> > 
> 
> ocfs2_populate_inode has two callers: __ocfs2_mknod_locked() and
> ocfs2_read_locked_inode()
> 
> Your code only works for the ocfs2_read_locked_inode() path, but not for the
> __ocfs2_mknod_locked() path.
> In __ocfs2_mknod_locked(), there are two tasks after ocfs2_populate_inode:
> "creating locks" and "updating the transaction". If you use a 'goto' to bypass
> these two tasks, ocfs2 will crash in the near future. Conversely, if you choose
> to execute the two jobs, the logic is flawed because we perform on a bad inode.
> 
> In my view, the existing code (using BUG()) is acceptable. We don't need to
> worry about this syzbot report.
> 
> Thanks,
> Heming

Hello Heming,

Thanks for the detailed explanation . I now understand more clearly how
removing BUG() from ocfs2_populate_inode() for inode having 
OCFS2_SUPER_BLOCK_FL set would cause problems in OCFS2 for the path
including __ocfs2_mknod_locked(). Since OCFS2_SUPER_BLOCK_FL flag on a
system dinode is indicative of metadata corruption and considering our
discussion, keeping BUG() for the same is appropriate.

Thanks,
Prithvi

