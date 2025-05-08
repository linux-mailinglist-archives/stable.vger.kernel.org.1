Return-Path: <stable+bounces-142928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45ADAB0471
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFDA9E42C8
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC128B7D6;
	Thu,  8 May 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Q8FUVZjP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jccUf1CU"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E07288C23;
	Thu,  8 May 2025 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746735521; cv=none; b=Dz/pvIDlVcx6uQBA0NKDneOwEoXvzPFcMOhjTcKmgTvI1mYjF7WJtiLbpVgHrfo6/jpI0RFuHX0JwTupW888CAckP5GDytU8McPv/6zRpbAD+fku+3UzXgKchy0FJUyPdwWcexUrwPPQpeeWtI77OPOUkC9Wfmb5vEhYVv0kVrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746735521; c=relaxed/simple;
	bh=3q4tYuWdlNpGKFA3V7Kif3AxjacEuPH1AKxvZQHHaZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWNv6OV4Y9M2ThCJUy+L3ehyW7s0iyIaI/42Ygqf6R6gL7WadNUAURj2kyiuMnlFr8VVxBq4QvbU5PsC4d2IEit97EKShb8gTIEAHSHlovCgOKFcnIpGiXOJcyeAczPZl3mKUDbXZ3KpyPlsrDcs8Rj+JAr71UaNkL4H5t/lWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Q8FUVZjP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jccUf1CU; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 22AC31140113;
	Thu,  8 May 2025 16:18:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 08 May 2025 16:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746735516;
	 x=1746821916; bh=wZArqTjX+Eurv0Dg2HLUKLKT6iFfH7o4KhILEFsOljQ=; b=
	Q8FUVZjPNpJ/FzRuhxRBClb0f67nvWwOxsgWk464ePTbMUvdbNaWH4bpkwIRcf0Q
	2Rpjwa6xsRndSFNDvGXyx+52WLteIHu5Po+6EQTxQAIqJv5WmqfyzgeTUenRcyy3
	Ln4iq8kXIGfuk6o1kHMrTudvYmN+aiTkh0OxWcn9E+ZNCvvhJRCSCf8QlyVOraFU
	npY7oQYqQAP2Z7NeENfHOFpxL2nd8XgrpYK40cBUNp7lIkeUWFo/ePh2Eoo14cNU
	oMx1PRvstTIlLcrwL3m+kCjRLXRPx5ZDNpHLAgd+gpFJ3XSidPtGNvKF9DX5ipzq
	XM2yCKD0BJqkGrZEAMGenw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746735516; x=1746821916; bh=wZArqTjX+Eurv0Dg2HLUKLKT6iFfH7o4KhI
	LEFsOljQ=; b=jccUf1CUoeM6UEb4wTf0VBNfTcmD4D47LyEkDRUhFUrfq0bgRai
	zDrKS3+pBWUeUOjByBw69gp+4dtbM/IFZhtGT4DDYt9UdiYM8TfzPEj9bNMpHfrS
	kEaKrj/Q4OFiIIjUsR4M6DBwZQhwVVkc6fZIcYRHMpc6jEOFokAnarU/t3EPVvG3
	Trtub5jjvQuJ3Z5PZ0vFcnrkFndviqYPZNWuKBANFFs7Wdh4iLR3SrR2SEzNbuQG
	I0/31CbLO4AaS31I3IRW0E9SYUxZJGWhLr6X/SOT+0e2Ba0wreieC5KCm0f+3zhM
	7O8PNcE5w/dK48uPE9CeiCsfEJqH9Ry36zw==
X-ME-Sender: <xms:nBEdaHnPIlC_bYI96CN1LdHRjW3ChCvJ-xMotF0KVw_BO7oNAWWmtg>
    <xme:nBEdaK0ou96bGd0kKjp7vUviQDMVx1ub-Bj7hbGYJotWi56FsUqCG6aBZbniOgJH6
    G7TbW28flO0QQ>
