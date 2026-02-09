Return-Path: <stable+bounces-215513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBAIB2QAimluFQAAu9opvQ
	(envelope-from <stable+bounces-215513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:42:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D5F112084
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6220301440C
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56AE37AA71;
	Mon,  9 Feb 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu3bRu43"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E34186A;
	Mon,  9 Feb 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651703; cv=none; b=WFl3xgwFnMROqW0P7saKz4idO3G231Qob+QOOYu3SmvH+fy0DRNPbw6yEaYGqJm6N+93UULifLAUAuZYVaeXI+oOkm+KvDA8VP6pc3KE1J5QHQ6pc7qlIFIYKaek9rsspIzCs8Spnb/Tcm/+KhbqpFjXUpcvIUbcpRxeAsnZkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651703; c=relaxed/simple;
	bh=P6UtJcHG3Nr16veWeeHgLqTHEzXULZqBZqhPiGa/4JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibvBC5SSo36ogUNJBduiGN+4Q1Ly4oGccwqfJghh6a7lVF15d1LrPmhRyNgDpmC6UmO++5n6Tqa7RvgbiSClBtg2s2VaCHc6s//uzRWgkBZCXvDXBMOfe1n3oyuvACT9OCcL1YjQv+dLexGmzvsYUUIRpss0d6R7Re+EnhRwpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu3bRu43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0932DC116C6;
	Mon,  9 Feb 2026 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770651703;
	bh=P6UtJcHG3Nr16veWeeHgLqTHEzXULZqBZqhPiGa/4JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uu3bRu43hPcGKWR2WOPsK+rXA4fY/Pq9E82iZ9furXASLwdRSckq5gLAfvfd3cKTE
	 pgw/cIcNMiIKCJ5Izsyw2T45kJpVes3GtibukxvLgKwU/xTa6lNXbBFFt5sOYT58xZ
	 U1r84f7v1mMDxf3+GP0fJt0SeSunk2qQ16Ew5vbU1bVsb7LMMnffNwrY7HkZOpV5c4
	 9J4W4sVLPlWYGlsLnxx/pfl2fsxReN680o3FA0SEIk3xCWTOGyCcBrKjvRK/CD0mxo
	 aRBf6FFmgE1M/DksxxfZQuO2XAc5co/lBfq0X+mvKD9FIc1FQqgDDI3CP+6cS0Wa1d
	 ySjLqTHaLHtlQ==
Date: Mon, 9 Feb 2026 15:41:38 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: Re: [PATCH net-next] net: arcnet: com20020-pci: fix support for
 2.5Mbit cards
Message-ID: <aYoAMrEVDNydXQdq@horms.kernel.org>
References: <20260205065113.33547-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205065113.33547-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215513-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80D5F112084
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 10:51:12PM -0800, Ethan Nelson-Moore wrote:
> Commit 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
> converted the com20020-pci driver to use a card info structure instead
> of a single flag mask in driver_data. However, it failed to take into
> account that in the original code, driver_data of 0 indicates a card
> with no special flags, not a card that should not have any card info
> structure. This introduced a null pointer dereference when cards with
> no flags were probed.
> 
> Commit bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in
> com20020pci_probe()") then papered over this issue by rejecting cards
> with no driver_data instead of resolving the problem at its source.
> 
> Revert the incorrect fix and fix the original issue by introducing a
> new card info structure for 2.5Mbit cards that does not set any flags.
> 
> Fixes: 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
> Fixes: bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

I do wonder if this should be targeted at net rather than net-next.
But at any rate, looking over the cited commits, the change looks good to
me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

