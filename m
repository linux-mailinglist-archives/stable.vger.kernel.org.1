Return-Path: <stable+bounces-270071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zT/7Fr5TRGqzswoAu9opvQ
	(envelope-from <stable+bounces-270071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 01:39:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9816E8ADE
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 01:39:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=A23ClQJB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270071-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270071-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6142B30102FF
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 23:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035C633A9F8;
	Tue, 30 Jun 2026 23:39:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B460F327C18;
	Tue, 30 Jun 2026 23:39:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862774; cv=none; b=hfCy7BH0JTG34+m7sWBO5hc8a1vIMv5jx3UCdKDCET1Iuq4MBGfU0u58MwRiroHyEClftLnRrGlabu4fo+tp/sl16KvSKKq21VZcaabofyd3nAqrGEExXdn8ornvPj3zjivY4Ph9Eu6fvgljd+plVs89qzAsFcrG7hI/oTR9mPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862774; c=relaxed/simple;
	bh=0G5cbCuFFtTik9VB/m/2l08FRU6Cu2jrZrkrO4k7EtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlpu4kfauBOhJxInMm8lt45JKdO2PhYFtNvH+/P8xFU10T1PfhbOwlMYjOs3Vqs2+rXIL0BBQQKgEG3voTPoKNK2WPPjLwr0adtCc/VSAH99GmXAyQpuBzBPtYwldS7Nsq7mF3zqc3QJqAUbZiwg9uGN6V3ArhOH7HSsLpXA5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A23ClQJB; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id C047220B7166; Tue, 30 Jun 2026 16:39:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C047220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782862772;
	bh=LknY8HuCtBdKybv7MMH3FvdcOBWXhWU7Txkil/1+ADw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A23ClQJBoBSn+1oFyLIz2cV3lCHwR/bTBRPYh1HXVCT0xVh3gdUtbu+kAYbaj2XiX
	 AmDh32UdvZn7C0+7quRoS9iy0OyYUVPnJ3P31dPxowZjenSXOaeciwZ/lvhWIepXtt
	 dHHGK8eTx5qKuwmVY/8usHuadm/pvx8URCNJi190=
Date: Tue, 30 Jun 2026 19:39:32 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	Fedor Pchelkin <pchelkin@ispras.ru>, stable@vger.kernel.org,
	xfs-stable@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lvc-project@linuxtesting.org, linux-xfs@vger.kernel.org,
	Leah Rumancik <leah.rumancik@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
Message-ID: <akRTtCIZZ0IZ0Omc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org>
 <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc>
 <ajFQPY2m2A6ltvTH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajFabPtI8UGfkyix@nidhogg.toxiclabs.cc>
 <CACzhbgS59uCYhjX80__+nPjEx=N8mKUsYyFS1+aRDpMA-b-VXQ@mail.gmail.com>
 <CAOQ4uxgXqmP49FV3b_cKDD_703bRHz0fjm=k=FmNytsPpnKx3g@mail.gmail.com>
 <ajKSytW_sBFJaBTW@nidhogg.toxiclabs.cc>
 <20260625183421.GO6070@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625183421.GO6070@frogsfrogsfrogs>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:cem@kernel.org,m:amir73il@gmail.com,m:sashal@kernel.org,m:pchelkin@ispras.ru,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:linux-xfs@vger.kernel.org,m:leah.rumancik@gmail.com,m:tytso@mit.edu,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270071-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ispras.ru,vger.kernel.org,lists.linux.dev,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org,mit.edu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.microsoft.com:dkim,linux.microsoft.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D9816E8ADE

On Thu, Jun 25, 2026 at 11:34:21AM -0700, Darrick J. Wong wrote:
> On Wed, Jun 17, 2026 at 02:31:01PM +0200, Carlos Maiolino wrote:
> > On Wed, Jun 17, 2026 at 11:19:25AM +0200, Amir Goldstein wrote:
> > > On Tue, Jun 16, 2026 at 7:33 PM Leah Rumancik <leah.rumancik@gmail.com> wrote:
> > > >
> > > > I have changed teams so I no longer work on kernel and I don't believe
> > > > my xfs maintenance work was backfilled ;(
> > > >
> > > > On Tue, Jun 16, 2026 at 7:19 AM Carlos Maiolino <cem@kernel.org> wrote:
> > > > >
> > > > > On Tue, Jun 16, 2026 at 09:31:41AM -0400, Hamza Mahfooz wrote:
> > > > > > Cc: linux-xfs@vger.kernel.org
> > > > > >
> > > > > > On Tue, Jun 16, 2026 at 09:13:45AM +0200, Carlos Maiolino wrote:
> > > > > > > On Mon, Jun 15, 2026 at 03:19:24PM -0400, Hamza Mahfooz wrote:
> > > > > > > > Cc: Carlos Maiolino <cem@kernel.org>
> > > > > > >
> > > > > > > FWIW I don't maintain the stable trees I really don't have time for
> > > > > > > that. Darrick/Leah have been doing a best effort case for that, but
> > > > > > > again, this is mostly a best effort so we shouldn't expect them to be
> > > > > > > looking/picking up every single possible patch suggested for stable.
> > > > > > >
> > > > > >
> > > > > > Now that you mention it, the xfs-stable mailing list seems to be pretty
> > > > > > much dead (i.e. the last time fixes from it were merged into stable was
> > > > > > almost a year ago). I guess no one is really working on it anymore?
> > > > >
> > > > > IIRC Darrick started it, I personally never worked on it, but I didn't
> > > > > follow the evolution there.
> > > 
> > > I think at this point we can officially declare xfs in stable <= 6.6
> > > unmaintained
> > > maybe need to send patches to LTS MAINTAINERS.
> > > 
> > > The best chance in this case to apply the requested fix to 6.6.y is that the
> > > author (Darrick) approves it.
> > 
> > Unfortunately this might be true. But let's wait for Darrick's input
> > please. He's on vacations this week so will be unfair to make any
> > decisions in this matter without his input.
> > Also he has been still poking people to tag patches with LTS versions
> > so even though he might not me dealing with the xfs-stable, he might still
> > be driving work on LTS trees.
> 
> I've really only been doing QA work on 6.12/6.18 LTS.  Ted Tso might
> still be doing the older ones.  Catherine left Oracle last year.

Any idea on potential paths forward for getting this series in
particular into 6.6.y?

> 
> --D

