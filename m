Return-Path: <stable+bounces-136855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2174AA9EF91
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A084D7A555B
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947FD26562B;
	Mon, 28 Apr 2025 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oTFPThzu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043DC169397;
	Mon, 28 Apr 2025 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840719; cv=none; b=ENG6uvNnx5QVO9ZDBQPXMJ24axeLyEMVEBvn4JLYLc/EGIdO7vYdBbo+/vmofMDomA/vJcKySgOOWv0Att4f2Zu9XVE5Z9PzVSpZP4Dyoy07c7HyfniRLrMuUqYtwer58RwMZ2ec7VvMdKTCWDiQBfI4spl6l8APi55n90aMOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840719; c=relaxed/simple;
	bh=+B51OvI6DvV1U6tDzyeEqpELU8eFoE8StNGnU7w3dLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu+06FzBXIloyrjI9wLCF9oWWZZoG32sJM8hyBFuS6FM4M3IZKFxhYO+dIk5YjehFudOSwMv2p246LWgX8fM70gqzWA2EtnM4qpKIoQowgc4qNo5Qxu7dLk6rPmU+EG93g+U9eFO4emHXpR23eNz+5JTlKz1zscVyrcO9E5Wziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oTFPThzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAFFC4CEE4;
	Mon, 28 Apr 2025 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745840717;
	bh=+B51OvI6DvV1U6tDzyeEqpELU8eFoE8StNGnU7w3dLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTFPThzuIAoP3jk6wOcrBd3vnaktCvuTnRKgt81C1uqFaw9t8568vy2UEs0ZW0FTn
	 8ljWIKvShgoAsj0ndGHPglxHxM6r8GmvdCPYAyos1g5ubmnEugaKnAfMCGesSw/I8Q
	 e5DZiCgpEs7loFPZQ9W/lpdhvVAPPWywIcA/8cac=
Date: Mon, 28 Apr 2025 13:45:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: "Alan J. Wylie" <alan@wylie.me.uk>, Jamal Hadi Salim <jhs@mojatatu.com>,
	regressions@lists.linux.dev, Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <2025042831-professor-crazy-ad07@gregkh>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
 <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
 <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>

On Tue, Apr 22, 2025 at 07:20:24PM +0200, Holger Hoffstätte wrote:
> (cc: Greg KH)
> 
> On 2025-04-22 18:51, Alan J. Wylie wrote:
> > On Mon, 21 Apr 2025 21:09:27 +0100
> > "Alan J. Wylie" <alan@wylie.me.uk> wrote:
> > 
> > > On Mon, 21 Apr 2025 21:47:44 +0200
> > > Holger Hoffstätte <holger@applied-asynchrony.com> wrote:
> > > 
> > > > > I'm afraid that didn't help. Same panic.
> > > > 
> > > > Bummer :-(
> > > > 
> > > > Might be something else missing then - so for now the only other
> > > > thing I'd suggest is to revert the removal of the qlen check in
> > > > fq_codel.
> > > 
> > > Like this?
> > > 
> > > $ git diff  sch_fq_codel.c
> > > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > > index 6c9029f71e88..4fdf317b82ec 100644
> > > --- a/net/sched/sch_fq_codel.c
> > > +++ b/net/sched/sch_fq_codel.c
> > > @@ -316,7 +316,7 @@ static struct sk_buff *fq_codel_dequeue(struct
> > > Qdisc *sch) qdisc_bstats_update(sch, skb);
> > >          flow->deficit -= qdisc_pkt_len(skb);
> > > -       if (q->cstats.drop_count) {
> > > +       if (q->cstats.drop_count && sch->q.qlen) {
> > >                  qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
> > >                                            q->cstats.drop_len);
> > >                  q->cstats.drop_count = 0;
> > > $
> > > 
> > 
> > It's been about 21 hours and no crash yet. I had an excellent day down
> > a cave, so there's not been as much Internet traffic as usual, but
> > there's a good chance the above patch as at least worked around, if not
> > fixed the issue.
> 
> Thought so .. \o/
> 
> I guess now the question is what to do about it. IIUC the fix series [1]
> addressed some kind of UAF problem, but obviously was not applied
> correctly or is missing follow-ups. It's also a bit mysterious why
> adding the HTB patch didn't work.
> 
> Maybe Cong Wang can advise what to do here?
> 
> So unless someone else has any ideas: Greg, please revert:
> 
> 6.14.y/a57fe60ef4cf96bfbb6b58397ec28bdb5a5c6b31
> ("codel: remove sch->q.qlen check before qdisc_tree_reduce_backlog()")
> 
> and probably from 6.12 as well.

Why only those 2 branches?  What about all others, and mainline?

Can someone send me a patch series that does the right thing here?
After reading this thread I'm confused as to what is needed to be done.

thanks,

greg k-h

