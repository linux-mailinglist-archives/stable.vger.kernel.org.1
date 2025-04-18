Return-Path: <stable+bounces-134516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EF9A92F8B
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 03:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EC460874
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 01:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E60125E806;
	Fri, 18 Apr 2025 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="JhWd1/r5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k/aRwnBE"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2521522A4C5
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941091; cv=none; b=mEP/rmkx1KpBPSjFRR7D67PwHtdI6vnnf6Dj96c6s7Nsv0z6JfOqDrO6iQ/rSgSlpaTbZNCBjpdBvRHQgwDyi1PxT0kWcxtE6Xa/ntEeRqyKClhIYE5F+as03aIX406A5cs/4w3gjDZ3JJv5MeMth60rkcPwobUiCKKMtL9rQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941091; c=relaxed/simple;
	bh=cVK7BY1FBJJ8wbsn4TKGi1QZ4YcjdoU2Eoq0QQv6XzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMKNyotWT7623qPOLBtlBPlGg6jSMUjvPixyZHRsCyCsnjHwXIzfRQQyYymKGRFzpd7zcMH+9QyqrdMpRxVknPGeoNEvMKgktftHCS+gekO9DqG3oXo2didag2OV5od8HQatA39Eta7R3loKI7UywwWm5zLsWhxABqOZTmYjF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=JhWd1/r5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k/aRwnBE; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC5E2254017A;
	Thu, 17 Apr 2025 21:51:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 17 Apr 2025 21:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744941086;
	 x=1745027486; bh=JJ8h3uVYslPtURWXQcJpREr7soM//IWfDMZYYwivCdk=; b=
	JhWd1/r583lrf8Tkp/sgHy65Jn9DKEhihWBMrnswpkvRkfEktlk4cu8E9F11G7vM
	9Id6Zkqd2NxHUNGeLVoIAp+2CU2q7Rrz7EcXWSiiYRogTU8h7VdbojI+nxOoGZoT
	sogNSArCgx0XncDeBjbJV0SrTvmhIdf1ML/wTA5jfclKwVHEzAHkzn1GzF1+IjnP
	flB6uI9WXrtu7aMv+Z6Eo6eS62iEtNbjwQyqU5XIrIDjf/hrxsXc56HVdMsH9/9A
	zb2wuxmzR84y3O7NAMYXy4R5R9YZ73V/Li9nBYHQPNKlb7JA26We2nyjK8Mdftkg
	gJEG9zp52ZYobsYok1sL+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744941086; x=1745027486; bh=JJ8h3uVYslPtURWXQcJpREr7soM//IWfDMZ
	YYwivCdk=; b=k/aRwnBEHBj93hvejiKWgqBMeBpDbA+sgeIgUIpTATf0WKCDR0W
	yNoUeFS1TkhrBtwKBF2I+Qrhh0lRLAP1KPg+JcL03grQ5uQZkQgMqNv/gmrZd9Q5
	ARTjEPJFbk9CkJPN6ctpFrCPoKw299CZOFwS8+WrZoS2/vsq9qrZ7fpkr3hY0G3w
	VHkusQwXb2XTgyvBTMgEzOYYhOC7xkl5hrnHTSZWJhSEEoNhWTjsde3O4iBdmpGj
	XWc64XMd9E22TAz2EuqWlBKfcXi+JRXz/P76nays4o3r8lo8u20PBeS9F23CRxCg
	VeNwV9b2aDJHZtRO81sFKXBRvvYF83+t1UQ==
X-ME-Sender: <xms:HrABaIxkroHT86QBkYQLOBoA-RHr-3-KsbRXvdlsfIr44ndo1uyCNQ>
    <xme:HrABaMSznEYVeb2Fic-fLZD8gQe96Wzk8ezyJxShudlkliDrQtwDohbCX7FxGJaXD
    xXxYT4ni6yphQ>
X-ME-Received: <xmr:HrABaKX6SoK615O3WSeH-VZXKrvxU6j7sTZJl4z-QKj4YcFK_NPnt_KwNCy5En2bV8A1UJFj4Jd7VAJK6zyNE-X-Oxkm81vKjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehgtdorredttdejnecuhfhrohhmpeforghrvghkucforghrtgii
    hihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvhhishhisghlvg
    hthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefffefgieduudeuieel
    keefgffhhefgfeekieelkeejkeduudehudevheeukeduudenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgpdhmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthh
    hinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
    dprhgtphhtthhopehrrghfrggvlhdrjhdrfiihshhotghkihesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehvihhrvghshhdrkhhumhgrrheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:HrABaGhiHEKK30mEVwbBmbdtQ1DYbedVfUGx2rV7ms6BZB2fB50x7Q>
    <xmx:HrABaKAao8r9o8WaIX2XFwejRW77QJDCxgjKTaJ3HqTVsw-a3WfKRw>
    <xmx:HrABaHKyxJ1En78_hD-_OovWfmtwbM5YVikqaptCxUoQrNZoWVKZNA>
    <xmx:HrABaBD4x7Rf_BnUGcgve-_8CAZ7FoM2ynlJn4-yeqCKyncshW_F3w>
    <xmx:HrABaI2zbZ3VF6hayo9hu5txcOPmddpHguoXXSsRyd4Turj7CAfRdTcW>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 21:51:25 -0400 (EDT)
