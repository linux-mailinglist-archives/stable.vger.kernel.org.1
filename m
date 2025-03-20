Return-Path: <stable+bounces-125630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF3A6A3AA
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 11:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF088A2543
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0957224252;
	Thu, 20 Mar 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="EH33pLp4"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278E22424D
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466535; cv=none; b=pBqfeJXKVdo3i37+tLWsXjx25YJ+EbmMdTw+RcoT8fppOJ2g4WQfskH3go+56++KszV4Bi5Drdj++vpQ6rk08+l81WMb3nZZQNgHwS2tonXp5PxCHBpIRHW93n84MZH/gzTFNzTT+YPCaRnh/SYpBnnIZLsXML+gJOKo+6b4xpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466535; c=relaxed/simple;
	bh=khC4F+I13TkYeZQRBsGXVV/+15Z5FgfMSYY+HvGff3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUY0+pBL8AusP+4017YsFJHOMTbt2kYq4uYbgOe67mX9XWbSiX75+dT57lAyVb9MRj9CXzssLvw6Jr6UsaOYEtRC9e1pHR4MwbAoNWo75ebnNGLdQM0PobKyB3nH3fwMvJjs80A9hYtFGExigxwi4lWVqxDehlLTpaCYjP2vwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=EH33pLp4; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id v8mutnHjwiuzSvD8ptzOTM; Thu, 20 Mar 2025 10:28:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vD8otpuneq3CNvD8pto2us; Thu, 20 Mar 2025 10:28:47 +0000
X-Authority-Analysis: v=2.4 cv=VpfoAP2n c=1 sm=1 tr=0 ts=67dbeddf
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=axMDLpPUFtze2iTFic/lgRRWODnye8AgYMuvuh4UIEI=; b=EH33pLp44M4dTjP49mBCCq791v
	ZByVNM5YChupJoGEcTrhwtJvNnx6uh4TgfTRZ+fDnW7OBygZPZJkfafT90MMZ644/TZbGtKHpOopI
	msg88KXLPeCTRxiVmb4zcgkZcfEzLreDWKNnRfL0ddEYs3yaxbYmtIAZc8MlRVGkhKxEQFsTiFRuz
	/voE6ZXJ20xgUqgfoZjsiVPZMLTgim/O9jmSh2MAaQMJJXNISEalwEBA1a3E/j6RP7Zg8goppxmNj
	jkI0BupvqxeXmKPy2B64bKSB3koKi03NM5bfDQhq1UqPZj0wQtxWNhAySVP4iZoWXCmUpBF7//Auf
	jTWFhxSQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:48952 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1tvD8m-00000003O0V-3XXh;
	Thu, 20 Mar 2025 04:28:44 -0600
Message-ID: <2ff822ea-589b-4370-89a8-d9519da6989d@w6rz.net>
Date: Thu, 20 Mar 2025 03:28:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.84-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250319143019.983527953@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1tvD8m-00000003O0V-3XXh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:48952
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMpcMuzQRN9RMOv+b7ofNeYTWCksIqBj8pUnkcI/7NOudXASRsh+ASb6nxQZVINKHL+8gKehF3mVAgdVmYgaHqcniIB8ER/ahHoJ/9+2o1qrIKP4FOvn
 7J8WlY1dxcqBOVLwxYtmifX26O3igdhzxUjXgfg5HGW/SWRR7/9CRP+L28gor1j+V1E2Dz8mui/FZg==

On 3/19/25 07:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.84 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.84-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


