Return-Path: <stable+bounces-176476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E500EB37EA7
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E45E8328
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933E343D86;
	Wed, 27 Aug 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="s//95xHf"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA819343219
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756286489; cv=none; b=VUITmTKOd6oySNevH2ybbZM8h3dn3R8GLNSSDYkNiMDNKeFWdoIil+3HHxMNuZeNCsG2Gzps5+p82IBfMpsC9V0h4GmZImwzxHZk+i8NbvdisdfIKdhj4wGo+8sthqgUOejBOB/dA4NRKyeG/+Dzs4rb55lBRGATSMGxxUCRuw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756286489; c=relaxed/simple;
	bh=8zinUOrBrdyPH0vtqYLCRXPg4x28SnjVLitLEeTBDdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6j9dRctFiYn9F5RO4GC5MBfX9Mjv4isXHyQYyIsvm2d9OsN+wEBMCtrf5ZRaYiY6J9JyM16HEHSDgX/UIzurtSpxEilhhKOJOxMqgmaIzIO1PDu/f2zgkyP5VevwatoF8Mi9ktu/ts5EO5FYKX1VuHqBFyAsEbLPxCN51hLy9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=s//95xHf; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id rC0iuIRy3av9lrCLOukgTh; Wed, 27 Aug 2025 09:21:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rCLOuKdxDWvdBrCLOujtxu; Wed, 27 Aug 2025 09:21:26 +0000
X-Authority-Analysis: v=2.4 cv=cZfSrmDM c=1 sm=1 tr=0 ts=68aece16
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=uh_HjuOCLM2ixMC6b1IA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5SB1wmBLc5smMfA0sMTPBTrAKW/zbSAR8HWXn/kwUbE=; b=s//95xHfiEtsO8lf/BrA4XLQom
	WAfAEcsXNIflPaoIgCPFYBlovhYl87Yah3HUyDhVioGKixnigriJ2MCg+v2pwi04aR4zKSZsS7pK1
	EEeJfODRFna511TAAzBflqg99qgYPblxMWEQdOE3+2Xw+ndDXkYLa23MITFgL/fpibfuRLqQ3JvdQ
	6LHaVOEby3h3AkteyssH8gfcFXsER6AYPBlBFBHU4DkRdEYiOudourzm3i3pHPSxj5iNw8dvjqCZm
	XaRESlHbafkuFNZ4AbYszH1NNK+VXG8+H66UNjFNSAkzoryqGoO4jyemr6bFYdQXiowzYJSzbgyAS
	Tue4RZaw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:38758 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urCLN-00000004Gr0-1IzB;
	Wed, 27 Aug 2025 03:21:25 -0600
Message-ID: <d07c6235-3f13-4318-823c-ce0ea3b0cbe9@w6rz.net>
Date: Wed, 27 Aug 2025 02:21:23 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/482] 6.1.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110930.769259449@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
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
X-Exim-ID: 1urCLN-00000004Gr0-1IzB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:38758
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNuJQ1/RmcMPDR8O8jfJzQcVSLS68mM8czp+Kl0mNYghA763TNI/aqGUQZDUQYtRLh1j7X4Q4sVQP9BQSW9+UQwD8SpuYFj02WMbd3h1DozGSCyEZfI4
 MBNP7R5LZZzgdwTZ0VY4aZUd/H3d5EROnN/5RUPg6D5KYudo589BmVzQDmmiPJgxMOch0wBtMxQINA==

On 8/26/25 04:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.149 release.
> There are 482 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


