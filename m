Return-Path: <stable+bounces-142980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B704AB0AE0
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF8A4E7714
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFB426F44B;
	Fri,  9 May 2025 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="O+qHb0Oj"
X-Original-To: stable@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9B26E159
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746773306; cv=none; b=V9zIf4I/Rh2kTUsnZn/zpt2ShX4I2kZRrhHpPlT9FEhrMVxVVo6OOhELUc2Z0GD1lJFYoM2VE7lR4ZDxXHM/Vg6+dy3Pcvnlolmbzp2nTduqJD84N3PQESZR2hYgv2/4U8/Bc/UmysR4ww2VI1n/P2gliPLxdsoLbL/yt51tnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746773306; c=relaxed/simple;
	bh=yn9xBcJIkvuulzjXHCPzrcm6ZA9GQGZzmoakAakeE6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IREfrtrodAxqR8QzXqo6XubszLREgm/qklmzb7T78yGBKcnWZ7LDuTTGB2KoQ18IMLJWtAZFsOwNxYXDJ4H615xGF0M4K91LI5q0Oskm+Cd/NrUTqJLFN02vIu0hBBEJ2fXQZ+nivRuffahZFD3yHEHZWc+xRrl16k10buw++0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=O+qHb0Oj; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id CsL5u1hTBiuzSDHVPuV4J7; Fri, 09 May 2025 06:46:47 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id DHVOudxHYh9ZxDHVOuznAi; Fri, 09 May 2025 06:46:46 +0000
X-Authority-Analysis: v=2.4 cv=GODDEfNK c=1 sm=1 tr=0 ts=681da4d6
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=KKAkSRfTAAAA:8 a=AKSX7mR1OybJH3gAxqcA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=cvBusfyB2V15izCimMoJ:22 a=hTR6fmoedSdf3N0JiVF8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J9ggdA9LkxevrgZ2irblcZWwIVM7hufIgtrdO56sBKI=; b=O+qHb0OjM87a6f2E0916Swxh5D
	L/PrRnAd7W6TLcZNkm/VdIhveeeWKXHhk4mshGTHvmcWf9vP2tjBK1cklFZDZOn2tL5sBVv5zRqVY
	uakjMEdV3J9986F2t5xNLg1tEE+4fC4Hxbt9ghnux1f5bLP58oZmqljI3KIZvtVsrgAi5I+Rv6EtF
	/UgaLCoxw7KgS2QYhNYfvc9oqcNKw0pqOfeG8osQCln24d2R1kG7q9CAnguPdbCXwcEXct3i8f5DA
	qtCLyCgJ5LLLCAuuuJu0FItD2QIaWvUS4xF2Mr1NJF4CQZitmdRWcpQBVUSL1NkTDauxMvrEGQg68
	enqcsWZA==;
Received: from c-73-223-253-157.hsd1.ca.comcast.net ([73.223.253.157]:41802 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1uDHVM-00000002D6f-299I;
	Fri, 09 May 2025 00:46:44 -0600
Message-ID: <147b3e09-d588-48bb-96b8-ad1decd28105@w6rz.net>
Date: Thu, 8 May 2025 23:46:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/129] 6.6.90-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 linux-riscv <linux-riscv@lists.infradead.org>
References: <20250508112618.875786933@linuxfoundation.org>
 <CA+G9fYsKqxUExVW1rEhU8_5pYOuhkzXyeL9TmTyGVsV2-C-PFQ@mail.gmail.com>
 <2025050917-dismay-scary-7261@gregkh>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <2025050917-dismay-scary-7261@gregkh>
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
X-Exim-ID: 1uDHVM-00000002D6f-299I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-223-253-157.hsd1.ca.comcast.net ([10.0.1.116]) [73.223.253.157]:41802
X-Source-Auth: re@w6rz.net
X-Email-Count: 24
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNUhdxCr/QOhLGqxjHMSwm0rE3/tV1cxOonBOLRUepnLQHtZCN9iujDlSNsUlJ0D1fXSH5zoZZPv/Of2wMDKSDLDrpCJPaTg+ZbGvMmhRvFIKkQagjWq
 Fu99ngNZG3r0ngMYynqFIDQ4nruYSd4trM9Q3GwH/S0Evz0gH6/yzFBf3qA6fkUO3mUuTrtHoCvTeg==

On 5/8/25 23:19, Greg Kroah-Hartman wrote:
> On Thu, May 08, 2025 at 06:16:12PM +0530, Naresh Kamboju wrote:
>> On Thu, 8 May 2025 at 17:00, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> This is the start of the stable review cycle for the 6.6.90 release.
>>> There are 129 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sat, 10 May 2025 11:25:47 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.90-rc2.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>> Regressions on riscv with allyesconfig and allmodconfig builds failed with
>> clang-20 and gcc-13 toolchain on the stable-rc 6.6.90-rc1 and 6.6.90-rc2
>>
>> * riscv, build
>>    - clang-20-allmodconfig
>>    - gcc-13-allmodconfig
>>    - gcc-13-allyesconfig
>>
>> Regression Analysis:
>>   - New regression? Yes
>>   - Reproducibility? Yes
>>
>> Build regression: riscv uprobes.c unused variable 'start'
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> ## Build error riscv
>> arch/riscv/kernel/probes/uprobes.c: In function 'arch_uprobe_copy_ixol':
>> arch/riscv/kernel/probes/uprobes.c:170:23: error: unused variable
>> 'start' [-Werror=unused-variable]
>>    170 |         unsigned long start = (unsigned long)dst;
>>        |                       ^~~~~
>> cc1: all warnings being treated as errors
> Oh that's wierd.  riscv defines flush_icache_range() as "empty" so then
> this patch does nothing in these older kernels.  Ah, it's an inline
> function in newer kernel trees as well so that the build warning isn't
> there anymore.
>
> As this change feels odd for 6.6 and older kernels, AND it's causing
> build warnings, I'm just going to drop it and if the riscv maintainers
> really want it applied to these trees, will take a working backport from
> them.
>
> thanks,
>
> greg k-h

This is the same build failure from last week. There's a fixup patch 
"riscv: Replace function-like macro by static inline function" upstream 
commit 121f34341d396b666d8a90b24768b40e08ca0d61 that doesn't apply to 
6.6, 6.1 and 5.15.

You dropped the patch "riscv: uprobes: Add missing fence.i after 
building the XOL buffer" last week, but it snuck back in this week.


