Return-Path: <stable+bounces-91937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4259C1FFA
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652351C21AB7
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 15:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6617BBF;
	Fri,  8 Nov 2024 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="gWByTu8U"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4EB1F4709;
	Fri,  8 Nov 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078254; cv=pass; b=Rao9OgQ1znTXP/T3UvcAVEx7u5mqg35BC8BBGM/Qr2UUxjdFtEChl6l/dpxqHLnLB0JvnHACaoPWMpdHZDtUaf6y1OVbpz/u/PW1fakKjtcnPpdgmGCjdSPcfZv6oHaWQw5ZFP7NG14r8bOwoYY/Qjt+fUg/QTkna3R3bSnOf/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078254; c=relaxed/simple;
	bh=1g6N36uT5P+qB4xj3TYD3S8zBCLFOkmq3yRj6IjCo90=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SpBiKAu5TQilJRjBKKoLyF0J0ImgicN6mzuObVL40ELD+bV1pWVBD7VIER+/eE8ZHOzyqdKIaPUBEav1wd46+fQXutQZR4KIp0eNgX+mjQmM1izOiLWI1Vd4hP4M2RyypjGTtK/HbmuECBf9z1w987CIPUHYo+BO4btqcDLsc4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=gWByTu8U; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1731078193; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aXvakjtZoCQtph0VZvtc7/+HCfM32kXOtJ9ic5+X4InUDB1pDPZOHck8uvD64/5RD11+PaKMdIZCLmaSavuh6ksDYqqev/hKFMo7TKYN0IfmtYoKqK70FCEshonLTVR5np3D2jCrV3QUeYoaN2yRpxifFZWRDaguU/7Lm+/HcEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731078193; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TocoG7kQBUv5QZO65D3IUtijhaNrryOZXHrTcPe3Nfo=; 
	b=VUJvvSHPNue2XY+ConKCDlR5nD1JoMcs9+8ISejaVddVGWoF2tM0x29T/xpI0RX1RM6rVtOlKpmsQ6oU9B716xsJt2d5Jnf3KrJr5+sxx8PBANL9msA3yx5BQlBtoAh3jw2jMwzi2Pzr1nC23pSn65Ra5j66Ip3lj/rSt4d7rkw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731078193;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TocoG7kQBUv5QZO65D3IUtijhaNrryOZXHrTcPe3Nfo=;
	b=gWByTu8UgmxeYjvTuevgm8PAq7VO2xahB9qXIlidsiqt1IAtr6/HDb9mlZqmVcPk
	6d3Q1oMShqbtY0iGHAsCC2ByI5gjH2r0lQtv2XZSMTD6d6/DhWrEEsc/FVNOm4Pn9Gi
	FE2QdNIPHdr3mEoojsGMp8xCdpROjpQmqy/bwAek=
Received: by mx.zohomail.com with SMTPS id 1731078192287354.59145001827324;
	Fri, 8 Nov 2024 07:03:12 -0800 (PST)
Message-ID: <e6545f17-8c16-4ae5-a284-3cfada68bb6a@collabora.com>
Date: Fri, 8 Nov 2024 20:02:59 +0500
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
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com,
 broonie@kernel.org
Subject: Re: [PATCH 6.11 000/249] 6.11.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
References: <20241107064547.006019150@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20241107064547.006019150@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 11/7/24 11:47 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 249 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 09 Nov 2024 06:45:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc2.gz
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

    Builds: 25 passed, 0 failed

    Boot tests: 54 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: 
        hash:   504b1103618a4532bbbf6558d80cdf3545a2c591
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y

BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
    https://kcidb.kernelci.org/d/revision/revision?orgId=1&var-datasource=edquppk2ghfcwc&var-git_commit_hash=504b1103618a4532bbbf6558d80cdf3545a2c591&var-patchset_hash=&var-origin=maestro&var-build_architecture=$__all&var-build_config_name=$__all&var-test_path=boot&from=now-100y&to=now&timezone=browser

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

