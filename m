Return-Path: <stable+bounces-139244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F73AA576E
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AAA16678F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF39F2D29C8;
	Wed, 30 Apr 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="mZ3Vf0GF"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D941EDA11
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048577; cv=none; b=esay6HjVStLjvEhRW6bjnKL63mtG1xxYovReIVxpxLjBw0tnK9POk7YEEE33GmmUwtkKVUYGexqR53NWjBRC2WvX1SmKv7LnRLZCC3jJ4Iq7Kfv29PauiTDbMI4qoPU5Dh9xgUQw0in+YnGsOUCcLaCVdivWlj2gvHu4zySt5BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048577; c=relaxed/simple;
	bh=1OuUbodVYhVl9bKW6Vaw5BSV1f0RNFAD4innAW1zTRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BDD6qxnYM8sqr0RIXOv+iO2tpkpAQ8PGdIs/lL5R61tn+Jyf9kTlvMYFZIliTyOfpLXgBUIPIE0N4MHI/VgdRXrBRGA4nA5bVk3CGAQWm/+h8wjl08ZM3XRduMFMjQLYcut9EIFcMguGwwGvc9mudo/1a6e5yYKKHIAcuSZjs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=mZ3Vf0GF; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
	by cmsmtp with ESMTPS
	id AEALurlxXWuHKAEznubqho; Wed, 30 Apr 2025 21:29:35 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id AEzluK4SkSPIxAEzmuaklr; Wed, 30 Apr 2025 21:29:34 +0000
X-Authority-Analysis: v=2.4 cv=MdZquY/f c=1 sm=1 tr=0 ts=6812963e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=X_drXzbwcQU-ujxrCA4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wMriEYcwK40iQDQjB61MofUi7skhAcrL3bkbegrM79c=; b=mZ3Vf0GFoR8iQeyRQJY3u6YtoA
	54q6zQQVNjkHFXMyFjfRFrUOptKXXlpydYXSPicY5iLlsrk1Ic7x988j1k+a0QfaumkbLW+48cCMe
	tTJSRHvJxlxs2B5l47V6WL4k9LChRiyJ8hTIeblTIplqB4ZJ2WG+7j57FzNp349BOD4RVt8nb9tdi
	FOZw1vF44dpZmfoL1TXRc78ATNQ69je/0TAosuuUAjX6IEPJQj4Num6uhBM+iA/Wd9wYKcQte7X0C
	4a4XIgmJ6PftHtSTW9kr2Zo9KiOyWxY//57rDFMEOcgjf3jfO97wdedVLfSbQ96KuYD4y4YXU0MM3
	n0+cOdGA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:50222 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uAEzk-00000000cL6-0C23;
	Wed, 30 Apr 2025 15:29:32 -0600
Message-ID: <e9e6ddf6-c87e-4e94-a2f8-107f6df419bb@w6rz.net>
Date: Wed, 30 Apr 2025 14:29:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/373] 5.15.181-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250429161123.119104857@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
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
X-Exim-ID: 1uAEzk-00000000cL6-0C23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:50222
X-Source-Auth: re@w6rz.net
X-Email-Count: 94
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDJnAYur+0tpyRaFRYLrlmwWPKWDMboxiJWKoD+Ylg5LNUeE38XXKAV+MBedmgBdRhKRk4yknz1zQeaHouEKHLRkfLpSLL2el125caJLbqoyMyGOA9wE
 Z0reweVUt2MiGGy0VtTL/lTjJ7K85Xyiy9ChjkMKX2X9ngbzwDUsYnCXqdHExmInsdw5quUGvWFlvQ==

On 4/29/25 09:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.181 release.
> There are 373 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 May 2025 16:10:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.181-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


