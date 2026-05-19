Return-Path: <stable+bounces-249560-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDAuCQpNDGrjdQUAu9opvQ
	(envelope-from <stable+bounces-249560-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:44:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646857DE66
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F6883042229
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22536680C;
	Tue, 19 May 2026 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="TuR/+cE0"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5373002BB;
	Tue, 19 May 2026 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190201; cv=pass; b=LWsIZv/f77crCPlANxPfpqj62RceVkl3iu0/QJSbGSGZ2H7CUfF7uUOL6+vhO/qVTOIqUh0ueOYP1EzE8NAvlLvAc/NKkrdsnmAHHI7lM5iVJP0hSfopV7LfOAgl3PlWV31/BMT6fAn7ePrxwdFGo2DSBrAmUSpCFYdayO2CHbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190201; c=relaxed/simple;
	bh=XVgXj8Tszmepy4d5wIEbEfFNceqfhk6Kru6Hjlmco1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nL9AGZtwcHoPlVQOLSxPl9a3DeN6LjOs4YMihEu6nEbLPhBytk+HNHoGTuieyqkhG9mOLJ7u6/AHy2SrPcvlCoy8M2ijXDBGtNiicgX6or+M0R/gwP7SjQ2CBnjgnJPXJla0CPuH7nQP6ItYWCaq+0jGRbA8PzksIrz/Qjf15Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=TuR/+cE0; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1779190186; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dyeKZ0M1kWsWaYXB/7WcHP+gyv7GguWHBp54aZ+mK4IpW6TjJHj4DZuG2nl2K7ROR2tgMm95hl04wVFOqaFtdi78Y+TJ3z7U5Udoh1k3tI9hKZABK3VeA3XX9WEGDEnt/W/ocOBze36ZnCk9L6zur9o6CKiyAKbHU56VDf3sans=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779190186; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=a21y7ylbJXMSnfljwvz1osdThtDDH25yBXqtvFOA67k=; 
	b=ZH47nl5zor2lKb6QwkJ1AVcjSAflDN947dg4QcS6NttsKv5/10qK+Pv2SQossIAQBrfoq8+cEOIfDX6Z3/GMfZk0wa5k2bJx1mJDPlxMElTc0XPzTnfKDA2imU+dnOw5McQAO0y4PmHBWwgklxj8LvFTo9ObTKU8Y03iXqnZUO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779190186;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=a21y7ylbJXMSnfljwvz1osdThtDDH25yBXqtvFOA67k=;
	b=TuR/+cE02QEEbcM2MyCuO/oYImS84pmWGp1CI+a69QZtUkOqgwI8cdqUs2i6T83e
	bgvW0oXoxxMNLLxFg2sno4K19S8YrGn9i/RnwyueH453T0a2ks/VB55w9/ET3h6T0sV
	xacsp0Wdao7+0YWWl7zq2t+Gt02ttTNQnbspoh8ZtErNcwpNf9wwCGUWunAEVApiKwx
	o6iHedJeUfnuRbrpazlbQ0vWsvHsZiy7NLp9OKrQ5oYJAMOyt8DSHP9CDVlhwG2tGsG
	3rg1yVjEs/v5yMtOP5Q8SEt2oPGYbxjX5mebf30JPOeBmr2FsgxFVRWsAEGGlQ2DcdF
	iSnBp80deg==
Received: by mx.zohomail.com with SMTPS id 1779190183865602.4770060891767;
	Tue, 19 May 2026 04:29:43 -0700 (PDT)
Message-ID: <7b49ae842c07a0437e6851aae944003785ef31a3.camel@icenowy.me>
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
From: Icenowy Zheng <uwu@icenowy.me>
To: Jani Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 19 May 2026 19:29:33 +0800
In-Reply-To: <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
	 <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-249560-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[uwu@icenowy.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[icenowy.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,icenowy.me:mid,icenowy.me:dkim]
X-Rspamd-Queue-Id: 2646857DE66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

=E5=9C=A8 2026-05-19=E4=BA=8C=E7=9A=84 12:41 +0300=EF=BC=8CJani Nikula=E5=
=86=99=E9=81=93=EF=BC=9A
> On Tue, 19 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> > Currently the implementaion of drm_client_modeset_wait_for_vblank()
> > assumes drm_vblank_get() will fail when the CRTC isn't active.
> > However
> > it seems that this is not true, and running fbcon on a device with
> > the
> > first CRTC inactive will lead to kernel warning in some cases
> > (which
> > could be reproduced with the loongson driver).
> >=20
> > Change the implementation to add a check for the active state
> > (atomic) /
> > enabled state (non-atomic) before calling drm_vblank_get(). As the
> > assumption of drm_vblank_get() failing for inactive CRTC isn't met,
> > the
> > error status of drm_vblank_get() can now be exported too.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with
> > vblank")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> > =C2=A0drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
> > =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c
> > b/drivers/gpu/drm/drm_client_modeset.c
> > index bb49b8361271a..1b03bf351256e 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct
> > drm_client_dev *client, unsigned i
> > =C2=A0{
> > =C2=A0	struct drm_device *dev =3D client->dev;
> > =C2=A0	struct drm_crtc *crtc;
> > -	int ret;
> > +	int ret =3D 0;
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Rate-limit update frequency to vblank. If there's a DRM
> > master
> > @@ -1326,15 +1326,24 @@ int
> > drm_client_modeset_wait_for_vblank(struct drm_client_dev *client,
> > unsigned i
> > =C2=A0	 * Only wait for a vblank event if the CRTC is enabled,
> > otherwise
> > =C2=A0	 * just don't do anything, not even report an error.
> > =C2=A0	 */
>=20
> I'll dodge the question whether the change below is right or not, but
> for sure the comment above needs to be amended to match the change.

If the change is right, it perfectly matches what the comment above is
saying -- it's the current behavior that does not match the comment.

Thanks,
Icenowy

>=20
> (Please wait for other review comments before sending another version
> with the comment changed.)
>=20
> BR,
> Jani.
>=20
> > +	if (drm_drv_uses_atomic_modeset(dev)) {
> > +		if (!crtc->state || !crtc->state->active)
> > +			goto out;
> > +	} else {
> > +		if (!crtc->enabled)
> > +			goto out;
> > +	}
> > +
> > =C2=A0	ret =3D drm_crtc_vblank_get(crtc);
> > =C2=A0	if (!ret) {
> > =C2=A0		drm_crtc_wait_one_vblank(crtc);
> > =C2=A0		drm_crtc_vblank_put(crtc);
> > =C2=A0	}
> > =C2=A0
> > +out:
> > =C2=A0	drm_master_internal_release(dev);
> > =C2=A0
> > -	return 0;
> > +	return ret;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);

