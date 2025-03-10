Return-Path: <stable+bounces-121733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6793EA59B87
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2294B3A3C4D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F693230BC0;
	Mon, 10 Mar 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoOScSYC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27C1C5D5C;
	Mon, 10 Mar 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625138; cv=none; b=Md4Gg8ztCEUbmub4dyMZ2cZHs8DqpFZaCyFuwR8TuW9+uwFVXBmwhkDePrR/EAypZeIUqROjJIVrczRzQ7HQgJxq3MDAL/ZPpfr+oVUgMoC98/8TDcIgcuHUnPr5H7f9AkqxmVz6kQ2xCMOd5s6C7t/Zn/guepXk7L3vIujX8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625138; c=relaxed/simple;
	bh=AhSiebyZisSEOEjFm8MpCPrlAdsRA9L9FC+Hd4Xs7NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKDRhRFf//mYFFX8vrgRDeEKEI5e3xUeyQBjv8xuybJBDexIH4RSkMGsXgqV3m4Ga7DYYOA8j0qlVTA/GHXUBeu29ybQQd50BNY6m6CBybt+RHqFSvQSCQbqLT6gwex5sYKim7F334y7z9vPdA3QkBcll1TRY2zN9yJa7qcoE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoOScSYC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5439a6179a7so4423976e87.1;
        Mon, 10 Mar 2025 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741625135; x=1742229935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xsicxmenQMOAQy9ZUHws7xk8D0uVS0Ti0PNVqRnMSU=;
        b=JoOScSYC/JaQnJuNSa52W4io2hXQ6QQ8GfgsOgZpuHu66Nn+LMCZ0lvBGS8mxbx4RG
         P476uk/M2yg5M5vc87K2nw6Fwqr474pt+iERLf1fdtk/iwTmxf6NsqEnhST6hud1DemD
         WuRzN+O23DBX3hdXYSctXCKgwC1+KIoCjyNPDqSRKdSiZ9asJWnKvU4ZwF1IqnITuJNt
         6IthKEK0ibCulB86dMgPWd8HpK/CT+RiNsYG9kERbvPM6qsmuGmamvCsqtc9we6+Klcb
         QBt215SvVxJtxl7GL/YAb1rrdf65OFykWlC0BAzIJyOAlOpqOFvL8+QD1jud/N7jmPed
         QtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625135; x=1742229935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xsicxmenQMOAQy9ZUHws7xk8D0uVS0Ti0PNVqRnMSU=;
        b=CEsKftTRhJ5w0aFWhpkJ3DkUvp3b8qqBqjaqUwugntpnUWhtizZ3vsjNjJvosKxddx
         Mh2ngiI47kYTAfPyhB2yUd7Yktn5u0mQwgUTF4dg4oRkgIS0pGhell01/eBMcV+Jyfxm
         S/NmliWUsLO7tfQIEDLSpPdIMMMiWR7scGp3CbDDau6RBz8yCLWs5Htw5HEKgYXUGuJB
         VeFuU3ls9mqpgst8ngYv9ckuiVRrJBEi6UDjVvJMWWcVSfzkXFoqwGusjVZak+ASpfBd
         xakya3wTjtTzBOpNStmKkj/GtZaDrl8Ju8QuLS0rgkF4JUbeFWofsGO0taCUFT3IYTJn
         nTYg==
X-Forwarded-Encrypted: i=1; AJvYcCVzexAbgVAOTCXEUHq9I/SYlS06h4kEYkliDiZwil5N3IMfhzYMVpfrNXpbPTBUHEQup56bWyRI@vger.kernel.org, AJvYcCXPwyKSmHkcRS73eQsMdZZVr8uqM1+N/z0XRXVTrRMINol8XhV3H2Jynt1dszaMT1eUPa0HtcSmRUJuIVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzedaopKuctthISL9Qs04aQ40M6AjmwmTb9OE58KqCM5u0bUznl
	+BD1V0VYvHkw7tgQJFhB/G9GYpW/QTpSLbLuswuYJV8RetcFzjHt0KvhGRE9IjFcKDPvyxb2Z0y
	5oxGLfVN3uWJF/DobllSXzfVhbjA=
X-Gm-Gg: ASbGncv8YZDidHQ0XSWIS1ysajDawGaITASucE6EE9CpKzWXBMRlD4rRdowrcp1GhsP
	XwhD63LrSXa1itqgjB9iEnMpGgAS/kV/blGQM5Xj4GbPNIxWmZ02Fo4UQqUpVUsyfHjlZ54uUln
	DpM0j+kH4qhgfNhO4JAxIfKjFHMA==
X-Google-Smtp-Source: AGHT+IELaT2li0TDFdIGi0ECQA6PJQbMNSD/H8pY1VH0V8khSOVia+1VvBGBenJ4MrkzN10ddT3NAwJsgribGaiDenw=
X-Received: by 2002:a19:385c:0:b0:549:9813:3e6b with SMTP id
 2adb3069b0e04-549abc9f5fcmr91423e87.0.1741625134237; Mon, 10 Mar 2025
 09:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com> <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com>
In-Reply-To: <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 10 Mar 2025 11:45:22 -0500
X-Gm-Features: AQ5f1JqmGHzEzkS1We4m_O_rX5wft37F9HsGwqv_A82mE5sllwO43e52LVF4N6s
Message-ID: <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 7:42=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-03-10 6:11 am, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > If ARCH_QCOM is enabled when building arm_smmu_v3,
>
> This has nothing to do with SMMUv3, though?
>
> > a dependency on
> > qcom-scm is added, which currently cannot be disabled. Add a prompt to
> > ARM_SMMU_QCOM to allow disabling this dependency.
>
> Why is that an issue - what problem arises from having the SCM driver
> enabled? AFAICS it's also selected by plenty of other drivers including
> pretty fundamental ones like pinctrl. If it is somehow important to
> exclude the SCM driver, then I can't really imagine what the use-case
> would be for building a kernel which won't work on most Qualcomm
> platforms but not simply disabling ARCH_QCOM...
>

I am working with the android kernel. The more recent setup enables a
minimal setup of configs in a core kernel that works across all
supported arch's, then requires further support to all be modules. I
specifically am working with tegra devices. But as ARCH_QCOM is
enabled in the core defconfig, when I build smmuv3 as a module, I end
up with a dependency on qcom-scm which gets built as an additional
module. And it would be preferable to not require qcom modules to boot
a tegra device.

Sincerely,
Aaron

> Thanks,
> Robin.
>
> > Fixes: 0f0f80d9d5db ("iommu/arm: fix ARM_SMMU_QCOM compilation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >   drivers/iommu/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index ec1b5e32b9725bc1104d10e5d7a32af7b211b50a..cca0825551959e3f37cc2ea=
41aeae526fdb73312 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -381,6 +381,7 @@ config ARM_SMMU_MMU_500_CPRE_ERRATA
> >
> >   config ARM_SMMU_QCOM
> >       def_tristate y
> > +     prompt "Qualcomm SMMUv3 Support"
> >       depends on ARM_SMMU && ARCH_QCOM
> >       select QCOM_SCM
> >       help
> >
> > ---
> > base-commit: 1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
> > change-id: 20250310-b4-qcom-smmu-d4ccaf66a1ce
> >
> > Best regards,
>

