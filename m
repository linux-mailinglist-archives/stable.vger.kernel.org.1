Return-Path: <stable+bounces-244628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFUaJsPY/GnxUQAAu9opvQ
	(envelope-from <stable+bounces-244628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:24:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ACF4ED5EC
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37485302A7E5
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4F2773CA;
	Thu,  7 May 2026 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOX/PQ5A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZ9PQ/+X"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8178466B63
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178231; cv=none; b=ezvYy3QZQ5CT9tupnhLBia5Eh0CELTXtoUrMh7RVwwDcqhK0m/beiTbGRVL0NnHzgqVw9Na70g/XSrtin22lpH5DP1XXXHQ+H+FnP5iRndh+Oevc/70ellsAHNO9yDsqN4MVDdgzkB5boUJhZRXZ0ULzQbiYJo96ug9mM6pCCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178231; c=relaxed/simple;
	bh=lwxgYlncyXwJYRGtk2C3Dwq8jEc9WeerZtFFgCLI180=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d5+0ON86zAan6ewozjIjkyDcYJavN/Tyywul/G8EruGNApwDTmRAhMFVs/CTdGgre8qNMA3u0YlfqFaHvLVSSWhrDnjDqYo28/7n+lhdv1rgh03LuI0opMgB5jGnFgTLLMdvHLMzg7hugCH/4u/i42dXC61vY2WHflP2juDC8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOX/PQ5A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZ9PQ/+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778178227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftCUpj5ypvcw40llhDtRrKigurBiomW0ZRMdUhWHyXA=;
	b=eOX/PQ5AkCflpLmGNjvVDzj8po1lfWCLcHNE0r5Zi59hG3AUwGKurNTAHvh2h+Z/64I65q
	GaksEfIqthFt1dnttqfUDrcccXaYFdP1+pgJHv3ZVb5OLDJeg3N6hNBkhqu4m8Hor4Y6UH
	DcrSYwz69fRdp+zNQSvQLNEsjf8CpCM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-L-DUB2D5OQS-XP0_dz-tEQ-1; Thu, 07 May 2026 14:23:46 -0400
X-MC-Unique: L-DUB2D5OQS-XP0_dz-tEQ-1
X-Mimecast-MFC-AGG-ID: L-DUB2D5OQS-XP0_dz-tEQ_1778178226
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50da529ff48so23961891cf.3
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778178226; x=1778783026; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ftCUpj5ypvcw40llhDtRrKigurBiomW0ZRMdUhWHyXA=;
        b=RZ9PQ/+XdfknRy8dxZGmGMYnrtTA8xjsdVfi63a7jLL+N8YgcrHrVpjSYoZcK1rfjU
         DIn92WdwlsvFc/NaIZmcfsCaqLKCJCQAUj/Y8p9sM1ijk4dOVY2AjUnck051P8jbUoZ/
         vveq8fwsR8tGdf+EK096OWUKvzqk4jdxJKfSvPZErxPuHJWU8krXN59SKifcQStMMF6o
         g0sjUjgP7v0vKE7TE9HHM0QaenP8jTqgbT5q74vPmEyMDOZUfRJwiMmlJ3RZkQX9NaOR
         1/FK8iAoU744cO7FbsqMTQcRrDhPfubvngA8mXcBHTxrzrbyUR8TcluSc7uw9J/QOFob
         qhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778178226; x=1778783026;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftCUpj5ypvcw40llhDtRrKigurBiomW0ZRMdUhWHyXA=;
        b=pD/gR7idDnrwSLeZms2UHzLO3N9ueMRYYrlS5md3iOjcIZN2dJeTe5O6W7KxfxAXzu
         0m7XlWW7ZHCXNs3gTadk4Ms0GaoVRfgE4UwOcnmK2emwrQ1nTsk71Epns7ivhb5u50D7
         5JVbbIguQ+1nxLlVhcsirfV5b+vHp99ZXCNDqmORamrzTfxdMjItCzartdsgFakkNnhR
         kjuizLbqMliFfZcOT0S21oj3x6pK+GHwfSRxJ4L0R9qAHGO3UFdNkoR6wqyfpYn0g3gt
         WJgnmr6aUpc9izGXGcX8xmyry3jlqHoUtdwcsxk7cEntQqHkKYFdadhO9njAtQ2CBbUZ
         E+KA==
X-Forwarded-Encrypted: i=1; AFNElJ+PEv/1AMdhUfOWWSoWMoQYEX2SRWsfkW27QkPQHHKcVJ/Lx5SHMN1JDz8yVYxI+5W02SxhOdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt8Y2bUhjluAE9oae8Gi0szayhG19ow5yldnhnSjrx+ErrT9DP
	YfmWeGrfnLJo4sMC42SxWUr4vlHhlrAcxTpTR+q40Zo4MWa1TUFo8UzImn5Na/KHIpsQ5F1BJZV
	f8VTyzSytm1Ju8OqDeub0QJgtM8LQ0opk3j/0+edZFHaZTvjZ+N6BIB2dh5KNIB0smQ==
X-Gm-Gg: AeBDietUvXZBhuo84af/F0LQkS5wLSJvyuCiRBWM7KCjfyhzWItQ7FdSBVr+ADo1EMR
	nCA6wteqwvhy1m2pYI4zwhfZAa3/O5RvxUXth6BKHbHDUiSeLPdC+SHEMmIndV2Lo+jXWmIUwiU
	u+rQV6nAe8cT/D2j8NwuiGYLncwn1Ie2B2rhzGgT0+hRkzh1BH7i1iEKvP/Mct+QoxesyyodvOz
	mliMVJ4hKuZbdCe4hzsVwUXpHJtth/i5nKV6alRUQ4vXPL5vHLD9W9aBNAJenCVjAwc4EjcT7EN
	96dPVS5Kae3cDJx3YXc1vmF4kGFhtnk+g+f0As8xoWdYcquMXX2Rk2B/Gr5naet4z1PLco+WWoR
	7m4Hl84xopWDTHQT0xQ==
X-Received: by 2002:a05:622a:5c98:b0:50f:c109:b78 with SMTP id d75a77b69052e-514621cf190mr123147881cf.60.1778178225689;
        Thu, 07 May 2026 11:23:45 -0700 (PDT)
X-Received: by 2002:a05:622a:5c98:b0:50f:c109:b78 with SMTP id d75a77b69052e-514621cf190mr123147321cf.60.1778178225080;
        Thu, 07 May 2026 11:23:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148522a5adsm4018391cf.14.2026.05.07.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:23:44 -0700 (PDT)
Message-ID: <4de3ead617a9f706d00e8540e6c6d65353799f4f.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Handle torn-down topology gracefully in
 drm_dp_mst_topology_queue_probe()
From: lyude@redhat.com
To: Jonas Emilsson <jonas.emilsson@gmail.com>, 
	dri-devel@lists.freedesktop.org
Cc: Imre Deak <imre.deak@intel.com>, stable@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org
Date: Thu, 07 May 2026 14:23:44 -0400
In-Reply-To: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
References: <20260503034533.1023686-1-jonas.emilsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 06ACF4ED5EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244628-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.freedesktop.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Action: no action

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in just a moment

On Sun, 2026-05-03 at 05:45 +0200, Jonas Emilsson wrote:
> A hotplug or link-loss event can tear down the MST topology
> (setting mgr->mst_state =3D false and mgr->mst_primary =3D NULL)
> concurrently
> with a caller invoking drm_dp_mst_topology_queue_probe(). Since the
> check
> is already performed under mgr->lock, the condition is not a
> programming
> error but a valid race -- the topology was valid when the caller
> decided
> to call this function, but was torn down before the lock was
> acquired.
>=20
> Replace the drm_WARN_ON() with a graceful early return. This
> eliminates
> spurious kernel warnings and the resulting compositor crashes
> observed
> when connecting/disconnecting DP MST monitors, while keeping the
> correct
> behavior of doing nothing when MST is not active. A drm_dbg_mst()
> trace
> is added so the skipped probe remains observable under MST debug
> logging.
>=20
> The existing WARN_ON(mgr->mst_primary) in
> drm_dp_mst_topology_mgr_set_mst()
> already catches the case where the topology is initialized twice, so
> no
> diagnostic coverage is lost.
>=20
> Fixes: dbaeef363ea5 ("drm/dp_mst: Add a helper to queue a topology
> probe")
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Jonas Emilsson <jonas.emilsson@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 8757972e8..0cb341ce1 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3738,8 +3738,10 @@ void drm_dp_mst_topology_queue_probe(struct
> drm_dp_mst_topology_mgr *mgr)
> =C2=A0{
> =C2=A0	mutex_lock(&mgr->lock);
>=20
> -	if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr-
> >mst_primary))
> +	if (!mgr->mst_state || !mgr->mst_primary) {
> +		drm_dbg_mst(mgr->dev, "queue_probe skipped: topology
> torn down\n");
> =C2=A0		goto out_unlock;
> +	}
>=20
> =C2=A0	drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);


