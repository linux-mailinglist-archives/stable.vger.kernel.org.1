Return-Path: <stable+bounces-107796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC8FA037FC
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2185316183B
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A01D90DB;
	Tue,  7 Jan 2025 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="YKMIm+cv"
X-Original-To: stable@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718171E25F6
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736231587; cv=none; b=lTpZPkrpZz1FZHAuex+oi4WMD0cymKmW45nqxzEn17+gWj3yZusm7ighxrcFuxpcfQuVw3mOGVvLgpKB7luyzyWWU/ybCSLTWP9tbSviswaecVnNXnZAXYTiaEneHFDBhUx3xW+5YMCaSnU1cKjcDdpdDBOYisaAGt5peICR0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736231587; c=relaxed/simple;
	bh=EuZjJTRSoc79uXRgCn4RUYCQUllYWbxfD4aAeWLh/5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHlfkXkHI3sbaqUNddui6Lq01ix9qc4VyOaEFoUfDeMGKCtAjeviCHVGtAILJmymDIOy7OnxV335rZOmykE7FiiwjC03iwZbqhrDy0bR0ztSnViuzJh2H5hCi79XtRJPwE1jM5QhtOnO1z/PnJuALdoHe6y6mqrkR6HImsz5KbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=YKMIm+cv; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id Up7ktDYUtxoE1V38ntiyFo; Tue, 07 Jan 2025 06:32:37 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id V38mtylSqIQeVV38mtjcgK; Tue, 07 Jan 2025 06:32:36 +0000
X-Authority-Analysis: v=2.4 cv=cLYrsUeN c=1 sm=1 tr=0 ts=677cca84
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=1GQxe75yrw9fIeUcjpcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JEXHEDNlBvVdAWmkTAUDI99Icn9gkYhgsaZ7o1D7xHU=; b=YKMIm+cvr+bnsFKZav6k3shEBW
	q2d/jdDRM1DwgQX4KpJbE+XJRPBzylCP7c1epQXzOvMupg7QQVRR2p+6G0eBDryZFvh2z/CJ6l94c
	YLgHc5cYfiJjS4DmqMBkVcsvfeFoQmwUBmeSG/3N7na1aKhxdUtJd7WFQwNTYmoMk//rED3fP+kJy
	tN/tUGBfJ6uYDXUQiTsij1cnkPcXHzzQEcXtTp2TyYVxv18zEwHniUWH08VMncN4QwZanXqodWkFZ
	OOjvHqX3G3bcCCa03n1GqWHf4BFHBQVTsig2Dc7kjyp5IRm68zMJlSjp506GtHxsTznfkRpOrwnfr
	0X5dZpUg==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:50016 helo=[10.0.1.115])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1tV38k-002VFG-2f;
	Mon, 06 Jan 2025 23:32:34 -0700
Message-ID: <fc58a412-b154-4286-9097-4f3c5d7d97aa@w6rz.net>
Date: Mon, 6 Jan 2025 22:32:32 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/168] 5.15.176-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151138.451846855@linuxfoundation.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.223.253.157
X-Source-L: No
X-Exim-ID: 1tV38k-002VFG-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.115]) [73.223.253.157]:50016
X-Source-Auth: re@w6rz.net
X-Email-Count: 18
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCQJHoJf5bQlzeruyae2fzkwVQN4FSlD9g9c9QG0ejhM+HFi0beZk17L8LAgXbanG78SB5E+2/k7oQre7C00Wv5AhwS2JZBnC5XWdgH0ijPQLxop4M51
 Z/gLJP6JcMTtIv0pL+LmBzSA/8QgbJiZlSa0ITv2hEjonAYIFyRc/zowsp9ZQC6HlpiXPztitlZdaw==

On 1/6/25 07:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.176 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.176-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

On RISC-V, the build fails with:

In file included from mm/kfence/core.c:33:
./arch/riscv/include/asm/kfence.h: In function 'kfence_protect_page':
./arch/riscv/include/asm/kfence.h:59:9: error: implicit declaration of 
function 'local_flush_tlb_kernel_range'; did you mean 
'flush_tlb_kernel_range'? [-Werror=implicit-function-declaration]
    59 |         local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |         flush_tlb_kernel_range
In file included from mm/kfence/report.c:20:
./arch/riscv/include/asm/kfence.h: In function 'kfence_protect_page':
./arch/riscv/include/asm/kfence.h:59:9: error: implicit declaration of 
function 'local_flush_tlb_kernel_range'; did you mean 
'flush_tlb_kernel_range'? [-Werror=implicit-function-declaration]
    59 |         local_flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
       |         flush_tlb_kernel_range

This is caused by commit d28e50e231ce20a9b9cad9edce139ac775421ce5 riscv: 
Fix IPIs usage in kfence_protect_page().

The function local_flush_tlb_kernel_range() doesn't exist for RISC-V in 
5.15.x and doesn't appear until much later in 6.8-rc1. So probably best 
to drop this patch.


