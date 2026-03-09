Return-Path: <stable+bounces-223639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC6jFqzGrmn2IgIAu9opvQ
	(envelope-from <stable+bounces-223639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:10:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CD239790
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53A7D3035A43
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C23C2773;
	Mon,  9 Mar 2026 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y4yf9JcQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C73BE167
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061770; cv=none; b=A4NeyJd98ckWJRu2YbynXdyErsrANgzNYJ0TvsTUcRxX06VU5MhRczmvjJr38OOkBg9TZo81M5AiG4BQK9hVvsbxqpSRYFHC5t/pYDeYH1Kph9WxPEgVdCFkOoXy7pOI8toPs3bp56urMU0KW/M/IhdczabRg6RCcqAWJQCqqvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061770; c=relaxed/simple;
	bh=rLZ5SfMw5tuBIj88iEJ3cVvT4yM3ioED2XVf2im3GlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYRwosDfe3djC5OHdr6BSGTwfPpOYKtmewikvJwVpTg0lfALTkqD+GpT8YTtdwXZNibj635wVbbmteiVi8PxVdsSHpKXjO+CphuXx/wJvxqG5ka2jFljVviRJHAWKAgSoDAqFZ+vJ+mfqxzJM4b3ZFmwrDwJOP1seZsOkXwUK2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y4yf9JcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F57C2BC86;
	Mon,  9 Mar 2026 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773061769;
	bh=rLZ5SfMw5tuBIj88iEJ3cVvT4yM3ioED2XVf2im3GlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y4yf9JcQ5RQbnbAYcLhln5qEv04CQGgnvNcrzpz28AbKr27QIArRHNNNmJIhIE4Oc
	 H+hl45JHlSbnLp3SZRWH73yQYbCOxaU145x64th5I/ScIg3c3wxTK0rwqTsX3v2YPY
	 37+uFX65aERuq4k5GLb6ieCaRmG2sVyxPoR4FFvE=
Date: Mon, 9 Mar 2026 14:09:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>, Boris Faure <boris@fau.re>
Subject: Re: please pick up patch for v6.19 soundwire build error
Message-ID: <2026030921-lash-strongbox-87b5@gregkh>
References: <ecf1447f-e450-46e7-b3d6-ab4632907492@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecf1447f-e450-46e7-b3d6-ab4632907492@infradead.org>
X-Rspamd-Queue-Id: DD5CD239790
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223639-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.200];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 01:31:26PM -0700, Randy Dunlap wrote:
> 
> commit bbb758a6943e
> Author: Boris Faure <boris@fau.re>
> Date:   Thu Jan 29 14:14:54 2026 +0000
> 
>     ASoC: sdca: Fix missing regmap dependencies in Kconfig
> 
> 
> for kernel versions 6.19.*
> to fix build errors.
> 
> I applied it to 6.19.6 and it fixed the build errors that I had.

Now queued up, thanks.

greg k-h

