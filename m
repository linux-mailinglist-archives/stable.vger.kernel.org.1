Return-Path: <stable+bounces-89173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B49B4513
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 09:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4571C20E29
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9BE20400C;
	Tue, 29 Oct 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="bqPbX2WV"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8B20400D;
	Tue, 29 Oct 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730192273; cv=pass; b=C3IF3hzFCLfFOSQfZkotXnO1VvYt9Pw2+nsI6eJCWkaVNK7uA/z/QLKits0nm7PCf0EkvEjQk99JBTY81XmQyt9g2vy4vnOFtsXLIRe1HhrbKsS7b1lSg5pHPcm2FV4536UMoj38ANKtNe7Cunj17W+gafAYWAhrgq8/F4ozYq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730192273; c=relaxed/simple;
	bh=TGzGyc7wuss4IjaAV7A09QofoUxmcaatq/kxmxw++p0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gXCZvfHrFRlmg3eFv3/Rljbmx1eja+NvNYex0bZphUkMxN0fzDroj0smM5JLPIbxCHJab86j8uyrSBJPQ8MJ9oiDRfkBCQRmqHNM4ipcr8ii780yVEsfpo3sH14c8GSXKYBRP2KJnE3ACCptImTsACg34xQSXW7zjWD+/4CkMQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=bqPbX2WV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730192238; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TlcSX0GaJV2En//r2bsvmOaKmbjQnrSsRc9/fkFLtLhFfyykLj+j91QPFMV6JLW/caOeg+8h+ZIM4wwThVQhHAe+kwviLG6OGDhcA32v+NbHJgRIHGIwH/5k3LWuDeuucL96CEJ8c01OueselSE9qrWo1pGPmGWxZqRQbyl4xpw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730192238; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xKmGpAx2FimZ5UjrjCZxGHkEp76bSM/aSSUIPKGDye4=; 
	b=HG6HzL+3m3u7Kdf2plHxi2uOt7TmlAq0sX2jUTKnyvnvG+bsUSHjMIlZB0eYVRjZn+A9/OvVYtevjHOdUZwaoamcXPUO16jQ22sfWwvu+jAR6dp7mE75m7psDxXwtTmVI46Ns9tj53onEO1gX5XQXnTGj1LJjVnIisT0xq+KxfE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730192238;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xKmGpAx2FimZ5UjrjCZxGHkEp76bSM/aSSUIPKGDye4=;
	b=bqPbX2WVQKXAFYqv34SLfdIOzeP31MIKLC073HoJwhPqLI/1fOb9FVt7Iz/sbmKW
	gKeTvHcR28H/RlqnzfT1dz0sCcASLpyh5HUFaD/j5Nbz5xAnQl9mn2w4otHRCGNPwWE
	UaeCpkH0lQ1u7kCXnmAjLhteTpIlKBoi1ehlTSWE=
Received: by mx.zohomail.com with SMTPS id 1730192236971732.3164999476212;
	Tue, 29 Oct 2024 01:57:16 -0700 (PDT)
Message-ID: <4086facb-67a7-4a9b-826e-aaedd99110c2@collabora.com>
Date: Tue, 29 Oct 2024 13:57:05 +0500
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
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241028062312.001273460@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/28/24 11:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.6 release.
> There are 261 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
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

    Builds: 24 passed, 0 failed

    Boot tests: 48 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash: e9c8d9f95b232eef9e9293ddda9af144dc511270
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=e9c8d9f95b232eef9e9293ddda9af144dc511270&var-patchset_hash=&var-origin=maestro&var-build_architecture=All&var-build_config_name=All&var-test_path=boot

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


