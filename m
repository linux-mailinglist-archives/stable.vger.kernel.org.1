Return-Path: <stable+bounces-116485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC398A36C84
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 08:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 645B1188C7AC
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 07:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27618B484;
	Sat, 15 Feb 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wYaOrRpV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0DF126C18
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739605585; cv=none; b=TLlhcGWKQp17sROyjpX3B7+RZAKIH+gk6M8+3w9Oo6GyF+7XUQu3T3/cdrvLLuvDB8oh5mLuqbvN1nc/6PV4Wwcs6MvalITs5wfP8a8d+luCe71RrGwIAcGi2NjYQvwI4sWnZG3Fc74WCatdMrS8GiTpnOKaCoMlSRDEHCFv10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739605585; c=relaxed/simple;
	bh=K/QmLZXWUymP+p68PHeGBdYnEjVYZ5KZCICrY2vL9VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UucpuLtNlFMu9BO+iNgDMDsdCx9ibYoAbA1LdTcD0FuKE6bI6THLti6+oCSqg2MB20tqzYKUdBZTKvIovqdHvFK8l+pGPNiaJC/P1kUfa9esEELYacrSzXuUK16iLkxhMBtBxMx72Cmqmq9gXe+YDP0xLVvyFBFbshivdfmTyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wYaOrRpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ECEC4CEDF;
	Sat, 15 Feb 2025 07:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739605585;
	bh=K/QmLZXWUymP+p68PHeGBdYnEjVYZ5KZCICrY2vL9VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wYaOrRpVA0CFVoSm+HIajZoCPQr1DTIo8pZ3aP8QXAjyQh3/UKs3gnYbiItBSbqY9
	 eYeKu73JkuzNE6xaABsJOd1YmNW+5fLWSiQ3z5aT0Y20W4RbLWsQrBfQtiCj/YDbEW
	 5V47AUPrJM1Y8g84kIKzHjzKWkp0S2o0WyisrysI=
Date: Sat, 15 Feb 2025 08:46:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>,
	Waiman Long <longman@redhat.com>, stable <stable@vger.kernel.org>
Subject: Re: Suspend failures (was [PATCH 6.13 000/443] 6.13.3-rc1 review)
Message-ID: <2025021555-pebble-eclipse-0ad3@gregkh>
References: <20250213142440.609878115@linuxfoundation.org>
 <e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com>
 <2025021459-guise-graph-edb3@gregkh>
 <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
 <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
 <9d2efa62-3b80-b594-5173-ca711a391dbe@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d2efa62-3b80-b594-5173-ca711a391dbe@applied-asynchrony.com>

On Sat, Feb 15, 2025 at 01:48:34AM +0100, Holger Hoffstätte wrote:
> On 2025-02-15 00:18, Linus Torvalds wrote:
> > Adding more people: Peter / Phil / Waiman. Juri was already on the list earlier.
> > 
> > On Fri, 14 Feb 2025 at 02:12, Holger Hoffstätte
> > <holger@applied-asynchrony.com> wrote:
> > > 
> > > Whoop! Whoop! The sound of da police!
> > > 
> > > 2ce2a62881abcd379b714bf41aa671ad7657bdd2 is the first bad commit
> > > commit 2ce2a62881abcd379b714bf41aa671ad7657bdd2 (HEAD)
> > > Author: Juri Lelli <juri.lelli@redhat.com>
> > > Date:   Fri Nov 15 11:48:29 2024 +0000
> > > 
> > >       sched/deadline: Check bandwidth overflow earlier for hotplug
> > > 
> > >       [ Upstream commit 53916d5fd3c0b658de3463439dd2b7ce765072cb ]
> > > 
> > > With this reverted it reliably suspends again.
> > 
> > Can you check that it works (or - more likely - doesn't work) in upstream?
> > 
> > That commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> > earlier for hotplug") got merged during the current merge window, so
> > it would be lovely if you can check whether current -git (or just the
> > latest 6.14-rc) works for you, or has the same breakage.
> > 
> > Background for new people on the participants list: original report at
> > 
> >    https://lore.kernel.org/all/e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com/
> > 
> > which says
> > 
> > > > Common symptom on all machines seems to be
> > > > 
> > > > [  +0.000134] Disabling non-boot CPUs ...
> > > > [  +0.000072] Error taking CPU15 down: -16
> > > > [  +0.000002] Non-boot CPUs are not disabled
> > 
> > and this bisection result is from
> > 
> >    https://lore.kernel.org/all/9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com/
> > 
> > and if it breaks in 6.13 -stable, I would expect the same in the
> > current tree. Unless there's some non-obvious interaction with
> > something else ?
> 
> I just booted into current 6.14-git and could suspend/wakeup multiple times without
> any problem - no reverting necessary, so that is good.
> 
> As for 6.12/6.13 it might be necessary to revert an accompanying commit
> as well since it seems to cause test failures with hotplug, as documented here:
> 
>   https://lore.kernel.org/stable/bcf76664-e77c-44b3-b78f-bcefc7aa3fc1@nvidia.com/
> 
> ..but I don't know anything about that; I just wanted to find the patch causing
> the suspend problem. Other than that 6.13.3-rc2 works fine.
> 
> Not sure if that was useful information. :)

Yes, thanks, I'll go drop this other patch from the stable queues as
taking only 1 of a 3 patch series generally isn't good :)

greg k-h

