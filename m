Return-Path: <stable+bounces-204429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63860CEDAD8
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 07:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31B063004B91
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 06:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616FA2C026E;
	Fri,  2 Jan 2026 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b="tAShDAG7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qZNdJMVe"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959CA1F0994
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 06:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767334754; cv=none; b=qGgxAtkflq7imYevNkuVZduIpL1JiD7FPlaYIPRxwnw108WotNGUyuDmv5N7Yzcm42rm/JppO4l1Ykkaum9eV5hqsk4lT6rUjUycwxWXE0BAyWtCuoPeMaYTSFv7tb8k1SuzMIZLUPFAl8J/9/y/RdIG1H9JMgUG01A3vtqobXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767334754; c=relaxed/simple;
	bh=NROA5ZUi/i71EXZGGiO7o7HxJF2lph2k1FFnpo+z+VQ=;
	h=From:To:Cc:Subject:Message-ID:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQOru3yvei6CysOyrxkNXTxNJ6SF5muAQDQ54Y1AvtfKeHOO9ElXMQYquAFG0wU0RTVARki2v7pBluh7piUYYA6r9Sie9Q1qKx7HOfLXwwjwR4vBqtVz8gnDjeIw804S5RcIiMNXA7u/fCPFyP1bbiTW8MrDhm2G1F9X3wrx7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net; spf=pass smtp.mailfrom=kode54.net; dkim=pass (2048-bit key) header.d=kode54.net header.i=@kode54.net header.b=tAShDAG7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qZNdJMVe; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kode54.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kode54.net
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7BD6B7A007A;
	Fri,  2 Jan 2026 01:19:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 Jan 2026 01:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kode54.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767334748; x=1767421148; bh=uIu3SmRvVW
	9jlFAJVaTfLed1Lotc92Iz/4W9HcDEspQ=; b=tAShDAG7sRAhMJpeBCrrYt90th
	h4HaZCgXKftktWArnJCke11l/kQ/sx28cR2NiWj2YOi7QWAIWbTJE+F919oRUDuv
	L4xO575PC4IgHbnx9VmlBuRCVcWVIyUvV7oyOWDCz4ZhHC8OGev2q0H5A3QDlYij
	hEp+gwOD03EuBRzpMKt6ItVttsUDI8C/AMhesyY83rBOeB4O0yLZo/cdab3bl8FD
	CkFvtG+uxeE4Jds/hMd5FhXJjk7bsm9K9e9cH3D0SzPJqJ3kL0A7f584CC8TyQTn
	oBu59YzoWUbKZ+Ohv6jMhaY0+p0O8v7FPW86I6AvEcMdVS6pVlwylqYhEc4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767334748; x=1767421148; bh=uIu3SmRvVW9jlFAJVaTfLed1Lotc92Iz/4W
	9HcDEspQ=; b=qZNdJMVexJb5dZfj3QplO8Djkp39NZl1uX0uIGw0OTEDj5+d0Xu
	1QG5OJgEvunlm9RrSjD0KS7wnRJL2vPmUCoO5Sp+NOEkw5LTKbpvAj9z9lBVIluc
	UbrQJzF8oYtPUmkIKrpWFYzAYpwdt11pleI6JKPjfgqM5aHWoPmYecempTmZIRnV
	fXQpVV2QrCzfSTyfPJMjURv8s8MTVE7M++lhTs+/S4Z3mGkDGn63MSpmkdqQvqJF
	C/VnDoJFiWrXJElr17txp5YyzXk8EJJKm6ZGwIfGbIwYQ2MKRl/LGmqcbT0NOOXg
	Kv2JwK+9Fy32Xq/Sg2jSVQhXQONHtSMW8iQ==
X-ME-Sender: <xms:XGNXacVM0JouHA1bqfeHubN2HcaeTuu-KsXBUeoiiboxW9NY5JZrcw>
    <xme:XGNXacmr_YvxlnVZ5gFSXcSYFZQWshvw-f0-96OSw30gf9XQ5POXFfPyMyANJrDVO
    q9Q2AAr6yinFpSEOr4zJSDyCRmECwIOJsNm05svSrOLCBKZECowziI>
