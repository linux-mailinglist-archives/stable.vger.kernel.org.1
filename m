Return-Path: <stable+bounces-83312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C17B9998150
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80A41C24EB8
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBE31C1ABB;
	Thu, 10 Oct 2024 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="iNlcqvLC"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E7B7E765;
	Thu, 10 Oct 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550763; cv=pass; b=rvT3kRE3fX5QaYwenHjeHtMExozytwsGhrdZktBMQt+G7KB38Wwif1tQpQTL78lgJS3ECJRptv7at04AkekvPb6OKJz0H2Y4VFopI6Dm39RaNey9oSVuHp3K4BfjOOP4/zX1xJRsexa3dNgl4yk7eBMrLlqFx5wwiI4+TZLH/9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550763; c=relaxed/simple;
	bh=IBKpCzUUAWN9qQwuN5Iyr9QaGakkO2Cujybu6NmrCYE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OBsYZaV/c2bw7wEvGn831RR8EIUXEgVjIgPtH9LNl4W2AaerXtBmzducdDJigc7CdR0MjXvhM3bYyM1FHnhQxiEZPoXjUlRMLoRhtpyO5mUijqszQXt3HWwIoHb2oicbvKSJYR5TLNiNcMNbxw2d9tWp+R8KILRjale5f7tD3Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=iNlcqvLC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1728550724; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=krzBJuY0uZPsewGCw/ReQypzdUjMIQB9GBaVdoNWFIqwazNkQ0WzzSTYR8q+Yxh8Y6ELyu6ecCu1WQXCDObyr20SgKh5dc2BjcrcXaQlqYmjhfpbhoGtN2uThYDWOua+jLFtOs8rG4KJq4huOUageSrTarLylex5jwjn3EzdAYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728550724; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m7dELNL7cHObjTe9qSiqEBrQd7uE9MHb33zBOW6Bchc=; 
	b=RRuKW7xSc5sZjrRNQ55NczaHHFh19NmxNsZNQYBH+2Sr9ZF+DlQuMlNi5QQzPPO0nU8hSgU9GlQ0EJREMUFEaDJadM0fRBXgl3ORyXuYproSKqutOnhi6JCM+beQCbMFqhmD6y3n8IMyxKLM68R3OHj34QCHL1uxTyTsNYB8iEg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728550724;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=m7dELNL7cHObjTe9qSiqEBrQd7uE9MHb33zBOW6Bchc=;
	b=iNlcqvLCHJC/Nn87jPGrHgnN4bmwNzB4QpB6NU2g1Mt3MaQzRCB2f62zMsQR4uva
	38ypGjq1SuNVBfHrBH7dbO7QP7usKp/i6FCdQxe+7G3p5pmrPCQtI9fp27S+iDR8d/O
	4iJlTt+RlNcHk2fcOcd/T6WvFWbCw8RylWK5XiOw=
Received: by mx.zohomail.com with SMTPS id 1728550721984430.80826526646126;
	Thu, 10 Oct 2024 01:58:41 -0700 (PDT)
Message-ID: <05ef1fc5-6947-45f1-bf9b-879681647107@collabora.com>
Date: Thu, 10 Oct 2024 13:58:30 +0500
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
Subject: Re: [PATCH 6.10 000/482] 6.10.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241008115648.280954295@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/8/24 5:01 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.14 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Hi,

Please find the KernelCI report below :-


OVERVIEW

    Builds: 24 passed, 1 failed

    Boot tests: 510 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name:
        hash: d44129966591836e3ff248d0af2358f1b8f7bc28
    Checked out from

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
linux-6.10.y


BUILDS
    - i386 (defconfig+kcidebug+x86-board)
      Build error:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_state.c:219:1: error:
the frame size of 1192 bytes is larger than 1024 bytes
[-Werror=frame-larger-than=]
      config:
https://kciapistagingstorage1.file.core.windows.net/early-access/kbuild-gcc-12-x86-kcidebug-6705246a7ef7358befb78db3/.config?sv=2022-11-02&ss=f&srt=sco&sp=r&se=2024-10-17T19:19:12Z&st=2023-10-17T11:19:12Z&spr=https&sig=sLmFlvZHXRrZsSGubsDUIvTiv%2BtzgDq6vALfkrtWnv8%3D

BOOT TESTS

    No new boot failures found

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


