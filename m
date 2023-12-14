Return-Path: <stable+bounces-6719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B2B812A33
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 09:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C5C282651
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08116402;
	Thu, 14 Dec 2023 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wmewIIee"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC4C1C6B0
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 08:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF876C43395;
	Thu, 14 Dec 2023 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702542026;
	bh=WgldY4t+s5U8rYaaPx7NM2kIjdgws/mqrpqwCOrc1Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wmewIIee8U6x7KZ0s3gRlxwAfJR98gBvk5VdViQJYGTCkBRVPS4JZWblwmDWpNzn4
	 QeCwLj/Kn7zwSDUDnWTCdW7DQxGcac6amX4lCX2OT1zyf5j+xY/DKiuOX4cg+E0pmX
	 vn2gT+kgc0vy0z0KLAG0QtJq6iBxZVXoJYOXWH/o=
Date: Thu, 14 Dec 2023 09:20:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431
Message-ID: <2023121407-composed-unscathed-5081@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <ZXjGg3SKPHFsTxkb@windriver.com>
 <2023121344-scorebook-doily-5050@gregkh>
 <ZXp2dTSlZ10aQ99t@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXp2dTSlZ10aQ99t@windriver.com>

On Wed, Dec 13, 2023 at 10:28:53PM -0500, Paul Gortmaker wrote:
> [Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 13/12/2023 (Wed 15:34) Greg KH wrote:
> 
> > On Tue, Dec 12, 2023 at 03:45:55PM -0500, Paul Gortmaker wrote:
> > > [Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CVE-2023-38431] On 12/12/2023 (Tue 21:04) Greg KH wrote:
> > > 
> > > > On Tue, Dec 12, 2023 at 01:47:44PM -0500, paul.gortmaker@windriver.com wrote:
> > > > > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > > > 
> > > > > This is a bit long, but I've never touched this code and all I can do is
> > > > > compile test it.  So the below basically represents a capture of my
> > > > > thought process in fixing this for the v5.15.y-stable branch.
> > > > 
> > > > Nice work, but really, given that there are _SO_ many ksmb patches that
> > > > have NOT been backported to 5.15.y, I would strongly recommend that we
> > > > just mark the thing as depending on BROKEN there for now as your one
> > > 
> > > I'd be 100% fine with that.  Can't speak for anyone else though.
> > > 
> > > > backport here is not going to make a dent in the fixes that need to be
> > > > applied there to resolve the known issues that the codebase currently
> > > > has resolved in newer kernels.
> > > > 
> > > > Do you use this codebase on 5.15.y?  What drove you to want to backport
> > > 
> > > I don't use it, and I don't know of anyone who does.
> > 
> > Then why are you all backporting stuff for it?
> 
> Firstly, you've cut the context where I already explained that I did it
> because others said it couldn't be done.  Of all people, I am sure you
> can respect that.

Sure, I saw that, but I didn't understand why someone was doing it in
the first place.

> The Yocto Project still offers v5.15 as an option, and whenever I can, I
> help out to advance the Yocto Project as time permits.  Ask Richard.

As an option, but is it recommended and does anyone actually use it
there?  Does yocto systems expect to use this kernel option for the
5.15 kernel?

> > If no one steps up, I'll just mark the thing as broken, it is _so_ far
> > behind in patches that it's just sad.
> 
> Again, in this case - I have no problem with that - but as a note of
> record -- whenever linux-stable removes a Kconfig, either explicitly or
> by a depends on BROKEN - it does trigger fallout for some people.

In what way?  Just having to update default config options?

> The Yocto/OE does an audit on the Kconfig output looking for options
> that were explicitly set (or un-set) by the user, or by base templates.
> If they don't land in the final .config file -- it lets you know.

So defconfig type checks?

thanks,

greg k-h

