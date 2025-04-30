Return-Path: <stable+bounces-139223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C8AA5686
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62637B4620
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632B827A479;
	Wed, 30 Apr 2025 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Hr0aVMcD"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE721A45C
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047525; cv=none; b=somDDyvzoz5FMbeGGnwntIQD1/Ql6RtW9pyV4RFHw7PcW/edvYCfj/Zyi4AYOjw/UoP4hIUXmK+Bv94BTFAO4gIvRlEosoWlwmhAFBtEshoNx7pxc/GZsZ/+9iWA12h5rq047mk785TG9KGC/LPInbu3aKpZU7xGkL+UOnLDu7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047525; c=relaxed/simple;
	bh=GkOhbOV/RyI9gL/+Or0DCnSmH3Zw+Nf4w3vNSwQTUsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBQCSvrFjDOLQbYptBrGUtdSPnMqy0xGIbnaxVAgepdo/e84Q0er3aExWGKFXUJMrc4ijF+XLmeUotAuvvNEWrJZFSfZTsAIcLqcFL0of4yUmQMnaZOuLhDLzbXPO/4doNvrSc7mq3gJxnEABQVKY2ybma6iMyhhnHSEUxbY2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Hr0aVMcD; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id AB8ZufuleAfjwAEiou6BKL; Wed, 30 Apr 2025 21:12:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id AEinuAKxVRlrsAEinu5JXf; Wed, 30 Apr 2025 21:12:02 +0000
X-Authority-Analysis: v=2.4 cv=Qamtvdbv c=1 sm=1 tr=0 ts=68129222
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=X_drXzbwcQU-ujxrCA4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LSGPeOSJBuiCDhhHIp+GJs/hJyO6g2wPqXqmpaVdDbA=; b=Hr0aVMcDxRLc2LZRxYNCuN3Dgu
	4IAus0o/PoNumoAZSNwayy99OcbFZGmd9N/3KjW8RrIQbivKSSfLINqOTEQbwIYYLYT4iGmV7FP+P
	ZWiyh59qNifs++OIBAsmTFHLju8scfmSXH1mMGC+1YYc3TqPa974eFqCxANRUGW9eRrHEEW/RJyqo
	H8nETTHI3PXmhrqL3OM1JKvP+muxwem0f3nnXE01DgCWW9Ai94bDJYCP4mg3oTeBkI3ufEz0kHIOt
	XGZxvJ2gIN4imA+LiJFA8qGmxBuaA1RobzHGP8OuNOuB8Stb5TV+TrAk+J6JqFD/w+r+G7/dXm/ay
	cD9tqVYQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:33340 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uAEil-00000000UUc-1upO;
	Wed, 30 Apr 2025 15:11:59 -0600
Message-ID: <ca20aa8c-9828-4838-bcb3-28ad0a1b1d2b@w6rz.net>
Date: Wed, 30 Apr 2025 14:11:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/280] 6.12.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161115.008747050@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
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
X-Exim-ID: 1uAEil-00000000UUc-1upO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:33340
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLAhkuESWPGZ8DFdJJnK/GXgHjOtYLmA0HwQfCvJ5xu8poQ7YZZXlc5PHFxk4mcuWG73uhjlT0qZwuPkkioFYsskvN/8CZabk9UORpeqXKa0gTD/6JR9
 r0vyZ0awGRpjZYoMMOMThY8gfVIa/cJhIQpgYRlVZv08nuoixL6L8ZCASqukH3f+PMxY1MBjC2C32Q==

On 4/29/25 09:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.26 release.
> There are 280 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.26-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


