Return-Path: <stable+bounces-128581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2187A7E53B
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 17:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F0D3A486A
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92482046A3;
	Mon,  7 Apr 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fInOwzLx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069922040B7;
	Mon,  7 Apr 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040835; cv=none; b=aAW0kdqHvr9VYoZ7JwFGsFvD24M0zxWaTwr+k/lnYXiNfZIkN588igF2bmSGHXy71FIo+CxvThHJb5Y8j7iQ0xeUbut0ZYW269vGX2KYSHHzAKTvn4CkPyWTehsiz5a+IDh8w5QMPPog4S/eBafrn8vN1oG9dtB4b4QuJTnkXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040835; c=relaxed/simple;
	bh=UaUZsRHa5EOc2Zin6lFK+DuGV7ZjbYiHEDzEp+CB8p4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C6+TdGoXA1pKCf+azY9kEssaX/YekmfRWye4IVNRUyiL/hXEmSr7yP02n8m6hMx1eLSPxGHUqmiqL+KM3VbLF+oEnZEpYDEq/q8rpj7x0g3RAAO2LWnbi5/7GBStu4K09q1rnIj2CHEa9uXRfFvm71z42wEjOo/Wxy+6EQNleEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fInOwzLx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744040834; x=1775576834;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UaUZsRHa5EOc2Zin6lFK+DuGV7ZjbYiHEDzEp+CB8p4=;
  b=fInOwzLxoQYX3fmjUKyMYMo3tjM36BZH4K3wKfpuZF0L8AYCCXSsKM5R
   oWinCfNr4Rd1/qJijGDBiA6ntshjAeKf3nI8K+wcDSZhY95S/asuQq0R4
   UlvDI+Nhw74HeGAhjRZkdZXUdF5vK5WiI/dttQAfLAMEigB2xwE3CcSt4
   WZolNeiIJtdWAWXmVfdBKkcQVnAoJ9u+O0/aRm4UtNf5ifPYuLB9IhNUU
   y+QvIRcd2g6pMjgEj+t4NUM4OtNUdrksCfBMaZ80b97pDZ3wH2citqj9k
   JBBg1m8pryi/Q9TJ2vIxAOnijrWSEK+uD2OQXsp64n4PAywyCaik6ZgOk
   w==;
X-CSE-ConnectionGUID: A0DONvGDRTWrUX1LMcqQLA==
X-CSE-MsgGUID: b/YqlXlfSyK6EKvM0xaogA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62982306"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="62982306"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 08:47:13 -0700
X-CSE-ConnectionGUID: jD+96N+KS7CMEJsYM+TmMQ==
X-CSE-MsgGUID: u+7ADUAjR8WPUu7E0qPIJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="127872061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 08:47:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 7 Apr 2025 18:47:06 +0300 (EEST)
To: Mario Limonciello <superm1@kernel.org>
cc: mario.limonciello@amd.com, Shyam-sundar.S-k@amd.com, 
    Hans de Goede <hdegoede@redhat.com>, Yijun Shen <Yijun.Shen@dell.com>, 
    stable@vger.kernel.org, Yijun Shen <Yijun_Shen@Dell.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: amd: pmf: Fix STT limits
In-Reply-To: <392938bb-24b8-4873-ba89-aacf2c404499@kernel.org>
Message-ID: <333df1fe-b9d7-9396-240d-e586a9f4088a@linux.intel.com>
References: <20250407133645.783434-1-superm1@kernel.org> <60e43790-bbeb-29b3-dcf1-7311439e15cc@linux.intel.com> <392938bb-24b8-4873-ba89-aacf2c404499@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1266864523-1744040826=:936"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1266864523-1744040826=:936
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Apr 2025, Mario Limonciello wrote:

