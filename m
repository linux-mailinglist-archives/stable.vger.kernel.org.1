Return-Path: <stable+bounces-246648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEk5MdJ1A2pY6AEAu9opvQ
	(envelope-from <stable+bounces-246648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:47:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D417B5281B1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E517300D4FE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35868274B3B;
	Tue, 12 May 2026 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doThEYuq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4D525B0A0;
	Tue, 12 May 2026 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611510; cv=none; b=M7J5K6Dk6IW1o8GWkP47LPtxVWtlQPg8gTKD9ziV7YqEj/kbqHAzAT1YSPkVdA7Fpw0L4IA/bvEsPdWUgVbAVgpRpp/F9NGEYOkkxeUkm83gNIHpqFJT1p108m30aFWeKIdbJD867qnUQW1QTfzi1WbVKu3/7j3UZBc89BG4SoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611510; c=relaxed/simple;
	bh=qdzjw3TcCMfGdb8sJ4MIzu7xGE5iKYmhXI9NHO0Q398=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgTI6SjEgPGYiloiSy90R++W6HmCjgb37cpli5dymUbyKhB50qhlJYwjsA7RUcNoX5tIlPoKsj81heHGa5ZMzcw/a9EKpvXd1hd6BIuwKvEwrtRt+QSwLKSeEmDV358lWbgDaNkxpTIEmB/PZG28QhEyCWT/y2646kNT0vrEK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doThEYuq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778611508; x=1810147508;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qdzjw3TcCMfGdb8sJ4MIzu7xGE5iKYmhXI9NHO0Q398=;
  b=doThEYuqmNtjWornecAz9Q+JT3Atk10ij7PINIqebwPHLZHy/DycQ+dF
   /NviKqmohrhhFJz59Mm3qJAmqiqU0a6n8Bgv0BtiZCtKkUW2WwTg9nT0l
   i7GMsU1qMAzhAxuduWrRUylLDTI8V5JBJjo2V1hty7P2ea4a5xok7BTxr
   ghqgW/WYFfOF+j4uNo9LdJotFqleQDTgeQB7KjfwC3pj5IRuY0Zyfjo8S
   cAB+79jukerq0GPGauxpduZ1aVZE5GuGM0MYYva7WF2hxY493RmOTbMft
   kFJvHUA6EQjgLj5zFKdnmQSy/7r62PXhXEQe/0ICZn2CUH491CNOIWJT6
   Q==;
X-CSE-ConnectionGUID: be61Ruq/TGGTV7cRCzogtQ==
X-CSE-MsgGUID: WbaCZ28BTaSJ5Cf4LniN4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="67057694"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="67057694"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 11:45:07 -0700
X-CSE-ConnectionGUID: w5VuX3emR/a2YuPytgIn7A==
X-CSE-MsgGUID: JqkDBWaLTdqvBLcaFQrUbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242197353"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.218]) ([10.125.111.218])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 11:45:06 -0700
Message-ID: <d2c5b841302df2538ffb634d9a86c5643122a509.camel@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix Raptor Lake-E cpufreq limits
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Henry Tseng <henrytseng@qnap.com>, 
	stable@vger.kernel.org
Date: Tue, 12 May 2026 11:45:04 -0700
In-Reply-To: <CAJZ5v0imv=-NRy1e1mvEYFcyryr7kqyCu+nEzGW=S+PSzDJHWA@mail.gmail.com>
References: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
	 <CAJZ5v0gVK7qF9Bfw952Vkb+-5WPOH+_M9-bRAwjJvHX3U=WOOg@mail.gmail.com>
	 <3a6b3499a8f2d39bac2bcf483ee48123823795d9.camel@linux.intel.com>
	 <CAJZ5v0imv=-NRy1e1mvEYFcyryr7kqyCu+nEzGW=S+PSzDJHWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D417B5281B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-246648-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qnap.com:email,linux.intel.com:mid]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 14:37 +0200, Rafael J. Wysocki wrote:
