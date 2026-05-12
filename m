Return-Path: <stable+bounces-245421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAeVL07eAmoMyQEAu9opvQ
	(envelope-from <stable+bounces-245421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:01:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724751C530
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74F26301486F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0FA481FC7;
	Tue, 12 May 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="d+G5n2OH"
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6F481AAC
	for <stable@vger.kernel.org>; Tue, 12 May 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572869; cv=none; b=sYMJ7vNd2zU7zMIuNX6R16eKP3XqVCJpn956R1tXinRJC40aS08xginnXAoBhpdykCAN0Mkyfehc/GjthN7Xl5LMAM4I3vOFVhL3/Ls1eFJotOjnRaWR9nHVxUnEftHvLVBCxs8FEKNvCswOglq38vyhGnzqth/4+JhFz7eLNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572869; c=relaxed/simple;
	bh=qwD/LSzoVz9lumpYwkztMi44QOqXs806ipkZ++I9kUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj7qFzOB/lNDux7XClw8Da4E81t76hJ3TdaxnZTZuI/Q3HAV1BwoGfZqu+Dw0pKcBSWipEDiM4Ntcq7tnGHfxAVozbfAwPvDJPT5men7BhdQPKtSfkQN1ha+h/q8lHCAdwM8NWzxDLTsXmou6DB36ka5CkIDhXFIn+zo9sBpuL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=d+G5n2OH; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0B5610A112;
	Tue, 12 May 2026 10:00:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1778572858;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=g+Zpf94C06g6DHzAxc3e8gDQbhna4u8G4j+iQusXqrI=;
	b=d+G5n2OHHVulgWYFrVkVx5olQnM3hfkHEVJpvxhcZecOQ2V5JR/og+tL5MU/dY7O5i7dTn
	CvPFZKuXlXetbh8h2GTjwT2Z/pKVxVYKF2/iVvrsnRk6er7BXRJ8V7HLaRfsOFf75JX73M
	qAspFQKNIxnwoMjxRLvGNYHq8E2LCwyL4K/Kci84jPse3K+JsqJHzB0LWsxbKgzNWibiI2
	T2Ly/M3oCOL2Y/L10k//XpPrQRgLxtra74s+P2Yg3KyJW4mTuv5XhCmM49VT+C2ywbqulb
	BWBVFnranMpWI+vWcIkVkauu0/0EY29aeaTEaW/m8+ZIMmidz9f0m8a7KP07IQ==
Date: Tue, 12 May 2026 10:00:48 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba, pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Message-ID: <agLeMIrCfFVypBav@duo.ucw.cz>
References: <20260511135357.2786242-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GN9Z98QuV/CIH4vB"
Content-Disposition: inline
In-Reply-To: <20260511135357.2786242-1-bigeasy@linutronix.de>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8724751C530
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-245421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[pavel.nabladev.com:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavel@nabladev.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nabladev.com:email,nabladev.com:dkim]
X-Rspamd-Action: no action


--GN9Z98QuV/CIH4vB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is a backport of ARM related fixes. This applies cleanly to v6.18
> and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> not apply cleanly.
>=20
> #1 and #2 are prerequisites for #3.

People often use stable-dep-of: header for that.

> Can't tell the origin of #3 (fix hash_name() fault). It might be there
> since the begin of time.
>=20
> #4 (fix branch predictor hardening) fixes commit f5fe12b1eaee2 ("ARM:
> spectre-v2: harden user aborts in kernel space") which is v4.20-rc2.
>=20
> If there are no objections I would post the v6.6 version once this is
> accepted and then rebase the PREEMPT_RT bits on top of this.

I don't see anything obviously wrong with the series.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
								Pavel

--GN9Z98QuV/CIH4vB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCagLeMAAKCRAw5/Bqldv6
8k4YAJ9h+PIe12p8Y5G7mPqKrlzzi6zhpwCdHbIPkY4dhb3ey2X1jYYYNCqOguo=
=B6hv
-----END PGP SIGNATURE-----

--GN9Z98QuV/CIH4vB--

