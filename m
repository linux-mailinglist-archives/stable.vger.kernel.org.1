Return-Path: <stable+bounces-203410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D07CDE304
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 01:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F64300941E
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 00:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB112E401;
	Fri, 26 Dec 2025 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5kL6WxH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4115E97
	for <stable@vger.kernel.org>; Fri, 26 Dec 2025 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766710449; cv=none; b=eQn1NRDiu9KXl/hfDNu82THiiCpAsKJCuHHd0jsVVwLhhTvI0bA7Ag1saZPveYsWvHzqoD7Icik+7n2ZguV82lYiqd8YEeXmsXmdkGCFeewfo/UNPu8/Wt1iPTTPBKoMJa6e6edgrP8EimagCcmcxd2yERo7B1qZcNx7HA0t/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766710449; c=relaxed/simple;
	bh=i5COWy3rfZwIgUNxrI4GAwaQqLJsqNDLuisCM/dK6f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPKpznHq+2IPTf/lm+Vwt3/Po6QntEQLu+RxoB9CW2zw+LTsSSbe7pWRFVTkprpm64Zzs6I8Whlyt0fp9pl5+5HRl4RQfalPako6IosSEDD+QIUfPJgaEn0ir4bI/x/gEd8s9JzKFZhvFhCnngWIirtUpDLemMjroh/CndJhW9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5kL6WxH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29efd139227so91639495ad.1
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766710446; x=1767315246; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Nz8Tjp3AaOWOXlLmwlKJ8QCQ6dId4zIiZlrgYittUg=;
        b=G5kL6WxHOM2FDWL9Hd8D7Dkw/R4dqp8FGwi5pRN0CHb7wlAGTCKIzpRBf3Lkw4uamt
         bxivJcWkCsZAK+kS4HMbLIAjsYoJg+TCayiAjjtO4rOAExWIL3Ox74pW2U/VRDqiAOh1
         zZMe3GPBZpJpsz3mpvk3NYVvHVmuKibyjrOHjQBR+QZuN6MJ87zCz5X752BIUZM0+bK5
         4SZM8mpYsKbNSzvzHMllc4GuNJw9WZze4dz3H3zvhkfcRwTEREwWPLCtJO3lVU2bFSMq
         yIBuj3G6BTY2CSDKHm+eGnzeoV0GyfbcEtwitlfTetcXcJagrt7ZzyRZGNHzWAG8Z52t
         3GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766710446; x=1767315246;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Nz8Tjp3AaOWOXlLmwlKJ8QCQ6dId4zIiZlrgYittUg=;
        b=QI7N4fiCbA6kgpsmGEWvdJUvruEEALzFLq8OX4waOm4vnyKWIJJTmzuxBea9Fn/ZHA
         xCqabUY9WWre2r/OIy9ORLW/UrcQEigQroJ+DSr9FVoylkP5fTec9dkSWppszdggwu8f
         AAEYokLVMlb8OlXCuhuSjnE8Xdm/FORCHiAtRMuhugQ5nXgZzHW8JbtKt55C2reFj5jZ
         4k+qvt21jqVpqcFLplCWXTCH7k0/egj22IOSxRrlJlR56mFdCXP+uAgzZwOGpM/Ci4vA
         ydbcHCpcncih+uz1lpk94WtkUPJiqXMbIFS+mR1EImQVc6vzuDYsx90+TomhwqO0n1nS
         EFWg==
X-Forwarded-Encrypted: i=1; AJvYcCVCj3iAF2xIsR0sXmjck7dzULuQ3iu8b/G9N2c03TgeNqtxwLEiQGC3ef3zzN02nLm/7csxLTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXbLlzc2Lb8EGWKRSSeuYDu82f4c5n3ZYWi9JhQfGr600a5Jox
	IN9xmybv10TpT0h8DRybRXxrtK5v6l+7QXvA5iB203cTI0yJNkn7esR+
X-Gm-Gg: AY/fxX5EHRyzIGlxVlj9XGol0bnouDIypLKxUpr1dXSoBSy9gHG1QNID0NHLjiqIkE/
	IeZquUQ3Unom2rB/5zU0VYBFz64B/GaLIPQBq9dDzvmrKDrPYLW9nRtHs9cIxAivFqJj2ZPpvrx
	mb0ZoFVBWm/DVRS+c+8o/PZNiMPBHaKmmInF9+bCG2OCTcGrzrv2qjgvUiKA9sWYUNHPJtvYibB
	Fpht/jfuAF7J/d3POOT6QsQy8cq8T30Agzr+30jr136SV6+gNXiWb0KBFN56381BuCanYsBjWQL
	x9a1b19hcTIrd4Km71tjq2OxlQ/tdDdeqx+oq4Kp60IfGhTf1n7AoL+k9vxYJGawRv/ymNcP2RV
	8hUKir/9lMcp97j7yXLqj/L5t9xz5EfhjlQ5xfxytXjn53voeknCDv1DRMykM1W1dg5huATYNR6
	j52DBhjFeDJw==
X-Google-Smtp-Source: AGHT+IGaDsT0j4q8/ZSFFbw2xdc1M9VAnGq5qpd7JQCuRHzrrYcXtXjqAkcYXXbP4gPMX3j0h85Juw==
X-Received: by 2002:a17:902:ce82:b0:2a0:f469:1f56 with SMTP id d9443c01a7336-2a2f272b393mr241519525ad.31.1766710446312;
        Thu, 25 Dec 2025 16:54:06 -0800 (PST)
