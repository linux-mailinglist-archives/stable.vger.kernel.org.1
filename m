Return-Path: <stable+bounces-124066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7371DA5CCE1
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF883A897A
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7D25FA2A;
	Tue, 11 Mar 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X202CRt+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205B1C3C07
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715725; cv=none; b=XVqeExz2MXN3F6pnUsIaW5a6IOmq32KTiIUiG5vKQgSWW9wrcJ6JzNg7SpzLcmHPHmgqs5/q7THPNZsgII6xyHdCpAV8RrcABtEiRovw3D1fVGbGOMyGb8IiQdRM7XggG61UV5q4B5zLHrSE+DVdlUDYC9Qq18v971w1T09293U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715725; c=relaxed/simple;
	bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHIPkUqJAIMKDfGspZvV8C8tSCA+8UZXSAwT0MHxuQMnFNzEfhcaHnkGESnshU7HP6iIz+ukU0loumwtnK9FeVRlLQV3O+1WrG+qjePrgVaLq7q2IGku2LVkT9hJX0TmK5ryBBlurcDYrHfV16sIJASjbZ7n2MEi5L7ZD81qQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X202CRt+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so1279a12.1
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 10:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741715722; x=1742320522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
        b=X202CRt+gCMHFjrNYwR/xLe0GLUo/cIc6w/r0Y3k8guDb7Vhqig7OiDvO8ow5vD2MO
         70mQ2g/Y6RaW5c/3sE2h2DLgEpJy/R0a9OPAiF3lTimp427NstZcgwl3Fpl/bl2y/bvT
         lqEEaSqq6K1EXPKasJLKNyPdjOCqWxXwBnWypE/5o2hD6eou7zw0koW0+Xtpz4YQTgVX
         PqNprvOj04eOAlEkcwPnOzVhTA270inymS4W9SeVM/4+FcquAIQNIzZWP2YkUGHpaB6R
         cnxm5YIVMhLHPrIXGPQPix3sV8MtKpHR/DIrrTwUu2iBXb3fRdjySerg4j3sdQAjoB15
         1bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715722; x=1742320522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIjUexkbM9coqCh0GSL4O85/rHY5aGj04usaPjJ5KJI=;
        b=jaGBmgy6EIgt9tNxSz3mpSN+hD+L667m6m8BwwQMp9CgGs07xPbdZ5CO6Nq0IPd2HU
         J8qYm/sRQ30ko4lwZcy1d8aaGwn+eLlMawvb/3NwTp5N9d9UC2ZWXdaiSBGD4VyVuqLR
         FFM1WlO6C16IjoJRksvx5qEIG5knCTUTbusXiU1r7SgraNtPjeFH2odECP+WnlRucNIi
         apVDH7NgasKrHTDDHHo9Pxd2WQJXnujVL2gD3++8uNvkJCnXvde04YpRIaiK5ZyDIUZT
         sqclx9I39YNXFKlouZ+UQKSL33hUZ2XUEIBbnQ4lbPq+MH1NqIoZ3kKivnGLmjTsJsvT
         0p6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8nzLqZJJOF7JH4Uiegoo2IOK1f+MGTEpPEYNZexhJo33fMJiVH9giGC9Js4GCBso8exGdzyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHYOFscslJ765wl1hlfihuLReAWnQJ07fGQDFEeF62GirRZGzM
	gb3RLPTJnVg6tE4hNSjEQwuGQS/dR4b2xzgol9bLo9Gms5nf8OGUbDao2ilh15JuJ55F7LVNSno
	CZfmVY+PoS/MY3Nh6SyYYPeL1TRQVUqdd6jSo
X-Gm-Gg: ASbGnctzP8e0ToluyVrqxPcUWBWCl4vDRXFaHKmE21/Jt7uN7gZ3f5J+QhiqN93I72U
	Vtp+LKDq3U5Ff60YdrPxDlt5fjayqTitzcexg4xvXAC8JUBQJ9BfXurClXRc4ZjiucZ8TEyppNJ
	BHMZFeycHm76cEHSbaZn/jtzd/nORn6pFBTOt//BavRTsB/kYnHsGM+zuBlekC
X-Google-Smtp-Source: AGHT+IHBou0AMnOc1wlERmQEiByjC9z6tx0SCc40GDDV97vQKc68PhQO6ik31ktuvMGhrIBUoFtdSF1c+d39GaMkrhc=
X-Received: by 2002:a05:6402:2048:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5e7b2684877mr140a12.1.1741715722207; Tue, 11 Mar 2025 10:55:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
 <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com> <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
In-Reply-To: <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 11 Mar 2025 10:55:11 -0700
X-Gm-Features: AQ5f1JoKKBbJ5USMaxKYhA8jhl8TuOZ3b3iaSIOxkea3mVVta9KFMFOusPuFh1Y
Message-ID: <CAE2F3rB-ACt2rdVFYSpSap=t_poTi0-PxhgrYGg4vzjfic7vqA@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:51=E2=80=AFAM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
> I am working with the android kernel. The more recent setup enables a
> minimal setup of configs in a core kernel that works across all
> supported arch's, then requires further support to all be modules. I
> specifically am working with tegra devices. But as ARCH_QCOM is
> enabled in the core defconfig, when I build smmuv3 as a module, I end
> up with a dependency on qcom-scm which gets built as an additional
> module. And it would be preferable to not require qcom modules to boot
> a tegra device.

If you want to build arm_smmu_v3.ko, you'd have

# CONFIG_ARM_SMMU is not set
CONFIG_ARM_SMMU_V3=3Dm

in your .config. I don't see how this would enable ARM_SMMU_QCOM or QCOM_SC=
M.

