Return-Path: <stable+bounces-6410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0428E80E555
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 09:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D404280EBB
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC56018035;
	Tue, 12 Dec 2023 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="1Q5nlSIW"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4BCA0
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 00:00:27 -0800 (PST)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id CuFNrYpNuWcCICxgorebT6; Tue, 12 Dec 2023 08:00:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id CxgnrXMlaRQmiCxgnro8MU; Tue, 12 Dec 2023 08:00:25 +0000
X-Authority-Analysis: v=2.4 cv=CdcbWZnl c=1 sm=1 tr=0 ts=65781319
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8NJ28uQZuk9BnM+rSq1icOVrsy5QUIj/jnor8S7F1us=; b=1Q5nlSIWx0eZOv/BaBntkeL3G6
	hD6Xm6dRgyzJiWkH6AHfe7H5SLkG1shTuiUu8mhe+RuUm1xUxPWJk7VH+H2SlCYEszjo2TXRZM6yD
	zaLyhEMJaKw5MBYlj/Nl1j0uSUkS/XjXZvfACt3pJfAeS3dawcfBWzOt5Yc69AHdA+S3BGsmACXig
	y3EM5UFf5+blr/q7lJMmDdzdIkAxQp8s53ppBegSs5QcMokRooUVROVK4C9Mg/xsPxaKtUPeS2Xrm
	6bs6PyCYVcS4XMuQsyB3eiMFwQrJXQPS097nQN4bG5ubrXvHxa2oUZya+E5a3cPlOEGeJVjBH0eSx
	8exJWmAw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:59438 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rCxgk-004JHm-2q;
	Tue, 12 Dec 2023 01:00:22 -0700
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
References: <20231211182045.784881756@linuxfoundation.org>
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <c8a25753-212c-f9b6-50fd-15b163d526c1@w6rz.net>
Date: Tue, 12 Dec 2023 00:00:20 -0800
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
X-Exim-ID: 1rCxgk-004JHm-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:59438
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDCdNgd08uLTv37gTjaiVMlnd1q6AI5Tsqyyhmgwe0gMliqQZpKBQ453iu7eS19t4XLKwXxv//aylb0HFvkXqpzVgOka8CNl7ymWoZRmLC4NW326EN26
 8zhI02ZqCeC47boGiFLgT+VnaI2V/57R6x6ZfEYMu2Y03Hvk0+U/A1p8+gZfl+MQVwkQlp7Ub0B5/A==

On 12/11/23 10:18 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


