Return-Path: <stable+bounces-55843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4983918162
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 14:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBF51F2451F
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 12:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B7C1822CB;
	Wed, 26 Jun 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="IHjhTNHz"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D70219BC6
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406124; cv=none; b=qDcK9rAhDafM2iP0Mi5MLYNzrZbiO5k9Y4EYL/v2+8/bBj/SUZZqBtpatECFJfJo1j6Crz23twIoGfSYqa2jLAm/qcM+atnSOrynAbmgOcIgjFELzYmNBtzYpaAoJqZAnP6srXWzfWcSnyROYhmY0ZHkGEfAUq//gAIifOS6iDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406124; c=relaxed/simple;
	bh=UD81cMwmUcHhRvplZaRd5shbhDnIzw+Ks4kxSd3Hivs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=OKMWqKQ3LaG9PaGXPJmwH13ek0r08XN28qlMRilXqyUGpR4Hnpu8h1Iobco1BIY7EUMeuKI0sTZNC4k8G5JomXXYaNE0t0ttzrVmTzwimTMg2cN4VGBto1i57Z/4WtUbTFuJa3slxZidtjX+PJmVx+TUKmtuAaVzKwp55NPSDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=IHjhTNHz; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
	by cmsmtp with ESMTPS
	id M7T0sSCKrSLKxMS4osMlJ9; Wed, 26 Jun 2024 12:48:42 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id MS4ns9gFhWSxAMS4nsR34P; Wed, 26 Jun 2024 12:48:41 +0000
X-Authority-Analysis: v=2.4 cv=VfXxPkp9 c=1 sm=1 tr=0 ts=667c0e29
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=nIAznLeY9BhABaY2-0MA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u0ctgDJnqsEISZjxnaetzAzJdwXXNoK5bJuVrmyecYY=; b=IHjhTNHzyltP0hrQckBsRKe8zv
	ezVvOBDAR3kXRWJHjFdX92kRXH/qJkklPYE1udraBfFnM14mocgnqEGq8PBxeaa9lcOlPq8UKvBG9
	8BBpUu5uy4zsDSCdUP9H5px05zNI7Ev2+kzxsdy4htGq4e/3lSxtpp5QiegrKsOVXE9XCrYfMqYjK
	iaNyMCbs5f6+6C/720bgi7MiyaHhPyJ225SXOQYMizua2ZxaFHRS3hDaDPau+gJF5nD7iETLnGrRz
	eZfjWQ8e0dzJ+wa3snf0zmpDCowYgPRmE4+cso4h52TuenH5a/34SU1uYakG0s8xs6EV4sh9f8L+I
	HA8SkHXA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:45932 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sMS4i-002rXt-0S;
	Wed, 26 Jun 2024 06:48:36 -0600
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240625085537.150087723@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <8ef227cf-7477-edf5-d802-1e186d92bfeb@w6rz.net>
Date: Wed, 26 Jun 2024 05:48:25 -0700
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
X-Exim-ID: 1sMS4i-002rXt-0S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:45932
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJLXzq0OJEvZNt0RnPOFiRRuBxjg1yejTg+F1Rpxi7XAt8ssKL7cjhntCqixJXzFua0edmbtzhDgc/iEPxEw0QnaPhJEmxZbWRT3U25ugFHXkZSIx0Pm
 qd1LRJpHCTwoJIMP+lKZx5aRSg6rkpQGCHHrKsoYcUtYMt6rWec6+rg4Rdk/72Hz/DJ7r7PvQK/sBA==

On 6/25/24 2:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