> On Tue, May 12, 2026 at 1:15=E2=80=AFPM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > On Tue, 2026-05-12 at 12:20 +0200, Rafael J. Wysocki wrote:
> > > On Tue, May 12, 2026 at 1:53=E2=80=AFAM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >=20
> > > > Raptor Lake-E processors are not correctly showing cpufreq
> > > > frequency
> > > > limits.
> > > >=20
> > > > These CPUs don't set X86_FEATURE_HYBRID_CPU and have no E-
> > > > cores,
> > > > but
> > > > P-cores still use hybrid scaling factor.
> > > >=20
> > > > commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
> > > > hybrid-capable systems with disabled E-cores") added support
> > > > for
> > > > such configuration. Here using CPPC nominal freq and perf was
> > > > compared
> > > > to still return hybrid scaling factor.
> > > >=20
> > > > Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > > > scaling
> > > > factors") restructured hwp_get_cpu_scaling() and added an
> > > > explicit
> > > > check
> > > > for X86_FEATURE_HYBRID_CPU and when not set returns core
> > > > scaling
> > > > factor.
> > > >=20
> > > > To address this remove check for X86_FEATURE_HYBRID_CPU and
> > > > call
> > > > intel_pstate_cppc_get_scaling().
> > > >=20
> > > > Ideally this change should be enough. But using CPPC for
> > > > scaling
> > > > factor
> > > > results in rounding error, so still doesn't restore the
> > > > original
> > > > behavior.
> > > >=20
> > > > In intel_pstate_cppc_get_scaling() return core scaling factor
> > > > when
> > > > ACPI CPPC is not present or when CPPC nominal frequency or
> > > > nominal
> > > > performance are invalid.
> > > >=20
> > > > Use hybrid_scaling_factor for P-cores when defined for a CPU,
> > > > if
> > > > not
> > > > calculate from ACPI CPPC nominal frequency and performance.
> > > >=20
> > > > Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > > > scaling factors")
> > > > Reported-by: Henry Tseng <henrytseng@qnap.com>
> > > > Closes:
> > > > https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henrytsen=
g@qnap.com/
> > > > Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > > =C2=A0drivers/cpufreq/intel_pstate.c | 29 +++++++++++++++----------=
-
> > > > ---
> > > > =C2=A01 file changed, 15 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c
> > > > index 1292da53e5fc..0379efdee5f8 100644
> > > > --- a/drivers/cpufreq/intel_pstate.c
> > > > +++ b/drivers/cpufreq/intel_pstate.c
> > > > @@ -421,15 +421,23 @@ static int
> > > > intel_pstate_cppc_get_scaling(int
> > > > cpu)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct cppc_perf_caps cp=
pc_perf;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cppc_get_perf_caps(cpu, &=
cppc_perf) ||
> > > > !cppc_perf.nominal_freq ||
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !cppc=
_perf.nominal_perf)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto core_scaling;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cppc_perf.nominal_perf * =
100 =3D=3D
> > > > cppc_perf.nominal_freq)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto core_scaling;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hybrid_scaling_factor)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return hybrid_scaling_factor;
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Compute the perf-to-f=
requency scaling factor for the
> > > > given CPU if
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * possible, unless it w=
ould be 0.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Compute the perf-to-f=
requency scaling factor for the
> > > > given CPU
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from nominal freq and=
 nominal_perf
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cppc_get_perf_caps(cpu, =
&cppc_perf) &&
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_=
perf.nominal_perf && cppc_perf.nominal_freq)
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return div_u64(cppc_perf.nominal_freq *
> > > > KHZ_PER_MHZ,
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cppc_perf.nominal_perf);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return div_u64(cppc_perf.nomi=
nal_freq * KHZ_PER_MHZ,
> > > > cppc_perf.nominal_perf);
> > > >=20
> > > > +core_scaling:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return core_get_scaling(=
);
> > > > =C2=A0}
> > > >=20
> > > > @@ -2281,17 +2289,10 @@ static int hwp_get_cpu_scaling(int cpu)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (hybrid_get_cpu_type(cpu) =3D=3D
> > > > INTEL_CPU_TYPE_CORE)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn hybrid_scaling_factor;
> > > > -
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return core_get_scaling();
> > >=20
> > > Why is this change necessary or even useful?
> > >=20
> > > This is about E-cores (because P-cores have been covered above)
> > > and
> > > if
> > > hybrid_scaling_factor is set, it is known that the processor is
> > > hybrid
> > > and E-cores have the "core" scaling factor.
> > >=20
> > > Or is Raptor Lake-E covered by one of the
> > > intel_hybrid_scaling_factor[] entries and
> > > hybrid_get_cpu_type(cpu)
> > > doesn't return INTEL_CPU_TYPE_CORE on it?=C2=A0 This piece of
> > > information
> > > is missing from the changelog.
> >=20
> > Raptor Lake-E (Xeon) uses CPU model as Raptor Lake-S, for which
> > there
> > is already a hardcoded scaling factor in the driver.
>=20
> This piece of information needs to be added to the changelog in the
> first place because it is key here.
>=20
> > So this "if" block will enter. But since there is no hybrid CPUID
> > feature is defined,
> > hybrid_get_cpu_type(cpu) will return 0 for P-core or E-core. Here
> > there
> > are no E-cores. So need to remove core_get_scaling() as this will
> > return non hybrid factor.
>=20
> Well, what about this:
>=20
> ---
> =C2=A0drivers/cpufreq/intel_pstate.c |=C2=A0=C2=A0=C2=A0 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2279,7 +2279,7 @@ static int hwp_get_cpu_scaling(int cpu)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Return the hybri=
d scaling factor for P-cores and use the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * default core sca=
ling for E-cores.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hybrid_get_cpu_type(cpu) =
=3D=3D INTEL_CPU_TYPE_CORE)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (hybrid_get_cpu_type(cpu) =
!=3D INTEL_CPU_TYPE_ATOM)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return hybrid_scaling_factor;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return core_get_scaling(=
);
>=20
> Or is the original Raptor Lake-S scaling factor unsuitable for Raptor
> Lake-E?

