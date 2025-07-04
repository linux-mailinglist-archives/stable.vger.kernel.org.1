Return-Path: <stable+bounces-160234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BCAF9CAE
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 01:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3441C2712A
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 23:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FC28D8D5;
	Fri,  4 Jul 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpH/f1rS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880DF20EB;
	Fri,  4 Jul 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751670656; cv=none; b=GOax1mBmIZzWGT+KSeVSsx59efhWA6aUOOteTF5FjVuNBz0VEMnRLeOAjN12HLxZaoKdsP4V774hGrRGO4/Zb3B1lqQGlotQTOuBlpLXKt+galxji9tVXbfRLqXGfTUuAIFG4p67DAb9XE/sqoxUdiyfra1iWmLWziXmCYBrtro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751670656; c=relaxed/simple;
	bh=WzEF1y0lZmRnc5y+Tvi5rT34TyJUGRdq03o+P2fNCUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSGaZOLLOh4pxos+FMCVeYDWaTcvvdjn4kWzwTpC3sbYiIUhO8zcfSxz8nv4IqC8clCbkKMspdZH4qd9HlHHV97Pi+IkKdlKMajgNuxmDwy2NekWk7dmQdMyVIuiWxoHUIfO2ws7Zye7+XkEejQpRu8s/Nu9tU6mnC6+7DmkS+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpH/f1rS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C15CC4CEE3;
	Fri,  4 Jul 2025 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751670656;
	bh=WzEF1y0lZmRnc5y+Tvi5rT34TyJUGRdq03o+P2fNCUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YpH/f1rSloLFgWn5sNuRXIkA3oG9qbQku5W83DlodFuFMraEvIl70MwYU02Y11KMz
	 BeZfUgEwL6rGwnJDH13p2pfkAS9cIh5020XslK10a5CY2XiiKAkxn2qonJUZ7UZ8Ce
	 Iu4mAhK3vJ/RhpDOLHryQ+aVBAqqG9VOBZxqUfjjkT+Zqe1ANtfCeRErgKBlJHZB32
	 q8XJ9EAp1yip/XX4jPuA05st/9Rd5M6QTerlH0AlA+RCqckXmy/tyBX4jACcZsxMOJ
	 I5SJTaHsb+s5XzXTOhLF6+reSm+wmolOu/PoNW+zF/pGP+S+25vuHhlPxMqkH0O/6k
	 mSUhGD1HCirhA==
From: Miguel Ojeda <ojeda@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 6.12 000/218] 6.12.36-rc1 review
Date: Sat,  5 Jul 2025 01:10:46 +0200
Message-ID: <20250704231046.332586-1-ojeda@kernel.org>
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 03 Jul 2025 16:39:08 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.36 release.
> There are 218 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.

Boot-tested under QEMU for Rust x86_64, arm64 and riscv64:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

However, in my loongarch64 built-test, I am seeing:

    arch/loongarch/mm/mmap.c:69:21: error: call to undeclared function 'huge_page_mask_align'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
       69 |                 info.align_mask = huge_page_mask_align(filp);
          |                                   ^

Which makes sense since that function appeared first in v6.13 in:

    7f24cbc9c4d4 ("mm/mmap: teach generic_get_unmapped_area{_topdown} to handle hugetlb mappings")

Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>

I hope that helps!

Cheers,
Miguel

