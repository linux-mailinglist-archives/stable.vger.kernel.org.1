Return-Path: <stable+bounces-176473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E75B37E57
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C3C17E5C5
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DCB341658;
	Wed, 27 Aug 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="3oHQmmcJ"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE333A023
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285671; cv=none; b=VVKzOOLFWohq1dHejaSWpyMtgz5FpT9Im7tPZApJVkcjV69oL0Yt1/OHpoGoKII5VUuUdjwGwBACzxCi3mYYXUFGhmZqBEp5bKvEZMJpRe/8yoU1h5S2jhLTPRm7jky0VW0OVUBBfypJ19e5WMH0yUahn9BNK6sLWgzJci9l8aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285671; c=relaxed/simple;
	bh=klb05lpdI4kaKBVrc0TwPb7cdhRmkZQDYnxWizwMpkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=roDV7d6Ydj0C1d0YuXTMXxL/8YUbaaImZnTFjmI7cM3HZ4HH1/oDQ3uUlrv41zn7Jx6LjnMAt6SJg2QAagIpW6HYN2mGvgc+P7kKd8Oe8YfMc/ppe0AE3TGIY16kZzoAWSm6QTENJN99ml7MD1D2vfxPQB9o9qVdXCp4vU1rMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=3oHQmmcJ; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006b.ext.cloudfilter.net ([10.0.29.217])
	by cmsmtp with ESMTPS
	id r1Hbu6NHZBQW9rC6euvQEg; Wed, 27 Aug 2025 09:06:13 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rC6euH57OQb4IrC6euw9Ii; Wed, 27 Aug 2025 09:06:12 +0000
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=68aeca84
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=nDJXrlvuemic_4Ofhm4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HQQeENt7JHfYmG9hkaa7t21nor9vhOWUk1xWH/UFGhI=; b=3oHQmmcJxQMlHJpiYJpD2fQXXX
	a+A4TYT3oibobr6/U5qmOWSNe0g33mtxlK/AOvbRza7BaO4VKzjboD4sfxwu3e1aNXaOvQPFgQpRh
	rr7p2+q93TL5Z8Dmk5BHU9cfZIG6amCtE+KbfauVQp4pX3ZlaunzlU2nip8RCowxXvdrQaU/wQHBT
	xhspZK2etvYkYIfdJ43NbamWrq+wfhtOogVq745f+sXG3NOs2Zoby2x90wOoaD5ZhOmxZZyScoyaN
	uMUrs0EqKB86nAGnJgt1dH64yuJPtaIsImqtzFLwN8G8fIuZVBPE6RLDHHQu98k+8Q+2B8lwpwzTQ
	T46YQjew==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49356 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urC6d-00000004AGp-1oJj;
	Wed, 27 Aug 2025 03:06:11 -0600
Message-ID: <ca193a08-1667-498e-a4c6-c579002b004b@w6rz.net>
Date: Wed, 27 Aug 2025 02:06:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/322] 6.12.44-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110915.169062587@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
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
X-Exim-ID: 1urC6d-00000004AGp-1oJj
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49356
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfECIr9xGU60KGVOBgn5uB1VSc5cOdhP5YGIee4zBqGMsUcvTDJ89QrzLxofhLopNrvkIWwtSQzwVMlEEwIN/yCdnte5FB27J4AWc6aImDiRSqd6nBKil
 ttLfdyknNULKfhW1He3aM1pkjnF+nvac5zmnR7EyHEEqb+cFIhpg/pdd5MqeaOHm6j9cjTBl8YyfQA==

On 8/26/25 04:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.44 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.44-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


