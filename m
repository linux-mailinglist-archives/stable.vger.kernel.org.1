Return-Path: <stable+bounces-177590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C3B41984
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0EC3ADCE7
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03E2D595D;
	Wed,  3 Sep 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="I1jzlikU"
X-Original-To: stable@vger.kernel.org
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AC2DF135
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890150; cv=none; b=ff6qujtRdkC0fUc8xCTxrI9nqRtgaCdsp6PmH7tsAmR8ulF1nX+5wlao/7beQUlYyLWc3PJePbAW2GoFZd+fw/73waET0xg3qEEvRUCRDT9+vrwbV+RcsFzCJUuF9Jfuj4ezSZmCT7RJWLTgZKBwKWe1Rskmj4t30XiWcoBNRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890150; c=relaxed/simple;
	bh=ZghjQ4sGxAlRlaK/9MCqmpKge6JXaWtLZ7jFDobDRzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHoxXDG6KQZmF560wwXOHtDvPZpr5Qw63qd8UNHDIPtF+pB4XeUkeHrN16EK0ppnBOW84VsYOmyHPSAlXH+PFaCIV8p6bboBrgQ9KSHUfVB278NLsS7vLXfWjYEkV/tgi+HsIEHkZ0G8zYyMWX7N/Ij1012QtslO/7lgOEWUwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=I1jzlikU; arc=none smtp.client-ip=44.202.169.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id tgXKu3AhVU1JTtjNruzE5E; Wed, 03 Sep 2025 09:02:27 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id tjNruEKbNwbSdtjNrucnep; Wed, 03 Sep 2025 09:02:27 +0000
X-Authority-Analysis: v=2.4 cv=VODdn8PX c=1 sm=1 tr=0 ts=68b80423
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=wQHQzwf_Hs2TCVCgcZgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MC4NAYLhwdC8vxhcTZFRp8+26vLRnoQroBbJEV28rQI=; b=I1jzlikU2GyTAgOwC2LHY5euQ6
	ROTBq/ObxrTSCmLRayVGzv/2ChWnlVudD8v+OXXdkELfP21ylKEatdVAmafmGAjrzczTFvkpdJq/4
	gtAn9BlgeRlqwD4/BqRUEXOmHWTdTjXkE7YIZ1d4mzWoKF5cbARMGxidHA0xTy4vtXHZrFw/JJLCf
	uPYCoM+Sjl6a9818+xpFQXuCldtI+3iCRm6onp9dPq/0FRlWsblkLiwdkSGVWt71usc4Sc+5G2Hdj
	7dw7iM2ObpWcRCEBFpeCwlUNZKLfKqwaBFWvI0ZazlJzT3M6oE4BANUBltUT7xbQtlViiqW1j5qJF
	FveRf2iA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:54690 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1utjNq-00000000mGZ-2B4i;
	Wed, 03 Sep 2025 03:02:26 -0600
Message-ID: <3e9342b1-4e3d-4551-9b48-b1fcdfc7e0b8@w6rz.net>
Date: Wed, 3 Sep 2025 02:02:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/75] 6.6.104-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250902131935.107897242@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250902131935.107897242@linuxfoundation.org>
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
X-Exim-ID: 1utjNq-00000000mGZ-2B4i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:54690
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMBsZ3Q/E3Ow/vqmjtgOftiOyJUltcCfedE9xsrZ9p1SLIT2F5iBp8H5tYNaZn23T/e0H0iwPkst50Pc0WAVEixOxMfnGr+Yd7162mT6gjMjN0dkkRiy
 kMFRvQuqwV02ll2qTiJ7NYniFgQxzEVIgBY5MXYiksCt05BU17Oasn20JpTEDMAsaunmMInTUndqFg==

On 9/2/25 06:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.104 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Sep 2025 13:19:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.104-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


