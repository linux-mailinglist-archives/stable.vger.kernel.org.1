Return-Path: <stable+bounces-274741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wcBbL8wlV2qxFwEAu9opvQ
	(envelope-from <stable+bounces-274741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:16:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C4575AE56
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:16:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=igalia.com header.s=20170329 header.b=Ml0hrBmX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274741-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274741-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=igalia.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D88A030088BA
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C693594A;
	Wed, 15 Jul 2026 06:16:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3553A1DB
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 06:16:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096199; cv=none; b=tnJ6v6O+0QrtcrrB3Q2xslZQ8B010YpzdRWnaTo7C00oJUuSn0BPFRXIqhWoRk5qNLGVx/Rx+fZvBuI7LGuaYhwBN6PLFb0Jhuy8ur3DCvIVPBx2ezuvHM59dy3KgKZxrDm8lacYcxArJGZZ/jUQc35dsbd2vAqn9Tz5dXI0qtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096199; c=relaxed/simple;
	bh=H9WRiiQjEONswEkrKbX6jHyE0pLkvTU8h1n7DoA/C6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R7cVPersQLIckwwjTpEwQ3Dum8e/0Ue0z7OiImbw65s+rJUA37texSZaqCBbLQ2q/KNfzUP7PWTWWGEL2gLSCVWvBziMU+aneO0hAnG5Ai4HB7dVOO0i06FQHabeJpLGflovYavsPqMn8vbnnlNrwmuy5FGyUPfgKCDNb4QJWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ml0hrBmX; arc=none smtp.client-ip=213.97.179.56
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
	From:Subject:Message-ID:From:Reply-To;
	bh=QzPGCwr7V9AVee7yhQ+nczZfLMVvubjLDbugo6vaKzk=; b=Ml0hrBmXrzXwzw1PXzlS0wKa8D
	hUmPS3lKyyBkZEE+Mc5eGEdeXxINH9p2DMEjZq5kzBwgloxAbumyui8o3FA9tqFcgotZYTSagcpZ3
	BtbQb126EwgoT71DcmNutNEik725D+2+dqW+s4x5Q8gFHXU7rkYV0ax2BZG94jk827+hfvI2bdRY/
	lNbN1oYuevU4JGcQ6NrOIVwDmFmJToXHMINI+zeqWhMU5CT8sXqPppj0n2xFqHCAQe7qK1fe9cjI1
	zF1oPDfKU13FKH2D+UWgsTDr07UixnNgb85ajopIHItiDoU71uiuusmRbMFvHsIY3kttGrzHrl4iu
	PcUXsllQ==;
Received: from [159.147.19.205] (helo=[192.168.0.17])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wjsuz-00FJvv-74; Wed, 15 Jul 2026 08:16:29 +0200
Message-ID: <e65137e19a8773a2f760531034481e0df60071d4.camel@igalia.com>
Subject: Re: [PATCH] drm/v3d: Widen cache_clean_lock over the whole L2TCACTL
 sequence
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
	 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 08:16:18 +0200
In-Reply-To: <20260707200738.659002-2-mcanal@igalia.com>
References: <20260707200738.659002-2-mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[igalia.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[igalia.com:s=20170329];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-274741-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mcanal@igalia.com,m:mwen@igalia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:kernel-dev@igalia.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[igalia.com,gmail.com,ffwll.ch];
	FORGED_SENDER(0.00)[itoral@igalia.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[itoral@igalia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34C4575AE56

Hi Ma=C3=ADra,

has this change fixed anything?

Also, I believe that GFXH-1897 is exclusive to Pi4. Have you tested if
this change has any visible performance impact on Pi5?

Iago


El mar, 07-07-2026 a las 17:05 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> v3d_clean_caches() and v3d_flush_l2t() both write the single L2TCACTL
> register and poll its status bits. The mutex cache_clean_lock exists
> to
> serialize them, but v3d_clean_caches() only took the lock around its
> final
> FLM_CLEAN write.
>=20
> These functions run concurrently: v3d_flush_l2t() is issued from the
> BIN/RENDER/CSD invalidate path while v3d_clean_caches() runs from the
> CACHE_CLEAN queue, and each queue's scheduler uses its own ordered
> workqueue, so their run_job callbacks execute in parallel.
>=20
> Because clean locked only its final write, a concurrent flush can
> write
> L2TCACTL during clean's unlocked phase. Both use non read-modify-
> write
> writes to the one register, so whichever lands last wins: clean's
> TMUWCF
> write can land on the flush's in-flight L2TFLS invalidate, triggering
> the
> GFXH-1897 hazard of writing L2TCACTL while a flush is pending.
>=20
> Hold cache_clean_lock across the entire L2TCACTL access sequence so
> it
> is fully mutually exclusive with v3d_flush_l2t(), which already takes
> the
> lock around its own write.
>=20
> Cc: stable@vger.kernel.org
> Fixes: abf888b03a98 ("drm/v3d: Wait for pending L2T flush before
> cleaning caches")
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_gem.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c
> b/drivers/gpu/drm/v3d/v3d_gem.c
> index c43d9af41374..e597b6fd47c4 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -204,6 +204,8 @@ v3d_clean_caches(struct v3d_dev *v3d)
> =C2=A0	struct drm_device *dev =3D &v3d->drm;
> =C2=A0	int core =3D 0;
> =C2=A0
> +	guard(mutex)(&v3d->cache_clean_lock);
> +
> =C2=A0	trace_v3d_cache_clean_begin(dev);
> =C2=A0
> =C2=A0	/* GFXH-1897: Ensure pending flushes complete before writing
> L2TCACTL */
> @@ -220,7 +222,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
> =C2=A0		drm_err(dev, "Timeout waiting for TMU write combiner
> flush\n");
> =C2=A0	}
> =C2=A0
> -	mutex_lock(&v3d->cache_clean_lock);
> =C2=A0	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 V3D_L2TCACTL_L2TFLS |
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 V3D_SET_FIELD(V3D_L2TCACTL_F=
LM_CLEAN,
> V3D_L2TCACTL_FLM));
> @@ -230,8 +231,6 @@ v3d_clean_caches(struct v3d_dev *v3d)
> =C2=A0		drm_err(dev, "Timeout waiting for L2T clean\n");
> =C2=A0	}
> =C2=A0
> -	mutex_unlock(&v3d->cache_clean_lock);
> -
> =C2=A0	trace_v3d_cache_clean_end(dev);
> =C2=A0}
> =C2=A0