This will work for RPL-E. But the original change also accounted for
core scaling on hybrid. There was some embedded hybrid capable with P
core only, used core scaling. Don't find that system details anymore.=20

But fine, we can live with this change with added Bartlett Lake scaling
factor.

Thanks,
Srinivas

>=20
> >=20
> >=20
> > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Use core scaling on non-hy=
brid systems. */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_feature_enabled(X86_=
FEATURE_HYBRID_CPU))
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return core_get_scaling();
> > > > -
> > >=20
> > > So we're now exposing all of the non-hybrid processors to the fun
> > > with
> > > possibly incorrectly populated CPPC, which is kind of risky.
> > >=20
> >=20
> > This was already used before with
> > commit0fcfc9e51990246a9813475716746ff5eb98c6aa
> > relying that all non hybrid processor (including servers) didn't
> > set
> > nominal frequency, so will return core_scaling without using CPPC.
> > I retested change on servers and non hybrids.
> >=20
> > > If Raptor Lake-E is not covered by an existing
> > > intel_hybrid_scaling_factor[] entry, why don't we add one for it
> > > with
> > > a "scaling factor" value indicating that CPPC needs to be used
> > > for
> > > computing it on all CPUs?
> >=20
> > It is already covered by existing, but we can only call
> > for intel_pstate_cppc_get_scaling() when hybrid_scaling_factor is
> > defined. This will require a hardcoding for Bartlett Lake also
> > which
> > uses different CPU model, which Henry Tseng is planing to send.
>=20
> I would add a new intel_hybrid_scaling_factor[] entry for Bartlett
> Lake then with a proper scaling factor along with the change above.

