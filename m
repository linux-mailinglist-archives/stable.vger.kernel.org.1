Return-Path: <stable+bounces-203356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F4CDB869
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 07:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48446300D140
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 06:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BB4329E7E;
	Wed, 24 Dec 2025 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/5JQGY8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD4309DDC
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766558300; cv=none; b=a6El52BbCnjt2d+3Qs5DxX8/YcSU9POrxlRf0/d2euFtOAEi/1Z+F+yUL0jVz/bW3XR6zUPbXvPvHzXt9+L9a9j1k3uma5AEJIgQCCB2utho2KZ8LjnFnDZSi9syyYiumNF2gZ68GcNTDEEvUp9Kr8PxcoHaClERiNN3tNy8uQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766558300; c=relaxed/simple;
	bh=gsrHNNbocSyGlKE7vERXRimkrvrozZZCJmIIb6a960o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSjbY/ajP6/X8z4dY0FkCtwHh/fK62yxjnhjpH0hu9OoRulL+qLMEL8sOSSCPllcmYmfubYzEQRQawB5f7EF9CfEGFhxk20znT1EJ1HIAhjjIAb7YiGc9TnnULD+7URUAGV8mIsV2j2Pdg61d9pRi/ePxZSJvSY7L9ppOF6GbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/5JQGY8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7f1243792f2so3923756b3a.1
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 22:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766558297; x=1767163097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1Anp1lY1We4/zAVuAi7e7U46WAxj4AfEwKzru4nCjs=;
        b=A/5JQGY8IrPgu6Kf5XhhK7zlCVhmBK+eedm/sUkrFLKXLei/5gcUv8aakGaiD/DMpi
         J090iGxpLQKxiCcN2vLl/OjDRF5cFCw7t82z5XNv2X4G9+Q3BTnqT8JWPHu0uKZQ4qf5
         JCwImGTk2FEaX3r/d8foYHSN93s3mXjmBI0y24J8NWG9UZRWoM39CrApz73mlAIRwnIN
         BJVhcz/9BhPAtRPcnuNTvWVsryPaEIEqaiPqqFkDbZd+n7zSjFAFuk/xt8QzOSJBTnUL
         yb2DlYc067yT6czwc6+8cSE3L5URwsuIGLD4UATuZiIbRv3To81KvBzV18pFx8V2B3Y5
         F3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766558297; x=1767163097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1Anp1lY1We4/zAVuAi7e7U46WAxj4AfEwKzru4nCjs=;
        b=t/JtsMctuvz28TkadlSUM/zdWNgbYRrkbq42kd8IlVtudZJ0EqRtqFw4E999EqLun3
         i18B9CM2dNLOAYVyHQ2v8qEnbn45wd5xq5EbI17qAHEd92AYR4WQwfKYWrNS4HxwhHB0
         c7ho7wcKjgQKwqZyZeu1jNVoJHKTlh4pWfCZnBqjTCWVQdExNLA2f33jick8bQxaAxmm
         Kcys09dk+6cAgyU5jewTF14A6hYmfsh95ujz1b4hNAfgLdPNNfualtYMtsE/YeRZSNrb
         +8GnMvQKjPV7ZVRtcU3uujnfACWR2Y8q5uf4QmbHExruh9AWQ09heiWJhpMMpL02MonF
         rJjw==
X-Forwarded-Encrypted: i=1; AJvYcCVI+IWzqferkJ64fDhEqSyd16V8YUSGdnyxKKSl+/NPZ0vdpFA1mjur8fpAnI6X//7sjvYmEHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrKKSUWAAXUqHz7PVp8LH4EQW2g4RVNIoBax5E9EMLxRegnAz
	s5VfNnUJDzqlOZ1LI8YhvXQZ6/3hKrpR3+0r9DFeGjLVZp11FEx88clAkk14dlUD
X-Gm-Gg: AY/fxX6AhODisqs+VdhqIlvGVE8phdOKO1aHdnnqD+4Psnc22+mIAjpD8mY5Nncdsaz
	1OOjCoWMlZpGR71wyKnSpq/733HFWTYFPU6W16Zcp3xuSUi6RjE4+vAbb7folh3yNWJM6DHNM4J
	fghFRlXdiwUNCCtFHsKKVbqzxJAgCA/QKJuEPc517EM5teS7Bg+Q5eroznAk57PqwG442yOBwDP
	6JUXPtdpt1ikirEmW9xyEHYlrpXSN3kQZt6idEDWxdDvx1oSX3zKNNi8OS91h+IcUOVgJ7kPyU+
	Pi7ka/XRJyhmXw708dGKsQSPaP8SXsvD+U9lyFNs7FWyQFdn5L8Zvyxa7ZSNuDcPKy0eox4XFBI
	7EcIxBcsaKyIgHca740gZbKwfTppmf2//P5s/wuw9u0GXOlrbuuSV62e3TmY6CZwM+cb7eJH3Cw
	PqdhvUbKmbMM0=
