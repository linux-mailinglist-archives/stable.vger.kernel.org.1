Return-Path: <stable+bounces-116939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA2A3AD2B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 01:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED917188487B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452CDF42;
	Wed, 19 Feb 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lt9RzjAp"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDCB35280;
	Wed, 19 Feb 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925604; cv=none; b=k2KKkHnUGTmLeoSc2LMzduD7lCYx7LRThKgR8UJ6BvxmdQUKk1KUOI8vfFkMACmdv5tJj+wz1hlbU+B0vIqfsUhy0Nm7U5r5qnapX9QunWQT5VJ5SWtAS82UyynZOfTElSP4heb+aF4dnUn0dtvn7PBxq4w+QCrsW/wwXRNZ/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925604; c=relaxed/simple;
	bh=V579PLhg5kd9B6AIRrCrl53a5ccGV5L8cH2lf2PBTEs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tk6zP4kXx+KcXphqEpuauKZZmJQgjZAZlXGvLXeIPR1Fl7BWS3roKLFdE5U4o8DGrSB6yQC3dffAAdrhAF4FEoD8g06anrYL/OVtFUaQFF/COmcYCpASEhBC4rHxckOrh6CZH42lGRYLB3tHjrDEucQlF282XvJhFF2SZ+zogLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lt9RzjAp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f325dd90eso2600718f8f.3;
        Tue, 18 Feb 2025 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739925600; x=1740530400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JHOHl2LXDy5H0c0r+6Un847IQsdcEJr0cAAnvM10wM=;
        b=lt9RzjApPbwUdd1fi4S8Jp7Zv0pBzHh9s4gmR1YmXE/9Cw3eELNu3KeihM5rxdMeiW
         mPHJo0v+5gK7I7FFKcL9KKfLWFFDzo0q5dvlvXeTTmHz5pc4Nf88Q5YkVVaOwTsbFFH/
         7fWvHkUVQvKUwaQZrofMzcI9/AVKMntZ9zSuwEXl1ys7NQY3CR4wSRIHUFfUKNK+HshG
         B96zAVo0eMlOVG3d1t4ouv1zQMWRu6sWnzFYlMSRoW92byas1YLhRWM3qcZeJC8CDQnK
         7mbNy+pgO54F6G5g0VBmC8J8OIjr2JJnQvHYPl0P40ZKx9mBMS4v2r88jIWH33AMGUfq
         yG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739925600; x=1740530400;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JHOHl2LXDy5H0c0r+6Un847IQsdcEJr0cAAnvM10wM=;
        b=DWhxmbiZLPTBwAHXyJQthp9zbCq81oQSN5TaX9UTtn4SaoHuBfRcH8XumlfK23TxpI
         2Cehj7VS2nI8+CBdm5/Ec9CGwrKN4QiUIqZyAtszjxbQJ2lIX0zFy/gmTvPNNWM3rrPi
         nKeQLNA957dRwHBne0uWON+jd0EQlWMZkwZi+uD5oKIZshvsSpWbHWi3LQVOVaQzT97y
         rrQeJ2kV5yQjR9Tke/9pQbBlSzTUWcGei2vZzJYHcz/Q5EtUcX1cRz2IRgKZR4f48Uzk
         1r6oAYD+1fFYMfY8g4cEnIwANjFJxBYC4RYnGYGJb5wps5kl8DmO1T1Z3OnM+9AYRL5T
         OVFw==
X-Forwarded-Encrypted: i=1; AJvYcCWrRSRpPew3x8qwPeO162VQTUK0SC2UP0Dsjg7Kkfbc/cgLY4GZvqoApYWDgQN2VKwwvUZNW+vH@vger.kernel.org, AJvYcCWsXMont4hSKnQ/DXNE6fGT1hvLgsr1/h4IGbwP38ca90Xrc+heKMXTQH3xAFSX79YwUFKs1cpO7M/LZ/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6em0xvNTbb7Xy83oVa2ErKXFnTkRLwSU1PeX8e1rqL8+o6Kkq
	qYbN2mEea5VQnJh5+0loAWxs3eMyRQYoM0+g5kbuYEb9OsmAZAwe
X-Gm-Gg: ASbGncvMUp3L+olaAazS1E/66r9RaK4ir/N6bCToPKAppDim5a4qcdWkNrX+FLr0osI
	7oL7S87FHgsBldyTGF9EDXLlBn9YFWu/n4GTDnEpuaafNCI/VSZizVsoEkENukt6q6jjgNHki+F
	sPev5+6rMNE25RQQuhWIdontxcO8Iy5ImVF6KE7httnJnJCLZPEPheSxrHNHDn4vtpTPvp2NHfV
	8/ezH+RCAPJ3k6UbXsLub8z8UTB57H5N2FoQXnt7B7susQ53FK32gcjWbwENbppiDKGrT6vv2AJ
	Lh3HuyBk6ePs79bgvXM=
