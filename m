Return-Path: <stable+bounces-116364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E374A35708
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 07:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 146007A635C
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152A189F57;
	Fri, 14 Feb 2025 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="NAc2NFl9"
X-Original-To: stable@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053A188CD8
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 06:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514346; cv=none; b=QboUnVyhvkROtvtsKPTnZgb9xqtfnYkOTs1HNoKuP8vKdn/M1RJda4sI5IoSu0lWKK6+yj+Ei+G9u9WLMTz5pcNodMvff+0+L7aewrIXsdkH8SxLzMNsUme2DFEtOTQ7UTphrsyRx22ENd8DzlUhWyKnty/jCpo0QXNfmNRnC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514346; c=relaxed/simple;
	bh=+NE6MU5T3q/y4ouBVcZwZAIkaVZ6laDjR94bKZxqX6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJj2K/uPa/4aIS8EiUvfvDdNbPq48AG9+WMJn1d8lANryJKMxfzpuruHqTOa0nf8LKSD3ROrgS90XiOq6E4X6tRZIe8/0iRQVnBlWiPaSsE8EzZMyOD+ONHg/+ugNvmtH+uUFaqvZ8tkMBukLKdkMZ9wPHLUaDcHCOytDtqNe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=NAc2NFl9; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id if4AtQBI9Xshwip8rtMh3l; Fri, 14 Feb 2025 06:25:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id ip8qtxTF8U1C7ip8qtdyDW; Fri, 14 Feb 2025 06:25:37 +0000
X-Authority-Analysis: v=2.4 cv=d/3zywjE c=1 sm=1 tr=0 ts=67aee1e1
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4041MwwcWqwrnTXoSgMA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kBZdlEL6DkXfhqaE1RgKQhsevj+7d3qHVeAgZe3tFfk=; b=NAc2NFl95mbZKaEw4CN2Jx9R36
	Yt6WctUWyd+lFvYBLYOsSHaQJHl0VyaVi80P0STTAjnssPh4OgkSsUSqMFtCyzmT6+cc1AbUeESSA
	Z6HNRykiEZmQ8PRqsflTfg1IDs4S3hXV3sNkaQSlDaRiNbk1NLWSDuV+6obHp/9PrfhllzMCCMO+b
	VJx3o7PLT5++qGxAmLpRGMB3twJPuyAWcnMzuNCV3PlMpZA2HEr8P6OVmcARsEkKAK3d/J34Ua4DQ
	87e1ekXWRKNPS96G9lO54Nb8r9Elwi3qhDYKsFgagy2+GyfVeorVCl75FVBd9TgsazQAyAg0ZPYMR
	mcWPpI1A==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59466 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tip8o-003lKb-1k;
	Thu, 13 Feb 2025 23:25:34 -0700
Message-ID: <d5a6675a-f257-4f73-8000-226bea580880@w6rz.net>
Date: Thu, 13 Feb 2025 22:25:31 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/273] 6.6.78-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142407.354217048@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
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
X-Exim-ID: 1tip8o-003lKb-1k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59466
X-Source-Auth: re@w6rz.net
X-Email-Count: 56
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDFvUvg3Llf5wJU4V37anX6Z6KxT6G3WoJUJD1Dnz0gZsFuspj5saI2VkX9C6dnChdSKRYhCiyX6Z7JDHRdoqG2926A4SinJGHJqJDYGzK+Jtfj1MXkb
 r35M8KQQlu/OwoWdaiKdAzPxDqNCYyRxDtXco4IQDrCfLntvyGAhjwVpLzy+qMXlW6xiiA/YmCkLqA==

On 2/13/25 06:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.78 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


