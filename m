Return-Path: <stable+bounces-217279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHg+CfOtlWl1TgIAu9opvQ
	(envelope-from <stable+bounces-217279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:17:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CAA1564B6
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 676083009805
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5932A3115A1;
	Wed, 18 Feb 2026 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtHXFFuq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD430FC32
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417068; cv=pass; b=RpuHi131j5ipkinmhHxZRGo1GWNl5OC67otb+suQPSpMrXJQQjmiokqmXLl75dQUSK62Aay7ExhHlJeKNIiew+3IuarWytXJdM3b0omagKhTTtC4Bc1KTEBUvaGOG8sywYOHGKsaD/XEvu9F9PJZuZKMiSOlq0R71RVwt9BiKQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417068; c=relaxed/simple;
	bh=hDMNd74Pxc2U5r6cQ0S83TyLQHXk1qYR0EipkoSEDh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaUZ5pXEnk6a6j5boG9EYxxrABi0OjxxhCrh17Pjl9OrgBsGhqCIjwYdDLGyyeHRJnxtSKjJ0bGn33xv7bjNGfRySudEJxwBn0kjrC/tLlS8VElKfL/2OG7KJX6/s2gcpPk3OIkwx3FKzS3H6V4nVUktAFKUoH/g3b3xdiuw3dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtHXFFuq; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b6b0500e06so6135103eec.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 04:17:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771417066; cv=none;
        d=google.com; s=arc-20240605;
        b=AaS1fygCMEwKGndm4eihi3qJG7pN7YJaZrZgDTJ3OetOex1nSXdOA/MxOCY6k6dyNF
         jhK7wpZaUHCZC1GjipZQzI6u+0DoP49ZlBFBDqtLZaeUwbJ50BXodewhnRhCUlo6uGDT
         t350RFi4golkGKkUnsiVLprZ6AS3JffrLuMrtL4Vuo2ZUv7WyfSuL7T9OWkR1XRMxRtp
         yuBDUUdw5gc7BjgmyIfC+hYkij+GncLLMfFuQZVyC5UKBkDwwpE7mfigbInfJCUE2LO5
         HHN9FnORqwJtSEIbUWwaUoJ9jrRM6g0oHGNNXCRxMcWoZWVSiAN8rJwrf8cn4eJQ1Bdw
         Z8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hlcD4mBl619MgaHciYViGbfD9oWOmC4uxOrCB3gT72Q=;
        fh=Wos2RGThg8Von/2fEFifEOCJu1nAqJBSvQGYkzXvMlc=;
        b=VFeU/RHTxRYcloixjhTMHpPSm4bf8hJA/N+KerIi6uR5iFS9ZX3Jl2fLYbrBgt8S5z
         6p8z/+NXH+VYXIg54sQxhZTjvP/hp/UYkPhMSebnLWK4XIptSZRMCXWSx0v20rC5LFjp
         uqpIrpwgUAoDI7kZlZ+AxfXip0VO0pr3pmOEbcSUmhYU2sQAErPAdkjfA742LP+DNfNU
         TnMt7XjAsuv2L728vD80rR2OqMl2xgF94w2nY2pzOKtO+MzxQSd/T1MbgBsjI7e3ujUN
         YYLoSfOlpotsLes3z4aYqSbLlRMUq7krEeGsE4qH3HeFLgXkMbeW4Wa8TSd9Ew8ZHmif
         PbZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771417066; x=1772021866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlcD4mBl619MgaHciYViGbfD9oWOmC4uxOrCB3gT72Q=;
        b=jtHXFFuq9oIBJW8btJyurQEyAF2WydkaXlgQR6f4iJPoq5elbIryYxtRVpW26wcsVz
         GtvCaFPzDk+h5la8qeolFcdBHvxD1lEhRd+CRcZ4SW0PoK13CSnVVUdI5hJGIvO8VIzr
         BWp2uleAjTUGrCXUOjBQaV+9+Do+xHU6hh59Z2O7g1MmzB3xY9pGu1S8wmvWmsJfxQH8
         yTOOKMatjB4yDuFc+8LBFrQEAImdHOch63/R1faCNLs8CXxQAqRRUemgerIu5tn6QPXZ
         C455NisL22lk8NTSokEcjpXOOW5A4altW8T4tHf67VBy4rf285/v0RhjZnGY/ucw60lP
         +TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771417066; x=1772021866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlcD4mBl619MgaHciYViGbfD9oWOmC4uxOrCB3gT72Q=;
        b=k53ANsrren+kYA6NoboOR0itzD/Yvq9U7QUQU1x5MzEUbwQJ3FGlwawdDyVV9VDcwY
         I/+bRn0ldPtDVBJTFyo/WdXC6MpR18pBCo7BqscYMr5cL+sLwbdfUdvocMonLMg/OXIM
         9p5bduUmMlOGKz2Jj4NeanJMX/ozhfCSvIMr4P1JHVMs9sJgj+auyxJhK1imSnvLWIAg
         SXpfp1q3St20cuWxbWYsqUylwT3iN01hCafN0VCDc5NG25uir7IXkjzOZGP6WpIW+AyP
         Xgge3UmHBREjfFy2wI2uJa6i/jr1O28sjBFUZqg7WO9olWYWkIB5qh3zEdSl/TujFpbY
         NElg==
X-Gm-Message-State: AOJu0Yzm3hhJY38B3HuzcL/fyl+xnzffD+VWbe9Si3mzqKMQTDORkYKq
	4Cyns69noTBMAt6EN/mURR6s662ld/1bY8yExBrFZiXTh7Vch05zxrviXvwnmyW2+w7h/0KzPgj
	2Xq6wSPHtVTtq3YU6R1raGLy2BaXwBaM=
X-Gm-Gg: AZuq6aKuG8xvL0S/7Y6v8NU1NVQdhlVtua97kU3GSBMw2pWjhQSFjjQ4ArBbJ90Kgq5
	yp1rU8oLtpAhtNpb51U86jJy3BKtpeYRevLIFxwVRefnkhY0ZCPlr3vJQQ6SH/UFdw9ZqnSP+J2
	Znbr/n1mF4SX576nkQILdqClXvT7wkb9tCgGlxg5MdzouLEHjWNEzQJvM2089I6FHEjlbrEq9Pa
	PbbB7tJVMwNgMc7CPvecWz7JMrMO6k+uJtU7gp4mBWewFH/P7IScH/06FoP0IBsHkE20LZrGt7/
	8psE6uYZIaVTJGUetqcdXw21c31Ni7WISQoYUA2HlPDkOYH2tcidTlOyucIYiz8JzaZT9U3QHay
	IwpHuJxdyVhbY0aMeS7OkncgNNgRgzH4oa6rem7zDGUyV9BKGvMvaOhBX93iqLoZ89aDvO/XuEM
	DJXR+jFFOs8KJuGyE12SY/XH+oGPotZxyD1wsmUg==
X-Received: by 2002:a05:7300:23cc:b0:2ba:769b:813e with SMTP id
 5a478bee46e88-2baba13689dmr6737357eec.38.1771417057499; Wed, 18 Feb 2026
 04:17:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217200006.470920131@linuxfoundation.org>
In-Reply-To: <20260217200006.470920131@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 18 Feb 2026 13:17:24 +0100
X-Gm-Features: AaiRm50U6OECfKkNegrsfdYjbIrz9JKTIu4dsD8NtGlz0cAT1gG99TY7AZgdDj0
Message-ID: <CADo9pHiSp3BrQs15Dc-E4TZTx9aHWpsnT1ZQseh222ZH0XdAzQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/43] 6.18.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luna Jernberg <droidbittin@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217279-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07CAA1564B6
X-Rspamd-Action: no action

