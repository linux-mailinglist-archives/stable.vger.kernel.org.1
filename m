Return-Path: <stable+bounces-78210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D129893D0
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 10:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD17F1F230C2
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 08:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080EA13B5B6;
	Sun, 29 Sep 2024 08:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="GdQFGbM+"
X-Original-To: stable@vger.kernel.org
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E096613B5A0
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727599419; cv=none; b=AYPRF9q+mwdbPHIEmcS0N0aTGCO5cnYeO4VNlS7m+Z8a+LCwA+sGNRkfhGzlauKzjLkuvB6CT46PA1fwZ+3D4yQCApTEK1Gawo5yPLsLgz0G9eohTLE8ErKAUn/M7kQ1z8usvwK65CnzgNQpikxAEoMjLE4juq0474tixgjt148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727599419; c=relaxed/simple;
	bh=T19KQz2/tTECmsi+5N/bBijXJzba822WCfvlRud2QjU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=UfVAmINB/NFfKZIsT3BcRZfbGncxDrDJWLgF+tib56n0sdT8V/SENMpAas3v6QcyBQQ/tWgdB+aBh2xn3b9D1gZXJWY8LNkfXOZcdMzl9s5QGakFHDV1a8XpgonvZXGEpckeUDMOE7mxG6uAzMwg0C6B0a3H4Y8lQm8qWW1krAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=GdQFGbM+; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id uVXBsMyC7umtXupWcsTU65; Sun, 29 Sep 2024 08:43:31 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id upWcs6cE13nDKupWcs2UCq; Sun, 29 Sep 2024 08:43:30 +0000
X-Authority-Analysis: v=2.4 cv=T6iKTeKQ c=1 sm=1 tr=0 ts=66f91332
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PeMHkyFFRZyyPOSMFU2k1WM65T2JKiwqNKpCmYj1jqA=; b=GdQFGbM+R61tslx17hD3031fUZ
	xjkEINEhnsTZFYEoM2R9JazkE1p2h1mq53QW0QyHXv7U90VqF34YND/hv9BU9VlmkdkKvH/Thoa2g
	Mn1RZovERGasEbfqjKqFq0Pl/JPFkG6yvFfq3mTVGKhFSHUfxDXVlHRuUGE06aqftvYodiT0HAiP4
	y8NqFAR95OtHKJG/0zSbCs2HHlPfLI6ikKFFoPtUmYBA41ZMGAQkLcgZOX3VLcbMo0ustgV94p+0V
	4Ceb94PnqX0bVY8qVq4quEeIGxNH3PUQb0gVCA8X66kjl60EOGX39Gnb6CQCLSid7i/XpdzGoqTSe
	1s6r7SdA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:43258 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1supWa-003szQ-0d;
	Sun, 29 Sep 2024 02:43:28 -0600
Subject: Re: [PATCH 6.1 00/73] 6.1.112-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240927121719.897851549@linuxfoundation.org>
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <b8dc892a-7b23-eb3d-f016-9494f2b902b2@w6rz.net>
Date: Sun, 29 Sep 2024 01:43:25 -0700
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
X-Exim-ID: 1supWa-003szQ-0d
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:43258
X-Source-Auth: re@w6rz.net
X-Email-Count: 59
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHFrOPtmferERNHNdALOiDJOh2YpqMhKswJTfQaSSf85Ptp1MJXCZ9AEIEsN3SLc4789DibNJEhqQEKjsbGSokODvKBXl5ZNvRTh8K/+7We3JPVloFo9
 MReiJY0Wa1DCfNAMiv7/5PP2/W1zPZ3nYiirTqgFDBJr6D0U2IGdoOsLoKFN3F13FRvYnC+dG2uYfw==

On 9/27/24 5:23 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.112 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.112-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


