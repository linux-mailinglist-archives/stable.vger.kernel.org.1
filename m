Return-Path: <stable+bounces-245149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL+hKJONAWpyeAEAu9opvQ
	(envelope-from <stable+bounces-245149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:04:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 88823509C70
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8CF53000096
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D63B5842;
	Mon, 11 May 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoHNq4wN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83943B6BE8
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486558; cv=none; b=i/qqhoPEJg9i8mSiElKsdZNJ+xbJp6Ys9XTdfPXQ/Z7Wh2WKjDDkEsH51mUqbbGizq1DFIgfUhnjO8FAvQy6kxvAPGezsmpHQRtLCBMlwtwZhfgShIB8kmer3jkmzdl7KbAb6qH5IB9k5xoCe42q+1Mw+3WbkZ4TFXc88LbA0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486558; c=relaxed/simple;
	bh=xRZd89/2Cf/SyjbXMCN+xfbG4F9Wl1sZpFpdFn3/fl0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0hobc/HT9U1jcn10ylJGiu5JnjUI0ru1dQbL5/ZFHZixguaMmEsosmj7K8W2ho73t/gn1f81VwbOCsbQc5Yfis69nqTaOyGXK6Da1r/EHLGR9CapXll1P3KG1EmZcHn7cHJ5aJdWuv564WwE8dc1V6YaAY4GunLd3YVFQLafig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoHNq4wN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778486553; x=1810022553;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=xRZd89/2Cf/SyjbXMCN+xfbG4F9Wl1sZpFpdFn3/fl0=;
  b=AoHNq4wNbOEc/StFiVJ1pUKDVayGUdjD7KpLIbyU/q7OKOEUoVOrebyk
   yR0MnyROOgdRT0/GxZWrmssWy+NbOcTlveVMioz2m8OwF2KJO5g936lMo
   Fm2TZalLSWNx0Z4cOu0lJ7qurMgQV/Wwh/MZxalOr3aKRAje8fFmMvbBB
   j1OtXQ9oIlk8JwWOZ8FIJgu3fexWvQ67NPjCoXxwTI5RAUbyDghXvZDb3
   edM8+I0b1jf50f/CVwVAgIqc3963xgRmNlGkPxQQKQbkbKxGnXxxVQWbc
   sywVfCdt+ZRagHao2o8gAncmHJi6Iyl1Lne5sBZG4M9ZZ9xqU8TQwq34Z
   w==;
X-CSE-ConnectionGUID: 8iMLxe+dSSO6Da5l2Ddglw==
X-CSE-MsgGUID: Hm4g4C9iSGeOFyYimd58og==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90469013"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90469013"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:02:22 -0700
X-CSE-ConnectionGUID: MkZCFCAYTlWHMvWT2AN/1A==
X-CSE-MsgGUID: 8PdQqgaOT/63IhSweIzyAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="232903163"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.248]) ([10.245.244.248])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 01:02:19 -0700
Message-ID: <ebc6a1f60e180e20eb5f599603c087e952c427e1.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Convert -EAGAIN from dmem_cgroup_try_charge to
 -ENOSPC
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-xe@lists.freedesktop.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Christian Koenig
 <christian.koenig@amd.com>, 	dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Date: Mon, 11 May 2026 10:02:17 +0200
In-Reply-To: <433c0bbd-6c47-4011-8551-d1cfd0b4e17c@lankhorst.se>
References: <20260508160920.230339-1-thomas.hellstrom@linux.intel.com>
	 <433c0bbd-6c47-4011-8551-d1cfd0b4e17c@lankhorst.se>
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
X-Rspamd-Queue-Id: 88823509C70
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,amd.com,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245149-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.hellstrom@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,lankhorst.se:email,lists.freedesktop.org:email,amd.com:email,intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lankhrost.se:email]
X-Rspamd-Action: no action

On Fri, 2026-05-08 at 19:03 +0200, Maarten Lankhorst wrote:
> Hey,
>=20
> Den 2026-05-08 kl. 18:09, skrev Thomas Hellstr=C3=B6m:
> > dmem_cgroup_try_charge() returns -EAGAIN when the cgroup limit is
> > hit and the charge fails. TTM has no concept of -EAGAIN from
> > resource
> > allocation; -ENOSPC is the canonical error meaning "no space, try
> > eviction". Convert at the source in ttm_resource_alloc() so no
> > caller
> > needs to handle an unexpected error code, and clean up the now-
> > redundant
> > -EAGAIN check in ttm_bo_alloc_resource().
> >=20
> > Without this, -EAGAIN escaping ttm_resource_alloc() during an
> > eviction
> > walk causes the walk to terminate early instead of continuing to
> > the
> > next candidate.
> >=20
> > Cc: Friedrich Vock <friedrich.vock@gmx.de>
> > Cc: Maarten Lankhorst <dev@lankhorst.se>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.14+
> > Fixes: 2b624a2c1865 ("drm/ttm: Handle cgroup based eviction in
> > TTM")
> > Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/ttm/ttm_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 2 +-
> > =C2=A0drivers/gpu/drm/ttm/ttm_resource.c | 5 ++++-
> > =C2=A02 files changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c
> > b/drivers/gpu/drm/ttm/ttm_bo.c
> > index d85f0a37ac35..cee3828df655 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -739,7 +739,7 @@ static int ttm_bo_alloc_resource(struct
> > ttm_buffer_object *bo,
> > =C2=A0		may_evict =3D (force_space && place->mem_type !=3D
> > TTM_PL_SYSTEM);
> > =C2=A0		ret =3D ttm_resource_alloc(bo, place, res,
> > force_space ? &limit_pool : NULL);
> > =C2=A0		if (ret) {
> > -			if (ret !=3D -ENOSPC && ret !=3D -EAGAIN) {
> > +			if (ret !=3D -ENOSPC) {
> > =C2=A0				dmem_cgroup_pool_state_put(limit_p
> > ool);
> > =C2=A0				return ret;
> > =C2=A0			}
> > diff --git a/drivers/gpu/drm/ttm/ttm_resource.c
> > b/drivers/gpu/drm/ttm/ttm_resource.c
> > index 9f36631d48b6..b0efffe5a526 100644
> > --- a/drivers/gpu/drm/ttm/ttm_resource.c
> > +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> > @@ -385,8 +385,11 @@ int ttm_resource_alloc(struct
> > ttm_buffer_object *bo,
> > =C2=A0
> > =C2=A0	if (man->cg) {
> > =C2=A0		ret =3D dmem_cgroup_try_charge(man->cg, bo-
> > >base.size, &pool, ret_limit_pool);
> > -		if (ret)
> > +		if (ret) {
> > +			if (ret =3D=3D -EAGAIN)
> > +				ret =3D -ENOSPC;
> > =C2=A0			return ret;
> > +		}
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	ret =3D man->func->alloc(man, bo, place, res_ptr);
>=20
> Yeah looks reasonable with the conversion to callbacks.
>=20
> Reviewed-by: Maarten Lankhorst <dev@lankhrost.se>

Thanks for reviewing, Maarten!=C2=A0

@Christian, any concerns?

/Thomas

