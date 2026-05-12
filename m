Return-Path: <stable+bounces-245439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL4NCwgMA2pmzwEAu9opvQ
	(envelope-from <stable+bounces-245439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:16:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B92A51F308
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71E3E302532C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DF247AF65;
	Tue, 12 May 2026 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V049/lV3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D93D649A;
	Tue, 12 May 2026 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584529; cv=none; b=MSoqU2pQfJSH+Zmtmpjq472xJsiF+WVWJ8n+T9udDe65m7ai3FQSVGekvDetccD5oMYHr/e3kZarHOJ0Epwj89prWU1WGYOEher0ZXYPUu2N/OHjgyPQrzUUNBDsMQkd8xrqmrUdSPmwf2ibsRns5X5RAzV7p02KcI4Zl4Ls+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584529; c=relaxed/simple;
	bh=owds3NhV2YSPbKyZxnxeFXcN9qHcUUzVWH5UtjTMxNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o6r1tranHoR7TyTxpR4OL3+NDVDMgXI6ZNKyAUKt8NeiBlRMpULLeSUdDJmvtOgz6OtuppjoQ8EDOogPsqWjx3FepaFVGNrFu9Xjz1wIk66wPFbvgCHCBrJPPKFp6mDfulCkLyjWPZMX+oAg3CIYfWUark2XzpEQ3AA2nG5g09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V049/lV3; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778584528; x=1810120528;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=owds3NhV2YSPbKyZxnxeFXcN9qHcUUzVWH5UtjTMxNM=;
  b=V049/lV3dq5EJipdkSiuXWeXt0Wv+yW9qs+G5RimHLeILRRDGhmv0HrT
   AlwghL7RRQG62dkvdx3vzow9+igNGKkTVG5f1ly5211mKazL+fCC4z0hA
   LjFDQ5ZPiDU8emLY6k/AloilzIH45pQIVjS3/nV1SPkVT9jfVKJAM6kGv
   XTUfiDvih7Z/mo0J+oEMDa9CXrkw1EukQe6myE+AG+rz65lH90xE7Wf88
   n5bHz5cnzsjS9OljL9ksXq+oK6yyn0qDJxR5SK3ruqluT1CIT6yAFMSvt
   7ylut8K77v3rJhLtT6c0o5kKiL2uAUzJLm6S6UBp569SwbF0lHjgIShRO
   A==;
X-CSE-ConnectionGUID: Xh7Iv1bSQDqzJsjLEtXItg==
X-CSE-MsgGUID: oR7BAM+HQ3qFDVgSlFjcrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79473905"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79473905"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:15:19 -0700
X-CSE-ConnectionGUID: TiuAy2vIQ5mBNH95h9/nUw==
X-CSE-MsgGUID: fZZnPAizQS6526++syv1rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="242736179"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:15:18 -0700
Message-ID: <3a6b3499a8f2d39bac2bcf483ee48123823795d9.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix Raptor Lake-E cpufreq limits
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Henry Tseng <henrytseng@qnap.com>, 
	stable@vger.kernel.org
Date: Tue, 12 May 2026 04:15:17 -0700
In-Reply-To: <CAJZ5v0gVK7qF9Bfw952Vkb+-5WPOH+_M9-bRAwjJvHX3U=WOOg@mail.gmail.com>
References: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0gVK7qF9Bfw952Vkb+-5WPOH+_M9-bRAwjJvHX3U=WOOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0B92A51F308
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-245439-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid,qnap.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 12:20 +0200, Rafael J. Wysocki wrote:
> On Tue, May 12, 2026 at 1:53=E2=80=AFAM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Raptor Lake-E processors are not correctly showing cpufreq
> > frequency
> > limits.
> >=20
> > These CPUs don't set X86_FEATURE_HYBRID_CPU and have no E-cores,
> > but
> > P-cores still use hybrid scaling factor.
> >=20
> > commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
> > hybrid-capable systems with disabled E-cores") added support for
> > such configuration. Here using CPPC nominal freq and perf was
> > compared
> > to still return hybrid scaling factor.
> >=20
> > Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > scaling
> > factors") restructured hwp_get_cpu_scaling() and added an explicit
> > check
> > for X86_FEATURE_HYBRID_CPU and when not set returns core scaling
> > factor.
> >=20
> > To address this remove check for X86_FEATURE_HYBRID_CPU and call
> > intel_pstate_cppc_get_scaling().
> >=20
> > Ideally this change should be enough. But using CPPC for scaling
> > factor
> > results in rounding error, so still doesn't restore the original
> > behavior.
> >=20
> > In intel_pstate_cppc_get_scaling() return core scaling factor when
> > ACPI CPPC is not present or when CPPC nominal frequency or nominal
> > performance are invalid.
> >=20
> > Use hybrid_scaling_factor for P-cores when defined for a CPU, if
> > not
> > calculate from ACPI CPPC nominal frequency and performance.
> >=20
> > Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > scaling factors")
> > Reported-by: Henry Tseng <henrytseng@qnap.com>
> > Closes:
> > https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henrytseng@qn=
ap.com/
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > Cc: stable@vger.kernel.org
> > ---
> > =C2=A0drivers/cpufreq/intel_pstate.c | 29 +++++++++++++++--------------
> > =C2=A01 file changed, 15 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c
> > index 1292da53e5fc..0379efdee5f8 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -421,15 +421,23 @@ static int intel_pstate_cppc_get_scaling(int
> > cpu)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cppc_perf_caps cppc_p=
erf;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cppc_get_perf_caps(cpu, &cppc=
_perf) ||
> > !cppc_perf.nominal_freq ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !cppc_per=
f.nominal_perf)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto core_scaling;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cppc_perf.nominal_perf * 100 =
=3D=3D cppc_perf.nominal_freq)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 goto core_scaling;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hybrid_scaling_factor)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return hybrid_scaling_factor;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Compute the perf-to-frequ=
ency scaling factor for the
> > given CPU if
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * possible, unless it would=
 be 0.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Compute the perf-to-frequ=
