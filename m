Return-Path: <stable+bounces-204428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2111CEDACB
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 07:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0202E30053E4
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 06:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015DF2165EA;
	Fri,  2 Jan 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwVwe+eB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217941397
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767334645; cv=none; b=peRr6LPu7G6nxbmhUKvKlmzAv11DcAzWuL7mFZTcQW12MU6OTaXJLWHQCf4T7b3OIRRrPjdvPnaN9QMFYxYEYbBuKhhkgZSuYlAiCjiLuV48UCKgV8j8eLZa7aNzAVsWsJiJ28RAgoK6g6p99wp5+8PW5wf2POXdf+l7foOdPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767334645; c=relaxed/simple;
	bh=8WyYCOq0f9QWb1e6YAGvsnDP0EAz6+qLVySEZOIq6es=;
	h=From:To:Cc:Subject:Message-ID:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1JROI1qphgh+kLcCx8ly0CprU5n6qcjoMHsdfH0RQ479N1T52JMAs9AALmFGT5OIUbgP11w4Eizjzh4Okguj09R6kgMFz+bDxWmPfKr/NaoE8bh/VKUicEDDUNOgu6LwUkvciKcY1C27R50QomlqaVDbknf1JyOHBfNPkEt/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwVwe+eB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso8979816a12.0
        for <stable@vger.kernel.org>; Thu, 01 Jan 2026 22:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767334643; x=1767939443; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:date:user-agent:message-id
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9tu4+qvE4HVhlD3XFHpS0OFSs6sZmg8C8rk5ZdNmyzE=;
        b=NwVwe+eB/ftbxL4tyBlE9gnAdUFISELSjsQxjqEFMwYpVGeFQwkSOHAgNEDwzSKVey
         vgQ5U4ks3WBsQV2mO76XLWmvVqpqNWzDjPH3vxbPdYo82CsFbZb0seNOt6XXw4wucIS8
         PpxUvSAj4LcXQBABTXMojng88f8Y1RN6vJNzr7vU3av5LMq0xyo/snOfzTRf8Eal/SkP
         0GuyJOwoUva9c6o8QEgKUNfNmyHMB3SpFtVuzyde9dl7wobfmbYroxmWwk2DcZW7N4wj
         UKMQvcJxC1Ezri2ypAAPxU6Z7dFMXwMUmUZfQflUE23vmKPRnL1r2cO+W3LrrDKcG2P7
         mCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767334643; x=1767939443;
        h=mime-version:references:in-reply-to:date:user-agent:message-id
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9tu4+qvE4HVhlD3XFHpS0OFSs6sZmg8C8rk5ZdNmyzE=;
        b=q8nLc49JhlWHHiG72E8Mcrj/Pn+8BQyaRfYAl7Iv2jp2wkLOy7eltCQj/EpKGZigme
         B49ym2EICBdWw3A+shaxA6/WAMlkAzjRfz6rkQ5cjwvkcpAQCVc5aLLKNrNeOJ/PCPE8
         0FE2YNob7MvVMnd5g58u0she85+9v8yiKfGrz8uvh8ixKjk+sXici8F5cLX7DfhgUXg/
         HpC9uASLKEmnL+9I8JBWU4idnF6n6nhxHDE2XJSOQwSfdET9uXjvAIYPIeUDsaphazT5
         35rpNqyy3FXD6msBdFknTkO8gUU3OEEmSMAMlJ8bDmKQjWfgEddSvmwn07X3EjdjXo6I
         Gl0w==
X-Forwarded-Encrypted: i=1; AJvYcCWQWyH6zlP+ayD+GTis++ZR0S2BMIEkkaBzKlOgFNe8KNmOeLW5sAhoVvDWPKOMYvBObPmOCG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlwTPR3dxqGh9qAdBIoXSrHdoPnk04E7JBF8XlgkEUaYGZ0J9
	yxQuGebXlEpkW5uwFeDCNQ93WzEmNtavJcNQsTeDwS5CttqG1wbaeit7
