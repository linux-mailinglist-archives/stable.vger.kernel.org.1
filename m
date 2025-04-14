Return-Path: <stable+bounces-132528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C85AA882E9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AB6164C24
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83E2D4B53;
	Mon, 14 Apr 2025 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="J9UCMz5C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VsF2XSoZ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2F296D25;
	Mon, 14 Apr 2025 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637342; cv=none; b=L0n/02mzwdSJJvZPZ3qXtDCUhhzWyJbfvx3LyzJAtz5DMJkzFj8E1Voi2VEqu9nFZohubHk9lx4O/jrBp+vhsIUz56W5A6qJmc+CZmH/ErAYBgWFlOLHxSpQEUa/N1FCIxwaqIWFi2OsPKhcbCZiitmHw6oLBqoiKEbwRXE9tAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637342; c=relaxed/simple;
	bh=w+GaCOk0unonkO298r/VvlKxdoXSTagPlOGL8b+c4pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4DsU0TLBOgbqSDJyhoYHvBvoqi7+BrJQM/JarNERWhaqQ3FbuT9W8SZxNkAAAVxi+nljDMiEtb+u5nCIAK6m1IeUAtR96nzT+rsyBmeXjDhzhmJk9CEwvpI+3AqzA5eJxkmdSF1w2X9rWHt8kJ2Rv4d/HgycqAxyoKD1mYBchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=J9UCMz5C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VsF2XSoZ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 797D72540329;
	Mon, 14 Apr 2025 09:28:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 14 Apr 2025 09:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744637339;
	 x=1744723739; bh=iMO9IccfCm2xvSWEFUJlubmfDh1c2iU+/IvUT7403yc=; b=
	J9UCMz5Ci/JXc2kD5UMu7YzqaxsTMyjl6YcPNGo4zkLwlg72sb6Znubb4OOYgr9F
	LW3OQI6++RNwHFWZjJvOAJvOUKoHj5lq9z7I1ru9xPX5a13ir8RQP3iSJy4/KeJ3
	c3Y7dxgjIWb0zrrsQf6YOfmpEA9IG/EjQvGvnNOHemSlaufNjTSXoam1Xp2Ncc46
	quAFqH3NPhFSjg6Rwhsdq4d+oRrnWR8+BgKsxaui5MGUGyju2p/rFHVXoYCKM2xC
	G0rJXk1hUrfZjGZerZlvtBrWuDSMKPLheX6i2+K+qkjT1D7xEWOsgleZOnaWjb/q
	7SuFHhJpnq4A4h4TcVXGaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744637339; x=1744723739; bh=iMO9IccfCm2xvSWEFUJlubmfDh1c2iU+/Iv
	UT7403yc=; b=VsF2XSoZvg+Fvp5WmnhCdfMmDw/+gqKQxfg5pNWOIyJi8ph5tvV
	Raw+fXzYWPJ2aJ5NOTpvMvhhOrTtGMy900o40Apqe/naae/u/4oMqL3PJwod+Kui
	w1knbc10IWj95mfYA3VycRivJ6BtSqynV4B+0upwk6j79qGn4Y5vA+3R0llLoZ33
	+r8ErlMADjqULs0P9Pzw9B61G581fidI/MH9Fr9POSr1njzZO21FBJtvrtgA8gtc
	8PPHehIrL475SGX2w2NCGha9tCpYvDKDnDkM+NWFC9t9k135QXnK6sBZ+r3c25PG
	2IqjngAc92qeNYQLvwPIgJ8HQuHpWFBtDog==
X-ME-Sender: <xms:mg39Z6MO2uCp0gPH6tNK2EulZ3-WKc4wVrDOE1tewMT6SPRQCSnPDA>
    <xme:mg39Z4_JOMYHM42kmKKE5-WkTFGasCoMFbqBzeJ0RmptqzraSq2Guw7gaoKUJzAzJ
    decGJTNhFsMPA>
