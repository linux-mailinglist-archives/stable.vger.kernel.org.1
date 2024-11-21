Return-Path: <stable+bounces-94494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14579D46C3
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A71F226EE
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0827C1C75F9;
	Thu, 21 Nov 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="tWSBFxr6"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1481C7281
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163215; cv=none; b=TjDr/IN4wPSTD40Qn3Ot7442QxM6b4mDbhjy/P8e4wRO6prPQX2syavKITrPC4VyRGRFCWZNDM7YqQsvYpmtzdHJWfdlzQfhHQqkXQQk1SwoD8b0lRyKRaPlYJpaQbM/PjWQVAU5TxZY5hd/+RQDEyRfnhktKHyF+cYQBE1ytTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163215; c=relaxed/simple;
	bh=d4UguWBFRRI9UGcu5jptyAwek5e7581XU9v4ac97NOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6VQp23Jli9GwJX5peFhTXe/Ud5unzqyvyoglJQdQPDDFw7lJFVYutmtjqoPB39oeJ4V1uJZp9KuVBoUD04VIXb9kGzsUGTsbxjzNbDmGuVXd+tfa9JgOfdehxc0yLdUOm17MJWk+cbQahtIbfCcRkopIQHYMqM1YLnkh1pUGbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=tWSBFxr6; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id DmrhtWyzGnNFGDymKtWNyM; Thu, 21 Nov 2024 04:26:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DymJtGIR065gFDymKtHhTb; Thu, 21 Nov 2024 04:26:52 +0000
X-Authority-Analysis: v=2.4 cv=Z58nH2RA c=1 sm=1 tr=0 ts=673eb68c
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=9KESZ2LI5RPservGmfkA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q66hiYcJWUlbGHkQQ7lQ0dDXohgnvccjHKN3geEmN2Q=; b=tWSBFxr6T9sti1Db9SrPnEfGLe
	oPnKn3AASoqLwm/hdMdh+MBjUQV+QoOx0/tD2GHNEfyrfEJE4higdK6YIsowyZ6qctd6DChQnkzih
	lpRaxoG+Rrcw1OXo8hCXo3l0hy/B/q6wiOMQM816NB6ERJPFfCPqnrEtlhtg2KG9ekleiC91Tj9Hx
	WAY6XzWEX7TKBwlVpDN5G6VnwM4IG1Jlg619d506rUP+x+jP+oyMiP+rvSshyYUnrXZ74viTX+Zom
	7xpWtJtpzCzo4Fl0lD+A1TEZpZ7+pBpzKbUvcZ6p6sjsFcNYg2/YUch8OW6FiEIhAgTqXGr9SUNnM
	pKpjnTsg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:42854 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tDymI-003JML-2h;
	Wed, 20 Nov 2024 21:26:50 -0700
Message-ID: <5ff78c03-bcdc-4a23-acfe-acc08f9f9c88@w6rz.net>
Date: Wed, 20 Nov 2024 20:26:48 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120125809.623237564@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
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
X-Exim-ID: 1tDymI-003JML-2h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:42854
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfASM9RShQnNH/wqMkCFfzfsXtiAGn3u18ttQiHnSgif/osyOikRFuviiuj472yY9ELj4dVU4uEMR0QS5IISRhj1h+z8dkLyMxFBDhkFSN22A2YAbcR8c
 eD83rCSD02BcexwmGx3FTK01Vx0Jg0QfrYyLW32lAv/a5sjLSNpcZUtDhRCxd4Qp4O+UZWvoPYpRWg==

On 11/20/24 04:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


