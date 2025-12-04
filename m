Return-Path: <stable+bounces-200083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C154DCA5A97
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 23:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BCE23178686
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043332861B;
	Thu,  4 Dec 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="uJNPcxBF"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAAF303C81
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 22:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764888936; cv=none; b=Ng/hRcf3ZeUEH4wIrBnBBY0XQKf6OKu0SJuFmM0N2VeCPc1ivy8Vz70hH1gT3vhnKvRyI5OGCp2mf51QGx5q4TwaZBOg+6sqj19YS3y7L8efOfKBWhqpqwRuXC17RVMLCtyt8dZldSoQo31cQ/cT8lj8d4DZog0Mv2Eh8TeDUWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764888936; c=relaxed/simple;
	bh=plQQVY+CU3JnJUBVg1DX0qL8eqRn+H2UK7YrAQOcpLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BMH1/GIgBwxeWw4iBs9/dEQ5V3XSjD2PmuAYMMceaaH9mpxnYYNhgiS72U5z6gN1z3BYE5jEFhd3QRi5Ip2x5a5e89byEfY7LNrv1x/gskb+8yf/ml6K6hr4G3UQtKKcmdObJ6A3pIf7wOKnrB0FqRcCzXrd/5HnUtF5zKNgiGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=uJNPcxBF; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id RFiyvAnmmKXDJRIEMvrooW; Thu, 04 Dec 2025 22:55:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id RIEMvh0a3jAxuRIEMvXojC; Thu, 04 Dec 2025 22:55:22 +0000
X-Authority-Analysis: v=2.4 cv=EoDSrTcA c=1 sm=1 tr=0 ts=6932115a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ehwNO0zokx9VrzKGBBwA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r2KyoncmFKG6UtIH1bR2pNoDEdqYgV9vjgqB0LVKO0w=; b=uJNPcxBFGfyJ2WZOYX6rKyU1tm
	oyWRUp93kcyhzD9qwIYtskIu6w3+Ok+En8ORYRhTfbPrzfFKja+1XN0PRXzOELhwEjycfh3DziqSL
	A36bERJV96NFbyETuJYc9i1+uAtPSQrmInI/uNGINqyZ6/SdBCLwtBDRVrfT2iLY49LW7TzoN137f
	ig4jqr7gRXYilKiFKwqgy23hcGchJvSISDDUZYjeHG7sayYwByGOpQopLN5dNkq8jgihzWOpyS5wA
	1kinanRT1WSLUPZXsbDwcl5mVF5l358dhleH3Un6PTrxoI4UMOiL1VjuW0UvPcMGUIpaPZuEnilcp
	gmHgl13w==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:57414 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vRIEL-00000002HcJ-3nhr;
	Thu, 04 Dec 2025 15:55:21 -0700
Message-ID: <9d989e8f-edb2-4338-af0b-051a72159ca2@w6rz.net>
Date: Thu, 4 Dec 2025 14:55:20 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/567] 6.1.159-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251204163841.693429967@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251204163841.693429967@linuxfoundation.org>
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
X-Exim-ID: 1vRIEL-00000002HcJ-3nhr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:57414
X-Source-Auth: re@w6rz.net
X-Email-Count: 22
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBTWZ86kP0Hwqy3U+OMfcBGpGXu4k8pyz/Ow88bBl/NxI4le7cRvruf04NSd0+AMnMg/i7YBsEn056xF2rZbjKMWXBGy1OoFXDI3IXpfzqbg3Ftjlj5y
 YFLMuZ83qPyWW+8HWT3lJY2hvLitjuKIqQl6PTR4UFP4Gqfvk1mKjZ9oyQh3cXLcsr1SMqVlYPykWw==

On 12/4/25 08:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.159 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 06 Dec 2025 16:37:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.159-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


