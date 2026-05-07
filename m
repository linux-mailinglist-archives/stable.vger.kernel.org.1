Return-Path: <stable+bounces-244630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC3sDUTe/GlFUwAAu9opvQ
	(envelope-from <stable+bounces-244630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9195F4ED99F
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0DB3034B27
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D09322A1C;
	Thu,  7 May 2026 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNQilGXj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0fh2+sd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94A8274B53
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778179560; cv=none; b=E1vs6f0gJYIIQiGJ8QoDHNrNC2QEVYz0MsrUMuXflnNlrzYmWM3xra40IwVpXGq27oOdyFRzxzBN01gVDmwSDpvF2SwO4OvFf7MJhrYlGNSTPnpphwnHhPbv1O9JOI7cNlX8R0PAs/G6YWcCzPSCbYS9DbEgM6IL8hE4uW+3HZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778179560; c=relaxed/simple;
	bh=A4Hf+A86cmm6TXKFB5fhNS2nVAHRzyFXFTRViEM7S5I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJ+7LU4A/lBydn/5LNsq96x6N2PygWLNUPPbrm93/sG9qWhguNcQSqHmqICERQfCSXcDNdOMDWaL0A+NYNIxX+UItdcFCSIWD2ZEnf3xR/fnB0jqLbGNW4zy4qGzbH9hZw094PVLd5uB3iyOsbEBzIfQpC7Z15FS4mM7ouVAek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNQilGXj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0fh2+sd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778179557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgXIkCgB3aSRfVz0FcSmSasyEWuA9kchSMzu8PPJBaA=;
	b=UNQilGXjqmp2Tlu5txOlvH5VA0olJfgUuwmolXcU7SXhOsQnrYC6SdvbdO7GbQqe3BMy7F
	CrJ0fkp+B595z5B42maUZp4jOardkklVnvq7nYv/ny6hU3cGIcZpcZaTeoMuLgRok4Ufxi
	6oh1rMf4JUsVvWrp+Ib9cQfHhPdMRUE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-6v9zc4MKOGOn7Ljcizcy7w-1; Thu, 07 May 2026 14:45:56 -0400
X-MC-Unique: 6v9zc4MKOGOn7Ljcizcy7w-1
X-Mimecast-MFC-AGG-ID: 6v9zc4MKOGOn7Ljcizcy7w_1778179556
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8acb85a973cso14233296d6.3
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778179556; x=1778784356; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WgXIkCgB3aSRfVz0FcSmSasyEWuA9kchSMzu8PPJBaA=;
        b=B0fh2+sd3hYAtB7q1bBBnnz6wCE8FXfOLxSl/i6VttqoFeSZBAeA9NZZcX9PMuVLXi
         OY8ftTOyeRfe0fzuQEJ+qQ4WPHY/hlV5bKU8k0/4ylW2N3ZuuUg7uiDDvUnc07bcE5R0
         2v5s+M39pXXgIvGI7YV2Acs0DEP2tX5+VgFF6EbpqGGdvIbuTz6rL6OUM/c/wHLTjiIL
         0tuFoia63zGN9Q/Tp45q7+lka6rN2pSRVBqALj/cLY1bTvnOvctZglImAYWjIn/EqFbM
         plKyVn5W/CJlxvMoDvcUjT/Fz4D3aK4MgKsiK64qZg83NqQ70PtzfpxudGQ5WFyB8bR8
         fs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778179556; x=1778784356;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WgXIkCgB3aSRfVz0FcSmSasyEWuA9kchSMzu8PPJBaA=;
        b=YFT0FFwTkVPAggPzwqW5oMg+Acalp4ZP3JiX6BC234WpxVrj0WWTHRgf8jYr7sbrth
         kD7xBsygNkSbaFM2+X1NgeTFGLazh81QmSuN0/yoi4I2R8RE1pPqg7NEpWqq2d0i/QNo
         pkxO/SjkRKaND4bjWy04KWGePD+5CzZ0Ygi0uALmGVhhDFOAVVElnebC+F8xvEfYvSHO
         VQrLJx/V7BRgc7bxAw/W5fWowVnlp2Cn9kfwaGgkmPsANv8mO0CtgQTas9X8wOvkkbOf
         klgXtXAMyIpDOvmGR45pfJth5wDS1CxdMsTrvuf3ZNeDenWBBALwfhoo+QCf5yqLJjhc
         g7QQ==
X-Forwarded-Encrypted: i=1; AFNElJ+BColgNolAIRXRuwfhTRnossocS96gpO3H8ED+B9CwYt9DDxJjIPNjQSwdgyQVlBPRblwKgi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7zty0Lzc+1sN0cudvc+rIdvA0ilZQj3Q12qSuicY9p/Xad7o
	UfY9zOKoBhOOqZppzvfL69qnPeHAlM2TzGR4xh6oa0k5W8y5HsskYfxz9Mm8j6awx/wFn7Oj7Ce
	XLAXxZfK8fnYoXd3/5LzQB6/WdpxqV3t+fUThf49v0qdVo6xz3eqGT2ARng==
X-Gm-Gg: AeBDieskxWuZ++6u1pXnxRNaViXV1vXO/F5NUQgGI5boOUjHJRA27b3imDaDBSlrAba
	qTAW2lm8I0/44dTgrKkJ5j6CVkNOfy987vJXp3mUWUAe638YFZNe/PgKa21DEIpBFVY2qSWa12Y
	WW1EgyqobKXfYnB22UghX7I0jmzXfiYWnGorQV7ZLtENjfgv2CN0SzIDUI6hs7LH7yhUXtLuZ9j
	JGSQGC1LjODLq6362drCYn/EVDTjn0VSycJzShpkbzAxibjKpmmOHWhvgXNZaj3XHxLTEkclTs4
	ueCErLoGgRvkggBHxsUY+rNCa58KvweVvHfxi87aGyutFl+hGN15xq/0+oHrTYdhgLcfINWU+TP
	R+JEyjztKGWvSYjZemA==
X-Received: by 2002:ad4:5ecb:0:b0:89c:4812:cc2 with SMTP id 6a1803df08f44-8bc42c63a8amr140677946d6.15.1778179555938;
        Thu, 07 May 2026 11:45:55 -0700 (PDT)
X-Received: by 2002:ad4:5ecb:0:b0:89c:4812:cc2 with SMTP id 6a1803df08f44-8bc42c63a8amr140677476d6.15.1778179555448;
        Thu, 07 May 2026 11:45:55 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538a293dbsm249581016d6.2.2026.05.07.11.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:45:54 -0700 (PDT)
Message-ID: <6b3516fe9db22f223f6e558b5a6ff31fbe6aa64d.camel@redhat.com>
Subject: Re: [PATCH] drm/dp_mst: Handle torn-down topology gracefully in
 drm_dp_mst_topology_queue_probe()
From: lyude@redhat.com
To: Jonas Emilsson <jonas.emilsson@gmail.com>, 
	dri-devel@lists.freedesktop.org
Cc: Imre Deak <imre.deak@intel.com>, stable@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org
Date: Thu, 07 May 2026 14:45:54 -0400
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
X-Rspamd-Queue-Id: 9195F4ED99F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244630-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email,intel.com:email]
X-Rspamd-Action: no action

Actually sorry - I need to take back the r-b, there's a couple of
issues in this patch that I didn't immediately notice because it had
trouble applying (though I don't have a clue why)

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

There is no such function named drm_dbg_mst, can you switch this to
drm_dbg_kms() like the rest of the file and make sure it builds before
sending another version?

> =C2=A0		goto out_unlock;
> +	}
>=20
> =C2=A0	drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);


