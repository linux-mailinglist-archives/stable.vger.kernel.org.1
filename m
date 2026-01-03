Return-Path: <stable+bounces-204537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A432CF036D
	for <lists+stable@lfdr.de>; Sat, 03 Jan 2026 18:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7AB8301DBBF
	for <lists+stable@lfdr.de>; Sat,  3 Jan 2026 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22025F7A5;
	Sat,  3 Jan 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="QoXZdzOQ"
X-Original-To: stable@vger.kernel.org
Received: from sonic314-19.consmr.mail.gq1.yahoo.com (sonic314-19.consmr.mail.gq1.yahoo.com [98.137.69.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DA61F0994
	for <stable@vger.kernel.org>; Sat,  3 Jan 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767461639; cv=none; b=LDYe1FYwY/N9EreDZ6bfHHz3DSCL+VCpBLxn4NvWRHD+uZ1FgcAGKdwQ1jvoJAfA6DBy+mcf3zJ67FQLu18FSAgG8WDLCc7mUU03wOBAw+2CBUAn4+9/5S0r9KHUt7RFVzVoAgY4f4zpztw8/HhTCW45Mtqext1eysPVxTUX7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767461639; c=relaxed/simple;
	bh=wcdz2Ta83d36gMkeXcDWlgH+vs9y3rQGm74MKM08QOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ftr2W6ie19qCZKjVPOyPx6XNKk/aAXVL9t+WokHFWHNN4lw3bnd9UQbbr+vaZdjtIlrIkHHwmM0YdiI9pqG8o1HFFOANjCTuTrcoMu0XJbTTNLa+mJoTigA3AwKB2JMQT1LTHEPGlTthdnCZXO/dT3bzpaoW467lkIDoIhaWhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=QoXZdzOQ; arc=none smtp.client-ip=98.137.69.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1767461630; bh=/yZC/Vu7GXGQgOFNfK5mq/MazW9h5uJQJc7zq2bO8Rg=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=QoXZdzOQzfyHswcKMoWWWt75Df/13XRzNOOu05ZsswhR0JEopbTOxWHLNF/+2REFVHfbEoxWU3XGTMVQyOtlO+J2xyswPSESqH+fA1Nk+zL3heagfcrX87mLHc9Bmm2VZFc1CshV0fsR9sAY0/JNWOHC5MsUQHxNaJ2c3fu6ziAK39bVsY3HLWle3yA0PyH114QDW2TnEC8c1y3I4yxL1wUuqCq2fonbrFm1dGRaclQY7JerVChytXXa+Lzy77ukAH2+ittBxkhGQ1rwRV67daVeyn7bVjGNFS5TH+7lKWiLGlLTNv6hxeY9G3ofvrJN1M00y8iGYosAV/54U8oEkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1767461630; bh=EkJlw1whD0TaDRkhPa6ZOfuKQNBMGZFCjXBqQ7xSmuJ=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=Ihc4MRHbusEGYYlwC3QYJ4cBdtvYubflEI5gQ73tkMHQ8D9WDYy5H6M58ltQTWjHYI4GBUQhQsrVomWv9YogLkKHj4yO4yOW5pa1n0VkSZ8IT5myVSBg0F612UryA1uZr7c55SKPKxxvzUx2WdmZWSLENYg2rjPwi4+nFWEcPW9bLXV+jOD/4L/2UvpLJ6Af7uh14wjd6O0lOed/0c9qFtRVtZfW0l9xyjeYn8mlsnYejiJA1dslej3ZgAaSQpe4h5POlhpQ7QSDxL5riqq20cjyvaC22NB0GB00xWnhHYHZQLgtJIaeboZi8+/+rpaBHGjolGkMVSMTl559MaWsHg==
X-YMail-OSG: 0bHBdl8VM1mog.gQJfNjrYZBGi_VLskP734xdEh6WHE6LHwxHfqYY.JInnJm4L7
 BoPdVwUxBrmKRmy7AxjlbYnhSn6MCkYZB2xWbC.SsPC2HOpKmFeqXQreTHNI1LbZxt1naXeA_Fcp
 RK.fWzwV9.PtGeTzZI0TB0GqLAz.zaDcO.nIhVW_aV2tq1daChbEUDdlaAowhOAzuCROqO8Mty9B
 U8Skvbcxoa_bvt3Kxj_upnmwOWF87riRkSCV4oqG8fpqGfdkVSwBo6_hYrvfaKDgnQE4uoDvmRr_
 6vzaGyiD_KSwhXl0vrIps4E9MhR2xyv3i9G9lHtwH4Vb9ZjghwS0PTsWcdKA96qKJA6Cf4qZk1Ap
 FAiTmIWuG9O93Q9r.y3fK0zQDst.h8Cvcd1iBpQS9zW.VrqCvMxaXQq.54.f7y3R1GIClybLXAQj
 YWSj6d1LNNru8SDFJ1YGRszkGofITe3hzYWPUSiccX3.otzBgzeVfYICN3JgQCYKlpqgBLeYq.sr
 6NB5UL7zhtp7VDTZXXuEP.iHqON3tBTEA.kLdWra37yf0CPL4KuY_ov33WUPcO1ZiVbrIKE_6hT4
 u2lKo2tn_zHN8srbL7Q6QKcXtDZvuUjnGB04xkynVkLvsXza_lnRM0AG5NHVnVVyJ8He5FzNXSEY
 XpxtbJP9VPij.mc6tKD92.c4oZ4VWzZunWTEbwNKWFKSaJX3mhGyorrZ0YPnSgM2pxPcjYIjBI2o
 Qzhl4Zk2TrWjr4zSVYW6gRjldks1WuiGnUDqSHUK9jkUPWowAmmMjROxNkzlncRWzZNQ47JJORU7
 bJ_oZNuW37.sMCHtuTBJ.fhRCYYBmblQBhQTOKJSx4XMYkLLynguR7BaJdUI51IlAm2mir_PaUhb
 VVdXudWW5B3szBDaaMl_ITrBqfX9NCVTZanBDqqNDSSw56FFpjLsRoVzePy.7cplvbvSFLG_8hAl
 MtgJGz5G04ODFiBAwYKKhUP26juGeIGDqsGGQyvqQn_xn8bzfpRVYpb2egYxj0QdOjoy_UkcK.nA
 4bMM.yMtRgSv8tP0sfgNQyPjQXriovDFKzpKq_CPtBoH3OdIDt4ZCecbNquItLbCzn.CK0Aqv_9P
 tvJ9KAMp0S0TzDWMDEFi9JbtT3IAX7N0CJ.limtNo9gwaDKPi2A8bomMwwCRYPvogIEzEPAZQ2ka
 I6QlfiVf3DrqTRN89eKcFMi21ZKBD8uNK5mosXcUAS9PQqY4wN3sAhU_0b.Fn1lry81qXcaqp6W_
 473TenDY1aecvCbNIeEquuRxhpDH7GkpncabnIjSScjeOxFeXFe.gs6dDCjLAfM81UVCPQv9Noml
 b7b1kDIVGZWkUB5Ykf6mBgcnzursxZJixE3_DLBOuTi6rVHaLRZl7hKko3maugngOqsv77QmODXU
 YcAcAvSjq6MAn.Ii8iscupfTk8cot_RXdx.jKNviRw.JA5HzxFisE0vTKKMeDs_gLxkJoH_x9o7J
 NAgAV2jImBz8pRionwiN5lET8lD30gWzOyv0lJkOZYuK7Z0K2O1zecN7xrbhtPyYJACsvfnjtaf9
 rBs.Kl1VDsD77Ny5FDwhYc4_PtH58I4th42zivw4FLCzcNXfN4sJF8zdHKhB.ZnLh4IgEMt89.eQ
 .dpF0MdCoOKIGzm07nSoyaOZqaytLD7DwI89XqTjRN919ejOycQb_9JGu7EN05z1dxJNxNAErJ9L
 Q0Y6MnuNDfpYU1VLX..T6v0UqorM9zOCzMU7KKwbsTXdaLSb4ybbsmoprlnzJwUUPNNz46w3Gqzt
 VWGyfJnN18jlfjVS.wxkqkBA5GX8vNLt61tM62dkLumGxR.Uu6DQSNS7QlEa6PJP_nBcK925wEDu
 VulctnbWZ8kV.55zVB9oACb1Pb4t_UtMCpcbkib9388.fk6FByxunV4d3JzU.tmfqryNqvA8dais
 0e_eylKRbENq1Ql06Xqr_gyKrBGTHTSRd69J7A9gL41Xkb6_CELICY71EU8.ioT4JyyUl1q_gJGl
 wplAQvijy0NLqtRL7FjR8E8vjgqSFS9xl2rH7XmSppwQz_.R4dlpyHR_wQve1EoN7d2FbANUjg8R
 x31lClaCCDW8.5AkgXB1FL._oOuTychtTPnXAHsEo0gWxFSL6B7Vb9BezWN.ocyojbP_cTWPsYbQ
 ubiyClC0U9Q7YcU6d2JD7sxuYLObN2uIG5s_fuvr0L.RXHhTbZNykM1bAne5sl7VQJuLiCS7yycq
 wIX1UJKWL.UB1bLvOCIp6UpzotqFHdyC7RQuShWntxeqEfLlcJvM-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: d02ed7d7-aa03-4199-a132-24f7094f6d19
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Sat, 3 Jan 2026 17:33:50 +0000
Received: by hermes--production-ir2-7679c5bc-pdjpz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 20535d56e29c56e21416a5f8b8c3cca0;
          Sat, 03 Jan 2026 17:23:40 +0000 (UTC)
Message-ID: <28c39f1979452b24ddde4de97e60ca721334eb49.camel@aol.com>
Subject: Re: [PATCH] drm/gud: fix NULL fb and crtc dereferences on USB
 disconnect
From: Ruben Wauters <rubenru09@aol.com>
To: Shenghao Yang <me@shenghaoyang.info>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Sat, 03 Jan 2026 17:23:33 +0000
In-Reply-To: <20251231055039.44266-1-me@shenghaoyang.info>
References: <20251231055039.44266-1-me@shenghaoyang.info>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-oIQ2Px4V9fc0bYCd3CpQ"
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.24866 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol


--=-oIQ2Px4V9fc0bYCd3CpQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, 2025-12-31 at 13:50 +0800, Shenghao Yang wrote:
> On disconnect drm_atomic_helper_disable_all() is called which
> sets both the fb and crtc for a plane to NULL before invoking a commit.
>=20
> This causes a kernel oops on every display disconnect.
>=20
> Add guards for those dereferences.
>=20
> Cc: <stable@vger.kernel.org> # 6.18.x
> Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
> ---
>  drivers/gpu/drm/gud/gud_pipe.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pip=
e.c
> index 76d77a736d84..4b77be94348d 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -457,27 +457,20 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>  	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
>  	struct drm_plane_state *new_plane_state =3D drm_atomic_get_new_plane_st=
ate(state, plane);
>  	struct drm_crtc *crtc =3D new_plane_state->crtc;
> -	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc_state *crtc_state =3D NULL;
>  	const struct drm_display_mode *mode;
>  	struct drm_framebuffer *old_fb =3D old_plane_state->fb;
>  	struct drm_connector_state *connector_state =3D NULL;
>  	struct drm_framebuffer *fb =3D new_plane_state->fb;
> -	const struct drm_format_info *format =3D fb->format;
> +	const struct drm_format_info *format;
>  	struct drm_connector *connector;
>  	unsigned int i, num_properties;
>  	struct gud_state_req *req;
>  	int idx, ret;
>  	size_t len;
> =20
> -	if (drm_WARN_ON_ONCE(plane->dev, !fb))
> -		return -EINVAL;
> -
> -	if (drm_WARN_ON_ONCE(plane->dev, !crtc))
> -		return -EINVAL;

With the elimination of these two WARN_ON_ONCEs, it's possible that
crtc_state may not be assigned below, and therefore may be read/passed
to functions when it is NULL (e.g. line 488). Either protection for a
null crtc_state should be added to the rest of the function, or the
function shouldn't continue if crtc is NULL.

Ruben
> -	crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
> -
> -	mode =3D &crtc_state->mode;
> +	if (crtc)
> +		crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
> =20
>  	ret =3D drm_atomic_helper_check_plane_state(new_plane_state, crtc_state=
,
>  						  DRM_PLANE_NO_SCALING,
> @@ -492,6 +485,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
>  	if (old_plane_state->rotation !=3D new_plane_state->rotation)
>  		crtc_state->mode_changed =3D true;
> =20
> +	mode =3D &crtc_state->mode;
> +	format =3D fb->format;
> +
>  	if (old_fb && old_fb->format !=3D format)
>  		crtc_state->mode_changed =3D true;
> =20
> @@ -598,7 +594,7 @@ void gud_plane_atomic_update(struct drm_plane *plane,
>  	struct drm_atomic_helper_damage_iter iter;
>  	int ret, idx;
> =20
> -	if (crtc->state->mode_changed || !crtc->state->enable) {
> +	if (!crtc || crtc->state->mode_changed || !crtc->state->enable) {
>  		cancel_work_sync(&gdrm->work);
>  		mutex_lock(&gdrm->damage_lock);
>  		if (gdrm->fb) {

--=-oIQ2Px4V9fc0bYCd3CpQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmlZUJYACgkQ0n5QwFCu
DOGDXhAAokLQ4FMSDE1nAVWQDxV8Y7KUeo0gh/h7koWcGdUuupE/mbyEMZz1jaNr
kX1P8fDMRY6VJjE+UpPFxP3wBifshGkrPVdzQ5nDDjHV6sXY7rhSBVpeVq/cis/i
w/5UFu6WvZkDd5GHbTPuG9RPUvPKoeUg6qCIXuP5WskjzB/WzAWU3/Pw6+o2Ho/B
GrIqA5UfdMZWsdxtJfsiRHXr/alOsi80qgyqqPlxki5BRNykne9STHO4YPJIiieE
cgiJ+hS0CS9Mh3wHna32oqlwLeOBYYNWpsItIVIyouAnplWPQxWZ6f9OIK3VY3Kl
U1S1nGhTuVnZPUz9BJwRiB0uRHg3UraNf/jJxkhfXlaTRpFCKrmHH0oHsOtYyS4G
nJWcYXbw59m4nlzl12TvlBvdyLzlUrU5yHAoGYyvSAPUkW1p348wxw8UAXrry3Cq
x2V/okH3NNW790EV5Mx5YRfLKCbuFmfBSordlsUh5knMmEmgg8nkipGYnzYUjJ3O
X/BtfKF/pTp6IzR6Wp/9rYEYZlNfjYToXadeu6jKArrwf1w7r4Q9mqVF2h2zHr2c
W6oJu3bwGisfPyIVX9+IuBLQmm6DjR4qyetVFdSj+OePTgJy03Fion5HrdAhv/zH
2A9xaZBTVdHHrnz3qa8Hgfj5pDMmZ2GQF08SdLxrGFBTUNHfa1E=
=O94+
-----END PGP SIGNATURE-----

--=-oIQ2Px4V9fc0bYCd3CpQ--

