Return-Path: <stable+bounces-185758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AF5BDD214
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 09:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954E01893237
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B431329D;
	Wed, 15 Oct 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rwL1z5EW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F50225C711;
	Wed, 15 Oct 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513277; cv=none; b=mKubujvN48Rle1stndgLmDGQ+UHrrfY41pbqYrrVISV4R8SBKQYN/XldauOgZx9Xbmp35D7M5psmC2P7UBt9czbPnV3hK5BU46lTNPIEWzFUNghbAZVrSGHVwEeOrjPElqRdtMV9MGIPtZIsr/rNDWMNAzT3FF2NlmAP2tGyXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513277; c=relaxed/simple;
	bh=Is/mP9CnZEFwJxb1uzYaRcwSHWOY1wuKhM2uP3rRUJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irc2OsUCRwWTNFiSCl5tO4Aw3wYSusghZ5DGbSDHSkMhDhi3WgNL7rf07gGMepu6l3ba8vtc/E81kHkc3gVUwZppq0zZE9T6SjLkmZ8E1smFY8tpO+eBXj8oHXiovs+wbaxQhCAjfOn0TPExNsmA2Tmw+xuddSwJ99cz17cyp3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rwL1z5EW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF8BC4CEF9;
	Wed, 15 Oct 2025 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760513276;
	bh=Is/mP9CnZEFwJxb1uzYaRcwSHWOY1wuKhM2uP3rRUJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwL1z5EW+qSFrYpFZVR1YT3E/vIpsHeoTmt9epBW0hzKMzRbbmnX5rLXGiAMRPrdY
	 XZbb6zxaiBpFO6Yh5f6rAq6/m4UjoTsJCjeOukI5TtZeFcQeIKUDaaZdrb0lv+JJD4
	 mSu1qU//c7aMSCNfWaZjEEv1bswPScfLp9xoRNIo=
Date: Wed, 15 Oct 2025 09:27:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Matt Fleming <matt@readmodwrite.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
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
Message-ID: <2025101506-haven-degree-8073@gregkh>
References: <CAENh_SRj9pMyMLZAM0WVr3tuD5ogMQySzkPoiHu4SRoGFkmnZw@mail.gmail.com>
 <20251015060359.34722-1-kprateek.nayak@amd.com>
 <2025101516-skeletal-munchkin-0e85@gregkh>
 <fe9320d4-9da0-4de8-8e1e-ec03ecf582a1@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe9320d4-9da0-4de8-8e1e-ec03ecf582a1@amd.com>

On Wed, Oct 15, 2025 at 11:57:19AM +0530, K Prateek Nayak wrote:
> Hello Greg,
> 
> On 10/15/2025 11:44 AM, Greg Kroah-Hartman wrote:
> >> Greg, Sasha,
> >>
> >> This fix cleanly applies on top of v6.16.y and v6.17.y stable kernels
> >> too when cherry-picked from v6.12.y branch (or with 'git am -3'). Let me
> >> know if you would like me to send a seperate patch for each.
> >>
> >> As mentioned above, the upstream fixes this as a part of larger feature
> >> and we would only like these bits backported. If there are any future
> >> conflicts in this area during backporting, I would be more than happy to
> >> help out resolve them.
> > 
> > Why not just backport all of the mainline changes instead?  As I say a
> > lot, whenever we do these "one off" changes, it's almost always wrong
> > and causes problems over the years going forward as other changes around
> > the same area can not be backported either.
> > 
> > So please, try to just backport the original commits.
> 
> Peter was in favor of backporting just the necessary bits in
> https://lore.kernel.org/all/20250929103836.GK3419281@noisy.programming.kicks-ass.net/
> 
> Backporting the whole of per-task throttle feature is lot more heavy
> handed with the core changes adding:
> 
>  include/linux/sched.h |   5 +
>  kernel/sched/core.c   |   3 +
>  kernel/sched/fair.c   | 451 ++++++++++++++++++++++++------------------
>  kernel/sched/pelt.h   |   4 +-
>  kernel/sched/sched.h  |   7 +-
>  5 files changed, 274 insertions(+), 196 deletions(-)

That's very tiny overall in the scheme of what we take for the stable
trees.

> And a few more fixes that will add to the above before v6.18. I'll defer
> to Peter to decide the best course of action.

We'll defer to the maintainers of the subsystem as to what they want
here.  If they say take this smaller patch, we'll be glad to do so.

thanks,

greg k-h

