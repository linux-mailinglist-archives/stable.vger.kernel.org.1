Return-Path: <stable+bounces-165635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24CCB16DF5
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 10:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3EA173D1B
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085AB21FF4D;
	Thu, 31 Jul 2025 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="RJCMEmVL"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE331482F5
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952105; cv=none; b=M6BniwtBE0c4AOLBmKnl8GxWj9nEB0u5wfnTYeHjJL3vtCdXBwSpg8hjF4vldkvOxaKZzqByFftpxdUABQ6t1EWNnmDlYHfxtYres5xIfb3gtIUIfAIVEbL3jsTvT7uVtWAQ+3U3kyLVj2z9WqMCvUoI2MBh82hProShVwzVj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952105; c=relaxed/simple;
	bh=W6U4dfBtts+FrNvWGW5UzWBXKxhXVVugXX9ysPsKdjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcVYs4uWn2ovxHbJbXQxdhI0Lgg3v8rT2PA/h6P9IL/uCvmZFlSlSAE/3vu+YWZFQyrBKcKRxdBesWsk6enLq2exH7nA8iHnFTd41//k0ZonbolN1hLOXK6f91oU1RdjlQeLoIutkvpBBJQm73XiT5Kiq6Z49W+i83DHnfwwcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=RJCMEmVL; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id hOCsuclfAuKaFhP43uyosy; Thu, 31 Jul 2025 08:55:03 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hP42uMZN7WvdBhP42ueqUV; Thu, 31 Jul 2025 08:55:02 +0000
X-Authority-Analysis: v=2.4 cv=cZfSrmDM c=1 sm=1 tr=0 ts=688b2f67
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=uL6TWLxzTrU8urRFV_wA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MEA4PprllVQlX0/iTZHjQ8U/qojmqMhkuvlaE9aph9s=; b=RJCMEmVLD/6ONTDxKyYeouK8ne
	/convlGjMbT98gajeblGye7mN84q+gV076xWGvRRnlihdDfQVbwIj2MCV/P2yYLe0BlYrfAmpevIZ
	I3bF80ERIjto5M0QCU14IwVl4i1REW5WI50KE67imzqFOqvQLiCOMrrTKT8hMHgKZI61VQ4zX9jb/
	UwheizA8jmzloyWzH9jBLAxyw52+WLSRjMQLqpcnCzrM4LWhpWDQ8jehKW2ZUzWTYnw5DxMuas0PT
	uRuGpk0WvmO5C6OtHn62hRtN8KnELwQ7PsHoGnB0YDu6u1eDDVVk+LIZSTIhBAeS4cXdoNxmnpb+a
	Exu9Z6vg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:40718 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uhP41-00000001eH4-0eH6;
	Thu, 31 Jul 2025 02:55:01 -0600
Message-ID: <b7644932-41c7-4b1d-9a8e-9408cbe9c1f0@w6rz.net>
Date: Thu, 31 Jul 2025 01:54:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250730093226.854413920@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
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
X-Exim-ID: 1uhP41-00000001eH4-0eH6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:40718
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfINEFPAi2wmh0xB49cpZMJ4xEaWjhcYl3WNCsK310jRyqvrRt8SxdfSUeBwY53FA2ne9gnk90eQQLne9HU6n17PC+KgIa2k/CChpkNtIZMYPxT+NZ0X9
 VnKTSwIY67mBDFEFE5qet107uxUeJBriyTjJKa31kCvuFCToVk0GSmWz6vWeUCi++6dF98VOFWYf+Q==

On 7/30/25 02:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.101 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.101-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


