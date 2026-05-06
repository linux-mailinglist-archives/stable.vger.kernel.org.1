Return-Path: <stable+bounces-244444-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDNTFK2d+2m0eQMAu9opvQ
	(envelope-from <stable+bounces-244444-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 21:59:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C94E0048
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 21:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9231F301A141
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF54C34D389;
	Wed,  6 May 2026 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTekwGm0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C5833D512
	for <stable@vger.kernel.org>; Wed,  6 May 2026 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778097577; cv=none; b=o4XFgYIiBrWQvzRIQvXzInZFenNmUvFftztRW8rH9fwfaDYQhRDzqP0nGkpt7/SUCc4G3J7W0rvfZLdNWHj6jfBqnygyiSMgonNsi8gdtpoTiyfOqpKPelXeA4VIy1JjKKFjNLrczKl/t8Mx9YJXqPBWBaHgsdf5WpNd3F8ojns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778097577; c=relaxed/simple;
	bh=ER328sLUwimCbuWTMWIiOxKHGPwMqnIBDUVIunTkos0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TKwMr1SZDkVCZu1rGnvlEGIrX+wDlFSiOTwjRqcrqEr/rzDE/JYaOrk3bjE5biFZyVc+9Ex+4y9fJrvwmj/pgW3ByNu5Dt2JVQCNzVvNQs1ecanmlTrkRa9ZwgWMPCIzHHOlJt2pttiBUjNE6MDqJuR4R4QxKX8WgF5VQQtNfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTekwGm0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778097575; x=1809633575;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ER328sLUwimCbuWTMWIiOxKHGPwMqnIBDUVIunTkos0=;
  b=ZTekwGm0KjctQtv1BFgzZ1UN5eM2rxLHO3Xca1zEasn2x7slz8xGdHOl
   SqbuX7YisfUMOI2T94qsUQhKQ7veMrf+9qVEOt4EEl9KnTw999+bCrGX+
   K6bdxelIKBdkta0sx3tn9yadwtZDu2Pua1Diog5FRGDwoR0WDY8tXJXRj
   imPLGMp9VD9/5AxR8ulAWIy375jzWV5GtziUiCFY4gvS7+5rf8fe27oxj
   Gb+gaA8KIHHK6pMdfV+6ARIjvVO2+NquLcNpzzYU9yzuRDZW6KsYrruj2
   ZvRBUlL4oXghhc0ZY/9gR1/FpAtl994G7hYaugttGwmf2BpPnwfIkCYsu
   Q==;
X-CSE-ConnectionGUID: KfNczlKIRby2H0vsRW/EzA==
X-CSE-MsgGUID: 0kmWYotYTj6PiWGox8vBQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="82885090"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="82885090"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 12:59:34 -0700
X-CSE-ConnectionGUID: K28VpcpCQduqoja89Zz+xA==
X-CSE-MsgGUID: C+06mTx+SIO41zpDscydoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="236349279"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.213]) ([10.245.244.213])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 12:59:33 -0700
Message-ID: <ac67eec8376792e795f37645b83c1f4c7fed8ba4.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe/dma-buf: handle empty bo and UAF races
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Wed, 06 May 2026 21:59:29 +0200
In-Reply-To: <20260506184332.86743-2-matthew.auld@intel.com>
References: <20260506184332.86743-2-matthew.auld@intel.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B29C94E0048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244444-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.intel.com:mid,gitlab.freedesktop.org:url]

