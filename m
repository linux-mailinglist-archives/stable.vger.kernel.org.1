Return-Path: <stable+bounces-268151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ECldFc7IO2pcdAgAu9opvQ
	(envelope-from <stable+bounces-268151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 14:08:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5CB6BDFC8
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 14:08:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=OVkmIq0O;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268151-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268151-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9BF631751E1
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0503AB47E;
	Wed, 24 Jun 2026 11:58:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5973A9856;
	Wed, 24 Jun 2026 11:58:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302333; cv=none; b=NeN6lJcMj7WLrwoopltHWR+Db9ccywLZRAtThH6gw7NoJnJQISflINYW4VVIgcH6ViwoV+j7tQCyvyKdnDi1eeOJjI2jnAbbpcyHNndqqEfrWK/xtBVl3J2GvRyd7uYGyaZQnjrHfyr/AqWHh+BUY+TeGtioG6w7gIWXxsIRZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302333; c=relaxed/simple;
	bh=Afjq53kjtlJtWaM/iynRMo2B4fa28T0aOwWngmX1NHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjImPJBzYB2lwQEmNq29bdjF7tqWTvwyjN+invQ/eabMwKC2gfH9zavtC6o5cmb8VbG0xmijY4loEKDuPstUkSWmjTC9mzkfgQNHlGXIzZm2cqEdCa6saaPbSvVFBRx/SZOYox570fc1pD1WHN22UZyiMBE8DurMCnZUeUIax98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVkmIq0O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878791F000E9;
	Wed, 24 Jun 2026 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782302332;
	bh=FgVZL5yjF1lvBvWnuYIQDHGkjIANCmjkiCOImFrhE0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVkmIq0OgK6ozwJCfT96eLni0mKCGIOEblshJgP+XC8zElVQukV9PL5Zcs8jmJu7H
	 RdkUPdtbaGyeJ7zBcpjJgdp+JuCXxAR5qR+keD/JN1D4Id1jimMRVIPGyDMDMbRwcC
	 thmOVSiHyW/aYwTUw42x1b7jk+MuJmQUJmBj4fEw=
Date: Wed, 24 Jun 2026 12:57:41 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>, stable@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>, Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH 5.10] netfilter: nf_log: validate MAC header was set
 before dumping it
Message-ID: <2026062417-icky-dissuade-7379@gregkh>
References: <20260624140117.19799-1-alexevgmart@gmail.com>
 <ajvEDFOlP7Bqb-3j@chamomile>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajvEDFOlP7Bqb-3j@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-268151-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:alexevgmart@gmail.com,m:stable@vger.kernel.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:davem@davemloft.net,m:kuznet@ms2.inr.ac.ru,m:yoshfuji@linux-ipv6.org,m:kuba@kernel.org,m:kaber@trash.net,m:netfilter-devel@vger.kernel,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,netfilter.org,strlen.de,davemloft.net,ms2.inr.ac.ru,linux-ipv6.org,kernel.org,trash.net,vger.kernel,asu.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:mid,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA5CB6BDFC8

On Wed, Jun 24, 2026 at 01:48:28PM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> Thanks but why only 5.10?

It's already in the following releases:
	5.15.210 6.1.176 6.6.143 6.12.94 6.18.36 7.0.13 7.1

so 5.10.y seems like the only one missing it at the moment.

thanks,

greg k-h

