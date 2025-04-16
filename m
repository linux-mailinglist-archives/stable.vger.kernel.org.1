Return-Path: <stable+bounces-132846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A010BA8B978
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78BD17E38C
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5261132122;
	Wed, 16 Apr 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="KDw+GqQP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b0iwPAUz"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF374BED;
	Wed, 16 Apr 2025 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807393; cv=none; b=QJ/bXlLSd+GiussWxHJLUiWZfWlns5U73cKW5Y1rv7NnstOawiEUioQe3a8PnDsF77f2623g0jHxf/SAYprjWpukhEXZQdIw+ZHIHAPjZfl1qx8JoGQ+ntigi/721T3LDVXOm86qnKFhMV/Anz8VECPnKaQZn4U6re9TlvjoFBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807393; c=relaxed/simple;
	bh=5cS5FKLiQUfonEA7BY1jtaB4wTSJc1sxxiZdnQ2u6FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMIEa8SZtWgB4+W2ovWEW6mPAPQy/f93mcuGxF5wiGUXnv/6254qByOYHcK0wx5ttV7yOkqN7qnK8AMRtXuMnCFl5c4V+wNy0vh2qFeQPFu703DOhawNJez4fSTXXO5a1LwNSBt6N2PPCta0oiZ5yk2+hNCvpxlOXsEM8lPwmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=KDw+GqQP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b0iwPAUz; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CF2DC2540309;
	Wed, 16 Apr 2025 08:43:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 16 Apr 2025 08:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744807390;
	 x=1744893790; bh=sND9dxGDYJjwCZ3AidctGsxHQXV9jFx3W/ejm+rcp2c=; b=
	KDw+GqQPQAOWCjwghDkpRUb+ME6GuobUutO6xF6E4JZiAJ9MoYcBpmz1JRcrlwGK
	3SR/H158GXNkgagIxctjaMBzI73OAP/EgYKjRWKa/hXM0lOgBBRA7VdWbNzYgRey
	OSQLkxB/9yqN8LGlkg/JMdZiEH9OtcySEKUqjEXSjv4Or2mpZhS6tp1bJ/mis0xa
	IJBgRMZGk2L7NsJo13irUddIxBRcifWqGH6JlUr0bBvA1AYJlc2NPhuIW+qoDr8x
	SgaA46ONQjoOEpVn+IUq0+3XKCnUVaeMbY3tWIc/Ca4fG54eFp8iyuodmdR99Cl6
	G4JmmMrSO2S93DOrK92Tvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744807390; x=1744893790; bh=sND9dxGDYJjwCZ3AidctGsxHQXV9jFx3W/e
	jm+rcp2c=; b=b0iwPAUzu/T9AKxI2CF2HxpIUCaAVcy7ZgPf25aGJbHMx3dnK/Z
	JxdxCUmz+VRd2LgXhWBRBaxIEnEEiIZivBXbqMSYgDccUqBRO0qbZdVCD7AYy2lu
	Hut76IyDkitrZz7r82jyEZGzQuRjpo//DVFy/J9Iwnik4lmtjmOP5QLt5oA4j50v
	D5SA7g1aNYnLrJ6bErYmwUTtgUWZcOEUX9N0WZDElwVsQ5QHdMJ/pBSkh/PFRDsb
	qj6/MGAgW1zb1S00FEkk8Tw7sqcCNA8zAVeqffJasjJVR7UUtc+wkd2deBr2wwXP
	QpEAMuOT86wdlltqy8eb8pLGk2V44GHyhHw==
X-ME-Sender: <xms:3qX_Z4f2py6u5pcPXIfASxBjY7__K9NjTHJOCDw6mWzgBe-knSuGZw>
    <xme:3qX_Z6Nda2Nv1ek2qe7qmSLeoTWzDzEuMrYmi2nRo_mY4f5Xb6b5F2yW6H6eIzTiu
    SKBirQk-DAaSg>
X-ME-Received: <xmr:3qX_Z5ioe27MIGrZc8vCxuej-9Tyc2nVjYjYo6q7Ub8sLN-ZFjwVi1HoJe2naf9zlPkBPSEeMOl2CkfEt7Fv0PkPJQpI1e0I2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeigedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3qX_Z9_EIqUEgaT0lav3-HkgsUM8UwvDKBPdl33ZvZZhjvAuFrodWQ>
    <xmx:3qX_Z0vxhai1VgWAwbCkRBvabkZ8bIm6jqOTTZ2gl77XlRVAnV0JYQ>
    <xmx:3qX_Z0G72xNI_NFP0oGpa7AaAe3UC7JlZ7M-EbjWZjf9qROy8ITkRg>
    <xmx:3qX_ZzOyVE_Fe2_ZLNdJmdmzlsS4C5a6qr4ZaWVnR_PeoudqFH2fDg>
    <xmx:3qX_ZyjmlTbza6EJna-cARrI3ew6UTtsgFqXi7_HYO1bOi8t0Z4TuIYI>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 08:43:08 -0400 (EDT)
Date: Wed, 16 Apr 2025 14:43:06 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2
Message-ID: <Z_-l2q9ZhszFxiqA@mail-itl>
References: <Z_z9EjcKtwHCQcZR@mail-itl>
 <b1f5e997-033c-33ed-5e3b-6fe2632bf718@intel.com>
 <Z_0GYR8jR-5NWZ9K@mail-itl>
 <50da66d0-fe66-0563-4d34-7bd2e25695a4@intel.com>
 <b5d72f51-3cd0-aeca-60af-41a20ad59cd5@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+UmjKULOlGl+gjJK"
Content-Disposition: inline
In-Reply-To: <b5d72f51-3cd0-aeca-60af-41a20ad59cd5@intel.com>


--+UmjKULOlGl+gjJK
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Apr 2025 14:43:06 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2

On Wed, Apr 16, 2025 at 03:09:39PM +0300, Lifshits, Vitaly wrote:
> Can you please also share the output of ethtool -i? I would like to know =
the
> NVM version that you have on your device.

driver: e1000e
version: 6.14.1+
firmware-version: 1.1-4
expansion-rom-version:=20
bus-info: 0000:00:1f.6
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--+UmjKULOlGl+gjJK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmf/pdoACgkQ24/THMrX
1yw3Bwf8Cht0lSoIZG2lnNwekyKZ9qUAcdU0Gn0+VOr00DBnQIoeCoCtkXRys2r2
fIz/Cq6AJKKY5T/odewOsIKpA7sHFnNYEmgiRaQBSQSwoUvlY4lZPp2cOJwQEQ9Z
b4okRyCYI95ALBivSHbll7dUBodlqXAa3gLqyYSwWbUm7Hflf6a2iIDTleGd845S
BEKGRoonXkwdtqvsLcfppdMJxxkyLKgi1RGmRqrHyuXMCxQUCZbZzro2wb+3xGP7
qVHvmn9FOOUQdD8V04HVRwnGdDQRC+awKrOvoMWM1VAkZl/BN/StOpfWvK+CoVsd
KM/Y77xL2pU/Bi4wmZ2iE36YIT4ggA==
=MLCj
-----END PGP SIGNATURE-----

--+UmjKULOlGl+gjJK--

