Return-Path: <stable+bounces-206115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86158CFD367
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 11:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 132F83112F23
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC1304BB7;
	Wed,  7 Jan 2026 10:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="zm3MPFKC"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551002DE70D
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781245; cv=none; b=r0RUIfXFxAtg8Ir2znTHpP0LPu9hnGZRXyRuiKczktkExhEkkm90FJ80VgVP49nOTNaZevyutRXf9fldb86jFKzJoyLz8Mio2W2zriOmzApplPyI0yZy131+C/b9B0YonxF6Hs0HqId4OyggTPrcK4C90hN2mxLs387hrTwinkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781245; c=relaxed/simple;
	bh=2kevmReVONO9r3jfr4iR4uVtt2oiu4HSkohKuguGhf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHRwog9k9cCOdqfxFV5xdk1kZXjw/8q0hl1UDt+jMif1PqnurB87fgpAqr/r6oJMDyAmxFHxJXpmo8Ua/BIOHd37ncbTIGBdHRY8Z0n4mPI35yyw999EVx2qdfiANxqK4fulg2rBA48SXKj8flGGEG2HY5LnT7LlSSMnhLTgol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=zm3MPFKC; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id dKiJv6g4bv724dQegvyTva; Wed, 07 Jan 2026 10:20:42 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id dQefvJxS9HSQMdQefvRapE; Wed, 07 Jan 2026 10:20:41 +0000
X-Authority-Analysis: v=2.4 cv=GIQIEvNK c=1 sm=1 tr=0 ts=695e3379
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=LzWpqFdwXcEHhgZWz_sA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eHohJFZUQWvjst9MO5HlxGxqblsHLRuIuobVHc7MXls=; b=zm3MPFKCdNjV2m4I5OOPxgHy3R
	XiCmp2hO3d78aBoa8rGZ5fGi4xbxn2jzBsY7tNz8TNaLJZoUWOuSjK7J+M50vkJaigmZegisdfa1s
	nPkSLCWYiMrfWYEgFYswwlVsGXwzQk6ol7WapzHZiVSC5Pp58BvttpSvU2/9WMkETsNgw5MO1hGCs
	5vQQMwUtC1MVhzgyehO+VlhaxXzLJlfvikAUUMOZqYQToSb9/ObmouLLHxRvuDrTBKSX5b7KmoUHb
	PTJeYG7AtAPqZ0CcpQDZtRtN4c/B6JNLkZsi7uJe1fQeuryMSq2mMVBzOyArXs6EROdig+NVIbk5r
	iEnZ46FA==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:40060 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vdQef-00000001Xto-0PHv;
	Wed, 07 Jan 2026 03:20:41 -0700
Message-ID: <d18989a3-4b79-492d-a023-a8a2a48fd7a6@w6rz.net>
Date: Wed, 7 Jan 2026 02:20:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260106170547.832845344@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
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
X-Exim-ID: 1vdQef-00000001Xto-0PHv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:40060
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNCIM9Niq0GhkvUykYy64cG2sRfpir+JY4Y6X1X+y+3sEeQJ90hd8aNPh9OTCL8FosMsB/iQGIurhJybhv5ECmWTeS2joJ2Atd02X/AmVi7ebIANbuoJ
 GDYDeeYyv1eRQsd76hINPWsBVyEDYUjsXk+3jgl94K05nnNX97peSpvqUrG/XFXnoj2S26bL5nMALg==

On 1/6/26 09:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 08 Jan 2026 17:04:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


