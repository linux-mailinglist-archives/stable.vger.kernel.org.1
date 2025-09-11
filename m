Return-Path: <stable+bounces-179246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A1B52BFF
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 10:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A161B26872
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB672E424F;
	Thu, 11 Sep 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWOrrQlo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2DD2E5438
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580093; cv=none; b=dSzBbkhnUF1UIoFIzkUrpHPJZQ+PAz5bteirz0WjrcRIzplKeDlfifo5C5jKSnuT+/jLIitYrstnczhYvsYoqjreUB+z34mWZWH79mhIQs0bnoXFdgsozTlpf24mizsHGy/SFwx5Q3bMnwbKzbUaxb1mo9bMRavFeaz/h8Gehcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580093; c=relaxed/simple;
	bh=rKZlrOiOpYWSNGkzGrMllX51wmmYySviIaeS+Q92BC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CTva085KNBZvo+xMqadenaYFIMoxlgd4Mypzs6ktSzWBjP1dEa7JhQ8TuCcJWW7vybk9rf29JXr1+Ud5z8yUc01AsJ/tSNDidrL1ZUryqJ2/v8XrfSGA3S+RhXix5+z3mloZ0NLRkhi62zmKpoUZUhyq4ch7JEX61+aiYTgSTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWOrrQlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722E8C4CEFD
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 08:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757580093;
	bh=rKZlrOiOpYWSNGkzGrMllX51wmmYySviIaeS+Q92BC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XWOrrQloZH7dBQBSbIdAuzeWR9WNueYMdJNYrJU+zW4j1th+z0BKgc1wVYCpwUbfs
	 UeZYF3n9C6s8oKe9mV1j08qQj7yZsSOwBq3UAvdOxR7yfeJNs6c3m4A/L3KeeK3rO4
	 /Ju1ANHhxnOVNHVgmttMQQ8zsFUIf/gzHBnkX2YsYDGs/7vyfznWx72uD/gqrFClvc
	 PPjub7rQyNgQvRYUu/VQvYY3rtKH5wLp2iwJJo+0sUBxkEl7qcXOB9dKx9Kkh5XFbz
	 44wn1jcCLb/lF7lYYOa0JfIodNXqCpah4DAaFBu+5curf961KgaqgltrmLp78o3rfn
	 gAJefxN6x1arQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0449b1b56eso67071466b.1
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 01:41:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6DIVmrr+D+pwf1QRse1ED6TCaIWUew2G8qgBVtZqJBunmtzsf5eO8/69sI7YN0EnukYUOsHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztepzEZSKR3vBzUwvlZkrtes1kUz0n6dlcfO4ezVellusYt4FQ
	85/mIbppW+56S4iz7gfwu19n1xSDdtjdERb4MBe2VPp+LLhbGihxPwgAGwbD1sjUr0X4N6F1+Ym
	inPyjz1jh1em+5pzvaesGO16OBSBen88=
X-Google-Smtp-Source: AGHT+IEyB92D+HyH8vTtrcoIFQUagsci7gdRxSdRn2/h7d/2hIo9GfgU3oeg8ffU0IcQ/q+cWAoYmPWmXjrYcxt50vo=
X-Received: by 2002:a17:907:6d17:b0:b04:a1ec:d071 with SMTP id
 a640c23a62f3a-b04b1780c10mr2048468066b.56.1757580091931; Thu, 11 Sep 2025
 01:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910091033.725716-1-chenhuacai@loongson.cn> <202509110853.ASZKE1gv-lkp@intel.com>
In-Reply-To: <202509110853.ASZKE1gv-lkp@intel.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 11 Sep 2025 16:41:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H70c=kZf4rjEfiXnpmNb0PjWb_kh7L4ZKhVzpa=teMvFg@mail.gmail.com>
X-Gm-Features: AS18NWBEH_um46mN5E-6MDwPMMRBZZk6Qm4uTjND-wWAR5mBCU5LXN5YjIUn7ks
Message-ID: <CAAhV-H70c=kZf4rjEfiXnpmNb0PjWb_kh7L4ZKhVzpa=teMvFg@mail.gmail.com>
Subject: Re: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
To: kernel test robot <lkp@intel.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, oe-kbuild-all@lists.linux.dev, 
	loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:00=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Huacai,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.17-rc5 next-20250910]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongA=
rch-Align-ACPI-structures-if-ARCH_STRICT_ALIGN-enabled/20250910-171140
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250910091033.725716-1-chenhuac=
ai%40loongson.cn
> patch subject: [PATCH V2] LoongArch: Align ACPI structures if ARCH_STRICT=
_ALIGN enabled
> config: loongarch-randconfig-001-20250911 (https://download.01.org/0day-c=
i/archive/20250911/202509110853.ASZKE1gv-lkp@intel.com/config)
> compiler: loongarch64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250911/202509110853.ASZKE1gv-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509110853.ASZKE1gv-lkp=
@intel.com/
This seems like a compiler issue...
https://github.com/AOSC-Tracking/linux/commit/1e9ee413357ef58dd902f6ec55013=
d2a2f2043eb

Huacai

>
> All warnings (new ones prefixed by >>):
>
>    In file included from include/acpi/acpi.h:24,
>                     from drivers/acpi/acpica/tbprint.c:10:
>    drivers/acpi/acpica/tbprint.c: In function 'acpi_tb_print_table_header=
':
> >> include/acpi/actypes.h:530:43: warning: 'strncmp' argument 1 declared =
attribute 'nonstring' is smaller than the specified bound 8 [-Wstringop-ove=
rread]
>      530 | #define ACPI_VALIDATE_RSDP_SIG(a)       (!strncmp (ACPI_CAST_P=
TR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) < 8) ? ACPI_NAMESEG_SIZE : 8))
>          |                                           ^~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/acpi/acpica/tbprint.c:105:20: note: in expansion of macro 'ACP=
I_VALIDATE_RSDP_SIG'
>      105 |         } else if (ACPI_VALIDATE_RSDP_SIG(ACPI_CAST_PTR(struct=
 acpi_table_rsdp,
>          |                    ^~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/acpi/acpi.h:26:
>    include/acpi/actbl.h:69:14: note: argument 'signature' declared here
>       69 |         char signature[ACPI_NAMESEG_SIZE] ACPI_NONSTRING;     =
  /* ASCII table signature */
>          |              ^~~~~~~~~
>
>
> vim +530 include/acpi/actypes.h
>
> cacba8657351f7 Lv Zheng    2013-09-23  529
> 64b9dfd0776e9c Ahmed Salem 2025-04-25 @530  #define ACPI_VALIDATE_RSDP_SI=
G(a)       (!strncmp (ACPI_CAST_PTR (char, (a)), ACPI_SIG_RSDP, (sizeof(a) =
< 8) ? ACPI_NAMESEG_SIZE : 8))
> 4fa4616e279df8 Bob Moore   2015-07-01  531  #define ACPI_MAKE_RSDP_SIG(de=
st)        (memcpy (ACPI_CAST_PTR (char, (dest)), ACPI_SIG_RSDP, 8))
> cacba8657351f7 Lv Zheng    2013-09-23  532
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

