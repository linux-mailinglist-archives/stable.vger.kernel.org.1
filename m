Return-Path: <stable+bounces-203422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0388CDEB10
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 13:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D9363006733
	for <lists+stable@lfdr.de>; Fri, 26 Dec 2025 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18D280312;
	Fri, 26 Dec 2025 12:21:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5073314B6E;
	Fri, 26 Dec 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766751677; cv=none; b=hiqT5vcF0jZbdtshsZPT3CC4y0L/6DfHijuoVHS0ef4O43qKnFPpRgy8GxtNETx4bcM7xN91kKVCUMsDf15iPsBuBaIWAf6KqO4evcpBlM62JoXLSJqxuUUU3FMfHSPY9f+wHZBAZZlDuscW8i+6AaR9N/9VCnkzkr9ueW5qgws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766751677; c=relaxed/simple;
	bh=XfD4oBld84hGa0frYTJY3dTeUChuqIrn5kecni3QS+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCAVAhElRe4Rh9hD7FnlrU572z6i/DhLEkKq7SuGZ9K2mzZyet2UoG4Ypi2KZd2hqVwxaI5Ce+YSRpCQ+2H16u1fbejZlzBOqkjk5tQs6ABc/gp5k3yZfGvMho5TerppZ5Ztkc9P9MtgD0E4Q/fM554y9jrNUTZ6UnnGSrctea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id E0FF172C8CC;
	Fri, 26 Dec 2025 15:21:12 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id CC2F636D00D1;
	Fri, 26 Dec 2025 15:21:12 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id A1B95360D63C; Fri, 26 Dec 2025 15:21:12 +0300 (MSK)
Date: Fri, 26 Dec 2025 15:21:12 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Junjie Cao <junjie.cao@intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peilin Ye <yepeilin.cs@gmail.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Shigeru Yoshida <syoshida@redhat.com>, 
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>, Zsolt Kajtar <soci@c64.rulez.org>, 
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2] fbdev: bitblit: bound-check glyph index in bit_putcs*
Message-ID: <aU58SeZZPxScVPad@altlinux.org>
References: <20251020134701.84082-1-junjie.cao@intel.com>
 <aU23brU4lZqIkw4Z@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU23brU4lZqIkw4Z@altlinux.org>

Dear linux-fbdev, stable,

On Fri, Dec 26, 2025 at 01:29:13AM +0300, Vitaly Chikunov wrote:
> 
> On Mon, Oct 20, 2025 at 09:47:01PM +0800, Junjie Cao wrote:
> > bit_putcs_aligned()/unaligned() derived the glyph pointer from the
> > character value masked by 0xff/0x1ff, which may exceed the actual font's
> > glyph count and read past the end of the built-in font array.
> > Clamp the index to the actual glyph count before computing the address.
> > 
> > This fixes a global out-of-bounds read reported by syzbot.
> > 
> > Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
> > Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
> > Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> 
> This commit is applied to v5.10.247 and causes a regression: when
> switching VT with ctrl-alt-f2 the screen is blank or completely filled
> with angle characters, then new text is not appearing (or not visible).
> 
> This commit is found with git bisect from v5.10.246 to v5.10.247:
> 
>   0998a6cb232674408a03e8561dc15aa266b2f53b is the first bad commit
>   commit 0998a6cb232674408a03e8561dc15aa266b2f53b
>   Author:     Junjie Cao <junjie.cao@intel.com>
>   AuthorDate: 2025-10-20 21:47:01 +0800
>   Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>   CommitDate: 2025-12-07 06:08:07 +0900
> 
>       fbdev: bitblit: bound-check glyph index in bit_putcs*
> 
>       commit 18c4ef4e765a798b47980555ed665d78b71aeadf upstream.
> 
>       bit_putcs_aligned()/unaligned() derived the glyph pointer from the
>       character value masked by 0xff/0x1ff, which may exceed the actual font's
>       glyph count and read past the end of the built-in font array.
>       Clamp the index to the actual glyph count before computing the address.
> 
>       This fixes a global out-of-bounds read reported by syzbot.
> 
>       Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>       Closes: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
>       Tested-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com
>       Signed-off-by: Junjie Cao <junjie.cao@intel.com>
>       Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>       Signed-off-by: Helge Deller <deller@gmx.de>
>       Cc: stable@vger.kernel.org
>       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>    drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
>    1 file changed, 12 insertions(+), 4 deletions(-)
> 
> The minimal reproducer in cli, after kernel is booted:
> 
>   date >/dev/tty2; chvt 2
> 
> and the date does not appear.
> 
> Thanks,
> 
> #regzbot introduced: 0998a6cb232674408a03e8561dc15aa266b2f53b
> 
> > ---
> > v1: https://lore.kernel.org/linux-fbdev/5d237d1a-a528-4205-a4d8-71709134f1e1@suse.de/
> > v1 -> v2:
> >  - Fix indentation and add blank line after declarations with the .pl helper
> >  - No functional changes
> > 
> >  drivers/video/fbdev/core/bitblit.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
> > index 9d2e59796c3e..085ffb44c51a 100644
> > --- a/drivers/video/fbdev/core/bitblit.c
> > +++ b/drivers/video/fbdev/core/bitblit.c
> > @@ -79,12 +79,16 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
> >  				     struct fb_image *image, u8 *buf, u8 *dst)
> >  {
> >  	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
> > +	unsigned int charcnt = vc->vc_font.charcount;

Perhaps, vc->vc_font.charcount (which is relied upon in the following
comparison) is not always set correctly in v5.10.247. At least two
commits that set vc_font.charcount are missing from v5.10.247:

  a1ac250a82a5 ("fbcon: Avoid using FNTCHARCNT() and hard-coded built-in font charcount")
  a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")

Thanks,


> >  	u32 idx = vc->vc_font.width >> 3;
> >  	u8 *src;
> >  
> >  	while (cnt--) {
> > -		src = vc->vc_font.data + (scr_readw(s++)&
> > -					  charmask)*cellsize;
> > +		u16 ch = scr_readw(s++) & charmask;
> > +
> > +		if (ch >= charcnt)
> > +			ch = 0;
> > +		src = vc->vc_font.data + (unsigned int)ch * cellsize;
> >  
> >  		if (attr) {
> >  			update_attr(buf, src, attr, vc);
> > @@ -112,14 +116,18 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
> >  				       u8 *dst)
> >  {
> >  	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
> > +	unsigned int charcnt = vc->vc_font.charcount;
> >  	u32 shift_low = 0, mod = vc->vc_font.width % 8;
> >  	u32 shift_high = 8;
> >  	u32 idx = vc->vc_font.width >> 3;
> >  	u8 *src;
> >  
> >  	while (cnt--) {
> > -		src = vc->vc_font.data + (scr_readw(s++)&
> > -					  charmask)*cellsize;
> > +		u16 ch = scr_readw(s++) & charmask;
> > +
> > +		if (ch >= charcnt)
> > +			ch = 0;
> > +		src = vc->vc_font.data + (unsigned int)ch * cellsize;
> >  
> >  		if (attr) {
> >  			update_attr(buf, src, attr, vc);
> > -- 
> > 2.48.1
> > 

