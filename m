Return-Path: <stable+bounces-223016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HcBFn33p2mtmwAAu9opvQ
	(envelope-from <stable+bounces-223016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:12:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B683B1FD57D
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CDAA30A7864
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 09:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EDB3932CD;
	Wed,  4 Mar 2026 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmP6/1L0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600A3914E2;
	Wed,  4 Mar 2026 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615094; cv=none; b=Y56jMLPi7eQ+Qslz/0ryfs8qB6IyNf/n9CAMW8XQk30UQTjtzGaTc2/xzZAadX9B5frTPofhfvGT3k5j6SmZwhuZYkMW8EvlfRCONfq9JPCgV3cxwtUdRq7UqYa++wW2Y+nyNX3KDg+EvUE61VKwEjJ7lUJMnwkXPTHK8i65VYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615094; c=relaxed/simple;
	bh=ukOc8PHdyC8DprhOgO1EX4dM+TohPShnMlbDurYsU7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INRAvVtKH0hgCBgZuaUuqUnCwp/wChHl1IbA6V6aPERKIXoddcVbuqMCIbN4o6TcIm26fwqzBpnGD8AZmMmG2w174jauNaD1eDbu155P6UyAAeJi67245pcvMwC9+sl84jfa24BrEdn3AxHIce2gV7fKjtTJaeS+E3Hi+o7v7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AmP6/1L0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B117AC2BC87;
	Wed,  4 Mar 2026 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772615094;
	bh=ukOc8PHdyC8DprhOgO1EX4dM+TohPShnMlbDurYsU7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmP6/1L0G23XyukhqZeOPWnfT1GpLgZhdnOgkQZNhgPzvTJLwxgwpzQPOAgBqdszK
	 kjx+ht1DPc7tfeTF4EoeOOkdDrw8QxUp1Eoo75uvEulVuFyJ4FJ9xZY5nspg9P0R0y
	 eSsk6TVGN7cb3+O8BVGk0uFWaJXZ8+YqMoV7be2Y=
Date: Wed, 4 Mar 2026 10:04:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH 6.18 315/641] netfilter: nft_set_rbtree: validate open
 interval overlap
Message-ID: <2026030457-shivering-crucial-a99e@gregkh>
References: <20260225012348.915798704@linuxfoundation.org>
 <20260225012356.353371017@linuxfoundation.org>
 <aaeEd8UqYQ33Af7_@chamomile>
 <69b9d4a7-166d-4f7e-9787-e1b96775ee19@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b9d4a7-166d-4f7e-9787-e1b96775ee19@leemhuis.info>
X-Rspamd-Queue-Id: B683B1FD57D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223016-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 08:29:16AM +0100, Thorsten Leemhuis wrote:
> On 3/4/26 02:01, Pablo Neira Ayuso wrote:
> > 
> > Would it be possible to revert this patch in -stable 6.18?
> > 
> > There is a bug in userspace nftables 1.1.6 that gets amplified by this
> > patch, resulting in rejecting large interval sets with -stable 6.18.
> 
> Sasha, I wonder if it might be worth the risk squeezing this revert into
> 6.18.16 and 6.19.6, as there are various reports coming in about the
> regression that Pablo mentioned:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=221152
> https://bugzilla.kernel.org/show_bug.cgi?id=221158
> https://lore.kernel.org/all/9d110d860c0c7e110d018ea53a7666eba275da20.camel@gmail.com/
> https://lore.kernel.org/all/2a780701-f1e4-4ff4-b796-889f7ee19ead@crc.id.au/
> 
> I think I saw a at least two more.

Let's wait for the next cycle, this one is "big enough" as is, I can do
a "quick" release with just a revert here for this if needed in a few
days.

thanks,

greg k-h

