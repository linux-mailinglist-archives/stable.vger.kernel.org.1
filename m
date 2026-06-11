Return-Path: <stable+bounces-262730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZMkRFKfBKmpGwQMAu9opvQ
	(envelope-from <stable+bounces-262730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:09:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC386729B8
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:09:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j2QYmsO6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262730-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262730-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A12E319C94E
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 14:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A373EAC9B;
	Thu, 11 Jun 2026 14:09:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243643FF8A3;
	Thu, 11 Jun 2026 14:09:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186975; cv=none; b=iB++aJbo5d67l3GQ0Nyzm45NjbEBNJ9EXk69PCTJ0TbS9j8/vEA1akfI3AYvX/pmPvcIsReqUD5TA03TnoFuVVBXtnDyA18LMeNoBC/rISD4LUzhz3IQT3fBbcaMGwayq0HCwV9XuOntI4hevX2nKM7Np/gCv0I03+1Y3eTuNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186975; c=relaxed/simple;
	bh=8kALzxCILqnsDSi7OPFFkSWPNmnSPH+VmVuXXrYuTw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAlVFVuchoDp73nUK2h43HVRQQuLHFuzxNT5fmf9qkeeeQX/H1cVqX4gdUYR3WzfjoIXLt/OMWOSHLXSM8TNfCF3o86IpEwVn/Eu6ECL6N1RgmjZ9e1QYecvGQDSt+1ROm12p3TV+6QFV0BjFkLFHggKsrfiXBXpgqGNXLPBL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2QYmsO6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A0E1F00893;
	Thu, 11 Jun 2026 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781186974;
	bh=8kALzxCILqnsDSi7OPFFkSWPNmnSPH+VmVuXXrYuTw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j2QYmsO6wI/9HS6mTERq8MJ2UEEhkhsafRuog9gDXd+PUHdPScMk7N5Afh3ALsi+i
	 6An2Pb8fmu777x3aA+ynIOBEPfTwkp+thMtFlV+xOJ/Zn5lsKjPL2T+SxTssZpCvWp
	 YGd4PSqgIsiROAiZRljc4qgXrqor6uDvNYd0d+bsng6tPKeuyxphkL70+4MyAJvTlU
	 YruMzB5wh469SWXSN+PS0JqKnN/q8rBrOBVINFJXCNtjAbEu32OpVcc25gUOHU8t9B
	 ZF2XiOBVtKE2KU+157Ck+jDAYlPycCKcX58Nf7IKkaNYMx21MjFny9ssBBVn8tZNsf
	 ibeLKh97WvHZA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 352681AC56C6; Thu, 11 Jun 2026 15:09:31 +0100 (BST)
Date: Thu, 11 Jun 2026 15:09:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>, stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] spi: uniphier: Fix completion initialization order
 before devm_request_irq()
Message-ID: <airBmzYhnxuK_xdh@sirena.co.uk>
References: <20260611113137.139673-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2KgV7ttlSOAuFoMN"
Content-Disposition: inline
In-Reply-To: <20260611113137.139673-1-hayashi.kunihiko@socionext.com>
X-Cookie: Leave no stone unturned.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,snu.ac.kr,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-262730-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:hayashi.kunihiko@socionext.com,m:linux-spi@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:stable@vger.kernel.org,m:mhiramat@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sirena.co.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CC386729B8


--2KgV7ttlSOAuFoMN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 08:31:37PM +0900, Kunihiko Hayashi wrote:
> The driver calls devm_request_irq() before initializing the completion
> used by the interrupt handler. Because the interrupt may occur immediately
> after devm_request_irq(), the handler may execute before init_completion().

This doesn't apply against current code, please check and resend.

--2KgV7ttlSOAuFoMN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoqwZoACgkQJNaLcl1U
h9D0Jgf/RBZfe+cdXTQ3yCoVQhnlmf/yAUsGSFW8vWNaHhOKevTLgHWYc/u8U4+o
EH+h7ITKfQCJZ1dDNfjqjNVWDzAsp9DKTtr9GtY/PINxxB6F6vJuTNiAyEb7wKOM
ORlcnU795uLloueMNaIF8LictF6DIWoM8czmMT41qh6GoTeWo0j3p9stf/Xu9Cqs
ggKVnP/rmfQYqBoyifm0AHxFQOnSfZU8ILVwSWNzIxXH5Sxyg7j21Vnfmt2vUu+Z
HHIbJXDhOnPXN2IgTFdrC6uGOh6kbHXfk3PKhUISEL+rPbp6Lzax/nxCjxXDR5Rc
4QWkwS8ZVPf5eh3ci/YA1DnjaJu04g==
=pTxp
-----END PGP SIGNATURE-----

--2KgV7ttlSOAuFoMN--

