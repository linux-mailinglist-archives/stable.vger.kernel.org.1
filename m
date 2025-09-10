Return-Path: <stable+bounces-179208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB807B51DE4
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BCD3BB0FD
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A46A270ED7;
	Wed, 10 Sep 2025 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="MEGx7w4A"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEEF26F2B9
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522235; cv=none; b=mbpFPnZgmTD6ueO7zv+lmhD4QbQpKSDkXjlX5Nsey5SEkgiZw8ARavndOPDrpXkwNbOuOsX7YlK91qU/Kp8NBJlaTLh9P2np2xhmAzPRtAUEbOqfLJmBC7+zG2KCwCeW0jBe+0o+Ge9+S92G458DRpxK/Mhi/6Z1M1s3ejOJdsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522235; c=relaxed/simple;
	bh=D7+1Jtko4vGFBtZ3b9PtA52nn3hdE+r4sdDTEiZ9DIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPlnOco7DUSaasrvNDSqdXJt4shC7pw8Xubf/Ncn/j8N6FNN1FFx+4IFD2m5Xu4OJRid4nH9YeuQJjvyAEqrtzNTdLyTmEubRaEW/zi/R4e+AeDOmXeaV+frviE9Ni5VBZvwXpj+4IdJ3OdYCuHVRsm0O1gcHloiLn+ciLbp0ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=MEGx7w4A; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-40b035b23c6so17427775ab.2
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1757522232; x=1758127032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5PHdX8GAxuQZU4FPQQfLC6oiU9UUSdStUhO8V11U/BI=;
        b=MEGx7w4ABZdm126HTNA3s4s0PSDKCS3OOLXr47+IaN8cVf/aoJSJyepbAPxjWF3vNt
         eKEhp+bDQ/cS84luZDF9WrjX/JQSpJS1lSZKJvj1pWrvXeK0PtRTN95hJWUJ4mSjBefo
         RMoBa5MFEi9cieAPzBBycDMBw25U743V8q8XNwSmtmCwQbD8KX74j6ETivflnUAuYidK
         UmprWnN+5ZZxSXQsn0mQEK0B/ND2FKctk88eWYC4b11BpH8MdMgDUAmEY9FtE56HhOLU
         0Jrp5QQEQQiW7RVQXLMOoncdmdi/f8/GHXl2g6ZHnDRY9O7lZ6ii7nWiCuk1j9fLO+Q4
         TA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522232; x=1758127032;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5PHdX8GAxuQZU4FPQQfLC6oiU9UUSdStUhO8V11U/BI=;
        b=OMIphdWfEvE4cGsLxDxMKZxDyzaP6v0xStryG/NiQ6oceDM/WD/HFiaUNbYUJgJPm1
         ZepQQDTq45lILqDNFWafNf4cMqpB22DSVQOAAWysS53XFgs8nyNzLDkZz1EWjFMEXoxS
         y0ZCosZwDszSr9NW3HGfFDzkUhRmmi6fYFx8hyzFOIjfoibUBMvngDflBEF/knBWtt0C
         JGLhVVNtDNerldETD2rg+HEyCWctIjKk5sKfM/d8RkBBVQeOkTQK4IqccF7nMvUou5Zp
         fnqzJ23Z7Fj/MxGqbhfubiWIGk8cfkCtK6CCeXwv9/ONWNmaRTw/0v+pvzjmT3X8ys8k
         06Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWkWLPGlLdGaA/VfMRK/BDFJ9P+WWgNO6HVOGsfRp4/rsE/65+jhjNr2g0BmdM5Enk5QOlCV3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe50fJ1VF5SLjaKGcZlSvpFAXx9IM8GOt9ILUXfkmIuesAhOQ8
	3+4xTkp2G3BI+lHZAQUfj+2NzsEBR1h4Zy2drMgk6ACYS7LQ7XBMWy5IQ3+vFOU92ig=
