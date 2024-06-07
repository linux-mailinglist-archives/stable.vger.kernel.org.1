Return-Path: <stable+bounces-49963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764AC90012C
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 12:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECAD1F2389A
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5B17DE36;
	Fri,  7 Jun 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYT3PVi+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773B78C96
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757412; cv=none; b=g6zrUgxM+2EWoAyjBIsAX3oHTfOeP6rLZDPdG0Y3O/WscUxf1zolN8pZ5xGwXfbJw7CQGw9z2jcFalqCuhKqNeYLPA06LWMrRLxKpPKHheUkpvNX1cfsTee8XSxP/7lrTlGy3nCYTVWsPTp+id/Unqq9W3pyGFMD6V4k977upcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757412; c=relaxed/simple;
	bh=M59btUBFNQS8PHpV32Q2lHQlpNERKenC+6HWEreGIE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j/wsxqdrkJkhsx0o6oK+K3fpe0QmgCCcuxghJssQFGAefycYWjevBu8Qsfk07M8T71fVmCAenWDQFik6FgZLqzV/gqBmJsNNegs3gU23mmIbRTplbgoW2PKGzmbqFtIjix32FBq4C756SaRIyzafTy8/vrNr6CO4NxO21DNpABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYT3PVi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D752EC32781
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717757411;
	bh=M59btUBFNQS8PHpV32Q2lHQlpNERKenC+6HWEreGIE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fYT3PVi+t/qDA4wVs11U4pGDv86N7TtcnxhgKBFQxPWtGTbPdQebTNzkOtCbLaUFW
	 WVfi7JpYUt1Bbn8d9du2NyNAgKyE3bRNyocrLHc5j7/KzOoPejoROSDPETfo5+oFi0
	 cQY3/aK78VKNmjpiuxpxOUVmFm4qVHv4Saht2kwh3o5l4uDPTlYa1xdwyyonjSRId5
	 TkAPrJH47g+X1mUPzz9Njdl51l6RcSH7Xg86I4N/FMWlRhlXQTeS5Wlu+6qBZIjuzH
	 GwUskM5R3nzCJa9vpHdlz6d3TTAc+5LU0fPT7519Om5VqgFabWAukdxbg8kAdNIbvT
	 S6roWsHhXQNBw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so37805171fa.0
        for <stable@vger.kernel.org>; Fri, 07 Jun 2024 03:50:11 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyv5uzguxTOO/gUQkYmXil2LjBuHhRGYk36o14mzXRRC4ArIVUQ
	FLU3Hxory8puen5r5HXRMeCFl4d85nKSGtSfNL/O2KnMOLPbcaGB0G32/yOPR3r37+PpTWf54yU
	F7d4EYHl1L/xzjCpucAKktSmbE3Y=
X-Google-Smtp-Source: AGHT+IGQM14UOGci2TWHc2218jPO4v1KYhF0Q2qlVCch7ZfGf+Ao8PsD46cJl9fjw5UcO/HrE6pRjf/iN2LosUpb2GY=
X-Received: by 2002:a05:651c:217:b0:2db:a9c9:4c5e with SMTP id
 38308e7fff4ca-2eadce3e2famr19646911fa.21.1717757410216; Fri, 07 Jun 2024
 03:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
 <2024060602-reacquire-nineteen-57aa@gregkh> <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>
 <2024060733-publisher-tingly-e928@gregkh> <CAMj1kXHXsTOcm8pYLnOh33dMKc31_dpPZJVXaen=-Dod4DMzuQ@mail.gmail.com>
 <CAMj1kXF_uTQetQU0GD72V=EgJQbBSLcpDwe_9LZg08dCoUPSEQ@mail.gmail.com> <2024060756-chess-riot-fb75@gregkh>
In-Reply-To: <2024060756-chess-riot-fb75@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 7 Jun 2024 12:49:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFBqpyDHw5NZ+FGGkoHPPx0BuFEeVFJkjhmjo6E0CXnJw@mail.gmail.com>
Message-ID: <CAMj1kXFBqpyDHw5NZ+FGGkoHPPx0BuFEeVFJkjhmjo6E0CXnJw@mail.gmail.com>
Subject: Re: backport request
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Jun 2024 at 12:46, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 07, 2024 at 12:27:49PM +0200, Ard Biesheuvel wrote:
> > On Fri, 7 Jun 2024 at 12:25, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Fri, 7 Jun 2024 at 12:23, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jun 07, 2024 at 10:43:19AM +0200, Ard Biesheuvel wrote:
> > > > > On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Wed, May 29, 2024 at 10:50:04AM +0200, Ard Biesheuvel wrote:
> > > > > > > Please consider commit
> > > > > > >
> > > > > > > 15aa8fb852f995dd
> > > > > > > x86/efistub: Omit physical KASLR when memory reservations exist
> > > > > > >
> > > > > > > for backporting to v6.1 and later.
> > > > > >
> > > > > > Now queued up,t hanks.
> > > > > >
> > > > >
> > > > > Thanks.
> > > > >
> > > > > I don't see it in v6.1 though - was there a problem applying it there?
> > > >
> > > > Nope, it's right here:
> > > >         https://lore.kernel.org/all/20240606131701.442284898@linuxfoundation.org/
> > >
> > > I don't see it here
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=linux-6.1.y
> >
> > Sorry, I meant here
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/6.1
> >
> > the other queues do have it.
>
> Those "queue" branches are auto-generated somehow on the backend, I have
> no idea how that happens as I am not involved in them at all..  The
> referenced commit is in the stable queue git repo, which is what we
> actually work off of, and is what we generate the other things from
> (releases, and -rcs), so I don't know what is going on here, sorry.  But
> don't worry, the commit is in the quilt series to be applied in the next
> 6.1.y release.
>

Ah ok, good to know - thanks.

