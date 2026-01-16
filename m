Return-Path: <stable+bounces-210014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D792D2F212
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5D9D3004E11
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D381635CBD3;
	Fri, 16 Jan 2026 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="wA3nqvDT"
X-Original-To: stable@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FC2D97AB
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557425; cv=none; b=kJPWX5iSI6bGOsy2GvHs22Qn12l8BxVzUql1rcDf1f2oTl/SdXw1MPQ+FKlb3JSiygOFNXufvor03Y4uXL1i8e82rhdS/WH+zgAGuCrlBTVnWWHOcrFf2G14C541JwYsivDlHhsqA6SsDuM+uGw05vHZ2nVo2IAnuC5ntRpyHDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557425; c=relaxed/simple;
	bh=I4rDDMbLLa3iKeu7sFsJWr9blyUrVMtreTK0Aptvy18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSIHrd5K251SCLidwwlN7bVeJtg2PoKgsXWZDbWxxJ9+IxxeyWoEPi2PfKn4HDWLM4w+pdXRTjT5mgiiLk4sMu+JFOc5tN2lcuN2YdTtoHs3vWO1DLRf8QEtMc7ItSLbFHsjkAp+SHIWg9FVspDYu3ikvR5sKKIs7UEDBK+AIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=wA3nqvDT; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id gWmyvdBY2aPqLggZcv33I7; Fri, 16 Jan 2026 09:56:56 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ggZbv8xyESqlVggZbvhRCr; Fri, 16 Jan 2026 09:56:55 +0000
X-Authority-Analysis: v=2.4 cv=I7FlRMgg c=1 sm=1 tr=0 ts=696a0b67
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=yLgqrl2s3EH9fNXCsX4A:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jn3QOhAKMGOBGWIh9YgigVxZOXZhMygj+Rwv8s2YbBg=; b=wA3nqvDTp2NN/ukCOMwIc3eXl+
	XHTXOCow3MtpKk+dHdnCoDNjj7rQytV9ZNAzhWV3rJAHeZLYv3CVTmlgCiKc4ugDAXL5tCgO6nTak
	YOIwiKUkQZ8RikpVJyMMf4jLNehxyF9bvBUOIr5dBba/WoAx5aORPz9T4lCyPpyJaNlHuQZhACmAl
	ADtflPozI9WBkCfzFkLTMNcBZTJCvogwDpvKAdkfDw3u1QMtfiq9n9xQz2iHxnxuy247E7aWIXgtH
	m0G63sfwW1uF+mbp2l80FkDkRpSDlztCzQl76338nbTNmanpkBpLOZ4Mip8SEKMs3AUxEXKB6qeSl
	KDWhhWbw==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:39176 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vggZa-00000000AiF-3zzQ;
	Fri, 16 Jan 2026 02:56:54 -0700
Message-ID: <cd04dcb3-276d-411d-be15-9e39e59a7a78@w6rz.net>
Date: Fri, 16 Jan 2026 01:56:52 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/181] 6.18.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164202.305475649@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
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
X-Exim-ID: 1vggZa-00000000AiF-3zzQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.180]) [73.92.56.26]:39176
X-Source-Auth: re@w6rz.net
X-Email-Count: 19
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFK5+uP/iJ9VZCru1Lik1E8qD+EYHhjZrYFTTMG674OXEloBykfxGKg6jo8ghpIlXvso8H++JTnEF6p47TqUTdaLjIkfjPBOgi5BK9LFod5OfOPRHihF
 Oro3lD9Krajmw2yt53qrDOtMvL2ll8EjrJlVdLyFZY4p1B9CHt5rUhRUdCIZdJJNa/8c0VD1A+FbMg==

On 1/15/26 08:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.6 release.
> There are 181 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