> On 4/7/2025 10:19 AM, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 7 Apr 2025, Mario Limonciello wrote:
> >=20
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > >=20
> > > On some platforms it has been observed that STT limits are not being
> > > applied
> > > properly causing poor performance as power limits are set too low.
> > >=20
> > > STT limits that are sent to the platform are supposed to be in Q8.8
> > > format.  Convert them before sending.
> > >=20
> > > Reported-by: Yijun Shen <Yijun.Shen@dell.com>
> > > Fixes: 7c45534afa443 ("platform/x86/amd/pmf: Add support for PMF Poli=
cy
> > > Binary")
> > > Cc: stable@vger.kernel.org
> > > Tested-By: Yijun Shen <Yijun_Shen@Dell.com>
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > > v2:
> > >   * Handle cases for auto-mode, cnqf, and sps as well
> > > ---
> > >   drivers/platform/x86/amd/pmf/auto-mode.c | 4 ++--
> > >   drivers/platform/x86/amd/pmf/cnqf.c      | 4 ++--
> > >   drivers/platform/x86/amd/pmf/sps.c       | 8 ++++----
> > >   drivers/platform/x86/amd/pmf/tee-if.c    | 4 ++--
> > >   4 files changed, 10 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/amd/pmf/auto-mode.c
> > > b/drivers/platform/x86/amd/pmf/auto-mode.c
> > > index 02ff68be10d01..df37f8a84a007 100644
> > > --- a/drivers/platform/x86/amd/pmf/auto-mode.c
> > > +++ b/drivers/platform/x86/amd/pmf/auto-mode.c
> > > @@ -120,9 +120,9 @@ static void amd_pmf_set_automode(struct amd_pmf_d=
ev
> > > *dev, int idx,
> > >   =09amd_pmf_send_cmd(dev, SET_SPPT_APU_ONLY, false,
> > > pwr_ctrl->sppt_apu_only, NULL);
> > >   =09amd_pmf_send_cmd(dev, SET_STT_MIN_LIMIT, false, pwr_ctrl->stt_mi=
n,
> > > NULL);
> > >   =09amd_pmf_send_cmd(dev, SET_STT_LIMIT_APU, false,
> > > -=09=09=09 pwr_ctrl->stt_skin_temp[STT_TEMP_APU], NULL);
> > > +=09=09=09 pwr_ctrl->stt_skin_temp[STT_TEMP_APU] << 8, NULL);
> >=20
> > Hi Mario,
> >=20
> > Could we add some helper on constructing the fixed-point number from th=
e
> > integer part as this magic shifting makes the intent somewhat harder to
> > follow just by reading the code itself?
> >=20
> > I hoped that include/linux/ would have had something for this but it se=
ems
> > generic fixed-point helpers are almost non-existing except for very
> > specific use cases such as averages so maybe add a helper only for this
> > driver for now as this will be routed through fixes branch so doing ran=
dom
> > things i include/linux/ might not be preferrable and would require larg=
er
> > review audience.
> >=20
> > What I mean for general helpers is that it would be nice to have someth=
ing
> > like DECLARE_FIXEDPOINT() similar to DECLARE_EWMA() macro (and maybe a
> > signed variant too) which creates a few helper functions for the given
> > name prefix. It seems there's plenty of code which would benefit from s=
uch
> > helpers and would avoid the need to comment the fixed-point operations
> > (not to speak of how many of such ops likely lack the comment). So at
> > least keep that in mind for naming the helpers so the conversion to
> > a generic helper could be done smoothly.
> >=20
>=20
> Do I follow right that you mean something like this?
>=20
> static inline u32 amd_pmf_convert_q88 (u32 val)

As with the ewma example, the operation should be the last part. And we'd=
=20
probably want to have some common prefix for all those to make it obvious=
=20
it's fixed-point related, so lets say e.g.:

fixp_amd_pmf_q88_from_integer()

I'm not entirely sure though if we really need per driver in the prefix at=
=20
all as fixed-points are more general concept than a single driver/hw. So=20
if it's only used for temperature, maybe just fixp_temp_q88_from_integer()=
=20
or even just fixp_q88_from_integer(), Q8.8 should really be the same for=20
all users, shouldn't it, so the last one would seem okay too to me=20
(although I'm not sure what people in general will think of that).

I suspect ..._from_int() isn't good name for operation because "int" is a=
=20
type in C but it would be shorted than from_integer.

> {
> =09return val << 8;
> }
>=20
>=20

--=20
 i.

--8323328-1266864523-1744040826=:936--

