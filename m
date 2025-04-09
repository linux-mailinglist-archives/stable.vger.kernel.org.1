Return-Path: <stable+bounces-131889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A8A81D80
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 08:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A019880F56
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565F1EB18D;
	Wed,  9 Apr 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0PBHCeMv"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB170809
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 06:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744181650; cv=none; b=hFG91cpn3siCZLLcur8TrrKEVlqlcX/FpqEJguxTKaWi07mWTo0zhdsK7m9lkqjwr1hXctOT/tvb/LFFCRUkiuwzc/k2HbdX9fW5j00Lr5PgQSwJUORs9cYGLIh0lBqpqXmMjkGfxrG/IncwcccY0jRzQLcTE9ZzzA974hyPOHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744181650; c=relaxed/simple;
	bh=QxH7+kfZFLAY/mCoHU6UiyvxMVtNvxZ8f21UE3uays4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzGRKvKZdixWwLdqeLlCSTfyz+lArzB5GTb70kOBgichCGQfdRZ02XNsjo3W20etCmPopiH4PvDPLtHC3McBPBARqeRMlQK4Q3DZDcs0nnJERdNYNYfb1sAqALm8MEx/d6EJl1AUkOadGU8AZAjRcplkBmQUztSe1p44pwVytxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0PBHCeMv; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 2AO2uoHe8WuHK2PK3uoOJh; Wed, 09 Apr 2025 06:54:07 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 2PK2umxtKCUo82PK3upHzt; Wed, 09 Apr 2025 06:54:07 +0000
X-Authority-Analysis: v=2.4 cv=NdLg1XD4 c=1 sm=1 tr=0 ts=67f6198f
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
	bh=ZxG2Mo1bweZcTQo1GVtvFkI4JIEh0Goa3Ucsj6YyNSw=; b=0PBHCeMv6O/RBN6/GF0+eWX2gb
	suGT2uLHrDI3YNKGHNojcmYhQFcbSUMx3YKktcBTt6oQWiATlxauB+1tE0gv9E+sw+c4ItnUP+Ji8
	klx2kLWdhQILV6hIKkmM5XoBhS1iE9gQ5SE9Q4XD4CXj45YeCAt+FyOdIW1FEYkfI1eaR8aKjoKe1
	KKPIBRBOZWAd7HIBC4SeeW72c0xWer4tYz82Iwm9tjoKPvXIJ6ZEiErdYk5Oq21vwmW3hUMB98WzD
	hSvgcr58YTxbknIuJxMw6a05200v5pno3ilQStDYGnl7kSWRQXrIjzKYwJJqCTV47qdT9vwT5VQMy
	jCcbgOnA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37958 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1u2PK1-00000000PfF-0Evq;
	Wed, 09 Apr 2025 00:54:05 -0600
Message-ID: <5f399993-4d74-4665-b64b-1d83cc7f8b25@w6rz.net>
Date: Tue, 8 Apr 2025 23:54:01 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/204] 6.1.134-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250408104820.266892317@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
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
X-Exim-ID: 1u2PK1-00000000PfF-0Evq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:37958
X-Source-Auth: re@w6rz.net
X-Email-Count: 94
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFgmfCRQsNcjrZkma1oRD3ZwrHHGA7dKTqc8CRwj8b6nra/gX37RCVyP3LEV8/Ly7xkrfOaIOUtgb76lAaTxYhYSn19U2oQpBv7wJzXT8uQdoXwTfOD0
 rG1qFym+rhfSiOwICqlx8euoSETRyAxAOCm3EZnmDq2r2sWuapslDhMcTiRqoib/mwE4tA2XEOWoxA==

On 4/8/25 03:48, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.134 release.
> There are 204 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


