Return-Path: <stable+bounces-245478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OChIVchA2r10gEAu9opvQ
	(envelope-from <stable+bounces-245478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:47:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267D52065B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C1A030778E0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC293AB5AB;
	Tue, 12 May 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHh1jqD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCB3812F8
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589447; cv=none; b=oIDy5paHUUlQI8xWqbNM5VPkVws/dDojyQePkUlSt+thnEJEhX7XT2bda7YDyK/oKZtEZF5dwb3Xh66lZsyOkv/CUHQ/kVVYWWwCX841Cly7zEuBpQUYhzOYglqFWNIqrLZgmXK5YVU+ZaNrc4RSWdKVhw0aAXHHVeJPGkOkzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589447; c=relaxed/simple;
	bh=DuVMza5iUPIUJ4S/iW1odGNYnuaSTN2j4lTMGVIW3vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c81YJrlSOVee+yA8KmI5h/jOftW8j/B9HPyFDMEsDZ3o3hhTjhE/W4q59X9zJN6SyvMY3qcXiTHRaOeTIaW0KVQXNWZkfq9ZLY1yqTUmEtrl3cRpB0NPBbmylwAS+BGRvnw8hytcDfNEe6Kn/BdNO6JQMzMCbwsjVaoz+hfv1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHh1jqD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8155C2BCF5
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778589445;
	bh=DuVMza5iUPIUJ4S/iW1odGNYnuaSTN2j4lTMGVIW3vA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IHh1jqD8sf6E2uD4LJwVhfO+jVfkFPhL/39nOClyfF8WOwfLGoQQZVGvFSwtdmhVb
	 M6PAykrUbmkc+jL3MoUjk2phL2t2tl2N7EhPtGfSDapynF8rMG8cbT+M8JcQysh7GI
	 CWFxV78/bOv3FYWt8UPh/RIPGjQN59PneEsHEJWGiqnBVyPujqKd+Ss8lLPjbjURb/
	 blOxFUWtm3A8uCBO3xznVUIZaEUEg2JiuA8cAnwySgOud6+fF71HOxXVAjSiGSBqPc
	 vdmhiTc2qS9IToMdslLiFkk4S6rQDEBDJtH49usg7nTnrO+PY4ttwr9qE4ZqvUZTGM
	 mEYjnWruzCo4A==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-394413a63d3so3629011fa.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 05:37:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8+4EvvCkkHMKlQPJJ/eHdq+lXpw2hzFo9J73nnW80xf4ZFWib9ch/mVCs+gpTGUDloy1KNzbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQx4uOAyRzbdiDA+zY+LGMWvlCz255eDStJL+DZJrBfvP/YWK/
	DMCVNmmly82ZmsAKGRUgzbIixfDTzz8k4h0OM9M2+m/dq5P4LeTzragJQihq+bQea2QXzKabdHH
	sMmtOJKtKDEoJu8MJPWh3aBfgu/qRt7g=
X-Received: by 2002:a05:6512:3e21:b0:5a8:6799:efb1 with SMTP id
 2adb3069b0e04-5a887cdebbcmr10041896e87.25.1778589444177; Tue, 12 May 2026
 05:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511235328.2018458-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0gVK7qF9Bfw952Vkb+-5WPOH+_M9-bRAwjJvHX3U=WOOg@mail.gmail.com> <3a6b3499a8f2d39bac2bcf483ee48123823795d9.camel@linux.intel.com>
In-Reply-To: <3a6b3499a8f2d39bac2bcf483ee48123823795d9.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 14:37:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0imv=-NRy1e1mvEYFcyryr7kqyCu+nEzGW=S+PSzDJHWA@mail.gmail.com>
X-Gm-Features: AVHnY4IZwyXmkNFk0i4LY7dMWA8hpaVkHe6hl_rw0wYZtQ8G-cI_hn4pYoRoARY
Message-ID: <CAJZ5v0imv=-NRy1e1mvEYFcyryr7kqyCu+nEzGW=S+PSzDJHWA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix Raptor Lake-E cpufreq limits
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Henry Tseng <henrytseng@qnap.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0267D52065B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245478-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qnap.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 1:15=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2026-05-12 at 12:20 +0200, Rafael J. Wysocki wrote:
> > On Tue, May 12, 2026 at 1:53=E2=80=AFAM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > Raptor Lake-E processors are not correctly showing cpufreq
> > > frequency
> > > limits.
> > >
> > > These CPUs don't set X86_FEATURE_HYBRID_CPU and have no E-cores,
> > > but
> > > P-cores still use hybrid scaling factor.
> > >
> > > commit 0fcfc9e51990 ("cpufreq: intel_pstate: Fix scaling for
> > > hybrid-capable systems with disabled E-cores") added support for
> > > such configuration. Here using CPPC nominal freq and perf was
> > > compared
> > > to still return hybrid scaling factor.
> > >
> > > Commit 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > > scaling
> > > factors") restructured hwp_get_cpu_scaling() and added an explicit
> > > check
> > > for X86_FEATURE_HYBRID_CPU and when not set returns core scaling
> > > factor.
> > >
> > > To address this remove check for X86_FEATURE_HYBRID_CPU and call
> > > intel_pstate_cppc_get_scaling().
> > >
> > > Ideally this change should be enough. But using CPPC for scaling
> > > factor
> > > results in rounding error, so still doesn't restore the original
> > > behavior.
> > >
> > > In intel_pstate_cppc_get_scaling() return core scaling factor when
> > > ACPI CPPC is not present or when CPPC nominal frequency or nominal
> > > performance are invalid.
> > >
> > > Use hybrid_scaling_factor for P-cores when defined for a CPU, if
> > > not
> > > calculate from ACPI CPPC nominal frequency and performance.
> > >
> > > Fixes: 9b18d536b124 ("cpufreq: intel_pstate: Use CPPC to get
> > > scaling factors")
> > > Reported-by: Henry Tseng <henrytseng@qnap.com>
> > > Closes:
> > > https://lore.kernel.org/linux-pm/20260508063032.3248602-1-henrytseng@=
qnap.com/
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  drivers/cpufreq/intel_pstate.c | 29 +++++++++++++++--------------
> > >  1 file changed, 15 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > b/drivers/cpufreq/intel_pstate.c
> > > index 1292da53e5fc..0379efdee5f8 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -421,15 +421,23 @@ static int intel_pstate_cppc_get_scaling(int
> > > cpu)
> > >  {
> > >         struct cppc_perf_caps cppc_perf;
> > >
> > > +       if (cppc_get_perf_caps(cpu, &cppc_perf) ||
> > > !cppc_perf.nominal_freq ||
> > > +           !cppc_perf.nominal_perf)
> > > +               goto core_scaling;
> > > +
> > > +       if (cppc_perf.nominal_perf * 100 =3D=3D cppc_perf.nominal_fre=
q)
> > > +               goto core_scaling;
> > > +
> > > +       if (hybrid_scaling_factor)
> > > +               return hybrid_scaling_factor;
> > > +
> > >         /*
> > > -        * Compute the perf-to-frequency scaling factor for the
> > > given CPU if
> > > -        * possible, unless it would be 0.
> > > +        * Compute the perf-to-frequency scaling factor for the
> > > given CPU
> > > +        * from nominal freq and nominal_perf
> > >          */
> > > -       if (!cppc_get_perf_caps(cpu, &cppc_perf) &&
> > > -           cppc_perf.nominal_perf && cppc_perf.nominal_freq)
> > > -               return div_u64(cppc_perf.nominal_freq *
> > > KHZ_PER_MHZ,
> > > -                              cppc_perf.nominal_perf);
> > > +       return div_u64(cppc_perf.nominal_freq * KHZ_PER_MHZ,
> > > cppc_perf.nominal_perf);
> > >
> > > +core_scaling:
> > >         return core_get_scaling();
> > >  }
> > >
> > > @@ -2281,17 +2289,10 @@ static int hwp_get_cpu_scaling(int cpu)
> > >                  */
> > >                 if (hybrid_get_cpu_type(cpu) =3D=3D
> > > INTEL_CPU_TYPE_CORE)
> > >                         return hybrid_scaling_factor;
> > > -
> > > -               return core_get_scaling();
> >
> > Why is this change necessary or even useful?
> >
> > This is about E-cores (because P-cores have been covered above) and
> > if
> > hybrid_scaling_factor is set, it is known that the processor is
> > hybrid
> > and E-cores have the "core" scaling factor.
> >
> > Or is Raptor Lake-E covered by one of the
> > intel_hybrid_scaling_factor[] entries and hybrid_get_cpu_type(cpu)
> > doesn't return INTEL_CPU_TYPE_CORE on it?  This piece of information
> > is missing from the changelog.
>
> Raptor Lake-E (Xeon) uses CPU model as Raptor Lake-S, for which there
> is already a hardcoded scaling factor in the driver.

This piece of information needs to be added to the changelog in the
first place because it is key here.

> So this "if" block will enter. But since there is no hybrid CPUID feature=
 is defined,
> hybrid_get_cpu_type(cpu) will return 0 for P-core or E-core. Here there
> are no E-cores. So need to remove core_get_scaling() as this will
> return non hybrid factor.

Well, what about this:

---
 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2279,7 +2279,7 @@ static int hwp_get_cpu_scaling(int cpu)
          * Return the hybrid scaling factor for P-cores and use the
          * default core scaling for E-cores.
          */
-        if (hybrid_get_cpu_type(cpu) =3D=3D INTEL_CPU_TYPE_CORE)
+        if (hybrid_get_cpu_type(cpu) !=3D INTEL_CPU_TYPE_ATOM)
             return hybrid_scaling_factor;

         return core_get_scaling();

Or is the original Raptor Lake-S scaling factor unsuitable for Raptor Lake-=
E?

>
>
> >
> > >         }
> > >
> > > -       /* Use core scaling on non-hybrid systems. */
> > > -       if (!cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
> > > -               return core_get_scaling();
> > > -
> >
> > So we're now exposing all of the non-hybrid processors to the fun
> > with
> > possibly incorrectly populated CPPC, which is kind of risky.
> >
>
> This was already used before with
> commit0fcfc9e51990246a9813475716746ff5eb98c6aa
> relying that all non hybrid processor (including servers) didn't set
> nominal frequency, so will return core_scaling without using CPPC.
> I retested change on servers and non hybrids.
>
> > If Raptor Lake-E is not covered by an existing
> > intel_hybrid_scaling_factor[] entry, why don't we add one for it with
> > a "scaling factor" value indicating that CPPC needs to be used for
> > computing it on all CPUs?
>
> It is already covered by existing, but we can only call
> for intel_pstate_cppc_get_scaling() when hybrid_scaling_factor is
> defined. This will require a hardcoding for Bartlett Lake also which
> uses different CPU model, which Henry Tseng is planing to send.

I would add a new intel_hybrid_scaling_factor[] entry for Bartlett
Lake then with a proper scaling factor along with the change above.

