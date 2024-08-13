Return-Path: <stable+bounces-67412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE6894FBE2
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 04:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640641F221E5
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D7917C8B;
	Tue, 13 Aug 2024 02:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9KpWv21"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3FD134A0;
	Tue, 13 Aug 2024 02:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517085; cv=none; b=aSm7zL9yBCGHocIqCnK2couVDHwR0ED4+yPuI/9YoSR2E5lrPDwn4iOxMDXgDw3lumxc6Ok7ZACSEYS769s56mOcxHyzQr0tmu4V/gdbFBb+/uei2On6cuaiOHEaLNi4yRjynOFE3omIbRBpldUT2T/x9/HTTZHiuK0HGkgF/Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517085; c=relaxed/simple;
	bh=I60PlMyyWYDCRulAnP167ZdngqVH4sIvUMMzPdffoG8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=slf0zki/AH4UKyt6BPTxgaEKHXUIejlNsY2djxrClneD5t4n4h8rvppTQwfyCcvZpTIjAyAIj0wikXwlu1FBlhqO8/QmuNVZEzIyExCz+7KPkJIv6kZdM6v5JaFtLJ/1D2NgN3ZG9LsX6Xi39dsQT6TENZE/PTsIGVSdK1bRNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9KpWv21; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cfd1b25aaaso3295993a91.0;
        Mon, 12 Aug 2024 19:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723517083; x=1724121883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=U52DsLaem6jjNsHFTlfStPuMxV/uZKDUZCCAkkvTxzM=;
        b=R9KpWv21yXSkqOVDUyaPqiPusZ7EEg7aa+toZQx6Q6OP0Oui31TnFzfe+Zz2dkaQoS
         9Sbl134epkfYlxR4hQo23P+BAoxGCzmtVnQ5NtvTqcjquj1wzdzkTM452nTH/XGgyecR
         LPi4CkgVS2FBiuNCGIr72GTJWuzcVMzCJN5ynpeI8Wn9XDXN+NSHBE5B3F0fAhVWyCbD
         fDI2lKfpNn8Sapdt2iu2/zVU2DxVtfhbAZpG225yGefTjYzcRjO7cCyPoU6AbXZGy/EZ
         btVJoMWJpylTSxgM8eODN54mUV2jeva2IWTiPcBmsFPP+/NP9KxspTyeF08ulMgoBDft
         aYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723517083; x=1724121883;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U52DsLaem6jjNsHFTlfStPuMxV/uZKDUZCCAkkvTxzM=;
        b=jaZGFI+p2AzCqtegVBdill4cfs+E27D32Vsr32tlRyVCihX5qao+KrvMa4758PXjtC
         X23KMoaVt5XVGNews/rfEDzn9bF2l6dGCqgBm6cxep1Sy958wWfYqO+hD1fqtz+K1FCh
         rg5NIlMTzATOgvbm6VaI8XZ2J7NXV2eVjgKQrZpZhGe2kMxE8D7ocbaf1izKs7NI3Vts
         0PjmiAjxdSWaNjKGRbamFgyvajm5bFHIpDK1pTTdvD1ibibYP4/wkwbhp26mXlLGZy8u
         rizrjda/DFiofgkCUU6qq1QLdsssg1tIOzBqWYVnBYqymgtyscQ96TsAG/j7Ghr0G+q/
         JGYg==
X-Forwarded-Encrypted: i=1; AJvYcCVRhstuoU0Iq7GDEjq1YaP0Nzm02So5nr4i7FGpN3r1E0EnGmAC4I3QWiDAdT/EtabfZQ3em8JsQU6g5eHLGnBUxaefjx0TmiDCdZKUChq7nDq9FLzJZAlGNb62QPp1aFImmAxn
X-Gm-Message-State: AOJu0YyFc0rtG4uBjFdN2ywg1P+BO0nnqO+C3I8O3fSzNK7NkMG/xONK
	uv+FETVdqxif0D3/eyOloNTMGtbVxuCpaYzmoiBGB1Jv1QbJw9en
