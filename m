Return-Path: <stable+bounces-111820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D38A23EF4
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772FD169136
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AABD1C760A;
	Fri, 31 Jan 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="kEYt6DPT"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3D1C5D78
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332304; cv=none; b=rL7mbrX6m44+dhTLfsdLsZcvxoe7qT+Ma8c0lNk0ydmhnln9bI4Dr+9iCr0WRpP3CiQ4R1RmvxSBb71U8BRbLDqbJRpgOmMYzehmxhgDp9AnWnRsn1oy57E7Wr7YcswHTxO813eiKYjfkSTGL9WGZZKbtd1TdKfuLoZ9QAigf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332304; c=relaxed/simple;
	bh=h2nJTg4+mFrqi7EKmH+vkp6tINkKplVirc+FceWWcAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9brtlYKtRrWVZk49TwVXndUDZWHYAzAstZsGQV8ulG7jGtt3QzyFzu2cwxpXPf1fWHEhGgrwxlD6Jhp69YbKt9ErerQWuJJHlA07HmNHejAa4jGINZgOllc9o9oF6jrXkb0bdzDaqpt+vyRvrZljyhjMf5OIpcnU4a4zmh4PP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=kEYt6DPT; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id dqEZtigYRiuzSdrdltjVi6; Fri, 31 Jan 2025 14:05:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id drdktQRDb1kimdrdktCrbF; Fri, 31 Jan 2025 14:05:01 +0000
X-Authority-Analysis: v=2.4 cv=B/i/0vtM c=1 sm=1 tr=0 ts=679cd88d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Zh1W6WffNNBMdkN8ln4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MXjjPkOeD3dHk3jj1JswXbDQV12qv9i0c/h4Aa5O2xA=; b=kEYt6DPTNaXf3E0YgEGX8RSkqg
	LX/TisN7iYvGPHmJdEXXRW4M+3k6nMZA6Ygp55POIicyuSJu6lIUq4OUQksbx5H63Bh/wF60cEPS/
	tfBd1EG8uq9R0Io8qTrcamKcCD50AbRJiiXbcmtFvYSn/bmFTvaYhZKImdjj/QztI78hR0IT1gPw/
	tuPl33eBtsa1qN/Rk0yVE5QZ+MCgHnXNnVHLKEo88rktiC/KnCjI6RO3fpsNrqXH9c/8PyRDlJeBo
	9aRXV6b3rzboqkZ8ZhOgIGZOZ3Qcr32nbyc27/3c5e4FD8hYwp9G/y1zZIEq+FshG9n0NYLIuIngq
	SVQD2oIQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:51690 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tdrdj-00195U-1q;
	Fri, 31 Jan 2025 07:04:59 -0700
Message-ID: <7857e37c-5aad-478b-8501-d98c4dfa6d21@w6rz.net>
Date: Fri, 31 Jan 2025 06:04:56 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/24] 5.15.178-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250130140127.295114276@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250130140127.295114276@linuxfoundation.org>
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
X-Exim-ID: 1tdrdj-00195U-1q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:51690
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNt1/4SB0S5XxoqOggdNrox8uN1d4bMRLVn5qVWtMntnTexzvBlY51N9retPkZ77OVhdwNMh8XVojIoaFyeGxmHw/gAZJbF0rtDq5Mg/k9o+FGfRNRos
 6l0pCtQyPDafI9DURaZkfFUf5E39pcOrArZdbANfH6EArz1ttgbC94oNosdq2QgX3cBp5WSIsUfLwg==

On 1/30/25 06:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.178 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Feb 2025 14:01:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.178-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