X-Google-Smtp-Source: AGHT+IGeF+1DNi4wBQ+citO8we8db5AW369vz0FLW8lrY82nDFCZVApz9JhjcAMfqp7ryzxlPiNF4Q==
X-Received: by 2002:a05:6a00:328f:b0:7e8:43f5:bd36 with SMTP id d2e1a72fcca58-7ff66d5f579mr15039520b3a.34.1766558297009;
        Tue, 23 Dec 2025 22:38:17 -0800 (PST)
Received: from inspiron ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e589b0csm15892605b3a.56.2025.12.23.22.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 22:38:16 -0800 (PST)
Date: Wed, 24 Dec 2025 12:08:09 +0530
From: Prithvi <activprithvi@gmail.com>
To: Heming Zhao <heming.zhao@suse.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: Add check for total number of chains in chain list
Message-ID: <20251224063809.b5zs7uiiupeexzwa@inspiron>
References: <20251220094928.134849-1-activprithvi@gmail.com>
 <dcbfbwivj2pgid24lp7xynsli5v44fw5lskyg6r6yodr223irp@alqswzjnxmmu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbfbwivj2pgid24lp7xynsli5v44fw5lskyg6r6yodr223irp@alqswzjnxmmu>

On Mon, Dec 22, 2025 at 11:21:11PM +0800, Heming Zhao wrote:
> On Sat, Dec 20, 2025 at 03:19:28PM +0530, Prithvi Tambewagh wrote:
> > The functions ocfs2_reserve_suballoc_bits(), ocfs2_block_group_alloc(),
> > ocfs2_block_group_alloc_contig() and ocfs2_find_smallest_chain() trust
> > the on-disk values related to the allocation chain. However, KASAN bug
> > was triggered in these functions, and the kernel panicked when accessing
> > redzoned memory. This occurred due to the corrupted value of `cl_count`
> > field of `struct ocfs2_chain_list`. Upon analysis, the value of `cl_count`
> > was observed to be overwhemingly large, due to which the code accessed
> > redzoned memory.
> > 
> > The fix introduces an if statement which validates value of `cl_count`
> > (both lower and upper bounds). Lower bound check ensures the value of
> > `cl_count` is not zero and upper bound check ensures that the value of
> > `cl_count` is in the range such that it has a value less than the total
> > size of struct ocfs2_chain_list and maximum number of chains that can be
> > present, so as to fill one block.
> > 
> > Reported-by: syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=af14efe17dfa46173239
> > Tested-by: syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> > ---
> >  fs/ocfs2/suballoc.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> > index f7b483f0de2a..7ea63e9cc4f8 100644
> > --- a/fs/ocfs2/suballoc.c
> > +++ b/fs/ocfs2/suballoc.c
> > @@ -671,6 +671,21 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
> >  	BUG_ON(ocfs2_is_cluster_bitmap(alloc_inode));
> >  
> >  	cl = &fe->id2.i_chain;
> > +	unsigned int block_size = osb->sb->s_blocksize;
> > +	unsigned int max_cl_count =
> > +	(block_size - offsetof(struct ocfs2_chain_list, cl_recs)) /
> > +	sizeof(struct ocfs2_chain_rec);
> > +
> > +	if (!le16_to_cpu(cl->cl_count) ||
> > +	    le16_to_cpu(cl->cl_count) > max_cl_count) {
> > +		ocfs2_error(osb->sb,
> > +			    "Invalid chain list: cl_count %u "
> > +			    "exceeds max %u",
> > +			    le16_to_cpu(cl->cl_count), max_cl_count);
> > +		status = -EIO;
> > +		goto bail;
> > +	}
> > +
> >  	status = ocfs2_reserve_clusters_with_limit(osb,
> >  						   le16_to_cpu(cl->cl_cpg),
> >  						   max_block, flags, &ac);
> > 
> > base-commit: 36c254515dc6592c44db77b84908358979dd6b50
> > -- 
> > 2.34.1
> > 
> 
> Since 'fe' is read by ocfs2_read_inode_block(), the validation function
> ocfs2_validate_inode_block() is the appropriate place to perform this sanity
> check.
> 
> Please follow the pattern in commit e1c70505ee81 ("ocfs2: add extra consistency
> checks for chain allocator dinodes") when adding your code.
> 
> btw, I am a little bit confused, it seems commit e1c70505ee81 is enough to fix
> this syzbot issue.
> 
> Thanks,
> Heming

Hello Heming,

Thanks or the clarification. I applied the commit e1c70505ee81 ("ocfs2: add 
extra consistency checks for chain allocator dinodes") above the commit on 
which syzbot reported the bug : 36c254515dc6 ("Merge tag 'powerpc-6.12-4' 
of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux") and 
verified that it fixes this KASAN bug. 

You are right that commit e1c70505ee81 is enough to fix this bug, and my 
patch is redundant in this case.

Thanks for the review and guidance!

Best Regards, 
Prithvi

