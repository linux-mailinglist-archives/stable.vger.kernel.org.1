Return-Path: <stable+bounces-131888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BBA81D6F
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 08:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E8C7B3515
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 06:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960801B81DC;
	Wed,  9 Apr 2025 06:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="hYEm43Gw"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343D8BEA
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181252; cv=none; b=YcU0RlzgMOhP+CJUWMjJz2y0vFvDqz27LghpjuWLN3b/TXUTK489n+UWsUpl2DEVUHEqSt7HG3ShlfYfcDMUcscBx+eE6keU0ymLvgA05NgRDZgrkHZVK6urWxgt2XosS0jaoKDBBnr4p6KAoiMi5PoRseW7+uHzXjejfUatG6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181252; c=relaxed/simple;
	bh=dSuhNbiaWYrVPStkGfZ4mDD4EmWjCfc/hB+7hG057p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVOmnjhnEe8QLRnseym9ZUBKWtpZotjZTIgBg2Hl08wGYb3W4yFZhX0jCVQVgM9mfRFVHpFbVyDj5d7NM8T9/RPLcr6r+cjk42vSMbDTSsBn00uxmiJ3oDaFoqf0MyLa1dt3JHvprV7+i9bf8eQ11VPyqi0mx4dLkApqyIFFFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=hYEm43Gw; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id 2IORuIhO2zZPa2PDdu8Y9L; Wed, 09 Apr 2025 06:47:29 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 2PDcuCq1tZ6h12PDcuUOiP; Wed, 09 Apr 2025 06:47:28 +0000
X-Authority-Analysis: v=2.4 cv=ergUzZpX c=1 sm=1 tr=0 ts=67f61800
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WIYjIZka4Koev1rTlkF0ZS+CFjn6vZFVHi4ABUumf54=; b=hYEm43GwVKwUfaDlFbJ/uUvTfK
	eg6k8wlPh4xZ6lshE5G/nu8u4WHqLxDmT+xJBaP4H+7QFT0vc50dRK8o9rwG7Iq3y8DxxJK8Eb2Wf
	bI5FnJOBpYV4TqiUgykBje9ByfvOH/UZPRJPZ4de06z47iC9oavlZYdOyaAVuEkCqTei2lJbc0Y0B
	hqMemSFc8bd/VgTpdOwLIycHwx/GRmXBN+H/rn/os7u+qbCjLNSz7tru5NU02Z6YWJUkRSQnXdRXA
	VJT5idoGOg0oBVTlECIzD9n+gsbPlisntTorB6bF/2g+wjB+U9tM97mkcCvwhttuubo7hOm3gT/0U
	hIlL0OQA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:49620 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u2PDa-00000000LZT-2EAL;
	Wed, 09 Apr 2025 00:47:26 -0600
Message-ID: <633cd6e8-6802-4a70-914c-d1207bf9d7e4@w6rz.net>
Date: Tue, 8 Apr 2025 23:47:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/268] 6.6.87-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104828.499967190@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250408104828.499967190@linuxfoundation.org>
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
X-Exim-ID: 1u2PDa-00000000LZT-2EAL
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:49620
X-Source-Auth: re@w6rz.net
X-Email-Count: 75
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfELpAc1zYeF8+eqRCo/Cb6U/xc1gAYVTPeKb79bAGRmYaWvsJvFEwIRLel+D1+BrtrJexWtOYV1iL23UVMnO9GhjDP373PAJt1Uyrn8DpUloMpJezJtT
 o6lruU8jUjx1hVSsYIEKY4Bht2OJOcsBtxpxx7LjTJRNovFkzluWQTyZ8JhGJA29plK97J0fsxa29Q==

On 4/8/25 03:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.87 release.
> There are 268 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.87-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


