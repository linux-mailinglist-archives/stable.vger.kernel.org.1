Return-Path: <stable+bounces-134794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE309A9517B
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 833FD7A6401
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F39A26561E;
	Mon, 21 Apr 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="MrbIe4s3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9j+OPzz"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A821019C;
	Mon, 21 Apr 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241560; cv=none; b=hgbaqFoRxfBE5kAnoj21X+yzZ8HbaYNs1xDTAHfFGtHLqNeblUyoZNtIrwL8qjibzGYNBUMrAhpAPsMK9jtIC8lNW13FGdWBZjmipMeCuM7Y6qxBws6atm/mskcfXS0XhA8oJpjGt3N8nQWYhOYgkX6oPPgKEBxqg6aOpTTa/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241560; c=relaxed/simple;
	bh=w5apYLFjiNPWWx/A7WRYrRcClGI+TQfzcfX8S3waGQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOvEdX5VNH/nKQZl+r+BXGpzTDN83AnSdslkSgYoCudQO0j+IwQS1VRarGiu8PoYJtfyI8wRPukihLwOzevL0gGkEj2p1/YENHpeFf2cVuDeGkaMG2jfyuADL0bVJxQR7SKQpzICdjf3EpH2hiA0e6SBi+GR9q2LGUWqNyo1FbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=MrbIe4s3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9j+OPzz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9CA681140247;
	Mon, 21 Apr 2025 09:19:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 21 Apr 2025 09:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745241556;
	 x=1745327956; bh=zVbdfyjXXUzkgsvwIg3jwWbyVaRbh5FQH6V+d4QgSvc=; b=
	MrbIe4s3pdaO7DysJAHQIpmTwPlQv69KKw52uSk0OzmgnV8RuwrGEXUEc7HyhNlV
	8ccAU/EWcSAf1tgIjuGNlqNGUCQSdirl2FJlK3utznREFFZ8xwepZDgePKjaKdPK
	DEG3I+akFUaMepkP2xssYZh6gU+TDZhiMgMd4z18j+No4bK7qC5EGOtSR/PZcNlM
	bxXfKLZeO36BjJ6XGVpAJ4lz6uAGDP1Vvb4Fv81/FiUgrdwiEOE2KDUS2O+TJgIz
	4ZuEd/ESo4JpDKZjfEp5splwh/dSkpP+zEMgFd+chqUbiMsvFx3a9golsyNCmpEx
	zIC0PDUrhP/vIN1/I8O20w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745241556; x=1745327956; bh=zVbdfyjXXUzkgsvwIg3jwWbyVaRbh5FQH6V
	+d4QgSvc=; b=e9j+OPzzFw0c/WfO5vtzydbJNlOm1jp+0KzcfRpTpbM0EFzEy+0
	nbucO3P6Lx4CCupQvtsat7JapPgtzP7cLlB3g7osJwx+GZHNGrJz+K9A46DKYvCl
	DAbOxNVcK8WI7urCxh/tM9SLml9a5XS6TJ0oDN3fJnmHiPv8e8gi+f0eHtkbuP/z
	NjQHQJplVrzdi7I7csrhQ8/L4zWGchXlqG4MRVSyaAum4EwiVZK3Ki/bR1EQAVre
	u0jmPJgo0avxPanY+XBtayNiMU/SsrahDtFXqc59pnTReU95WRlCheHuoMtrvHkh
	SnUDwo1yu1ZOAoqlDJQRMPkc0uhx1yqz8ow==
X-ME-Sender: <xms:1EUGaAOBAhZkwXwzh3HU6Yb_nouafcl3par1ACCb-ylstV0RkebMqA>
    <xme:1EUGaG-8s286vBiyLKywdyhTFoD9BxQ50tw0FjplTw2-0ja9PquDDJM_dA0XrPUW8
    VkQFe2JUEalyg>
