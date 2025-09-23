Return-Path: <stable+bounces-181513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF31B967A1
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 17:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747B01684FA
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77791F75A6;
	Tue, 23 Sep 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="yPYHckoK"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEEE18E20
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639486; cv=none; b=UTIhJa1Zw+ylJeABFroARUet7yaqipj093K6tB/t/6zjIX/J5YS3hY6G8Sv2/wOewTSCzei3mEeK3aWMKePfvG3ixGmHA93buFNMAqa1TlCdYl43nbpg7HJ4MXzlsxrQG3ObDqLXRAze49yTfpthHjq6VEBEe+wWe8zsQ2CPodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639486; c=relaxed/simple;
	bh=fPgKhAXLtq1r+0p7DPCWl4qoTyUKru1c3B+IZWuMy88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOva66dXcOetmeEGQr6t1MmT3lIB9QxM2iOEaK0FERRSKMnHgkvpiUsdR8kl2Hz0/08sB5ND96IYmZbZUbGKLiDxZ47VfSiOUGQ7NFf2H/HJGSnCb7FTjv/XgXAAzb9mIY+xx9jc42guVlGrvZ1ULklufAusNU7AzLFDhIT2Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=yPYHckoK; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id 13I1v83DHSkcf14Spv9XtW; Tue, 23 Sep 2025 14:57:55 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 14Sovdy5tHyqZ14SpvAs4u; Tue, 23 Sep 2025 14:57:55 +0000
X-Authority-Analysis: v=2.4 cv=G4EcE8k5 c=1 sm=1 tr=0 ts=68d2b573
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=H2e1TcdlFpyve7uw5OEA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ei7w3jLwdGgrHNAL8l1NYLiV0L5D5a+WqLWXWUhRPtc=; b=yPYHckoKdKLF13hMR+iCX+JnES
	56HwZHhvEjHgkfo3bBgQiuhYzH2DlEKKbY7DTZAA3C472eWkWojSMLOyUnGfj43rB0iwFVHCjWpmn
	/bJ/ziWb0nplp6aD4IDd0AKhTQTEfoDP9DQebeZd2+xAhNUGvtS4IcvqZ2LmwsOOn2X09CAq+OwH6
	kuwbPz/PqMlifKb/CafzZpxY7y7GlPC1FYauLFuljO4r9d+bDcJIFmgQr3MUUPT9ONF3UG1Ya4VTb
	60Tp7sQSVSx+aG1VsxaOGdOYdEP8PqzlLGRKCikeVMOfpTcSVvPwmJN3z0gSeW7tdexkjdUESaLPn
	KHKo7gvg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36408 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v14So-00000000s8B-0bpF;
	Tue, 23 Sep 2025 08:57:54 -0600
Message-ID: <a4cab218-3c25-426e-a5a5-fb49d89ce544@w6rz.net>
Date: Tue, 23 Sep 2025 07:57:51 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250922192412.885919229@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
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
X-Exim-ID: 1v14So-00000000s8B-0bpF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:36408
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFNMFeIZUImhdel45rz2EyWWRN4PXZqj1vbckt4+r6qbwt9KShoslSDXDpsXEBof0TYnKxNwoA5QPYtjxTAXhwB4CR37D9QXWkkqcoS1puMhSTtClwsr
 NG7GgYX21biSVG6VeZkNWcMDGoYfQOdUv9hIO7dIzjftEwpw+unbEHs3+b+/FkLnwKSG/YlptjUJ/A==

On 9/22/25 12:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


