Return-Path: <stable+bounces-109138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37467A1259B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9194E1885109
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 14:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411E243ACB;
	Wed, 15 Jan 2025 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="fBXzKPM1"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7FF24A7E4
	for <stable@vger.kernel.org>; Wed, 15 Jan 2025 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950160; cv=none; b=Xk3lPo3gEBG6EVPsmr781Wis0onl4Dcly0xlzDcF+WWuvBUQN3sBZO52xXRoRZ7YzQdJ912LGgXFPRUcVhMEwr1G+2iNyP4tcc6UjT12FYmFmAQcpviwRlY/0fUAHrRCmxi450sF4CD6vC4ULp7IOwVq/BeW1I5lVmzK0JOUxro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950160; c=relaxed/simple;
	bh=SWrXX8wvsvnkrpoiZF1+PO9FbX4TQ4pkPz7b2QZ9EH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lU9tiEEv9ujGJLavCy714L/rugnLUSfZPPzFD/k0h2LOSpho3MsyDcRkdDNpwG/HU6c5R/asvwe/dibDuGuQTvX7hlR8NmsGJ9dQ02cC221MMZoNb59EORwVyAZnJBZvbZsyEClLOfoEYcBF0pJcSJ6hD2+R+Dut7/VxcKBrUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=fBXzKPM1; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id Y3ngtxUePxoE1Y450timI0; Wed, 15 Jan 2025 14:09:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Y44zt9BCo5bbpY450tZovT; Wed, 15 Jan 2025 14:09:10 +0000
X-Authority-Analysis: v=2.4 cv=JYa6r1KV c=1 sm=1 tr=0 ts=6787c186
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=p0WdMEafAAAA:8
 a=OOLGUsdZh3r8lMXUeu4A:9 a=QEXdDO2ut3YA:10 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wkgCP3QEFhUPgm8Gzul5deoTHMOBwSGN96oz/T7JrHU=; b=fBXzKPM11jLm2UXSnTtUWj3Jmi
	Q0bMj57sNrGCzmpYxSo1tXEYGgnMjY9hKReTXKoIC8/HPHxsXIJiJu8FrOHsw27HLO/HaFnL/s+Or
	VUu/8MUPZZo4q5yIbOuoecBWcqhCA8VQYKPS6Wd1h5Savmj+F1NaThZyFldL1iVz581gRHdIMFhth
	AMGVFSKObGiF/EBExBlvSjZSnnbDg6dg49RRIkCoC9NaBpMP+Tb1HqYSEOKsZpWMLbnjO7qy/xxzu
	STckjtrHGqnRWoz1oh7VxRCyelRamv5Epq4TAyiDA84nRZmWSTctD2GGgl7v3HHPDt8swZlkmkGgS
	b7nrn+fQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:54026 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tY44y-0010nZ-21;
	Wed, 15 Jan 2025 07:09:08 -0700
Message-ID: <eb167e35-ab0d-4037-aa44-3fa74a450e69@w6rz.net>
Date: Wed, 15 Jan 2025 06:09:06 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/92] 6.1.125-rc1 review
To: Pavel Machek <pavel@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250115103547.522503305@linuxfoundation.org>
 <Z4evJUkzHauW+zOU@duo.ucw.cz>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <Z4evJUkzHauW+zOU@duo.ucw.cz>
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
X-Exim-ID: 1tY44y-0010nZ-21
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:54026
X-Source-Auth: re@w6rz.net
X-Email-Count: 17
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM2MNzwchcsyhG/4xycE9GbERjsGk17xtgsOc8hTAdarckusKM813+e7jGrgm1GRYfrqElZNIqiuwpeg5Ht/m7l4rrso0J2M0YucvQRhTUSRopGzX0ao
 6qQLV+FnCPiZc6Gueh53SSg2WHyTowzW9/1teMvM2SFDyHRPucTMpNfxlQOxngGbwJSV6gBrVekmbA==

On 1/15/25 04:50, Pavel Machek wrote:
> Hi!
>
>> This is the start of the stable review cycle for the 6.1.125 release.
>> There are 92 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
> Still building, but we already have failures on risc-v.
>
> drivers/usb/core/port.c: In function 'usb_port_shutdown':
> 2912
> drivers/usb/core/port.c:417:26: error: 'struct usb_device' has no member named 'port_is_suspended'
> 2913
>    417 |         if (udev && !udev->port_is_suspended) {
> 2914
>        |                          ^~
> 2915
> make[4]: *** [scripts/Makefile.build:250: drivers/usb/core/port.o] Error 1
> 2916
> make[4]: *** Waiting for unfinished jobs....
> 2917
>    CC      drivers/gpu/drm/radeon/radeon_test.o
>
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1626266073
>
> Best regards,
> 								Pavel

I'm seeing the build failure here also. Looks like it's due to not 
having CONFIG_PM set in the config. The member "port_is_suspended" is 
inside of an #ifdef CONFIG_PM in include/linux/usb.h. The #ifdef 
CONFIG_PM has been removed at some point.


