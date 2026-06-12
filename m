Return-Path: <stable+bounces-262918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NCn6GDr+K2qtJAQAu9opvQ
	(envelope-from <stable+bounces-262918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 14:40:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B83679686
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 14:40:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OhPFpNLC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262918-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262918-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13D7A32CDEEB
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6F3DCD99;
	Fri, 12 Jun 2026 12:37:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B63DB652;
	Fri, 12 Jun 2026 12:37:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267863; cv=none; b=GWT64iAIHCj3wkRerWoCWEIHw2Y6sexXRHZ9Pjlu7RkXvk1F1+HqXTmG0+7wadcnSQTXTNMlBBomII0QQ6H64BZokldJm9iQwBQkVpAsD2WUIFdIwsUU5suGt+TV5vSdyste4RQFeFH0BDo7TQOjJ0D8vkzJmeMnFBgKs/2iZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267863; c=relaxed/simple;
	bh=MLaoj618ugGUnLY1sDpNI/JIio/w6trq+CPhGyjXJsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLky6EMLDkqf+iHLhasFwI6zJsQSeRruedjvQebtRHx6mguPz+LSF4cuhsoMFGddnETc+kGQngK9+ULwlhUbTNMDONRFPFR76Tfz/qvpa+nYSaWewToUxhEcqX8VGhMoHCHeHKFXf/8Q8H54qzPCpz/m8rxxZ98CfKE7I9tq/Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhPFpNLC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CEA1F00A3D;
	Fri, 12 Jun 2026 12:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781267862;
	bh=MLaoj618ugGUnLY1sDpNI/JIio/w6trq+CPhGyjXJsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OhPFpNLCMu6p3UVIv+GrZxDel5NM2zrkmRC32ICYU5eowxNFB8RcZVGwyCSZRyLZM
	 /uqWj9kwoBQEiVxC8Ip0zG/nN/arIoRZEw/bEpjw89sgxT8xBoKPhlr/jnYTKxsuq/
	 lKeNMQbw56u7gyR+vkDEA00yjnEBCgpYTc5A+abyyiw64m8i596EIWBI2u2dVQyaV2
	 cbWziNSzRsgaXBTOFTxv5HXBpT7DBAy7NCjsV3EiDlBmX/Q/04E5sjZvvZs5kasdBa
	 bSk/H2PMIT26qFCFyW6ySdgODFgJRVVFjRBO5M81vhnJKz8KLVQilFGSUH7gO7NIeM
	 +Lv0MC4rja6lQ==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id D74E81AC58C5; Fri, 12 Jun 2026 13:37:35 +0100 (BST)
Date: Fri, 12 Jun 2026 13:37:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>, stable@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] spi: uniphier: Fix completion initialization order
 before devm_request_irq()
Message-ID: <aiv9j5CInFE3twZX@sirena.co.uk>
References: <20260611113137.139673-1-hayashi.kunihiko@socionext.com>
 <airBmzYhnxuK_xdh@sirena.co.uk>
 <cd454dac-868d-43b9-9b50-9ba9f3f370a9@socionext.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y/POWcu9qVi0j0d+"
Content-Disposition: inline
In-Reply-To: <cd454dac-868d-43b9-9b50-9ba9f3f370a9@socionext.com>
X-Cookie: Nice guys get sick.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,snu.ac.kr,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-262918-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:hayashi.kunihiko@socionext.com,m:linux-spi@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:stable@vger.kernel.org,m:mhiramat@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sirena.co.uk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86B83679686


--y/POWcu9qVi0j0d+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2026 at 05:17:49PM +0900, Kunihiko Hayashi wrote:
> On 2026/06/11 23:09, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> That seems a bit strange. I applied this patch to v7.0 and linux-next successfully.
> Which tree did you apply to and fail?

It applies to none of spi/for-7.1, spi/for-7.2 nor spi/for-next.

--y/POWcu9qVi0j0d+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmor/YoACgkQJNaLcl1U
h9CSZAf+KZm3kSUqca9u97nHbQlwVjEXYEInZhJlUX0dECsMhLw97D1TU+Cj42+o
z6NIQNWrzvpywu3pRAlOgVSoxaqiusjIx6gD0jAvdM/OaCAdEKJTEJD2qSfqn9h6
++pfqfBtoM0Q+0yfEk/eVnaGFqBmk3977DpPNZkp+L8FkeLhQlKCajr+P5IFu1Bl
ly1uWFl8LSQUw1WJ6TXd/kiC5PMZYAAiewnm3PucfTRIl/21oz80u6KgIF8FO4w/
U9ryt6a1AMS+G1NiHPyI3QAipxLoolDVSq3Y4Gj01SBD9f7UMdWDeEq1XNT+1UPs
i0M07bDkqvtIFZyEI4kraBfL5ynkwg==
=P7CQ
-----END PGP SIGNATURE-----

--y/POWcu9qVi0j0d+--