X-ME-Received: <xmr:mg39ZxSkeDTyuzKz_HqtNGVtjNP0K9UWHbEXIK-7Qn5QqNQiYbMGhyQ9_M9LdT570peAE_eRcw-T32ih2s6teSFqC9IvtsO8Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddt
    jeenucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuc
    eomhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecu
    ggftrfgrthhtvghrnhepgfduleetfeevhfefheeiteeliefhjefhleduveetteekveettd
    dvgeeuteefjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
    dpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvhhi
    thgrlhihrdhlihhfshhhihhtshesihhnthgvlhdrtghomhdprhgtphhtthhopehjvghssh
    gvrdgsrhgrnhguvggsuhhrghesihhnthgvlhdrtghomhdprhgtphhtthhopegrnhhthhho
    nhihrdhlrdhnghhuhigvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehinhhtvghlqdifihhrvggu
    qdhlrghnsehlihhsthhsrdhoshhuohhslhdrohhrghdprhgtphhtthhopehrvghgrhgvsh
    hsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrshhhrghlsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:mg39Z6tAG5q_-mlN7TbVkEKknpZDzoH-FH1TfLkoAo_sGOMEnYA-0w>
    <xmx:mg39Zyfvmz1sVnPqkWaxWLP7aezRpvNvHDkwoah6fsBuRa6uaAKEtQ>
    <xmx:mg39Z-15HB_I08LrNCQSPUSSHFHWa2sRowet8gXQxWyzwyklTgo9Og>
    <xmx:mg39Z29pxDP62hoQfrq-pErrAo3uOVL0Jh6m9Wg3DmnfcPlZujxFmw>
    <xmx:mw39Z4T_dWr6aU2pDmSsaOokywZ5Op15EXF5ZCggmlMoh-IzJ01dpaRp>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 09:28:57 -0400 (EDT)
Date: Mon, 14 Apr 2025 15:28:54 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] e1000e heavy packet loss on Meteor Lake - 6.14.2
Message-ID: <Z_0Nl1yD4n__oWiO@mail-itl>
References: <Z_z9EjcKtwHCQcZR@mail-itl>
 <b1f5e997-033c-33ed-5e3b-6fe2632bf718@intel.com>
 <Z_0GYR8jR-5NWZ9K@mail-itl>
 <50da66d0-fe66-0563-4d34-7bd2e25695a4@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IB2IGAFxKW/DJnLD"
Content-Disposition: inline
In-Reply-To: <50da66d0-fe66-0563-4d34-7bd2e25695a4@intel.com>


--IB2IGAFxKW/DJnLD
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Apr 2025 15:28:54 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] e1000e heavy packet loss on Meteor Lake - 6.14.2

On Mon, Apr 14, 2025 at 04:04:51PM +0300, Lifshits, Vitaly wrote:
> Do you have mei modules running? Can you try if disabling them make things
> better?

I do, disabling them (via module_blacklist=3Dmei) doesn't help.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--IB2IGAFxKW/DJnLD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmf9DZcACgkQ24/THMrX
1yyNbwf+ORoBWsb6q5Fjli64YiXuY/22Zvq/ugiuZv9CrpfLnRxkgLbkxdb9h2wv
n/YiAPxVIi/Prn8ihpS3UiMCLv9jEfMVIY8STpWr+O+gutyIaU0g43ZUECxpbyRW
cZWssO2ylXx2n83BzOEpJDFVcgZhWLQu/qjERf4Ub9BtQT6WsfkdoZ3muSK3TyuA
hTNDMAVcOa70nGwg6J9ksV3WrEHRHoD96HRwgS3IRmH8SRf2yvCQm4OWyUJqTE2A
XUzY2g1JQeWMdELJoxfFi6WlqWbIeCxXc2heLSC+NfQOAxCBmhVDK9b37Wj/Gwkk
0+SUrOc9A7ImL6/4SQivifiZRz1S0g==
=OV6S
-----END PGP SIGNATURE-----

--IB2IGAFxKW/DJnLD--

