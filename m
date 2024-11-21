Return-Path: <stable+bounces-94490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22C9D4675
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 05:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 334BE1F226A9
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 04:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69112AAE2;
	Thu, 21 Nov 2024 04:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="4ZicuOTL"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A27130E27
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 04:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732162034; cv=none; b=f3vFdw1F/KWOBxwcfqDPSXKx6liDg/7bae7qT7oGyQwRyn0u3c4j5Hzf1U+FUKyDtxyNms+c5ljzSmV1wF+6NB+0Joz3q6n0ikrWZhXXFMadcQm1XVECJo+ltHBKm0I9oSKH32xLkJZ29b8xWuYHm3AJ933rbHY+DyT29G29t94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732162034; c=relaxed/simple;
	bh=ERffJn60KeZxUuTpwiuizCps0p3OfPLgk9YJ/nzt/MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D82vO3Z0WnnQoDyhSrx5UNieDSz9qnbDWW4KbI3ETaMtAKvmOkiLUcHSLrg1istcwDinh52V2td5IwvXokIxfseq4bqcR3vi+0h5ODCg3XuXz+Wi08qOIeWey+mf766CTB9ibL3JNCL1osZ/ugg4sV4DZJZBZMNugJWI3MHwg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=4ZicuOTL; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id DfTZt5vq3g2lzDyTBtF6Hy; Thu, 21 Nov 2024 04:07:05 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DyTAtysfNXDcgDyTAt1xK2; Thu, 21 Nov 2024 04:07:05 +0000
X-Authority-Analysis: v=2.4 cv=MedquY/f c=1 sm=1 tr=0 ts=673eb1e9
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=u4wymUDdFjS2QedViv0A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=klnTPdvsvSnFhe25dTAPVQHCchV9mup2zE31aItoC8U=; b=4ZicuOTLvY6/p6kq7o8jXLcRer
	cKzyWeITVmJ0jIu9MQuvgFdmDyciAyadD/WZZewCybQO2EMyO2iYDy4StlIffgKlhCoPSJQFtVLRo
	iTyk1YyRs5uEbY95N7bK+saGABLAwk/cIqBnn1kndjCRtfSWFl+vVYVRwDWFLlAp2pCT7Ivyfb8e8
	1KOIft8Rg2kwYK0On1tBad2hvDIcrU1bJWPNBDCKAfptbFo59JtF1ZL23FVDF/5PJoJAkdZHqCgSi
	ibhLdARa3WCzKeZZs0I01LPVCxERagUlPdbOaMHG9t680LH15xdjdCh98iKOjpTxvBRc78jqeqvU/
	9ZXKzI3w==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:36288 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tDyT9-003BsK-25;
	Wed, 20 Nov 2024 21:07:03 -0700
Message-ID: <ff346263-8187-4b11-873b-193aebb51cd5@w6rz.net>
Date: Wed, 20 Nov 2024 20:07:01 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 0/3] 6.12.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241120124100.444648273@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241120124100.444648273@linuxfoundation.org>
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
X-Exim-ID: 1tDyT9-003BsK-25
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:36288
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAtjKS9Pb8rgcH3KunlVAWfsgea9OSp18g4VmTLJCzn3mhgQSkOzsg/ZjMiRqMfDqrGQUYVWFeu/jkH4oO7OfHrpDOeflZmsMXHBAJjFt27zQiRY0FIx
 fjOVzMX4uAAN3krN/Gj2j5SrQCOR0JOXCGKFXocwCtMALBOMl/4wrPEuabDTmf5nMiYGbB9ubLJCSg==

On 11/20/24 04:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.1 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:40:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