Received: from localhost ([2403:2c80:6::30e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a8442edsm20380428b3a.12.2025.12.25.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 16:54:05 -0800 (PST)
Date: Fri, 26 Dec 2025 08:53:54 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Message-ID: <aU3cok27oxoiyvZn@ndev>
References: <20251216113504.297535-1-wangjinchao600@gmail.com>
 <4msliwnvyg6n3xdzfrh4jnqklzt6zji5vlr5qj4v3lrylaigpr@lyd36cukckl7>
 <aUNbhrPEY9Aa2U4L@ndev>
 <qn25xtvqu76womw47qq6uhlhmudymvfqableicrodalzfkeo4r@qjwl5oegvlpd>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qn25xtvqu76womw47qq6uhlhmudymvfqableicrodalzfkeo4r@qjwl5oegvlpd>

On Thu, Dec 18, 2025 at 04:39:08PM +0100, Jan Kara wrote:
> On Thu 18-12-25 09:40:36, Jinchao Wang wrote:
> > On Wed, Dec 17, 2025 at 12:30:15PM +0100, Jan Kara wrote:
> > > Hello!
> > > 
> > > On Tue 16-12-25 19:34:55, Jinchao Wang wrote:
> > > > syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].
> > > > 
> > > > When xattr_find_entry() returns -ENODATA, search.here still points to the
> > > > position after the last valid entry. ext4_xattr_block_set() clones the xattr
> > > > block because the original block maybe shared and must not be modified in
> > > > place.
> > > > 
> > > > In the clone_block, search.here is recomputed unconditionally from the old
> > > > offset, which may place it past search.first. This results in a negative
> > > > reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().
> > > > 
> > > > Fix this by initializing search.here correctly when search.not_found is set.
> > > > 
> > > > [1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> > > > 
> > > > Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
> > > > Cc: stable@vger.kernel.org
> > > > Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> > > > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > > 
> > > Thanks for the patch! But I think the problem must be somewhere else. 
> > The first syzbot test report was run without the patch applied,
> > which caused confusion.
> > The correct usage and report show that this patch fixes the crash:
> > https://lore.kernel.org/all/20251216123945.391988-2-wangjinchao600@gmail.com/
> > https://lore.kernel.org/all/6941580e.a70a0220.33cd7b.013d.GAE@google.com/
> 
> I was not arguing that your patch doesn't fix this syzbot issue. Just that
> I don't understand how what you describe can happen and thus I'm not sure
> whether the fix is really the best one...
> 
> > > in ext4_xattr_set_entry(). And I don't see how 'here' can be greater than
> > > 'last' which should be pointing to the very same 4-byte zeroed word. The
> > > fact that 'here' and 'last' are not equal is IMO the problem which needs
> > > debugging and it indicates there's something really fishy going on with the
> > > xattr block we work with. The block should be freshly allocated one as far
> > > as I'm checking the disk image (as the 'file1' file doesn't have xattr
> > > block in the original image).
> > 
> > I traced the crash path and find how this hapens:
> 
> Thanks for sharing the details!
> 
> > entry_SYSCALL_64
> > ...
> > ext4_xattr_move_to_block
> >   ext4_xattr_block_find (){
> >     error = xattr_find_entry(inode, &bs->s.here, ...); // bs->s.here updated 
> >                                                        // to ENTRY(header(s->first)+1);
> >     if (error && error != -ENODATA)
> >       return error;
> >     bs->s.not_found = error; // and returned to the caller
> >   }
> >   ext4_xattr_block_set (bs) {
> >     s = bs->s;
> >     offset = (char *)s->here - bs->bh->b_data; // bs->bh->b_data == bs->s.base
> >                                                // offset = ENTRY(header(s->first)+1) - s.base
> >                                                // leads to wrong offset
> 
> Why do you think the offset is wrong here? The offset is correct AFAICS -
> it will be the offset of the 0 word from the beginning of xattr block. I
> have run the reproducer myself and as I guessed in my previous email the
> real problem is that someone modifies the xattr block between we compute
> the offset here and the moment we call kmemdup() in clone_block. Thus the
> computation of 'last' in ext4_xattr_set_entry() yields a different result
> that what we saw in ext4_xattr_block_set(). The block modification happens
> because the xattr block - block 33 is used for it - is also referenced from
> file3 (but it was marked as unused in the block bitmap and so xattr block
> got placed there).
> 
> So your patch was fixing the problem only by chance and slightly different
> syzbot reproducer (overwriting the block 33 with a different contents)
> would trigger the crash again.
> 
> So far I wasn't able to figure out how exactly the block 33 got zeroed out
> but with corrupted filesystem it can happen in principle rather easily. The
> question is how we can possibly fix this because this is one of the nastier
> cases of fs corrution to deal with. The overhead of re-verifying fs
> metadata each time we relock the buffer is just too big... So far no great
> ideas for this.
> 
> 								Honza
> 

Baokun explained part of the process in the kernel space.
https://lore.kernel.org/all/d62a25e9-04de-4309-98d1-22a4f9b5bb49@huawei.com/

I analysed syz-reproducer and add some userspace details:

- original filesystem state
  - file1:
    - inode 15 with File ACL block 33
  - file2:
    - inode 16 with data blocks 27–35
- actions
  - syscall(__NR_creat, "file2")
  - syscall(__NR_unlink, "file1")  // panic happens here

The original filesystem state is already corrupted, with block 33 beging
referenced both as an xattr block and as file data.

