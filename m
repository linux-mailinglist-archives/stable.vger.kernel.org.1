Return-Path: <stable+bounces-54723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E56910830
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 16:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D0BB25BBB
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB31AD9EB;
	Thu, 20 Jun 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="MOWS+snf"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26441AD9E6
	for <stable@vger.kernel.org>; Thu, 20 Jun 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893596; cv=none; b=STwC3n1PKaSLN/6NVgWK3k2B12+MAvkU24akgYIU6pm6IgofYo5AgFZ4dFJILqGH2+6ZPxRe423z7KXNnFKM50E7aplyiI5hi9vOsuRjVR4ZGVPQNXv6aDCYGPge4i0a5XPWbL1GMLZ65HMwFg3UNfFjbx9iq3dMUV8p3fde1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893596; c=relaxed/simple;
	bh=OtWs8cW/5ov0RRwfm21rf58AsHqQtNVE1O5G1Hjb5SM=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=c72cx43P3UfexelKrVdZsw2j/xk79KWM0TSF5PK4MWkjH44Cfbrp4pmUkgp1eiIg/6fwtYvUgpkDalT51uM/lV0EmRI1cLqJ8I0vI8oa9zMw6KZVYFRz1h5fEwH6uHwfcrjIdvceGVPMLsPvYe93+z+7HrHGDX2KL8tHIbEV6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=MOWS+snf; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id K0XNs1sLLSLKxKIkEsVHY5; Thu, 20 Jun 2024 14:26:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id KIkDsZsDDCaXoKIkDsmHhL; Thu, 20 Jun 2024 14:26:33 +0000
X-Authority-Analysis: v=2.4 cv=deBL3mXe c=1 sm=1 tr=0 ts=66743c19
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lvk90vOh/9SOXSj80jTDyWfb41nLZq4JTiFFLtCM7MY=; b=MOWS+snf180hF3Jjm+v9SX8ms9
	47BN90+q9M2I1rIFT23hkkjS7Y/uThipsfzXaE11Y0la4pn2p16hBiWhwis23Xxiz7GZA2h2fJVWC
	UDWTvceYVh3OUy+nhBamM4q2jyTwd1GKeaW8Qy/ZK96SPxIQ9gnuEO1h8Hl8El+WBOvk/ryo2tYJ2
	JVwgQnExvvyRAUwBKHWPn4c+uXxr3bCA1ka2/9yhbXO5fLbsdm34JRgtHcCBaqU3K0k9oX9oW5di1
	/lSjjBMtmth6esl6+RazPNZfoXaEDUcfTYxPJxKBkbdX7sUIy0eq2rQLGsTja4P8I32KgzvY9F9Ra
	CRxlcZPw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44944 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sKIkA-001g1T-2Y;
	Thu, 20 Jun 2024 08:26:30 -0600
Subject: Re: [PATCH 6.6 000/267] 6.6.35-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240619125606.345939659@linuxfoundation.org>
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <5412986b-a0f8-27c7-11c1-2471d7beb3c2@w6rz.net>
Date: Thu, 20 Jun 2024 07:26:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1sKIkA-001g1T-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:44944
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMYLPzKEh30c/Rj9j3DvfRLrAkdIxPwzrsZQTAtkbdkNNfgUtBVWsLcFicoimnpq0Mr83KPuvCvCbOOF6NUENLF4Zux4w6KoYXuaMaxbkXYQNHzgA2ir
 bY9FAc62dzfcv3VweXbcwGo8git+fyHmKGl8xHjxb8vVm+ZrWpWt+MckrbG3VcT5TwnhxsMuVXxhkg==

On 6/19/24 5:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.35 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.35-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


