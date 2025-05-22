Return-Path: <stable+bounces-146071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF88AC0A2A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 12:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E3D3A8480
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 10:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D31E3DED;
	Thu, 22 May 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyZzDEu2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123912882C3
	for <stable@vger.kernel.org>; Thu, 22 May 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911494; cv=none; b=SX0YwPH/5p3i8Z1aYE+9oeY05igeys/dRmpLSwtX6Rbyr/3JQ+Vf9Nic43U4Qgbthu0NCxaCv9WaQTTzkM/BkIOVw3c09j9Kh01rbnW8ajFwSFAYYqyUhBqBL0IoWxWAc6GgWl4+wvGgiA2/9fcKgt/wfU2/zUu9UWbkV1gLg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911494; c=relaxed/simple;
	bh=dtIdeBILIEVkrXRtwvbqd6idFoqP4YdRc38caMjTwt4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=hHYMca1CXgfYKpKGbdsOjGg2aXl4zK3iPCZUZKoNBVi4lC4+NKgbejl5sCEBfNb/XeAQyQyZMhMRbE7w1azd1NSJnsRzrHsqhlW7h+b5lG57Lao4MHtlGCX+8A/tj/nuoDb94Ms+SfOm2tU6MTzfo+S3imo29394DktORnfaq0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyZzDEu2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747911493; x=1779447493;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:from:cc:to:date:message-id;
  bh=dtIdeBILIEVkrXRtwvbqd6idFoqP4YdRc38caMjTwt4=;
  b=ZyZzDEu2CPg7aW1wJ1GK+T0scEdLSJxG90yezOCMglyRidMN2HilxaQ0
   zvDs9BEFWvHYMkBU/TA2cc4qPKSe5cXAOaIRMjeqjK4PW7JuFSvAYtJRB
   rPU3oyIb03dJR0dujNroYj0ij4hil38I1O4Ll/YvXicqnw8oRwO140y7T
   d9CQwE7EgsThQ2it8rYpCRSJPTPOqEe95Bmx0AnETPMgsP21GpBvwLmvG
   +Lpz8gEVau+Uaz+KlBIuTaLIgqDl50oM4uYkqajGMxsfgIBU1uMT4jIhx
   6RqbOLzkNKXftCufFIgXcslnRFrzjKtpZXdYWYjxMcjBkRNAaiCULx0Ee
   A==;
X-CSE-ConnectionGUID: rUOLeQO9SKapubuAWluTzg==
X-CSE-MsgGUID: +ZyMRgoNS4eVKLXMH/Ukxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="67486511"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="67486511"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 03:58:12 -0700
X-CSE-ConnectionGUID: hye4iOL0RcmFRlQ4FGhZOg==
X-CSE-MsgGUID: MJGPGi6OQ1GfWuUlMA0QBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140615706"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.66])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 03:58:10 -0700
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aC7vyURBb6k8TqBI@intel.com>
References: <20250411144313.11660-1-ville.syrjala@linux.intel.com> <20250411144313.11660-2-ville.syrjala@linux.intel.com> <174789510455.12498.1410930072009074388@jlahtine-mobl> <aC7vyURBb6k8TqBI@intel.com>
Subject: Re: [PATCH v2 1/2] drm/i915/gem: Allow EXEC_CAPTURE on recoverable contexts on DG1
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Tvrtko Ursulin <tursulin@ursulin.net>, stable@vger.kernel.org, Matthew Auld <matthew.auld@intel.com>, Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>
To: Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Date: Thu, 22 May 2025 13:58:07 +0300
Message-ID: <174791148753.46844.12744171979550995848@jlahtine-mobl>
User-Agent: alot/0.12.dev7+g16b50e5f

Quoting Ville Syrj=C3=A4l=C3=A4 (2025-05-22 12:35:05)
> On Thu, May 22, 2025 at 09:25:04AM +0300, Joonas Lahtinen wrote:
> > (+ Tvrkto)
> >=20
> > Quoting Ville Syrjala (2025-04-11 17:43:12)

<SNIP>

> > > +++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> > > @@ -2013,7 +2013,7 @@ static int eb_capture_stage(struct i915_execbuf=
fer *eb)
> > >                         continue;
> > > =20
> > >                 if (i915_gem_context_is_recoverable(eb->gem_context) =
&&
> > > -                   (IS_DGFX(eb->i915) || GRAPHICS_VER_FULL(eb->i915)=
 > IP_VER(12, 0)))
> > > +                   GRAPHICS_VER_FULL(eb->i915) > IP_VER(12, 10))
> >=20
> > The IS_DGFX check was there because the error capture is expected to be
> > broken on anything with VRAM.
>=20
> I don't care. It's a regression that prevents current userspace
> from working.

(Spoiler: The userspace fix seems to be accepted and released.)

It's always bit murky when a platform stays under force_probe for
extended period of time, but it was never considered to be finalized from
memory management perspective at the time of adding this check.

Now you are just unblocking codepaths that are simply not expected to work,
and as it's in rather fragile part of the device resets so that's bit of
a no-go.

So if you really would prefer to drop this check for DG1, options would be =
to
implement the page copying for VRAM (probably bit much work) or alternative=
ly
we could just ignore the flag for DG1 specifically.

> > If we have already submitted an userspace fix to remove that flag, that
> > would be the right way to go.
>=20
> There has a been an open pull request for that for who knows how long
> without any action.
>=20
> >=20
> > So reverting this for now.
>=20
> *You* make sure a userspace fix actually gets released then.

Per GIT history[1] it should already be part of media-driver release 25.2.3
which was released last week. Or am I looking at the wrong fix?

Regards, Joonas

[1] https://github.com/intel/media-driver/commit/93c07d9b4b96a78bab21f6acd4=
eb863f4313ea4a

