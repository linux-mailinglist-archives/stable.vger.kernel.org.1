Return-Path: <stable+bounces-179031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32E7B4A1A1
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 07:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795644E6112
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 05:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3657D2FCBF9;
	Tue,  9 Sep 2025 05:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="TnNuZYna"
X-Original-To: stable@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA283257828
	for <stable@vger.kernel.org>; Tue,  9 Sep 2025 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397223; cv=none; b=RAw+lpPm2rZlPbAvnVcnsr3qCGqzLBaDv+3zqef0+JXVqpb4AcoGr8HNlwMcIAQCicUuiEaWp7wLwqb1Oj8qlHcGGOFx6myhb10DBd9QDytZUl5vQ9IL3JfKAPQ9d4OmD7I9hoLQli4r6eh2ZthYf0J76oFygHGdvQDROc1uZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397223; c=relaxed/simple;
	bh=qUtna0PyyH9rwBG66LiA94B2PnwwVPbPFDc3m6NUHac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ1gH1hC7/I/yyP1fkTm07ey7+Tu4pN01c5K+wulvXVK+Bfa/60VA73vUIv0r2CFaozSuvCQe3ukF93AlTxmhs6K0gw5bk4d/h/N9AGwyB1KWVfV2YUxOrySFkojF8pPNDPpA3TK575RbW5hfWDEHSKbbHijeaaZylngiZ0ENw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=TnNuZYna; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id ve9fu3pYGLIlMvrITuPUoL; Tue, 09 Sep 2025 05:53:41 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id vrISu4jwgcGiCvrISuPGl9; Tue, 09 Sep 2025 05:53:40 +0000
X-Authority-Analysis: v=2.4 cv=V8590fni c=1 sm=1 tr=0 ts=68bfc0e5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GwxR6IbGldVJlwKqBdAY14bWiXLRyUljxF73BTLNTyA=; b=TnNuZYnaZHCPmEw9vw8wFZbztt
	1zmZZdKaCHqIv1Q2N8RFTimKkIhS1VReyzvklqjb85cGbOyclPxJjl/hTF2blBdw7Fye3WYCpzV2g
	UGtg40e9oh1FpcMnN//ebuHiRR7JiZH2k0JIxwk3laaIR4R6JYyGantGE1TW79+2ptu2bA6UVcK8j
	UeKDUWN868GzIsfywRplAklrg15g+tQAxBGbPdcAZKxwCU693W5MIL+kuxjl2ZPa0DX/ApCd5B8VT
	66Jub+N00anEaX3guT1xaIlYhAvv4g8SUxeGPv8+RK3bL+QJXyrsXJPK/RHVu+phQl9JCV8T4C5W9
	QeHsGo/Q==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:55018 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uvrIR-00000001mdn-2qR3;
	Mon, 08 Sep 2025 23:53:39 -0600
Message-ID: <3f9c3683-60ee-4532-a6ff-b45572d6bc06@w6rz.net>
Date: Mon, 8 Sep 2025 22:53:37 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/175] 6.12.46-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250907195614.892725141@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
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
X-Exim-ID: 1uvrIR-00000001mdn-2qR3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:55018
X-Source-Auth: re@w6rz.net
X-Email-Count: 39
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHJMtr1/fmTQnqFVbr8ovdU8Alae+tEy3CQ/9uBdF+tQ2VCKdSSue/RwFVq++PeJO2BUrBtczbqFAlmQ7FctxEdXexoNXybPQH0le7JrKQOuVCwH95Sd
 x0LxbH8RjEiQc37SWKoBQHQBJeQFs+NLPWFQoyE6eIrRG+0N6fvi9M1D5yWkABIdlXPZeQcwQu7jmA==

On 9/7/25 12:56, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.46 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>


