Return-Path: <stable+bounces-35535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E53894AC7
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 07:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073DD1C21935
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 05:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093218044;
	Tue,  2 Apr 2024 05:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0eiWRh8q"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7FA17C95
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034843; cv=none; b=GgApJtX9jVYMR3dax8+L8CwKfYRXHqNX4MofV+QGILmM+tOXiH9WaKLYFX/YeOEHGD8ryijAd9vK+PT0kDXqWO1usAio6BLIYiur3KfMB8m2GtecqvpFRe1FiLcBlb7lPvxshnP/yJyv7ZddyAqEDeCpvBwaIOfpwhsiDkdzA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034843; c=relaxed/simple;
	bh=fxwNwE3ZMbT6hPHqx2KGEVoVHnLMm7qX+1rvhAbsHFQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=E3XJlFEshB8OcbLTEwHiYc5zkdBqy/mpczQ6vyv3J+I4Y/IRx1h/Y9f9D05Q4AzTd0cm0Y2kZooedZnDfzQ4vTUfepwPHkBynUS+9frwsEo/VjzDG8fFyIJGwAkG+0x/xKeKaF4KTst08xnhwKd+uyCQapc6y7xm06DOiTyH0Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0eiWRh8q; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id rK6Sr9WKGHXmArWTBrjbs6; Tue, 02 Apr 2024 05:14:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rWTArvKBtbhc1rWTArVyeJ; Tue, 02 Apr 2024 05:14:00 +0000
X-Authority-Analysis: v=2.4 cv=Z7bqHmRA c=1 sm=1 tr=0 ts=660b9418
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rh1jffIz4yI6KmIMiYoXE1SPjv74MhJUKr3aoR16hAs=; b=0eiWRh8qObOvHNmnSJ2lw3vdqa
	SRPEQyPDFeNUeik2SLTSvYVizZUC6CUdlwsfUzkNz/sZT13wji6zoQ8yYKqjDXXFC0Po3xXlWXygW
	vCBOk+Fwv16tYcHcFYV+ajTyYNNiPZTFvsZuSuOcmcgbALRzX5bacPWLL4A9LLUmWD9+/KOLxKs2h
	1NEyEHBLyU2rd4s9MT5iGjLeqIMIkHBYzwKr7e+uqUrYJSGKKT9nH1AfkyvSlLE0Dd0oJAre7OAxZ
	4wBJln2kzHwJtUrlzi1ZVHGyJYKmLBeXQvs3iSlWIv35RqK1MXhSCJw21uHTOxnIkJ2oXINrr323I
	xJbbGtJA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55194 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rrWT8-0020xn-1t;
	Mon, 01 Apr 2024 23:13:58 -0600
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152547.867452742@linuxfoundation.org>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <55be44a0-cec1-0feb-fba1-300c5c1086cd@w6rz.net>
Date: Mon, 1 Apr 2024 22:13:50 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rrWT8-0020xn-1t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55194
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGRNH7CPBERznpZ2LcH99YVQ+mYT3peR+6YzXcrDBlwXVECaQAzdMW19FPY3vqWabEPyWPX5CIN6TqvBAHWiPKRWWwZI4xCHtcgidsR2y3TW+3liefNo
 0vzwqa2NDd8IB2FsyiY6qO9IhHxmfirulnvg459tUfPimztAiIMz9JRNw8t/XgP3DlKoz+QuLcUBJg==

On 4/1/24 8:40 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


