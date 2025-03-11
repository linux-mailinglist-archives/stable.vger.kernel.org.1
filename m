Return-Path: <stable+bounces-124075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212ADA5CDAB
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A4916A527
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2626389D;
	Tue, 11 Mar 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a83LfgTq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD752627E7;
	Tue, 11 Mar 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717069; cv=none; b=fMgcWF95PgER1yGQyVmyzxxqpoIL1htSo7ClDsVJytFoBnkA6QIIaPBvkApmCNPyO0Jzd3WOQZnAwWf/t9yM+dbLHYIplUQ6Rckq7n+M6t9kmxCudRgnKoiLchkesXEwwAC4Dh8vgfH7wuT8AZ0cLvB3buOnMnDn7S+3/0mmT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717069; c=relaxed/simple;
	bh=amzaeUHYPxdXfgE5dqqUKy6QdRie3H51MlqUc45Ro3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFa7HnywXIWRghPL9eTs0uDC6oC8LE7yrbNoaszEss1BCF0a8xDIpekq2ReJl7nZqQAo6qXyjAeLyIwRViWg5sGahxicZkcGBUNuYZZw9nmzXQNhD8LYR1GykiOb5Twadn60/mwW9EdVs2NxJaxz3UxT0z4gsjnSxGU3RSXj8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a83LfgTq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5499614d3d2so5087186e87.3;
        Tue, 11 Mar 2025 11:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741717065; x=1742321865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amzaeUHYPxdXfgE5dqqUKy6QdRie3H51MlqUc45Ro3w=;
        b=a83LfgTqkvpxtQnqnPhn2ldUCCdvqNeKWbTuFECmo4RZVzrNSiR9pGeqJGPCFgT01Z
         rJoTsc8qlwFnUjrdEdXRznSpIZu2cQOTlZXVshufZQIhlvt1PLf41LU9ItF8P07JpZyx
         TMtz1l8tjcfvyEd+qr+SzDFNf2DixovBTZE5u9z0aSnaAsjwrNC4qShKNoHp75g+MNTl
         iPMGAfcmKjGOHo43GQSjz97reiCohP07CV88FgsLtz7IzLid9ZKQG/DqmOzV1cPyq3K5
         qxpI6YcW7xxIczZUqgRiXOh9/yrBFYOfro/VQ/furaiQl61cbro9mfY5vsBNb8PYNbGw
         eTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717065; x=1742321865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amzaeUHYPxdXfgE5dqqUKy6QdRie3H51MlqUc45Ro3w=;
        b=m6gKVBIs0yQDQ7dZ3XCX3Wbi0oMZ8H0bs/cibdN9khd3wMeCQwV/KN7vCN+WxnCsow
         J2ldrKaYuJcz4hVCek8tkVuecYzrPq/kdrXkybnx8y/wWxSrxLSebjmk5NJ2gci03rac
         ABaCnF2iDuP/+eBUqx6w7278TcD2/vuXbPp+o/tH5cSOSt0H++YImYE3DDpCOs197wt0
         /woP/hYtsWesr85zhm1DhVW4OMIuP+Q8RD1YgUTdh56werG2ZB+n9FhvGhxMMqf8f+6N
         zAV6nvkIfuBDGVxLhDJLDAnwgNL2rQPkI5o6M4ZgxY9xncxXg+ug2pzg/3WPsEuvfiKH
         XU9g==
X-Forwarded-Encrypted: i=1; AJvYcCVhvaXpYBsOa8q3ZznliPXab24UwQEKhSmn1LSoiT6o5ocjCIJIQLq6ctOHpyU3mG9TCjVaWjizN7MJQSA=@vger.kernel.org, AJvYcCWw8kbHBbJAKlPZ7F7mD1PjlLRMObswxX5Fm1rxiUFSZ2CB2SYPY5c+eKfCCVVO5qtZ4An/phLO@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVtQ6vozaZV87ggkA0BRCaNZlhL+H2tLdsXXfXaFgjM5c9isr
	WvdQemQ6TL0pd1tPYHxArFdL/PO7Qm1fn+ieXM7mvX1zwd7QHzVWRX2eepTfKvxT8Oy0VsLlpZJ
	OMwSMi82C7MJHohkMc8uoJf4D0lg=
X-Gm-Gg: ASbGncvEpsIF9vCj1Y2jWA11r1164HVFrNHBdd8kJmcw/L36N9n0KDgXwXMKTuoZp2E
	CvHMA5yPXYu1tV2e60QGr1TYOkRl1NMg9cLCT7szcdMojUZEwPWI2yu/qWnNfzjkSVW/H2r/IDS
	Tje6cd52BfdU63lt+hF8BRVtYeHQ==
X-Google-Smtp-Source: AGHT+IEYrR3iuVb9k7bTT8zIzdeCEs1XeQqQDE64pk/im8l6F+pZMmJa1FuK6qJVeCb7epxnxpHYTAZTWwaqAKTXhR4=
X-Received: by 2002:a05:6512:2386:b0:545:60b:f381 with SMTP id
 2adb3069b0e04-54990e6764cmr5155120e87.29.1741717065084; Tue, 11 Mar 2025
 11:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
 <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com> <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
 <CAE2F3rB-ACt2rdVFYSpSap=t_poTi0-PxhgrYGg4vzjfic7vqA@mail.gmail.com>
In-Reply-To: <CAE2F3rB-ACt2rdVFYSpSap=t_poTi0-PxhgrYGg4vzjfic7vqA@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 11 Mar 2025 13:17:33 -0500
X-Gm-Features: AQ5f1Jotsyx4CiMaVUlC-vkoovHyzT3WerEGqfj6ILGnt1v6WPD-tu9VOLKyoNc
Message-ID: <CALHNRZ8YUjMq0NfAT10wajFJGWaxGWarn-z2C=1Obf0ewT13gQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Daniel Mentz <danielmentz@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:55=E2=80=AFPM Daniel Mentz <danielmentz@google.c=
om> wrote:
>
> On Mon, Mar 10, 2025 at 9:51=E2=80=AFAM Aaron Kling <webgeek1234@gmail.co=
m> wrote:
> > I am working with the android kernel. The more recent setup enables a
> > minimal setup of configs in a core kernel that works across all
> > supported arch's, then requires further support to all be modules. I
> > specifically am working with tegra devices. But as ARCH_QCOM is
> > enabled in the core defconfig, when I build smmuv3 as a module, I end
> > up with a dependency on qcom-scm which gets built as an additional
> > module. And it would be preferable to not require qcom modules to boot
> > a tegra device.
>
> If you want to build arm_smmu_v3.ko, you'd have
>
> # CONFIG_ARM_SMMU is not set
> CONFIG_ARM_SMMU_V3=3Dm
>
> in your .config. I don't see how this would enable ARM_SMMU_QCOM or QCOM_=
SCM.

I went and double checked my defconfig snippet and I have to
apologize. I put the wrong thing in the commit message and caused
confusion to myself and the entire discussion. This is what I've got:

# MMU
CONFIG_ARM_SMMU=3Dm
# CONFIG_ARM_SMMU_QCOM is not set

Tegra186, tegra194, and tegra234 are supported by arm-smmu, not by
arm-smmu-v3. And these are the relevant archs I'm trying to work on.

Having the extra dep doesn't break anything, so worst case I continue
to carry the extra dep or this as a downstream patch. But I had to at
least try to decouple unnecessary dep.

Sincerely,
Aaron