X-Google-Smtp-Source: AGHT+IH3+KUECayclfSqQFaRWxuKG5B08STeM0zSF0183amtqyEvTCXByOdJbxpa7ysaG2Ke1EpuiQ==
X-Received: by 2002:a5d:518b:0:b0:38f:2f88:b034 with SMTP id ffacd0b85a97d-38f33f4e284mr11303156f8f.42.1739925600068;
        Tue, 18 Feb 2025 16:40:00 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:9fde:9e4f:b0fd:6a37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b434fsm16570328f8f.16.2025.02.18.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 16:39:58 -0800 (PST)
Date: Wed, 19 Feb 2025 00:39:47 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: shaggy@kernel.org, zhaomengmeng@kylinos.cn, llfamsec@gmail.com,
	gregkh@linuxfoundation.org, ancowi69@gmail.com,
	jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] jfs: fix slab-out-of-bounds read in ea_get()
Message-ID: <Z7UoUyuHzGWwvBOK@qasdev.system>
Reply-To: 2025021350-geometry-appear-9d84@gregkh.smtp.subspace.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Feb 13, 2025 at 11:07:07AM +0100, Greg KH wrote:
> On Thu, Feb 13, 2025 at 12:20:25AM +0000, Qasim Ijaz wrote:
> > During the "size_check" label in ea_get(), the code checks if the extended 
> > attribute list (xattr) size matches ea_size. If not, it logs 
> > "ea_get: invalid extended attribute" and calls print_hex_dump().
> > 
> > Here, EALIST_SIZE(ea_buf->xattr) returns 4110417968, which exceeds 
> > INT_MAX (2,147,483,647). Then ea_size is clamped:
> > 
> > 	int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> > 
> > Although clamp_t aims to bound ea_size between 0 and 4110417968, the upper 
> > limit is treated as an int, causing an overflow above 2^31 - 1. This leads 
> > "size" to wrap around and become negative (-184549328).
> > 
> > The "size" is then passed to print_hex_dump() (called "len" in 
> > print_hex_dump()), it is passed as type size_t (an unsigned 
> > type), this is then stored inside a variable called 
> > "int remaining", which is then assigned to "int linelen" which 
> > is then passed to hex_dump_to_buffer(). In print_hex_dump() 
> > the for loop, iterates through 0 to len-1, where len is 
> > 18446744073525002176, calling hex_dump_to_buffer() 
> > on each iteration:
> > 
> > 	for (i = 0; i < len; i += rowsize) {
> > 		linelen = min(remaining, rowsize);
> > 		remaining -= rowsize;
> > 
> > 		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> > 				   linebuf, sizeof(linebuf), ascii);
> > 	
> > 		...
> > 	}
> > 	
> > The expected stopping condition (i < len) is effectively broken 
> > since len is corrupted and very large. This eventually leads to 
> > the "ptr+i" being passed to hex_dump_to_buffer() to get closer 
> > to the end of the actual bounds of "ptr", eventually an out of 
> > bounds access is done in hex_dump_to_buffer() in the following 
> > for loop:
> > 
> > 	for (j = 0; j < len; j++) {
> > 			if (linebuflen < lx + 2)
> > 				goto overflow2;
> > 			ch = ptr[j];
> > 		...
> > 	}
> > 
> > To fix this we should validate "EALIST_SIZE(ea_buf->xattr)" 
> > before it is utilised.
> > 
> > Reported-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
> > Tested-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
> > Closes: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
> > Fixes: d9f9d96136cb ("jfs: xattr: check invalid xattr size more strictly")
> > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > ---
> >  fs/jfs/xattr.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> > index 24afbae87225..7575c51cce9b 100644
> > --- a/fs/jfs/xattr.c
> > +++ b/fs/jfs/xattr.c
> > @@ -559,11 +555,16 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
> >  
> >        size_check:
> >  	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
> > -		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> > -
> > -		printk(KERN_ERR "ea_get: invalid extended attribute\n");
> > -		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
> > -				     ea_buf->xattr, size, 1);
> > +		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
> > +			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
> > +			       EALIST_SIZE(ea_buf->xattr));
> > +		} else {
> > +			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> > +
> > +			printk(KERN_ERR "ea_get: invalid extended attribute\n");
> > +			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
> > +				       ea_buf->xattr, size, 1);
> > +		}
> >  		ea_release(inode, ea_buf);
> >  		rc = -EIO;
> >  		goto clean_up;
> > -- 
> > 2.39.5
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>   older released kernel, yet you do not have a cc: stable line in the
>   signed-off-by area at all, which means that the patch will not be
>   applied to any older kernel releases.  To properly fix this, please
>   follow the documented rules in the
>   Documentation/process/stable-kernel-rules.rst file for how to resolve
>   this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>
Hi Greg,

Just following up on this patch. I’ve sent v2 with the added CC stable tag. Here’s the link:
https://lore.kernel.org/all/20250213210553.28613-1-qasdev00@gmail.com/

Let me know if any further changes are needed.

Thanks,
Qasim
> thanks,
> 
> greg k-h's patch email bot

