Return-Path: <stable+bounces-223766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHODJlLDr2mfcAIAu9opvQ
	(envelope-from <stable+bounces-223766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:08:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A03F2461E3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99B6A30530EF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2073D75A4;
	Tue, 10 Mar 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dz0M06b/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23F3D6690
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773126456; cv=none; b=Eykgb3YnE65Ew7KlkSEm35Pl9NvAvfEZ6Zwq3wYRAJ0EFROUxovua2yvomRy7oKHyqd/U7UaO4Iik5wzC4DZou7kM3f7+iQkC1wMRegKUdGw6Kv+2uGpMzjdhqPVOB77FhG1/Y225i+2OLof11XzSIJzSDOGk1OVGxXi8ZEz/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773126456; c=relaxed/simple;
	bh=pNxow5gQLOZW+7zUw+jgxbtuU0UuRym2WzYt9PiePKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq3XiGdAGE+8oL8AVHXS5kX8W8HqbfRgkieCjYEO2i2K4NlkZMoVrOA8FsENIXDGC1WYYB3I0g9bB9TBQqwxwamE1LEeSBmaGJdTUf3et+OrGxesk6u3AVgABjctRc4TIZVDl1IHO4nDsM80GF36QuMvfg2DODoBBRT1L/3Jxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dz0M06b/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53AD5C19423;
	Tue, 10 Mar 2026 07:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773126455;
	bh=pNxow5gQLOZW+7zUw+jgxbtuU0UuRym2WzYt9PiePKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dz0M06b/mVjMN9+JadOj4sBqVIvslCbmr/wZupUowrtCm3OdWzv4ojb7y011qqY7n
	 sOxYa2/kD/Nvbi2yD+gq38T+dp/HqHh5AZvPguRXE68rIli42qfrB0fjMCsESKLed0
	 kKZjT8S8mJycHqwtv7KHe3rcT2LpguB3Fc+1h8EI=
Date: Tue, 10 Mar 2026 08:07:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [5.10.y] "driver core: platform: use bus_type functions" causes
 freeze on shutdown
Message-ID: <2026031014-dimly-unbaked-4f9c@gregkh>
References: <f20634ac-f5e3-4b0e-a91c-d557d0f1aa39@pobox.com>
 <2026030930-iphone-pony-e8ef@gregkh>
 <037126c3-d398-42aa-9883-e9eb74a0ad20@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037126c3-d398-42aa-9883-e9eb74a0ad20@pobox.com>
X-Rspamd-Queue-Id: 0A03F2461E3
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-223766-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 06:34:47PM -0700, Barry K. Nathan wrote:
> On 3/9/26 07:43, Greg Kroah-Hartman wrote:
> > On Mon, Mar 09, 2026 at 07:03:33AM -0700, Barry K. Nathan wrote:
> > > To be very clear, I want to emphasize up front that this is regarding
> > > the *current 5.10.y queue*, and not any 5.10.y release. This does not
> > > affect any currently released 5.10.y kernel.
> > > 
> > > When I apply the current 5.10.y queue on top of 5.10.252, the result
> > > is a kernel that consistently freezes on shutdown, both when running
> > > directly on my Lenovo ThinkPad T14 Gen 1 (Debian 12 bookworm running on
> > > an Intel Core i5-10310U) and when running in a virt-manager VM (I didn't
> > > put much thought into it and just happened to pick a Debian 13 trixie VM
> > > for my testing).
> > > 
> > > (Just once in my testing, there was a visible kernel panic, but there
> > > was also screen corruption, and it looks to me like it might've frozen
> > > up partway through the panic being printed on the screen, so I'm not
> > > sure how useful it would be. I did take a photo so I guess I could
> > > post it up somewhere if it might be useful, or maybe I'll try to type
> > > it in from the photo later today or tomorrow.)
> > > 
> > > I bisected manually, and it turned out to be this patch:
> > > "driver core: platform: use bus_type functions"
> > > (driver-core-platform-use-bus_type-functions.patch)
> > 
> > That patch has been dropped from the queue earlier this morning, so all
> > should be fine.
> > 
> > thanks,
> > 
> > greg k-h
> 
> $ git pull
> Already up to date.
> $ fgrep bus_type queue-5.10/series
> driver-core-platform-use-bus_type-functions.patch
> 
> It doesn't look like the patch has been dropped yet from the
> 5.10.y queue in the stable-queue git repo on kernel.org.
> 
> (At least as of this writing, around 6:30 PM PDT, you can go to
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-5.10
> and see that the patch is still there.)
> 
> 
> By the way, if dropping this patch turns out not to be the correct course
> of action, I think backporting one additional patch will fix it.
> 
> I applied the following patch directly from mainline to test it; it
> applied with an offset but no fuzz. I did some brief testing and it
> seems to fix the problem (no more freezing on shutdown).
> 
> mainline commit 46e85af0cc53f35584e00bb5db7db6893d0e16e5
> driver core: platform: don't oops in platform_shutdown() on unbound devices

Ugh, my fault, I was confusing this with a different patch.  I'll go
drop all of these now, thanks for confirming.

greg k-h

