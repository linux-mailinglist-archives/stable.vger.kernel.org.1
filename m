Return-Path: <stable+bounces-121144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82886A54185
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 05:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498CB16B876
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 04:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D679E194094;
	Thu,  6 Mar 2025 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhJMyOte"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC1310E4;
	Thu,  6 Mar 2025 04:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741234017; cv=none; b=VQF4n00xkgqVnpN+ZMm+0DYiNs/LnYN6Oid4vYZIGWJf3xaJS98iIA+037T7MbW6lM5SHqzG52DRvYvH8ETzwjCZhm1PfaxTTS3wGTUfN0ATOPhGmyCLhzki5OsqbRpr3UM8yCoaBjF/OO+s7lQ4v4M3zXj9Cu6PfKQyPks8Vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741234017; c=relaxed/simple;
	bh=XozwWwnjDwGjGyca6d6EHwGV9nhokS3iVuQ3Q5Um7es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sy5IVxt0ew+TGiCge8p1Ini7vANLhNxdRjKsqvyTnOyULXKnZ6VGz9jxG+8CfJdddyXNPQkGknH/G3PwjH5EMSTrpT1Zvx7Xt3OIy1+aeUV2YyxnszWdZ7y7o8axw45o9iJfTgPAgYt9Zv6qkjNCX7jfEXC+Dbon4PxrjvQ2Dd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhJMyOte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14028C4CEE5;
	Thu,  6 Mar 2025 04:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741234017;
	bh=XozwWwnjDwGjGyca6d6EHwGV9nhokS3iVuQ3Q5Um7es=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KhJMyOteweqJpJRaSmMHtzGdEFOZ2yXZNoSBZttPyqrQ+ymBSj0+VK4pJoGvtvy+i
	 W9ih8lPl152sFpaAmO/D/1XoMa2Y+M01SQT60/sMhPq0nrcuNve5ttVw+97/euqVcF
	 VKZno+Ef6GAsLF0JHXqekLVxsN886arD9OgdrU520t/ov9+qT8d8+rxQqZ1FxnASrq
	 TqOz0pz+j8xqSmujjdErEddr7MqVdRSsHNBnWS0qgX4iy+iJdw3YDWJdLvNWKWeaRg
	 CU60G6DB0wAgi1KSe8zH1tSPzrY56eVVPbBCWPVvx8JESTcnh0xgVJ8I/jzu8xZ4Pf
	 O1027T74SWoUQ==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf48293ad0so31624766b.0;
        Wed, 05 Mar 2025 20:06:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHzk0S6j7vIdaSXkPAqcMtIVkpCToSessV3vIqlD8dSYV5bBk0L1ENdUHBU9iO56jH+yAcoViY@vger.kernel.org, AJvYcCXvi6GTfad/CptnezZ++VLOscI1PCEIRMdJ2u9Qk9qz/I8Uk2cdxpUtCMWFCEtjeJ6xCPGEQn41rH1B1D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxaEWh2UU32hck8Gofh1rQ4D7kEEcmnfIzvSkrgVhonkYH2sc
	hRd9KDQ47M9rae/zWkb3kjT3JWvpSICuXPj81cJgG1/Jdps3RbgoIWa6us24dqLSFNfaBCLu5DW
	4SK/2syrnvBKwt1Ja+aGhwBAcavM=
X-Google-Smtp-Source: AGHT+IFEpQmCdpQF1YcZVe69j5zMrzUNuYk8qCTUVcN5t76qAUVRM6X7gxG/XNu/SC4PiQdCy0STBDKm17DpOcMAEnc=
X-Received: by 2002:a17:907:2da0:b0:ab7:851d:4718 with SMTP id
 a640c23a62f3a-ac20da97bf6mr558790266b.36.1741234015448; Wed, 05 Mar 2025
 20:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306035314.2131976-1-maobibo@loongson.cn>
In-Reply-To: <20250306035314.2131976-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 6 Mar 2025 12:06:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H45DobYbBFBatJtHPF22VAX=QWH8i=jzpWNvN-ELgWr4Q@mail.gmail.com>
X-Gm-Features: AQ5f1Jqq26JUePxdoeylRkQAICxpF-T6Xr_eahEsklbevBfbUvgEr8_0PUQXre8
Message-ID: <CAAhV-H45DobYbBFBatJtHPF22VAX=QWH8i=jzpWNvN-ELgWr4Q@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: mm: Set max_pfn with the PFN of the last page
To: Bibo Mao <maobibo@loongson.cn>
Cc: WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Bibo,

On Thu, Mar 6, 2025 at 11:53=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> The current max_pfn equals to zero. In this case, it caused users cannot
> get some page information through /proc such as kpagecount. The following
> message is displayed by stress-ng test suite with the command
> "stress-ng --verbose --physpage 1 -t 1".
>
>  # stress-ng --verbose --physpage 1 -t 1
>  stress-ng: error: [1691] physpage: cannot read page count for address 0x=
134ac000 in /proc/kpagecount, errno=3D22 (Invalid argument)
>  stress-ng: error: [1691] physpage: cannot read page count for address 0x=
7ffff207c3a8 in /proc/kpagecount, errno=3D22 (Invalid argument)
>  stress-ng: error: [1691] physpage: cannot read page count for address 0x=
134b0000 in /proc/kpagecount, errno=3D22 (Invalid argument)
>  ...
>
> After applying this patch, the kernel can pass the test.
>  # stress-ng --verbose --physpage 1 -t 1
>  stress-ng: debug: [1701] physpage: [1701] started (instance 0 on CPU 3)
>  stress-ng: debug: [1701] physpage: [1701] exited (instance 0 on CPU 3)
>  stress-ng: debug: [1700] physpage: [1701] terminated (success)
>
> Cc: stable@vger.kernel.org
> Fixes: ff6c3d81f2e8 ("NUMA: optimize detection of memory with no node id =
assigned by firmware")
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index edcfdfcad7d2..a9c1184ab893 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -390,6 +390,7 @@ static void __init arch_mem_init(char **cmdline_p)
>         if (usermem)
>                 pr_info("User-defined physical RAM map overwrite\n");
>
> +       max_low_pfn =3D max_pfn =3D PHYS_PFN(memblock_end_of_DRAM());
max_low_pfn is already calculated for all three cases, so here just
need "max_pfn =3D max_low_pfn".

Huacai

>         check_kernel_sections_mem();
>
>         /*
>
> base-commit: 848e076317446f9c663771ddec142d7c2eb4cb43
> --
> 2.39.3
>

