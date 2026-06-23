Return-Path: <stable+bounces-267933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LeOwLNd0OmrW9QcAu9opvQ
	(envelope-from <stable+bounces-267933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:58:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB16B6EBD
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 13:58:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="fW3nk/C9";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267933-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267933-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E391B3041A81
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498023D47C5;
	Tue, 23 Jun 2026 11:56:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C7A3D3CEA
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:56:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215764; cv=none; b=AMbAZisokCxgSki6TsrCqGst56Fm/xdJRxkj+oDFMnGTQD24/Hw9MbaGLa+ng7VSA7hzixwyyP+VYwXnY7bl6Xx5bC5ESQJbubOAYz+8LcgitPaz1NafAlKqCnV3V+wCSZH+fKV6tywvdMdZYkM/YrhYgUzO234q7O5UvThHFCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215764; c=relaxed/simple;
	bh=/5xsWwS2xUnGFCsaWljXVmVzriLYZcgoN6mZ8ww728Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJks1y6mWxvi+N6NZYcTT40FtGRIJ6GcBX/xJLsVwRhgI89Fg9J82vlCuYrwUHF3z1o5UI5POjNdaO6KLc2tK/j/Hl/D/OQTP2Doq21dnmDiR7oTenCyMrNs4rgX2SEALv410OQvQI+UrTuwsAWAJrptOwFAGRU8yHFmcFEMvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fW3nk/C9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192401F000E9;
	Tue, 23 Jun 2026 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782215762;
	bh=YKaY+oipGDQj+pG1rp59NfmK2RnFUAUjoiQxt5RGKfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fW3nk/C93mwqa5jrg0k+b+buCB1TjKEDPnOSWo67Hqzpzzj0Vv966V8FRDuB1Iwd9
	 zxdR0JLIYhb198syd3CkcRGGWgJxvhdtSMooU7CIpQfdHUjSAWHYw3Z3gLvZwmMlUW
	 6e7D19Z2zqyRcwLMj7qwea6NxiLpxA6aqEHc1qUk=
Date: Tue, 23 Jun 2026 13:54:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Pratte <slatoncomputers@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] s2io: only arm hardware LSO for GSO skbs
Message-ID: <2026062345-kilobyte-tubby-4425@gregkh>
References: <20260623112131.752148-1-slatoncomputers@gmail.com>
 <2026062327-unengaged-apostle-5728@gregkh>
 <CAButv0efpYUSmOaqksOs0C6To6n+DQQ7vdQFq-pQWwK6Dfau+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAButv0efpYUSmOaqksOs0C6To6n+DQQ7vdQFq-pQWwK6Dfau+g@mail.gmail.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-267933-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:slatoncomputers@gmail.com,m:stable@vger.kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01EB16B6EBD

On Tue, Jun 23, 2026 at 06:48:18AM -0500, Michael Pratte wrote:
> On Mon, Jun 23, 2026, Greg Kroah-Hartman wrote:
> > Why not just remove the driver in older kernels as well if it is not
> > being used?
> 
> It is being used - Xframe-II (17d5:5832) in a Supermicro X5DA8 on 6.6.
> Please keep it in stable.
> 
> > And if it's not being used, why is this patch needed at all?
> 
> It's used and broken: since v4.2 (51466a7545b7) s2io arms LSO with
> MSS=0 on every non-GSO TCP frame, so the card aborts all TCP TX - links
> fine, UDP/ICMP ok, but no TCP at all. The one-liner restores it.

So what happens when 6.6.y goes end-of-life?  Why is this driver removed
if people are actually using it and willing to fix bugs in it?

I really don't want to take non-upstream patches for obvious reasons.
And for code that has been removed already, that goes doubly so.

thanks,

greg k-h

