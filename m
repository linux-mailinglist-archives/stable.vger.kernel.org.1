Return-Path: <stable+bounces-98243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0303D9E33F5
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 08:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951D3B23648
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B24217C7B6;
	Wed,  4 Dec 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wzixE6KQ"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D584915B97D
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733296624; cv=none; b=uAh66AdA1YaRSsvwq3AiBgKQLCmvzdMYTe+a2su6jcR6x0Oc5JEmGCMTJa7IMIDDOcNwQcvQ+JOGCVd3Ix9IMWyatnPmLQqTMhzpjEuYbV3utKUjKsH10Ma6SY552l+fBjXKmElQTXZBsT5p7ImZ1Txrb2xGJNeKjF6PaIe2N18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733296624; c=relaxed/simple;
	bh=LS6D0DMcqAtNOJLzoN61P/kNctUIwdsiIyLu7XfmwY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWlMghTlugcqSZtXisLKbwbAtBjeHlNeIRmKK0sLpTmnwQ6ISjERwpk6v5LFEdmDRIKpeW4TiZR68Qg0iB2D9Z5qU7+6UXhHPtxwh8zOHhsDTj7RJds2vYNxL/kpcAIJpSj85HtqRH784kqv1Wr0B36IszKP6+5uBVYFfSMLqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wzixE6KQ; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id IeO1txEPdumtXIjd7tV2JD; Wed, 04 Dec 2024 07:17:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id Ijd5tz4F1827nIjd6tipqQ; Wed, 04 Dec 2024 07:17:00 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=675001ec
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=PNakoOEtvSgnu2LyEsUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7cDjMqXJlAWEosN7QlYOQ2nWafkVPYFg4+5PusqUFkA=; b=wzixE6KQmHYKfM3S8CESBhhB4z
	/xO+WFMSyAbNF1I0FVBgSfzM92DyR/1kRZqZDauT3ncEBlE/6Qe1fI+XQAA/cRhV49A36+SCScnxd
	AQTyA7E7YbQv3lQzQP8h8EHv2ynM+HsrlgE335A0vGNOInLRgwg1vXYbn8rXIEWT2IJMZ3pFRFc5t
	4xJ5xb0XTJWz0K4VoaEGyBcqzPT8psCIPKVkglsegRWD7zMT7cFkRdd2JRcbDrIWiTyJAaLxJqC21
	P8qPQoK3mwnheHGcKwOFOgTFd+V3H5eD3S5qsBndWfpob0krh9lpxsJEuufRV4vuWwMyGJY2A+pf/
	xR0FNK9A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:53986 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tIjd4-004EmQ-39;
	Wed, 04 Dec 2024 00:16:59 -0700
Message-ID: <c2027a39-7d5a-4a12-b47e-6e304448b7bb@w6rz.net>
Date: Tue, 3 Dec 2024 23:16:56 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 000/817] 6.11.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20241203143955.605130076@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
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
X-Exim-ID: 1tIjd4-004EmQ-39
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:53986
X-Source-Auth: re@w6rz.net
X-Email-Count: 37
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKQDr+P8mpANz/GWn47x1olpamNCoWoHZZtukJy/Xo3jydp8Yp9Wp+P/75XMG7HXNZ5cMYl1/SlxDz/Y9onwP2Lx3/EUBi9IAWLSQca/1Vfvo0dpykxx
 i6D75JwaO9pr7VLVZhMwWiAPl6TvjZCn3J/aO/gwx9yvEdqq20rZUii2gaTt1Ml054AWuHrdjQk1VQ==

On 12/3/24 06:32, Greg Kroah-Hartman wrote:
> -----------
> Note, this is will probably be the last 6.11.y kernel to be released.
> Please move to the 6.12.y branch at this time.
> -----------
>
> This is the start of the stable review cycle for the 6.11.11 release.
> There are 817 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Dec 2024 14:36:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