ency scaling factor for the
> > given CPU
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from nominal freq and nom=
inal_perf
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cppc_get_perf_caps(cpu, &cpp=
c_perf) &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_perf=
.nominal_perf && cppc_perf.nominal_freq)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return div_u64(cppc_perf.nominal_freq *
> > KHZ_PER_MHZ,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_perf.nominal_perf);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return div_u64(cppc_perf.nominal_=
freq * KHZ_PER_MHZ,
> > cppc_perf.nominal_perf);
> >=20
> > +core_scaling:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return core_get_scaling();
> > =C2=A0}
> >=20
> > @@ -2281,17 +2289,10 @@ static int hwp_get_cpu_scaling(int cpu)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (hybrid_get_cpu_type(cpu) =3D=3D
> > INTEL_CPU_TYPE_CORE)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n hybrid_scaling_factor;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return core_get_scaling();
>=20
> Why is this change necessary or even useful?
>=20
> This is about E-cores (because P-cores have been covered above) and
> if
> hybrid_scaling_factor is set, it is known that the processor is
> hybrid
> and E-cores have the "core" scaling factor.
>=20
> Or is Raptor Lake-E covered by one of the
> intel_hybrid_scaling_factor[] entries and hybrid_get_cpu_type(cpu)
> doesn't return INTEL_CPU_TYPE_CORE on it?=C2=A0 This piece of information
> is missing from the changelog.

Raptor Lake-E (Xeon) uses CPU model as Raptor Lake-S, for which there
is already a hardcoded scaling factor in the driver. So this "if" block
will enter. But since there is no hybrid CPUID feature is defined,
hybrid_get_cpu_type(cpu) will return 0 for P-core or E-core. Here there
are no E-cores. So need to remove core_get_scaling() as this will
return non hybrid factor.



>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Use core scaling on non-hybrid=
 systems. */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_feature_enabled(X86_FEAT=
URE_HYBRID_CPU))
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return core_get_scaling();
> > -
>=20
> So we're now exposing all of the non-hybrid processors to the fun
> with
> possibly incorrectly populated CPPC, which is kind of risky.
>=20

This was already used before with
commit0fcfc9e51990246a9813475716746ff5eb98c6aa
relying that all non hybrid processor (including servers) didn't set
nominal frequency, so will return core_scaling without using CPPC.
I retested change on servers and non hybrids.

> If Raptor Lake-E is not covered by an existing
> intel_hybrid_scaling_factor[] entry, why don't we add one for it with
> a "scaling factor" value indicating that CPPC needs to be used for
> computing it on all CPUs?

It is already covered by existing, but we can only call=20
for intel_pstate_cppc_get_scaling() when hybrid_scaling_factor is
defined. This will require a hardcoding for Bartlett Lake also which
uses different CPU model, which Henry Tseng is planing to send.

Thanks,
Srinivas


>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The system is hybrid, but=
 the hybrid scaling factor is
> > not known or
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the CPU type is not one o=
f the above, so use CPPC to
> > compute the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The system is hybrid, so =
use CPPC to compute the
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * scaling factor for t=
his CPU.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return intel_pstate_cppc_get=
_scaling(cpu);
> > --

