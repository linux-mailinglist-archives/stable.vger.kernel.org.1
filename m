Return-Path: <stable+bounces-86616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C2A9A23AB
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 15:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E532D28B5E7
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037A21DDC21;
	Thu, 17 Oct 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="A8E6avh7"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CA61D435F;
	Thu, 17 Oct 2024 13:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171304; cv=pass; b=fDhMHY/7/DKTHIueCBNs86su8Mi13CxcjczA0PyLLWe/xrJ1FJLWw1ljFaTnbvqppYqnJYSBheKiZOBaQr5nVifCfscOiZo+JCM57Vn9NOYY49Y9KrmCqbko3jDepAv9JhjVgTBg0uzb5sxJHhpXkMp8RTg3lyrDHILMJU3H0lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171304; c=relaxed/simple;
	bh=iJwhTHY21oguyKVfA4vBnK09HrtZp6vHv09zWx07d5Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CaEi4fZa1SmKT7+gchvawVH2Z35U25O9ujS7+AbxLtdzcFP109GjmRBvetxo+b571MCY7/YwAITA+xPRCODNgtmOfH4JEKCnNdYWXok8sTL6dXI6X7t/hzmaSwYzdQx8Pzh553p0Qfgfud7Fzw56Ks/EIZ4UkBGYYuDX+LWc7Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=A8E6avh7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729171257; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A+MBQLjkvAVauiguJVpYtURYY/Vng8ESTaqG9GNH0dhiAO3XHJLEr6wRmpUcHEGNjsZILzPYCXkpUbs+wCVGLNLaC8M5Qc1oasYvHi2Zs54bdTdA5H0HjkstE4uoyoqIweOzDCPr2wPKPO4m0vLsvCTzOB55AsliMwajHicJG8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729171257; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sk9U3jIp2/CPs8MdfD4LZ6p7s36kmaHrSOQaWLkeJlE=; 
	b=CCXSDP8Rn4EAE77HqONQh6w/7mFrEVVKt1736VGfLZLPxqzvCwjXSiABgoQYGGzFN8J3FPprvix/DkHffT2Mp8nYaAWImvCZiC1Y/IGZf+/0DVTijwyLMwXstl5gys8LESHomYvFKLhE9J56LMifC1axSMRqXrnwHEjxMc11Qbs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729171257;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sk9U3jIp2/CPs8MdfD4LZ6p7s36kmaHrSOQaWLkeJlE=;
	b=A8E6avh7Jj2S04BCdFs9Vl3NWdNQDsbpOFMRT52mZN1oesgtMI9e1Le6H4p5vgYU
	OYY2IWPFVTfzs0pXm2GCkXoVWCOpRm/nAZPfEm3WqtmyVgNhUTeZSG0EuFxQT7/H77V
	Uj2VmbMaOJLqWmHK3dIhD3awIh7DYfqUa/suynJk=
Received: by mx.zohomail.com with SMTPS id 1729171255253769.7356385334499;
	Thu, 17 Oct 2024 06:20:55 -0700 (PDT)
Message-ID: <f0878449-7cb9-4320-bae3-183a95ff3d53@collabora.com>
Date: Thu, 17 Oct 2024 18:20:44 +0500
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
 allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/211] 6.6.57-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241015112327.341300635@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241015112327.341300635@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/15/24 4:25 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.57-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 25 passed, 0 failed

    Boot tests: 62 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: a3810192966c3144d8cf988e8a13fc18a2dde677
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=a3810192966c3144d8cf988e8a13fc18a2dde677&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


