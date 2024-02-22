Return-Path: <stable+bounces-23294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E903185F1F0
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 08:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25DE31C23096
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 07:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EA175B5;
	Thu, 22 Feb 2024 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXzhVEWf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1389217BBF
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587251; cv=none; b=UuHKf6Gy95ExYXOUgZyWm7duDtgU+wxAp7fJedg6nW92KUs06t6vlzd09l7fKx8PR5iLY6T1yVtLSNsLAk9WIWBgcw+S/vuOnZ8LRR3JhGvdoma5Q53jBq6AjAbBBe/FCeK1kFZNskLKlAUY3J1xXVqg8u+tMs36GyoAt7IeYC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587251; c=relaxed/simple;
	bh=D5iKaUm2basq6grzebPijfPPX3HpjC4EmCe2BPCu+9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q1iz/s7RHW1dUK01Xxd+9fhuYAQP48jjllIYx6EIub6ps5I9tvV/iaVq38MFm0aWDvzRGTnwCtH77287tXPl+sPY//M+YO5xI0LFldpwX9Q5TvbNkH1Q7+TdWyuSoUbOEP91+Wr1n0SrCyuk7hkjTy0TQzDveWU1dR6rwS9GChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXzhVEWf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708587250; x=1740123250;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=D5iKaUm2basq6grzebPijfPPX3HpjC4EmCe2BPCu+9M=;
  b=MXzhVEWfAbB7oHFJKurFx40ldSj6gbcycTLVoqQ2bWYZ5kppsENIn0sy
   C5iEXKKsR6L/fwywKLsTDl7swzZ3koKTtpFQMt/Ena9oynV6tAEbZUFPA
   WAolraRJjwfn6IRXP8FBCxe6V8Vn+yGwcOgKY4BHlTHjGK5/8AdYP9ILf
   bekKdhv08Gl4KlF1tg17PwmY1p3PYVUirxx1n/PItbrj7jtOhgPN9vqFU
   aqCFO75NbE9Dcw2jutLMO/iPXxLQOS2nrEu2S+0IMQwuoRbVlNre4WPmr
   rOl3jyRMITRHa4LHuf7RmXxIGxzs4drN334n+713rTyhSesDr8XZS7x1S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13353819"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13353819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:34:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="42889046"
Received: from binm223x-mobl2.gar.corp.intel.com (HELO [10.249.254.168]) ([10.249.254.168])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:34:07 -0800
Message-ID: <12471d185a3c90e53d665878db321c36e3fd2e53.camel@linux.intel.com>
Subject: Re: [PATCH] drm/ttm: Fix an invalid freeing on already freed page
 in error path
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>, Huang Rui <ray.huang@amd.com>, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Date: Thu, 22 Feb 2024 08:34:03 +0100
In-Reply-To: <6733f48a-4fb2-446c-91a8-e631937fbfcb@amd.com>
References: <20240221073324.3303-1-thomas.hellstrom@linux.intel.com>
	 <6733f48a-4fb2-446c-91a8-e631937fbfcb@amd.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 11:26 +0100, Christian K=C3=B6nig wrote:
> Am 21.02.24 um 08:33 schrieb Thomas Hellstr=C3=B6m:
> > If caching mode change fails due to, for example, OOM we
> > free the allocated pages in a two-step process. First the pages
> > for which the caching change has already succeeded. Secondly
> > the pages for which a caching change did not succeed.
> >=20
> > However the second step was incorrectly freeing the pages already
> > freed in the first step.
> >=20
> > Fix.
> >=20
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Fixes: 379989e7cbdc ("drm/ttm/pool: Fix ttm_pool_alloc error path")
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: <stable@vger.kernel.org> # v6.4+
>=20
> You don't know how much time I've spend staring at this line to find
> the=20
> bug in it and haven't seen it. Got bug reports about that for month
> as well.


Yeah, sorry about that. We should probably have Kunit tests exercising
OOM in the pool code involving WC pages.

I'll push this to drm-misc-next.

/Thomas

>=20
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>=20
> > ---
> > =C2=A0 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
> > b/drivers/gpu/drm/ttm/ttm_pool.c
> > index b62f420a9f96..112438d965ff 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -387,7 +387,7 @@ static void ttm_pool_free_range(struct ttm_pool
> > *pool, struct ttm_tt *tt,
> > =C2=A0=C2=A0				enum ttm_caching caching,
> > =C2=A0=C2=A0				pgoff_t start_page, pgoff_t
> > end_page)
> > =C2=A0 {
> > -	struct page **pages =3D tt->pages;
> > +	struct page **pages =3D &tt->pages[start_page];
> > =C2=A0=C2=A0	unsigned int order;
> > =C2=A0=C2=A0	pgoff_t i, nr;
> > =C2=A0=20
>=20


