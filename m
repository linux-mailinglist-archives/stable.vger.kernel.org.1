Return-Path: <stable+bounces-163119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C1B07449
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 13:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B55F7B0209
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC322F2C70;
	Wed, 16 Jul 2025 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="Lm3Py5m6"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567028CF40
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 11:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664063; cv=none; b=Gw3+6RUM/I/5tUmg6+2xnkUoMTihoaPnMV1Zic8XeEDhYvhljDiQlzgUc20jaQz95q1QrgynQUfJpA03SDIinPOSkW74HaKYavy1jnCnTJKLD0mue9R2k4BlNqFV5e7JxByZz8cMGW2/uiASADa7RhKaErX8/nWI/FM9FgEWfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664063; c=relaxed/simple;
	bh=mwGp4R1gitGS/X93gxT7UmdwDzUd2/nf1PRus339koA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmzUigyO5W0xX6kN718CRdu4inpQ7ueq0zF4HJUDF5TLmifT6/SsTss4Pm8OsIeqsJax97ZFytt67LcWI+nPEHSDR+JPjKPVgb7CzbTZKtfUeTQX5mrIB91QmWcFQScqA0VkmLF6eqAjA+ZaeM7FlZ0ZO8UA/rHrPCF8AhyO3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=Lm3Py5m6; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id bzuIuZI7pXshwbzz4uaDga; Wed, 16 Jul 2025 11:07:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id bzz3upUYkmygZbzz3ukiPw; Wed, 16 Jul 2025 11:07:33 +0000
X-Authority-Analysis: v=2.4 cv=MNqrm9Zl c=1 sm=1 tr=0 ts=687787f5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Jy6JTofK_kRrUkXSLyIA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZrOxz31SkqpEv52GkWlzMzZ9gXUywrNtFTdgYCDdzFw=; b=Lm3Py5m6K8c8HZxw45z8YnJI8c
	Y9S7A6tMIBDo0Bd8dyELa+CGlqrRwfFpD5PGGNFdELWnwuH+j6LYLmxspfrx5kA8COuAlJlBGCmRu
	s+RvD6WFHF/4lw/ylNMikWXtUnnbkWBBfe9kjq8H8aLljKj+e8E2nMsnMMEZ7YNmUny7HelrMaC+c
	+vC51WYkAasFCMFy57qISNlCc/NsGBEsyFQJ5/ayQc22pziKekcNBZHx03Lyc3FKIzzhJhWqe67VJ
	efyKLzI+vvIrfljStJKPoIWQPPJMflq8VkpFKKn2EFeSRsqdLISZv1ktOL+5oBE2P6goopVcmn8EG
	CMcP8NzA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57448 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1ubzz2-00000002WC2-0i1v;
	Wed, 16 Jul 2025 05:07:32 -0600
Message-ID: <cd68564b-4775-47ba-800d-35b98f814883@w6rz.net>
Date: Wed, 16 Jul 2025 04:07:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/111] 6.6.99-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20250715163542.059429276@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250715163542.059429276@linuxfoundation.org>
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
X-Exim-ID: 1ubzz2-00000002WC2-0i1v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57448
X-Source-Auth: re@w6rz.net
X-Email-Count: 22
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPtrtxMm6YMOLNPi/LbqEXkGM4xG3rI2k/IN4O2Hw2P/9kJSuAtT/9HB2/8s0kwA0bLk7h0Bv2lGdfC5Id79mXd2rFRfCGeWROJdZEMs6Pt1dJRbo41t
 TiYgDU7HRjKi1M6silb37QF9PQXW9XCAYmfv8BLfeAT4cICQwhJResxCxccnY0C1JQGkwYO1NEQDjg==

On 7/15/25 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 16:35:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.99-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