X-ME-Received: <xmr:1EUGaHRNh_rI7INPcpx0an_JhVLQFa_I-NdJffOynRT9mEAbtF8FxPD5z6SklnV1EMr9p2ppL6iYwP7s2JZ9sg1teJxDHTWU9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtleeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:1EUGaIueBX-ENHBjt7DTNYlMFF21tNKIdqI7ymi-0PO62W_vIt5P_Q>
    <xmx:1EUGaIcnPRA2UWqw-XFvbNQ-TgSEH4rgzF54qPvD21XpHmxL_rlMow>
    <xmx:1EUGaM26595kmVrL__Q2j41Nsl81BIIucpNDrV44cHhAhAdxlO0ybg>
    <xmx:1EUGaM9IGIgVs5uo11bWgEEsScsDu3HKqbUE3HuLf8quWFa4RxY1mw>
    <xmx:1EUGaORDDeFLL8wGE2OIlC6I4sQImaigSz6YR9KgFP2mgoFhIbLE106L>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 09:19:14 -0400 (EDT)
Date: Mon, 21 Apr 2025 15:19:12 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2
Message-ID: <aAZF0JUKCF0UvfF6@mail-itl>
References: <Z_z9EjcKtwHCQcZR@mail-itl>
 <b1f5e997-033c-33ed-5e3b-6fe2632bf718@intel.com>
 <Z_0GYR8jR-5NWZ9K@mail-itl>
 <50da66d0-fe66-0563-4d34-7bd2e25695a4@intel.com>
 <b5d72f51-3cd0-aeca-60af-41a20ad59cd5@intel.com>
 <Z_-l2q9ZhszFxiqA@mail-itl>
 <d37a7c9e-7b3f-afc2-b010-e9785f39a785@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FtZpEP7ZV9KwPWkb"
Content-Disposition: inline
In-Reply-To: <d37a7c9e-7b3f-afc2-b010-e9785f39a785@intel.com>


--FtZpEP7ZV9KwPWkb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Apr 2025 15:19:12 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2

On Mon, Apr 21, 2025 at 03:44:02PM +0300, Lifshits, Vitaly wrote:
>=20
>=20
> On 4/16/2025 3:43 PM, Marek Marczykowski-G=C3=B3recki wrote:
> > On Wed, Apr 16, 2025 at 03:09:39PM +0300, Lifshits, Vitaly wrote:
> > > Can you please also share the output of ethtool -i? I would like to k=
now the
> > > NVM version that you have on your device.
> >=20
> > driver: e1000e
> > version: 6.14.1+
> > firmware-version: 1.1-4
> > expansion-rom-version:
> > bus-info: 0000:00:1f.6
> > supports-statistics: yes
> > supports-test: yes
> > supports-eeprom-access: yes
> > supports-register-dump: yes
> > supports-priv-flags: yes
> >=20
>=20
> Your firmware version is not the latest, can you check with the board
> manufacturer if there is a BIOS update to your system?

I can check, but still, it's a regression in the Linux driver - old
kernel did work perfectly well on this hw. Maybe new driver tries to use
some feature that is missing (or broken) in the old firmware?

> Also, you mentioned that on another system this issue doesn't reproduce, =
do
> they have the same firmware version?

The other one has also 1.1-4 firmware. And I re-checked, e1000e from
6.14.2 works fine there.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--FtZpEP7ZV9KwPWkb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmgGRdAACgkQ24/THMrX
1yxLeAf8DvKL+foWSoIwDphGGhQZ3unGbl5ca72JDBQ6KcM6JxaNauYhY9mpzz+C
ZESupbqixbb+HLmbIbEQLVlDyfxAW6x6y4sBV+8c3fy8678Z+c2PcHIgiX8YV0a1
Ntrjn9GRZBWi2e6RmJSCHijHtRlfQsjDxSWiwT1WxjuNVROgsLOW9LXPZmXvasnp
UDTqgIhH6jcNFhaQ/pQcoGyZ31vG6pVLeloePXDOlJ35Gb+4Cts6jTeqBxxyF0R8
O1TMVSAYc3G6wlH7o1eSQ4pLeORMY0H8m/kf1dMOLj7osPorfDauk5KLXVm2WWJh
VEKHuDwHUdeCHvG8BvsOAKR9tsuung==
=gE/2
-----END PGP SIGNATURE-----

--FtZpEP7ZV9KwPWkb--

