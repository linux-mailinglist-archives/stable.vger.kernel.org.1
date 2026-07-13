Return-Path: <stable+bounces-273545-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xli0HjZUVGrZkgMAu9opvQ
	(envelope-from <stable+bounces-273545-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:57:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DB5746D2D
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 04:57:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cG28i22f;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273545-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273545-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C90130041D3
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 02:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A3335202B;
	Mon, 13 Jul 2026 02:57:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8A33F598;
	Mon, 13 Jul 2026 02:57:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783911475; cv=none; b=kdO0dm0ga6ouX1MTSPcbfU5qUNtxriVULXO6Rls71W7yMd6fmUTtHz1WUVJB24eUvPwMxgGIQKymW2kGHJqOpHvd3tH3scp/mMH7vJwffP+VUpNHuDafnwRnB3I7HUWDDIV2MktaV7O+OpeIWpBWqrnHLKa5mC0rQnKnZxVIvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783911475; c=relaxed/simple;
	bh=1j1ktiudgVP+BmyH45G9e/PokfKl4lKPJgW30o5nsno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8twoO98p6MDHOwg3HoFFoi+L/AKUyTz/7DtQblDZHbFkjPJBtBqZ16qDuppqTIQSx3CFKbmbFomUdziIoboIv+8X0nAU7rpjqXRJMxLFye02DF4W9XQ9FbtT40w6kG4KF+tzd8pydmDkOQn0qVO3ay0xeFMKefJEbRdsiopVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG28i22f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E390A1F000E9;
	Mon, 13 Jul 2026 02:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783911474;
	bh=/hRnTUulKPiYornA9CIY0YUDODR0Yv2On60iD5z+Ovw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cG28i22fpIZ9ePz2SOq4tK5Q2IBQh5aMchvOUFHUtm57MLqZkzCUNNxakiFVRMQEy
	 20JdUtNB3Sbbm/QamvF99sFUFy3J7LMocPnufg3Yez4nFaLE39ZoB7UeDy0/QOhPqh
	 a9MITHEmltMmi+Hyba5xGV4yNwt8eaAtrGuAEvYACfCPYqZM7gqHTexbjKyCoMHDsa
	 ZMyCtqlYfr7Xxl37jRRgqwzFPu/wzE9gBJ1K6ID4Jms6xpYZBSQ014GSUP3l3DhdHQ
	 n4teOvJqClQgWLxBmKDJcPwv1/63Mw1+9avBygJe+dgmtKJFKOpIQk0bP0JarAemz3
	 RSx0Z07Rr03WA==
Date: Sun, 12 Jul 2026 22:57:52 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: demiobenour@gmail.com
Cc: Russell King <linux@armlinux.org.uk>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drivers/crypto: Mark QCE as BROKEN
Message-ID: <20260713025752.GF4362@quark>
References: <20260712-qce-broken-v2-1-b2dfff47f7f5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-qce-broken-v2-1-b2dfff47f7f5@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:demiobenour@gmail.com,m:linux@armlinux.org.uk,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-273545-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F3DB5746D2D

On Sun, Jul 12, 2026 at 05:31:31PM -0400, Demi Marie Obenour via B4 Relay wrote:
> From: Demi Marie Obenour <demiobenour@gmail.com>
> 
> This driver is harmful:
> 
> - It is much slower than the CPU [1] [2].
> - It Has a history of bugs [2] [3].
> - It does not have exclusive access to the hardware [4], causing races
>   with the secure world.
> - It register its implementations with too low a cra_priority for them
>   to be actually used [5].
> 
> Therefore, disable it to ensure that nobody builds it into kernels they
> intend to ship.
> 
> In the future, the driver will be used for processing restricted media
> content.  However, the kernel does not currently support this.  Since
> the driver will have future uses, allow building it if COMPILE_TEST is
> enabled.
> 
> [1]: https://lore.kernel.org/r/20250704070322.20692-1-ebiggers@kernel.org/
> [2]: https://lore.kernel.org/r/20250615031807.GA81869@sol/
> [3]: https://lore.kernel.org/r/20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com/
> [4]: https://lore.kernel.org/r/20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com/
> [5]: https://lore.kernel.org/r/20260524204537.GB110177@quark/
> 
> Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
> Signed-off-by: Demi Marie Obenour <demiobenour@gmail.com>

Acked-by: Eric Biggers <ebiggers@kernel.org>

- Eric

