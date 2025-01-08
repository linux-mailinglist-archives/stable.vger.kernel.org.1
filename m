Return-Path: <stable+bounces-107989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B1EA05C25
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 13:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431F718846AF
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 12:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962441F9F4C;
	Wed,  8 Jan 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="Rs76IAct"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E9B1F942F;
	Wed,  8 Jan 2025 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340863; cv=pass; b=Kz4+YSEwkOarOHy8TukCkURzrDbijo7FGjI5zwxc2Y8iiTArpWAxbnxCrfCFwdvQmr2FJAWqLhTgarsnKWX6AaiVPTABpnWywnQDMmCzXxYE8wCAeKBqAumzVYlLcwbqVLoqghGMQFz/2ulSq0vTw+oyekOebNZVfZrU41rXGu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340863; c=relaxed/simple;
	bh=cOBuH+Ar3/Tv0aFxUCrAETJblGMPY4RSTmguzDsLwPw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HDV44SisUJHNUPWqKfj+32kYB66khLDL1mnTGiOCWEK5t1jHb/TzcrAcLHtH3dUOSWgubyXAk7BjdUeEiNji0AVE5qPCOJWu0gEEix9EJH919y9Z/+/iq/PtiGAnoqrWh5BXDBXGeeJgcarmGO6IaaC9XPv1lvzhXjWzX1L6PBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=Rs76IAct; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736340833; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GyKiTR3i9IVImWgohbu/h7RiDH80Ry0XKlQH3YOMGTFcAM6jGPuXE+byNsbvNMnZY/NYipVWxBRFSVTv+9pmJ9i8KTz4diOZqQh3s+NBvQ5ejrbluJHWWRCsxX9hhjmaT/qAjwSkRTCptdOoI1XF7/yS0TI86wlAAo+/xoYk27I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736340833; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=As/1OFEdRlaDnb0q+DbYfiD3CxO3jXivKyFqYgdOjBQ=; 
	b=j962p/EA2Pg9ZkR7jLuoI5fOxe5zDufgnIZTOE66ondDtHnlqN7WBj76at4G39VOaizHnI4HDdHtNOIpf0YaN/fvwZw0WqsEFn+7uo3pQPAQFkARRePMBV6x5INpAuYphTaFl0L//Jt6nhv7UoPFefVKu2SXPVwfdoq8ArZZaoM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736340833;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=As/1OFEdRlaDnb0q+DbYfiD3CxO3jXivKyFqYgdOjBQ=;
	b=Rs76IActLdubnBActQkfV0AAW/9cYoRXsV+ejcclL3sTIWZzF2FulJdm981FIfQT
	wv+uBOnA4JV72psQITPito5cbUv50/8YxTbQaSQgnkAsEg0JVJB+m79kF/qwFiuEqnr
	v85bXscpFiFG15UxOI14vXZPVK1l96ZNHD9pOr/M=
Received: by mx.zohomail.com with SMTPS id 1736340830559114.59343033945629;
	Wed, 8 Jan 2025 04:53:50 -0800 (PST)
Message-ID: <f6073fd2-5254-4de5-8e0b-cc32166f8ffa@collabora.com>
Date: Wed, 8 Jan 2025 17:54:08 +0500
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
Subject: Re: [PATCH 6.1 00/81] 6.1.124-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20250106151129.433047073@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20250106151129.433047073@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/6/25 8:15 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.124 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.124-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
OVERVIEW

        Builds: 39 passed, 0 failed

    Boot tests: 507 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.1.123-82-g88f2306b7d74
        hash: 88f2306b7d7493dc9a6aaa851f2983532fb5666f
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y


BUILDS

    No build failure found


BOOT TESTS

    No boot failure found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-git_commit_hash=88f2306b7d7493dc9a6aaa851f2983532fb5666f&var-patchset_hash=


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


