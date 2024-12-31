Return-Path: <stable+bounces-106604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E017A9FED98
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22A71882DBA
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5E5186E27;
	Tue, 31 Dec 2024 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Yu8uI2jm"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E71632FE;
	Tue, 31 Dec 2024 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735632110; cv=pass; b=O1BiCogRXd3Iwtr7aj/ydwPA0KrySXr0x/jVNq72aN8hk2bi3ypmKKLX81VziKFzHWNwkev0rjkBCVOAwyJE/3DaUMrRXPjqdFDoxr8SV8KfqDvTEASFZI7kAxV+X2Bj0204I7fb8urkJ4LPqVMgotDf0M5GTb3Ej882h1ycBkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735632110; c=relaxed/simple;
	bh=iNSIhzhs2Lo8518VSM3pwlMsO5x5lSXZOTSKCR5LLL4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jBF1i8oaj9w9a6h6pYHUgGsp547VkgaH33vU/kCZrqE6UVE3CMoa+6QWIW+kVT+c4wHoe5zDpRCPaysMKfxICjowRjSMeqXQkJORw9upm+HIcVvX4C8nhBJarwN6DIgpiuDlqXMOID9I675jSkHMAGld3ux0GjeIzMg7TzlIXkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Yu8uI2jm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1735632076; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Iy+ZSdu4WSBzPtScQCLsvUksVHuXPrFh4P0tuWQIjfPMwq81dGt17anuO7c4CoO73zhn69nuAe442E0wv3B3CHgRV8Zt25JuMAZ82xoMTXKxUPJCEJ8wQ82nLVrUOS5O12/kH6zHRQtdPFL7ZhQWfCE/iF4X1YnkiRzawFycYh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1735632076; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x9F/JkDKq0zQoTXZBBjeaQzwYY5oUXrQgM0P+vHnjH0=; 
	b=NJin+fdeyg4+S8UpC+Bk41zAMFTGm6RUbUSIOb9133V3Kqf+vdcVxA3LnRf9/2WL2CUVlrFfKlqJK9dBzBsvuxXWOHy6Muf6V4hO0sZHtVyy4E0UR6LYYv+1RcYlvwj+qhe0PRhdzyyHL47JmaDa49Zlgjb7p80hCCgIEVrPTx0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1735632076;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=x9F/JkDKq0zQoTXZBBjeaQzwYY5oUXrQgM0P+vHnjH0=;
	b=Yu8uI2jmJRAvhL5UJpOTW7VPEYMNGOVDrvsByUjgQDHY4KIwxX7LXHFmvx2P5aNT
	zrjWnv192eYR1/35AAXKzRAKqBUX5ba96fa7UG2McDQ5V6wPvYk4LuSDfAwD7dmId7S
	x1yIZmwvNH/RzKRDQm3jgVttt+YZ6d2FUbv7UHsg=
Received: by mx.zohomail.com with SMTPS id 1735632074473517.68000306542;
	Tue, 31 Dec 2024 00:01:14 -0800 (PST)
Message-ID: <a1162760-b451-4c11-b5ca-536ede236bb2@collabora.com>
Date: Tue, 31 Dec 2024 13:01:28 +0500
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
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241230154218.044787220@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/30/24 8:41 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
OVERVIEW

        Builds: 41 passed, 0 failed

    Boot tests: 580 passed, 1 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.12.7-115-ged0d55fbe89cd
        hash: ed0d55fbe89cd97180e55170f9f3907b2aa5f91d
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y


BUILDS

    No build failures found

BOOT TESTS

    Failures

      arm64:(defconfig)
      -mt8186-corsola-steelix-sku131072
	[    6.051924] Device 'adsp_top' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
	[    6.064309] WARNING: CPU: 6 PID: 74 at drivers/base/core.c:2569 device_release+0x170/0x1e8
	https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:67731b7b423acf18d2654a3c&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=$__all
      CI system: maestro

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=ed0d55fbe89cd97180e55170f9f3907b2aa5f91d&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

