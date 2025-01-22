Return-Path: <stable+bounces-110150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8705A190A5
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 12:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F5B23A2AB7
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631532116FF;
	Wed, 22 Jan 2025 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wCyA5EYg"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE42101AD
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737545386; cv=none; b=qvaGAL/uAokp2A0qdcFZ/kjScObkLGxJrjeUqgQnI/KbCLoiSbaNttaqHaZH5KQg14iQTYB6galcDpU8mPtTgWwNdnBhU1Bicke+CqaExLcPkZa6eH14Q8yN/LQhtz7nt7w/GoDBL/3ByQrebeKepwlv82uVduu+lupZgp7YXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737545386; c=relaxed/simple;
	bh=bPKbKvF+c0/9ffoq2We4FHJekIbeOf8rHFTCcowBsgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJ32vvTuMvfahK04oo2FzJcFtC1NGMN+NzMw7E5ujwW0ML8Hyt4yfA5cf+6TcoLVXjllL7hjCW266A/hMXHkhKB5c3NHmXpgMkj18+pN6K1Bnt3HP1a2s7ZfxGIq2XPNkC413tgluFiRLcVZB3Q8gLfkxGvRpe0bqyIMBSVSMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wCyA5EYg; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id aXIPtFZWtWuHKaYvXtmNQq; Wed, 22 Jan 2025 11:29:43 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id aYvWt9dEZPWBNaYvWtr7ep; Wed, 22 Jan 2025 11:29:42 +0000
X-Authority-Analysis: v=2.4 cv=A/+nPLWG c=1 sm=1 tr=0 ts=6790d6a6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=N6S5BkFEZOQ7AHEsthEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q8oQjlQ/g5zvR8k8Cp5eb5VXKejq1jXgCKe68fvmcRc=; b=wCyA5EYgXqur+SU4E/7jQwej8Q
	qi9VXXIijIVpNip9Ct+kauq1npWq1yy4Y0TJyDtrPMDmdUz5ciNOIz9zxm3k7IHDVOy8pUGI2OKOE
	MJ1N23yGE5OrOqN9NsJXCFvCiu2pj9TcgCcN/0OBWL0S5txjk8TGhLDOeZfQQ34RAGRTFyFvELp9E
	u8XSsEVzVy49sabkj4bZGp9NjY/SslbTv2DOnLDAqqAQg8iSYxuWOn8frqpXlICX7YT/CHwfFjtfe
	Zy/d2mERquUQrGjWVxp/Y1/JK9EIviuJLVT7TwL2RIfVDiwOhgMbYQl0twwN/r6xhDo/7AxRbldoM
	0pxMWJnw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:56230 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1taYvV-000blX-1N;
	Wed, 22 Jan 2025 04:29:41 -0700
Message-ID: <37856bee-2886-4292-ab14-cd152a0fa569@w6rz.net>
Date: Wed, 22 Jan 2025 03:29:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/121] 6.12.11-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250122093007.141759421@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250122093007.141759421@linuxfoundation.org>
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
X-Exim-ID: 1taYvV-000blX-1N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:56230
X-Source-Auth: re@w6rz.net
X-Email-Count: 43
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfG++PW7kY7/2I+75YPkAZQYIl3cN9vjimh4XQXrB209uyqIAvgw6NJyOIVVopQnAVS5SVj9jJ+wbzj210TrMTw+xMkUkdT4Bz86XS+4UF7DTLf481Vaj
 LfyS/sfHdSUZxMLd3AZjAwv1/Xkcvj4IuoZaWDBe3nPJPryBuMMoXMd2e+aRiU//dseHXPfY5GKfLQ==

On 1/22/25 01:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Jan 2025 09:29:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.11-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


