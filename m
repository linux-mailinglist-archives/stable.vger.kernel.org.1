Return-Path: <stable+bounces-45220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E28B8C6C43
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 20:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1AC0B22972
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCB158DD8;
	Wed, 15 May 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="jKXV7Okp"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26455336D
	for <stable@vger.kernel.org>; Wed, 15 May 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798334; cv=none; b=iTLvzljQxPowJX+m+OKpHzUaeAY+rE1OsPMPABtGD3AhP8QkhJ5WehddRnme9RWziPKKJB/MUG/Zvj1CCgXvT+Ucn9s5Yi8Tl0gi/h0abGJGdAZeI1Kp3mrcTZoof9Vk8gJDzm8QZOMErbqKgm6A+yyrRnU2qzImb+dcrVld+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798334; c=relaxed/simple;
	bh=kgXmoeA5QJFBdmBZ5Tt79+j9GliEDkUNMU8MR5QdIxc=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=Wif+YAg1q7Mfci0Jzu4NiDRHIJO5J+auQ72xiBqYDFW9+6SxgA9h1hD4anm2H5G2tIzjMy85wJG82RkrMm4ifOkJHlpnwSfRthi2SsXIWekrmBRVrm9imlL6+sguqLg+l3jkQxqawJ+GM7tgNryjNkSZN1jHMpj9C3G/g2ZTZLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=jKXV7Okp; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id 6uFZs1OGgjfBA7JWWsG80e; Wed, 15 May 2024 18:38:44 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 7JWVsO7H1YakK7JWWsvmgB; Wed, 15 May 2024 18:38:44 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=66450134
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=TpHVaj0NuXgA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3YATSvnBnidChYswAfJbWcwqylIg5Ov/7fdJysWj1IU=; b=jKXV7Okp7cx3WtV/BxyiKlA7ib
	OeEBb2zf4qwDtvASveVYO4sU+3s94nIh6KwscYmZMVqzEdyD5DXZFY/R6/TYuAtLXkxcV87tE5d2B
	JoUsbNbAanuUTi4jzLUoyYjwqQBNjwAuDqzHcsKcah69khUxQXakvBSwLJdi7PhVWyDc62KD0ZoE0
	lDTfenph288QbEecKHrgANBg0mEUOPok/PatKQ/GYLfnUIsJyGvNQqu3uBjf8QVmHS0v5CLq1dRg/
	MXHCXwWDA0KY4sc16ew+dxS25GIAIWLp0Xp91k2F9G5/8rvoTeCA9i4GwzWCIWS/qSJ4xto2ult85
	uep5W9OQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:35768 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1s7JWS-002IJ7-1u;
	Wed, 15 May 2024 12:38:40 -0600
Subject: Re: [PATCH 6.9 0/5] 6.9.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240515082345.213796290@linuxfoundation.org>
In-Reply-To: <20240515082345.213796290@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <7203f680-4f23-2cbc-9e07-3b49d63a24fd@w6rz.net>
Date: Wed, 15 May 2024 11:38:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1s7JWS-002IJ7-1u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:35768
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJBSwppQtk0iYcvzG186rTQjcpCSDwtGM4bfmGkMQQ31s9MFdrdg5Z5e8rDkOCcxQA7WVMvIKrPFBPKS9rhM8emDfybpw2zOo5H6U4Kzb3atRMUExwnG
 LYwyYjcNhKLMbxl7CTT99gyg+Qz4VyjE9UKvULX+960P6a5Q1Nb9Xr7bwCsMxAjhFMVthPdSXKKt+A==

On 5/15/24 1:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.1 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 May 2024 08:23:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


