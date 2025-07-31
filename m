Return-Path: <stable+bounces-165633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA12B16DA8
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 10:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D85DD7B35E6
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 08:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B6529E108;
	Thu, 31 Jul 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="0vA0tvCc"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D57EC13D
	for <stable@vger.kernel.org>; Thu, 31 Jul 2025 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753951029; cv=none; b=tnwKn59inhUda0bNpsQAt0vHpdnUsU2m5W6xs0/CVnPtgWVlnK/22elwaILwUs2lzoYuQAymDoeR1CAcmZh26wt8ISuH9lj2zoDNai13BwZaN/nmL2DdTWfma7ncrkXRhGlstlLxAopbug+EWBQgyYi/HLsaTmS82iUUMYl1FeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753951029; c=relaxed/simple;
	bh=d6vv6eakRyIvuGiDTGqAt739nwa+GVzji5Ne7c0xBtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6fxYawK3teGz7shREBSj0niR1w7mKHIKpJchkRMwFF4XxXzZAIfHoo4BT1lV16gDAGnqC3BCTcLABhogqbccb2h2siXHXab4f0UOulm/Yjp0m+9gMevqiPp9O7H5YcKahiyv+UTt5d48cYJ2bGsYGTm9VVljVRXX+q8j8FTSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=0vA0tvCc; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id hDg3uxLq4JLhFhOmYuQZFo; Thu, 31 Jul 2025 08:36:58 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id hOmXu6hykb6dmhOmXu3dj9; Thu, 31 Jul 2025 08:36:57 +0000
X-Authority-Analysis: v=2.4 cv=bs9MBFai c=1 sm=1 tr=0 ts=688b2b29
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=v0eEEZAoNUg_BbrKGCsA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tc+flYPvwVIjvmZiDyrWijlUd6u0n/v8BfGnNJ0OMJ8=; b=0vA0tvCceErZnzHg2aG1u0rtCk
	NIdiTGLrUNSbCoi/YXZO1UEBVDMvYaacHdDTUm8WcLsKdyN2siu5vJmIarzIqy2Ggf8t0PfFoVFNb
	fMJtIP6a8Ghmx+Qtk+XH2Cy9+j9/liOFi+9FewmM+J1e6DbLArp80LV1VUNgEc0wKgwoGcThEgJga
	48QPa7YvBIZVoRulnLydohK63Xg0jW7xWlw7Zr3Ys5+CcnncbE7OBVSjW+MajymfGEoE2LSpCuyfs
	TD/ArQwJK/P7bPCdXJBV8BTva09wi65PTRtsmLp1VaQ1JvNi4hTt2TsIBO3X1ZBpj4+p/4giuHiJb
	5WEdaMPQ==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:42876 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uhOmW-00000001Xok-0m5L;
	Thu, 31 Jul 2025 02:36:56 -0600
Message-ID: <41fdee77-7652-4310-ba4f-2ff56ec6fec5@w6rz.net>
Date: Thu, 31 Jul 2025 01:36:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250730093230.629234025@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>
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
X-Exim-ID: 1uhOmW-00000001Xok-0m5L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:42876
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ3BfBZi508RdvXQgbqY1cr75ZxKv44DBe5FlT9Ftv/K+yZJ2GMttKdp2IFz4Tl5gyjC1EryjGZPNn1Y0UmUHjKk1ysmviy3wYGe+RalspxVqscfVw44
 OxYgCTXm+JNS5VvBPgO6y4c6Nn8jmHjVilwAOZ6kYaYKPwsU5Rbqf0oyPzICam/M872aIvFdhjsIIA==

On 7/30/25 02:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


