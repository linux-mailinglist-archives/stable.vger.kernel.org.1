Return-Path: <stable+bounces-89091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117EF9B3564
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 16:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21E7281AF8
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C441DE4F8;
	Mon, 28 Oct 2024 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M4ZQLHX1"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA7F1DD9A6
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730130747; cv=none; b=K/3y4vlsX4sWjh57O49rxkBbMSm+8bwFlxu7FrneIn9gUjyjKRJQX3+SHXoxrMurgTWVUuHVNh9eQYbz63FafIr2TLl0FT8TgFqr0z3LqE9+3DZCOa76GOidBv6mRsjvwfl3dpm+PnYxnyXtPDR0fyYR/EAoIXbBmdK7JFybJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730130747; c=relaxed/simple;
	bh=EJ4j4fxWkmFQMUhVZGVCGTg+4bUfh3rMb1YxJ3ygpnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz5n2WHyF1gk01c1Lry5TiAGTWPvpMog7Ae2iAuEGtxiNXqM3MGRc+Hoppj/vGM9lEtOoLbwouX2wUwFWfW7fbFUGvj5GmrOrOy+7bd3fuJEzshLEvo05k827caimA7/EPtiiDNn1xJbVKJNoRZzHd6JrCjaYJZLOejaeSE6jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M4ZQLHX1; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 28 Oct 2024 08:52:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730130742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4s1VKY0ZwmwCvbsxErbp1i9wD5rVUZihhdeNL1S2sUY=;
	b=M4ZQLHX1j+hvfMsrWOy4J9QjHlJwmzo2dTgH1rlbT6dFfijLg6vGn7Ej3+cMU8yRL4mCFV
	DsIjj0gQvL7A3gmem9ThbwPWFa3nfrd187zU/AtApxyx081TEZD18ejJHOLbWF7b0+LakZ
	ZZwHxWEzhIk3JM2c028xJxO7ZR2Dis8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
Message-ID: <Zx-zLHBseRoZz4MM@linux.dev>
References: <20241028062312.001273460@linuxfoundation.org>
 <CA+G9fYu-tpwX=09=VOjniFnBz3MSXpaHb_gir2AqyNpihERT2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYu-tpwX=09=VOjniFnBz3MSXpaHb_gir2AqyNpihERT2Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi,

Thanks for the report.

On Mon, Oct 28, 2024 at 09:14:57PM +0530, Naresh Kamboju wrote:
> On Mon, 28 Oct 2024 at 12:16, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.11.6 release.
> > There are 261 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.6-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> The selftests: kvm: vgic_init test failed on stable-rc linux-6.11.y,
> also seen on Linux next-20241023 onwards and Linus v6.12-rc5
> on the Graviton4 and rk3399-rock-pi.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> ---------
> # selftests: kvm: vgic_init
> # Random seed: 0x6b8b4567
> # Running GIC_v3 tests.
> # ==== Test Assertion Failure ====
> #   lib/kvm_util.c:727: false
> #   pid=2680 tid=2680 errno=5 - Input/output error
> #      1 0x0000000000404eaf: __vm_mem_region_delete at kvm_util.c:727
> (discriminator 5)
> #      2 0x0000000000405d0f: kvm_vm_free at kvm_util.c:765 (discriminator 12)
> #      3 0x0000000000402d5f: vm_gic_destroy at vgic_init.c:101
> #      4 (inlined by) test_vcpus_then_vgic at vgic_init.c:368
> #      5 (inlined by) run_tests at vgic_init.c:720
> #      6 0x0000000000401a6f: main at vgic_init.c:748
> #      7 0x0000ffff8620773f: ?? ??:0
> #      8 0x0000ffff86207817: ?? ??:0
> #      9 0x0000000000401b6f: _start at ??:?
> #   KVM killed/bugged the VM, check the kernel log for clues
> not ok 9 selftests: kvm: vgic_init # exit=254

This is a known test issue currently being discussed [*], the KVM change
responsible for the test failure *is* correct.

[*] https://lore.kernel.org/kvmarm/3f0918bf-0265-4714-9660-89b75da49859@sirena.org.uk/

-- 
Thanks,
Oliver

