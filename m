Return-Path: <stable+bounces-80701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECC098FA80
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 01:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0F5B22ACB
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 23:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0CF1CCB21;
	Thu,  3 Oct 2024 23:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="MGgV9CNQ"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCC84E0D
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998414; cv=none; b=c0gN32ZNidkHFxG/lTs9lO4Dsa6CT6qQv1bAYwdjN4LtATLqr27XMpcCh4sA2zfw5jAo7he7QczMR4Fs3UMIPoLumVGNwXB8CeczvY8ne1+W1yXnbZVFQh3bHa0f7nK51ek5+yChTNp9/Or/ivo4zc8fnfWOXZGLjNs4Uc9oeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998414; c=relaxed/simple;
	bh=NdcaIYoUN3/QDabg/eu4TFWwd0SJ41/5IF720takjgw=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=ClGmRugj98yoLzJOLZLG+NY5VRrRonX1pFBMGRZ8lOaYM+nlw3tTjpx3Zxgf457i5bYQtf5YBxsu9/A63E9hdtxdSAH2bhT9U+mKNq03aFJdxLb4mD20fjq5NQpVFiR7nfktqP5b3484dKmx03++5vH7gL6Lwnjk9tYW79KUEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=MGgV9CNQ; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id wNyzsd4Xq1zuHwVK1sRmTl; Thu, 03 Oct 2024 23:33:25 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wVK0se76kcEKuwVK1s0ojh; Thu, 03 Oct 2024 23:33:25 +0000
X-Authority-Analysis: v=2.4 cv=Z7YnH2RA c=1 sm=1 tr=0 ts=66ff29c5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QwLPCtcMcN5jNYhbZB7Z+UpxpTvfOz7Spxd74YwuQOw=; b=MGgV9CNQZaeaxxJnnqDXHrbewV
	69LOCVHiTo+ZJqVby8gtfRT6wF8ESwUBPUma0YiV0kjo6wfRVdD+zjyfgRRsV/vutMg+96GFYjqY/
	YTec4ABtS3hTVuwWX3XuEvw/5eRGwakcKXfYwidRFBqHvyT2PR73GP+YBlv4vpZEPhTfCxb4KG82v
	n8ZT8yxnrk4vbyzTYRhHzTBUio9ZYWF9oCaJiobi7UWXoBJRdKovum+ZyMr1cdt7mQXBDM37K6S8f
	YR3ZgSQ6Z/8f7DsJBREf6FTflWHMdQzDUcn5LIiBGC/OHDzRlqzdZtZA2rXHnZzo0Vyqyb6hBN9j3
	YUk6dHjw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:44440 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1swVJy-000vUr-1k;
	Thu, 03 Oct 2024 17:33:22 -0600
Subject: Re: [PATCH 6.11 000/695] 6.11.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241002125822.467776898@linuxfoundation.org>
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <f5b3f4ae-33ab-9de9-871c-f0ce880a6b58@w6rz.net>
Date: Thu, 3 Oct 2024 16:33:20 -0700
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
X-Exim-ID: 1swVJy-000vUr-1k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:44440
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKVHIZ4VCmFZ8bsvJUKkiFIg6YzlACeqGH00ZkzxTIrzURLCMqdjEcjWoeU7D9ToC4uP9NIWFIohoXoO1/a7syHXoe/mTUjmClsT0zfkZo0NoxwDp4qz
 UmMedUWXNnJQblGIPoM4WED0AC+RBeomVJERYJIXxDnAKDHiSGOjlJS3vGBudZdGEFIxQPc2pIMLVQ==

On 10/2/24 5:49 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.2 release.
> There are 695 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


