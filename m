Return-Path: <stable+bounces-199997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 397EFCA3407
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 283643027715
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E1329E6D;
	Thu,  4 Dec 2025 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="ksmECPAJ"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8042E06EA
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844788; cv=none; b=FvgdAf4u2UV6dPVzfaZeVo8reEbZlYJ3LXU+8C7e8ztjdwS7hVm15yIhHkS4cXmT5wdZZQ+pTHLB4lPw1R3NQbfrkR06GaCBDIMBgwzOuWl5glW5D1Z1NanOcINQaqqDGdJpqD5gkN9K7GT/j637tDI0V4xFZD3Q65xhRcUI73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844788; c=relaxed/simple;
	bh=nTF5dXyJXcZmBo8sfznGNyeFPTJIxBUFGUsLSHEAdwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I6GB38QFE29PEMAbbq8KrqUd8N3kK+O9FYLD3e7bT3IcEG8KHz8gUmaEgA+dFtbvCUArkzExgREugFQaeFmzwJCOUJDDCJs4DHMdfT3u185a2rxe3DDNDQlmI0z0w/Q8SM5EDJ2ujVaG8y/88jilHfbz9Ifrwzeb/mlQtvef7zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=ksmECPAJ; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id R5I9v9nJoipkCR6kTvxrBz; Thu, 04 Dec 2025 10:39:45 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id R6kTvhZjihoT4R6kTvDUOC; Thu, 04 Dec 2025 10:39:45 +0000
X-Authority-Analysis: v=2.4 cv=XZyJzJ55 c=1 sm=1 tr=0 ts=693164f1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E9a5hM8EkPK/t7TaD0teulCvjz/eWSTm+mJSdQrACXQ=; b=ksmECPAJeFW3tnNwYueDC9qn1N
	STqY5hMxBNLhODH6qPZj57cC4RcCzscOvjJPPZLDYmtx3z+MfB/GIFShjWFWgMPnZZUQeAT+N5oTK
	n5erNovecXao5S7X0cbe2gkjJpsCNOWhG/8a0j5mT0OwlOxxS4x0Sr7I7ATYGL0LGt09ckKolvf7u
	KAshY0JHLi+26KipS+FeMJcKe9KsLvw5S+PJkUKXpmVKAM4nnOIiLHssf711bUlAdOpyY/A9z1fQ0
	itkTYtLBxTokL99uD6Ky9PoZXrhDz0UVOxyqLl15Vd7k/ugd5Xm3NFOuYhjFUkFuTfdAskpKRe04r
	aoQ7iyRg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:60538 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vR6kS-00000001ZBt-30ow;
	Thu, 04 Dec 2025 03:39:44 -0700
Message-ID: <30edad97-faec-43a8-a855-d20bed99a29a@w6rz.net>
Date: Thu, 4 Dec 2025 02:39:42 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/93] 6.6.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20251203152336.494201426@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20251203152336.494201426@linuxfoundation.org>
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
X-Exim-ID: 1vR6kS-00000001ZBt-30ow
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:60538
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDLw3xGirUxVFnYL4F1j4iSkjxanAHL9xJjTsG1t39Fy1J+MHaNA64Hpxqv1Vc+aYSZOvuCxmzb9PJnpBwt+Jod/7K+gvUTH6PeOAk/h83wKaEJpseNp
 kyaQQlNsWuUY0w0eweZOodAk4Sw9ng47GTVfZo7TdTp7i4wXLkpjXJzvP4UfmY/mqX0UTQ21+0aV0g==

On 12/3/25 07:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.119 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


