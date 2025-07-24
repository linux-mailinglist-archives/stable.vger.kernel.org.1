Return-Path: <stable+bounces-164548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC8B0FF2A
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6A81C80719
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081181DF24F;
	Thu, 24 Jul 2025 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="JFKjFrQ5"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6124185B67
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 03:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328088; cv=none; b=UB2aKM5Lkn4R/9VK1ShXzv3tpV0E20hIXFv9SN68wVIy02BYgqLJMQmuwgCTEXWbwlq4F9Cg2e1JgfvCAnTiBOznp3w2H4cYJhAuHkTYLt5nNGimKHGLIgkltRDE+uiQ5/RLUpXGNWJ92PnSXkvFnvt/atz7KF8aNx6AjnGPtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328088; c=relaxed/simple;
	bh=6RGZZzwq1RVcl552iNQdR3Qa3UKwnf49Lhs6Z+EddBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INHNsdMln5DhCrDV+8a65ih4ICYEXnmHa4eJLaFX8rAOGeeZ6kXVnKhaFHnlHJmWXIcZDU9bmgRILp4Vnn7nk2RAEdd0RGGZf/N8+eE+y1NOVEhVWLEk5jL/pF4O2vAXI+Xz9503I3y2OOnQo+g2m8zKZzcbdBhyJqPL3tKIxL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=JFKjFrQ5; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id ekrduYRDeVkcRemj9uQ3Mp; Thu, 24 Jul 2025 03:34:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id emj8uEcYglaDGemj8usfYK; Thu, 24 Jul 2025 03:34:38 +0000
X-Authority-Analysis: v=2.4 cv=MLxmmtZl c=1 sm=1 tr=0 ts=6881a9ce
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ScgFMeR7n2JIvPbK2CgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y5LIDLyJPqcD/dy7AI+rdWrOWNWHHviMXkH8I49vgOA=; b=JFKjFrQ5b+Me+O9IIIoHIXBo3j
	KxYbrSkJglzfidy52guqzu9ZPWWfksstOK8BbBSqhT9ZQPhcfN3riDfsAleC16JAo234FEQQmeOku
	TvyOpbvixy+AmIH4JGqO1FbMqm6rPDHyXGAnH5lGNaHBLhURn/fLMOkUAfqVIUAkSBLIjCWnxZGLn
	v6C5nBL/fjigmykfcJ/thUToyxxKx6SoSyJJlSmEL5KDy6o51ZMipRhnfkX4ivJA+P356/ekPRzMA
	DirDqGUyUgqXy7c8NznbMkCNOLnZALw0798J7EGaVxBfhr98cy0QOl+5HGCdqb3pHtFxZxeuYp8VF
	0tUu8TsQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37616 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uemj6-000000006a5-3kZo;
	Wed, 23 Jul 2025 21:34:36 -0600
Message-ID: <0a54bcf5-e5ca-4841-abbe-89739243837d@w6rz.net>
Date: Wed, 23 Jul 2025 20:34:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134345.761035548@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
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
X-Exim-ID: 1uemj6-000000006a5-3kZo
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:37616
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLmvkzbHsAeL1I7k5VZcnCM7by6mOg/s2gojhky2wYR6AuyRPODyAUPFmUttFjL1+cElkAfPqILDXxBgdJF/suKqp/4g2f9I5Bwv+4D0ccD2M8mTmnku
 /donnKL0O18QANrHDQCBe2bKJAs/fpjVcn6iGdv69Y6Ywo88MG9zo27t9IVp5NU06yekFUIUn8NsbA==

On 7/22/25 06:42, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