X-ME-Received: <xmr:XGNXaSkLaLHXlpD98nyIdUhqO1pga7WDnRgjkSu_7duzVPSfqUB5e7YgQos>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevuffkfgffjghfgggtsehgtderredtreejnecuhfhrohhmpeevhhhrihhsthho
    phhhvghrucfunhhofihhihhllhcuoegthhhrihhssehkohguvgehgedrnhgvtheqnecugg
    ftrfgrthhtvghrnhepteevfeekueefieegleeiveevfeeiffegjefglefgtdeuleeltefh
    udfhlefgtdefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpfhgrlhgtohhnrdhssg
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhr
    ihhssehkohguvgehgedrnhgvthdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgrthhthhgvfidrshgthhifrghrthiisehlihhnuhigrdgu
    vghvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhope
    gurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghp
    thhtohepnhhouhhvvggruheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprh
    gtphhtthhopegrihhrlhhivggusehrvgguhhgrthdrtghomhdprhgtphhtthhopehsthgr
    sghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlhihuuggvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehtthgrsghisehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:XGNXacZ20w0qWwIlofZi7f6ByDt-eM6T0VRSrvih1Cr35XrngY-wJg>
    <xmx:XGNXaURLZZl5lqKZhInqtPNy0RZKQ-ojWIYAOQiTqVT_vSUghR9CUA>
    <xmx:XGNXaWvZ_Ll4I72oHdY2FcWDY49UrVPjpzzOnQ_WFhpJaeCsvPczEw>
    <xmx:XGNXaWHkIhbWw8tZ2fwUHe-rBsnbs2W7DCC8pKmiIBcJXAcYGwVubA>
    <xmx:XGNXaWl_MY0aNOvP2FiiyZ9JVw0vbkosPPXJMc8Zx1mLy5WgyDEqaBaQ>
Feedback-ID: i9ec6488d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jan 2026 01:19:07 -0500 (EST)
From: Christopher Snowhill <chris@kode54.net>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Timur Tabi <ttabi@nvidia.com>
Subject: Re: [PATCH] nouveau: don't attempt fwsec on sb on newer platforms.
Message-ID: <176733474669.3438.14473492367845630654@copycat>
User-Agent: Dodo
Date: Thu, 01 Jan 2026 22:19:06 -0800
In-Reply-To: <176733464054.3438.4631752218787568258@copycat>
References: <20260102041829.2748009-1-airlied@gmail.com>
 <4ba1b583-8ae3-4698-8fde-0084f7f9cbf9@linux.dev>
 <176733464054.3438.4631752218787568258@copycat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha512"; boundary="===============6365538168194709753=="

--===============6365538168194709753==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On Thu 01 Jan 2026 10:17:20 PM , Christopher Snowhill wrote:
>=20
>=20
> On Thu 01 Jan 2026 09:21:26 PM , Matthew Schwartz wrote:
> > On 1/1/26 8:18 PM, Dave Airlie wrote:
> > > From: Dave Airlie <airlied@redhat.com>
> > >=20
> > > The changes to always loads fwsec sb causes problems on newer GPUs
> > > which don't use this path.
> > >=20
> > > Add hooks and pass through the device specific layers.
> > >=20
> > > Fixes: da67179e5538 ("drm/nouveau/gsp: Allocate fwsec-sb at boot")
> >=20
> > Closes: https://lore.kernel.org/nouveau/59736756-d81b-41bb-84ba-a1b51057c=
dd4@linux.dev/
> > Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> >=20
> > Thanks,
> > Matt
>=20
> Closes:
> https://lore.kernel.org/all/176682185563.8256.115798774340102079@copycat/
> Tested-by: Christopher Snowhill <chris@kode54.net>
>=20
> My thanks as well,
> Christopher

Oh, dang it, it didn't auto pick the address the list sent it to as the
sending account.

