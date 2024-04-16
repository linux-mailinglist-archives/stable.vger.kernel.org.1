Return-Path: <stable+bounces-39987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3208A63BE
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 08:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A75280F48
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460D3BBFE;
	Tue, 16 Apr 2024 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="zSsyc32r"
X-Original-To: stable@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421B339A0
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248911; cv=none; b=p+LvWcKI7ZU9KJvuRt701QfHCkiR2oozETVyMh22hcxQRnHWf/FYQLzl1rERqzRqxH0jJKn/yNGZPC780yolIRgsG6a6+ncW6iXD5AowNuY3FaqBctuFjlKdp6BcSm/sy2lHO2ATnm9nadICp0fDM+x4JizZatB6Y/yRDz25xl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248911; c=relaxed/simple;
	bh=HkZd0zzaKJyyw0jX8UVziNvY59dzsIqRa436sqbNJbU=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=rYw0jUD02BONTk65oamx6/Hc12ZFxGaGvuP+dynuAkiKnY+HLQmZD7DgPzrdF0k0iL1OIoFLFgzLPT037Wc2cwd6GCbVAxxE0+k5HwBKA2BSeWu7pHn2ZrRMJAASkSemHktOrRcbuFQZi/BkHehcDRIWnr9m8UqRhAQMtW6tN7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=zSsyc32r; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id wCFir3bRytf2QwcHNrBlqG; Tue, 16 Apr 2024 06:26:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id wcHMrv9rKr1IfwcHMrYdkf; Tue, 16 Apr 2024 06:26:53 +0000
X-Authority-Analysis: v=2.4 cv=BawT0at2 c=1 sm=1 tr=0 ts=661e1a2d
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=raytVjVEu-sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zFQ1NTMnyQPBoKTIcPSeqB0n91BpF8u3lomtPBYB4To=; b=zSsyc32rqxcAWInddI/rZL1HQQ
	rhKnTBoQbjntSqRSt+cNiKClttwFSrtRimUqiSoDZQ6OtXGYTdftjztz8xFzBQpEnX4ExatQcP8rR
	8iezclHCQynBA/joXEUUx9pcaOHO++PfcjWQB2jfBrLrn+EgpWw3De1Axu7mGqX5PCD20S7LhEoTX
	2gQ++w15xtCP42G/WZ/PNwU6F1ABTB0qHlLKMTvX9ztqig746kygx84DBclsNa1fq2LQIl3sM4CPx
	xbvPYYzkysU7McoShlize3ejoxHxu334VymchYsQHRAHNUhpqC7skknDIX0/PkI1GeaI5jPzOJF2k
	84LdEhAg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:57900 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rwcHK-0029YN-0i;
	Tue, 16 Apr 2024 00:26:50 -0600
Subject: Re: [PATCH 6.6 000/122] 6.6.28-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240415141953.365222063@linuxfoundation.org>
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
From: Ron Economos <re@w6rz.net>
Message-ID: <be538464-58a7-8a98-d8ed-58ebc4c0b426@w6rz.net>
Date: Mon, 15 Apr 2024 23:26:47 -0700
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rwcHK-0029YN-0i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:57900
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfI1UQqT37HJLWplCUQMnvSg3VCIW4XjwmAx774bYI9Z4J5/PL3TCfGgQPB4b6vfWAfsuatk+RzG5w3hIDgmHUm3bKgcubaQ1lTWUeYuGZMVZqkOii7/C
 eImwb58IBvH8UMQEu8mEgS9UD4MH+hi34va0A1PG+eiJmt0uIxVTgXYdYhJcFOMpZ0HoYgM7aATuEw==

On 4/15/24 7:19 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.28 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.28-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