Tested on: Arch Linux Machine a Dell Micro 3050 with a
model name    : Intel(R) Core(TM) i5-6500T CPU @ 2.50GHz
and works as it should


Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tis 17 feb. 2026 kl 21:52 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.18.13 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.18.13-rc1
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to do sanity check on node footer in {read,write}_end_io
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to do sanity check on node footer in __write_node_folio()
>
> Fabio Porcedda <fabio.porcedda@gmail.com>
>     USB: serial: option: add Telit FN920C04 RNDIS compositions
>
> Danilo Krummrich <dakr@kernel.org>
>     iommu/arm-smmu-qcom: do not register driver in probe()
>
> Yeongjin Gil <youngjin.gil@samsung.com>
>     f2fs: optimize f2fs_overwrite_io() for f2fs_iomap_begin
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to avoid mapping wrong physical block for swapfile
>
> Daeho Jeong <daehojeong@google.com>
>     f2fs: support non-4KB block size without packed_ssa feature
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to avoid UAF in f2fs_write_end_io()
>
> Yongpeng Yang <yangyongpeng@xiaomi.com>
>     f2fs: fix out-of-bounds access in sysfs attribute read/write
>
> Yongpeng Yang <yangyongpeng@xiaomi.com>
>     f2fs: fix IS_CHECKPOINTED flag inconsistency issue caused by concurre=
nt atomic commit and checkpoint writes
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to check sysfs filename w/ gc_pin_file_thresh correctly
>
> Zhiguo Niu <zhiguo.niu@unisoc.com>
>     f2fs: fix to add gc count stat in f2fs_gc_range
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     fbdev: smscufx: properly copy ioctl memory to kernelspace
>
> Guangshuo Li <lgs201920130244@gmail.com>
>     fbdev: rivafb: fix divide error in nv3_arb()
>
> Chen Ridong <chenridong@huawei.com>
>     cpuset: Fix missing adaptation for cpuset_is_populated
>
> Tiezhu Yang <yangtiezhu@loongson.cn>
>     LoongArch: Rework KASAN initialization for PTW-enabled systems
>
> David Hildenbrand (Red Hat) <david@kernel.org>
>     mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables us=
ing mmu_gather
>
> Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
>     arm64: dts: mediatek: mt8183: Add missing endpoint IDs to display gra=
ph
>
> Alban Bedel <alban.bedel@lht.dlh.de>
>     gpiolib: acpi: Fix gpio count with string references
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/fdinfo: be a bit nicer when looping a lot of SQEs/CQEs
>
> Ziyi Guo <n7l8m4@u.northwestern.edu>
>     ASoC: fsl_xcvr: fix missing lock in fsl_xcvr_mode_put()
>
> Melissa Wen <mwen@igalia.com>
>     drm/amd/display: remove assert around dpp_base replacement
>
> Melissa Wen <mwen@igalia.com>
>     drm/amd/display: extend delta clamping logic to CM3 LUT helper
>
> Deepanshu Kartikey <kartikey406@gmail.com>
>     tracing/dma: Cap dma_map_sg tracepoint arrays to prevent buffer overf=
low
>
> Charles Keepax <ckeepax@opensource.cirrus.com>
>     ASoC: cs42l43: Correct handling of 3-pole jack load detection
>
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     platform/x86: panasonic-laptop: Fix sysfs group leak in error path
>
> Maciej Strozek <mstrozek@opensource.cirrus.com>
>     ASoC: sof_sdw: Add a quirk for Lenovo laptop using sidecar amps with =
cs42l43
>
> gongqi <550230171hxy@gmail.com>
>     platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro
>
> Breno Baptista <brenomb07@gmail.com>
>     ALSA: hda/realtek: Enable headset mic for Acer Nitro 5
>
> Dirk Su <dirk.su@canonical.com>
>     ASoC: amd: yc: Add quirk for HP 200 G2a 16
>
> Tagir Garaev <tgaraev653@gmail.com>
>     ASoC: Intel: sof_es8336: Add DMI quirk for Huawei BOD-WXX9
>
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     platform/x86: classmate-laptop: Add missing NULL pointer checks
>
> Brahmajit Das <listout@listout.xyz>
>     drm/tegra: hdmi: sor: Fix error: variable =E2=80=98j=E2=80=99 set but=
 not used
