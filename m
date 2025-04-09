Return-Path: <stable+bounces-131887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E24CA81D39
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 08:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE753B8991
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 06:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F941DF991;
	Wed,  9 Apr 2025 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="xikLMr6k"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B41DFDB8
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744180818; cv=none; b=Mm380FHJAIqXrbHVw9w0hGzMG0F3hlC4fenK1beKT5TKoRe1d0YcponBcloDDJBynGU3vqCYPP2NR692Cacbr7/JBDUb7BlQEngzdCw1Ps43moUrV3GLr3EiU5LHGB/JMpz3g4azjCwLEv2x4mYnhpu6Rv2UUYjjNCjC8Hzd6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744180818; c=relaxed/simple;
	bh=EA4R1E+05gtL01yoBf9zEwuEj63laa4tf7bpqq0eQhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBMClJScBTsOFEvsAWPusu4uKGX4YpI+Rl77jK9N2zUa+YyuhGaHUdOyFibUfU+gBkuOpD+5tWx4y+F6sZQBVoDHB0DjhtrO3YPAqDskkWGxP9q54vPfk+uV063XxkkfFY4wsOWpymtZx+ooqH7r8CaheVWBIhbRL5mPB/HLvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=xikLMr6k; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id 2AOAuGE8KzZPa2P6Xu8VtV; Wed, 09 Apr 2025 06:40:09 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 2P6XuNojy7b2o2P6Xu5HXz; Wed, 09 Apr 2025 06:40:09 +0000
X-Authority-Analysis: v=2.4 cv=EZXOQumC c=1 sm=1 tr=0 ts=67f61649
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qpm6j0JhOIFKcdxChBMhu3xTAdJvNiLceWDGvFN+pFQ=; b=xikLMr6kwELm3gep0qnGf5GqzI
	JAE6i5oDYASi2Owvm9B0QWLx8TAryzPa99z1unsiJv6/CsF7qmCj4d3ghaGTfgWeNvJ/gjJMMenc/
	9x0Sw3rxvlMcJUBzqvZPrR+WcWFs7ALibc/neD18LxieXlyqHIVKKanPwFzlNmE3UU+ySBbEbqieU
	xD1Bp7gY3PAF4n90SCOpCfsHXow1oXkS7qkiih9/nFh3LDWNqyeqSXOxLEJQ2tFM5gOX4YDKOMNxv
	JVcnhbCfUfcVbWOrWCP6stJpGepCeSW7vnozvPG7W8MS/2Kiyvk6wIADz0jeH3nlNHZj6ikKcT2+B
	5BrrC2Ew==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:58032 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u2P6V-00000000J2N-0zEQ;
	Wed, 09 Apr 2025 00:40:07 -0600
Message-ID: <696e8945-3343-4cf7-b5aa-b39051db3911@w6rz.net>
Date: Tue, 8 Apr 2025 23:40:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/423] 6.12.23-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408154121.378213016@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250408154121.378213016@linuxfoundation.org>
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
X-Exim-ID: 1u2P6V-00000000J2N-0zEQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:58032
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAB2G6kc7yotnVaIu/SIYf6P5mx/bIpG90lCfFFfNb4ASURmJKwcuytPvbhKg/pumMyeCVchJ07id+lSNjvDJieSbeLEMkumDZlC/0JgEQxeTuBmMIWA
 l+c6agLjtszXZKTWRD2YWDcSy2+dn8bxuHF5q+OXlHgy1+a7nJ6BUrJXHQh33CzquhUzcXZ+codEZA==

On 4/8/25 08:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.23 release.
> There are 423 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 15:40:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.23-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


