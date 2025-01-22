Return-Path: <stable+bounces-110102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D6A18B4E
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 06:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A953A1D52
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 05:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2CA1547E4;
	Wed, 22 Jan 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Q5ukFDhU"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3D653
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737523940; cv=none; b=lJQjruHz7oc23StMKBBzkzb80kIDFB1lEDfEA69mNyLj7+aDlBStMEqmMzxGwAXHHueXF05OYrzarwAfB2nJLJ6NRlQkJeThORxTGHWC8NkPXHY1jAGZIAMS0pyrDCfYf3MERHh8UwrmFOCLcPw2Jz83rhcnBD4qt5BoX3KdC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737523940; c=relaxed/simple;
	bh=TBGIerr9So+B+FpwEYdO2GNEcpZGfOj6u5Tu+F54hCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVJpzH1fuTXXZhjvuBwxQTrAdH0CiAGrOx6c035UzpYXfz0kfkJ8espxtrC5KSWkT+8OERu4MONKOowlpxR1bxiS26ow1m8TtKt8hkTAoWmgOJVsAmoc246SCUOBZuAQ5F9t9ylw6qo/8cVIcXo+8XIHplSGuqR/o74kpx9LEpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Q5ukFDhU; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id aI4UttH3yiuzSaTLXtXxzg; Wed, 22 Jan 2025 05:32:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id aTLWtStcllqdtaTLWt7tj8; Wed, 22 Jan 2025 05:32:10 +0000
X-Authority-Analysis: v=2.4 cv=JIzwsNKb c=1 sm=1 tr=0 ts=679082da
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10
 a=MxsrI0xeJYWERC35mTAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hiNkqIA+PSBuWzpSlengkjlEK020pb1szEliO93dE1M=; b=Q5ukFDhUgNaBPU7hq1XBwzOkvA
	dhIpdF/AzdVYGlpbxL78ja6VbNwi5TyASA4wvNnnXIe9mmVAYq1hkYz+vD+zyodvdNpTAnME/FfYs
	K7SJ95SJ6sD50GIJXmrHY1BWuJDQSMbQCSICGtPt1w1kqtqE4XjOhyhtfcKKe0Uh+48aF6k5GR02A
	Sf3vs1xb6M0I3vHJsJ2UbVag0i29bgzeF2ccR9KMd/y1fPgLsQKMe2yiEq9VDflc0E5DeiC0qTCi2
	pWFtIbhjlgP7eVP4odnpoep5gHYghh062riou7rM7H0zXb/IbJ8j9d96yYe6SSlXBAgtz/GTTVM6T
	svyV1JtQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:58508 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1taTLV-002ouN-0u;
	Tue, 21 Jan 2025 22:32:09 -0700
Message-ID: <fc55aea2-4493-499c-8ff9-93c7a3486da4@w6rz.net>
Date: Tue, 21 Jan 2025 21:32:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc1 review
To: Peter Schneider <pschneider1968@googlemail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250121174521.568417761@linuxfoundation.org>
 <b5f7b88a-0f6a-4815-8344-bf6bf941bc91@googlemail.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <b5f7b88a-0f6a-4815-8344-bf6bf941bc91@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1taTLV-002ouN-0u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:58508
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB+e0LfstoCFVIksyqZlwAKL6x4U136Raar9uuzEp9Y4vRrjQDcsuuatLyEcAlLMXbPTlGPgGCm4FdfAJc+bwSbTe/ydtoR0S7HI5jTq7/A4twzGHnWH
 M7r8jJCX6d61D4jZRhKHfyXYHI8BGyA78bS4MVNMRFYtOjUNmD0kQ0hSKOaUM7VXWmft2TREnZoUYg==

On 1/21/25 11:32, Peter Schneider wrote:
> Am 21.01.2025 um 18:51 schrieb Greg Kroah-Hartman:
>> This is the start of the stable review cycle for the 6.1.127 release.
>> There are 64 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>
>
> On my 2-socket Ivy Bridge Xeon E5-2697 v2 server, I get a build error:
>
>   CC [M] drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn303.o
>   CC [M] drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn31.o
>   CC [M] drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn314.o
>   CC [M] drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn315.o
>   CC [M] drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn316.o
>   CC [M] drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn32.o
>   LD [M]  drivers/gpu/drm/amd/amdgpu/amdgpu.o
>   AR      drivers/gpu/built-in.a
>   AR      drivers/built-in.a
>   AR      built-in.a
>   AR      vmlinux.a
>   LD      vmlinux.o
>   OBJCOPY modules.builtin.modinfo
>   GEN     modules.builtin
>   GEN     .vmlinux.objs
>   MODPOST Module.symvers
> ERROR: modpost: module inv-icm42600-spi uses symbol 
> inv_icm42600_spi_regmap_config from namespace IIO_ICM42600, but does 
> not import it.
> make[1]: *** [scripts/Makefile.modpost:127: Module.symvers] Fehler 1
> make: *** [Makefile:1961: modpost] Fehler 2
> root@linus:/usr/src/linux-stable-rc#
>
> I have attached my .config file.
>
>
> Beste Grüße,
> Peter Schneider
>
Seeing this on RISC-V also. Commit 
9737085ba4040357da943b5eb975ce8444283b62 "iio: imu: inv_icm42600: fix 
spi burst write not supported" is the culprit.

The line:

EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);

should probably be:

EXPORT_SYMBOL_GPL(inv_icm42600_spi_regmap_config);