>
> Deepanshu Kartikey <kartikey406@gmail.com>
>     romfs: check sb_set_blocksize() return value
>
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - fixed speaker no sound
>
> Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
>     ASoC: cs35l45: Corrects ASP_TX5 DAPM widget channel
>
> Zhang Heng <zhangheng@kylinos.cn>
>     ALSA: hda/realtek: Add quirk for Inspur S14-G1
>
> Xuewen Yan <xuewen.yan@unisoc.com>
>     gpio: sprd: Change sprd_gpio lock to raw_spin_lock
>
> Anatolii Shirykalov <pipocavsobake@gmail.com>
>     ASoC: amd: yc: Add ASUS ExpertBook PM1503CDA to quirks list
>
> Alice Ryhl <aliceryhl@google.com>
>     rust: driver: fix broken intra-doc links to example driver types
>
> FUJITA Tomonori <fujita.tomonori@gmail.com>
>     rust: dma: fix broken intra-doc links
>
> FUJITA Tomonori <fujita.tomonori@gmail.com>
>     rust: device: fix broken intra-doc links
>
> Anil Gurumurthy <agurumurthy@marvell.com>
>     scsi: qla2xxx: Fix bsg_done() causing double free
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                           |   4 +-
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  37 ++++++-
>  arch/loongarch/mm/kasan_init.c                     |  80 +++++++-------
>  drivers/gpio/gpio-sprd.c                           |   8 +-
>  drivers/gpio/gpiolib-acpi-core.c                   |   1 +
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c |  30 ++++-
>  .../drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h |   2 +-
>  .../drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c    |   9 +-
>  .../drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    |  18 +--
>  .../drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c  |  16 +--
>  drivers/gpu/drm/tegra/hdmi.c                       |   4 +-
>  drivers/gpu/drm/tegra/sor.c                        |   4 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c         |  14 +++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  14 ++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c              |  24 +++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h              |   5 +
>  drivers/platform/x86/amd/pmc/pmc-quirks.c          |   7 ++
>  drivers/platform/x86/classmate-laptop.c            |  32 ++++++
>  drivers/platform/x86/panasonic-laptop.c            |   4 +-
>  drivers/scsi/qla2xxx/qla_bsg.c                     |  28 +++--
>  drivers/usb/serial/option.c                        |   6 +
>  drivers/video/fbdev/riva/riva_hw.c                 |   3 +
>  drivers/video/fbdev/smscufx.c                      |   8 +-
>  fs/f2fs/data.c                                     |  51 ++++++---
>  fs/f2fs/f2fs.h                                     |  64 ++++++++---
>  fs/f2fs/gc.c                                       |  24 ++--
>  fs/f2fs/node.c                                     |  50 +++++----
>  fs/f2fs/node.h                                     |   8 --
>  fs/f2fs/recovery.c                                 |   6 +-
>  fs/f2fs/segment.c                                  |  86 +++++++-------
>  fs/f2fs/segment.h                                  |   9 +-
>  fs/f2fs/super.c                                    |  26 ++---
>  fs/f2fs/sysfs.c                                    |  62 +++++++++--
>  fs/romfs/super.c                                   |   5 +-
>  include/asm-generic/tlb.h                          |  77 ++++++++++++-
>  include/linux/f2fs_fs.h                            |  73 +++++++-----
>  include/linux/hugetlb.h                            |  15 ++-
>  include/linux/mm_types.h                           |   1 +
>  include/trace/events/dma.h                         |  25 ++++-
>  io_uring/fdinfo.c                                  |  11 +-
>  kernel/cgroup/cpuset.c                             |   2 +-
>  mm/hugetlb.c                                       | 123 ++++++++++++---=
------
>  mm/mmu_gather.c                                    |  33 ++++++
>  mm/rmap.c                                          |  25 +++--
>  rust/kernel/device.rs                              |   6 +-
>  rust/kernel/dma.rs                                 |   5 +-
>  rust/kernel/driver.rs                              |  12 +-
>  sound/hda/codecs/realtek/alc269.c                  |  13 +++
>  sound/soc/amd/yc/acp6x-mach.c                      |  14 +++
>  sound/soc/codecs/cs35l45.c                         |   2 +-
>  sound/soc/codecs/cs42l43-jack.c                    |  37 ++++++-
>  sound/soc/fsl/fsl_xcvr.c                           |   3 +
>  sound/soc/intel/boards/sof_es8336.c                |   9 ++
>  sound/soc/intel/boards/sof_sdw.c                   |   1 +
>  54 files changed, 877 insertions(+), 359 deletions(-)
>
>
>

