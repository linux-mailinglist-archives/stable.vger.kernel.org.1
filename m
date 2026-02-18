Return-Path: <stable+bounces-217278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM2BGNatlWnbTgIAu9opvQ
	(envelope-from <stable+bounces-217278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:17:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A71564A8
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77786300D54C
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159BC311952;
	Wed, 18 Feb 2026 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoPtVf8u"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722743101D3
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417024; cv=pass; b=DiYgUwH8Fk1JmUbnzol8666ZMTcaNoS0a43KUz0oiH3Nb/HWkm89JcnessbApcCmt+o8u6nYHdm+7Eh7b0OaRJ1WZOHI9JZSlswjw7xrBEp9fR0QKQGryQ6128Cpr86s6NW9Ec0vS7R7fpAq+DLGUsiDpTEGTSvOU39BOYO/RH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417024; c=relaxed/simple;
	bh=Q52a4UJfvIsleI0KiLJqmKoW253Zn7XVEUEx+gL2Nbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKl5B9Bp2eTkjZON5NzT/t8bSmcTmrTphMDRO8LV6g8ebAQ4LBgpgMHGEjMCI4uSYMt3P4LOTDTsrrC7tsvcI4Um712Yr5rXDQOd6zw2ZfhUP6C1t9dkyKAf4xOQ9iCW5ucaolOZ2nJRwnOpqxhjGlN6Qw6vfY8zA9jCSGwslAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoPtVf8u; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ba68df3687so9059951eec.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 04:17:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771417022; cv=none;
        d=google.com; s=arc-20240605;
        b=jygzS23Mf3U59nmtvokJESeiBYb8pb5mcIpiEms7siRTjxre617GKTCumxWiL6ScYm
         RqmPQSOT2US+FQXvJcxf7MxpqP2IprPh1NMWWrtRU24aM7tzbON5iwYbNFPiwAZRdjol
         k31/R9eaCDf6zk/Mr0Lq9sKC2do6t30Z0pfd67WSKluQx+g36gT23wknqy+Y6o5rM1V3
         bftVQFIg6UDR6B2HrcipHh59h9goakZ0dv43kS062TAfm8nbPPFlOWQ28ApsNQBQLNRl
         9YR80rrUrYbRmb2g1YGh/3trLjkELPgpoz5SND86ZMaHWbIbQkWmNaWqGfvOhgLb4ucK
         tVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ozglTU0/5jdL+iGl35JF4KdKCYTgtwfXNxsYuR40g5k=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=IK+BquxaxZY8yGJZc6069noZ3DoX5VfMgQi4flqiUtoDg5/DMB90QQrg+WgyvxmZ5D
         YdBQB3cecRa2tVhSinpJLBbn5sh1KJKS8tOgVWb97B3JQ84VvBiR5caW0VUppx/bn667
         /ivC9l8JN9ebu+cOX1n/iip7XWHZUSBfmZYcpPIBNmKJvr8AYWNzdvMYsdNZrXyXmMV0
         dsozDw5rOYjvSWHqioLOZuUgAbsRWb5EpcUy9IoE3Y+2uVbY+PF0fplYL8DYPXmlbY/r
         V4iJ/doo8Ox1WP7qhPScTzeNvN/WINDa6CzHcaNPG9gUmHM1C86eAODA6PUcleQJkTah
         7qnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771417022; x=1772021822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozglTU0/5jdL+iGl35JF4KdKCYTgtwfXNxsYuR40g5k=;
        b=NoPtVf8uJlYpLGykReRIzDfCS0WGZ8ENZ3cDmZ8gHywnC5q8pDvVS2jYZ87Fg4CYTr
         DISERzZXJIZbM4KB0NSFXr7YteAh6lkO/EMusezoGI5ebSHYEzVlEhbpgA62bY2dGHtg
         10XsuM5YUmRGi+OLj85Ar7xOB4i/YAxdEPCbVUB0FUCGySvkZvXLN8/KTMe0De7G6VGd
         P1tlFDyW41NByv3tgHhe3TpYYom3kBnw3mIl8ft7jsYCa8KkNtNA2OjEwiq3Hq/+5jOw
         LAjlGXIDg5cxxBw9/L7sr3wF+eJuL6U5uBAVbpr4PsXNFMmTg853eRTLz+qOIoEt4Lru
         wqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771417022; x=1772021822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ozglTU0/5jdL+iGl35JF4KdKCYTgtwfXNxsYuR40g5k=;
        b=P1tU5zG/t2ll2zyQX/kIqdVFhlqDxNqGqAPcjLD2+3IDkfkDGKXEdRJnSpGJ6zIS9T
         I1zZBEgGfYat7pB0yFKboC9m3lG+N7tVLdnNcjQOjVVrU0rYjnA217HXCETd1EJb6i+t
         2neUVE/wl2RZ3CH30cxHfzxxlk2tgPn9Yw8pJ3zB7nBTj3ye6FqSuwEq4L0s6+1BOW9i
         CUyAEVjgn58QEBO0Nc7Lbg0y+mWZ3+Q0en2J9wE9kN1vak16Bv2H3F8l0qYegm3Ksw7r
         rGqhC4vfUxe0ofEa07i8bmbJKKVwhiYf6bbGsNOUbD9Og6D+ddEE7xjyOgNcxzSrix1k
         7Zeg==
X-Gm-Message-State: AOJu0YyVzdCllG1c5HYQAhO2DoBl8HzdLY6LSdpuV4g5mhK0/YsPDocW
	nDsf8H8Z2xoYrc9TPrV0RcYBP5Hw410U42aMRfktksThVHGedbmCoNh0pD5pWIcsNM/EElK7O6U
	vdKlxwuktMKaSCGndRZWZ3yL+7Y2QYqE=
X-Gm-Gg: AZuq6aIjcGm9AWDPpJb1nnVgEb+HRDbPDDeou/Z1TmfGIH74k34uvBtKtXqqV2kUHl7
	ukILyOSY1KgUygnRoZmYX7WdvQl1B3pjtx0HkJ7h2HWitZ1/qNLihBvQbMfs8dFEhYX9viAjgh7
	WMtpDo69EmJoSuVMvCQ8K1oB9j9vT4mJg8o081JPTqyQEKgE7Y8xAkXIPyGG3+sLdE4Ab/p6suu
	PT/WAWJ2JuJMfhuxKRtaIqZB1BkXgv0yOVs+TZ6ChRgSlEO1idOlnqL0z2cwGDKzSrmf/mYLeUU
	zPgLUJTfzktXhzA5x3EIiBeSZceu6CepkG2BBNvZeXHIcjg6QvP9mSfN0Mv9qsWlZh4+cyMRP9W
	w7CLn9PopvNqguxXWpNoLVOvQdcrklnuJ1HgF9TXH8NuwPWA6l+sVytWtMRwrMUQwP3g7iuVYoR
	eUfdEualIAteOkNJxFWVxlTEHZuLQKrxPAOAkmow==
X-Received: by 2002:a05:7301:1e8c:b0:2ba:7404:f587 with SMTP id
 5a478bee46e88-2bac9795cfamr6303886eec.21.1771417022413; Wed, 18 Feb 2026
 04:17:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217200002.683975158@linuxfoundation.org>
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 18 Feb 2026 13:16:49 +0100
X-Gm-Features: AaiRm53lbHi9bNe7QArcmodc7DyAzejdocLDCI6dCZ7KtSzzGkFgRK0hE6V-8Dg
Message-ID: <CADo9pHjy5ZhNJb2i00GmunPWb3HpYmbqDWiKu+tKJ5AWkYbjNQ@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/18] 6.19.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217278-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
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
X-Rspamd-Queue-Id: 4D6A71564A8
X-Rspamd-Action: no action

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den tis 17 feb. 2026 kl 21:51 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.19.3 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
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
>     Linux 6.19.3-rc1
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
> Chao Yu <chao@kernel.org>
>     Revert "f2fs: block cache/dio write during f2fs_enable_checkpoint()"
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
> Tiezhu Yang <yangtiezhu@loongson.cn>
>     LoongArch: Rework KASAN initialization for PTW-enabled systems
>
> Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
>     arm64: dts: mediatek: mt8183: Add missing endpoint IDs to display gra=
ph
>
> Anil Gurumurthy <agurumurthy@marvell.com>
>     scsi: qla2xxx: Fix bsg_done() causing double free
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                   |  4 +-
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi   | 37 ++++++++++---
>  arch/loongarch/mm/kasan_init.c             | 80 +++++++++++++-----------=
---
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c | 14 +++++
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 14 +++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c      | 24 ++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h      |  5 ++
>  drivers/scsi/qla2xxx/qla_bsg.c             | 28 ++++++----
>  drivers/usb/serial/option.c                |  6 +++
>  drivers/video/fbdev/riva/riva_hw.c         |  3 ++
>  drivers/video/fbdev/smscufx.c              |  8 ++-
>  fs/f2fs/data.c                             | 53 ++++++++++++------
>  fs/f2fs/f2fs.h                             | 67 +++++++++++++++++------
>  fs/f2fs/gc.c                               | 24 +++++----
>  fs/f2fs/node.c                             | 50 ++++++++++-------
>  fs/f2fs/node.h                             |  8 ---
>  fs/f2fs/recovery.c                         |  6 +--
>  fs/f2fs/segment.c                          | 86 ++++++++++++++++--------=
------
>  fs/f2fs/segment.h                          |  9 ++--
>  fs/f2fs/super.c                            | 64 +++++++---------------
>  fs/f2fs/sysfs.c                            | 62 +++++++++++++++++----
>  include/linux/f2fs_fs.h                    | 73 +++++++++++++++---------=
-
>  22 files changed, 460 insertions(+), 265 deletions(-)
>
>
>

