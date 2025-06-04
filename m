Return-Path: <stable+bounces-151424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBBCACE02D
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201B43A70F2
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA4628F935;
	Wed,  4 Jun 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Q4ErSjeW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0j+LQ7c"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42426ACC;
	Wed,  4 Jun 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749046943; cv=none; b=FB23tD793sTAGpyDAFhZY1bc+XVQlba5hBdbv8LA5LiLjFOXmMyk3wOWaf9Nu6iVUIxNTUpPZq03ANtuLhPsY5/0faidPS1oUyZ9d+FgZnKSKwXOb//bii4DuyDbHe7IJpRXJRYc9GC+Ga/YundbxMjmTd2L9vJK2uXdlJV7fhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749046943; c=relaxed/simple;
	bh=21q2Hgnh+ETCIq892NOXpcaeeVs0BPFo0vdeaSX1P5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OejlejE0E1el9O0MmAo2lihyxB1ImO/I6+ZUgFdSalsUDG1/6Tu8xFo9EweDbSk8eMNNoabmhKqeh8sf4zGtt9kmQfebkGbJ7OiDHCZAmsBWO+6OpedxxLsLllFTgCUnyNSzSJbCYsAe67EVmyT250AZDBOGbFkyTQfRKYOClKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Q4ErSjeW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0j+LQ7c; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 417A21140237;
	Wed,  4 Jun 2025 10:22:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Jun 2025 10:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749046940;
	 x=1749133340; bh=l9qTL6VyDfkoyc94nfz6CdcDFNs7QiHmBUzDCEMHvgE=; b=
	Q4ErSjeW4VOznKj0N+l3iczNlcBj+NXKv2ttSNWavCZIq8sDZ9aSXq6qnKzCuMsG
	K5In3r//KTUnq7X3M4aNES5WcC+p1RdR16RNz8VHhbvFYGcxnnODJGsc6p/D7OCs
	cky8j3l8OKDIkYrT4eiKkaYXYRWgm5/wOCGEYGA93nmrED45BFUKl+TeZIvmUHDx
	4r22XvBct4APiCGsoXjbFtSN+xZfCOz5tnKcN0m6gR1NvPlilC1MqyXdYE9Uqp+4
	ZfWkw0JiMdovs2aE4Mn3pQ3xKcQR8J63AhorWedPjEsZ/ZnX9qQMCOemxn1VyoUZ
	UrOQ9TirfiFKwq0Z/x/elg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749046940; x=1749133340; bh=l9qTL6VyDfkoyc94nfz6CdcDFNs7QiHmBUz
	DCEMHvgE=; b=D0j+LQ7cOJA1nQG4pbbCqsU+8T60bcyhWBSItXL5xkQ2AScoRup
	D6g4gDmau1B431JqpfNxV3xt57U4JDhFpjfZ+nhowCNxV4g4f/rJ+htSU9nXGg3o
	74J+lhyCe1zhavHk5HjkbV2NtYsXrLddg1LY6oYfM0d5FzrpEgbNxLawWBpNF7B9
	J2asq5O3u4rMDl4ayVWbUvR1Or1mSbYOuDfy403SsoLyDEwcaPtx3oUM/bWPZdeF
	u+Glkou7WcVwQHq6SKjdRXVkE7ZXYEkq8mBzvqvbs6VEMAd94p393OhV+ckBkhne
	fVinQQncbTo5iuwokYLteKc5APqImwNbZzg==
X-ME-Sender: <xms:m1ZAaPw6UWuK9hpeyxebyC6A52423UjSdibmiQKlGTFVdUVfMejm0w>
    <xme:m1ZAaHSh2tywL0-gFkcmuHcEBkbc70T-H7K4mJybqLp1XTy1rjeOh1Nve0O9AN7YL
    u8P6zxXU0V6XA>