X-Gm-Gg: ASbGnctqV/pr5enMUtUCw/p1BouMm6AyjQZwPr+5lbCOpRgvhW5Ov0JfxjW6UVugqFW
	yvurGPgJ2TjFZM4hhxgrjE58GHGfG1Qt9EhvV5ociu4bIt+R6HC4RKKTFWumrAFAlwmAoiX4382
	f6B1GE+YxvG9GLFrhYz7tuu/9d/LdUdhjce14P35nCabiYxjldD3YkkEiRDJxp6ru3BSY6NDysa
	SBrrh7p6CBcoNTnP64MmPgvP5/1KZ+N9OCOYvnFhtsdJeU9WbTat8nHHX7G+q++944lwL1GjXoT
	rDHrktjIuz8pNWP162Do4BVAKiVwWvf0CLJKQQElqIfhfixbSy9OXJjhe8jKXnUk6ZH0cht0Kwh
	1CwnTOszVfrMZ6PZklxV1ogd+i0l5oA==
X-Google-Smtp-Source: AGHT+IGBAC+NF9eQWXe2qgtcaHE/zyQFVP7RCp/eYumttsidkm4pYYuSbUHJdDdCHsm7TKN2JhGJKw==
X-Received: by 2002:a05:6e02:1c0f:b0:418:f658:acbc with SMTP id e9e14a558f8ab-418f658ae4bmr28223245ab.20.1757522232476;
        Wed, 10 Sep 2025 09:37:12 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:cfaa:41d:4be0:7e8b:71d9:233b])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4049b300638sm42214305ab.10.2025.09.10.09.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:37:12 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:36:50 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, mmikowski@kfocus.org
Subject: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
Message-ID: <20250910113650.54eafc2b@kf-m2g5>
In-Reply-To: <CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
	<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
Organization: Kubuntu Focus
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 16:29:09 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > When turbo mode is unavailable on a Skylake-X system, executing the
> > command:
> > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > results in an unchecked MSR access error: WRMSR to 0x199
> > (attempted to write 0x0000000100001300).
> >
> > This issue was reproduced on an OEM (Original Equipment
> > Manufacturer) system and is not a common problem across all
> > Skylake-X systems.
> >
> > This error occurs because the MSR 0x199 Turbo Engage Bit (bit 32)
> > is set when turbo mode is disabled. The issue arises when
> > intel_pstate fails to detect that turbo mode is disabled. Here
> > intel_pstate relies on MSR_IA32_MISC_ENABLE bit 38 to determine the
> > status of turbo mode. However, on this system, bit 38 is not set
> > even when turbo mode is disabled.
> >
> > According to the Intel Software Developer's Manual (SDM), the BIOS
> > sets this bit during platform initialization to enable or disable
> > opportunistic processor performance operations. Logically, this bit
> > should be set in such cases. However, the SDM also specifies that
> > "OS and applications must use CPUID leaf 06H to detect processors
> > with opportunistic processor performance operations enabled."
> >
> > Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38,
> > verify that CPUID.06H:EAX[1] is 0 to accurately determine if turbo
> > mode is disabled.
> >
> > Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current
> > no_turbo state correctly") Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> Cc: stable@vger.kernel.org
> > ---
> >  drivers/cpufreq/intel_pstate.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c index f41ed0b9e610..ba9bf06f1c77
> > 100644 --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -598,6 +598,9 @@ static bool turbo_is_disabled(void)
> >  {
> >         u64 misc_en;
> >
> > +       if (!cpu_feature_enabled(X86_FEATURE_IDA))
> > +               return true;
> > +
> >         rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
> >
> >         return !!(misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
> > -- =20
>=20
> Applied as a fix for 6.15-rc, thanks!
>=20

FYI, this seems to have broken turbo boost on some Clevo systems with
an Intel Core i9-14900HX CPU. These CPUs obviously support turbo boost,
and kernels without this commit have turbo boost working properly, but
after this commit turbo boost is stuck disabled and cannot be
enabled by writing to /sys/devices/system/cpu/intel_pstate/no_turbo. I
made a bug report about this against Ubuntu's kernel at [1], which is
the only report I know that is able to point to this commit as having
broken things. However, it looks like an Arch Linux user [2] and a
Gentoo user [3] are running into the same thing.

[1] https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2122531

[2] https://bbs.archlinux.org/viewtopic.php?id=3D305564

[3] https://forums.gentoo.org/viewtopic-p-8866128.html?sid=3De97619cff0d9c7=
9c2eea2cfe8f60b0d3

