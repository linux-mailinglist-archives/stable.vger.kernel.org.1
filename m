Return-Path: <stable+bounces-69359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FFD9551FB
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 22:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6407B1C21880
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 20:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD51C463B;
	Fri, 16 Aug 2024 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="kERu4hm+"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786B1C3787
	for <stable@vger.kernel.org>; Fri, 16 Aug 2024 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841101; cv=none; b=eNpRRYH8HnLHJoRporzUYfuou9BevOKXx9HgIocyUsxJVs4gKjcGCg5Qt+j+fdm+tk+avpZc7JRSVVlBbNfLvGD3fv/UtMxDsiQZPVb7IuCj1jOBMz6lcvAEkkB7aSDBxalR+A8bHRELRhHzlQTWcTT+suuABLYGLjKps3QuJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841101; c=relaxed/simple;
	bh=D0CIyrrVM4FwGv/7HrMqU9NODuSehPITjjwcgc4dANE=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=PmlIP2bU8AZxCaB5CQR2vMt+KGxeI85thsSBRfY79ijnG+IcwC4XFvUdzSrw5UAZoP/Y1QSjTvRyF5k+IYteNK01U+4ha6U5gCQwdS7PcZyffrAm+A01Xd661uMzHEAZ0AEkcQOysD0+SMBdWx/tbMrhrQJm04MpWJxz2fh6sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=kERu4hm+; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
	by cmsmtp with ESMTPS
	id ejgKsRS0YvH7lf3ohsei8J; Fri, 16 Aug 2024 20:44:59 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id f3ogsdWBhmqhif3ogs8l68; Fri, 16 Aug 2024 20:44:58 +0000
X-Authority-Analysis: v=2.4 cv=NdEt1HD4 c=1 sm=1 tr=0 ts=66bfba4a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8
 a=dMa8K_NYSMvRJTca4hgA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GHlsHH8KZhX4WinjSa7N+Lbm/VjM/IFlrjYyrlMyRMU=; b=kERu4hm+sd+T1lmSJ4RQvz2Qw1
	+mJXGMf1RtntWeBFnqubS0tBZvIeuvCd3QNMDdQoO/C9IVUItgnVGdgVqb5tT15/7khF0UYSjlD6k
	G5deIXnTbBNt6+cIhyiR65VWh5mRqijmIVzaWhFz315dAMUGuFXblsdrQnt7bQFTvy9ONUuWO+ac4
	xZKTLOCknQt8pbV5aGPDDT3dqXIJjObLtT3DlLYGqBcEysdSw1D2lpkE4HU0w+aRg8q+wLyTuWvt2
	0Att4gmT4oXMwBg7P1T2GkiO6YaXnWf0MOdGUJsnv3f8DSKc8YsR95oNWiTNA+A2klV4r1aMXxHiq
	62tFmVpg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:35224 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sf3oc-000AtD-03;
	Fri, 16 Aug 2024 14:44:54 -0600
Subject: Re: [PATCH 6.1 00/38] 6.1.106-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240815131832.944273699@linuxfoundation.org>
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <bb711081-78a5-a8bd-3605-442db115b69d@w6rz.net>
Date: Fri, 16 Aug 2024 13:44:47 -0700
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
X-Exim-ID: 1sf3oc-000AtD-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:35224
X-Source-Auth: re@w6rz.net
X-Email-Count: 40
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH0Fs1RRI5iBfdEhTTSUXgKt0nXH1gxoYU5iBm1E3ksNLfWplp3JuJ/GuQ4d3rQYlFYeQa6EZ99mpDi8L2w4SdMTQTChMSQw3faeP2XPL4bWx0GkwI1f
 x6th3OSL+V86lEnAzVf/L3j82e/Hzg95BRIMqzhPFlN/xO8l0saKBzToedT5lbtgZd71+bOOv8p/Lw==

On 8/15/24 6:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.106 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.106-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


