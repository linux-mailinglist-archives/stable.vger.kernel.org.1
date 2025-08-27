Return-Path: <stable+bounces-176472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D706B37E40
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703CD18990DE
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363D5312814;
	Wed, 27 Aug 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="D3oB+seA"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C9194A65
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285280; cv=none; b=gxZz7XKzYf/6Wh6G2dpqWzGaxoofT4Us91VKp2D1H1M+MeFmcxvA79dfquzwrFnPuunGc78h7HqGBoGtE5YZ3li6F0NNzM0b+eLEEsNI9AJxGBzeMHh3S8JrYDFEd/b883uA0T3I/F4qpylAeUHBBSjnQdrzHfXdywKOp6aCNS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285280; c=relaxed/simple;
	bh=e+VoK9+9ktkhtiSHmZtvrsusXYvPcQRzEfCAaq7ZjnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXVQpw0EFq0F5uWFOgHbr7AzoFS3J2nDQwcvHewCGTWMjwCjcQeqotHiI3IA/VfMy7WNLnfrqgftMmwiJG3rXtfK1Dn1rHxx3gus+mX9rsMyiqhPKABl9UD5R5+TRXLxP/xxHqH4qHAs0KwmRxQ3h6a0pjtg7P1+6NP/uydDcoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=D3oB+seA; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id rBIjuILLiav9lrC0JukYmV; Wed, 27 Aug 2025 08:59:39 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id rC0IufRgSwYTkrC0Iu7G4M; Wed, 27 Aug 2025 08:59:38 +0000
X-Authority-Analysis: v=2.4 cv=fYCty1QF c=1 sm=1 tr=0 ts=68aec8fa
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=Hjfe3DhCYvkSn7QD38gA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VOG3LYKgZCMMo+MNkUGKaiRiVRBi5+p1mFmH9vWfY6k=; b=D3oB+seATMeIynAFejlT0dNFkP
	7J3AFKy6noMCCpGqOGkZyj3IUAvXxNoVq+CnAjsfJc/1yBSGEGnGv9cEWFwyuMmj88J4xhlJK+yMs
	0EMZwAFvWr15dFWHVF/rtB+Iwp9RKYpwNQKgIY5tFQrjGpoQhgcNe2wyOzwGi4LfVVucpE6Tdfj1s
	TU9PTB9NN3W2EVycXQmijoCexs3U3wPE+PZriKKSAsstBPiw8erUs2igNpIHeFd8cICta3nfl7b2Z
	xH9u2EchuVC01aFZ7MHh/qTNUcXKRlfSY1uCTZz+0vhMWf1kCtUUKDLwwXvLJ5vexQk2khoLG1BC5
	jaNR9TQg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:57290 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1urC0H-0000000473b-2Tat;
	Wed, 27 Aug 2025 02:59:37 -0600
Message-ID: <d3486309-6615-4754-8944-13e48067d052@w6rz.net>
Date: Wed, 27 Aug 2025 01:59:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110937.289866482@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
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
X-Exim-ID: 1urC0H-0000000473b-2Tat
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:57290
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCGCScJV+c5iggzU/TLcdokKBiexUli0RVnEhyJLFweyaef7NICeilUg7+Z0ZMoxHP4RXctWkMQMhPNYigwJIUuSXOhUi0NEc/H2YhYKYf7W7xncGK/w
 I2rHEbyPejv9Y+ryjBMX5j4ycjcaqj3DONKP4qqglKy4pHBPBvBnfCHEMdQ1IqhPle/erMrPU3aQvQ==

On 8/26/25 04:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


