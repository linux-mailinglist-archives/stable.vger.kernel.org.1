Return-Path: <stable+bounces-163124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDA4B07496
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF82B1C26012
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34F42F2C6B;
	Wed, 16 Jul 2025 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="y3UDJezc"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EB92F2C5B
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664964; cv=none; b=T3jhx66VPFNqPMX5VTac0N3IfiWG3XdDDYRbU1h8URGiN6xI9biNp7fx6nVquBgtFYDu1DGukKkd/lsGOVBKiLLoGn3CJA5JBgSOQdrWPLPUtUry2Wzy6V4oGZAE8tUrjdJBYRZzHESghowPMWgRcjDzdsYGX50qpLc9YGItoSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664964; c=relaxed/simple;
	bh=tu8g/lLnRN3gWiBCOOMBuADgmI/tlfwkiz548ypuxbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VK6xBRIrvivbzj8G2ESKPoaO41AQOg8q1XYbgJQcwua4EcNbh2YtEe9xLjPorM4ES3ny42EQlePSfpOLMK0msIyBCorRTza9wipP+gVlahcXXpiCshOLzHAhuIZXz0bG3fFw2vgBna46a7OjddtDq/340bYD/1ZcJI58DrLZNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=y3UDJezc; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
	by cmsmtp with ESMTPS
	id bw75uu8o8f1UXc0DhuAZyU; Wed, 16 Jul 2025 11:22:41 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id c0DhubWMmPEpqc0Dhu2xKJ; Wed, 16 Jul 2025 11:22:41 +0000
X-Authority-Analysis: v=2.4 cv=QddgvNbv c=1 sm=1 tr=0 ts=68778b81
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=ETq25zZTwTwJC2UVe4wA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7S27DjL3daXHOEiAWFot6UHdeAAXgcQrfveAHrwjWwg=; b=y3UDJezcG17LppFGIMeC2h07Av
	bgtWt/6JITjx8J2apDcrFSfLZUY0zw51/zCMH9qy5fJOHxfwHZJDN+f/+HELycklcMkJNr6vLQbrD
	x+kgWDEuheua+kZPTjiAH2mzzs7At0ZJ4Yl3yZNyHYyKwBRns+6YxP0pc/MUOLNzpHyDlAIBwpJ4z
	yxdImB8jZ44sfPwUbIDBMuS3h4bkq9yceMl5Ngq9YrQRbElJPFTKjh4QJvooJ8xlHYLR5u4+rSi55
	8Av50CPYE0mc8vR2j6wxbxGCawBq/MLX93EGC3dxgJcCsF+NMcOGoykApWHSFcsTgVDrh0S63IlHC
	yvPsyWfg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43214 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uc0Dg-00000002duB-19BD;
	Wed, 16 Jul 2025 05:22:40 -0600
Message-ID: <f620794d-15e6-4a0b-b487-420e772a8c8e@w6rz.net>
Date: Wed, 16 Jul 2025 04:22:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/78] 5.15.189-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715163547.992191430@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250715163547.992191430@linuxfoundation.org>
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
X-Exim-ID: 1uc0Dg-00000002duB-19BD
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:43214
X-Source-Auth: re@w6rz.net
X-Email-Count: 60
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKVQ4XQssx+/zHFH1gm/23NVGxJzQOH677XOiWcfDGvcor11OapZZz67v+voXKOjCUNEnTPQC6CzrL5FZV2BJCn/HiLiub79AwYRpeTA1RiZVUrN4pjQ
 1vUK44uyFkwWbKiccjHgyDaSW6sgw4GAJ4N8FeE2F3e26FooSIx2HBK4EjkTGNqITdrThy9TSeAcMA==

On 7/15/25 09:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.189 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.189-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


