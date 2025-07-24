Return-Path: <stable+bounces-164552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AF3B0FF39
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 05:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53ED75460A8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 03:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E401F8F58;
	Thu, 24 Jul 2025 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="v4panOWu"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59250EEC8
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753328917; cv=none; b=FDPvAoQ27HbTHmOvCGiEqlbN5sQDJBhA92vIG4nLmYGSvbFvHrW2ap47A1MEJXnLoV58qo4TO0bmR/ihJyU46OoPvQe1cj2Eagb7A+PC9eiNhyQreYJgClbhQEdJ5WkdPPkelImT2IQbstS5JnnGF7Epf2sFixa1oT4aA7QRCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753328917; c=relaxed/simple;
	bh=H0tBM7zoukl/CfcYJ0dSST41IE7bVr8Hub0As0Nr0po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LSBGEmpyqE1OCZ6Y6/i3sQ71U+LvrtM6n3elS9TZIeTqzQpOH8o3WPjQggZPImyOoo6sRhoP/TXv3cIOL1385/Bwvfr3togZVaXBIFwT6E2WxOnvBpRecdYFAVEVNMJASY3deJuL7ZELwcyZzHw2OufGHGtNxvrWrbTRlCWzGjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=v4panOWu; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id ehHyu8h8UAfjwemwcua6Ph; Thu, 24 Jul 2025 03:48:34 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id emwbutdCO52FNemwbuAvXh; Thu, 24 Jul 2025 03:48:33 +0000
X-Authority-Analysis: v=2.4 cv=QIduRBLL c=1 sm=1 tr=0 ts=6881ad11
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=CIo_2QJ3nJB9J6BkDI8A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jJBRnUgykqIJVCxscrZQ6+h/Jo/rwBJPqV0aq58gHM8=; b=v4panOWueFdtcZIf/A+Uyo+nmZ
	mzEA68xhXEAmX/qlr+iHeSKLeMkkN4gV8smCKqU8TUCDyk8EruZfrAxZiGF0N98dO6EFqsxpjLlDh
	tqTEXirGgyVpOy3BN9hpO7jfQ044sWLYy6NohWiVAwPCguqRl52MZ59ymQxWObC70KnvsO4A3CpUZ
	ocRuptVwr7XqrMDaMSRxoT0KEBb4U+bIMYqNFqBo+BY2rE6bclI7RHkQNUQdnTBn1ooI/u/WvScnS
	6SFfxqS0lF0O4CK26C4WuhFPvqRzHzELtNAlXxAvLlXjyiV+BqEp8CavnMeEfZZZIigzsmCb3Nr+6
	MedhpHVw==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:51942 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uemwa-00000000C9F-1KrE;
	Wed, 23 Jul 2025 21:48:32 -0600
Message-ID: <98a8b080-8948-452f-b7b1-d8b68a1755ac@w6rz.net>
Date: Wed, 23 Jul 2025 20:48:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/111] 6.6.100-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250722134333.375479548@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250722134333.375479548@linuxfoundation.org>
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
X-Exim-ID: 1uemwa-00000000C9F-1KrE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:51942
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAFya6NtB00sURfgzGQC8cWdXyznOhlydr8M3cWshabrBKsPiUQT6EauxzVDvjkLFmm9PUsyHr2IUUMTMKIKWqecrqFZ0qrckxv2n/OFO1FnltbuUbzx
 JAyD0UTk+de22orP2O5qHI09HQZF+raCdk31UvxY9OIyxUHPWfmm9znEdCjfLoBWgScdc0ycqSRPUw==

On 7/22/25 06:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.100 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.100-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


