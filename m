Return-Path: <stable+bounces-151871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E15AD110A
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 07:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12157A2985
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF519AD90;
	Sun,  8 Jun 2025 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="cKjYCzzc"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EF2224D6
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 05:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749361141; cv=none; b=RRSf6KaVE0RE/Cx3LD4caFuDVFxcy+rPHlvl4EwnJ6knuDJAAPkBQtcwBr2SjLDoI1psGubN7PLfCUuIij3OAO9oMvlkzKcPblNCr5NOGImoeMXOT7v6KTLJtC/wdljoIfS7jiayBNWv+6T04RabS6h8Ytu37G+PVIgllvLbZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749361141; c=relaxed/simple;
	bh=g5L7M65BVtn6YUhYH8zVe1Gt0I7xl3TF0fkn8aNJ57A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMnoo32UyckOM01zqFBXzeyMKauAI0DZtOd3vWqbfRCPsYNQNO0DCgxuMTbQcbjTVWsj3t4Q4kF515q3Y91gXPo2Az9zTOz0X2C3bzEjW8UnkPyrIRd2ssCVPQ+rb1Dy7weps8aYKhXSHQkdlYMAyDczgLY6oJ3MQVbhIWeKaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=cKjYCzzc; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id NrHRuHUpziuzSO8k8uYczK; Sun, 08 Jun 2025 05:38:52 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id O8k7uroargFaXO8k7u5Yed; Sun, 08 Jun 2025 05:38:52 +0000
X-Authority-Analysis: v=2.4 cv=DbzcqetW c=1 sm=1 tr=0 ts=684521ec
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kqdGiCBDTTx+KZJH3p+L4dXqH7I3Kl2/Mynql0kVhC4=; b=cKjYCzzcdr74e1+jSKshQj9cQ8
	9bGjN4JlmzUdN6BGcS0WKrB4sf8oh2BMtF+/bFbY82XYYdjb8rpYgMmd/Gfy0nwuNNmmGy8IseJf2
	iebbXBY2MX7yvMAxd+DH6W/CYMsTzcVysnk9349Wj/VHwjNPpDU1HVproACbd5UaU/D0rLeaxTIhq
	Bgn8myflwi5ojuVkqnipul4Pt0jJdPGzu9zOmqwuW8tMq+M64Ey/AMrnamm/UOVxERXG6u3/sxAFw
	HCaEwZOFvPHAZp1o6ejtPo2Q8FQVmUM8E8P6xyQpKBK8jZCc3q50LS/UVxX1FcOpF+KMy6YxyEZ3h
	StHp6m0w==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:37640 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uO8k5-00000003PTj-31xB;
	Sat, 07 Jun 2025 23:38:49 -0600
Message-ID: <c3f5e55a-353b-4802-9420-25b5ee48f625@w6rz.net>
Date: Sat, 7 Jun 2025 22:38:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250607100719.711372213@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
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
X-Exim-ID: 1uO8k5-00000003PTj-31xB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:37640
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNhm/YLzJMIV7yDXz+N7x3Nuhx+CtZN2x9DPJpuzBEhFKjQvGRNDbaiOntNJWNRvW8n3W7AWnVssybqg3K0FjUr1NTzq1CybZe5kCnAdRPH/WJ8pCMkW
 qhjmNASx4XYqTjOcHuNZW+flyRyfcD0SNBmMJ9hhuPGiussyATlRKOORcKN9XEKpiL/A6ytOuMJVgA==

On 6/7/25 03:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


