Return-Path: <stable+bounces-83287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F1997988
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 02:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC8A2839AB
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 00:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E144180B;
	Thu, 10 Oct 2024 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="aeZiy1SU"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8626632
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728519300; cv=none; b=LVmb0tHjspy32GWZWxHLqoOSZGYuYsQdBVOF0gdsH5cTFV82hfv2wW7z12/yXric4cOWryfeqcS4Pajzis7oajkh2olSwfep8SQlcrQdSZP7XT03pZDOQsVDdKADJCb3hIgjDIsmbPAj8FtTGBUkMqLJ8jaU7JsvS78TAvct9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728519300; c=relaxed/simple;
	bh=MetQIlVErqyCaeKy4Og15EKwEngtHD3WHSWtUIdWuYQ=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=FNYonqt8dA+ODP0mW/USzHFe7T3gJXQpICMc5Eqsd3WVvVhPhbYU41O7TGTSaa8PzmQQxIY5SMpxH8BYz6TssZ5ckrxKe3pqemkZQagdab5VD7yS2tufxhFJdgKlMUJKsReSybHgJSljZjYdGKKj9qPZo5jtmfAM1BXpmjxvZJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=aeZiy1SU; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id yaylsG55Pg2lzygpQs58fw; Thu, 10 Oct 2024 00:14:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ygpPsoKefmNYjygpQsj1IX; Thu, 10 Oct 2024 00:14:52 +0000
X-Authority-Analysis: v=2.4 cv=fb9myFQF c=1 sm=1 tr=0 ts=67071c7c
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
	bh=lemu//ZBsQxi9QpD8FpQiJb5bAyX7XGQCvz/q/ffwgY=; b=aeZiy1SUjflW5zkDOzzyGeT2zE
	uYPI0VlhKWyRNdqENkKQgHlYlklRF1J12H3cMOfYL0Zt1TaYd2BBqnwuWWwAkm9KH8D38IolRZT7/
	ZiZl+5pA2JUn5sVs8ZKSGFDza9XzA/Jt4F0YYwdFb7qCeYgjuzKciJiR/dXxfbWiQ9BdF20N9YypG
	+Y8BmRVO4q5LAEEE2o4s+TWnGKj91ZQavUXuQ8XNzPrh4k/vPPUzGyNLxgagDUXSw48FM9OdzUGNx
	2HhVL++rG43V6sg5+TkHIGIRpK0rJ5FdqSqDA5Fwik02rfJLJzWqIa4b2cOlyKYBmLMpHLcvfYSx6
	R9BHOlvQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:46234 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sygpN-002rlw-2t;
	Wed, 09 Oct 2024 18:14:49 -0600
Subject: Re: [PATCH 6.6 000/386] 6.6.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20241008115629.309157387@linuxfoundation.org>
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <041eedae-37f7-4d55-63c9-5429ff0d625e@w6rz.net>
Date: Wed, 9 Oct 2024 17:14:47 -0700
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
X-Exim-ID: 1sygpN-002rlw-2t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:46234
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO3FgCs01LZ+sQvtYmwjZh25EeuLIXi0gxyX0LTIeYGjvXbM9Yi8XEGjX0GjF4CNTluq1CLXf5jT3s4WSl0RcHar4MCMcX3tJf6wJcwyfycocyrGORKN
 U+3dTcSxftMA+1odXQ4m/4KKZy8p/p9QWNUiTRN1smwQr4SKFpfnpn9y/wBaFiwCExC5NfLvmtI+0Q==

On 10/8/24 5:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.55 release.
> There are 386 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


