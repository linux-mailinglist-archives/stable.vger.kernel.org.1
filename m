Return-Path: <stable+bounces-244557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNvYM4J0/GkEQQAAu9opvQ
	(envelope-from <stable+bounces-244557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:16:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3C14E74FB
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E58EC300D74E
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 11:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1736F433;
	Thu,  7 May 2026 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQCVxOrg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD05319851
	for <stable@vger.kernel.org>; Thu,  7 May 2026 11:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152495; cv=none; b=iLJozrXLs/WmWhqaL037pOQbATJ4PAGt5J/S4+8vQBWm0n6q+o8oKFsZh2iPoa5V9aRH1Yzrtkpt6Eh/VVwRAL8e57zOi5itGs9TH9zDHxp9iRLM/Vux8F8EKWUvNT5ze7VuQ05rqpW7LD16NG2NkzRvTAOsZqe9+05gv+QmUkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152495; c=relaxed/simple;
	bh=Py3NrPc/eqFNM9z+HmDNKtvWsJuLTKEutWYvzvxH55o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I54B4QIXUaCDLEm0I2vXqMVLhhQUaNO/4rHttQR6T5DApgCdrMTH3VYO+BvvKP+ZT44e/umXxBlkaD/xHoh5BaVd5j8VvkUbRlCmmIkoSZns7pmDeNaT4uUA/kLLJRpGfbBuDV/3q/jeWF8RPX+dMrOZI71X3eVUj/EF0IrRs3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQCVxOrg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778152494; x=1809688494;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Py3NrPc/eqFNM9z+HmDNKtvWsJuLTKEutWYvzvxH55o=;
  b=hQCVxOrgEjCGf8UjBeblxz0vW+J9x+BP3/8hEogonIvLjDCvcn+6KGAK
   3ksXghS9Mn9mhYypMfkKOZB0sZ9I5ga8rBxaGstzQ/COlAf1YRWpOcbtz
   R9937HGbrzjDEcePa1dkawN6fr4CdWA8no5j17scDfQdhS62RV9BM5Dzt
   kuQ5YfbhDhpU3Hn+SOeLo5GHLmYVauIUJSS9s+Eual5SUAthlPPV/2XSO
   77pDtuGvEdyVOZRYKQ+RwxAOWWxbKjCSbBvmkYNuKikPAhMSNJ5y0f95n
   HU61BuNEpP8WykCcqcRm2IbW47CzLyPkiwTMfWsILdxn5pcvK8J6DCgrd
   A==;
X-CSE-ConnectionGUID: aQv+erLERMKWks5ImX1/7A==
X-CSE-MsgGUID: Wv8tazTmRYWtOPWd8ohWzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79115911"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="79115911"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:14:53 -0700
X-CSE-ConnectionGUID: OR4xePgbR7eh1Un7/nnVoQ==
X-CSE-MsgGUID: 5PG98wUWRjKCZD/+VvswMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="241438237"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.94]) ([10.245.245.94])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 04:14:52 -0700
Message-ID: <87936849a77c61c8f9ab15e31be16ea1e22e479c.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe/dma-buf: handle empty bo and UAF races
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Thu, 07 May 2026 13:14:49 +0200
In-Reply-To: <f4957d06-3c0b-4ffe-928c-e82bf7615d75@intel.com>
References: <20260506184332.86743-2-matthew.auld@intel.com>
	 <ac67eec8376792e795f37645b83c1f4c7fed8ba4.camel@linux.intel.com>
	 <f4957d06-3c0b-4ffe-928c-e82bf7615d75@intel.com>
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
X-Rspamd-Queue-Id: CB3C14E74FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-244557-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,gitlab.freedesktop.org:url]
X-Rspamd-Action: no action

On Thu, 2026-05-07 at 10:03 +0100, Matthew Auld wrote:
> On 06/05/2026 20:59, Thomas Hellstr=C3=B6m wrote:
> > On Wed, 2026-05-06 at 19:43 +0100, Matthew Auld wrote:
> > > There look to be some nasty races here when triggering the
> > > invalidate_mappings hook:
> > >=20
> > > 1) We do xe_bo_alloc() followed by the attach, before the actual
> > > full
> > > bo
> > > =C2=A0=C2=A0=C2=A0 init step in xe_dma_buf_init_obj(). However the bo=
 is visible
