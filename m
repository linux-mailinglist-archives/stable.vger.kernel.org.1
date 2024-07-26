Return-Path: <stable+bounces-61852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318893D071
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6821C214CD
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4A176AAF;
	Fri, 26 Jul 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="qkIoYEK+"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A245009
	for <stable@vger.kernel.org>; Fri, 26 Jul 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721986397; cv=none; b=pI0CalAjcbodr6WWwQOmcK+41M2ebPmVzl2OAbFDd+2CxdAe+U/p+IfFRx6iBJWHCi3DZjAAQv1cyxbaVEWWhmL9iYhKPKGNa9d7Su2eWLKIrPU1NVkO+oGu26aww4yrRBOQBp4PgsjpIRHq5Rrp9t79utsAq3wPh7FWT0rRFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721986397; c=relaxed/simple;
	bh=hXI6cs6ZBhAEE0DCjCq9d6B/MD/en+KCjrgrOwDez08=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=s3fb5pZNaYjAEfXTpJoyCasqIxzRtpPXB648Ere0RKrTY0/JzPKgSjXKS5QUQ92ICdKsfhjduDZkT+7bRKkkcKTzvOOzdcL3PX/qaZTST8DUyARMzXZcuboCEOnVVJqlBuWDaTeE06TOO//lqYnA3hVx7yz0Q6EthT6qMHvq3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=qkIoYEK+; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id X84Osru3zvH7lXHK1sbp9R; Fri, 26 Jul 2024 09:33:09 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id XHK0sw21nO7CrXHK0sbWh1; Fri, 26 Jul 2024 09:33:08 +0000
X-Authority-Analysis: v=2.4 cv=Pco0hThd c=1 sm=1 tr=0 ts=66a36d54
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=hP_FQLMrEgTDVdh0MfgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mt1JKvn8m2oelKEfsHUTEnD1OsGxGm/nt2JBIswpTOg=; b=qkIoYEK+XDlA2i0gw5ZMLMiMCo
	BuxZTkojTBpZnQQzOLSJV/TvHG6ui/mwrb1nslHbliM0MDH4D8+zgf37ZfeHIRtW4GCTIP5XuyPmZ
	miaXTgem3XQShZg0PwxZ4/BI46fu0mEGpng1MkCdhBqsY17MT/vlqJKuUIiE4w11m4rBY51bHBwlm
	efBXd7twA0ytI0xHFAZuF1tayfl28GXqGnTwYA/j0y1iQjB/R6DjWkEkl7JXDg3VRwobSBJAETumZ
	LLEjkcFne3Lqh5LvHS5bFUnLYETd/oDAdtNnsqknibfXegUNHfr+bx3oA+pHo9bvAIJTdl7QHBILa
	uGPURoww==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59290 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sXHJv-0002wk-23;
	Fri, 26 Jul 2024 03:33:03 -0600
Subject: Re: [PATCH 6.1 00/13] 6.1.102-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240725142728.029052310@linuxfoundation.org>
In-Reply-To: <20240725142728.029052310@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <9e4f235e-b439-f277-6206-f4558ad3c253@w6rz.net>
Date: Fri, 26 Jul 2024 02:32:58 -0700
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
X-Exim-ID: 1sXHJv-0002wk-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:59290
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIibXGSp84u1koRKPJgHLlXwiat63e7Z5bfpeQHgn1Sl7ZxVlYpi3c4Roq3kgyWE8a1K8LLRukwoRS3LLxgv58zf0mofQn+lqlF9a2KLPpRYdhkG5WAZ
 byFTrPKvgweIZ0iwqc7Szg7F1hnyrR/bHHM3iyyuz/3mqFq+BMDVbQHrJuw+RbSubg17WU4O1BILJg==

On 7/25/24 7:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.102 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.102-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


