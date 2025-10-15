Return-Path: <stable+bounces-185761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DA9BDD5BD
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F4384E3BF6
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152712D3725;
	Wed, 15 Oct 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H7FQ+NwQ"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1A26560B;
	Wed, 15 Oct 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516548; cv=none; b=sTi8brN7XAKkvjA2LQn7jJtJ9jyvVLjrfrOefI4ME7kYo76ssxlcpEC2/jdi1Uj5JDwuQB6ozNiGx0SDduK6ngJxo2ObtSdJYA8ZkxXAQxcXqbibU4bpUfsHd9NerUGrfNs7przSI4JsQb2Z+qA2V4K+Ff7l6kcTSoDrJd2AVIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516548; c=relaxed/simple;
	bh=DPnN3fs/48GuvsaJ++ya+X9QIA2J4RNJ6uIWPggURm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etQyEjyc4gucUEP4LQXoDDoSRV2vZjkvjRtGqnv4gcroZ6rA3zAUQZSD9XRGcAnOdxeQGTReOxpLYkqD26i2O1rlh30A5pbZA+hOcKxgIwnqu9zVL9ye7C3648LZgZNYuaGrjT9Ycr+PD/smlylJmB+42H/Gi55Iklbjv7aLcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H7FQ+NwQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OFfO0mv+1F8CEwMk5csVg/s97taAvNwLC7BBBi9ptXk=; b=H7FQ+NwQupAQ420QioBzGjAlx+
	GdRk9GIlGOuN2F+a1X1DT0a6l0Kvv/bSFq3l2xOnQTpEfUGxpm3nenpiwTQliwYD5698HpZbd2CTS
	jQEJ20NcqOwBr2LPpq0fq0QTXS9FxB8u0DOikXNFLA5C0oLhsts9JRhQYRvw5NW5lPOOx3HN1sMlN
	Vgj7TiRn+40v7aGn6XyghGPQNtoIJK3DQA+mZ8cb95B8WMdjY1Q4Acj5UC3lNyauVsbTlW2A+iFD0
	1SgbLcQVD75zEsglEgRwxsMOaS3Z1clJCoX95I+q81ToBo+phO1i6d2QpcphJPMCFkH42FGofH/rQ
	8LeKB3FQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8wm1-00000005neg-2WuI;
	Wed, 15 Oct 2025 08:22:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2D13830023C; Wed, 15 Oct 2025 10:22:16 +0200 (CEST)
Date: Wed, 15 Oct 2025 10:22:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Matt Fleming <matt@readmodwrite.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>,
	Oleg Nesterov <oleg@redhat.com>, John Stultz <jstultz@google.com>,
	Chris Arges <carges@cloudflare.com>
Subject: Re: [PATCH v6.12] sched/fair: Block delayed tasks on throttled
 hierarchy during dequeue
Message-ID: <20251015082216.GP4067720@noisy.programming.kicks-ass.net>
References: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
 <20251015060359.34722-1-kprateek.nayak@amd.com>
 <2025101516-skeletal-munchkin-0e85@gregkh>
 <fe9320d4-9da0-4de8-8e1e-ec03ecf582a1@amd.com>
 <2025101506-haven-degree-8073@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101506-haven-degree-8073@gregkh>

On Wed, Oct 15, 2025 at 09:27:53AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 15, 2025 at 11:57:19AM +0530, K Prateek Nayak wrote:
> > Hello Greg,
> > 
> > On 10/15/2025 11:44 AM, Greg Kroah-Hartman wrote:
> > >> Greg, Sasha,
> > >>
> > >> This fix cleanly applies on top of v6.16.y and v6.17.y stable kernels
> > >> too when cherry-picked from v6.12.y branch (or with 'git am -3'). Let me
> > >> know if you would like me to send a seperate patch for each.
> > >>
> > >> As mentioned above, the upstream fixes this as a part of larger feature
> > >> and we would only like these bits backported. If there are any future
> > >> conflicts in this area during backporting, I would be more than happy to
> > >> help out resolve them.
> > > 
> > > Why not just backport all of the mainline changes instead?  As I say a
> > > lot, whenever we do these "one off" changes, it's almost always wrong
> > > and causes problems over the years going forward as other changes around
> > > the same area can not be backported either.
> > > 
> > > So please, try to just backport the original commits.
> > 
> > Peter was in favor of backporting just the necessary bits in
> > https://lore.kernel.org/all/20250929103836.GK3419281@noisy.programming.kicks-ass.net/
> > 
> > Backporting the whole of per-task throttle feature is lot more heavy
> > handed with the core changes adding:
> > 
> >  include/linux/sched.h |   5 +
> >  kernel/sched/core.c   |   3 +
> >  kernel/sched/fair.c   | 451 ++++++++++++++++++++++++------------------
> >  kernel/sched/pelt.h   |   4 +-
> >  kernel/sched/sched.h  |   7 +-
> >  5 files changed, 274 insertions(+), 196 deletions(-)
> 
> That's very tiny overall in the scheme of what we take for the stable
> trees.
> 
> > And a few more fixes that will add to the above before v6.18. I'll defer
> > to Peter to decide the best course of action.
> 
> We'll defer to the maintainers of the subsystem as to what they want
> here.  If they say take this smaller patch, we'll be glad to do so.

So if the timing of all this would've been slightly different, I'd have
taken the smaller patch and routed it through sched/urgent in time for
the 6.17 release. And we'd not have had this discussion, but alas.

Also, while we're fairly confident in the task throttling rework, it is
somewhat invasive and hasn't seen widespread testing -- it is
conceivable there are performance issues.

So at this point I would really rather backport the smaller patch that
fixes the immediate bug.

Thanks!

