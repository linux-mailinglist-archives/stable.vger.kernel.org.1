Return-Path: <stable+bounces-134795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ECDA951A8
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC5D1891844
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12009265CCC;
	Mon, 21 Apr 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="BBCtm0r2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsHkOrr1"
X-Original-To: stable@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14055264A8E;
	Mon, 21 Apr 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745242099; cv=none; b=G4qYppFdTsKhAY30corqFKUgIT4esONsDmWMH24SbyLmQj7cTmuLJwAKSA3D945M+C1zseQYTuUY7Fg2Qk1b9Mktt989ch86U+jDGgW6JstS6aNNSb5cohTYuR78mOF/778BkYIr+MW0uu4ue0w9vukvMJGE4o1HDADi91fTZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745242099; c=relaxed/simple;
	bh=UW4KfkqVjMFvjVYxl8fSH0s9vr14x9srzxS09ro5CHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYWK6FyUyzufAwcE2/Ju84YF4bf8P1TH7UhzSKGj6lP7tkqf5Kc0OGQBH3qgRcymW0Gd9Fq7NwRl6lEDYg79D9QCcMQT5vwZdMn7ACn8/UN5uU7kUXzN/z3qIxlvLuQHyLzQKELtbV0nFuTCEBq0ShDMj7AmMK2YlohgmN6cejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=BBCtm0r2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IsHkOrr1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2EF6913801E1;
	Mon, 21 Apr 2025 09:28:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Apr 2025 09:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745242097;
	 x=1745328497; bh=0qVkw3Shy50bKVumUVEOY0hrPGUdQGC9Px7ESgUdwPI=; b=
	BBCtm0r21NtdT/wx7sN6S5nvF196m6MHLg778hwYFYxru1XxmE9GRjwCR32vfYRQ
	rsBT6hwdRFwrDZILrlmO0o8/fLc1j1A+FG4rWW8mQBSrICcTmBUxbJpWa7Wh0zDf
	DCmbESiUWqvJHXBPryXEEU+GXKjX2obVEsjTU2xoAaK4yrl3RHus+Y86Lbcpdp63
	1A46dnrM5RZAn+tWN3g0EWNvzpQy2d155f44gr2NVP7h/lxsIcpdF6BJvaAgXDHR
	oclUqTX5C+Mxwrh6zk4m1GHrlPbkmaTa94yUyLr1LQU1zaJwUR5t/FQ1OZBVLnv1
	60HBXlgyIc7rraxGpEuTug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1745242097; x=1745328497; bh=0qVkw3Shy50bKVumUVEOY0hrPGUdQGC9Px7
	ESgUdwPI=; b=IsHkOrr1D9U44QgLYMugomS5SZH2D/6JiOmoUSK7JAslfQ3I9Fs
	cbfBjJjADNpu/ec/96xTVHwCtZ62/EUAiiM9aLA9vG/i3B3KVT/X6t9aD1TnfmSe
	EfxGqd+Q4dhXXbkNbpULorYiqNLrC2vdd2TX8K5acxE67hQKPsnkpvHMNff9P8IV
	iszTUGWzUjwlnhz5AaWZU9wwkqXk7o6u2XHpjdCtjrbrbR0pb3hp8pEdnBuBOcCG
	kyuocuHiLTX8yKsQhecLyVwVoUnr8w9v58wljoFmrvCRY0ZWdVJwVvaHQQgH4cSj
	YrnPLPLOgunEOLT5hl10AaT9mCYe0CeIXWg==
X-ME-Sender: <xms:8EcGaA0nCNkqsGCB3-A5JGrfK6zazK-dAkfTWJIRLWAu3jjK-P40xA>
    <xme:8EcGaLFqgEksz8DbdJkEi6aA3FY2cJnhB7OJKqWYLpFKyo7MjhnrVbrkKCwVLHWnH
    TmIG_Wa6lZeEQ>
X-ME-Received: <xmr:8EcGaI7LFHxmY0cOnK-PUxsH7CZreptB7y_63gMfTC_VJoeNji9d2sUTKi7a3W2Ro1t9lMiUn2fOTRTfGQWm3ui5SNlrCe0Ljg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgedtleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:8EcGaJ2rh5PwY3x0_lr2Ab43gObWDK2UoFCwret-rkg08bf2I00Ksw>
    <xmx:8EcGaDHk8ks_ttZLUUMRGZarUIM1Fxox91PpBtZbUqb0m3_0ey5KOQ>
    <xmx:8EcGaC_LgeuqN_3HAJFOhwcf8x9DXFombyislo9_SfGgpb-tTGyFBQ>
    <xmx:8EcGaIlOwWa2FZYzEMxrYp0Z65b3x0Q0CLRI7jffDIZpQzAXIMmtZQ>
    <xmx:8UcGaM4lhdbQpb3Ng1Ox1ioxy2jfwtF3pm7lAz8N1PTTqoYOTWc-qptw>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Apr 2025 09:28:15 -0400 (EDT)
