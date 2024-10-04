Return-Path: <stable+bounces-80730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19E9901B2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 12:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4BF282D68
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 10:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A90215574D;
	Fri,  4 Oct 2024 10:57:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-61.mail.aliyun.com (out28-61.mail.aliyun.com [115.124.28.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B43156F3A;
	Fri,  4 Oct 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728039435; cv=none; b=kaClvl0p+pPtwV75mmgmjRX1QEAIG+7kLYxPQF9MIbdBsrRpQXi1Lrgn9pOd9lZs6YFO0rrZt4HTE0epyKkhhHfxH1QfMEZ0DVGVfNVWfeI2RNIydYnul4YMfwegRSyrK85eH5WbbPf7RzdIYJJGPSJtl7J1PzFJI+rtkZeyCT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728039435; c=relaxed/simple;
	bh=xgotsJYrQkUik75kgemkKnDvJIXuzfmllRMSabhTQYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=h6mc87mkjiOAq5geamCRXMP1t5wltx9eYuWAE+Wq8k9Kz9yEUn2weJ2XiVZFXB5unNcrQBMXuThG8akB+1z8KEko39edt95AXmVJ1u7igpVeHzd8Q1GT3Gtfk3cz5N5YlubYylzHI9kWrJ6LKUarBQxYRUglLOT0Up15Nd+Bhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.ZYwd.tJ_1728039424)
          by smtp.aliyun-inc.com;
          Fri, 04 Oct 2024 18:57:05 +0800
Date: Fri, 04 Oct 2024 18:57:07 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org,
 akpm@linux-foundation.org,
 linux@roeck-us.net,
 shuah@kernel.org,
 patches@kernelci.org,
 lkft-triage@lists.linaro.org,
 pavel@denx.de,
 jonathanh@nvidia.com,
 f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net,
 rwarsow@gmx.de,
 conor@kernel.org,
 allen.lkml@gmail.com,
 broonie@kernel.org
In-Reply-To: <2024100426-wheat-heavily-68d1@gregkh>
References: <20241004071723.69AD.409509F4@e16-tech.com> <2024100426-wheat-heavily-68d1@gregkh>
Message-Id: <20241004185705.7AA1.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.07 [en]

Hi,

> On Fri, Oct 04, 2024 at 07:17:24AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > This is the start of the stable review cycle for the 6.6.54 release.
> > > There are 533 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc2.gz
> > > or in the git tree and branch at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > > and the diffstat can be found below.
> > 
> > A new waring is report by 'make bzImage' in 6.6.54-rc2, 
> > but that is not reported in 6.6.53 and 6.12-rc1.
> > 
> > arch/x86/tools/insn_decoder_test: warning: Found an x86 instruction decoder bug, please report this.
> > arch/x86/tools/insn_decoder_test: warning: ffffffff8103c4d5:    c4 03 81 48 cf e9       vpermil2ps $0x9,%xmm15,%xmm14,%xmm15,%xmm9
> > arch/x86/tools/insn_decoder_test: warning: objdump says 6 bytes, but insn_get_length() says 0
> > arch/x86/tools/insn_decoder_test: warning: Decoded and checked 6968668 instructions with 1 failures
> > 
> > the root cause is yet not clear.
> 
> I've been seeing this locally for all 6.6.y releases, so for me it isn't
> new, and I can't seem to track down the root cause.  As it's just now
> showing up for you, can you do a 'git bisect' to find out the issue?

'git bisect'  show that the root cause is
	x86/entry: Remove unwanted instrumentation in common_interrupt()

after reverting this patch to 6.6.54-rc2, this warning does not happen.

gcc --version:
gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3)

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2024/10/04