X-Gm-Gg: AY/fxX7/Q3PbGoa5L7TmLELXPVHSjPzCPc0b3VTZ2XZt0U/CfaXNRUwK9+QwGlNRTE0
	ueBkK/4CEYZcdwkZ7hBqQGrB4RdWnjCgvsfy2RdLvQ40HYDJ3Ql+3U1/lwUDEpQJDbpIWaUFDfD
	ruTxYIeh9I+1Oq2xmBmExdeLOrlUtZ+q6VfaLHBp8PzWi+L9gsnC+lhSGNuYI+4YTRi7SrQXAeZ
	Z7xt26kAfKoEvmRXgMVbeVRhlxx4lqTnCaP7oomzg5oKrESFU6iXnhz4broNrAJ54Av/SdgPIJ4
	BzaEN1aVxVEJnkmEn8L9ApIGS9PJB8VtVUsvE6yaOfc0Jm58sXg991GGC3QY+KJOeOijKp3U8tE
	7J4bwZ0lzgJl5k4U7PqZ8fG/FmmoUAjj/xIi4xzKQIgqGp3Igi1wNSD68GuRdfQc38OVFP9f3di
	k=
X-Google-Smtp-Source: AGHT+IHFpVYh+rorOZKdQRWoZhugs0CHqY2P8dMbar8W2hgy3i7fuX7M+pBhDPEO+z8g5iSqn3uNwg==
X-Received: by 2002:a05:7022:e80c:b0:11d:f44d:34db with SMTP id a92af1059eb24-121722ec1a5mr33889693c88.35.1767334643190;
        Thu, 01 Jan 2026 22:17:23 -0800 (PST)
Received: from localhost ([2600:6c51:4c3f:8e93::cef])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm159501293c88.0.2026.01.01.22.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 22:17:22 -0800 (PST)
From: Christopher Snowhill <kode54@gmail.com>
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Timur Tabi <ttabi@nvidia.com>
Subject: Re: [PATCH] nouveau: don't attempt fwsec on sb on newer platforms.
Message-ID: <176733464054.3438.4631752218787568258@copycat>
User-Agent: Dodo
Date: Thu, 01 Jan 2026 22:17:20 -0800
In-Reply-To: <4ba1b583-8ae3-4698-8fde-0084f7f9cbf9@linux.dev>
References: <20260102041829.2748009-1-airlied@gmail.com>
 <4ba1b583-8ae3-4698-8fde-0084f7f9cbf9@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha512"; boundary="===============8364432865010440589=="

--===============8364432865010440589==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On Thu 01 Jan 2026 09:21:26 PM , Matthew Schwartz wrote:
> On 1/1/26 8:18 PM, Dave Airlie wrote:
> > From: Dave Airlie <airlied@redhat.com>
> >=20
> > The changes to always loads fwsec sb causes problems on newer GPUs
> > which don't use this path.
> >=20
> > Add hooks and pass through the device specific layers.
> >=20
> > Fixes: da67179e5538 ("drm/nouveau/gsp: Allocate fwsec-sb at boot")
>=20
> Closes: https://lore.kernel.org/nouveau/59736756-d81b-41bb-84ba-a1b51057cdd=
4@linux.dev/
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>=20
> Thanks,
> Matt

Closes:
https://lore.kernel.org/all/176682185563.8256.115798774340102079@copycat/
Tested-by: Christopher Snowhill <chris@kode54.net>

My thanks as well,
Christopher

