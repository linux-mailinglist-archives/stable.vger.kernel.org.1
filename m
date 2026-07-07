Return-Path: <stable+bounces-272414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MNLeCLDoTGqvrwEAu9opvQ
	(envelope-from <stable+bounces-272414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:53:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B971B1DD
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:53:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="zv/22Vjl";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272414-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272414-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18F153093C10
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 11:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D62FB969;
	Tue,  7 Jul 2026 11:48:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E83DDDD1;
	Tue,  7 Jul 2026 11:48:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424913; cv=none; b=R6D4NH5gVQEQDgp4KtpQ6OCv5PiZNS3jBMEZAGHCL1ctuAUdbhejvEnY2fcYBjx/KXzRBzs0QXn/QhVrERN5BpcDn/lf2p9WYeta52/XNqIwftres77GUOtJ+kk3SsSF3nz54VUFY2Aegnc/KT9l/rt+s7dLJS7Gpf7yXmtszU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424913; c=relaxed/simple;
	bh=BgYOaktcMt1nceXY3EpYXd9cB75a4eT5UGpR1GkEhIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+xWrxwV4B2zHfhYuf+UjDAwAw+/zlEgXruUWe36ZaeJvyzPt5bX/gozrP5ZcDKBE9ehLafhuwPogTb8EWbj27mAIiXROvEeiRKQgd4TY1xpU/4kaTNUMKjp1DfCcCZDbptSEQ9nFFjzJaiikmjxCrgPVf+IbiEAUklGVBvO8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zv/22Vjl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792B61F000E9;
	Tue,  7 Jul 2026 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783424911;
	bh=1X4zGBhtOLN0tEuoSAI+g0Byez2/9GsK3c0FH083OHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zv/22VjlaL3tsYIxzyNDQP2bQVXRF3Cj/V54hS2vx3wsnrFFDTulV8c4xF2FAOLlP
	 dsSQWQCCnzt0FJZqWUQUcHXVYkQ9Dk0qGeLz09W7/DlUOEiJe/EfgK0Ei9wW8VbGDE
	 pUlx42K3IIeM4GX7HpyvA2zp4fFJjqeuiy9Sm1as=
Date: Tue, 7 Jul 2026 13:48:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
Message-ID: <2026070707-brigade-petted-5ef2@gregkh>
References: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
 <2026061917-flinch-idealism-898f@gregkh>
 <2026062236-ludicrous-detached-6e20@gregkh>
 <d3d467d3-637c-49fe-8516-8da65cf4261b@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d467d3-637c-49fe-8516-8da65cf4261b@leemhuis.info>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272414-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:sashal@kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,m:alexander.deucher@amd.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:torvalds@linux-foundation.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gregkh:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gitlab.freedesktop.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 710B971B1DD

On Tue, Jul 07, 2026 at 12:19:20PM +0200, Thorsten Leemhuis wrote:
> [CCing a few people]
> 
> On 6/22/26 07:32, Greg KH wrote:
> > On Fri, Jun 19, 2026 at 11:43:41AM +0200, Greg KH wrote:
> >> On Fri, Jun 19, 2026 at 08:04:35AM +0200, Thorsten Leemhuis wrote:
> >>> Hi Stable Team! From the regressions point I think it might be nice to
> >>> pick up the following changes for the next round of stable updates (e.g.
> >>> 7.1.2), as they seem to fix regressions I've seen multiple people report
> >>> with 7.1:
> >>> [...]
> >>> * 12f58a6caad3be ("drm/amd/display: Fix Color Manager (3DLUT, Shaper,
> >>> Blend)") [v7.1-post]
> > 
> > This doesn't apply to 7.1.y, and would need a working backport.
> Just a quick status update twimc:
> 
> I pointed that out in
> https://gitlab.freedesktop.org/drm/amd/-/work_items/5396 , but nothing
> happened from the AMD side afaics. They have much on their plate, I
> fully understand that, I guess it fell through the cracks (maybe this
> mail helps). Thing is: the backport of the revert is quite big, so
> nobody else (including me) did yet dare to submit it themselves.
> 
> So two weeks later the regression caused by e56e3cff2a1bb2
> ("drm/amd/display: Sync dcn42 with DC 3.2.373") [v7.1-rc1] is still
> unfixed in 7.1.y as far as I can see it -- a regression that is known
> since more than two months now, as the revert to fix it (12f58a6caad3be,
> mentioned in the quote above) was submitted already on 2026-04-29, but
> only made it to mainline during the merge window for 7.2 (this is
> another thing that afaics fell through the cracks; sadly I only became
> aware of the regression after 7.1 was out, otherwise I would have made
> noise earlier to get it included in 7.1).

So should 12f58a6caad3be be added to the stable queues?

If so, why was it not marked as such?

thanks,

greg k-h

