Return-Path: <stable+bounces-81222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D489927C8
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671F3282B6B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B418A6D3;
	Mon,  7 Oct 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A+13tIXI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13628EA;
	Mon,  7 Oct 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291942; cv=none; b=uMPM5jL9f7X1CjAJNJfyen/RgIsLTd3+sI8TRjRS3XCXc6V5lIvFrPdM0JDk6j2hoBV5K3nk7Rl3+EV35tzwhnoOA9wJoGSB2cZl6BVpKe/Nd/NwhsBToK6BuO01rK5HjzAjA/L2t3TL/ke3GUf7F0bNDQGCes/84+Zn1EcB3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291942; c=relaxed/simple;
	bh=uQeNvsiSV1kj3jk5hB6wIWiHs0hBMW7OkluGU+OeX3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCQfeTatJAjGQDKsisz1G0FhNKvSSlKmC7mgHh/eZeDRuCgOJ8NReeALa0uKrE9mFomX4YOhWon4ieBW0Ik9dhpBBlcCA94+1l1AAAzCOpHU8B1c+hSkDaqaCzMSU3k3KeXg7T2f9R5oc9KpCEg+e6CixXEYd6r/dw7Us4Plem8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A+13tIXI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057C3C4CEC6;
	Mon,  7 Oct 2024 09:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728291941;
	bh=uQeNvsiSV1kj3jk5hB6wIWiHs0hBMW7OkluGU+OeX3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A+13tIXI6PXQBoHMp7h3fIsc954/fJ6T2DXmsGuUWbR29gm2C/jcG8G1CKA8BGvTj
	 SYj5c2Igz8mAe2QUyCKaYV9UCUPwDKM1cFRCylVFzcvlAtgQy8R9pJfke1LibUbeim
	 ptpPntUkGBXKvafVHVOOz3DeHz0EHtBWXfdwoK9I=
Date: Mon, 7 Oct 2024 11:05:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, usama.anjum@collabora.com, peterx@redhat.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: remove the newlines, which are added for unknown
 reasons and interfere with bug analysis
Message-ID: <2024100700-animal-upriver-fb7c@gregkh>
References: <20241007065307.4158-1-aha310510@gmail.com>
 <2024100748-exhume-overgrown-bf0d@gregkh>
 <CAO9qdTFwaK36EKV1c8gLCgBG+BR5JmC6=PGk2a6YdHVrH9NukQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9qdTFwaK36EKV1c8gLCgBG+BR5JmC6=PGk2a6YdHVrH9NukQ@mail.gmail.com>

On Mon, Oct 07, 2024 at 05:57:18PM +0900, Jeongjun Park wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Oct 07, 2024 at 03:53:07PM +0900, Jeongjun Park wrote:
> > > Looking at the source code links for mm/memory.c in the sample reports
> > > in the syzbot report links [1].
> > >
> > > it looks like the line numbers are designated as lines that have been
> > > increased by 1. This may seem like a problem with syzkaller or the
> > > addr2line program that assigns the line numbers, but there is no problem
> > > with either of them.
> > >
> > > In the previous commit d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC"),
> > > when modifying mm/memory.c, an unknown line break is added to the very first
> > > line of the file. However, the git.kernel.org site displays the source code
> > > with the added line break removed, so even though addr2line has assigned
> > > the correct line number, it looks like the line number has increased by 1.
> > >
> > > This may seem like a trivial thing, but I think it would be appropriate
> > > to remove all the newline characters added to the upstream and stable
> > > versions, as they are not only incorrect in terms of code style but also
> > > hinder bug analysis.
> > >
> > > [1]
> > >
> > > https://syzkaller.appspot.com/bug?extid=4145b11cdf925264bff4
> > > https://syzkaller.appspot.com/bug?extid=fa43f1b63e3aa6f66329
> > > https://syzkaller.appspot.com/bug?extid=890a1df7294175947697
> > >
> > > Fixes: d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > ---
> > >  mm/memory.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 2366578015ad..7dffe8749014 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -1,4 +1,3 @@
> > > -
> >
> > This sounds like you have broken tools that can not handle an empty line
> > in a file.
> >
> > Why not fix those?
> 
> As I mentioned above, there is no problem with addr2line's ability to parse
> the code line that called the function in the calltrace of the crash report.
> 
> However, when the source code of mm/memory.c is printed on the screen on the
> git.kernel.org site, the line break character that exists in the first line
> of the file is deleted and printed, so as a result, all code lines in the
> mm/memory.c file are located at line numbers that are -1 less than the
> actual line.
> 
> You can understand it easily if you compare the source code of mm/memory.c
> on github and git.kernel.org.
> 
> https://github.com/torvalds/linux/blob/master/mm/memory.c
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/memory.c
> 
> Since I cannot modify the source code printing function of the git.kernel.org
> site, the best solution I can suggest is to remove the unnecessary line break
> character that exists in all versions.

I would recommend fixing the git.kernel.org code, it is all open source
and can be fixed up, as odds are other projects/repos would like to have
it fixed as well.

thanks,

greg k-h

