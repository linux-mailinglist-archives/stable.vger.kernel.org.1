Return-Path: <stable+bounces-57987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31927926A1C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 23:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C161C21CC2
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30349636;
	Wed,  3 Jul 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="oVWseWuc"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41B2BB13
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041439; cv=none; b=gJ6uyRTIABai1kklOy/Nwv1aKFPo/cbndpwp4fILr2byt8q80YQ0HHdCcZp4FNL9NudqMn+hFXpW2OXA3FZgnpZC5C18F+7GmGEvYhL5evJqo5hlhaoP2maTLIulCHxbSfpjgOr0cFL05/x4HqZtjtM9VpTRt9Uu0SAnCXP0Wcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041439; c=relaxed/simple;
	bh=TWW3SGJsCiTIz2xw42rW7CKAEZKD6ab6eH1iE6g0NnY=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=WWQQNIrhz0wrjgGmXz0SRMmAC7Y66Xqzypcpm9duR5uDJJCmMDvN72BIHH1lwDe0f04T3FPm4hOiU+jz9niXru043CC0W43CSW2nMvY+HyTttgM49++7BhaQy6wIhsajy0bG3WYJZizTD2oAQwH39/h3KARrVroJszpEvsTkQxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=oVWseWuc; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id Ojo9sdj4mJXoqP7LjsL8E1; Wed, 03 Jul 2024 21:17:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id P7LhsJMSzB0eBP7Lhs5X4R; Wed, 03 Jul 2024 21:17:10 +0000
X-Authority-Analysis: v=2.4 cv=Z9gnH2RA c=1 sm=1 tr=0 ts=6685bfd6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=dM-kR4knkKEf_V6v5WMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=szdH6T5/4CdM5uYttbRQkvj8JnJmXn3XncbuNhEck+k=; b=oVWseWuczjl79XAlGr2CYrM93P
	kkPXIJKmF9eQd+1O302jptzdxlRui8c/W9vGFNjE5VQE+9ur52Z2pBHpgIIFTJXE3qwTKvs1Lhh81
	Zq93aOVxPpExwuDq/koMgd04eDGSHTzVRn3F2FZUcZWZboMtWmxFLtRjHHtXCdj0DEMYPeWhd0Eny
	1A0PnzmuYODVdUrGRMiLvg7SCRJ3xNDsGfAa7M45QIXAjAYrRJet9Ogt1bUhfoAmcEtpSq+4eg0bt
	dnEr1YkPz8BV/Q3UOD2yMLQeOkrlZreFy1uPEINhnc4oavPK2Tc041H9sX2254PA/bGjowwAaCa/B
	3KhVOgwA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:46974 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1sP7Lc-003b7H-1t;
	Wed, 03 Jul 2024 15:17:04 -0600
Subject: Re: [PATCH 6.6 000/163] 6.6.37-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240702170233.048122282@linuxfoundation.org>
In-Reply-To: <20240702170233.048122282@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <323a73ba-6cc6-45a1-e15f-9b08b6293c3f@w6rz.net>
Date: Wed, 3 Jul 2024 14:16:58 -0700
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
X-Exim-ID: 1sP7Lc-003b7H-1t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.47]) [73.223.253.157]:46974
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDvHZFdTeeTmgtB+29FDzQGoBMPJRU/yAt/95q3oTAO7aaua2sj9EdgnsUVdmShGmh4dsK8f5hdpeAWOBVK30eVaupGySOSAIG979sW/EEJQ+m2R72LA
 dablY426Y+RquT3ISZXHEkOshIdYGVglNMtZs9HGKbz30dN1se5kbt3qUGezdV4cQDEql/5TCAkIiA==

On 7/2/24 10:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.37 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.37-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


