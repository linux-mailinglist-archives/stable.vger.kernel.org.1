Return-Path: <stable+bounces-28343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F0287E520
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A031F22290
	for <lists+stable@lfdr.de>; Mon, 18 Mar 2024 08:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC390286BF;
	Mon, 18 Mar 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSEd7k75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA426AD8;
	Mon, 18 Mar 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710751457; cv=none; b=lAq4ipeAop024IhpIJd4O1H1JmBXSUiIO9NSuNzC81lc48tYqa0TYuj57beIRHeD9CPqDyxeEUlO8Dt4atIhH1sRBwV3dURJftXtAstYe23XFwU0xwls+dv/Lg+SbP2qLAfORwITI14ZlNTc+nbRM8PCqc1PfXRZFkAabE4tyxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710751457; c=relaxed/simple;
	bh=tgAPjvF3ioJGuh/k4VH4nzhLxQlR7APgozh3yQXWWXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEb5VYDU95Zcc+B0UC5ZUZ7yYqHZMmkROXCVTzwI19Ve0kbnvmwbI//SVaVRSQeefbW5By5U4Cw2oRgduii4wK5HlYOuyNMN9pwC10lSq02mz7raG5CAEIEyllSKTn7vAzbjuRcUMuNQLIX3SVRsqQrZ/UQqXwXP4apbUAihOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSEd7k75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD604C43390;
	Mon, 18 Mar 2024 08:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710751457;
	bh=tgAPjvF3ioJGuh/k4VH4nzhLxQlR7APgozh3yQXWWXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSEd7k75BiPJDsR6nMMSvz1HnRuZFCyR006gvaJMOqeHmtY535njdAhdxnB7s3Vly
	 1t5Eh7L+cvgzBzAsS/8h9KIANO/PCFX+p5hgwWwNiIkvdd8xhckgNeP4yFGBrVO6z6
	 5pklNU/U49/G2SYbSqPcXgOcu9ggw4nTfucaoZbquimYqPT3QqAJc4xVLdr2tr4+cH
	 wQlwW1zFgtq1ZLXfW07XG2O+ojyenkAV0dswz/S7W3JU+n/daTDSPpin4fj72UqtNv
	 xnrcqXWBFQkEhhqeI7jzV1g0UWGqtl3hLvYIbyKb5Eaj9Mynh+NsT0ahZ0+kXDvwAw
	 t1HhanHBmNYrw==
Date: Mon, 18 Mar 2024 09:44:14 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zack.rusin@broadcom.com>, daniel@ffwll.ch, 
	airlied@gmail.com, deller@gmx.de, javierm@redhat.com, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 01/43] drm/fbdev-generic: Do not set physical framebuffer
 address
Message-ID: <20240318-dark-mongoose-of-camouflage-7ac6ed@houat>
References: <20240312154834.26178-1-tzimmermann@suse.de>
 <20240312154834.26178-2-tzimmermann@suse.de>
 <CABQX2QPJJFrARdteFFZ8f33hvDx-HSyOQJQ7AMFK4C8C=BquTQ@mail.gmail.com>
 <e684558e-8308-4d73-b920-547f9012a2cb@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a7vnwfog3n7f6fea"
Content-Disposition: inline
In-Reply-To: <e684558e-8308-4d73-b920-547f9012a2cb@suse.de>


--a7vnwfog3n7f6fea
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 08:59:01AM +0100, Thomas Zimmermann wrote:
> Hi
>=20
> Am 18.03.24 um 03:35 schrieb Zack Rusin:
> > On Tue, Mar 12, 2024 at 11:48=E2=80=AFAM Thomas Zimmermann <tzimmermann=
@suse.de> wrote:
> > > Framebuffer memory is allocated via vmalloc() from non-contiguous
> > > physical pages. The physical framebuffer start address is therefore
> > > meaningless. Do not set it.
> > >=20
> > > The value is not used within the kernel and only exported to userspace
> > > on dedicated ARM configs. No functional change is expected.
> > >=20
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > Fixes: a5b44c4adb16 ("drm/fbdev-generic: Always use shadow buffering")
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: Javier Martinez Canillas <javierm@redhat.com>
> > > Cc: Zack Rusin <zackr@vmware.com>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: <stable@vger.kernel.org> # v6.4+
> > > ---
> > >   drivers/gpu/drm/drm_fbdev_generic.c | 1 -
> > >   1 file changed, 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/dr=
m_fbdev_generic.c
> > > index d647d89764cb9..b4659cd6285ab 100644
> > > --- a/drivers/gpu/drm/drm_fbdev_generic.c
> > > +++ b/drivers/gpu/drm/drm_fbdev_generic.c
> > > @@ -113,7 +113,6 @@ static int drm_fbdev_generic_helper_fb_probe(stru=
ct drm_fb_helper *fb_helper,
> > >          /* screen */
> > >          info->flags |=3D FBINFO_VIRTFB | FBINFO_READS_FAST;
> > >          info->screen_buffer =3D screen_buffer;
> > > -       info->fix.smem_start =3D page_to_phys(vmalloc_to_page(info->s=
creen_buffer));
> > >          info->fix.smem_len =3D screen_size;
> > >=20
> > >          /* deferred I/O */
> > > --
> > > 2.44.0
> > >=20
> > Good idea. I think given that drm_leak_fbdev_smem is off by default we
> > could remove the setting of smem_start by all of the in-tree drm
> > drivers (they all have open source userspace that won't mess around
> > with fbdev fb) - it will be reset to 0 anyway. Actually, I wonder if
> > we still need drm_leak_fbdev_smem at all...
>=20
> All I know is that there's an embedded userspace driver that requires that
> setting. I don't even know which hardware.

The original Mali driver (ie, lima) used to require it, that's why we
introduced it in the past.

I'm not sure if the newer versions of that driver, or if newer Mali
generations (ie, panfrost and panthor) closed source driver would
require it, so it might be worth removing if it's easy enough to revert.

Maxime

--a7vnwfog3n7f6fea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZff+0QAKCRDj7w1vZxhR
xbbfAP9Pld0vccS27vREZ3xsYkeM/kiU0yHFImyTFQZWfZWwiAD/aouRJnuZ7N1x
BfTpDauyPANFnaIznKrfRtKrI2D+4QU=
=utup
-----END PGP SIGNATURE-----

--a7vnwfog3n7f6fea--