>=20
> > Cc: <stable@vger.kernel.org> # v6.16+
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Timur Tabi <ttabi@nvidia.com>
> > Signed-off-by: Dave Airlie <airlied@redhat.com>
> > ---
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c   |  3 +++
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c   | 12 +++-------
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c   |  3 +++
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c   |  3 +++
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/priv.h    | 23 +++++++++++++++++--
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c   | 15 ++++++++++++
> >  .../gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c   |  3 +++
> >  7 files changed, 51 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ad102.c
> > index 35d1fcef520bf..b3e994386334d 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ad102.c
> > @@ -29,6 +29,9 @@ ad102_gsp =3D {
> >  	.sig_section =3D ".fwsignature_ad10x",
> > =20
> >  	.booter.ctor =3D ga102_gsp_booter_ctor,
> > +=09
> > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > =20
> >  	.dtor =3D r535_gsp_dtor,
> >  	.oneinit =3D tu102_gsp_oneinit,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/fwsec.c
> > index 5037602466604..8d4f40a443ce4 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
> > @@ -337,16 +337,10 @@ nvkm_gsp_fwsec_sb(struct nvkm_gsp *gsp)
> >  }
> > =20
> >  int
> > -nvkm_gsp_fwsec_sb_ctor(struct nvkm_gsp *gsp)
> > +nvkm_gsp_fwsec_sb_init(struct nvkm_gsp *gsp)
> >  {
> > -	return nvkm_gsp_fwsec_init(gsp, &gsp->fws.falcon.sb, "fwsec-sb",
> > -				   NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB);
> > -}
> > -
> > -void
> > -nvkm_gsp_fwsec_sb_dtor(struct nvkm_gsp *gsp)
> > -{
> > -	nvkm_falcon_fw_dtor(&gsp->fws.falcon.sb);
> > +       return nvkm_gsp_fwsec_init(gsp, &gsp->fws.falcon.sb, "fwsec-sb",
> > +                                  NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB);
> >  }
> > =20
> >  int
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ga100.c
> > index d201e8697226b..27a13aeccd3cb 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c
> > @@ -47,6 +47,9 @@ ga100_gsp =3D {
> > =20
> >  	.booter.ctor =3D tu102_gsp_booter_ctor,
> > =20
> > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > +
> >  	.dtor =3D r535_gsp_dtor,
> >  	.oneinit =3D tu102_gsp_oneinit,
> >  	.init =3D tu102_gsp_init,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ga102.c
> > index 917f7e2f6c466..a59fb74ef6315 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> > @@ -158,6 +158,9 @@ ga102_gsp_r535 =3D {
> > =20
> >  	.booter.ctor =3D ga102_gsp_booter_ctor,
> > =20
> > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > +=09
> >  	.dtor =3D r535_gsp_dtor,
> >  	.oneinit =3D tu102_gsp_oneinit,
> >  	.init =3D tu102_gsp_init,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h b/drivers/gpu=
/drm/nouveau/nvkm/subdev/gsp/priv.h
> > index 86bdd203bc107..9dd66a2e38017 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h
> > @@ -7,9 +7,8 @@ enum nvkm_acr_lsf_id;
> > =20
> >  int nvkm_gsp_fwsec_frts(struct nvkm_gsp *);
> > =20
> > -int nvkm_gsp_fwsec_sb_ctor(struct nvkm_gsp *);
> >  int nvkm_gsp_fwsec_sb(struct nvkm_gsp *);
> > -void nvkm_gsp_fwsec_sb_dtor(struct nvkm_gsp *);
> > +int nvkm_gsp_fwsec_sb_init(struct nvkm_gsp *gsp);
> > =20
> >  struct nvkm_gsp_fwif {
> >  	int version;
> > @@ -52,6 +51,11 @@ struct nvkm_gsp_func {
> >  			    struct nvkm_falcon *, struct nvkm_falcon_fw *);
> >  	} booter;
> > =20
> > +	struct {
> > +		int (*ctor)(struct nvkm_gsp *);
> > +		void (*dtor)(struct nvkm_gsp *);
> > +	} fwsec_sb;
> > +
> >  	void (*dtor)(struct nvkm_gsp *);
> >  	int (*oneinit)(struct nvkm_gsp *);
> >  	int (*init)(struct nvkm_gsp *);
> > @@ -67,6 +71,8 @@ extern const struct nvkm_falcon_func tu102_gsp_flcn;
> >  extern const struct nvkm_falcon_fw_func tu102_gsp_fwsec;
> >  int tu102_gsp_booter_ctor(struct nvkm_gsp *, const char *, const struct =
firmware *,
> >  			  struct nvkm_falcon *, struct nvkm_falcon_fw *);
> > +int tu102_gsp_fwsec_sb_ctor(struct nvkm_gsp *);
> > +void tu102_gsp_fwsec_sb_dtor(struct nvkm_gsp *);
> >  int tu102_gsp_oneinit(struct nvkm_gsp *);
> >  int tu102_gsp_init(struct nvkm_gsp *);
> >  int tu102_gsp_fini(struct nvkm_gsp *, bool suspend);
> > @@ -91,5 +97,18 @@ int r535_gsp_fini(struct nvkm_gsp *, bool suspend);
> >  int nvkm_gsp_new_(const struct nvkm_gsp_fwif *, struct nvkm_device *, en=
um nvkm_subdev_type, int,
> >  		  struct nvkm_gsp **);
> > =20
> > +static inline int nvkm_gsp_fwsec_sb_ctor(struct nvkm_gsp *gsp)
> > +{
> > +	if (gsp->func->fwsec_sb.ctor)
> > +		return gsp->func->fwsec_sb.ctor(gsp);
> > +	return 0;
> > +}
> > +
> > +static inline void nvkm_gsp_fwsec_sb_dtor(struct nvkm_gsp *gsp)
> > +{
> > +	if (gsp->func->fwsec_sb.dtor)
> > +		gsp->func->fwsec_sb.dtor(gsp);
> > +}
> > +
> >  extern const struct nvkm_gsp_func gv100_gsp;
> >  #endif
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/tu102.c
> > index 81e56da0474a1..04b642a1f7305 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c
> > @@ -30,6 +30,18 @@
> >  #include <nvfw/fw.h>
> >  #include <nvfw/hs.h>
> > =20
> > +int
> > +tu102_gsp_fwsec_sb_ctor(struct nvkm_gsp *gsp)
> > +{
> > +	return nvkm_gsp_fwsec_sb_init(gsp);
> > +}
> > +
> > +void
> > +tu102_gsp_fwsec_sb_dtor(struct nvkm_gsp *gsp)
> > +{
> > +	nvkm_falcon_fw_dtor(&gsp->fws.falcon.sb);
> > +}
> > +
> >  static int
> >  tu102_gsp_booter_unload(struct nvkm_gsp *gsp, u32 mbox0, u32 mbox1)
> >  {
> > @@ -370,6 +382,9 @@ tu102_gsp =3D {
> > =20
> >  	.booter.ctor =3D tu102_gsp_booter_ctor,
> > =20
> > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > +
> >  	.dtor =3D r535_gsp_dtor,
> >  	.oneinit =3D tu102_gsp_oneinit,
> >  	.init =3D tu102_gsp_init,
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/tu116.c
> > index 97eb046c25d07..58cf258424218 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu116.c
> > @@ -30,6 +30,9 @@ tu116_gsp =3D {
> > =20
> >  	.booter.ctor =3D tu102_gsp_booter_ctor,
> > =20
> > +	.fwsec_sb.ctor =3D tu102_gsp_fwsec_sb_ctor,
> > +	.fwsec_sb.dtor =3D tu102_gsp_fwsec_sb_dtor,
> > +
> >  	.dtor =3D r535_gsp_dtor,
> >  	.oneinit =3D tu102_gsp_oneinit,
> >  	.init =3D tu102_gsp_init,
>=20

--===============8364432865010440589==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEdiLr51NrDwQ29PFjjWyYR59K3nEFAmlXYvAACgkQjWyYR59K
3nE1yQ/9EJVWTNypR4Qp9EdmQu8lGbilKZCbxy9izW/fLgrRyeZwT2NX7nDV67uC
lDT/6jsgs6BeCeKKnJeEwoH15fEuRkh9CnXQ4R0dl9Zea8nXWpaGBf5SAhSpZxdP
pYKTWN1XUUWDFrzEwiBkF9etrzQnEfnmY2SxO/fBXiQ0A4u94KxuWMZ3zEc6YoPQ
Lp2r2/N2trJII7wlhSTPGsVf7+X0eYUxFyzEEAJ7TsOyu4U4rFBBMaSClHXmPHTV
bVYIRyPtsRULdaNVxgrQQmbrstjUM7R9crBCo6WhIa7EAhOj7mRG/q+jRIyjr/g+
bFG1K8EUAcC04eTuLFAjPMW2mfUwDh6HVzQ6+Lzqc1ljbcbxpNkN3PgiQ/e7CyYA
fc8gPCYU0/yzpcIcriqH+Yu/t17Fxdr9EqVcLS5VcAUKifcGl++gauK0MO2R7UWq
5L1DXk3u2Y+d9gmOdOyrt3f/7dZSJTXz0IlLdZWb71oM0Vu+UeIhM8zG5qtz1ejO
ovMgReAoKwDc1tdIj5Uo9ERe6R6HAoJhEPQ2q7rPpKZO7+4MEoA1rRpssMEeRCtj
S0us+sSpwg/udEO8QyBkyQ9LyGln3KUd6hH78k7WEoJQhU1ukS19TifV7RAHLIOq
c47v0A68w2DI8txaU7N2tCDOkH0Ayce59RbVgzdT/hP0srJeMYY=
=7N2B
-----END PGP SIGNATURE-----

--===============8364432865010440589==--