X-ME-Received: <xmr:m1ZAaJVOddxB3gO064bczIBpuj1OQ_vGKB4MPRikzRCKr0eQhzkg0jpWVpOm4iHKKpNjmQ1bfcgDd0QY8H3VcaLdHBTph-YOq6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtjeen
    ucfhrhhomhepofgrrhgvkhcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomh
    grrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggft
    rfgrthhtvghrnheptdetvdfhkedutedvleffgeeutdektefhtefhfffhfeetgefhieegle
    dvtddtkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrrhhmrghrvghksehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnh
    gspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhoghgv
    rhdrphgruhestghithhrihigrdgtohhmpdhrtghpthhtohepjhhgrhhoshhssehsuhhsvg
    drtghomhdprhgtphhtthhopeigvghnqdguvghvvghlsehlihhsthhsrdigvghnphhrohhj
    vggtthdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjrghsohhnrdgrnhgurhihuhhksegrmhgurdgt
    ohhmpdhrtghpthhtohepjhifsehnuhgtlhgvrghrfhgrlhhlohhuthdrnhgvthdprhgtph
    htthhopehsshhtrggsvghllhhinhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopeho
    lhgvkhhsrghnughrpghthihshhgthhgvnhhkohesvghprghmrdgtohhmpdhrtghpthhtoh
    epshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m1ZAaJi_yy7OaaEYivfAL-FTDb0mEe_8_itFv7hYF8TfdadF9Da2xQ>
    <xmx:m1ZAaBDoRqc-amRoTlDHMh_luKJYVdJJq8m2ZY10fIqFT5830IZaLQ>
    <xmx:m1ZAaCLLVT38noOg_E7NdYhKtNB50na0NfVage2tJKiaOL-_4fAA7Q>
    <xmx:m1ZAaACb_WNon-eBBvWPrABlBSzf3x4PwdbrF_dWVL47s0fa_Ugsug>
    <xmx:nFZAaP2ldpj4cJl3_ertUruqbAmMgG4SV2TvOG0W_agpxzhVp9iSGrxX>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 10:22:18 -0400 (EDT)
Date: Wed, 4 Jun 2025 16:22:16 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, jason.andryuk@amd.com,
	John <jw@nuclearfallout.net>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] xen/x86: fix initial memory balloon target
Message-ID: <aEBWmAoDSaNpsrvQ@mail-itl>
References: <20250514080427.28129-1-roger.pau@citrix.com>
 <aCWtZNxfhazmmj_S@mail-itl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rjdcZPeLS3c+Qw6Y"
Content-Disposition: inline
In-Reply-To: <aCWtZNxfhazmmj_S@mail-itl>


--rjdcZPeLS3c+Qw6Y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 4 Jun 2025 16:22:16 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Roger Pau Monne <roger.pau@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org, jason.andryuk@amd.com,
	John <jw@nuclearfallout.net>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] xen/x86: fix initial memory balloon target

On Thu, May 15, 2025 at 11:01:24AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Wed, May 14, 2025 at 10:04:26AM +0200, Roger Pau Monne wrote:
> > When adding extra memory regions as ballooned pages also adjust the bal=
loon
> > target, otherwise when the balloon driver is started it will populate
> > memory to match the target value and consume all the extra memory regio=
ns
> > added.
> >=20
> > This made the usage of the Xen `dom0_mem=3D,max:` command line paramete=
r for
> > dom0 not work as expected, as the target won't be adjusted and when the
> > balloon is started it will populate memory straight to the 'max:' value.
> > It would equally affect domUs that have memory !=3D maxmem.
> >=20
> > Kernels built with CONFIG_XEN_UNPOPULATED_ALLOC are not affected, becau=
se
> > the extra memory regions are consumed by the unpopulated allocation dri=
ver,
> > and then balloon_add_regions() becomes a no-op.
> >=20
> > Reported-by: John <jw@nuclearfallout.net>
> > Fixes: 87af633689ce ('x86/xen: fix balloon target initialization for PV=
H dom0')
> > Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>=20
> Tested-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingslab.c=
om>

I think this wants Cc: stable, since the commit named in Fixes: got
backported too. Or is the Fixes tag enough?

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--rjdcZPeLS3c+Qw6Y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmhAVpgACgkQ24/THMrX
1yxTXAf/f2m+HJfB41dbfKE54f3JNUqW0V87ci8kZTbhmd1/JxZFU+o1phpKn9Dd
PW4Dd2qzBqcu7h+rlG6C3q9Y6ugtR17qU3eTWA3OCNmBgwK34ga3oJ6bJ5Fbvkyv
//B71ZXIXTv3KxjQgRUH6v3n1WNNqLjkFQBtHqjlC/1K8NCierXgiQK25ysueo/K
yybT8woevQgoZm1E6VINtDYo6c8sbtGE+RorVX8Q4DeSn3AutWRG/AFL/yw1RF7U
QAgZq297ZSLAyHFVtNiGoWY5zELHTVb9EW/ajvPE0jPnuOjEgGw+Mwg2SnAmHejb
rgokQ7UTD84BW7b58MHEMK0W190lRA==
=Birs
-----END PGP SIGNATURE-----

--rjdcZPeLS3c+Qw6Y--

