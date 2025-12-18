Return-Path: <stable+bounces-202912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58179CC9FEE
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 02:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85FD3301D596
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 01:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E63261593;
	Thu, 18 Dec 2025 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST/E5YbZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72581E5714
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022042; cv=none; b=S4NZhh60Vx8ZodYDpX8ffc25JlIA70j9dEGQ2Y+HWlv/TmX1ctuQD42+//K05cOlDPn5teIzat4aBMWBcIqKh0fHGXWCas6pg0t0lgYsz86wbN3atFgIPnPVq4b21HyZp1oLIEOsp6F6cr2lxj8axev5wlii6buqKenHddo3AQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022042; c=relaxed/simple;
	bh=I/rAODo+HwIExcOnsjmamAW6YGMWDM8LedYa4wNcyT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4cUHbUM2bVU/7mmaQADT9srCNRtp6lzEdiPCMMGAsYTEtBwp/I0OamCutImvtuCTDaimLJcNB4a1f76/DG20sw4ixUyl60wqCNyQ+z/DY6u76dyQkucYTT7fCPn99OPCCppR+EKDt7iOHVWhWfnqwKJxFEDdakcjLJ7UFAf2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ST/E5YbZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso80665a91.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 17:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766022040; x=1766626840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXvduGGYVPs0oki2ZyuK6X23qPiD8W0H5r3f0w1VklU=;
        b=ST/E5YbZ/iWTqZ3hxCCPoBtpLiE6xHbl49BiT2uGfCroChA/W+G4yEXcT2iz+EbYfO
         rwpwUjuteE4G1WjHhXPvgXt1JeJzw2Invm+Zq0tBncY1l0Pfou1ieXMFI3a1vjxLuDcD
         ubIF4AVfVhzuMLvX4RteaTv8LqKJP4lrL4Lz6D7sk9petdp84/31JiWUQYGNrIR3Y4RG
         WmBAk/8teGQcLBnZ0WNBS3OQEm0bMbcvhCy3kgfEAKinfnyehEuvSjAq2TTfj8v9HIOJ
         4fWcSeAcAiMZiTXFY6PompcU7akVIot+tsRcmayDlbBwPFoL+rYksUJ//JoTxCWAL/DM
         PXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022040; x=1766626840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXvduGGYVPs0oki2ZyuK6X23qPiD8W0H5r3f0w1VklU=;
        b=Brcyzk404t3JSMXauDAuXScoxqmJUj216CXHXL6QE8yYOQdKjkcnbSy6RMP3CnjQrr
         CLw9MkN9T+ASwj5JEwXDVjjB7l972+V7R0O7h1JEcG6sqS558HG7SWFbd5C72RiLNQ8V
         mlU90qzSIuiLCGiGnXTOPe6yLoOnrVpMuoFfVveg++hJ90N5xO4E0nRWhrY22T5YTZL+
         u/yuRvlWrhHcc/ATVlpk78i9fGFudqgD9CqFrBI9WuKSNgVOfgTbiYI+R71cDAYz0KkC
         4snMEeoLcIFitiRGxc9NEqgLuuPQGMGQml7CdDzvzOllZLEjAla84wP09+WAUmL6nH0o
         C/qg==
X-Forwarded-Encrypted: i=1; AJvYcCUMogykRj0QjoGbMhylt1/XfBa0LzdY8M/jisIEZQjWHt+Pzc/w2WrEJqLYaAFrdJnTjAjQ7Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Hw74idq/5trtwdzkTxoCNEeiJYZWRnDx8kmnC5peBDMNGAxz
	5uz6w3eOXthhDpTSFAJl5RmDzzUbT8gm9H8xGe7Dhz/DnHuU+4iNf7/1
X-Gm-Gg: AY/fxX4DQCycl3tanmYATpVAWZUOpqqtJpLVOsMkmXs7L2WqvGZtvPJjeeOzo+F/5QY
	nEOVh8cJKhwnVSQVF6K9VWFfFyVOpb8CAwJTBAZ1rG/ba6punsM09bICQebe6tXal5OFhnHBzj9
	Cq4Tln4e7nfDvGgI4PoCGTPYwvr5N+PfV5mB7qM5lgvpLeLBPaR51c2iDjU1j8BcIEpEdogEyAs
	H56FFcFgXzbHYKTb4m4d4YG2oWleZ290K5txWWHWHariIBFTOkv9Ndwi4CCrvuhBJLG37gmnuPB
	dQ3nD74VKxI0sK7mZiXi4Pzopn0rdr8s9a5R2AE/kmfvH1idfa0Cn9EOBBasyZE+Yf43ED0KuHp
	5fTIrzSNDU7xU55/cGmxzAimcdplEkjDkQlZHI0UT9rSwOa2zgclrpOuePLRCO8ngU9tEskl5Ts
	VHLms=
