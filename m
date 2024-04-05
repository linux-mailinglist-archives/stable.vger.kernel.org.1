Return-Path: <stable+bounces-36139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F789A28D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 18:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36DF282204
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 16:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6DD200DB;
	Fri,  5 Apr 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v6KwdisF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474591B962;
	Fri,  5 Apr 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334707; cv=none; b=dIJX0/GbRrA/I7Xbk6iCZeyFK//oSS90u8ePX/9Sv+atH1/7X5w0FyTrugZIzQua+s/jYzVEt/RZmDAdqOBg97WJa6nI37zp+5pl8nltpva5sXmIZLl/GWgDM0gmBNsQiqzgxDvyTzIg+IYd8kEIcG8roBBzEjKJ+2m12/5YvRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334707; c=relaxed/simple;
	bh=vLB0RLP186o5BEmkFHpB0kflt/kis3fM7NERkY/HLhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+XJj189REZ2Iyv0ER5hXH+RFeHOH1OBtgRCHw8+xoWiTexdjMIORd5xi/9wWCoQBjg+hV7x2Gqgz/E8EhnBz3lYg5Th/6sXxC7j4O2pBDrERQuNseOAGtkzvUwe7GBeCiYqmEg99cnhaoBvX1x31UsCAi91kRam7czYIxGXVjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v6KwdisF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53298C43390;
	Fri,  5 Apr 2024 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712334706;
	bh=vLB0RLP186o5BEmkFHpB0kflt/kis3fM7NERkY/HLhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v6KwdisFlpX+JbXFyx8pMdROjMYtxZklBmJEUvRbq5STZFLpMEfYlL04XenV68Kza
	 wqB5GHkc3hBorAOul3pkOB/6H/7XfPWXFe5GOqTHxDs+x4k9ZuWM8tscUi4CbljNeP
	 lKqjnICO5m2aQVZrY3Ry9Su3bCSUL9hEPaKBp73Y=
Date: Fri, 5 Apr 2024 18:31:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org,
	stable@vger.kernel.org, bpf <bpf@vger.kernel.org>
Subject: Re: FAILED: patch "[PATCH] bpf: support deferring bpf_link dealloc
 to after RCU grace" failed to apply to 6.8-stable tree
Message-ID: <2024040528-backroom-hardened-4248@gregkh>
References: <2024040527-propeller-immovably-a6d8@gregkh>
 <CAEf4BzaNmxj2nLyxiugcmC1v1Cs7HEX2Z0-3a=P323-TxHHTXQ@mail.gmail.com>
 <CAEf4BzY03zZrHUXTNop8+PMt=-d0+oOaWBnJyPTSSOvKv1mgNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY03zZrHUXTNop8+PMt=-d0+oOaWBnJyPTSSOvKv1mgNg@mail.gmail.com>

On Fri, Apr 05, 2024 at 09:21:15AM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 5, 2024 at 9:15 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Apr 5, 2024 at 2:50 AM <gregkh@linuxfoundation.org> wrote:
> > >
> > >
> > > The patch below does not apply to the 6.8-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> >
> > This is strange, I get a clean auto-merged cherry-pick:
> >
> > $ git co linux-6.8.y
> > Updating files: 100% (10694/10694), done.
> > branch 'linux-6.8.y' set up to track 'stable/linux-6.8.y'.
> > Switched to a new branch 'linux-6.8.y'
> > $ git cp -x 1a80dbcb2dbaf6e4c216e62e30fa7d3daa8001ce
> > Auto-merging include/linux/bpf.h
> > Auto-merging kernel/bpf/syscall.c
> > Auto-merging kernel/trace/bpf_trace.c
> > [linux-6.8.y fd74c60792f5] bpf: support deferring bpf_link dealloc to
> > after RCU grace period
> >  Date: Wed Mar 27 22:24:26 2024 -0700
> >  3 files changed, 49 insertions(+), 6 deletions(-)
> >
> > Note that e9c856cabefb ("bpf: put uprobe link's path and task in
> > release callback") has to be backported at the same time. I'll
> > cherry-pick both and will send it just in case.
> >
> 
> Ah, so it doesn't build (trivial link->prog->sleepable ->
> link->prog->aux->sleepable change, will fix up). Not sure if possible,
> but it would be nice to distinguish between patch not applying vs it
> causing build (or test) failures, but no big deal.

I only have 1 script, sorry :)

thanks,

greg k-h

