Return-Path: <stable+bounces-161414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3B4AFE563
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6203C561354
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 10:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B710289E26;
	Wed,  9 Jul 2025 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ldmJQjxQ"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9A28981C
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055766; cv=none; b=h9ZGOfwtMPelxgUglPpnse6YifYWeSu0praqz0a8qXuUm4PrijPOpHToRdN3gQJWOYlGe+IOrz3lZlFa9eY0O5lTYDnyqmzwUe2iYd+iaAuvIHH7TA+k5x6W285EiRww0Hykp7InGB885sbpqEs8BrMtg+SotmDPA5G85RD5UEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055766; c=relaxed/simple;
	bh=bL1QCulMurf6j0Kf9zlvvDZRmItbDJtZO/4OUhKdWAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uT7GMisM1ZVUX4fPUC4okLkac/xJ17fC7bC4zj45PIWoPwDVrC22rIju3vdbkn2WZ06W/29UkMfUM6GR2GpQA//fIjN2/rs+QnR1h1hXzjroYJttUniV5e6txTrY3SFpJ7cOk7u0TQYQ/SiUgPjQA9MYiruPzX/BtRMB1XGKaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ldmJQjxQ; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id ZKdxuZ9z8iuzSZRjuuedvL; Wed, 09 Jul 2025 10:09:22 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ZRjuuZg0iz1ssZRjuuOKjp; Wed, 09 Jul 2025 10:09:22 +0000
X-Authority-Analysis: v=2.4 cv=Q5LU4Z2a c=1 sm=1 tr=0 ts=686e3fd2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yE26g0Vn26Q0To6AtuuF8z05zOs4rpxeOht1Xqw5dRo=; b=ldmJQjxQmJsj6cqTBTSU+x1MvV
	MyHjhgOl4AKKlqZ404PLmapqzcn1P7gTNzbwcfXS8OquEcpUQhyYBcSyIzH6GG1YWp7CmKIwAKN5O
	08iWYfbDnyKZ7osVcTXv9gV3lrD2w2UqrsgQhbLWEyHo77+uTF0fwSZ+F8pIGWuONkBK3IRrNPYFr
	FDOE4bCNPpT3qLWmQf4V55Vf9lcjX1N2BEtNXF4OqmtU85vkXPwXPVpRXr8hBAlPflshJlFCtjuzF
	3izA9kWXdvrxlJu0UNcB6mlFuqYWRnrh+RWMwyZRu/Zrk9kdECVFeMQg3iRvxUP+lRgLrUIAJOiZg
	izGoWziA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40366 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uZRjr-00000003Ve1-2vVh;
	Wed, 09 Jul 2025 04:09:19 -0600
Message-ID: <09db343f-e4c6-41cb-b39a-b556bcafbc39@w6rz.net>
Date: Wed, 9 Jul 2025 03:09:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/149] 5.15.187-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708183250.808640526@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250708183250.808640526@linuxfoundation.org>
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
X-Exim-ID: 1uZRjr-00000003Ve1-2vVh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:40366
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAEGo9guJ6AnUW97tyYUoSVNKPf6W8FPQ8IHACvtzuNDTc7govvXnhhCFnWAMZstu5GkT4FAj+z7jjUc3IeWqcFPujqcCyT9xDXlrJ7/EapkxVErMvfE
 LJYIuW7UnH1nbrn9+tF6fQU/rAkRxUxMYfX5CGYJBhvcZbMx+cicApU7JAMXMDFjFvY+vPB3Dbmalw==

On 7/8/25 11:33, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.187 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:32:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.187-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


