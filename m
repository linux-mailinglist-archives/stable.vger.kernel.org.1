Return-Path: <stable+bounces-107990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF8A05C44
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 14:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14AF43A55BA
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 13:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DAB1F63D9;
	Wed,  8 Jan 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="VOAqhO61"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881011F3D53;
	Wed,  8 Jan 2025 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736341260; cv=pass; b=ACkaZHSECOb2L+UDvi7/oULXbqZdxgEQZBP/Q4MO+GMkObVNyC59sOtFWdkxGUgG7RVoreHH/yJFznadUgd/qcH176n2YHBtfAwUbQCzLT3W/hwBNzUcyv75QeX0DKyIRAI2UWESYrVIaGT8o33SoojOt9JNaSx+7xuY0vq2uVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736341260; c=relaxed/simple;
	bh=tnTizHbo5RCVXiv/k44EMtNNSlcV8XEFxWPds94nEiU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jYBYLQ4+J1zGzbkvqhmeJJSxRKuDVlPnz5SkxBMjN01gRMzYILud0vE1Ao2eMJFDIwqQrKDCm23w7OWF4Sm/HC+VmEu7ex9qCfUCN5By0VF/V400u5Suh2J9UlU7PMD4pTtQcE3zO44TPgy1Rbx5FUQNuM5nf0YGfxBKb9b2HoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=VOAqhO61; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736341225; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DH/LOQZfq01z/2t2GaD9VUKmNUlGvwWvPBSvttSNzrhpNUOkHj2O4anSjPMIlJxGslRmAvmdC3lev3YlqXLHkWdyGSTP00d5ZCmu3GwKBMBBzqj9EWp+GhOM8/hbUQwPeK1hXhWMxSPh6mo+Kjtl+gpqdfvJgaWFxNdmrWalyVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736341225; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Hq+0i0owL/LZnmcbP3iuFwoYgT0nRlEWFd9Yf09SLY0=; 
	b=SB7Qqw9hZzNnIHFtTx+BZSJSiY3huPCdtNb39YfMieztH5hg25lL5LjerS2wxvpiPP4g6jm10IuQMDsZdrKBBVqpJk46R/DvEqRFhmnkm2I5/xDKAyG7eWbSqCJEK2zKKXbFEHFcnQutpg74CWc/TAhlaAd1Xa1qoPuVNzMztjQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736341225;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Hq+0i0owL/LZnmcbP3iuFwoYgT0nRlEWFd9Yf09SLY0=;
	b=VOAqhO61v+fXipESqurfzHnyR0L15zNpuHGd7/CzWPBMKutEn3Rl2epna/ntyTUA
	zEX2c0XBGJiJzsEu7kfFABq3MlPKKJ4teupCBPY3i+sZhxgF1cUfDRXtRf9Jnw8QSKZ
	nwvbDV2NATAlT9wBdDY55p3yKNLPjundhCmzwvqI=
Received: by mx.zohomail.com with SMTPS id 1736341222896299.72530666439025;
	Wed, 8 Jan 2025 05:00:22 -0800 (PST)
Message-ID: <9382652c-939d-4368-a4b2-93798ba0da19@collabora.com>
Date: Wed, 8 Jan 2025 18:00:40 +0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.4 00/93] 5.4.289-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250106151128.686130933@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250106151128.686130933@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 1/6/25 8:16 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.289 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.289-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
OVERVIEW

        Builds: 34 passed, 4 failed

    Boot tests: 384 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v5.4.288-94-g0578e8d64d90
        hash: 0578e8d64d90f030b54a4ced241ec0b7f53a7c57
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y


BUILDS

    Failures
      -arm64 (defconfig)
      Build detail: https://kcidb.kernelci.org/d/build/build?orgId=1&var-id=broonie:0578e8d64d90f030b54a4ced241ec0b7f53a7c57-arm64-defconfig
      CI system: broonie

      -arm64 (cros://chromeos-5.4/arm64/chromiumos-qualcomm.flavour.config)
      Build detail: https://kcidb.kernelci.org/d/build/build?orgId=1&var-id=maestro:677c0e55423acf18d2736a33
      Build error: make: *** [arch/arm64/Makefile:170: vdso_prepare] Error 2
      -arm64 (defconfig)
      Build detail: https://kcidb.kernelci.org/d/build/build?orgId=1&var-id=maestro:677c0e9e423acf18d2736b66
      Build error: ./arch/arm64/include/asm/memory.h:85:50: error: ‘KASAN_SHADOW_SCALE_SHIFT’ undeclared (first use in this function)
      -i386 (i386_defconfig+allmodconfig)
      Build detail: https://kcidb.kernelci.org/d/build/build?orgId=1&var-id=maestro:677c0ea8423acf18d2736b8c
      Build error: arch/x86/events/amd/../perf_event.h:838:21: error: invalid output size for constraint '=q'
      CI system: maestro


BOOT TESTS

    No boot failure found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=0578e8d64d90f030b54a4ced241ec0b7f53a7c57&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


