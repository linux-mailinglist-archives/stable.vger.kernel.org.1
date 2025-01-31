Return-Path: <stable+bounces-111838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF86A240F3
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 17:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A773AB7F2
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA16A1F7096;
	Fri, 31 Jan 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="TC2S47Vu"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A79F1F2362;
	Fri, 31 Jan 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738341333; cv=pass; b=P+zMY6X6XLa5r3Dzam+RfzJe6NJnhhMvveop2ez4LSbDaUYO2eFOscFmNcJkji9NP66tZi6h3D4WJ+F31VVBsTrqnCXcfRb7b4wERB3XvKsVth3QA/RmFC2abqiS/Z/n3oLjmxzhZUMbqI2stzWIIWTCQ4X3msiIzBNP6iwxscY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738341333; c=relaxed/simple;
	bh=XgS2L+34Ke6xvustNM7+wFuXH1wzkd14SDXRbm0A/oA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q8co6u4TnCCVvWT30KH+GKUZTsKX5LqZiU10sIhOSq1LSALgvSuzh5zmWeg2AupQUiAkmQrZ38pO5OeyjWSHCLLF5c5pmBLjBnaTwXcYxHdXCwxkeoCNbMkBlsj6fcE+S7dvykdUaBJCs4Nzu61VNernQV1IfvukweA+2po+A/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=TC2S47Vu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1738341300; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QfD505EplMj5AN+t6edHdq2nCeftCErH7fex6Er/JI3uG687V7y/dscPg9mVR0wiejzcjv9g2Wlwl5K/98EGG0b3JZhk/g9OXKh7+KI3w1V/WiZwMoBYSCaugWgCknUuNJfhTsoO/bESxsXjxWDEQOuNp3U84dcy0mTB/7U1Ur8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738341300; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=s/MwLXdW6lhe4b4SYznH7eP7SAUBl5VqxWFZqTXi7iQ=; 
	b=OAZrVKRey7a8eUkG3/F6tIoZwop1VbYWu0YeZP2QF5usmZMW/jGeFxF7PdbKdfTi28tmpty97FsKhkPJs7qpfNnbb0yswAJ8nkkY6HVDY2nhkrT7h6W5DacV6EJUoTrOvrLTsmMiBMXYxEiD57D+qhHC6TlRgzfXW8IELxE/nJs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738341300;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=s/MwLXdW6lhe4b4SYznH7eP7SAUBl5VqxWFZqTXi7iQ=;
	b=TC2S47VuMc13CFMFXnYaH/WISyO0Lj3Z1ZP/7glZ3H1skkcE/fi7c32CLQd2dlQD
	cwQX8uzQlb/OaLxt9Bq5YWxI+mb8RPn3mjXoSPntXaNUVS2tDdV/3I7nbi0pgHN5NlL
	hwtMB0wRxi4h+wFZrnGHN810pyjMGRX2Nn2bXmOA=
Received: by mx.zohomail.com with SMTPS id 1738341294735759.9478557279423;
	Fri, 31 Jan 2025 08:34:54 -0800 (PST)
Message-ID: <a6d110a7-a46d-4d80-82b1-ddf33395b46b@collabora.com>
Date: Fri, 31 Jan 2025 21:35:12 +0500
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
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250130144136.126780286@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/30/25 7:41 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:41:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
OVERVIEW

        Builds: 29 passed, 0 failed

    Boot tests: 667 passed, 2 failed

    CI systems: maestro

REVISION

    Commit
        name: v6.12.11-42-g4d14e2486de5
        hash: 4d14e2486de5514e8267e9061685a372056a2b94
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y


BUILDS

    No build failures found

BOOT TESTS

    Failures
      arm64:(defconfig)
      -mt8195-cherry-tomato-r2
	https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=$__all&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:679ba54865fae3351e318fd9&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=$__all
	https://kcidb.kernelci.org/d/test/test?var-datasource=edquppk2ghfcwc&var-origin=$__all&var-build_architecture=$__all&var-build_config_name=$__all&var-id=maestro:679baad565fae3351e31b376&from=now-100y&to=now&timezone=browser&var-test_path=&var-issue_presence=$__all
      CI system: maestro

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=4d14e2486de5514e8267e9061685a372056a2b94&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


