Return-Path: <stable+bounces-132635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA286A885C9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7E4D188E50C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE2296D3D;
	Mon, 14 Apr 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="UEvAevRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ft8asqhg"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9F296D1C;
	Mon, 14 Apr 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640845; cv=none; b=sPFJPHMI8abPtVxeXOBt80ptXnmPz2zOre5q9ncuGGG473V9pX4aqgfdhGePbWqnEhTPjbNNizhfXt7H/VR8PZZFZD7Z74vXW5Y+yameJiaUSrXTWjBa12zhK8GI9TGvWQdQZRYnh0o6xjmxADHSiNXJcnd7raF5SZ3D9XZc7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640845; c=relaxed/simple;
	bh=7HUhjmwcPNmFHFopEOLG3LYIR4w1KoVGOZxGdF8k7C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMFqM7ZEPZ5n+AeO9W3ZEkixkWCnO5/B9ZOqo27BySBxNzL45YyRBBhv8nYAMOSuDKP1d8GcGaQspENxWMYqsSLZvf1kyMyqkF5uMdUkUU5079D4eyWfIn2Sdp/FTMSVXD9ifTAWYUOkbSR7CZ+Tf8sTaTBFw28y20aTXnZytjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=UEvAevRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ft8asqhg; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B218A2540092;
	Mon, 14 Apr 2025 10:27:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 14 Apr 2025 10:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744640842;
	 x=1744727242; bh=FGczV9RNjMQmfxd5ITnC2B5H9+mipmvnLLOBr0rYbCM=; b=
	UEvAevRoNXvAlB6qUjAuZfSlFYe2Ibhl4BhFljf1+2Nm4Ha3jEVpBG2uSY+vnrt7
	iba8gjnrbVNXWYOXsEsh3LyvkltxP1U3b4f20X/j65dN4D9DOqtwPOW+3L2h/o7/
	QsHJpdjDr9qSkVo8+AI30nqkLr2c08tp1/6Cei2QUOIHzsAAdi7JmmWdHIS3v4ff
	G0bMMITqPF13ZlfO84m14/OV1hX3kPC7RUy4H0vcmo5/i3KkYBSFPrDi784NHIjD
	FLI6OvytE+Veiq4CDcFh1LdhvNOydXphG3kfDnthXrzMqoebz+kjMuMQ0St5vrtb
	ksK99U+bsQ7O+nHFFrOIeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744640842; x=1744727242; bh=FGczV9RNjMQmfxd5ITnC2B5H9+mipmvnLLO
	Br0rYbCM=; b=Ft8asqhgNZHMhjVRK6nSuhT1hEzeVjLo80WQTha3IeT1kv1nqdY
	8RK8d9bqGlD2t4mgyo5/xzjKUeJ8DDqUtmIhoN+ArcuQBZlG8io+5OocvXmotAlj
	ABfcc6gmwi+GnwkPBhDG5TvWO6CVXewTvGjXcWFAxkYh5urzB7epEt5gbMpXAuw3
	M0WO4heXjoMmMKZrcuxbaShyja3bhECRElcpftxygfjeDqeLnCuUIHbHNJjJoref
	iHgesMXHQfn7kHEDDDrK7hKJpxKiaXJxG/dbwGQETwImXKUmsa0nnHGmXQraPcj+
	q7Cp2qNannKUWBSKOrBVURgdGP13ydiu/LA==
X-ME-Sender: <xms:Shv9Z-HDHvZB7J3iBDdUSQ-ZH4y0ki1OipAAXf4o5xFAnQRcefx5mA>
    <xme:Shv9Z_Wod2hOamRjVzLqxeUd5gvVdrTm5wTZPZA6wxi9CDX9rgxkMkOZTD71r6-q1
    XjdvOk36Pwptw>
X-ME-Received: <xmr:Shv9Z4Jm-ytIC-oRHDGWRfSpk24IcOPqJQ7e9gLNPjaBmIhoB1WXkAXSWYvp9YOxucJDY8EHeKn3AihIoqcofxDQ23eRbGbt8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtjeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:Shv9Z4Hd3hjCGEhxqSrTN-ZRylr_4bd5M6TKcw8eAUwC8tpq5lTtfg>
    <xmx:Shv9Z0X6FR_S9SvvzCR2Xzd1BJr2or9LUQkBPICM2Bu8lUUEIqVb5w>
    <xmx:Shv9Z7MpuAl91ymTARkmz2H49ltLoE1-Ye4UIzEBipuYQF3qIxzdbQ>
    <xmx:Shv9Z70kgrarP4T3-kbgzpcQCe_Bh-5Vb2O450Rc19EB47Wgo46_RQ>
    <xmx:Shv9Z2IenmIynaODyFpXHB4RWhJU5kVtpLZgV5kntx7VeHSUKVGeTTaF>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 10:27:20 -0400 (EDT)
Date: Mon, 14 Apr 2025 16:27:18 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] e1000e heavy packet loss on Meteor Lake - 6.14.2
Message-ID: <Z_0bRoXicYoDN8Yf@mail-itl>
References: <Z_z9EjcKtwHCQcZR@mail-itl>
 <b1f5e997-033c-33ed-5e3b-6fe2632bf718@intel.com>
 <Z_0GYR8jR-5NWZ9K@mail-itl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rTRxnz3WOg1FQi+e"
Content-Disposition: inline
In-Reply-To: <Z_0GYR8jR-5NWZ9K@mail-itl>


--rTRxnz3WOg1FQi+e
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Apr 2025 16:27:18 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] e1000e heavy packet loss on Meteor Lake - 6.14.2

On Mon, Apr 14, 2025 at 02:58:09PM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Mon, Apr 14, 2025 at 03:38:39PM +0300, Lifshits, Vitaly wrote:
> > Do you see the high packet loss without the virtualization?
>=20
> I can't check that easily right now, will try later.

Tried now, the same issue is without any virtualization too.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--rTRxnz3WOg1FQi+e
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmf9G0YACgkQ24/THMrX
1yweRgf/aORxxg52KTbf5Wzyo3+4I32anJhuAiYfyvBI6iVxylb/WPaUmJpWgEyg
AbIRZ1AH+VEQBrEkp8MnHwzohTVJoujvoNxtYm3cXcyimvdTlF8Kxs0pbPJRvqYp
UJoJnJfssPcA5/SMOaggYVAbRl6YWm8V3MC+PNWyyc6p9Pk8sU7RBM/0MQZ2ev8V
G1m24gH9ZrEwKZRhJnGdPz/eUNEYzFBd2lfodkRt0rw/suep/JhzxJNm5mfcn/WC
mVZfU8/j8sJxO58tFRjIZ7Cw24W1TVorM2c8MC6NDYMbKSmn2q1odXEs9PYeRO0W
viBB/84x4D82qNVmbDS1Q96Qw93B7g==
=M5lp
-----END PGP SIGNATURE-----

--rTRxnz3WOg1FQi+e--