On Wed, 2026-05-06 at 19:43 +0100, Matthew Auld wrote:
> There look to be some nasty races here when triggering the
> invalidate_mappings hook:
>=20
> 1) We do xe_bo_alloc() followed by the attach, before the actual full
> bo
> =C2=A0=C2=A0 init step in xe_dma_buf_init_obj(). However the bo is visibl=
e on
> the
> =C2=A0=C2=A0 attachments list after the attach.=C2=A0 This is bad since e=
xporter
> driver,
> =C2=A0=C2=A0 say amdgpu, can at any time call back into our invalidate_ma=
ppings
> hook,
> =C2=A0=C2=A0 with an empty/bogus bo, leading to potential bugs/crashes.
>=20
> 2) Similar to 1) but here we get a UAF, when the invalidate_mappings
> =C2=A0=C2=A0 hook is triggered. For example, we get as far as
> xe_bo_init_locked()
> =C2=A0=C2=A0 but this fails in some way. But here the bo will be freed on
> error, but
> =C2=A0=C2=A0 we still have it attached from dma-buf pov, so if the
> =C2=A0=C2=A0 invalidate_mappings is now triggered then the bo we access i=
s gone
> and
> =C2=A0=C2=A0 we trigger UAF and more bugs/crashes.
>=20
> To fix this, move the attach step until after we actually have a
> fully
> set up buffer object. Note that the bo is not published to userspace
> until later, so not sure what the comment "Don't publish the bo
> until we have a valid attachment", is referring to.
>=20
> We have at least two different customers reporting hitting a NULL ptr
> deref in evict_flags when importing something from amdgpu, followed
> by
> triggering the evict flow. Hit rate is also pretty low, which would
> hint at some kind of race, so something like 1) or 2) might explain
> this.
>=20
> Assisted-by: Gemini:gemini-3 #debug
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7903
> Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/4055
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+
> ---
> =C2=A0drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++---------------
> =C2=A01 file changed, 8 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> b/drivers/gpu/drm/xe/xe_dma_buf.c
> index b9828da15897..e6c2f7d30abb 100644
> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> @@ -357,11 +357,6 @@ struct drm_gem_object
> *xe_gem_prime_import(struct drm_device *dev,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	/*
> -	 * Don't publish the bo until we have a valid attachment,
> and a
> -	 * valid attachment needs the bo address. So pre-create a bo
> before
> -	 * creating the attachment and publish.
> -	 */
> =C2=A0	bo =3D xe_bo_alloc();
> =C2=A0	if (IS_ERR(bo))
> =C2=A0		return ERR_CAST(bo);
> @@ -371,6 +366,13 @@ struct drm_gem_object
> *xe_gem_prime_import(struct drm_device *dev,
> =C2=A0	if (test)
> =C2=A0		attach_ops =3D test->attach_ops;
> =C2=A0#endif
> +	/*
> +	 * xe_dma_buf_init_obj() takes ownership of bo on both
> success
> +	 * and failure, so we must not touch bo after this call.
> +	 */
> +	obj =3D xe_dma_buf_init_obj(dev, bo, dma_buf);
> +	if (IS_ERR(obj))
> +		return obj;

IIRC this publishes the bo on the LRUs, as per the removed comment.
What happens if, for example, the shrinker kicks in and shrinks it? But
similarly perhaps we should have obj->import_attach set already at
publish time?

If this is indeed the case we might have to revert to some trickery.
Like invalidate_mappings() returning early if the init is not complete,
and set obj->import_attach under the lock in xe_dma_buf_init_obj?

Also I think IIRC xe_bo_alloc() was created specifically for this
situation, so unless there are more users of that, and the ordering in
this patch is indeed correct, we might be able to get rid of the two-
step bo creation here.

/Thomas


> =C2=A0
> =C2=A0	attach =3D dma_buf_dynamic_attach(dma_buf, dev->dev,
> attach_ops, &bo->ttm.base);
> =C2=A0	if (IS_ERR(attach)) {
> @@ -378,21 +380,12 @@ struct drm_gem_object
> *xe_gem_prime_import(struct drm_device *dev,
> =C2=A0		goto out_err;
> =C2=A0	}
> =C2=A0
> -	/*
> -	 * xe_dma_buf_init_obj() takes ownership of bo on both
> success
> -	 * and failure, so we must not touch bo after this call.
> -	 */
> -	obj =3D xe_dma_buf_init_obj(dev, bo, dma_buf);
> -	if (IS_ERR(obj)) {
> -		dma_buf_detach(dma_buf, attach);
> -		return obj;
> -	}
> =C2=A0	get_dma_buf(dma_buf);
> =C2=A0	obj->import_attach =3D attach;
> =C2=A0	return obj;
> =C2=A0
> =C2=A0out_err:
> -	xe_bo_free(bo);
> +	xe_bo_put(bo);
> =C2=A0
> =C2=A0	return obj;
> =C2=A0}

