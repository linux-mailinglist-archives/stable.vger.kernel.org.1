Return-Path: <stable+bounces-139224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7FDAA568C
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C109E47F8
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0D21ABB8;
	Wed, 30 Apr 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Ds1/6tig"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D039A1EB19B
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746047758; cv=none; b=kbd83luwQB1e2YgKYO2IUJ2v8sQhPXi1PuvC3Kx5Rw3Qn2nYT6OccHEBEAirdYu0TVD8K0kr8qqaqC/2TeC7fDffMdBax9bL/eJM/XkNLr/hoJOXdMBTT2IU0j2ae9MQt3yAfJDDu/BfJqDKfrCtRJ72KDmQISosIl0UtqwfJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746047758; c=relaxed/simple;
	bh=6r1njB5qW961zeCeyC1Ws8NaIGYrxNdPCrHI/BqR2Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RwwLB2QjOE/blzbgA6H4Wd3vYCXKgiHcA3B6fyS/tof7riNMb6bGUJg869giSjrmQSf85QrI5EwiCtAK4PkrdsdwPo7qrzjjguW0fxYrXEPBr+NPwB9epyZVxgWaYmQ5KLxjenmac35j+E7lT7yix4RXDLSDfjl0A1V/Gs+l8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Ds1/6tig; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id A3qxuqApsXshwAEmZuH1wx; Wed, 30 Apr 2025 21:15:55 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id AEmYuonKK4LOpAEmYuKlss; Wed, 30 Apr 2025 21:15:55 +0000
X-Authority-Analysis: v=2.4 cv=L6MbQfT8 c=1 sm=1 tr=0 ts=6812930b
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
	bh=sac6IcSg3WZKKwFgj909ohZY4/RAuKfKEzfaggAeOhw=; b=Ds1/6tigsTvFXgHGZBrBCcXeTe
	M0OMVtbhzefYtpyax/jwvulyJ81cO28jBt6XlspMY7GpJAR1sZPU9mYcE+NZ7Xby2Vwryj6vRyaBc
	2cBWRGj9/ccTseKH+VbLdeuANJ7ZdB/iyxUQbwrj+dwzdSlDzka+FxJAXd+LHxVJMwVYzgk+EniA6
	usr4bgfVwf7cpaWC326r0NsDTDOGFGJE15KjnwAwgXYiec/JyQyW/ecuFF/Orvl7Vr2WSbCidUyrV
	7jiFGWmop9JWKTfxgnL0j5kroZ+E0fsW6/7RUn05aIZm5ZXvOM9pFQ8bc/pX2Qk32lnHlQpJ8MsOs
	iUrWTXQA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38784 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uAEmW-00000000WGy-26SK;
	Wed, 30 Apr 2025 15:15:52 -0600
Message-ID: <b5ef1369-f2cd-4e15-89f8-eeb20977dce6@w6rz.net>
Date: Wed, 30 Apr 2025 14:15:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/204] 6.6.89-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161059.396852607@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250429161059.396852607@linuxfoundation.org>
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
X-Exim-ID: 1uAEmW-00000000WGy-26SK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:38784
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMxh75Jg8+NbuO3Nu0NqjHKy020YUcLP9p5ZCmXuOHYjURzjAovpCvGxRHTuqTCQWt6Ytd5Phz3doaAV5YtkGIGQE0qAM2IG2T8Juvj6I8KdCMi68xKW
 lx4CeHLO+by8FzYDqZPnE5rtBits6zRLw64FZWm/WJyNP3XNpTs6aX1fDuwtDedVUf/g2HZxH1OsJQ==

On 4/29/25 09:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.89 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.89-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