>=20
> >=20
> > > Cc: <stable@vger.kernel.org> # v6.16+
> > > Cc: Lyude Paul <lyude@redhat.com>
> > > Cc: Timur Tabi <ttabi@nvidia.com>
> > > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > > ---
> > >  .../gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c   |  3 +++
> > >  .../gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c   | 12 +++-------
> > >  .../gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c   |  3 +++
> > >  .../gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c   |  3 +++
> > >  .../gpu/drm/nouveau/nvkm/subdev/gsp/priv.h    | 23 +++++++++++++++++--
> > >  .../gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c   | 15 ++++++++++++
> > >  .../gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c   |  3 +++
> > >  7 files changed, 51 insertions(+), 11 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c
> > > index 35d1fcef520bf..b3e994386334d 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c
> > > @@ -29,6 +29,9 @@ ad102_gsp =3D {
> > >  	.sig_section =3D ".fwsignature_ad10x",
> > > =20
> > >  	.booter.ctor =3D ga102_gsp_booter_ctor,
> > > +=09
> > > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > > =20
> > >  	.dtor =3D r535_gsp_dtor,
> > >  	.oneinit =3D tu102_gsp_oneinit,
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
> > > index 5037602466604..8d4f40a443ce4 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
> > > @@ -337,16 +337,10 @@ nvkm_gsp_fwsec_sb(struct nvkm_gsp *gsp)
> > >  }
> > > =20
> > >  int
> > > -nvkm_gsp_fwsec_sb_ctor(struct nvkm_gsp *gsp)
> > > +nvkm_gsp_fwsec_sb_init(struct nvkm_gsp *gsp)
> > >  {
> > > -	return nvkm_gsp_fwsec_init(gsp, &gsp->fws.falcon.sb, "fwsec-sb",
> > > -				   NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB);
> > > -}
> > > -
> > > -void
> > > -nvkm_gsp_fwsec_sb_dtor(struct nvkm_gsp *gsp)
> > > -{
> > > -	nvkm_falcon_fw_dtor(&gsp->fws.falcon.sb);
> > > +       return nvkm_gsp_fwsec_init(gsp, &gsp->fws.falcon.sb, "fwsec-sb",
> > > +                                  NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB);
> > >  }
> > > =20
> > >  int
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> > > index d201e8697226b..27a13aeccd3cb 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> > > @@ -47,6 +47,9 @@ ga100_gsp =3D {
> > > =20
> > >  	.booter.ctor =3D tu102_gsp_booter_ctor,
> > > =20
> > > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > > +
> > >  	.dtor =3D r535_gsp_dtor,
> > >  	.oneinit =3D tu102_gsp_oneinit,
> > >  	.init =3D tu102_gsp_init,
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> > > index 917f7e2f6c466..a59fb74ef6315 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> > > @@ -158,6 +158,9 @@ ga102_gsp_r535 =3D {
> > > =20
> > >  	.booter.ctor =3D ga102_gsp_booter_ctor,
> > > =20
> > > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > > +=09
> > >  	.dtor =3D r535_gsp_dtor,
> > >  	.oneinit =3D tu102_gsp_oneinit,
> > >  	.init =3D tu102_gsp_init,
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h b/drivers/g=
pu/drm/nouveau/nvkm/subdev/gsp/priv.h
> > > index 86bdd203bc107..9dd66a2e38017 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> > > @@ -7,9 +7,8 @@ enum nvkm_acr_lsf_id;
> > > =20
> > >  int nvkm_gsp_fwsec_frts(struct nvkm_gsp *);
> > > =20
> > > -int nvkm_gsp_fwsec_sb_ctor(struct nvkm_gsp *);
> > >  int nvkm_gsp_fwsec_sb(struct nvkm_gsp *);
> > > -void nvkm_gsp_fwsec_sb_dtor(struct nvkm_gsp *);
> > > +int nvkm_gsp_fwsec_sb_init(struct nvkm_gsp *gsp);
> > > =20
> > >  struct nvkm_gsp_fwif {
> > >  	int version;
> > > @@ -52,6 +51,11 @@ struct nvkm_gsp_func {
> > >  			    struct nvkm_falcon *, struct nvkm_falcon_fw *);
> > >  	} booter;
> > > =20
> > > +	struct {
> > > +		int (*ctor)(struct nvkm_gsp *);
> > > +		void (*dtor)(struct nvkm_gsp *);
> > > +	} fwsec_sb;
> > > +
> > >  	void (*dtor)(struct nvkm_gsp *);
> > >  	int (*oneinit)(struct nvkm_gsp *);
> > >  	int (*init)(struct nvkm_gsp *);
> > > @@ -67,6 +71,8 @@ extern const struct nvkm_falcon_func tu102_gsp_flcn;
> > >  extern const struct nvkm_falcon_fw_func tu102_gsp_fwsec;
> > >  int tu102_gsp_booter_ctor(struct nvkm_gsp *, const char *, const struc=
t firmware *,
> > >  			  struct nvkm_falcon *, struct nvkm_falcon_fw *);
> > > +int tu102_gsp_fwsec_sb_ctor(struct nvkm_gsp *);
> > > +void tu102_gsp_fwsec_sb_dtor(struct nvkm_gsp *);
> > >  int tu102_gsp_oneinit(struct nvkm_gsp *);
> > >  int tu102_gsp_init(struct nvkm_gsp *);
> > >  int tu102_gsp_fini(struct nvkm_gsp *, bool suspend);
> > > @@ -91,5 +97,18 @@ int r535_gsp_fini(struct nvkm_gsp *, bool suspend);
> > >  int nvkm_gsp_new_(const struct nvkm_gsp_fwif *, struct nvkm_device *, =
enum nvkm_subdev_type, int,
> > >  		  struct nvkm_gsp **);
> > > =20
> > > +static inline int nvkm_gsp_fwsec_sb_ctor(struct nvkm_gsp *gsp)
> > > +{
> > > +	if (gsp->func->fwsec_sb.ctor)
> > > +		return gsp->func->fwsec_sb.ctor(gsp);
> > > +	return 0;
> > > +}
> > > +
> > > +static inline void nvkm_gsp_fwsec_sb_dtor(struct nvkm_gsp *gsp)
> > > +{
> > > +	if (gsp->func->fwsec_sb.dtor)
> > > +		gsp->func->fwsec_sb.dtor(gsp);
> > > +}
> > > +
> > >  extern const struct nvkm_gsp_func gv100_gsp;
> > >  #endif
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> > > index 81e56da0474a1..04b642a1f7305 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> > > @@ -30,6 +30,18 @@
> > >  #include <nvfw/fw.h>
> > >  #include <nvfw/hs.h>
> > > =20
> > > +int
> > > +tu102_gsp_fwsec_sb_ctor(struct nvkm_gsp *gsp)
> > > +{
> > > +	return nvkm_gsp_fwsec_sb_init(gsp);
> > > +}
> > > +
> > > +void
> > > +tu102_gsp_fwsec_sb_dtor(struct nvkm_gsp *gsp)
> > > +{
> > > +	nvkm_falcon_fw_dtor(&gsp->fws.falcon.sb);
> > > +}
> > > +
> > >  static int
> > >  tu102_gsp_booter_unload(struct nvkm_gsp *gsp, u32 mbox0, u32 mbox1)
> > >  {
> > > @@ -370,6 +382,9 @@ tu102_gsp =3D {
> > > =20
> > >  	.booter.ctor =3D tu102_gsp_booter_ctor,
> > > =20
> > > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > > +
> > >  	.dtor =3D r535_gsp_dtor,
> > >  	.oneinit =3D tu102_gsp_oneinit,
> > >  	.init =3D tu102_gsp_init,
> > > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c
> > > index 97eb046c25d07..58cf258424218 100644
> > > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c
> > > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c
> > > @@ -30,6 +30,9 @@ tu116_gsp =3D {
> > > =20
> > >  	.booter.ctor =3D tu102_gsp_booter_ctor,
> > > =20
> > > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > > +
> > >  	.dtor =3D r535_gsp_dtor,
> > >  	.oneinit =3D tu102_gsp_oneinit,
> > >  	.init =3D tu102_gsp_init,
> >=20

--===============6365538168194709753==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEdiLr51NrDwQ29PFjjWyYR59K3nEFAmlXY1oACgkQjWyYR59K
3nH0mQ//ahTpyMCsv0PFZ4kS1OdYl2N+47Zyq339I7QLRrfTiaxDmP4RTyauDCn0
D7zBOF4su2DVCjVje+jUMxKizb5/Z3jHO4Cxy+qpzYqxlkv/cBQpZW+dDsnmIVaj
eCSXIn2mt1RNaA6oJ+C5kzUhAgXzfCx9G4db+p7/qTgovGhyblZqmusZH93+Mo/G
7omNOCLMK5/IncTpHx5yNsDKSCRP/w7WmJBqKgATDygEMLdf7WJ4JhjfKdkinIni
ZBSCIXqbaDnsJ+D22vmfCeWbMPrl7pBC48kuw7bpGQ4iCjFfmvUQ929+hUgHJi4w
sY9ur2+q+ZVzBntJlz5mT0ymFKy31vfdQmzjA/K+t3FGAJl3L8XKqaFpkujhXnu6
LrANM7BXIE0w8WhEG8yLlMwnEgE260ekwKSetGSH7hBWKZMM62BbMuQl30vA17DZ
Lx9JBXowLRtn1mla0aUqhzqQ6+7PCKERmjvPy04XjM0XHkwf2qEV96ibhr8xWHiV
s4UxByMtvUHRAwwPheDjz6gA/NxRDR09cF11sftHUAz3gO+yxxzxz93QepCs6bFQ
YamGpghJNvDeV4Wet/CL2CyhSt77BRhG0xILl/csI5PrcFd+6o5JwLutnmKGNyyi
JxTFjW/H7o0w7QdxVgqDSVxYc1+h9T7iTfUVuxq/IeTYFoAwYtg=
=ZLEY
-----END PGP SIGNATURE-----

--===============6365538168194709753==--

