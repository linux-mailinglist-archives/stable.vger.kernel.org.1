Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5893073F6C9
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 10:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF0ISZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 04:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjF0ISY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 04:18:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3E1991
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 01:18:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6a5fd1f46so22202111fa.1
        for <stable@vger.kernel.org>; Tue, 27 Jun 2023 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687853887; x=1690445887;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDcwtD5dUb123KopR26bdwMl9ONuprOUqM+yKdmN9c0=;
        b=jlQ2gQvxDhLs4c6oIgDQwYGRKdEaNxEKomPDk+ORI695SBCXAN7+x9dJPD4KB/DbRL
         Z3kAjQbrwlrMXqs7Ga1mkzJb4/Wc9p3dyqyXW/6kfrqqr/PXofvB64g039xyPICBhnoS
         9PhII/bi7WRpn9xE9QR7NXOFQf4jDa9jJd60QDW/XPRYSjDkA33z2djuxx98sfSl9ihL
         CFdcLcIKd66KU9THV1moDZnK/liFunO0LPv5wVkIJH9jEjDRr3CBvqVVv+fpIeODSx2h
         iztz8E4lzamSEBOewzj/BaGoUO2qU+Er9/kExQmSgOEkdzugAjk+Ik2n9caA0VRuyzyn
         8CoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853887; x=1690445887;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDcwtD5dUb123KopR26bdwMl9ONuprOUqM+yKdmN9c0=;
        b=TD3+uBM8u3AKZohZ/3hPy6vnnFpZRxXxgt0UCNynVjeTgsDubjWOJYWhIwMBvTBU+e
         46N0Bn+9EAM78lk4IPVRVQQg3e0LreuaVmeuWw4CJOT/rjdKsz1i/3XDCYaKyJrnawX+
         MkD17tamD7BLJraczjmNNtC+M74lDwUfdU0wu0fzZKb6NFuSmf454kkNEUjxjpMGW082
         Z2O5Tb/ZRy6t3Ug/m/k5l6SkyggTh2m5twSDmzagPp6ovRAWzeZwP/V7UPQDx/yOEwnw
         nZMpZJD0VKnQzmQPPnOXVBc07+CVyVg2U1HYOR852IXm96TVBhYvoFxCw1FNIsp+txzF
         svHw==
X-Gm-Message-State: AC+VfDwzw1SuvQu33eRf89WivAeBRBxXd8PhF7lMrQbtQtq8UssrMW0Z
        TLKqSD09B88CYEyPn9xfSS4=
X-Google-Smtp-Source: ACHHUZ5FLZn8rqUWAkxdQHm9Ebkb03Lru6KLXrl+NbgOJY0YeaeLuRriQGlPrQ27n31tEWDBOTG6HQ==
X-Received: by 2002:a2e:6a07:0:b0:2b5:7fba:18ac with SMTP id f7-20020a2e6a07000000b002b57fba18acmr15598565ljc.48.1687853886640;
        Tue, 27 Jun 2023 01:18:06 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id y13-20020a2e9d4d000000b002b69b44fd52sm1282062ljj.5.2023.06.27.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:18:06 -0700 (PDT)
Date:   Tue, 27 Jun 2023 11:18:02 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Zack Rusin <zack@kde.org>
Cc:     Zack Rusin <zackr@vmware.com>, dri-devel@lists.freedesktop.org,
        krastevm@vmware.com, mombasawalam@vmware.com, banackm@vmware.com,
        iforbes@vmware.com, javierm@redhat.com, contact@emersion.fr,
        daniel@ffwll.ch, stable@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 1/8] drm: Disable the cursor plane on atomic contexts
 with virtualized drivers
Message-ID: <20230627111802.4953a3ae@eldfell>
In-Reply-To: <20230627035839.496399-2-zack@kde.org>
References: <20230627035839.496399-1-zack@kde.org>
        <20230627035839.496399-2-zack@kde.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dn7NARskuHFZfslN0/I+jRo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--Sig_/dn7NARskuHFZfslN0/I+jRo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jun 2023 23:58:32 -0400
Zack Rusin <zack@kde.org> wrote:

