Return-Path: <stable+bounces-196597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C652C7CDA9
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 12:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7C4F4E7644
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A62F6939;
	Sat, 22 Nov 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="zFYxSapY"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3E27B34C
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763809303; cv=none; b=gRPjDccgSY5JIxDrHlAe8w129OyCVBFsgj11Jy4gFiDRgDlwaaQ2y2DUgB8qVe+bRSBHBO+l6s45BStAgWPd8odYLE9vLvP+yFXxQ05h44ggQ8Rl5F1HcaSFA4YrtnPACGvxiz7gZP2wjnStvsbS+RrL68FS7TkEewG5MX/gOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763809303; c=relaxed/simple;
	bh=zHZwkiCAzTVWZ+qDpjGuPYbklcxKt74h1F7ZrvRuLy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FinWrmaJFi+ad+LtT/+bU6EbukhbN1UQkaLP74LNaHLbEW9TaoEBZTX8+OoiQ57ljlZnHD2sVE1ItcBZXwsD55vUJ2Hw6Jv2xQAV1PI4Kb059OZbQr+IetFGgZAxWgZztgiixZ05UoDSsZDgigW9CDF4zbCErn7t2VrF7cuby08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=zFYxSapY; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id MkrovA9v6VCBNMlN0v7wav; Sat, 22 Nov 2025 11:01:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MlMzvIqrdh8QWMlMzveccq; Sat, 22 Nov 2025 11:01:33 +0000
X-Authority-Analysis: v=2.4 cv=Mcdsu4/f c=1 sm=1 tr=0 ts=6921980d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=llK4eWEQ3wr25i-VKEUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6KP4whfyUbXrghwXehco2BK29EZzuZWm/nl4pVFh/2c=; b=zFYxSapYxZVb9M3dOkMDf0MMBQ
	bd/74VIPe82SSO3pEclQeOZYkEWUpvwmDs6PmcQgbsn3trxFUuJZjcl5cngAz39A+0eeXeCI5gt6n
	xFrMoFfxGr/t9Uk+bPQH3DYOpJeIHikTYOUEUXb2zE1K2fBwint4WXTCottS+m2YcL9nbT+8rZKiX
	sSeNZA/gmd8ecPlNIWuLX1r3aQ3RxUtLh2Qlltx/GXv2PmMnKhFFF0Pghl0LbZwAZZD0f3MBH/ZD8
	MMbu84DZM9r/5d6lRBUeIpH/2BjEJhTOplwHkHWbWetv4fvkV76WJCLm1ZsouudIIOt4tVo6cwfpu
	xi0quLUg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:33378 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vMlMz-00000001DuY-0AUG;
	Sat, 22 Nov 2025 04:01:33 -0700
Message-ID: <0f0e7f61-5bde-46d3-9ea4-8bc83579c132@w6rz.net>
Date: Sat, 22 Nov 2025 03:01:31 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/244] 6.17.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251121160640.254872094@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251121160640.254872094@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1vMlMz-00000001DuY-0AUG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:33378
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBMKJlAwliUND2mnuOXKDQta8cCB2BR6C+3IaP1C207Te/giEGht4r2lCQBMCkC8+mwhW+f8OPSp2CejZxd8JL9tOt8Hx5BxmRfHvCyNdvAmLltkWUeC
 epAMLva9RVrH9mA2pe+Qi0nJ96Cia9NJfvW87VjlPNIckpeTXTm+jND+qIrriugIbuKUEYQVncRXbg==

On 11/21/25 08:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.9 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Nov 2025 16:05:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


