Return-Path: <stable+bounces-116959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7828BA3B0C1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 06:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67993A4FB1
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 05:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF351A9B27;
	Wed, 19 Feb 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JHJ2dQhg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464419DF99;
	Wed, 19 Feb 2025 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739941846; cv=none; b=hxgHLRHUkUuF4COwewVI6wQP11y/IxL5ouZ2iQgUYHUz0XECO+wFf2oA4ZirKbDPkLuoY60AUCALWDsD60e46lwhEwyrPgGXPbbUhMDlBF1m/a5nDKCdBgMkSUKDbUQD5pfwxnCaPVJ/aRkN0eoCbCjey5FezICEHxp0CVCGE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739941846; c=relaxed/simple;
	bh=qxphvqi7G/P4h2lBp66CeMOj+EvTR2VDJKFiAP9MOjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yy3OUpvqWqJOWC1FOilz/HHpweoPY/LQXE+vXRJcU6f1gRvWfdq1dLHWt3nXGwrO/cXBOHGucfcCIpOYpGNl8NdP/3Ey3/jNZFczewK/JwLZV9j8LL8I0kqET5YJTP6utRz2HWTJKAvVQSd/q5osCgjIU24E1ojcNx6Q5oVo5WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JHJ2dQhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA51DC4CED1;
	Wed, 19 Feb 2025 05:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739941845;
	bh=qxphvqi7G/P4h2lBp66CeMOj+EvTR2VDJKFiAP9MOjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JHJ2dQhgEGEU9XHZRYdpJh9ouXvg+EK03p6FxYi4Es8RtII/fARmJDvW9r2lADXlv
	 NWlLS5XQ6rq+k84lrtV9ZhIJY+F374YFqdrJtySwbkszTomR7ofaRQQBBHPwLixvHu
	 Kx/Rrqr77KRT51765LSBPmomgVc4/L7w68rP5w0Y=
Date: Wed, 19 Feb 2025 06:10:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: 2025021350-geometry-appear-9d84@gregkh.smtp.subspace.kernel.org
Cc: shaggy@kernel.org, zhaomengmeng@kylinos.cn, llfamsec@gmail.com,
	ancowi69@gmail.com, jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] jfs: fix slab-out-of-bounds read in ea_get()
Message-ID: <2025021902-overspend-buckwheat-e5c3@gregkh>
References: <Z7UoUyuHzGWwvBOK@qasdev.system>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7UoUyuHzGWwvBOK@qasdev.system>

On Wed, Feb 19, 2025 at 12:39:47AM +0000, Qasim Ijaz wrote:
> On Thu, Feb 13, 2025 at 11:07:07AM +0100, Greg KH wrote:
> > On Thu, Feb 13, 2025 at 12:20:25AM +0000, Qasim Ijaz wrote:
> > > During the "size_check" label in ea_get(), the code checks if the extended 
> > > attribute list (xattr) size matches ea_size. If not, it logs 
> > > "ea_get: invalid extended attribute" and calls print_hex_dump().
> > > 
> > > Here, EALIST_SIZE(ea_buf->xattr) returns 4110417968, which exceeds 
> > > INT_MAX (2,147,483,647). Then ea_size is clamped:
> > > 
> > > 	int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> > > 
> > > Although clamp_t aims to bound ea_size between 0 and 4110417968, the upper 
> > > limit is treated as an int, causing an overflow above 2^31 - 1. This leads 
> > > "size" to wrap around and become negative (-184549328).
> > > 
> > > The "size" is then passed to print_hex_dump() (called "len" in 
> > > print_hex_dump()), it is passed as type size_t (an unsigned 
> > > type), this is then stored inside a variable called 
> > > "int remaining", which is then assigned to "int linelen" which 
> > > is then passed to hex_dump_to_buffer(). In print_hex_dump() 
> > > the for loop, iterates through 0 to len-1, where len is 
> > > 18446744073525002176, calling hex_dump_to_buffer() 
> > > on each iteration:
> > > 
> > > 	for (i = 0; i < len; i += rowsize) {
> > > 		linelen = min(remaining, rowsize);
> > > 		remaining -= rowsize;
> > > 
> > > 		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> > > 				   linebuf, sizeof(linebuf), ascii);
> > > 	
> > > 		...
> > > 	}
> > > 	
> > > The expected stopping condition (i < len) is effectively broken 
> > > since len is corrupted and very large. This eventually leads to 
> > > the "ptr+i" being passed to hex_dump_to_buffer() to get closer 
> > > to the end of the actual bounds of "ptr", eventually an out of 
> > > bounds access is done in hex_dump_to_buffer() in the following 
> > > for loop:
> > > 
> > > 	for (j = 0; j < len; j++) {
> > > 			if (linebuflen < lx + 2)
> > > 				goto overflow2;
> > > 			ch = ptr[j];
> > > 		...
> > > 	}
> > > 
> > > To fix this we should validate "EALIST_SIZE(ea_buf->xattr)" 
> > > before it is utilised.
> > > 
> > > Reported-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
> > > Tested-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
> > > Closes: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
> > > Fixes: d9f9d96136cb ("jfs: xattr: check invalid xattr size more strictly")
> > > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > > ---
> > >  fs/jfs/xattr.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> > > index 24afbae87225..7575c51cce9b 100644
> > > --- a/fs/jfs/xattr.c
> > > +++ b/fs/jfs/xattr.c
> > > @@ -559,11 +555,16 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
> > >  
> > >        size_check:
> > >  	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
> > > -		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> > > -
> > > -		printk(KERN_ERR "ea_get: invalid extended attribute\n");
> > > -		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
> > > -				     ea_buf->xattr, size, 1);
> > > +		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
> > > +			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
> > > +			       EALIST_SIZE(ea_buf->xattr));
> > > +		} else {
> > > +			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> > > +
> > > +			printk(KERN_ERR "ea_get: invalid extended attribute\n");
> > > +			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
> > > +				       ea_buf->xattr, size, 1);
> > > +		}
> > >  		ea_release(inode, ea_buf);
> > >  		rc = -EIO;
> > >  		goto clean_up;
> > > -- 
> > > 2.39.5
> > > 
> > 
> > Hi,
> > 
> > This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> > a patch that has triggered this response.  He used to manually respond
> > to these common problems, but in order to save his sanity (he kept
> > writing the same thing over and over, yet to different people), I was
> > created.  Hopefully you will not take offence and will fix the problem
> > in your patch and resubmit it so that it can be accepted into the Linux
> > kernel tree.
> > 
> > You are receiving this message because of the following common error(s)
> > as indicated below:
> > 
> > - You have marked a patch with a "Fixes:" tag for a commit that is in an
> >   older released kernel, yet you do not have a cc: stable line in the
> >   signed-off-by area at all, which means that the patch will not be
> >   applied to any older kernel releases.  To properly fix this, please
> >   follow the documented rules in the
> >   Documentation/process/stable-kernel-rules.rst file for how to resolve
> >   this.
> > 
> > If you wish to discuss this problem further, or you have questions about
> > how to resolve this issue, please feel free to respond to this email and
> > Greg will reply once he has dug out from the pending patches received
> > from other developers.
> >
> Hi Greg,
> 
> Just following up on this patch. I’ve sent v2 with the added CC stable tag. Here’s the link:
> https://lore.kernel.org/all/20250213210553.28613-1-qasdev00@gmail.com/
> 
> Let me know if any further changes are needed.

It's been less than one week, for a filesystem that is not actively
maintained and no one should be using anymore, so please be patient.

thanks,

greg k-h

