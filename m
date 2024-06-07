Return-Path: <stable+bounces-49962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67275900121
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 12:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C91B23059
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C3517F37A;
	Fri,  7 Jun 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G53lCtNc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579F17F391
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757193; cv=none; b=lOr0P1I9Gx6foOpngc7pwJaaiDiYla7NYh98olsntomHulE35VFJyTHBRkdjKQQuavoWBlEEnQRXESDAqsQZsC0nCMXvJqT4b4RKgvliUsO/ivWjdJciYa93+bfFIwASoFQyjodwTOLAYhbY+CsZ83Tx/t2RsKz3TQk9fEDI1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757193; c=relaxed/simple;
	bh=SsVw4jKSDMcuXKJN6SgPeAyx3O2L2KhrS0dG9lBpVWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCAVpQJULGNkRJIWmd5sRGt4flBGVbvVL9i8qzFKT2+U9wv7cUCnFCgH9nsnvVt/pSs5YHUNHefmOT+PKpy6k1Z870/qha/mSCP2xDILh4v2TA2Hb92D7zvJOuTTpPEtNKS9wlCc69MEE48h5mtzOrmDBw1Gn826gtOT/yPpBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G53lCtNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDA5C2BBFC;
	Fri,  7 Jun 2024 10:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717757191;
	bh=SsVw4jKSDMcuXKJN6SgPeAyx3O2L2KhrS0dG9lBpVWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G53lCtNc/BwM9YaKiRH0MhZZvp7P4UX53Zq1er1JqyK5Tmzu3/BPBcfGFEQOkScap
	 YflZ6KT62d3Pd/bgFlZjp1hY5C4RxIytR7r+TkFJtwuHkCSrZ57NG/ffr6IrZjm7Ib
	 zxqYIDN4uIWiPAcaoQxg5dZe6f0iEB3nFigMEpoE=
Date: Fri, 7 Jun 2024 12:46:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: backport request
Message-ID: <2024060756-chess-riot-fb75@gregkh>
References: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
 <2024060602-reacquire-nineteen-57aa@gregkh>
 <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>
 <2024060733-publisher-tingly-e928@gregkh>
 <CAMj1kXHXsTOcm8pYLnOh33dMKc31_dpPZJVXaen=-Dod4DMzuQ@mail.gmail.com>
 <CAMj1kXF_uTQetQU0GD72V=EgJQbBSLcpDwe_9LZg08dCoUPSEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF_uTQetQU0GD72V=EgJQbBSLcpDwe_9LZg08dCoUPSEQ@mail.gmail.com>

On Fri, Jun 07, 2024 at 12:27:49PM +0200, Ard Biesheuvel wrote:
> On Fri, 7 Jun 2024 at 12:25, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Fri, 7 Jun 2024 at 12:23, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Jun 07, 2024 at 10:43:19AM +0200, Ard Biesheuvel wrote:
> > > > On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Wed, May 29, 2024 at 10:50:04AM +0200, Ard Biesheuvel wrote:
> > > > > > Please consider commit
> > > > > >
> > > > > > 15aa8fb852f995dd
> > > > > > x86/efistub: Omit physical KASLR when memory reservations exist
> > > > > >
> > > > > > for backporting to v6.1 and later.
> > > > >
> > > > > Now queued up,t hanks.
> > > > >
> > > >
> > > > Thanks.
> > > >
> > > > I don't see it in v6.1 though - was there a problem applying it there?
> > >
> > > Nope, it's right here:
> > >         https://lore.kernel.org/all/20240606131701.442284898@linuxfoundation.org/
> >
> > I don't see it here
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-6.1.y
> 
> Sorry, I meant here
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/6.1
> 
> the other queues do have it.

Those "queue" branches are auto-generated somehow on the backend, I have
no idea how that happens as I am not involved in them at all..  The
referenced commit is in the stable queue git repo, which is what we
actually work off of, and is what we generate the other things from
(releases, and -rcs), so I don't know what is going on here, sorry.  But
don't worry, the commit is in the quilt series to be applied in the next
6.1.y release.

thanks,

greg k-h