X-Google-Smtp-Source: AGHT+IGYt5LKODS00vdZHwC4eA1BWZLfBEbqIl3IJhkavTYXGxFwU/CLHs51coKHx23+zBw1wryCIA==
X-Received: by 2002:a17:90a:4922:b0:2c9:5a85:f8dd with SMTP id 98e67ed59e1d1-2d39253b110mr2473966a91.18.1723517082709;
        Mon, 12 Aug 2024 19:44:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce5624csm5898888a91.11.2024.08.12.19.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 19:44:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <58b977a4-5328-47d1-927b-625de75ebe0f@roeck-us.net>
Date: Mon, 12 Aug 2024 19:44:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org
References: <20240808091131.014292134@linuxfoundation.org>
 <c65c3c23-c945-4fad-9e39-6e229b979592@roeck-us.net>
Content-Language: en-US
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c65c3c23-c945-4fad-9e39-6e229b979592@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/12/24 14:49, Guenter Roeck wrote:
> Hi,
> 
> On 8/8/24 02:11, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.1.104 release.
>> There are 86 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.104-rc2.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
> ...
>> Naohiro Aota <naohiro.aota@wdc.com>
>>      btrfs: zoned: fix zone_unusable accounting on making block group read-write again
>>
> 
> This patch results in a variety of problems with the parisc64 qemu emulation.
> Some examples from various test runs:
> 
> [   10.527204] alg: akcipher: test 1 failed for rsa-generic, err=-22
> [   10.529743] alg: self-tests for rsa using rsa-generic failed (rc=-22)
> [   10.529905] ------------[ cut here ]------------
> [   10.530276] alg: self-tests for rsa using rsa-generic failed (rc=-22)
> [   10.530732] WARNING: CPU: 0 PID: 50 at crypto/testmgr.c:5907 alg_test+0x618/0x688
> 
> [    7.420056] ==================================================================
> [    7.420507] BUG: KFENCE: invalid read in walk_stackframe.isra.0+0xb4/0x138
> [    7.420507]
> [    7.420827] Invalid read at 0x0000000042f07000:
> [    7.421037]  walk_stackframe.isra.0+0xb4/0x138
> [    7.421204]  arch_stack_walk+0x38/0x50
> [    7.421338]  stack_trace_save_regs+0x58/0x70
> [    7.421498]  kfence_report_error+0x14c/0x730
> [    7.421649]  kfence_handle_page_fault+0x2c8/0x2d0
> [    7.421996]  handle_interruption+0x9b0/0xb58
> [    7.422168]  intr_check_sig+0x0/0x3c
> 
> [    8.891194] =============================================================================
> [    8.891558] BUG sgpool-32 (Tainted: G    B   W        N): Wrong object count. Counter is 3 but counted were 18
> 
> [    0.403174] =============================================================================
> [    0.403568] BUG audit_buffer (Not tainted): Wrong object count. Counter is 1 but counted were 34
> 
> [    0.505914] =============================================================================
> [    0.506258] BUG skbuff_head_cache (Tainted: G    B             ): Freechain corrupt
> 
> [    2.831636] =============================================================================
> [    2.832144] BUG skbuff_head_cache (Tainted: G    B             ): Left Redzone overwritten
> 
> Reverting it fixes the problem.
> 
> Bisect log is attached for reference.
> 
> 
> I tried to repeat the test with v6.1.105-rc1, but that fails to compile for parisc64.
> 
> /home/groeck/src/linux-stable/include/linux/slab.h:228: warning: "ARCH_KMALLOC_MINALIGN" redefined
>    228 | #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
> 
> This is due to commit 96423e23e05b ("parisc: fix a possible DMA corruption").
> After reverting that patch I don't see the above problems anymore in v6.1.105-rc1,
> so it looks like the btrfs patches in v6.1.105-rc1 may have fixed it (or maybe
> there is another hidden bug in the parisc64 qemu emulation).
> 

Oh, never mind. I did a reverse bisect on v6.1.105-rc1 (after fixing the build failure there),
and it points to an unrelated commit. Looks like another qemu emulation bug. Sorry for the noise.

Guenter


