Return-Path: <stable+bounces-179221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FB8B52258
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 22:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5C44851A8
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 20:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA952EFDAE;
	Wed, 10 Sep 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b="x0VoysvS"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF172EFD92
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757536419; cv=none; b=F3JA4KUlNeWRX0jB9zsFOgnNgqfjuevktrmg5b1+D/pORpHKuvzEfVxgxzpLXjO+DUkD/JaVduEfLJjA1KLkTvhgFOgyxhM+Na+6X8PyksAB4RjMmyN+A1eyscMa6ubcpn4M7oFBXUAG9jYWz9euCE74W6s5zYlSLakmpAcKPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757536419; c=relaxed/simple;
	bh=YhHcGR6NcktdDika/H79AEJwmn9xeexlbfC0CIPF2GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHiwcR91mVTnc8YrfR8khPHU1tFWhC089U3nLe/7cTjIpPWiIn2N4qAho2I+RsWwuHcZRH7bfNeYxrISiG88XNg/bdeAx8/VH7m2gZaKBj9jLxUMvllCxKj79jMggRxpjDsdF+hrWgVOZMqd3UM+DLJ7ZGyh+Av+ix2ZhHLXEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org; spf=pass smtp.mailfrom=kfocus.org; dkim=pass (2048-bit key) header.d=kfocus-org.20230601.gappssmtp.com header.i=@kfocus-org.20230601.gappssmtp.com header.b=x0VoysvS; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kfocus.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kfocus.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8877677dbaeso398039f.0
        for <stable@vger.kernel.org>; Wed, 10 Sep 2025 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kfocus-org.20230601.gappssmtp.com; s=20230601; t=1757536416; x=1758141216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZC/n9aPRKkY1e246SyhB/Q8BzMW4BNCrjlHrCKsg/4Q=;
        b=x0VoysvStrMaIlndpVjY3ix2GqeW/1mfjunZQzmzcpriHQWch0fhIOXQr6ds5OT8lS
         0LfcsQFACVbaqIRFTZLrbOHzzhqyK6XHbHXMVEVKyXqPW03w13T2Lu/SFneNhoZirELH
         vQk+0MHOsdT+xpo2ja8GhC1YwonVCXeMVesXFhHAo7WV9qf/EmAwRcpI+ISdQxZqWVLu
         5msDyFr+zoQB19lmMLNWt9pWgLm0WfpPTzH1COWHiBiCA4Vq+1GW1cyzSBwOWb1bp2jd
         m5vm+PQO5PpFqj25eReYrRbbNztrmnuSU9x6L09b4b5TrPTargwAj0oG58MVuz75NYE/
         hJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757536416; x=1758141216;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZC/n9aPRKkY1e246SyhB/Q8BzMW4BNCrjlHrCKsg/4Q=;
        b=n2XpkuXitCYY9tJgyPAuCJ5jy8YUom8yDqD89lnZDMMUwOTVSlI9sE8OGJTfEC1lho
         Rh0pZ4vtfDk8fcJkNY+YMT0vPiHDMan+dOBxLaeaUoT6BmZIPKw/xiB2/UQy8tlI8xFn
         U39ZE85a8GA9xqG/rH2/HFQyaaNpfw1uPvpR5J1xBVf9skDl+yRUD6dmQ1PlabWRY2M7
         Aw6Z1oCicM9+QWvd2d2JjZ5qsbFcFhT2OAOUCdTXCABlWpR+S6TCS7uELqJtOkk99NHr
         rCWoI3AwTVfP7Xfw4dTm84PADPwHG7kTvgv4R+1Hzv+31gF6AYTfR8lv8csB7HV7zqh+
         1qPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHgjp7J/O9WlZtmBXHRUGy8PI1peB3XyjqntK0m0Iai0Za/J20RO6x85ntHOi72N6JC33Zosk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdI6I8C+lM1i0EHh9tlZswBW2+1E9zbjfoITJcDaFB6xodRLV
	6OjTpOXwlj4J/IzemDrW645dwkp6XbtWAW6GxwdccbWDYw0uhlWefCn+e/ZbkDIZfnc=
X-Gm-Gg: ASbGncuJkhWhk0GCQr9640jdXQsW2AQ4aRDtxPj7MOsXQXIdcAOqu1yy9fpZIxu3qwV
	1dGQA4GpYTmygvQl/djtqqytL7pSxqnyuCtE5TRIfRNc4uQTnoQ2SeSvFZAMfk33dXUwee+Ixoy
	hdJpTxX3+hypeaM255SddT0kxuzGKoR2sT5qIA7Q4gXQgVqZcBO3cuvmLF1+evS3uQvHL8xVD1S
	vltsoE7y+JytngglnzpvBoTEq79ca381sHliAWu0mngebuvbLzSlX0yaRkr5Rb62DWJ5DdidPao
	ut82DFf3aXQ+Om5StsiPnyQLSPD0YeQHeVzGuWMYjAVCr+UX7Ubl9cP6So7wwJqDau1S+I3y1vo
	3p0IE3CEJaEfadx8uISsKm0rg84vqxQ==
X-Google-Smtp-Source: AGHT+IFUIt/o0aTDvAKsDPoZqNCzU+WEORCP4SO4/NIgvZhEvVZboD+hqTS72AUl6+6DUmBYDzCqDg==
X-Received: by 2002:a05:6602:36ce:b0:88d:9dce:2916 with SMTP id ca18e2360f4ac-88d9dce2a43mr691914239f.8.1757536416124;
        Wed, 10 Sep 2025 13:33:36 -0700 (PDT)
