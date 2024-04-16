Return-Path: <stable+bounces-40017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B465E8A6BD3
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D971F22695
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1320612BF2E;
	Tue, 16 Apr 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1hMs6mu"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352B12BF30
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272865; cv=none; b=uY94BQCXuNG+MnY9qV2VG/L4B6TLCGbAuQ5vsQeysuD9QU1EACGMAv/+WLO0Mo7tF04NlS/Qz7P2XJSFojy+50EvCjYgmZmy/ga5+Dgp6eEae/hGT/qNLRoIszfoj+84xvO8Abx9/WLOdilp9kh3Zv+QPEe5Ah/nXBQJzlMNClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272865; c=relaxed/simple;
	bh=7uLnhRptJhIlL/WoucKKi6qhTOkpC62d1wAP3c/jHHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYMihu54CBrbM32OPHPFqzJqqMvWDXfohi7872GfZafhID8F8ud35q/BdxB5Xk97eCnobkqEQ6oGzKNwJpApYircF/Il5MJJGlIfcjKX457subI4v3PCXO5VxLaAaopYhTCubVx4D2difGBQKRgKvQ9ftEdVFhJzg+KvpYvosoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1hMs6mu; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa3af24775so3141864eaf.0
        for <stable@vger.kernel.org>; Tue, 16 Apr 2024 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713272862; x=1713877662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea6CgGbzHVftCIUlE44bhMIJf3xGIJgS5bdRui+rEss=;
        b=R1hMs6mu0NtjDxOqe5Z6R0tV/vOvDyBLK1Yp7cCDppKfLaf6bCYG4rqlWkWsHc3U7P
         zYw8TQGpHqphnnft3uXyAa0oX1PONuRllZbzJ1Gy4fz1VsItiSwx0my2FJG0FBUDawkV
         gao6P94scI+Mwq//XxXCo6wcKABLSfHCk9/ZzfJ1j3tOmHBzyeRheRq6pgOaru+vH9R6
         lv/F9vYhx7DUr7m+szlZn+PheH7IKdHooh+qs4Ofjmp5CfiEHGnc0VDQy+LU7LaoA32V
         6A5XEGHaEdDK+MpqMgVXoZtMQg21NUfPLaDp7jpMrLRgR5k4c9E2ntPC7ewksoCvOa5a
         f47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713272862; x=1713877662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea6CgGbzHVftCIUlE44bhMIJf3xGIJgS5bdRui+rEss=;
        b=Y4kOO0nSXR/EOrrVjd38F8Pz+ZARhQMjPPSNuNie9UVb+dcR2Yxo8WEiQ2EB5y7K3k
         P9Nn8KTIzSL9ayr0zXr6gyGgGT5hlwVr8CQxalCBn/AzkgmGkDwh2IEdg6M1mf9p46IU
         EmXWdG6BOC4If2oTOSuNmS9ZUSRRCsx3wv5qub3X94D/umdVi7lWtqkgymNchz8aN3Pt
         P2sjVb+spbl6KT7XRsoBVpUUYYBaJQ2M2kelLkrTPdrl1VUl1OgO3ltfwPaZdSn1ilEy
         +hat76E5SzDxltLDYwAZC8eSOKjPt4GGp6/O/ulWUOkTv0r5w84AHuEDHiWNgdd+og3z
         o+zw==
X-Gm-Message-State: AOJu0Yw+S66bNOzxyNb/tVMHdv9q6jqTdhgcuDcXoAt5rHIwaIEqtaiZ
	QpJOaf8X7AbKQIkZPtDrYckov/zylg5MBl00eJxSGB0UpRsMTtykMhiUdSkJyfxLmK+0yMhi7k/
	btOPwsh8bdRNfqZB71n0g0VpX0OmeFYVlHzRQcQ==
X-Google-Smtp-Source: AGHT+IH7nHIwoL3TWj/tf4kEGG9jfaQ98hAGzRADAS0JU5ClDVgTBcndZ1ImALsskvzSGFQFySrHCtTqVF/FVHBvAsY=
X-Received: by 2002:a05:6359:4b89:b0:186:3ae:e13c with SMTP id
 oi9-20020a0563594b8900b0018603aee13cmr15909727rwb.0.1713272861886; Tue, 16
 Apr 2024 06:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415141953.365222063@linuxfoundation.org> <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
In-Reply-To: <Zh5UJh31PlBkpZWd@finisterre.sirena.org.uk>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 16 Apr 2024 18:37:30 +0530
Message-ID: <CA+G9fYu-AjRm-BBA=8fWS8oCbBJ5W443JHPh3uddD7ea7MY-YA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Yihuang Yu <yihyu@redhat.com>, Marc Zyngier <maz@kernel.org>, Gavin Shan <gshan@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 16:04, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Apr 15, 2024 at 04:19:25PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.6.28 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> The bisect of the boot issue that's affecting the FVP in v6.6 (only)
> landed on c9ad150ed8dd988 (arm64: tlb: Fix TLBI RANGE operand),
> e3ba51ab24fdd in mainline, as being the first bad commit - it's also in
> the -rc for v6.8 but that seems fine.  I've done no investigation beyond
> the bisect and looking at the commit log to pull out people to CC and
> note that the fix was explicitly targeted at v6.6.

Anders investigated this reported issues and bisected and also found
the missing commit for stable-rc 6.6 is
e2768b798a19 ("arm64/mm: Modify range-based tlbi to decrement scale")

--
Linaro LKFT
https://lkft.linaro.org