Date: Mon, 21 Apr 2025 15:28:13 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2
Message-ID: <aAZH7fpaGf7hvX6T@mail-itl>
References: <Z_z9EjcKtwHCQcZR@mail-itl>
 <b1f5e997-033c-33ed-5e3b-6fe2632bf718@intel.com>
 <Z_0GYR8jR-5NWZ9K@mail-itl>
 <50da66d0-fe66-0563-4d34-7bd2e25695a4@intel.com>
 <b5d72f51-3cd0-aeca-60af-41a20ad59cd5@intel.com>
 <Z_-l2q9ZhszFxiqA@mail-itl>
 <d37a7c9e-7b3f-afc2-b010-e9785f39a785@intel.com>
 <aAZF0JUKCF0UvfF6@mail-itl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="905i3CbqCZm+HHvF"
Content-Disposition: inline
In-Reply-To: <aAZF0JUKCF0UvfF6@mail-itl>


--905i3CbqCZm+HHvF
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Apr 2025 15:28:13 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [Intel-wired-lan] [REGRESSION] e1000e heavy packet loss on
 Meteor Lake - 6.14.2

On Mon, Apr 21, 2025 at 03:19:12PM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Mon, Apr 21, 2025 at 03:44:02PM +0300, Lifshits, Vitaly wrote:
> >=20
> >=20
> > On 4/16/2025 3:43 PM, Marek Marczykowski-G=C3=B3recki wrote:
> > > On Wed, Apr 16, 2025 at 03:09:39PM +0300, Lifshits, Vitaly wrote:
> > > > Can you please also share the output of ethtool -i? I would like to=
 know the
> > > > NVM version that you have on your device.
> > >=20
> > > driver: e1000e
> > > version: 6.14.1+
> > > firmware-version: 1.1-4
> > > expansion-rom-version:
> > > bus-info: 0000:00:1f.6
> > > supports-statistics: yes
> > > supports-test: yes
> > > supports-eeprom-access: yes
> > > supports-register-dump: yes
> > > supports-priv-flags: yes
> > >=20
> >=20
> > Your firmware version is not the latest, can you check with the board
> > manufacturer if there is a BIOS update to your system?
>=20
> I can check, but still, it's a regression in the Linux driver - old
> kernel did work perfectly well on this hw. Maybe new driver tries to use
> some feature that is missing (or broken) in the old firmware?

A little bit of context: I'm maintaining the kernel package for a Qubes
OS distribution. While I can try to update firmware on my test system, I
have no influence on what hardware users will use this kernel, and
which firmware version they will use (and whether all the vendors
provide newer firmware at all). I cannot ship a kernel that is known
to break network on some devices.

> > Also, you mentioned that on another system this issue doesn't reproduce=
, do
> > they have the same firmware version?
>=20
> The other one has also 1.1-4 firmware. And I re-checked, e1000e from
> 6.14.2 works fine there.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--905i3CbqCZm+HHvF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmgGR+0ACgkQ24/THMrX
1yxQZQf/YKyAaZ6uRKoItVe64l4tTEHFhwtsfm1XnV8YQ7kifFzR2nqj01vPZccG
GB5o+uI2XY/q927n+QlEemEM+bAt66etky1bC5noOxyZeLbQdUj32e7gG5pb5Gh5
XaUSK4DVQEL3NLzsfV2DQlEDOHaGOWie4Ya/83ic5TyXxbEcqLWRznvA699akDf4
z9XXTLmDfJrdu1qneGDb6p5tzsqkHHdODr3jAtDh/q6GDBEGlJ2wxYz138RJKfVG
i3R+n9n5UwcfQNK4wUg1NX2678f1oT3aLqABYCCvQGN/iscU8C4msM+yZYlZffQd
S80FnW5zu4unYc34FjocJnc1Yp7ovA==
=VB7y
-----END PGP SIGNATURE-----

--905i3CbqCZm+HHvF--

