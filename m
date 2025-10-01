Return-Path: <stable+bounces-182891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FCFBAF0D4
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 05:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF09517DE49
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 03:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F427B331;
	Wed,  1 Oct 2025 03:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="F68qHZMu"
X-Original-To: stable@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C441A4F3C
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 03:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287858; cv=none; b=kUCtZs1/YCnius6V2rEdmhm43VsMzq+iUyOSK3/9h8Z96CTTeCS5cXmduWNWtbmy51ljiWgZmjMsCvpGYff+FxsoZZ8wFaNMwuArjL6Dz5yIpcSBxbhtjnienx3LhH6soOQpPZxDC02wiiXlBRoW0A0+FDYREIszTgtNUivfxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287858; c=relaxed/simple;
	bh=ifdEVCSmfeq6YiF1BSc/ORyDHXWpxmZAePTywu7Uxck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XULUZRISJhZipTfXQtwS5i1bnyS+4A8fg7DukMHsivR4Y3Gr+bMtdxEyK2Z5yZCb9ZsfCRIgaDW3BaYZa8kNL8GtkRtiAS6QIro4GbWu6FykJbaqdt9pUVj2jjG7XhMqFJ07bieTquMrHQwvP/sAzr34GN/s9HxpzDm40naREeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=F68qHZMu; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id 3gW5vKcRzv7243n8Zvoe1x; Wed, 01 Oct 2025 03:04:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 3n8ZvjRBPwoI23n8ZvnLPS; Wed, 01 Oct 2025 03:04:15 +0000
X-Authority-Analysis: v=2.4 cv=PZX/hjhd c=1 sm=1 tr=0 ts=68dc9a2f
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=De7t3naRBfxtA5xB3EgA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5PkxsPutvdKk2z/ipz7uZ5LYOkOuVqmY2FwGjozjSPA=; b=F68qHZMuPb6XM3BqD3rCaBvyUx
	8OxIURUjig2WoNEOk7phipOZOltY4QDJNEiKGLajB1eDdjlVfP1Us8CKBTaSpMuPmpoqUBdMkNE3n
	Dzw9kRQKB2cFAPtTnnpl7kq/t2GdsKXXtF8gnEneqCibAVOSkrjjXAz3dgYPZ+hK4OLx2Y5B1Q+Ms
	B33892QoZmXTqUfgyUOd4budcmXnfWE6vG9zlX449qr+N/yVqWMIAFQ9ftXmTzITUUvps4r6TcWx7
	cEeP3dAcyHRSqwNF9c8qaP4cXEQ7BYNgoHhUV5EdOLqzlqegwEPIjBZ+su+DRPR471R0EI3lULikz
	c4+tdI8w==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:57704 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v3n8W-00000000bhO-2S43;
	Tue, 30 Sep 2025 21:04:12 -0600
Message-ID: <63cc4202-5114-4e9d-bb1f-1f138ef434f7@w6rz.net>
Date: Tue, 30 Sep 2025 20:04:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143820.537407601@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
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
X-Exim-ID: 1v3n8W-00000000bhO-2S43
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:57704
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCW7/GBHvkRCcCSGzDFIo2hk/GnLB/2C6DMD4AWq4dynqaRiMUQfeHWw8z4TP57H7jKlYKy1ZpAOT0u685K5RwOMJWcqt0ehChI7wM7KGhz/IZE0bgxk
 65YXNhv0UA0dqM+xvzEySSvC7raJyE64qq3UNMU1Ybnnh1eduQLjZXd9xgZG93a0d7HelsciPKsRPA==

On 9/30/25 07:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