Date: Fri, 18 Apr 2025 03:51:22 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: gregkh@linuxfoundation.org
Cc: rafael.j.wysocki@intel.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org
Subject: Re: FAILED: patch "[PATCH] cpufreq: Reference count policy in
 cpufreq_update_limits()" failed to apply to 6.14-stable tree
Message-ID: <aAGwGlLCCwxqjTJo@mail-itl>
References: <2025041714-stoke-unripe-5956@gregkh>
 <aAGUKHsF2epjlNqG@mail-itl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LRee4dmOwf6jQHCx"
Content-Disposition: inline
In-Reply-To: <aAGUKHsF2epjlNqG@mail-itl>


--LRee4dmOwf6jQHCx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Apr 2025 03:51:22 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: gregkh@linuxfoundation.org
Cc: rafael.j.wysocki@intel.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org
Subject: Re: FAILED: patch "[PATCH] cpufreq: Reference count policy in
 cpufreq_update_limits()" failed to apply to 6.14-stable tree

On Fri, Apr 18, 2025 at 01:52:07AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> On Thu, Apr 17, 2025 at 03:28:14PM +0200, gregkh@linuxfoundation.org wrot=
e:
> >=20
> > The patch below does not apply to the 6.14-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >=20
> > To reproduce the conflict and resubmit, you may use the following comma=
nds:
>=20
> What specifically the conflict is? For me it applies cleanly, both on
> top of v6.14.2 and v6.14.3-rc1...
> And same for 6.12 branch, I haven't checked others.

Ah, I see, it fails to build as it depends on
97a705dc1a3654d8d2e466433a897be202a7f0ac (the part about DEFINE_FREE).
A backport without this dependency is easy, I'll post it in a moment.

> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/ linux-6.14.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 9e4e249018d208678888bdf22f6b652728106528
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '202504171=
4-stoke-unripe-5956@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..
> >=20
> > Possible dependencies:
> >=20
> >=20
> >=20
> > thanks,
> >=20
> > greg k-h
> >=20
> > ------------------ original commit in Linus's tree ------------------
> >=20
> > From 9e4e249018d208678888bdf22f6b652728106528 Mon Sep 17 00:00:00 2001
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Date: Fri, 28 Mar 2025 21:39:08 +0100
> > Subject: [PATCH] cpufreq: Reference count policy in cpufreq_update_limi=
ts()
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >=20
> > Since acpi_processor_notify() can be called before registering a cpufreq
> > driver or even in cases when a cpufreq driver is not registered at all,
> > cpufreq_update_limits() needs to check if a cpufreq driver is present
> > and prevent it from being unregistered.
> >=20
> > For this purpose, make it call cpufreq_cpu_get() to obtain a cpufreq
> > policy pointer for the given CPU and reference count the corresponding
> > policy object, if present.
> >=20
> > Fixes: 5a25e3f7cc53 ("cpufreq: intel_pstate: Driver-specific handling o=
f _PPC updates")
> > Closes: https://lore.kernel.org/linux-acpi/Z-ShAR59cTow0KcR@mail-itl
> > Reported-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Link: https://patch.msgid.link/1928789.tdWV9SEqCh@rjwysocki.net
> >=20
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 0cf5a320bb5e..3841c9da6cac 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2809,6 +2809,12 @@ EXPORT_SYMBOL(cpufreq_update_policy);
> >   */
> >  void cpufreq_update_limits(unsigned int cpu)
> >  {
> > +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> > +
> > +	policy =3D cpufreq_cpu_get(cpu);
> > +	if (!policy)
> > +		return;
> > +
> >  	if (cpufreq_driver->update_limits)
> >  		cpufreq_driver->update_limits(cpu);
> >  	else
> >=20
>=20
> --=20
> Best Regards,
> Marek Marczykowski-G=C3=B3recki
> Invisible Things Lab



--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--LRee4dmOwf6jQHCx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmgBsBoACgkQ24/THMrX
1yxCZgf/Z3eqW1kq8EhqLqRuX7E7bK/L1gQGkB9z8d/Z7MgIEFp4P5AEOiocmCBE
z6wsoCgHQhGQUP2QY504M9bC+twxQIaRgT9TQbxj8gJh6tan0A/IjfkCc/bAS3qX
ZNKxArPed/jeMkp2395ocyZ8Xo1RjhvuuLPwNK2qugE50yJpxFMssEuuV2x7FhOd
wMVMloe+7qct09h0mT8cgCevp5cZqyU/2DtPnt9dZyssvjQUVHFsADmeSbOY7QJx
Q338pMu2ZFpTYWpwSMHSKPzDZPeDTx2NWSuq0xpZdAcZ+WVDDNFMRjgImV6S5Y8G
J8bNEStgB7Y/g3obmPCGJsZWPx/Lhw==
=82Si
-----END PGP SIGNATURE-----

--LRee4dmOwf6jQHCx--

