Return-Path: <stable+bounces-111231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A45A22478
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 20:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156A2165582
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1BA1E2606;
	Wed, 29 Jan 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsRKp1ZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A2B194089
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738178080; cv=none; b=BCWTAyKItdEW62rPH51FX32nORVLmIqikbeieWqyhSHAziR/SsiUhp6Uk/TbOd7jxOuI74C1vpi34mrhXW7lMY/Q+DkxLqVgd/YKfRFq2FwGnAFcWfX+VEI7sBX57EMCghhmzcuSL+M4UlvetQNXc3SbtGxOzWK1Qro4oJroupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738178080; c=relaxed/simple;
	bh=ER8lqBAZcv6KsLLhT5KhhBA7/CdCOEuki7UUP/RCSS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgSN2EgIUG/ysh1LMjFvw3VHLR0GjSPgXI/J4xn/nQdgCEFjOQ2tyTAS1tyHhpTvYzdoKT6Zk4+MeyyvNXnmTcWEyxozh8iSYbiuOmwQeHXgIjRAKv1laGqw7D6527CFvrPNQagKIkQuapRxN0E6gxQW2ykl/r576yUA1j3t87s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GsRKp1ZK; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so54759601fa.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 11:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738178074; x=1738782874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9cVYaCEgnAXitcL12ziEbi8qnnUEvX6uA7m4++DLeU=;
        b=GsRKp1ZK9yLkGzlG7s4431RqZIcOWFpXFK7E1FggaCvDxn0cXHs9sqpwNOdoTo/BVr
         tWUawwc0ki4h7l7n/0XO3yguhxhKpJWLzE9/h3G9oVrembBIuYeBus0ybudLWNUbfujv
         wEF7Usut3eS8zyq+j2LCqI7BcyoMIS865oJDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738178074; x=1738782874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9cVYaCEgnAXitcL12ziEbi8qnnUEvX6uA7m4++DLeU=;
        b=vjh99FpK+KoM399c+twIqZJ61tDncVnKtqNaIdYcgFgqBvsMEGHFuRAboGJ6kl3+zm
         e20uvn5SHDxZt8Hl0lR1kOkPUc+zEky4hfnOu1FWZSqU8saw5dYPldMWDgMgH6L+8SJz
         HzgQTnUTN7H/DgLHcHWzcAygkz+Kw+Fa7U/26jzqatF+wxxmP9xWcX5U+K493HUM8prD
         BytQUoY8y42H3ivUXafUwC8wvnGDk0GLddXz7yIr5DwmNcbjkEbg6TMa8x0okEU3KL1s
         t+cUuCfutkf9ObA1L97h9KBwLEwrkYnjCMuO4gF+qMLxrCMNgdy5Y5F4pA6SLFKGfX1t
         mbdg==
X-Forwarded-Encrypted: i=1; AJvYcCVDP9Hnei5G3oPihFLCRxZJm3RodioaWTIxtV1XvpJEbXQFcMSLUdZBlIzH5C6Jm8yTVbeSIFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRIXVn+JTgwZhQEOk0Xkg6CSDulPdijgs806Y9MdxzIg8jyAx
	1M2sYQxCG0wQHOmeaagJA/Ty7TGGidZF3cfAku1pHAsaKJ1UCzYb4QaEhJR3v6jcDOh9Hdy8V/Q
	/VA==
X-Gm-Gg: ASbGncvc9JydpMyOvqaMvb8xzF0KeD9zPyl74UJf0gj3m+RqPYSEaFVIbhyFbnNHsjP
	ZttZGfFa24srpMXhak1IFIg4HhUxMegPirEidg5qm5w3FldmVd6xpU4UNVoi8sJ1L5aYrv563Rf
	gWo0aMTz00ZyCQhLNqXoOsq7HfzwH0URFtX4dYeRl/MaYo1U5HgBef36grhchdmV/eROK+3n31q
	fjRk3qRn46vgdA7jqThm22jWlBkyGHteKBi9sjQtTAmuAfmZl4zOI8kM+36buNbUNixd/RYpndw
	bKQViRkFcSCh3kINhAALOr3D7bqTMYA17SCUqKm8ZJA9Ss43ySi9zMx+xTE=
