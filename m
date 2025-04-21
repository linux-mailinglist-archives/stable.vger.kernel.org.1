Return-Path: <stable+bounces-134889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C7A959AC
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 01:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55403ABB56
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 23:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161511F09B1;
	Mon, 21 Apr 2025 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2cw98NJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A24433A6;
	Mon, 21 Apr 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745276532; cv=none; b=mD4fNxj5ukrXQYP/KF6vu15WnfQA3Kni09gdLCaBiuXVHWU7nnmlUGL9ETNS56ihXH4UBSYNoqug68saKDJZTSbsJoDYNoy5FXY4uJ2v+2Iupe4ie4Cxx7OBCVbh72fdZkYKQzWI+A/kyHO4e666Q/LIUgzBPLkz/DTYkFXqwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745276532; c=relaxed/simple;
	bh=PxijuOCw0Bdx861a4zW55lKeDWdMiX31beduH51dM+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+yt7b9gdVtXQ5pCQ7LAUV07s8YPUIdqaYb558CJQPa0cdc3lEVdQ96jD7jcYv154RiDq1f8dXSsWiE7+8t94lu9B0NTwOe0+TA0V10km3SHDqUsHLsYNrfZevUKQydObCjjM9Yir9ZDcDcAP2CFny/2ITD+FBvHsIuamf2qz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2cw98NJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745276532; x=1776812532;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PxijuOCw0Bdx861a4zW55lKeDWdMiX31beduH51dM+Y=;
  b=S2cw98NJ+RAl+gNqhjooJCjSxVTeAbjtoKBxkE+9qveWhtpWYQr+K1zn
   w5GRPjQuOMD9ciMR8ZCt0IPdeDePN9Eh0r5Mq1bhYRTZ7FmKViDSApTas
   mG1IUweQAruf3yjmEvy+OPwDZk1lqnnTTmiE4tasLu1uRGPKy0bDdZ69k
   7RgZi05xy9EZVTrclVfIra0QRyxhEQmUCStCkvL9EbuIreWtJ1JZAa2Rg
   acZwFD0rjBLvEelFxz9hiJvlvf1OIveCt22apZFufjvYOScE9gQmpa/gP
   i/C0G72YwO6Z2IQjhpUqQXwRpoi/kwK8YnAb8ByAE09ZXnn6PsFdAUOTH
   Q==;
X-CSE-ConnectionGUID: misd28V1TBK0mVZX/n4euA==
X-CSE-MsgGUID: Q4MOB+ZJR8yuWyxmt393aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="50619942"
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="50619942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 16:02:11 -0700
X-CSE-ConnectionGUID: 930LvW+rQ96x8ogVNgeKcA==
X-CSE-MsgGUID: DMPzTLypRp+ab+28XKiAig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,229,1739865600"; 
   d="scan'208";a="132798875"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.111.93])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 16:02:10 -0700
Message-ID: <595bce6203d6d8951e312064bd5a8ba14c1fe141.camel@linux.intel.com>
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, andrew.cooper3@citrix.com, Len Brown
 <len.brown@intel.com>,  Peter Zijlstra <peterz@infradead.org>, "Rafael
 J.Wysocki" <rafael.j.wysocki@intel.com>, stable@vger.kernel.org
Date: Mon, 21 Apr 2025 16:02:10 -0700
In-Reply-To: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
References: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
Autocrypt: addr=srinivas.pandruvada@linux.intel.com; prefer-encrypt=mutual;
 keydata=mQGNBGYHNAsBDAC7tv5u9cIsSDvdgBBEDG0/a/nTaC1GXOx5MFNEDL0LWia2p8Asl7igx
 YrB68fyfPNLSIgtCmps0EbRUkPtoN5/HTbAEZeJUTL8Xdoe6sTywf8/6/DMheEUzprE4Qyjt0HheW
 y1JGvdOA0f1lkxCnPXeiiDY4FUqQHr3U6X4FPqfrfGlrMmGvntpKzOTutlQl8eSAprtgZ+zm0Jiwq
 NSiSBOt2SlbkGu9bBYx7mTsrGv+x7x4Ca6/BO9o5dIvwJOcfK/cXC/yxEkr1ajbIUYZFEzQyZQXrT
 GUGn8j3/cXQgVvMYxrh3pGCq9Q0Q6PAwQYhm97ipXa86GcTpP5B2ip9xclPtDW99sihiL8euTWRfS
 TUsEI+1YzCyz5DU32w3WiXr3ITicaMV090tMg9phIZsjfFbnR8hY03n0kRNWWFXi/ch2MsZCCqXIB
 oY/SruNH9Y6mnFKW8HSH762C7On8GXBYJzH6giLGeSsbvis2ZmV/r+LmswwZ6ACcOKLlvvIukAEQE
 AAbQ5U3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5j
 b20+iQHRBBMBCAA7FiEEdki2SeUi0wlk2xcjOqtdDMJyisMFAmYHNAsCGwMFCwkIBwICIgIGFQoJC
 AsCBBYCAwECHgcCF4AACgkQOqtdDMJyisMobAv+LLYUSKNuWhRN3wS7WocRPCi3tWeBml+qivCwyv
 oZbmE2LcxYFnkcj6YNoS4N1CHJCr7vwefWTzoKTTDYqz3Ma0D0SbR1p/dH0nDgN34y41HpIHf0tx0
 UxGMgOWJAInq3A7/mNkoLQQ3D5siG39X3bh9Ecg0LhMpYwP/AYsd8X1ypCWgo8SE0J/6XX/HXop2a
 ivimve15VklMhyuu2dNWDIyF2cWz6urHV4jmxT/wUGBdq5j87vrJhLXeosueRjGJb8/xzl34iYv08
 wOB0fP+Ox5m0t9N5yZCbcaQug3hSlgp9hittYRgIK4GwZtNO11bOzeCEMk+xFYUoa5V8JWK9/vxrx
 NZEn58vMJ/nxoJzkb++iV7KBtsqErbs5iDwFln/TRJAQDYrtHJKLLFB9BGUDuaBOmFummR70Rbo55
 J9fvUHc2O70qteKOt5A0zv7G8uUdIaaUHrT+VOS7o+MrbPQcSk+bl81L2R7TfWViCmKQ60sD3M90Y
 oOfCQxricddC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 12:22 -0700, Dave Hansen wrote:
