Return-Path: <stable+bounces-26755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632DE871A5B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27C3282A8B
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA692535DC;
	Tue,  5 Mar 2024 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxvfH5yV"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D314253E03
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633699; cv=none; b=EcVcQslm7cEYtDIjMtjiXx32WlrkMOl/HvZhY6d2ujNPcEzwgZYt2iFK1zJE63rBWxI6MGeMIAgDsFESvmNKXbYwRaFYbMDIM0hvI95a8NN69K7j8TZpPLmvvxugQb31QA8pQTV9wT7t2ueaAGD9RoeRFm7r3Hvoflk73qaR5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633699; c=relaxed/simple;
	bh=IfD+qDLgLczsyuWim2FnqlLcEdRE5l9kc0iYiLLTlhc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Cc:From:Subject:
	 To:Message-ID:Date; b=NRV6gjNgoAw0GYOaKY5gKbLDHXQsOeHSPVAry9B/ms1WbA+Uy7soPsLJmUiWcfJRsq2rN43GxQnxyl84qiIVTh/afDldjTfrEytH0jIIZrlrv7qWDSAGp52E0gMBBRxQBDsXt9IToDwdEb6I93f/UP6U7oDV1RIEbGJ4UrGZfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxvfH5yV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709633698; x=1741169698;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:cc:from:subject:to:message-id:date;
  bh=IfD+qDLgLczsyuWim2FnqlLcEdRE5l9kc0iYiLLTlhc=;
  b=nxvfH5yViexmZnBXPj6MavBJzLWix5EKgrjXn62la8ToqbkJwAAUYXvU
   HSzVmvTnPCNRh2WYmZv1Qx+98GSZKfMLFP23xyxf7qkg6p2gkR54onCfE
   Z4c/yY6gVWvsQ02lJpEkuVR4AQsEov77eh/2BcQQaAQzPKslvaGIMhlHI
   z8HYHeQ6bKJjSc+LYFa67SJYnPp4/3lZ79JmSbWiQejDhNvKUng3Hy8B9
   S4nyNqBazZ5/GZzlTuFypX/jb3/BcA+B2BEmWQcEVf4ZpUW1hjKKDh9YK
   b4BYXORQ9VUP0awsfSf/FYitfiCn9LEsOVaLjYdNQJzNP/AkxXi8/WxUK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21629493"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21629493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:14:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9740489"
Received: from unknown (HELO localhost) ([10.245.244.116])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 02:14:53 -0800
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240229232859.70058-2-andi.shyti@linux.intel.com>
References: <20240229232859.70058-1-andi.shyti@linux.intel.com> <20240229232859.70058-2-andi.shyti@linux.intel.com>
Cc: Chris Wilson <chris.p.wilson@linux.intel.com>, Matt Roper <matthew.d.roper@intel.com>, John Harrison <John.C.Harrison@Intel.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, stable@vger.kernel.org, Andi Shyti <andi.shyti@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH v3 1/4] drm/i915/gt: Refactor uabi engine class/instance list creation
To: Andi Shyti <andi.shyti@linux.intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, intel-gfx <intel-gfx@lists.freedesktop.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <170963369058.35653.11240745207600457716@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date: Tue, 05 Mar 2024 12:14:50 +0200

Quoting Andi Shyti (2024-03-01 01:28:56)
> For the upcoming changes we need a cleaner way to build the list
> of uabi engines.
>=20
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_engine_user.c | 29 ++++++++++++---------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_user.c b/drivers/gpu/dr=
m/i915/gt/intel_engine_user.c
> index 833987015b8b..cf8f24ad88f6 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_user.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_user.c
> @@ -203,7 +203,7 @@ static void engine_rename(struct intel_engine_cs *eng=
ine, const char *name, u16
> =20
>  void intel_engines_driver_register(struct drm_i915_private *i915)
>  {
> -       u16 name_instance, other_instance =3D 0;
> +       u16 class_instance[I915_LAST_UABI_ENGINE_CLASS + 1] =3D { };

Do you mean this to be size I915_LAST_UABI_ENGINE_CLASS + 2? Because ...

<SNIP>

> @@ -222,15 +224,14 @@ void intel_engines_driver_register(struct drm_i915_=
private *i915)
> =20
>                 GEM_BUG_ON(engine->class >=3D ARRAY_SIZE(uabi_classes));
>                 engine->uabi_class =3D uabi_classes[engine->class];
> -               if (engine->uabi_class =3D=3D I915_NO_UABI_CLASS) {
> -                       name_instance =3D other_instance++;
> -               } else {
> -                       GEM_BUG_ON(engine->uabi_class >=3D
> -                                  ARRAY_SIZE(i915->engine_uabi_class_cou=
nt));
> -                       name_instance =3D
> -                               i915->engine_uabi_class_count[engine->uab=
i_class]++;
> -               }
> -               engine->uabi_instance =3D name_instance;
> +
> +               if (engine->uabi_class =3D=3D I915_NO_UABI_CLASS)
> +                       uabi_class =3D I915_LAST_UABI_ENGINE_CLASS + 1;

.. otherwise this ...

> +               else
> +                       uabi_class =3D engine->uabi_class;
> +
> +               GEM_BUG_ON(uabi_class >=3D ARRAY_SIZE(class_instance));

.. will trigger this assertion?

Regards, Joonas

