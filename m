Return-Path: <stable+bounces-259590-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMO8IWmjHWrmcgkAu9opvQ
	(envelope-from <stable+bounces-259590-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 17:21:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD452621943
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ACAC30221FD
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 15:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6C63D967D;
	Mon,  1 Jun 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i4hSbOjw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C53D890B;
	Mon,  1 Jun 2026 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326808; cv=none; b=ZGk3vX6opDNbnhKvRar21H8reeBYqzkp6kGZlJWLYPL1eh8iJDhgO/YsPDuyOxhC8+ndqLsLUbjAtZP6G8J8Fua9UbcUaNuJ+w/O00kz83MyHpaiW7rxJWOxB6tthIdYXAcJ4yY2IAtXj0ghc7uxqeelTxWzcnkmtUtLVI/I3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326808; c=relaxed/simple;
	bh=TD6ua6GJtuPKCTXaI1zduZWc/XJ7Gl2TnyWLBYxxQRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGfrM5IgyPGx/j2lmYqtWXOxBux0Qusw+uUiaarf1XzZEcxMT/Eepv9a9pE59xWN3XDVRG/OW62p0ZkRjLpNHrnkyvt2VLC1v/3ibevH289NnzX62xY8OcKPCbieymNgXplljp4uzb5P2ZMB1KFE6pnZiAsqywdkpRPDGTG1Igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i4hSbOjw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3680D1F00893;
	Mon,  1 Jun 2026 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780326807;
	bh=PbHIkTitXA6BGzmAPIRc4mMQco5WVW7XUxuczu1PXBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i4hSbOjw04knOXzCYWFlCPDfvc0XvAWn5dW1VjvRiCNPQjKSET4J+SyvgefuihB4A
	 lU+eEv27qbEZUYVhJ51KI/gFOX7rLuJN9VGzP3p10JlF6IkERZETQZdCD2SDlOjp7X
	 qKLs+CfycvFef06iyprBgWXr44nzpXF7AvyUgino=
Date: Mon, 1 Jun 2026 17:12:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Angel4005 <ooara1337@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ron Economos <re@w6rz.net>,
	"Pavel Machek (CIP)" <pavel@nabladev.com>,
	Brett A C Sheffield <bacs@librecast.net>,
	Mark Brown <broonie@kernel.org>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Vijayendra Suman <vijayendra.suman@oracle.com>,
	Ben Hutchings <ben@decadent.org.uk>,
	"Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [PATCH 5.10 072/589] media: uvcvideo: Use heuristic to find
 stream entity
Message-ID: <2026060104-customs-naturist-7a58@gregkh>
References: <20260530160224.570625122@linuxfoundation.org>
 <20260530160226.496219768@linuxfoundation.org>
 <5e2ac444-451c-4220-8013-0e6382b5f165@pobox.com>
 <136f03aa6f51bdfecc786e5278f5fd03b4a6966e.camel@decadent.org.uk>
 <20260601015021.rc-uvcvideo-heuristic@kernel.org>
 <CANiDSCvh6u6AWnarEtso=zKPD3upEsaJBMOm1x35fHyPMaEMyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCvh6u6AWnarEtso=zKPD3upEsaJBMOm1x35fHyPMaEMyw@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259590-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,w6rz.net,nabladev.com,librecast.net,googlemail.com,toradex.com,linuxfoundation.org,nvidia.com,broadcom.com,oracle.com,decadent.org.uk,pobox.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DD452621943
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 08:41:14AM +0200, Ricardo Ribalda wrote:
> Hi Sasha
> 
> On Mon, 1 Jun 2026 at 04:11, Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Sun, 2026-05-31 at 12:53 +0200, Ben Hutchings wrote:
> > > This doesn't properly fix the problem.  Commit 3d9f32e02c2e "media:
> > > uvcvideo: Create an ID namespace for streaming output terminals" (which
> > > reverts this) needs to be applied on top.
> >
> > Rather than carry the heuristic and then layer the namespace rework on top
> > in 5.10 only, I've dropped this together with its regression source
> > 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id
> > UVC_INVALID_ENTITY_ID") from the 5.10 queue. That mirrors what 3d9f32e02c2e
> > does upstream (it reverts the heuristic), and avoids exposing the
> > 0e2ee70291e6 regression that would otherwise enter 5.10 in the same batch.
> 
> Are you going to apply:
> 
> Commit 3d9f32e02c2e "media: uvcvideo: Create an ID namespace for
> streaming output terminals"
> ?

It wasn't planned on.

> We need either that patch or this one: media: uvcvideo: Use heuristic
> to find stream entity

What id is that?

thanks,

greg k-h