X-ME-Received: <xmr:nBEdaNoXGHlGyjIVFYTb48xXmXH5CoOnS2X0fgRZQlXAbK6Nzct1sGJWaTzZdK638jqt7CBHtTs2teJxT-zI6UV5hnmy233T6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
    jeenucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuc
    eomhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecu
    ggftrfgrthhtvghrnhepieeluddvkeejueekhfffteegfeeiffefjeejvdeijedvgfejhe
    etuddvkeffudeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjrghsohhnrdgrnhgurhihuhhksegrmhgurd
    gtohhmpdhrtghpthhtohepjhhgrhhoshhssehsuhhsvgdrtghomhdprhgtphhtthhopehs
    shhtrggsvghllhhinhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopeholhgvkhhsrg
    hnughrpghthihshhgthhgvnhhkohesvghprghmrdgtohhmpdhrtghpthhtohepsghorhhi
    shdrohhsthhrohhvshhkhiesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgigvnhdquggvvhgvlhes
    lhhishhtshdrgigvnhhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nBEdaPlvi4KRC4tv4lLTlMV_hqpE_T1IGWug6zNOQPErjCTxSHXkYw>
    <xmx:nBEdaF0nyD9BrSz_XTPP2Aqmxmlv6Rnr2AcvUrcOHXPgF5Cwpg7XhQ>
    <xmx:nBEdaOvsOGzjb0H97LHWtLnLhaAWfsnYZmclG4Sjo-FiYZbZ4gCgDw>
    <xmx:nBEdaJWTWd7y8X--VVeVxZFxXaHUlbrHtbGQT-twwze1620kr36ChQ>
    <xmx:nBEdaJ0OSP63Hruxr1kpsRopqL4z2qSkXOGt0bKjBPskzYvnnbf1tdzI>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 16:18:35 -0400 (EDT)
Date: Thu, 8 May 2025 22:18:32 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	stable@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xenbus: Use kref to track req lifetime
Message-ID: <aB0Rmd1PCxA_7Gch@mail-itl>
References: <20250506210935.5607-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qkJiPgqLCT4AW8qo"
Content-Disposition: inline
In-Reply-To: <20250506210935.5607-1-jason.andryuk@amd.com>


--qkJiPgqLCT4AW8qo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Thu, 8 May 2025 22:18:32 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	stable@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xenbus: Use kref to track req lifetime

On Tue, May 06, 2025 at 05:09:33PM -0400, Jason Andryuk wrote:
> Marek reported seeing a NULL pointer fault in the xenbus_thread
> callstack:
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: e030:__wake_up_common+0x4c/0x180
> Call Trace:
>  <TASK>
>  __wake_up_common_lock+0x82/0xd0
>  process_msg+0x18e/0x2f0
>  xenbus_thread+0x165/0x1c0
>=20
> process_msg+0x18e is req->cb(req).  req->cb is set to xs_wake_up(), a
> thin wrapper around wake_up(), or xenbus_dev_queue_reply().  It seems
> like it was xs_wake_up() in this case.
>=20
> It seems like req may have woken up the xs_wait_for_reply(), which
> kfree()ed the req.  When xenbus_thread resumes, it faults on the zero-ed
> data.
>=20
> Linux Device Drivers 2nd edition states:
> "Normally, a wake_up call can cause an immediate reschedule to happen,
> meaning that other processes might run before wake_up returns."
> ... which would match the behaviour observed.
>=20
> Change to keeping two krefs on each request.  One for the caller, and
> one for xenbus_thread.  Each will kref_put() when finished, and the last
> will free it.
>=20
> This use of kref matches the description in
> Documentation/core-api/kref.rst
>=20
> Link: https://lore.kernel.org/xen-devel/ZO0WrR5J0xuwDIxW@mail-itl/
> Reported-by: "Marek Marczykowski-G=C3=B3recki" <marmarek@invisiblethingsl=
ab.com>
> Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent=
 xenstore accesses")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> Kinda RFC-ish as I don't know if it fixes Marek's issue.  This does seem
> like the correct approach if we are seeing req free()ed out from under
> xenbus_thread.

Thanks for the patch! I don't have easy way to test if it definitely
fixes the issues (due to poor reproduction rate), but it looks very
likely. I did run it through our CI and at least there it didn't crash
(but again, it doesn't happen often).

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--qkJiPgqLCT4AW8qo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmgdEZkACgkQ24/THMrX
1yz5FAgAhQUkBLIS6ba26NE9OtI7whD/OKYYKBosqmstTcpUark0KVM6gkGx/JNN
g7NFpvp/LeozFs+J/Ol27sqhCdUIFoFo4OGL31gR9riNimt2xG7xOfmv09376fjo
3UbYN0R9tXzr56c3jL2y2k1fNi4+K0udX6eYKz8YsLytYvt+TrUGVFAPl2HqC09Y
uMQaRfwGVq53kcfHDO7HAcP9Xi/Igc4ucyZ5fNk9RzlDAFK2VktYF3OcsLT3sZcs
dEkMZA3uAJl+PSCcMmQ7WwmyF06sYllkeGmMQ2dQL/OAWICUCfr7jv24Sh0m7kTx
abAMG7wNfu45kMbQtkK3yehIOllexQ==
=mAy6
-----END PGP SIGNATURE-----

--qkJiPgqLCT4AW8qo--