X-Google-Smtp-Source: AGHT+IGcjhSl2bHBup1kA9XFixLHgA7WpjTb1h4pJITj6E+MWKhGWifPYr1G6Vkc9qB531VSrx6XWA==
X-Received: by 2002:a05:651c:150a:b0:302:5308:ba48 with SMTP id 38308e7fff4ca-3079684eb6bmr15765061fa.12.1738178073549;
        Wed, 29 Jan 2025 11:14:33 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3076bc51543sm21786451fa.108.2025.01.29.11.14.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 11:14:32 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-306007227d3so72921781fa.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 11:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWQBsmiblnQl7L1EnfmrD2Kxp7MYlFHGx/FDP3D1kcTZnBPgCKqiTuNGbWf+An7nl7aJjQHUs=@vger.kernel.org
X-Received: by 2002:ac2:4c10:0:b0:543:baca:6f22 with SMTP id
 2adb3069b0e04-543e4c3a1b8mr1212346e87.33.1738178071558; Wed, 29 Jan 2025
 11:14:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107200715.422172-1-dianders@chromium.org>
 <20250107120555.v4.2.I2040fa004dafe196243f67ebcc647cbedbb516e6@changeid> <e6820d63-a8da-4ebb-b078-741ab3fcd262@arm.com>
In-Reply-To: <e6820d63-a8da-4ebb-b078-741ab3fcd262@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Jan 2025 11:14:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WTe-yULo9iVUX-4o8cskPNp8dK-N9pKq6MxqrPX3UMGw@mail.gmail.com>
X-Gm-Features: AWEUYZn5hR5EGwLlUS7JXsgHfNwD6Le_AQBkJPOKlult6Zu_h1QVTzgrlfd7LL8
Message-ID: <CAD=FV=WTe-yULo9iVUX-4o8cskPNp8dK-N9pKq6MxqrPX3UMGw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: errata: Assume that unknown CPUs _are_
 vulnerable to Spectre BHB
To: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Roxana Bradescu <roxabee@google.com>, 
	Julius Werner <jwerner@chromium.org>, bjorn.andersson@oss.qualcomm.com, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	Jeffrey Hugo <quic_jhugo@quicinc.com>, Scott Bauer <sbauer@quicinc.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Wed, Jan 29, 2025 at 8:43=E2=80=AFAM James Morse <james.morse@arm.com> w=
rote:
>
> Hi Doug,
>
> On 07/01/2025 20:05, Douglas Anderson wrote:
> > The code for detecting CPUs that are vulnerable to Spectre BHB was
> > based on a hardcoded list of CPU IDs that were known to be affected.
> > Unfortunately, the list mostly only contained the IDs of standard ARM
> > cores. The IDs for many cores that are minor variants of the standard
> > ARM cores (like many Qualcomm Kyro CPUs) weren't listed. This led the
> > code to assume that those variants were not affected.
> >
> > Flip the code on its head and instead assume that a core is vulnerable
> > if it doesn't have CSV2_3 but is unrecognized as being safe. This
> > involves creating a "Spectre BHB safe" list.
> >
> > As of right now, the only CPU IDs added to the "Spectre BHB safe" list
> > are ARM Cortex A35, A53, A55, A510, and A520. This list was created by
> > looking for cores that weren't listed in ARM's list [1] as per review
> > feedback on v2 of this patch [2]. Additionally Brahma A53 is added as
> > per mailing list feedback [3].
> >
> > NOTE: this patch will not actually _mitigate_ anyone, it will simply
> > cause them to report themselves as vulnerable. If any cores in the
> > system are reported as vulnerable but not mitigated then the whole
> > system will be reported as vulnerable though the system will attempt
> > to mitigate with the information it has about the known cores.
>
> > arch/arm64/include/asm/spectre.h |   1 -
> > arch/arm64/kernel/proton-pack.c  | 203 ++++++++++++++++---------------
> > 2 files changed, 102 insertions(+), 102 deletions(-)
>
> This is a pretty hefty diff-stat for adding a list of six CPUs. It looks =
like there are
> multiple things going on here: I think you're adding the 'safe' list of C=
PUs, then
> removing the list of firmware-mitigated list, then removing some indentat=
ion to do the
> mitigation detection differently. Any chance this can be split up?

I have to get back into the headspace of this patch since it's been a
few weeks, but let's see.

At the end, you suggest that maybe we could simplify this patch by
just adding the function is_spectre_bhb_safe(), calling it at the
beginning of is_spectre_bhb_affected(), and then changing
is_spectre_bhb_affected() to return "true" at the end instead of
false. Looking back at the patch, I believe this is correct.