X-Google-Smtp-Source: AGHT+IGRV2jXQCCrdDuQ9IckFl0dfpdQWVmaKgrYY4f+jm8IX4QNAUnhVgQPtQjwcLLs8oAAZGnIHg==
X-Received: by 2002:a17:90b:3d0e:b0:340:2f48:b51a with SMTP id 98e67ed59e1d1-34abd802b08mr17080735a91.15.1766022039901;
        Wed, 17 Dec 2025 17:40:39 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70ddf58dsm750401a91.17.2025.12.17.17.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:40:39 -0800 (PST)
Date: Thu, 18 Dec 2025 09:40:36 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Message-ID: <aUNbhrPEY9Aa2U4L@ndev>
References: <20251216113504.297535-1-wangjinchao600@gmail.com>
 <4msliwnvyg6n3xdzfrh4jnqklzt6zji5vlr5qj4v3lrylaigpr@lyd36cukckl7>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4msliwnvyg6n3xdzfrh4jnqklzt6zji5vlr5qj4v3lrylaigpr@lyd36cukckl7>

On Wed, Dec 17, 2025 at 12:30:15PM +0100, Jan Kara wrote:
> Hello!
> 
> On Tue 16-12-25 19:34:55, Jinchao Wang wrote:
> > syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].
> > 
> > When xattr_find_entry() returns -ENODATA, search.here still points to the
> > position after the last valid entry. ext4_xattr_block_set() clones the xattr
> > block because the original block maybe shared and must not be modified in
> > place.
> > 
> > In the clone_block, search.here is recomputed unconditionally from the old
> > offset, which may place it past search.first. This results in a negative
> > reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().
> > 
> > Fix this by initializing search.here correctly when search.not_found is set.
> > 
> > [1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> > 
> > Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
> > Cc: stable@vger.kernel.org
> > Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> 
> Thanks for the patch! But I think the problem must be somewhere else. 
The first syzbot test report was run without the patch applied,
which caused confusion.
The correct usage and report show that this patch fixes the crash:
https://lore.kernel.org/all/20251216123945.391988-2-wangjinchao600@gmail.com/
https://lore.kernel.org/all/6941580e.a70a0220.33cd7b.013d.GAE@google.com/

>When
> a search ends without success (-ENODATA error), s->here points to the
> 4-byte zeroed word inside xattr space that terminates the part with xattr
> headers. If I understand correctly the expression which overflows is:
> 
> size_t rest = (void *)last - (void *)here + sizeof(__u32);
> 
Yes, you are right about all of the above.

> in ext4_xattr_set_entry(). And I don't see how 'here' can be greater than
> 'last' which should be pointing to the very same 4-byte zeroed word. The
> fact that 'here' and 'last' are not equal is IMO the problem which needs
> debugging and it indicates there's something really fishy going on with the
> xattr block we work with. The block should be freshly allocated one as far
> as I'm checking the disk image (as the 'file1' file doesn't have xattr
> block in the original image).

I traced the crash path and find how this hapens:

entry_SYSCALL_64
...
ext4_xattr_move_to_block
  ext4_xattr_block_find (){
    error = xattr_find_entry(inode, &bs->s.here, ...); // bs->s.here updated 
                                                       // to ENTRY(header(s->first)+1);
    if (error && error != -ENODATA)
      return error;
    bs->s.not_found = error; // and returned to the caller
  }
  ext4_xattr_block_set (bs) {
    s = bs->s;
    offset = (char *)s->here - bs->bh->b_data; // bs->bh->b_data == bs->s.base
                                               // offset = ENTRY(header(s->first)+1) - s.base
                                               // leads to wrong offset
    clone_block: {
	s->base = kmemdup(BHDR(bs->bh), bs->bh->b_size, GFP_NOFS);
	s->first = ENTRY(header(s->base)+1);
	s->here = ENTRY(s->base + offset); // wrong s->here
    }
    ext4_xattr_set_entry (s) {
      last = s->first; // last < here
      rest = (void *)last - (void *)here + sizeof(__u32); // negative rest
      memmove((void *)here + size, here, rest); // crash
    }
  }
> 
> 								Honza
> 
> > diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> > index 2e02efbddaac..cc30abeb7f30 100644
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1980,7 +1980,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
> >  			goto cleanup;
> >  		s->first = ENTRY(header(s->base)+1);
> >  		header(s->base)->h_refcount = cpu_to_le32(1);
> > -		s->here = ENTRY(s->base + offset);
> > +		if (s->not_found)
> > +			s->here = s->first;
> > +		else
> > +			s->here = ENTRY(s->base + offset);
> >  		s->end = s->base + bs->bh->b_size;
> >  
> >  		/*
> > -- 
> > 2.43.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

