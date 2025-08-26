Return-Path: <stable+bounces-176391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29338B36D92
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A31686D2A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1E2641FC;
	Tue, 26 Aug 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="TrHWMSmq"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EB263C8E;
	Tue, 26 Aug 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756221182; cv=none; b=b7QWdaZXV2RVBKF8MwAlxm8N8H8woIGV5Yb1NfMeOkD0xdt99UeyCXn1x0JSaHnrUzMGYbRqrOPDpKLs7Gy14wNHtiG2IKfFz8ELl+4XPO5gMrA2nkJd1CuXCPn+nMULrU/rt5D0wAWehSi3E4k71s1lkD1vGnBCEPOZuwHcX78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756221182; c=relaxed/simple;
	bh=HjxE+jvSemmztjLoeQ7Kor5bNdMkSH2bsJaT0LMpHpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXx5cIUfQM9Z3ckx+Jv/1QHehacAWH+s1nRBYPBBJe4X/ZW7iuHOBy65PVQR34ScAgDIRbC2MOKZ0RgHpYPhW9IhZ3qqu4x3shbqxhVMJcYW0JKQOPk1FXunka7A55a8SuoE9aMvfZrL1Uy82ZDaogpiq1p9tiuST7o7p/LahRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=TrHWMSmq; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1756221175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aicesAZaaVpnFhA0L0ibeFFVdIHLDSvHjGF2Ll7ru7E=;
	b=TrHWMSmqiV+s1hVsCIk5I5A5oFjT93mPLhDfiZ1ulNttqFIOWU9wB3Dnc2cNDs0GehgPVj
	Z2SzHEF7KbfG1TBg==
Message-ID: <fcbab36e-5812-4bbc-8080-4e48e35930e7@hardfalcon.net>
Date: Tue, 26 Aug 2025 17:12:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20250826110937.289866482@linuxfoundation.org>
 <ba879776-f2eb-4e5a-adea-07aad8929d6b@hardfalcon.net>
Content-Language: en-US, de-DE, en-US-large
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <ba879776-f2eb-4e5a-adea-07aad8929d6b@hardfalcon.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[2025-08-26 17:10] Pascal Ernster:
> [2025-08-26 13:04] Greg Kroah-Hartman:
>> This is the start of the stable review cycle for the 6.16.4 release.
>> There are 457 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.4-rc1.gz
>> or in the git tree and branch at:
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
>> and the diffstat can be found below.
> 
> 
> Hi Greg, 6.16.4-rc1 (6.16.3 + all patches from the stable queue from 24h ago) compiles fine for x86_64 using GCC 15.2.1+r22+gc4e96a094636 and binutils 2.45+r29+g2b2e51a31ec7, and the resulting kernel has been running without any discernible issues since roughly 00:00 UTC today on various physical machines of mine (Ivy Bridge, Haswell, Kaby Lake, Coffee Lake) and in a Zen 2 VM and a bunch of Kaby Lake VMs.
> 
> 
> Regards
> Pascal

Tested-by: Pascal Ernster <git@hardfalcon.net>