...that being said, all of the other changes that are part of this
patch came in response to review feedback on earlier versions of the
patch and do make sense. Specifically:

1. Once the default value is to return false, there's not a reason to
call supports_clearbhb() and is_spectre_bhb_fw_affected() in
is_spectre_bhb_affected(), right? Those two functions _only_ job was
to be able to cause is_spectre_bhb_affected() to sometimes return
"true" instead of "false", but the function returns true by default
now so the calls have no purpose.

2. After we do #1, it doesn't really make sense to still have the
snippet of code that looks like this:

  if (spectre_bhb_loop_affected(scope))
    return true;

  return true;

We could just change that to:

  spectre_bhb_loop_affected(scope)
  return true;

...but then it seems really strange to call a function that returns a
value and we're ignoring it. As per review feedback on the previous
versions, I moved the calculation of "max_bhb_k" out of
spectre_bhb_loop_affected() and made that just for local scope and it
turned out much cleaner.

3. Given that we no longer have a reason to call
is_spectre_bhb_fw_affected() in is_spectre_bhb_affected(), it also
made sense to get rid of the "scope" variable for that function and
simplify it and the other caller.

...so I could break some of that stuff up into separate patches, but I
don't think we'd just want to drop any of the changes.


> (I'm not sure about the last chunk - it breaks automatic backporting)

Why would it break things? This entire series should just be
backported including the change of the default value to "affected". If
someone is running an old "stable" kernel and they're missing a
mitigation this would make it more obvious to them. Without
backporting everything then people running old kernels but lacking a
needed FW mitigation would show as "unaffected" when really they are
"vulnerable".


> > diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton=
-pack.c
> > index e149efadff20..17aa836fe46d 100644
> > --- a/arch/arm64/kernel/proton-pack.c
> > +++ b/arch/arm64/kernel/proton-pack.c
>
>
> > +static u8 spectre_bhb_loop_affected(void)
> >  {
> >       u8 k =3D 0;
> > -     static u8 max_bhb_k;
> > -
> > -     if (scope =3D=3D SCOPE_LOCAL_CPU) {
> > -             static const struct midr_range spectre_bhb_k32_list[] =3D=
 {
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
> > -                     MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> > -                     MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> > -                     {},
> > -             };
> > -             static const struct midr_range spectre_bhb_k24_list[] =3D=
 {
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
> > -                     MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> > -                     MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
> > -                     {},
> > -             };
> > -             static const struct midr_range spectre_bhb_k11_list[] =3D=
 {
> > -                     MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> > -                     {},
> > -             };
> > -             static const struct midr_range spectre_bhb_k8_list[] =3D =
{
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> > -                     MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> > -                     {},
> > -             };
> > -
> > -             if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k3=
2_list))
> > -                     k =3D 32;
> > -             else if (is_midr_in_range_list(read_cpuid_id(), spectre_b=
hb_k24_list))
> > -                     k =3D 24;
> > -             else if (is_midr_in_range_list(read_cpuid_id(), spectre_b=
hb_k11_list))
> > -                     k =3D 11;
> > -             else if (is_midr_in_range_list(read_cpuid_id(), spectre_b=
hb_k8_list))
> > -                     k =3D  8;
> > -
> > -             max_bhb_k =3D max(max_bhb_k, k);
> > -     } else {
> > -             k =3D max_bhb_k;
> > -     }
> > +
> > +     static const struct midr_range spectre_bhb_k32_list[] =3D {
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A78AE),
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
> > +             MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> > +             MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
> > +             {},
> > +     };
> > +     static const struct midr_range spectre_bhb_k24_list[] =3D {
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
> > +             MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
> > +             MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
> > +             {},
> > +     };
> > +     static const struct midr_range spectre_bhb_k11_list[] =3D {
> > +             MIDR_ALL_VERSIONS(MIDR_AMPERE1),
> > +             {},
> > +     };
> > +     static const struct midr_range spectre_bhb_k8_list[] =3D {
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> > +             MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> > +             {},
> > +     };
> > +
> > +     if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k32_list))
> > +             k =3D 32;
> > +     else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k24_l=
ist))
> > +             k =3D 24;
> > +     else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k11_l=
ist))
> > +             k =3D 11;
> > +     else if (is_midr_in_range_list(read_cpuid_id(), spectre_bhb_k8_li=
st))
> > +             k =3D  8;
> >
> >       return k;
> >  }
>
> This previous hunk reduces the indent to remove the static variable from =
inside the
> function. Your patch-1 can be picked up automatically by stable branches,=
 but after this
