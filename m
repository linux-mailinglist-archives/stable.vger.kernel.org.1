Return-Path: <stable+bounces-163114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211AB073F7
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 12:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46B817B956
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 10:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B762F365C;
	Wed, 16 Jul 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="oYu7SUfM"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0C22F3640
	for <stable@vger.kernel.org>; Wed, 16 Jul 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752663047; cv=none; b=rFMLKv2TN1x8bgBR/2ep02nWTSu7wfAwNPoVI8ItZBiFyXPxQdiNq6J0L7noeZQcNFGUMsXPpx5fPcw0+LK6UvxGf76B0J9Zt1BS5mgmR9juQt0QN+yhgGc7WPjfwFEI9tgYhv9YpYnmR31fn8zRa43nmk1hnMCRO6LI/ivFWBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752663047; c=relaxed/simple;
	bh=b49Cun0UIi/X2wvmkqoMW71Ecfzv0WUit1rUd6cd/zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUI/ci9m0Rl7dLGFEFtrFStaov0UK+sa+KJLwAIkDPZ5anguX6UW2Z3rCtbMGULdseiMEA09DVPeJtZ5jG11kMJZVHXhxktQ86HNYDBjcvH8pd4s97FyZpxqJNF1mtDQPwSihn/xZmB0FYv2UL6a2tFeVcr6/qcht4ZwFKCkb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=oYu7SUfM; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id bp67u3feAiuzSbziguiFLl; Wed, 16 Jul 2025 10:50:38 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id bzifuH3G7lLZybzifuuQAJ; Wed, 16 Jul 2025 10:50:37 +0000
X-Authority-Analysis: v=2.4 cv=bNXdI++Z c=1 sm=1 tr=0 ts=687783fd
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=QHUtQvI2Ve2vEipCl2YA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0gSRGIRmUA1jhOfMMNyErZgXS0KWs37oIPa/xGC0LzA=; b=oYu7SUfMNATZ6oLSvcKJzSoMKN
	FUh3mqOFj/pzsVha09Dof/wpyDtRfTZSkvomkqaVMjyeXoB2/4zzNHQsnehiIg0vbyJta1ABhKYa8
	XqU0PhA7OXHPQa8Mod9sa9DKCtaMiV/8fb5ZI+Z8sbG1q4/ObjhZ2hhtkpsNGkW6jcZtk4UrBJ5GE
	Qc6ysLGpGjpZRIhb5pVFodsqXOGCcpOq9f5tYjme6fA8HnyB4Ga0oWkvpoTKiOzZVXqfaJGHGA33q
	rZd+TSg2zho/KIjGevRBRBV7pV7nAaG0L8YPiGsCehSBbMXhy7xapFC8hH8aGTV4GGMUgNNCJhvt3
	BJhfqnxg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:59720 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1ubzie-00000002NLO-0K8v;
	Wed, 16 Jul 2025 04:50:36 -0600
Message-ID: <7bbc85e6-8967-4c58-8aac-403dea30200a@w6rz.net>
Date: Wed, 16 Jul 2025 03:50:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250715130814.854109770@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
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
X-Exim-ID: 1ubzie-00000002NLO-0K8v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:59720
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOPbBdrMJKWHbtIkfWO6xIVMlY8WS1pXxH/7ud+knPD4sU8R+ZwE/76ak+U8XJVUu6SeHe1rbfpN84m55omWenfZ/PyC6nSUnwgJFK9oDgy4EYWwsNzM
 p/ALKfzwn7Uw+SnGdtE7EItt5Y5GdqR+8BlxfCOltOmSPtEnfTIgODGu3K27ChSxjGnY1CSa98fPXg==

On 7/15/25 06:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


