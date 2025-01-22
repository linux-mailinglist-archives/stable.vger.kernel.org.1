Return-Path: <stable+bounces-110165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE34A19244
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 14:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8FC3AAE80
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6EC21323C;
	Wed, 22 Jan 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Xtiid8aK"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0101212B30
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552063; cv=none; b=ANAKSP/LtBjSLoJcxQfRY34O4vYHXnignFK7x+WVzHDWa8FmEnUCXtesdaKe3EFJAe560BG8W2Hb130QWnnK4Rrbb+yO8qs3o/DiKYFFprHUsCvVFTJpR93jZoIsqLanXMNYQHI5f0VK7odekwREfb8vXdxHTR3q7TLOS8Nvxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552063; c=relaxed/simple;
	bh=TjlJAB4wY+0AGDIhAo5uuFZnp2hsjh4Fhz/GogWCaTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFM0YoVNxYz6phK238L/FbC0AgRdxpaLUHHhLlWgbZCiN/1s6T8MGWGrnMgmPBBhhvpUH4jzDOUzwz+IATVFL50/35hNWvhdq6k8jduLjmAeRj5RPLkvZfiK/9vYtYxz2HQgeC1gihm8z+9CSbedxVdB4AQ9xVUY6UuxIwvQ+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Xtiid8aK; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id aLLxtn7aZzZPaaafCt7S6U; Wed, 22 Jan 2025 13:20:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id aafBt7n2lH8AkaafCtjwB5; Wed, 22 Jan 2025 13:20:58 +0000
X-Authority-Analysis: v=2.4 cv=YZS75RRf c=1 sm=1 tr=0 ts=6790f0ba
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=-Qcm0AZxhyoZnww38z8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j2zsya5L0S6eRk9iAMF6kTfvmywm0qNtG2RPlpAsIfM=; b=Xtiid8aKRnMEG2C72zWzf8nlno
	UkOu3V3iThucgpsYHs77kCYLwGzgy8BZ8hS/Gir4vojARw7BTCHViaSlksCKPxBryzDzMX2LgRtdm
	SPRqR0KeZw9xLZIPgM4Kn1M3X0ysMrwh2X/85egz5nLt91f4pPwJrFnG6aDAIiUjKBDxxj7E8Hbgb
	dkaVGObf6+DRx7Z/bpCNlG1nZ+xBq5uzgB/CgWtBTp3iKcEfen7RY/YPSIyhcYhc7TPVVK3xzXbrR
	WLsocmzmkBEGEL9a0Y6aDJei3YjeS4XEcMh9fASw9hW40O7fnh04bXBy+jJrVcUDveR6aKLtPnNYT
	g+iFJWgg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33540 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1taafA-001IoG-2T;
	Wed, 22 Jan 2025 06:20:56 -0700
Message-ID: <010553d5-4504-40d9-a358-8404f57ebe9a@w6rz.net>
Date: Wed, 22 Jan 2025 05:20:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/127] 5.15.177-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122073830.779239943@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250122073830.779239943@linuxfoundation.org>
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
X-Exim-ID: 1taafA-001IoG-2T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:33540
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBF/XU9+172S0MO/dt9eYd87Q5SxLHdOL9a5wEuiHAR+CiIJW5M/9qyYRt56Fm1xg0ud/y9A0F6y3kP3frUjZTs7ygpkE8VE6c6i3vZApP01SR5tl+aj
 tGcloitlEinWRP80yFzyuc5wbuRfc+iQNMAKTf1Qk6Yrsh6eSodR4OeY5pk7qbEo3s9SionooHS0cw==

On 1/22/25 00:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.177 release.
> There are 127 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2025 07:38:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.177-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The build fails with:

drivers/usb/core/port.c: In function 'usb_port_shutdown':
drivers/usb/core/port.c:299:26: error: 'struct usb_device' has no member 
named 'port_is_suspended'
   299 |         if (udev && !udev->port_is_suspended) {
       |                          ^~
make[3]: *** [scripts/Makefile.build:289: drivers/usb/core/port.o] Error 1
make[2]: *** [scripts/Makefile.build:552: drivers/usb/core] Error 2
make[1]: *** [scripts/Makefile.build:552: drivers/usb] Error 2

Same issue as with 6.1.125-rc1 last week. Needs the fixup patch in 6.1.126.