> change, that will have to be done by hand.

As per above, I think the whole series should simply be backported so
this shouldn't be an issue.


> Arm have recently updated that table of CPUs
> with extra entries (thanks for picking those up!) - but now that patch ca=
n't be easily
> applied to older kernels.
> I suspect making the reporting assuming-vulnerable may make other CPUs co=
me out of the
> wood work too...
>
> Could we avoid changing this unless we really need to?

Will / Catalin: Do either of you have an opinion here?


> As background, the idea is that CPUs that are newer than the kernel will =
discover the need
> for mitigation from firmware. That sucks for performance, but it can be i=
mproved once the
> kernel is updated to know about the 'local' workaround.
>
>
> > @@ -955,6 +956,8 @@ static bool supports_ecbhb(int scope)
> >                                                   ID_AA64MMFR1_EL1_ECBH=
B_SHIFT);
> >  }
> >
> > +static u8 max_bhb_k;
> > +
> >  bool is_spectre_bhb_affected(const struct arm64_cpu_capabilities *entr=
y,
> >                            int scope)
> >  {
> > @@ -963,16 +966,18 @@ bool is_spectre_bhb_affected(const struct arm64_c=
pu_capabilities *entry,
> >       if (supports_csv2p3(scope))
> >               return false;
> >
> > -     if (supports_clearbhb(scope))
> > -             return true;
> > -
> > -     if (spectre_bhb_loop_affected(scope))
> > -             return true;
> > +     if (is_spectre_bhb_safe(scope))
> > +             return false;
> >
> > -     if (is_spectre_bhb_fw_affected(scope))
> > -             return true;
> > +     /*
> > +      * At this point the core isn't known to be "safe" so we're going=
 to
> > +      * assume it's vulnerable. We still need to update `max_bhb_k` th=
ough,
> > +      * but only if we aren't mitigating with clearbhb though.
>
> +       or firmware.

No, I believe my comment is correct as-is. The code in
spectre_bhb_enable_mitigation() prior to my change prefers a loop
mitigation over a firmware mitigation. My patch doesn't change that
behavior. So we'll always update `max_bhb_k` even if there is a FW
mitigation that might be in place. Updating it by comparing it to a
value that might be 0 is still an "update" in my mind.

If a FW mitigation _is_ needed for a given core then
spectre_bhb_loop_affected() should return a "k" of 0. That will fall
through to the FW mitigation.

...so in the context of this code here, we always will "update"
`max_bhb_k` regardless of whether there is a firmware mitigation.


> > +      */
> > +     if (scope =3D=3D SCOPE_LOCAL_CPU && !supports_clearbhb(SCOPE_LOCA=
L_CPU))
> > +             max_bhb_k =3D max(max_bhb_k, spectre_bhb_loop_affected())=
;
>
> CPUs that need a firmware mitigation will get in here too. Its probably h=
armless as
> they'll report '0' as their k value... but you went to the trouble to wee=
d out the CPUs
> that support the clearbhb instruction ...

In order to understand why the patch does what it does, I got all my
understanding of how mitigations should be applied by maintaining the
existing behavior of spectre_bhb_enable_mitigation(). Specifically, if
a FW mitigation is _needed_ for a given core then it's important that
spectre_bhb_loop_affected() return 0. This means that whoever wrote
that code assumes that the loop mitigation trumps the FW mitigation.

I don't think there's any other reason for weeding more CPUs out.


> For the change described in the commit message, isn't it enough to replac=
e the final
> 'return false' with 'return !is_spectre_bhb_safe(scope)' ?

See my response to your first comment.


So I guess in summary I won't plan on sending a v5 at this time and
I'd hope that v4 can still land (maybe Qualcomm can give an Ack?). If
necessary I could break this patch into more than one to break the
diffstat into multiple patches, but I'd prefer to still keep the
resulting code the same. I like how it turned out and it matches all
the existing review feedback that Julius provided. If Will or Catalin
wants to come in or enough other people come in and vote that I should
make more changes, then I could do it.

I could move the last two patches up to the front and send a v5 if
needed. That would make the short term job of backporting those
faster, but any future cores would have the same problem. As per
above, I'm of the opinion that the whole series should go to stable
for as far back as people are willing to take them (which is why I
CCed stable on all the patches)


-Doug

