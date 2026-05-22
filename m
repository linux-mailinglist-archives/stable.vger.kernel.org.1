Return-Path: <stable+bounces-253733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLN3JgcnEGpQUQYAu9opvQ
	(envelope-from <stable+bounces-253733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:51:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E54D5B17A6
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 379733056DC1
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937283B8BBF;
	Fri, 22 May 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="o/AP2Rr3"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DBE241690;
	Fri, 22 May 2026 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779443329; cv=pass; b=nO8+oLRbT92hjSOvrz3EqbTEfja/g5ND2cBO8rKwLKKEXnqhO+XTHaBtlhHmlBd5l1p1x4BZ05UUs5jSNWE0s2x/66CeHit+U6uuzEatbp6+QkOS2OPuwa3Jgh5eFkVBm8Iblj2Sn9lkLVDweCtk3t2DZlH91rSTWURXYT3O3g4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779443329; c=relaxed/simple;
	bh=MKrPHbrmUoGlxGZ2SDgGz6AFXcZxBmI+bXjSN9etLq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rh3t01wI+RBs86kVZjtSO1BUHHutiorXOG9bhdG2KCi/RtGIvjVfQmsafEHvHV/JvA07WLNmmONUHmD/dTrIah5gHz0DjGI2ooFNr+SR8nLdod496ybSVCtkT4QNHNQPkWlk7+3dte+Pa4H6HVCneEhLIEnab0n4G6/MaOg7yYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=o/AP2Rr3; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1779443311; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lazfF6hyKv13onpMqlIpmfS3/3ipHa3V9U5fySqe3wen4/nHJ19qETquKdunB3wN4kI6FRvuorDY4Ll7Nh98v4ql1ct5uRKbhTQvfYRGn745J8cmcgo1NSFzsM9e2ZwRpbHYZKE5Yoe/Jh4jNxhmgyHGHVKSFumL7fONgznuPKA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779443311; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wupJUne4Ip3bPbjlNU6yymI9fB/aYNmeAim/I7sSyoc=; 
	b=F/+OB4q+qB+IoAVB02pr+W9+9FDXV7K0hcZtfmdE7TqVZomiaHKShUW2+TaOJBYjJJ6kDjJHsbXxqkxTR5zbhLNQPkxAwGMeTIQNYNYigERrvDs9F/1G4yKB7CIQDs0yO7ZI3aPpS7yCACriL9xVsA8yJiy80oV0cLlKvTQXDGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779443311;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=wupJUne4Ip3bPbjlNU6yymI9fB/aYNmeAim/I7sSyoc=;
	b=o/AP2Rr3GswutLS6MvF4DYn0seIjOGAc5VJGM16aeQyTKMoNLNNRp18cKfeElId1
	mHJqwBO2T+Ha0leIImYvf8MAQ8tUdHo3Osz3ZZjMoY3QqoIjzcGjqm2ktVYnoU3J0Aq
	zcxPHKb4TrcaWHFz+PrN3zAAvoQgvRX8zcASE73/yBVnWFTCPEk4hbHD17l3Qe/Wm5/
	wZkFTsA7aczEWt9H9CaL6KZM8XtEX9VsuMLakG8a58qpO2tVRBs1rrhfFOO87Fo1tb8
	zdvjYBhw7erQHzVt0hpY4RV//CMhx0M7fCL9DQOsY4J38fnkSqpdJB+MyobKMRAEIdy
	AvLW8J/a1g==
Received: by mx.zohomail.com with SMTPS id 1779443308314935.8685400434817;
	Fri, 22 May 2026 02:48:28 -0700 (PDT)
Message-ID: <91204e5642937692912f5a0f73ec4928c089a403.camel@icenowy.me>
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
From: Icenowy Zheng <uwu@icenowy.me>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Jani Nikula	
 <jani.nikula@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas
 Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>,  Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Fri, 22 May 2026 17:48:21 +0800
In-Reply-To: <874533c1-716d-4c96-aa6f-87ab04c5f617@linux.intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
	 <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
	 <7b49ae842c07a0437e6851aae944003785ef31a3.camel@icenowy.me>
	 <874533c1-716d-4c96-aa6f-87ab04c5f617@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-253733-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[uwu@icenowy.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[icenowy.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,icenowy.me:mid,icenowy.me:dkim,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 0E54D5B17A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E5=9C=A8 2026-05-22=E4=BA=94=E7=9A=84 11:23 +0200=EF=BC=8CMaarten Lankhors=
t=E5=86=99=E9=81=93=EF=BC=9A
> Hey,
>=20
> Den 2026-05-19 kl. 13:29, skrev Icenowy Zheng:
> > =E5=9C=A8 2026-05-19=E4=BA=8C=E7=9A=84 12:41 +0300=EF=BC=8CJani Nikula=
=E5=86=99=E9=81=93=EF=BC=9A
> > > On Tue, 19 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > wrote:
> > > > Currently the implementaion of
> > > > drm_client_modeset_wait_for_vblank()
> > > > assumes drm_vblank_get() will fail when the CRTC isn't active.
> > > > However
> > > > it seems that this is not true, and running fbcon on a device
> > > > with
> > > > the
> > > > first CRTC inactive will lead to kernel warning in some cases
> > > > (which
> > > > could be reproduced with the loongson driver).
> > > >=20
> > > > Change the implementation to add a check for the active state
> > > > (atomic) /
> > > > enabled state (non-atomic) before calling drm_vblank_get(). As
> > > > the
> > > > assumption of drm_vblank_get() failing for inactive CRTC isn't
> > > > met,
> > > > the
> > > > error status of drm_vblank_get() can now be exported too.
> > > >=20
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker
> > > > with
> > > > vblank")
> > > > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
> > > > =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/drm_client_modeset.c
> > > > b/drivers/gpu/drm/drm_client_modeset.c
> > > > index bb49b8361271a..1b03bf351256e 100644
> > > > --- a/drivers/gpu/drm/drm_client_modeset.c
> > > > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > > > @@ -1310,7 +1310,7 @@ int
> > > > drm_client_modeset_wait_for_vblank(struct
> > > > drm_client_dev *client, unsigned i
> > > > =C2=A0{
> > > > =C2=A0	struct drm_device *dev =3D client->dev;
> > > > =C2=A0	struct drm_crtc *crtc;
> > > > -	int ret;
> > > > +	int ret =3D 0;
> > > > =C2=A0
> > > > =C2=A0	/*
> > > > =C2=A0	 * Rate-limit update frequency to vblank. If there's a
> > > > DRM
> > > > master
> > > > @@ -1326,15 +1326,24 @@ int
> > > > drm_client_modeset_wait_for_vblank(struct drm_client_dev
> > > > *client,
> > > > unsigned i
> > > > =C2=A0	 * Only wait for a vblank event if the CRTC is
> > > > enabled,
> > > > otherwise
> > > > =C2=A0	 * just don't do anything, not even report an error.
> > > > =C2=A0	 */
> > >=20
> > > I'll dodge the question whether the change below is right or not,
> > > but
> > > for sure the comment above needs to be amended to match the
> > > change.
> >=20
> > If the change is right, it perfectly matches what the comment above
> > is
> > saying -- it's the current behavior that does not match the
> > comment.
> >=20
> > Thanks,
> > Icenowy
> I would rather have expected drm_fb_helper_ioctl to fail like you
> mention.
> Probably needs a fbcon_is_active() there to prevent it.
>=20
> The damage helper should not be triggered if no CRTC is active, so
> that means
> the check here is slightly too late.

Well the problem here seems to be a CRTC is active, but it's not CRTC 0
(for embedded hardwares CRTCs could be somehow fixed and tied to
physical ports); and the fbdev helpers hardcode 0 as the CRTC ID.

Thanks,
Icenowy

>=20
> Can you fix it at a different level, like damage helper or its
> callers instead?
>=20
> I believe when the client gets suspended, all the pending damage is
> flushed before
> suspend.
>=20
> Kind regards,
> ~Maarten Lankhorst

