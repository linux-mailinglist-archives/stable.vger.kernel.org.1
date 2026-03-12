Return-Path: <stable+bounces-224852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DldOWGssmkjOwAAu9opvQ
	(envelope-from <stable+bounces-224852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:06:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4E2716B7
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 13:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E26730F8354
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554D287263;
	Thu, 12 Mar 2026 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTJ8b+aw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC474347FFE;
	Thu, 12 Mar 2026 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317192; cv=none; b=nnpfkGq1BbVOZQV56pt7rEqY4Qh/gp3cBrMWegdlgz7Wm0pdL4ETJTM+GmUPbJGPaqPnlas1cAItHnqEQC2UtAm/kSPJ4ih7/qBgu+QYmURD8TpzrFE0PP0+QJC3vr8YlRPtm6P2L4E5HHb9KW8jxBv/DHEBSLmaDkK1UgduEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317192; c=relaxed/simple;
	bh=3WMCEBRrJ9bVQ6bhFXEYZNYaBW87IPtg+ssv8B/O5C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1NwfNkuPur6VDFH/9H2U4bDKKsbRcjbNNLrr6wCU/fF0eMVnoXqz1NtKMnzuGc7sqZ+L6cmXNcpkyAfZU85l2IKKZvpqCkIgqoacsD0UO0/DS5i9/c8j26iYQC67HqmPEwMzHftZYtrkZvcgxuuXcSUL+1andV5OiUnK3y+PxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTJ8b+aw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6BAEC4CEF7;
	Thu, 12 Mar 2026 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773317192;
	bh=3WMCEBRrJ9bVQ6bhFXEYZNYaBW87IPtg+ssv8B/O5C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BTJ8b+awhmjiKQzgk3DuVdINIroZ9DgSKPU5qA9NM9icbrK0PlmUQb/jtnolYD+Py
	 mOahFrnCLmd8BYlXeIsfnTESHRskqaXkIlGwUjGa5MhVJXBmj3tbxjrZu4ccYYmwKA
	 5idInJtVvbzRjO/593Ape67PUYZYNH3CBCrBfGQ07eX1n7l2orfS8xYeQ4hnBPxJff
	 eTjgRLA68xliyqlDwZHEkXKo9yTU1kgBos0Y48mMuhyGC9DDdtv/7H8CEm1UXCpMev
	 EqADBtxgeG6BdiWSnMMNFUWV/FcBgWn6CkPI/2mlqY/1/6JJ8LPiXyF80MUP/GNNyT
	 Dc8lArr1iflCw==
Date: Thu, 12 Mar 2026 12:06:28 +0000
From: Mark Brown <broonie@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chenyuan Yang <chenyuan0y@gmail.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: sma1307: fix double free of devm_kzalloc() memory
Message-ID: <4e7e5bfb-2497-4b6e-91b2-871d2c4eee92@sirena.org.uk>
References: <20260312084749.365325-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HxrAaCQ1eEAaU8O9"
Content-Disposition: inline
In-Reply-To: <20260312084749.365325-1-lgs201920130244@gmail.com>
X-Cookie: I feel better about world problems now!
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[irondevice.com,gmail.com,perex.cz,suse.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-224852-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 7BA4E2716B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--HxrAaCQ1eEAaU8O9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 04:47:49PM +0800, Guangshuo Li wrote:
> A previous change added NULL checks and cleanup for allocation
> failures in sma1307_setting_loaded().
>=20
> However, the cleanup for mode_set entries is wrong. Those entries are
> allocated with devm_kzalloc(), so they are device-managed resources and
> must not be freed with kfree(). Manually freeing them in the error path
> can lead to a double free when devres later releases the same memory.
>=20
> Drop the manual kfree() loop and let devres handle the cleanup.

You're right that we shouldn't be using kfree() here, however the
settings can be reloaded via the userpace visible reset control the
driver has so removing the free entirely will leake the mode strings.
We need a devm_kfree() here I think.

--HxrAaCQ1eEAaU8O9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmyrEMACgkQJNaLcl1U
h9BX8gf/f64I6uopAZ+xWPMPEVbRj38U6V82naSPtJfz40UDUihJXQntng5e4MAB
SHYfQ9If2HJnyINol9LlK6ceA9rEqyryCUBL3DLWt/ju7qinIAkf1jRG3kevl3Es
9v5/6M6QxTLsycbNOxvpRVOc2wJJQv3F4lM55nKYdQG67lIwN3rDRwIZN6njnchV
uujJ8YA3ZhalndJbriz6M/Wvyj3EO+yFVn81aUjFz8EmvoKMA0aFw0Yq5p+G3EhZ
uVxJvbqHxn17C2q5UOrneoqe8lveq0/0k8JETXjVPvdlx+LFQGZm1du3+5mec0X8
kRj3HfpN6pkjYP5UBu0PyxAFxs1oaQ==
=sYoI
-----END PGP SIGNATURE-----

--HxrAaCQ1eEAaU8O9--