> > > on
> > > the
> > > =C2=A0=C2=A0=C2=A0 attachments list after the attach.=C2=A0 This is b=
ad since
> > > exporter
> > > driver,
> > > =C2=A0=C2=A0=C2=A0 say amdgpu, can at any time call back into our
> > > invalidate_mappings
> > > hook,
> > > =C2=A0=C2=A0=C2=A0 with an empty/bogus bo, leading to potential bugs/=
crashes.
> > >=20
> > > 2) Similar to 1) but here we get a UAF, when the
> > > invalidate_mappings
> > > =C2=A0=C2=A0=C2=A0 hook is triggered. For example, we get as far as
> > > xe_bo_init_locked()
> > > =C2=A0=C2=A0=C2=A0 but this fails in some way. But here the bo will b=
e freed on
> > > error, but
> > > =C2=A0=C2=A0=C2=A0 we still have it attached from dma-buf pov, so if =
the
> > > =C2=A0=C2=A0=C2=A0 invalidate_mappings is now triggered then the bo w=
e access is
> > > gone
> > > and
> > > =C2=A0=C2=A0=C2=A0 we trigger UAF and more bugs/crashes.
> > >=20
> > > To fix this, move the attach step until after we actually have a
> > > fully
> > > set up buffer object. Note that the bo is not published to
> > > userspace
> > > until later, so not sure what the comment "Don't publish the bo
> > > until we have a valid attachment", is referring to.
> > >=20
> > > We have at least two different customers reporting hitting a NULL
> > > ptr
> > > deref in evict_flags when importing something from amdgpu,
> > > followed
> > > by
> > > triggering the evict flow. Hit rate is also pretty low, which
> > > would
> > > hint at some kind of race, so something like 1) or 2) might
> > > explain
> > > this.
> > >=20
> > > Assisted-by: Gemini:gemini-3 #debug
> > > Link:
> > > https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7903
> > > Link:
> > > https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/4055
> > > Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for
> > > Intel
> > > GPUs")
> > > Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: <stable@vger.kernel.org> # v6.8+
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/xe/xe_dma_buf.c | 23 ++++++++------------=
---
> > > =C2=A0=C2=A01 file changed, 8 insertions(+), 15 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > index b9828da15897..e6c2f7d30abb 100644
> > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > @@ -357,11 +357,6 @@ struct drm_gem_object
> > > *xe_gem_prime_import(struct drm_device *dev,
> > > =C2=A0=C2=A0		}
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > -	/*
> > > -	 * Don't publish the bo until we have a valid
> > > attachment,
> > > and a
> > > -	 * valid attachment needs the bo address. So pre-create
> > > a bo
> > > before
> > > -	 * creating the attachment and publish.
> > > -	 */
> > > =C2=A0=C2=A0	bo =3D xe_bo_alloc();
> > > =C2=A0=C2=A0	if (IS_ERR(bo))
> > > =C2=A0=C2=A0		return ERR_CAST(bo);
> > > @@ -371,6 +366,13 @@ struct drm_gem_object
> > > *xe_gem_prime_import(struct drm_device *dev,
> > > =C2=A0=C2=A0	if (test)
> > > =C2=A0=C2=A0		attach_ops =3D test->attach_ops;
> > > =C2=A0=C2=A0#endif
> > > +	/*
> > > +	 * xe_dma_buf_init_obj() takes ownership of bo on both
> > > success
> > > +	 * and failure, so we must not touch bo after this call.
> > > +	 */
> > > +	obj =3D xe_dma_buf_init_obj(dev, bo, dma_buf);
> > > +	if (IS_ERR(obj))
> > > +		return obj;
> >=20
> > IIRC this publishes the bo on the LRUs, as per the removed comment.
> > What happens if, for example, the shrinker kicks in and shrinks it?
> > But
> > similarly perhaps we should have obj->import_attach set already at
> > publish time?
>=20
> I don't think anything bad will happen? I would view it as an sg
> object=20
> without any real backing store or attachment. Trying to=20
> move/shrink/evict should be a noop, like moving from SYS -> SYS=20
> (starting placement for type_sg). But since this a type_sg bo, I
> think=20
> shrinker will already ignore it right?
>=20
> =C2=A0From user POV, the handle is only published until much later at the
> end=20
> of drm_gem_prime_fd_to_handle(), after our import callback here,
> AFAICT.=20
> So I don't think there is a risk of the user somehow using the
> imported=20
> bo in an ioctl, before we have done the attach etc.
>=20
> One other data point is perhaps amdgpu, which does seem to do the
> create=20
> + attach as normal steps.

OK, Yeah if there's no way the bo can see other unexpected callbacks
after initializing it, then

Acked-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>


>=20
> >=20
> > If this is indeed the case we might have to revert to some
> > trickery.
> > Like invalidate_mappings() returning early if the init is not
> > complete,
> > and set obj->import_attach under the lock in xe_dma_buf_init_obj?
> >=20
> > Also I think IIRC xe_bo_alloc() was created specifically for this
> > situation, so unless there are more users of that, and the ordering
> > in
> > this patch is indeed correct, we might be able to get rid of the
> > two-
> > step bo creation here.
> >=20
> > /Thomas
> >=20
> >=20
> > > =C2=A0=20
> > > =C2=A0=C2=A0	attach =3D dma_buf_dynamic_attach(dma_buf, dev->dev,
> > > attach_ops, &bo->ttm.base);
> > > =C2=A0=C2=A0	if (IS_ERR(attach)) {
> > > @@ -378,21 +380,12 @@ struct drm_gem_object
> > > *xe_gem_prime_import(struct drm_device *dev,
> > > =C2=A0=C2=A0		goto out_err;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > -	/*
> > > -	 * xe_dma_buf_init_obj() takes ownership of bo on both
> > > success
> > > -	 * and failure, so we must not touch bo after this call.
> > > -	 */
> > > -	obj =3D xe_dma_buf_init_obj(dev, bo, dma_buf);
> > > -	if (IS_ERR(obj)) {
> > > -		dma_buf_detach(dma_buf, attach);
> > > -		return obj;
> > > -	}
> > > =C2=A0=C2=A0	get_dma_buf(dma_buf);
> > > =C2=A0=C2=A0	obj->import_attach =3D attach;
> > > =C2=A0=C2=A0	return obj;
> > > =C2=A0=20
> > > =C2=A0=C2=A0out_err:
> > > -	xe_bo_free(bo);
> > > +	xe_bo_put(bo);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	return obj;
> > > =C2=A0=C2=A0}

