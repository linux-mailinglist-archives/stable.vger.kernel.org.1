Return-Path: <stable+bounces-267879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n82pI180Omrz3wcAu9opvQ
	(envelope-from <stable+bounces-267879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:23:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDCA6B4D15
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=goldelico.com header.s=strato-dkim-0002 header.b=MOy7wTf6;
	dkim=pass header.d=goldelico.com header.s=strato-dkim-0003 header.b=pQkK9W2U;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267879-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267879-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=goldelico.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2B2303A66E
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 07:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C13E3C4B89;
	Tue, 23 Jun 2026 07:22:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2ED30F526;
	Tue, 23 Jun 2026 07:22:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199375; cv=pass; b=Xw25sqLLY53DGnM+vKNihECyiQgunkZFoIgVEcqZeklnMq6/J0X0v+bJYXuUqeSpp6mURKzOYXT6DB98wjKKERyJFE/v8sUnVALGiEK1/0PCvUq9HNHY6CMmvwLz83vH9T3c12fv9j11uLfAIoZWO638GonmLglZxtnpP1NrePY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199375; c=relaxed/simple;
	bh=OjzHYqufZLcWP0X57NtIgnbS6S5FI0/hDMnsUlAfGeg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l4fDyeOJkWvN9KR1rV7Rr9SyX6B4elD1lNtW2Bui6cED7oXAhjk8fLCx+3QKluYlwfUHj61fOuusQOsWPdKWIGxWnyywn/1zBToG3cTrWYCfnetIEZcnKhBQoBC3RBTgw7YLL1rdlblQ7Ml705LTFg+ZW0c0LJt3TgxdrBNrnEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=goldelico.com; spf=pass smtp.mailfrom=goldelico.com; dkim=pass (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=MOy7wTf6; dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b=pQkK9W2U; arc=pass smtp.client-ip=81.169.146.165
ARC-Seal: i=1; a=rsa-sha256; t=1782199331; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sk2421s3Yyab9h4B8cgsnB189bbJvJcbhRpkJYFkBTxXDlG1GSU7XA1q8l8VTcnfZe
    Y5OSTBBFmvYLhawUAkkBQmH36NlZpivGW4OQSkC10pzHHDZkNOEkOSJjopBBK6T07aRC
    Ee8BsZsNKlFobp85SMPZ1VqVzy0ZwpHywv26N23f7x7RsS7C+2cePZRJbnI7MtGj0FUS
    hzmSXEm58CGwFPkvd2+OlkHOZKxaUN5wlaLklbTveEu8m5nGILPZEETLJVHIQwVBNBv4
    j7qNCeYRXZmJ5QQSDi87fZwrEAONoshiWhrujzbmjcDoXHSmkI18wMnKGOarhRziQgEJ
    rIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1782199331;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=WTYAouhypkSMMbUqkmiovoMH0bMziRxtmsQeKkczqhw=;
    b=GLliX+TRc0SeHVl2jxQY5V9OT68L1bflDDI+wCRYWy2+B9mbpE0uJ+3RV9FGwrDf8/
    1JJomg4PneJy3hBN2OgPv1sebM26V2hPPO9jprJ7D2mL7NP0Km1GJQaPVUQ9HsKa8vbv
    yvD5wLGW3sUnS3zyYsvC6qojkzpfQcwJUz7zP/akw8cd8o4L4QvDxZfsv3nOJq45GPJB
    8gqBlhcaPln9iPdrXOlGEbFMkSw068ZkXFz18JSpFwRUg53XosvQSkLC2vMEBS0Rxawx
    c6HhzpEP3v/ZKi2OD9MprwTMgO2quN6phu6jZftEzh5iSextU3TcrDVYP46NTrCraa8X
    dsVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782199331;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=WTYAouhypkSMMbUqkmiovoMH0bMziRxtmsQeKkczqhw=;
    b=MOy7wTf6LEJl2fAWaBzYrkVlE4ae7vwWnSLQQoitxTFss67JifKatvDQ3LYYpd2qxs
    9K68x/wMA2kfaVMm7OdK3ROVbztViHZ4lxBGtb9dNUS3MXvABSykmL2t4HcnRRGw9CMC
    8OsvTbrCNE8CpXOh19M2D68Zz7LSx+S4SKaXK8MYSTQ3755rPC3QbDShoAR5CH6QC9kF
    pDSJES5GzPHyofZJ1wHAW6AN7feKiGWSPPG6+C5PzzRs1VMon9IUTS5SWwi/q40D0cIh
    UmkHZ0t70+WSmFKCY7befGZxn1or4dy/ValtuHrLYy/htCJULd621qTIlVefMxnvRDE8
    L5Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782199331;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=WTYAouhypkSMMbUqkmiovoMH0bMziRxtmsQeKkczqhw=;
    b=pQkK9W2UDkonRrzqGHC9xllTFrZuRLYYfnn5IE5TgIzY1er79izhIoGMZyqMyh1fjG
    1ypa0FMmCSv1PH6eKmCA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT3ppdzsiNsOz5aTA7oOYU7otmLOEb1cQTmFAp"
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Qcf97c25N7MAvdX
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 23 Jun 2026 09:22:10 +0200 (CEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH v2] drm/fb-helper: Only consider active CRTCs for vblank
 sync
From: "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20260622113434.682292-1-tzimmermann@suse.de>
Date: Tue, 23 Jun 2026 09:22:00 +0200
Cc: zhengxingda@iscas.ac.cn,
 maarten.lankhorst@linux.intel.com,
 mripard@kernel.org,
 airlied@gmail.com,
 simona@ffwll.ch,
 akemnade@kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org,
 kernel@pyra-handheld.com,
 sashiko-reviews@lists.linux.dev,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <685F8D2B-84D9-45AD-A979-CFDE71F7E9F2@goldelico.com>
References: <20260622113434.682292-1-tzimmermann@suse.de>
To: Thomas Zimmermann <tzimmermann@suse.de>
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[goldelico.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[goldelico.com:s=strato-dkim-0002,goldelico.com:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267879-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhengxingda@iscas.ac.cn,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:akemnade@kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:letux-kernel@openphoenux.org,m:kernel@pyra-handheld.com,m:sashiko-reviews@lists.linux.dev,m:stable@vger.kernel.org,m:tzimmermann@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hns@goldelico.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[iscas.ac.cn,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,openphoenux.org,pyra-handheld.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hns@goldelico.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[goldelico.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDDCA6B4D15



> Am 22.06.2026 um 13:33 schrieb Thomas Zimmermann =
<tzimmermann@suse.de>:
>=20
> Only synchronize fbdev output to the vblank of an active CRTC. Go over
> the list of CRTCs and pick the first that matches. Fixes warnings as
> the one shown below
>=20
> [   77.201354] WARNING: drivers/gpu/drm/drm_vblank.c:1320 at =
drm_crtc_wait_one_vblank+0x194/0x1cc [drm], CPU#1: kworker/1:7/1867
> [   77.201354] omapdrm omapdrm.0: [drm] vblank wait timed out on crtc =
0
>=20
> This currently happens if the fbdev output is not on CRTC 0.
>=20
> Atomic and non-atomic drivers require distinct code paths. As for =
other
> fbdev operations, implement both and select the correct one at =
runtime.
>=20
> Not finding an active CRTC is not a bug. Do not wait in this case, but
> flush the display update as before.
>=20
> v2:
> - move look-up code into separate helper
> - support drivers with legacy modesetting
> v1:
> - see =
https://lore.kernel.org/dri-devel/1c9e0e24-9c4a-4259-8700-cf9e5fd60ca3@sus=
e.de/
>=20
> Co-authored-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: d8c4bddcd8bcb ("drm/fb-helper: Synchronize dirty worker with =
vblank")
> Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

Tested-by: H. Nikolaus Schaller <hns@goldelico.com>

> Closes: https://bugs.debian.org/1138033
> Cc: <stable@vger.kernel.org> # v6.19+
> ---
> drivers/gpu/drm/drm_fb_helper.c | 71 ++++++++++++++++++++++++++++++++-
> 1 file changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_fb_helper.c =
b/drivers/gpu/drm/drm_fb_helper.c
> index 7b11a582f8ec..cbf0a9a7b8e5 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -225,16 +225,85 @@ static void drm_fb_helper_resume_worker(struct =
work_struct *work)
> 	console_unlock();
> }
>=20
> +static int find_crtc_index_atomic(struct drm_fb_helper *helper)
> +{
> +	struct drm_device *dev =3D helper->dev;
> +	struct drm_plane *plane;
> +
> +	drm_for_each_plane(plane, dev) {
> +		const struct drm_plane_state *plane_state;
> +		const struct drm_crtc *crtc;
> +
> +		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
> +			continue;
> +
> +		plane_state =3D plane->state;
> +		if (plane_state->fb !=3D helper->fb || =
!plane_state->crtc)
> +			continue; /* plane doesn't display fbdev =
emulation */
> +
> +		crtc =3D plane_state->crtc;
> +		if (!crtc->state->active)
> +			continue;
> +		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
> +			continue; /* driver bug */
> +
> +		return crtc->index;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int find_crtc_index_legacy(struct drm_fb_helper *helper)
> +{
> +	struct drm_device *dev =3D helper->dev;
> +	struct drm_crtc *crtc;
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		struct drm_plane *plane =3D crtc->primary;
> +
> +		if (!crtc->enabled)
> +			continue;
> +		if (!plane || plane->fb !=3D helper->fb)
> +			continue; /* CRTC doesn't display fbdev =
emulation */
> +		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
> +			continue; /* driver bug */
> +
> +		return crtc->index;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int drm_fb_helper_find_crtc_index(struct drm_fb_helper =
*helper)
> +{
> +	struct drm_device *dev =3D helper->dev;
> +	int crtc_index;
> +
> +	mutex_lock(&dev->mode_config.mutex);
> +
> +	if (drm_drv_uses_atomic_modeset(dev))
> +		crtc_index =3D find_crtc_index_atomic(helper);
> +	else
> +		crtc_index =3D find_crtc_index_legacy(helper);
> +
> +	mutex_unlock(&dev->mode_config.mutex);
> +
> +	return crtc_index;
> +}
> +
> static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
> {
> 	struct drm_device *dev =3D helper->dev;
> 	struct drm_clip_rect *clip =3D &helper->damage_clip;
> 	struct drm_clip_rect clip_copy;
> +	int crtc_index;
> 	unsigned long flags;
> 	int ret;
>=20
> 	mutex_lock(&helper->lock);
> -	drm_client_modeset_wait_for_vblank(&helper->client, 0);
> +	crtc_index =3D drm_fb_helper_find_crtc_index(helper);
> +	if (crtc_index >=3D 0)
> +		drm_client_modeset_wait_for_vblank(&helper->client, =
crtc_index);
> 	mutex_unlock(&helper->lock);
>=20
> 	if (drm_WARN_ON_ONCE(dev, !helper->funcs->fb_dirty))
> --=20
> 2.54.0
>=20


