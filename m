Return-Path: <stable+bounces-54713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF9C910589
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020A31C20AC6
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64611A8C1B;
	Thu, 20 Jun 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EN3pBnVv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6718E1A3BD1
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718889121; cv=none; b=KLYbgRQXGGU2ErGDRELZzX3huFWI8SWKh56FGzJOdkidYgyAHPhMXkQk2JfyRGSFHda4RXrliYRo4ZsWxrw0x7jO0XLMK4/Ufd63flgVhjYn9AG3yrxbofNa84svo4XNWoU/CU/p+t3L+nvnwE+jUqgQKlJngdjhE9FMzqnNJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718889121; c=relaxed/simple;
	bh=7jBCReqSeSIPBO9uDMj53sp6WI2BXfVShEFx31BK9BQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lD7j4D6ff+zdp0TnJeaSJWlu9+1LlLe9uLg2KjZTFQvpypTW+04yYaCPO1DUV6oCoZnp5BvT+03IRkjdX72L2LcisomiBt2rRn5yiKliZHLWeaTT/LqEiKiE7yYjUR3aVNiVICCpf6xp3e6IPQtY5zGEzC0WaVx9qo0Efy94nA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EN3pBnVv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718889120; x=1750425120;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7jBCReqSeSIPBO9uDMj53sp6WI2BXfVShEFx31BK9BQ=;
  b=EN3pBnVv5djWA9aCT7qnaVG1JdG2LLFMh0q6jtgx1A4ymEbvgiGc8Wuh
   JFVi4f/DuFLaCPB2q40VWU5/czDEA5KpnmVQGf/0ftaBw50ecBgeB4RPv
   5VsLrvv1TuBa2omB9KLzCmmATwP9FLJassPNUFjITHLYFupFhPW1tPvp6
   dDe2fX9LROiCwShbeeh/4PFF81wCkyMMH5xoR0kTQQ3zBap9V/hpMhRvT
   nTd4R5mpxqbd1dPn2NI94NRsgEW/TjqzcI4Jb53YyFsWefYuMpusRIuT7
   fvvCfUalEIVE6q6azAKmSd1Uzo7BjR11+QgJI7FmPSzZS1BsMxb0h8Jnh
   Q==;
X-CSE-ConnectionGUID: 7/hwwFJmSH6C7T5dTuHU5g==
X-CSE-MsgGUID: l/iNJsssRsOX00i4hJuGMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="41268353"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="41268353"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:11:45 -0700
X-CSE-ConnectionGUID: Z8gnxoDfSIWgZise/v9zqw==
X-CSE-MsgGUID: 8iZz4SGIS3CeGkbTTMN3LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="42131165"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO [10.245.244.11]) ([10.245.244.11])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:11:45 -0700
Message-ID: <fcfa6c00b3b29fc169c148f8ffa08640c35b28a5.camel@linux.intel.com>
Subject: Re: [PATCH] drm/xe: fix error handling in xe_migrate_update_pgtables
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, stable@vger.kernel.org
Date: Thu, 20 Jun 2024 15:11:28 +0200
In-Reply-To: <20240620102025.127699-2-matthew.auld@intel.com>
References: <20240620102025.127699-2-matthew.auld@intel.com>
Autocrypt: addr=thomas.hellstrom@linux.intel.com; prefer-encrypt=mutual;
 keydata=mDMEZaWU6xYJKwYBBAHaRw8BAQdAj/We1UBCIrAm9H5t5Z7+elYJowdlhiYE8zUXgxcFz360SFRob21hcyBIZWxsc3Ryw7ZtIChJbnRlbCBMaW51eCBlbWFpbCkgPHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPoiTBBMWCgA7FiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQuBaTVQrGBr/yQAD/Z1B+Kzy2JTuIy9LsKfC9FJmt1K/4qgaVeZMIKCAxf2UBAJhmZ5jmkDIf6YghfINZlYq6ixyWnOkWMuSLmELwOsgPuDgEZaWU6xIKKwYBBAGXVQEFAQEHQF9v/LNGegctctMWGHvmV/6oKOWWf/vd4MeqoSYTxVBTAwEIB4h4BBgWCgAgFiEEbJFDO8NaBua8diGTuBaTVQrGBr8FAmWllOsCGwwACgkQuBaTVQrGBr/P2QD9Gts6Ee91w3SzOelNjsus/DcCTBb3fRugJoqcfxjKU0gBAKIFVMvVUGbhlEi6EFTZmBZ0QIZEIzOOVfkaIgWelFEH
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 11:20 +0100, Matthew Auld wrote:
> Don't call drm_suballoc_free with sa_bo pointing to PTR_ERR.
>=20
> References:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2120
> Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel
> GPUs")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: <stable@vger.kernel.org> # v6.8+

LGTM.
Reviewed-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>

> ---
> =C2=A0drivers/gpu/drm/xe/xe_migrate.c | 8 ++++----
> =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/xe/xe_migrate.c
> b/drivers/gpu/drm/xe/xe_migrate.c
> index 05f933787860..c9f5673353ee 100644
> --- a/drivers/gpu/drm/xe/xe_migrate.c
> +++ b/drivers/gpu/drm/xe/xe_migrate.c
> @@ -1358,7 +1358,7 @@ xe_migrate_update_pgtables(struct xe_migrate
> *m,
> =C2=A0						 GFP_KERNEL, true,
> 0);
> =C2=A0			if (IS_ERR(sa_bo)) {
> =C2=A0				err =3D PTR_ERR(sa_bo);
> -				goto err;
> +				goto err_bb;
> =C2=A0			}
> =C2=A0
> =C2=A0			ppgtt_ofs =3D NUM_KERNEL_PDE +
> @@ -1406,7 +1406,7 @@ xe_migrate_update_pgtables(struct xe_migrate
> *m,
> =C2=A0					 update_idx);
> =C2=A0	if (IS_ERR(job)) {
> =C2=A0		err =3D PTR_ERR(job);
> -		goto err_bb;
> +		goto err_sa;
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Wait on BO move */
> @@ -1458,10 +1458,10 @@ xe_migrate_update_pgtables(struct xe_migrate
> *m,
> =C2=A0
> =C2=A0err_job:
> =C2=A0	xe_sched_job_put(job);
> +err_sa:
> +	drm_suballoc_free(sa_bo, NULL);
> =C2=A0err_bb:
> =C2=A0	xe_bb_free(bb, NULL);
> -err:
> -	drm_suballoc_free(sa_bo, NULL);
> =C2=A0	return ERR_PTR(err);
> =C2=A0}
> =C2=A0


