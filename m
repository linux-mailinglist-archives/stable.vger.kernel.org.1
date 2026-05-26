Return-Path: <stable+bounces-254275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJt9OXFXFWqmUQcAu9opvQ
	(envelope-from <stable+bounces-254275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:18:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBD95D2576
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A84A3015CAD
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0583C3C0E;
	Tue, 26 May 2026 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Wuq0HNWI"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB53B9D9E;
	Tue, 26 May 2026 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779783532; cv=pass; b=FThzyBDpjvra/KiQDhwizVvPX82mMCB09/R7TO9/dGH4DbjTVnjr8Or+zciCRWrLnVlu2n2vdaAjo5CuW+IfFlzQxyk+i6Sppe6WQdoNISkAepUkPZY5MlqnG3D+rPUNiSiAGT/XfR/7syUhgijZNtJ8wEEjmDM/qntmiM/8Pko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779783532; c=relaxed/simple;
	bh=pK6L1GzooHbxBV3/tusQ/1ATYI9S8OXSF73Z6YpE6tQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JUU2ynAoyW9vAISJ2jabZ1WKj8k4nqDWK0YX1xustdP2QjS1D8cm2CjaaxSvJGuti6JDpKimilYbC3u1Vrs/NYm+V/4ZD4kz61DQYDjMy1z4CkU/jd2V1REimsHv6GDEVI62fHvKwYdh670NeG6lzDQfjuPzeMGlM7lZZjdJ9R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=Wuq0HNWI; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1779783515; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FWZ2tYymJfyIfly1WlPJXKZgBvoXqNA/WEM7NYQE6cT6/PhQ0AQzAQDVCE9LG1XRoFuqbkNgL5kugLKYC0whqISUtDp+mIZqMKqvoHDpRXbglLd/NdJrRgYsPQUbwSoxAAZ60K6BS+OIess6NKtJMg/N6pJk7y4vKBv2Z0hZhPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779783515; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VxdYd1cKkV0EdIWlixskBAMHzoXvyNtx9ZGHc6qepk8=; 
	b=MOTzvRekXYnFgo18gwlhZ6E8iyxs9PBQEY3q33hHnkea/UEbmFK8pKxJDqN8CAHFtrRMVevVcUNato+rrPsgKswLArjqwYXrTTgEnnjcAKFCYIodvBjyIzxtXSph0OQYvJTAEpy7uHBibAxmLLv2jkHomMqe9psMxKnHectcKAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779783515;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=VxdYd1cKkV0EdIWlixskBAMHzoXvyNtx9ZGHc6qepk8=;
	b=Wuq0HNWIK3LpgkbB/KUjGhGHyg8nK/KT2+H6BS3+34imCG/2C4OMkjyXdYUsCSTE
	gkaGLSQ9hi4CyDduXKqKaoyw/2d2ug45rkaFW48Hp9tmb0PmOG+/oYX2A0H1kJr73cD
	AP9VQUFXoSYj+2EzZx7zn2KCuH9olUYTXQ06xLMYK/L/AnZCscKi0yC0d/ByCyr0o5H
	ZAS4zZkZxlfx6xphon039Gy9q1q4qWc5R+cQJTKFmbL6A3LRgMOtfLOfFLlskVqn3K+
	pNn/WbdUST94/jOsTFV26SShtiDRKvShOuq1EhuxODv0TNbUKkaEjrx2M9EIdiSou67
	mzwcm8NEhA==
Received: by mx.zohomail.com with SMTPS id 177978351302433.27254888770108;
	Tue, 26 May 2026 01:18:33 -0700 (PDT)
Message-ID: <da7033ca1c9a5fbce6b48ad684644c56c366a74b.camel@icenowy.me>
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
From: Icenowy Zheng <uwu@icenowy.me>
To: Thomas Zimmermann <tzimmermann@suse.de>, Ville
 =?ISO-8859-1?Q?Syrj=E4l=E4?=
	 <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
	 <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 26 May 2026 16:18:12 +0800
In-Reply-To: <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
	 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
	 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[icenowy.me,none];
	R_DKIM_ALLOW(-0.20)[icenowy.me:s=zmail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,ravnborg.org,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254275-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[icenowy.me:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[uwu@icenowy.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 3CBD95D2576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E5=9C=A8 2026-05-22=E4=BA=94=E7=9A=84 15:24 +0200=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 22.05.26 um 15:13 schrieb Ville Syrj=C3=A4l=C3=A4:
> > On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
> > > Hi
> > >=20
> > > Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
> > > > Currently the implementaion of
> > > > drm_client_modeset_wait_for_vblank()
> > > > assumes drm_vblank_get() will fail when the CRTC isn't active.
> > > > However
> > > > it seems that this is not true, and running fbcon on a device
> > > > with the
> > > > first CRTC inactive will lead to kernel warning in some cases
> > > > (which
> > > > could be reproduced with the loongson driver).
> > > >=20
> > > > Change the implementation to add a check for the active state
> > > > (atomic) /
> > > > enabled state (non-atomic) before calling drm_vblank_get(). As
> > > > the
> > > > assumption of drm_vblank_get() failing for inactive CRTC isn't
> > > > met, the
> > > > error status of drm_vblank_get() can now be exported too.
> > > >=20
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker
> > > > with vblank")
> > > > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > > ---
> > > > =C2=A0=C2=A0 drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++-=
-
> > > > =C2=A0=C2=A0 1 file changed, 11 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/drm_client_modeset.c
> > > > b/drivers/gpu/drm/drm_client_modeset.c
> > > > index bb49b8361271a..1b03bf351256e 100644
> > > > --- a/drivers/gpu/drm/drm_client_modeset.c
> > > > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > > > @@ -1310,7 +1310,7 @@ int
> > > > drm_client_modeset_wait_for_vblank(struct drm_client_dev
> > > > *client, unsigned i
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0	struct drm_device *dev =3D client->dev;
> > > > =C2=A0=C2=A0=C2=A0	struct drm_crtc *crtc;
> > > > -	int ret;
> > > > +	int ret =3D 0;
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0	/*
> > > > =C2=A0=C2=A0=C2=A0	 * Rate-limit update frequency to vblank. If the=
re's a
> > > > DRM master
> > > > @@ -1326,15 +1326,24 @@ int
> > > > drm_client_modeset_wait_for_vblank(struct drm_client_dev
> > > > *client, unsigned i
> > > > =C2=A0=C2=A0=C2=A0	 * Only wait for a vblank event if the CRTC is
> > > > enabled, otherwise
> > > > =C2=A0=C2=A0=C2=A0	 * just don't do anything, not even report an er=
ror.
> > > > =C2=A0=C2=A0=C2=A0	 */
> > > > +	if (drm_drv_uses_atomic_modeset(dev)) {
> > > > +		if (!crtc->state || !crtc->state->active)
> > > > +			goto out;
> > > > +	} else {
> > > > +		if (!crtc->enabled)
> > > > +			goto out;
> > > > +	}
> > > > +
> > > This part is good.
> > Locking is missing.
>=20
> Ok
>=20
> >=20
> > > > =C2=A0=C2=A0=C2=A0	ret =3D drm_crtc_vblank_get(crtc);
> > > > =C2=A0=C2=A0=C2=A0	if (!ret) {
> > > > =C2=A0=C2=A0=C2=A0		drm_crtc_wait_one_vblank(crtc);
> > > > =C2=A0=C2=A0=C2=A0		drm_crtc_vblank_put(crtc);
> > > > =C2=A0=C2=A0=C2=A0	}
> > > > =C2=A0=C2=A0=20
> > > > +out:
> > > > =C2=A0=C2=A0=C2=A0	drm_master_internal_release(dev);
> > > > =C2=A0=C2=A0=20
> > > > -	return 0;
> > > > +	return ret;
> > > But this isn't. There can be CRTCs without any vblank at all. We
> > > still
> > > want to fail silently for them. So we still have to return 0
> > > here.
> > >=20
> > > Having set this, fixing this helper is only partially what you
> > > want.
> > > Since your device has vblanking, the emulation should check on
> > > the
> > > correct CRTC. IOW you need to pass the right CRTC index at
> > >=20
> > > https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_=
fb_helper.c#L237
> > > https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_=
fb_helper.c#L920
> > >=20
> > > I'm not quite sure how to support this. The CRTC is under
> > > fb_helper->client.modesets.crtc. You'd have to figure out which
> > > is the
> > > relevant one and use that. But that's also not so great, as fbdev
> > > ioctls
> > > only support CRTC 0. Doing internal re-mappings only complicates
> > > matters.
> > >=20
> > > But why does your HW use CRTC 1 in the first place.
> > Could be eg. the enabled outputs can't be driven with CRTC 0.
> >=20
> > I guess what you want to do is pick the first crtc from modesets[]
> > which is enabled. Or perhaps even "pick the Nth enabled crtc from
> > modesets[] based on the ioctl argument".
>=20
> The enable-status of each CRTC could change later on, which might
> lead=20

Well, maybe it's too difficult for things like fbdev to support
hotplugging outputs.

Maybe just use crtcs from modeset[] and check its enable status before
doing vblank wait, and have the vsync waiting falling back to nothing
when the initial CRTC of it isn't now enabled?

This will at least make some usages of fbdev work and restrict the
failure for other usages (e.g. doesn't enable vblank on a not enabled
CRTC).

Thanks,
Icenowy

> to problems.=C2=A0 Picking the one CRTC/output with the lowest spec and=
=20
> mirroring it to the others might work. This CRTC would then be the
> one=20
> to wait for.
>=20
> Best regards
> Thomas
>=20
> >=20

