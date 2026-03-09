Return-Path: <stable+bounces-223674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNYXMmXdrmm/JQIAu9opvQ
	(envelope-from <stable+bounces-223674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:47:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D9423AD27
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 15:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7D5D30692C2
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E223D331B;
	Mon,  9 Mar 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iMrRBMSU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B93D333E
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067432; cv=none; b=pw0BqLLlzc5nZvCg0FfSjh1PLw+IULStM7r2S+gC57Hpr12ga4uuusqQfsrUnfWzaFBx+uCqDrHPzLDoWG/kGpxwHytInKgefU0Z//E9apaWidyi8IkZdSgZpJkVZy/GCBTa2R0wm2jVS7JWWiM9YQoe3eCzd5iGU0COa1N9bUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067432; c=relaxed/simple;
	bh=PaAjEMP/fjM7jk4M/QhmJ/mI9bqZEWN/USdKE1/G/j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4/LIaFD3jDs1ehrG09LZSW4rJy9WC+lJHJHE/ASoVbbMu4K7koCdUPDrYPWfEzmonZKjPUPQrGczeSJ71C59+YlOzXMb1LDg2zsMFhbSLGi5afJovBnLfj7igIyrRdrvzmHqMZtt0WF/ronEnAEtYZ6pJ8zWl4Y1AgXQtt04rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iMrRBMSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A84C4CEF7;
	Mon,  9 Mar 2026 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773067431;
	bh=PaAjEMP/fjM7jk4M/QhmJ/mI9bqZEWN/USdKE1/G/j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iMrRBMSUFHusVIXBBk1eI433wcOISF6HBEdVYuZ5w7XZ1Brs4FFYitRT3uRYfq0pW
	 6yyJY1o9mkTc6MSME4KbbSzwWLazfFEc5ICf5s2QC9JQZ6q+Sw1yAKfbNpbx+itOsm
	 6Ud8WGaly3fRsDSk4KPRhnbBmLzcCUOe5d8UWuxs=
Date: Mon, 9 Mar 2026 15:43:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [5.10.y] "driver core: platform: use bus_type functions" causes
 freeze on shutdown
Message-ID: <2026030930-iphone-pony-e8ef@gregkh>
References: <f20634ac-f5e3-4b0e-a91c-d557d0f1aa39@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f20634ac-f5e3-4b0e-a91c-d557d0f1aa39@pobox.com>
X-Rspamd-Queue-Id: 32D9423AD27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223674-lists,stable=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.098];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 07:03:33AM -0700, Barry K. Nathan wrote:
> To be very clear, I want to emphasize up front that this is regarding
> the *current 5.10.y queue*, and not any 5.10.y release. This does not
> affect any currently released 5.10.y kernel.
> 
> When I apply the current 5.10.y queue on top of 5.10.252, the result
> is a kernel that consistently freezes on shutdown, both when running
> directly on my Lenovo ThinkPad T14 Gen 1 (Debian 12 bookworm running on
> an Intel Core i5-10310U) and when running in a virt-manager VM (I didn't
> put much thought into it and just happened to pick a Debian 13 trixie VM
> for my testing).
> 
> (Just once in my testing, there was a visible kernel panic, but there
> was also screen corruption, and it looks to me like it might've frozen
> up partway through the panic being printed on the screen, so I'm not
> sure how useful it would be. I did take a photo so I guess I could
> post it up somewhere if it might be useful, or maybe I'll try to type
> it in from the photo later today or tomorrow.)
> 
> I bisected manually, and it turned out to be this patch:
> "driver core: platform: use bus_type functions"
> (driver-core-platform-use-bus_type-functions.patch)

That patch has been dropped from the queue earlier this morning, so all
should be fine.

thanks,

greg k-h

