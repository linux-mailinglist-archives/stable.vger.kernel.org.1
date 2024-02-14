Return-Path: <stable+bounces-20224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596E85576D
	for <lists+stable@lfdr.de>; Thu, 15 Feb 2024 00:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F056328B924
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 23:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE41420C8;
	Wed, 14 Feb 2024 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLCjfMJx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490C13DB90
	for <stable@vger.kernel.org>; Wed, 14 Feb 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954345; cv=none; b=nS3E05hrnTKToS8TlbqSJfNdGiQ8eA9NZZ9f+otv7JfQZHo5ujDPWOmWez4Zvga19vrJOMuY4yXP0WVLE4rom5STdU92ztC1wYf2coOAOqweuFKUf2SjB2WJaF6imFz8aei2m8Cp7SEWnC5ehn8edKO9py81NfMf9CG6Xva3mGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954345; c=relaxed/simple;
	bh=b10hcijK0qE3BkNp8u5VgKtBYxQGdaTD5bm686/cKgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcOlccd6e3J1DLMMxgmhKj/r9AnXsq68N44ifhX36yqORqafktd81LJgvcdWXUOUmsAWQ9LR5CcZ/MQ1Ez+jkSWP3wssqraKE1GqTDY9bolS62yZ97lJ/Ug0dExq2MpjssyXE0EjfmTJ0sxhXZv1o/+wG7w2TvPGQPhbQ8xV4M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLCjfMJx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5ce88b51cso47435ad.0
        for <stable@vger.kernel.org>; Wed, 14 Feb 2024 15:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707954342; x=1708559142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5gly/VFOoLySfRJOHKm6JFRHLJyyId6LtcsyMKAaXs=;
        b=fLCjfMJx26kvH/a7e+AQNb5a7oa5KYsOJ06rk4iKwdq05QEjTevilVAWQsDaVv82af
         /iD5LFFinVPpHlbv4P54VM0K0A898IZX0qIXDe7gs3xJXkM4ySGXwKjFhMMUY/TH1B6H
         UA7sCPXT6dLwpao+CQjw5Eoow+1wwZts1pxEYmM87aZ4cFR2zQ+bPxIL44lPcr8aLBl1
         SacTwpZVD3/PhYCUP0uV+jDuNSvp8hqelSd/cKRHrLtoN1xVgLanTgGSGPER0DEi6kB0
         xGRf+re8G995TwBB6ZHgbnma7lSln/KmrFDgX+89m78eYwoQRQr3pdi+JMoDw7EGFvEe
         BQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707954342; x=1708559142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5gly/VFOoLySfRJOHKm6JFRHLJyyId6LtcsyMKAaXs=;
        b=tzmQtQbUHLnaOBDq7r+MTv09rU+ISFPgphUb/uz9c2wpyat5r2W2dbLlFZsodMeFA/
         +0m3kVboHtb7rSuD1ZMMJ4WlQx/RNtlYU+u5v8w6/9kKAgoAKJosEMPX34J+IAOR7tu1
         oJ2TXHylZ/x6LOvpzMxPBeQlukdTySYkemCn8TeMcvN+9/BWt7Aj56iE2Ky2lhTQ1Zx7
         olu+sCUHltemFgdEo1QGoZVjNqd2yUsKFW396sbE14Nc1Z8uYKWFuHDw6CfXxzIAt4Px
         dis8tpeOpzrOw6cHnY3k91ypmRgjuf5ZkEYAW46CEQYGx/2+AtwPL2Yc2RXwn5pB755x
         4kUw==
X-Forwarded-Encrypted: i=1; AJvYcCXnkIVTi8tpV2MT0fULR+sWvqu8pRg1++LQwCmVBBBc0T7Z9U0xiil042tjO27aBpm9P9RZL4zL+JPjGNfU8H269u9dEpon
X-Gm-Message-State: AOJu0Yxd6RxwfedEIQ3+KcjeTEZD+OxnPdHHIFmgVLq7CtGwyQqK4kBn
	3hLHOUw9kV5GIMMOiA6Az6LvbHNFK/GKT98Dnzbl7F7w0Qo0kh8uouweTco4oxM+TIUNcKRfMLn
	9KeBh9P97gkSE442LmQzAdixa4SX4L+mx3Vlk
X-Google-Smtp-Source: AGHT+IHVwUB8LIh0FA6G+cYFDq6/LDCPW9SbA6YjALRn94EPRW5oD0V+gydguAGzjtnOf5jkpbatb3l7pLynjaUHRGY=
X-Received: by 2002:a17:902:d101:b0:1d8:b92a:336 with SMTP id
 w1-20020a170902d10100b001d8b92a0336mr371114plw.7.1707954341932; Wed, 14 Feb
 2024 15:45:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214155740.3256216-1-kan.liang@linux.intel.com>
In-Reply-To: <20240214155740.3256216-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Feb 2024 15:45:27 -0800
Message-ID: <CAP-5=fVeQdNYPwxc02KVCM0uAhw0u5im99gZKvAo4NTvA+nUuw@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the bits of the CHA extended
 umask for SPR
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@kernel.org, acme@kernel.org, 
	namhyung@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mpetlan@redhat.com, eranian@google.com, 
	ak@linux.intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 7:58=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
> event.
>
>  $perf stat -e uncore_cha_55/event=3D0x35,umask=3D0x10c0008101/ -a -- ls
>     event syntax error: '..0x35,umask=3D0x10c0008101/'
>                                       \___ Bad event or PMU
>
> The definition of the CHA umask is config:8-15,32-55, which is 32bit.
> However, the umask of the event is bigger than 32bit.
> This is an error in the original uncore spec.
>
> Add a new umask_ext5 for the new CHA umask range.
>
> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server C=
HA support")
> Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.24013007=
33310.11354@Diego/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  arch/x86/events/intel/uncore_snbep.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel=
/uncore_snbep.c
> index a96496bef678..7924f315269a 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -461,6 +461,7 @@
>  #define SPR_UBOX_DID                           0x3250
>
>  /* SPR CHA */
> +#define SPR_CHA_EVENT_MASK_EXT                 0xffffffff
>  #define SPR_CHA_PMON_CTL_TID_EN                        (1 << 16)
>  #define SPR_CHA_PMON_EVENT_MASK                        (SNBEP_PMON_RAW_E=
VENT_MASK | \
>                                                  SPR_CHA_PMON_CTL_TID_EN)
> @@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8=
-15,32-43,45-55");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
>  DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
> +DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
>  DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
>  DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
>  DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
> @@ -5957,7 +5959,7 @@ static struct intel_uncore_ops spr_uncore_chabox_op=
s =3D {
>
>  static struct attribute *spr_uncore_cha_formats_attr[] =3D {
>         &format_attr_event.attr,
> -       &format_attr_umask_ext4.attr,
> +       &format_attr_umask_ext5.attr,
>         &format_attr_tid_en2.attr,
>         &format_attr_edge.attr,
>         &format_attr_inv.attr,
> @@ -5993,7 +5995,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
>  static struct intel_uncore_type spr_uncore_chabox =3D {
>         .name                   =3D "cha",
>         .event_mask             =3D SPR_CHA_PMON_EVENT_MASK,
> -       .event_mask_ext         =3D SPR_RAW_EVENT_MASK_EXT,
> +       .event_mask_ext         =3D SPR_CHA_EVENT_MASK_EXT,
>         .num_shared_regs        =3D 1,
>         .constraints            =3D skx_uncore_chabox_constraints,
>         .ops                    =3D &spr_uncore_chabox_ops,
> --
> 2.35.1
>

