Return-Path: <stable+bounces-133191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF41AA91F33
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC3B3A5DEC
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 14:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323524886B;
	Thu, 17 Apr 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ips7QsGf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B3241CBA
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744899028; cv=none; b=kwqA+e4jPR6haMtc0Z37vhPJ4BULL+P1ZHE+ucX8INMJLvdR8zwdThfJ50ZdH5OXMe5hSB2h46sB0nP+h34VeZeq66vp+SA/gI05o6LIrkG7u4eAo7WhgILizFOLgELQnR37eKiF+yMcNuiE9vjGlJQou/I8I/6SFJXcKaAaPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744899028; c=relaxed/simple;
	bh=qDX4QYqoZpE2k3A5FoOLmBJA+XMFR/OdSvPKGnaKZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYvKIlQ5UtCoL46joKIQXhyDwoaWGwSo11BOPo4ZOOLgvTRGdoB2yBxSKn3A6xCjRv083sx4XdNTEuWqERSG+HNRO43j3/4mvIHb21kWI2s02HD9v3Ubb5iE7T+M2SToVYTkQlimZ4dYTv2PGDF2QXCn219qBTiU0t3cR/AnC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ips7QsGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C19C4CEEA;
	Thu, 17 Apr 2025 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744899028;
	bh=qDX4QYqoZpE2k3A5FoOLmBJA+XMFR/OdSvPKGnaKZrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ips7QsGf0P9977xgYfMCmj2fYpKdlzlaEiXqvY7squnvJUJAcYfBTFTY4ZvspvEul
	 Vho9e93FwOhaH9k34o7DaY86zLCYvlG9wPFXg1JyKpSwerfgss/ZTfSePREVaQxGCB
	 m5QUImhZwxPu8soEm4ymZlHFzyu1pTySQOcamHF4=
Date: Thu, 17 Apr 2025 16:10:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Doug Anderson <dianders@chromium.org>
Cc: catalin.marinas@arm.com, james.morse@arm.com, stable@vger.kernel.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: FAILED: patch "[PATCH] arm64: errata: Add newer ARM cores to
 the" failed to apply to 6.14-stable tree
Message-ID: <2025041705-contented-pony-7ff8@gregkh>
References: <2025040844-unlivable-strum-7c2f@gregkh>
 <CAD=FV=U=7G-V2FBNHJ5=bE+BVa1Jcbd=fi-zD4wCVAwxcpU2ww@mail.gmail.com>
 <CAD=FV=UrERLaPhPznUkW-O-K=_-uBROScPYy1eC_7RrDGXPS=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UrERLaPhPznUkW-O-K=_-uBROScPYy1eC_7RrDGXPS=w@mail.gmail.com>

On Mon, Apr 14, 2025 at 08:37:36AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Apr 8, 2025 at 8:49 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Apr 8, 2025 at 2:17 AM <gregkh@linuxfoundation.org> wrote:
> > >
> > >
> > > The patch below does not apply to the 6.14-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > >
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x a5951389e58d2e816eed3dbec5877de9327fd881
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040844-unlivable-strum-7c2f@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> >
> > FWIW, this patch applies cleanly for me to the top of 6.14.y if you
> > simply apply all 5 patches in the series, all of which are CC stable.
> > AKA these commands work
> >
> > git checkout v6.14.1 # Current linux-6.14.y
> > git cherry-pick ed1ce841245d~..a5951389e58d
> >
> > Where you start getting a conflict is if you also take this patch from mainline:
> >
> > e3121298c7fc arm64: Modify _midr_range() functions to read MIDR/REVIDR
> > internally
> >
> > The merge conflict between those two series was resolved upstream in:
> >
> > edb0e8f6e2e1 Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> 
> I tried again as of today's linux-6.14.y (which is 6.14.2), and the
> patches still apply cleanly. I can send all 5 patches to the lists if
> it's desired, but I'm uncertain if it's required since they all apply
> cleanly. Just "git cherry-pick ed1ce841245d~..a5951389e58d". They all
> apply cleanly all the way back to 5.15 as far as I can tell. Would I
> need to send the same 5 clean picks in response to every stable kernel
> from 5.15 all the way to 6.14?

I see all but the last one in the stable queues right now, let me try
the last one...

Ok, that one also applied from 5.15.y and newer.

> These patches don't apply cleanly to 5.4, but that's because kernel
> 5.4 doesn't have `proton-pack.c`, so presumably none of the Spectre
> mitigations were ported back that far.
> 
> Some of the spectre stuff is present in 5.10, but it looks like not
> all patches are being picked there. It's probably not critical to
> support newer ARM cores there, but changing the default to say cores
> are vulnerable might be worth it? What do folks think?a

That's up to you.

thanks,

greg k-h