>=20
> From: Dave Hansen <dave.hansen@linux.intel.com>
>=20
> Andrew Cooper reported some boot issues on Ice Lake servers when
> running Xen that he tracked down to MWAIT not waking up. Do the safe
> thing and consider them buggy since there's a published erratum.
> Note: I've seen no reports of this occurring on Linux.
>=20
> Add Ice Lake servers to the list of shaky MONITOR implementations
> with
> no workaround available. Also, before the if() gets too unwieldy,
> move
> it over to a x86_cpu_id array. Additionally, add a comment to the
> X86_BUG_MONITOR consumption site to make it clear how and why
> affected
> CPUs get IPIs to wake them up.
>=20
> There is no equivalent erratum for the "Xeon D" Ice Lakes so
> INTEL_ICELAKE_D is not affected.
>=20
> The erratum is called ICX143 in the "3rd Gen Intel Xeon Scalable
> Processors, Codename Ice Lake Specification Update". It is Intel
> document 637780, currently available here:
>=20
> 	https://cdrdv2.intel.com/v1/dl/getContent/637780
>=20
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: stable@vger.kernel.org
>=20
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

> ---
>=20
> =C2=A0b/arch/x86/include/asm/mwait.h |=C2=A0=C2=A0=C2=A0 3 +++
> =C2=A0b/arch/x86/kernel/cpu/intel.c=C2=A0 |=C2=A0=C2=A0 17 ++++++++++++++=
---
> =C2=A02 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff -puN arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug
> arch/x86/kernel/cpu/intel.c
> --- a/arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug	2025-04-18
> 13:54:46.022590596 -0700
> +++ b/arch/x86/kernel/cpu/intel.c	2025-04-18
> 15:15:19.374365069 -0700
> @@ -513,6 +513,19 @@ static void init_intel_misc_features(str
> =C2=A0}
> =C2=A0
> =C2=A0/*
> + * These CPUs have buggy MWAIT/MONITOR implementations that
> + * usually manifest as hangs or stalls at boot.
> + */
> +#define MWAIT_VFM(_vfm)	\
> +	X86_MATCH_VFM_FEATURE(_vfm, X86_FEATURE_MWAIT, 0)
> +static const struct x86_cpu_id monitor_bug_list[] =3D {
> +	MWAIT_VFM(INTEL_ATOM_GOLDMONT),
> +	MWAIT_VFM(INTEL_LUNARLAKE_M),
> +	MWAIT_VFM(INTEL_ICELAKE_X),	/* Erratum ICX143 */
> +	{},
> +};
> +
> +/*
> =C2=A0 * This is a list of Intel CPUs that are known to suffer from
> downclocking when
> =C2=A0 * ZMM registers (512-bit vectors) are used.=C2=A0 On these CPUs, w=
hen
> the kernel
> =C2=A0 * executes SIMD-optimized code such as cryptography functions or
> CRCs, it
> @@ -565,9 +578,7 @@ static void init_intel(struct cpuinfo_x8
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0 c->x86_vfm =3D=3D INTEL_WESTMERE_EX))
> =C2=A0		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
> =C2=A0
> -	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> -	=C2=A0=C2=A0=C2=A0 (c->x86_vfm =3D=3D INTEL_ATOM_GOLDMONT ||
> -	=C2=A0=C2=A0=C2=A0=C2=A0 c->x86_vfm =3D=3D INTEL_LUNARLAKE_M))
> +	if (x86_match_cpu(monitor_bug_list))
> =C2=A0		set_cpu_bug(c, X86_BUG_MONITOR);
> =C2=A0
> =C2=A0#ifdef CONFIG_X86_64
> diff -puN arch/x86/include/asm/mwait.h~ICX-MONITOR-bug
> arch/x86/include/asm/mwait.h
> --- a/arch/x86/include/asm/mwait.h~ICX-MONITOR-bug	2025-04-18
> 15:17:18.353749634 -0700
> +++ b/arch/x86/include/asm/mwait.h	2025-04-18
> 15:20:06.037927656 -0700
> @@ -110,6 +110,9 @@ static __always_inline void __sti_mwait(
> =C2=A0 * through MWAIT. Whenever someone changes need_resched, we would b=
e
> woken
> =C2=A0 * up from MWAIT (without an IPI).
> =C2=A0 *
> + * Buggy (X86_BUG_MONITOR) CPUs will never set the polling bit and
> will
> + * always be sent IPIs.
> + *
> =C2=A0 * New with Core Duo processors, MWAIT can take some hints based on
> CPU
> =C2=A0 * capability.
> =C2=A0 */
> _