Received: from kf-m2g5 ([2607:fb90:cfaa:41d:2536:6680:5b26:e8b0])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511ee8f8e5csm129110173.10.2025.09.10.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 13:33:35 -0700 (PDT)
Date: Wed, 10 Sep 2025 15:33:29 -0500
From: Aaron Rainbolt <arainbolt@kfocus.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki"  <rafael@kernel.org>, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, mmikowski@kfocus.org
Subject: Re: [REGRESSION] Intel Turbo Boost stuck disabled on some Clevo
 machines (was: [PATCH] cpufreq: intel_pstate: Unchecked MSR aceess in
 legacy mode)
Message-ID: <20250910153329.10dcef9d@kf-m2g5>
In-Reply-To: <dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
References: <20250429210711.255185-1-srinivas.pandruvada@linux.intel.com>
	<CAJZ5v0h99RFF26qAnJf07LS0t-6ATm9c2zrQVzdi96x3FAPXQg@mail.gmail.com>
	<20250910113650.54eafc2b@kf-m2g5>
	<dda1d8d23407623c99e2f22e60ada1872bca98fe.camel@linux.intel.com>
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

On Wed, 10 Sep 2025 10:15:00 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Wed, 2025-09-10 at 11:36 -0500, Aaron Rainbolt wrote:
> > On Wed, 30 Apr 2025 16:29:09 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> >  =20
> > > On Tue, Apr 29, 2025 at 11:07=E2=80=AFPM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote: =20
> > > >=20
> > > > When turbo mode is unavailable on a Skylake-X system, executing
> > > > the
> > > > command:
> > > > "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
> > > > results in an unchecked MSR access error: WRMSR to 0x199
> > > > (attempted to write 0x0000000100001300).
> > > >=20
> > > > This issue was reproduced on an OEM (Original Equipment
> > > > Manufacturer) system and is not a common problem across all
> > > > Skylake-X systems.
> > > >=20
> > > > This error occurs because the MSR 0x199 Turbo Engage Bit (bit
> > > > 32) is set when turbo mode is disabled. The issue arises when
> > > > intel_pstate fails to detect that turbo mode is disabled. Here
> > > > intel_pstate relies on MSR_IA32_MISC_ENABLE bit 38 to determine
> > > > the
> > > > status of turbo mode. However, on this system, bit 38 is not set
> > > > even when turbo mode is disabled.
> > > >=20
> > > > According to the Intel Software Developer's Manual (SDM), the
> > > > BIOS
> > > > sets this bit during platform initialization to enable or
> > > > disable opportunistic processor performance operations.
> > > > Logically, this bit
> > > > should be set in such cases. However, the SDM also specifies
> > > > that "OS and applications must use CPUID leaf 06H to detect
> > > > processors with opportunistic processor performance operations
> > > > enabled."
> > > >=20
> > > > Therefore, in addition to checking MSR_IA32_MISC_ENABLE bit 38,
> > > > verify that CPUID.06H:EAX[1] is 0 to accurately determine if
> > > > turbo
> > > > mode is disabled.
> > > >=20
> > > > Fixes: 4521e1a0ce17 ("cpufreq: intel_pstate: Reflect current
> > > > no_turbo state correctly") Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> Cc: stable@vger.kernel.org
> > > > ---
> > > > =C2=A0drivers/cpufreq/intel_pstate.c | 3 +++
> > > > =C2=A01 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/drivers/cpufreq/intel_pstate.c
> > > > b/drivers/cpufreq/intel_pstate.c index
> > > > f41ed0b9e610..ba9bf06f1c77 100644 ---
> > > > a/drivers/cpufreq/intel_pstate.c +++
> > > > b/drivers/cpufreq/intel_pstate.c @@ -598,6 +598,9 @@ static
> > > > bool turbo_is_disabled(void) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 misc_en;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cpu_feature_enabled(X86_=
FEATURE_IDA))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
> > > > +
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdmsrl(MSR_IA32_MISC_ENA=
BLE, misc_en);
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!(misc_en & MSR_=
IA32_MISC_ENABLE_TURBO_DISABLE);
> > > > --=C2=A0  =20
> > >=20
> > > Applied as a fix for 6.15-rc, thanks!
> > >  =20
> >=20
> > FYI, this seems to have broken turbo boost on some Clevo systems
> > with an Intel Core i9-14900HX CPU. These CPUs obviously support
> > turbo boost,
> > and kernels without this commit have turbo boost working properly,
> > but
> > after this commit turbo boost is stuck disabled and cannot be
> > enabled by writing to /sys/devices/system/cpu/intel_pstate/no_turbo.
> > I
> > made a bug report about this against Ubuntu's kernel at [1], which
> > is the only report I know that is able to point to this commit as
> > having broken things. However, it looks like an Arch Linux user [2]
> > and a Gentoo user [3] are running into the same thing.
> >  =20
>=20
> As the bug report suggested, the system boots with no turbo, it must
> be forcefully turned ON by writing to this attribute.
> I wonder if there is a BIOS option to turn ON turbo on this system?

I just double-checked the BIOS settings, there does not appear to be
any setting related to turbo boost there. The closest there is, is
overclocking settings, which comes with warnings about possibly causing
the system to become unbootable, thus I think those settings are for
true overclocking and not turbo boost.

> This processor itself is capable of up to 5.8 GHz turbo.
>=20
>=20
> I will try to find contact at Clevo.
>=20
> We can try to reduce scope of this change to non HWP only where there
> is unchecked MSR issue.

That sounds like a good idea to me.

> Thanks,
> Srinivas
>=20
> > [1]
> > https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.14/+bug/2122531
> >=20
> > [2] https://bbs.archlinux.org/viewtopic.php?id=3D305564
> >=20
> > [3]
> > https://forums.gentoo.org/viewtopic-p-8866128.html?sid=3De97619cff0d9c7=
9c2eea2cfe8f60b0d3
> > =20
>=20