> From: Zack Rusin <zackr@vmware.com>
>=20
> Cursor planes on virtualized drivers have special meaning and require
> that the clients handle them in specific ways, e.g. the cursor plane
> should react to the mouse movement the way a mouse cursor would be
> expected to and the client is required to set hotspot properties on it
> in order for the mouse events to be routed correctly.
>=20
> This breaks the contract as specified by the "universal planes". Fix it
> by disabling the cursor planes on virtualized drivers while adding
> a foundation on top of which it's possible to special case mouse cursor
> planes for clients that want it.
>=20
> Disabling the cursor planes makes some kms compositors which were broken,
> e.g. Weston, fallback to software cursor which works fine or at least
> better than currently while having no effect on others, e.g. gnome-shell
> or kwin, which put virtualized drivers on a deny-list when running in
> atomic context to make them fallback to legacy kms and avoid this issue.
>=20
> Signed-off-by: Zack Rusin <zackr@vmware.com>
> Fixes: 681e7ec73044 ("drm: Allow userspace to ask for universal plane lis=
t (v2)")

Sounds good to me.

Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>


Thanks,
pq



> Cc: <stable@vger.kernel.org> # v5.4+
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/drm_plane.c          | 13 +++++++++++++
>  drivers/gpu/drm/qxl/qxl_drv.c        |  2 +-
>  drivers/gpu/drm/vboxvideo/vbox_drv.c |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_drv.c |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c  |  2 +-
>  include/drm/drm_drv.h                |  9 +++++++++
>  include/drm/drm_file.h               | 12 ++++++++++++
>  7 files changed, 38 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 24e7998d1731..a4a39f4834e2 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -678,6 +678,19 @@ int drm_mode_getplane_res(struct drm_device *dev, vo=
id *data,
>  		    !file_priv->universal_planes)
>  			continue;
> =20
> +		/*
> +		 * If we're running on a virtualized driver then,
> +		 * unless userspace advertizes support for the
> +		 * virtualized cursor plane, disable cursor planes
> +		 * because they'll be broken due to missing cursor
> +		 * hotspot info.
> +		 */
> +		if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR &&
> +		    drm_core_check_feature(dev, DRIVER_CURSOR_HOTSPOT)	&&
> +		    file_priv->atomic &&
> +		    !file_priv->supports_virtualized_cursor_plane)
> +			continue;
> +
>  		if (drm_lease_held(file_priv, plane->base.id)) {
>  			if (count < plane_resp->count_planes &&
>  			    put_user(plane->base.id, plane_ptr + count))
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index b30ede1cf62d..91930e84a9cd 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -283,7 +283,7 @@ static const struct drm_ioctl_desc qxl_ioctls[] =3D {
>  };
> =20
>  static struct drm_driver qxl_driver =3D {
> -	.driver_features =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
> +	.driver_features =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC | DRIV=
ER_CURSOR_HOTSPOT,
> =20
>  	.dumb_create =3D qxl_mode_dumb_create,
>  	.dumb_map_offset =3D drm_gem_ttm_dumb_map_offset,
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxv=
ideo/vbox_drv.c
> index 4fee15c97c34..8ecd0863fad7 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> @@ -172,7 +172,7 @@ DEFINE_DRM_GEM_FOPS(vbox_fops);
> =20
>  static const struct drm_driver driver =3D {
>  	.driver_features =3D
> -	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
> +	    DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC | DRIVER_CURSOR_HOTSPOT,
> =20
>  	.fops =3D &vbox_fops,
>  	.name =3D DRIVER_NAME,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virti=
o/virtgpu_drv.c
> index a7ec5a3770da..8f4bb8a4e952 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -176,7 +176,7 @@ static const struct drm_driver driver =3D {
>  	 * If KMS is disabled DRIVER_MODESET and DRIVER_ATOMIC are masked
>  	 * out via drm_device::driver_features:
>  	 */
> -	.driver_features =3D DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIV=
ER_ATOMIC,
> +	.driver_features =3D DRIVER_MODESET | DRIVER_GEM | DRIVER_RENDER | DRIV=
ER_ATOMIC | DRIVER_CURSOR_HOTSPOT,
>  	.open =3D virtio_gpu_driver_open,
>  	.postclose =3D virtio_gpu_driver_postclose,
> =20
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 8b24ecf60e3e..d3e308fdfd5b 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1611,7 +1611,7 @@ static const struct file_operations vmwgfx_driver_f=
ops =3D {
> =20
>  static const struct drm_driver driver =3D {
>  	.driver_features =3D
> -	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM,
> +	DRIVER_MODESET | DRIVER_RENDER | DRIVER_ATOMIC | DRIVER_GEM | DRIVER_CU=
RSOR_HOTSPOT,
>  	.ioctls =3D vmw_ioctls,
>  	.num_ioctls =3D ARRAY_SIZE(vmw_ioctls),
>  	.master_set =3D vmw_master_set,
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index b77f2c7275b7..8303016665dd 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -104,6 +104,15 @@ enum drm_driver_feature {
>  	 * acceleration should be handled by two drivers that are connected usi=
ng auxiliary bus.
>  	 */
>  	DRIVER_COMPUTE_ACCEL            =3D BIT(7),
> +	/**
> +	 * @DRIVER_CURSOR_HOTSPOT:
> +	 *
> +	 * Driver supports and requires cursor hotspot information in the
> +	 * cursor plane (e.g. cursor plane has to actually track the mouse
> +	 * cursor and the clients are required to set hotspot in order for
> +	 * the cursor planes to work correctly).
> +	 */
> +	DRIVER_CURSOR_HOTSPOT           =3D BIT(8),
> =20
>  	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
> =20
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 966912053cb0..91cf7f452f86 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -228,6 +228,18 @@ struct drm_file {
>  	 */
>  	bool is_master;
> =20
> +	/**
> +	 * @supports_virtualized_cursor_plane:
> +	 *
> +	 * This client is capable of handling the cursor plane with the
> +	 * restrictions imposed on it by the virtualized drivers.
> +	 *
> +	 * This implies that the cursor plane has to behave like a cursor
> +	 * i.e. track cursor movement. It also requires setting of the
> +	 * hotspot properties by the client on the cursor plane.
> +	 */
> +	bool supports_virtualized_cursor_plane;
> +
>  	/**
>  	 * @master:
>  	 *


--Sig_/dn7NARskuHFZfslN0/I+jRo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmSamzoACgkQI1/ltBGq
qqev5w//bf7LGYapeDrkT7Kx5Wn2+3er1WUXQw0qS2wzQsju36GQD0vreWuKNiK+
try/OSwHPEUFxwlsaBJ97ovqnb+P8EvxLHVe2Qa2feOoKgVY/HO5JvZiDMUT6ZIp
gBH4UHeAdfpTIOyiI67Ru7qtWjsGZGamhyYBaD9JC7Qm2oRIBxCbCUBHvWmrvSG/
HOzjY0u5CFFtsB1F6TttosUBXwLuGn3FRKp/7KgiBXUR5Q9rKW0r5ncmxRyVLV8H
w5pOjD4BpAnJwvI78Yr/xaoM3+Wty4adawDysKOPA+OGXCWvRh+EkQ25kIXlms9Y
USqq9qGP03dtAKiSjg+CkjYK2PCOPys17xsTFMSWCWU4byuJ0sF6V/S1ckpai2hz
EMLPq/s3MBpWzX4ZeTAq3s4GkIbLeNgW4u1G2EeqG+obWEL7Y3fNGi4/G4BJr6Ue
zYGL4XRMAyCQTtPSr7eXHbW5j2xQxUPWYgPFwgISyeBePxcWqov9IG+gulZOMSOj
2q27CTVIjfYYKztU3JCyRxS8PTamoiDgo/7H+GqTBNRu9eOliapmp2Yo4atVXvE7
p8BBogtHMTPzXpgVoR6NoKThHsTXBo4oC7w0ttQYoDSS811/b/xza4ptScBSqkxL
1IIafFLBw5n/eBrJnQY8D2qaJR6Pj96fr8zB5to46EYwYdKpPXg=
=wBza
-----END PGP SIGNATURE-----

--Sig_/dn7NARskuHFZfslN0/I+jRo--
