Return-Path: <stable+bounces-78554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C279298C17E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7C92852DC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3681C68AC;
	Tue,  1 Oct 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wdt9lXqO"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D8026AF6
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796275; cv=none; b=GLsl+IiWNQHg1s3aDmHnDsC58aV5r2FMDxF9FggPNw8F+LTHnLzXNf2Jf/BV3vwoUqWlW74wfDo6P2YVHi5VVTBC385e0xgAP6bl7xjr0twk8s4sLjCa20XY61BYy0sv8tFJWTdn9VZGweLwJ1u/ACjlqmM9JpxUQV2MzEslttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796275; c=relaxed/simple;
	bh=niSGvh9NK28TTMNw+oIdMqrrpOCq9aq3rPkpfjc4Kxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7eRAaD4Ek35p2Gn6jMjAlUFvSGWw6YPws7byoEofvV83dmCCgWkNQ3dSyIrvB/B9YxouKOGUF9O38MykYkq9b76P3Z3Jv+Jo7yf6CTZ7xt1W9zgGyus3VmklrsIoJ6S9q+rwYNUhuDGf9f6ojgVpUOI5+/Q67L0ZupLI+mZx/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wdt9lXqO; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2A693FA4D
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727796264;
	bh=IfyD3J08rpFUiSXRGVfyNTQZMlD+U8b9QEj2MDOV6RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=wdt9lXqOJTT3WqCBVHdUXIfCN2P6GRcRZm99rSmrSL3DcAAuEE7bfkYR2lv3IC1jC
	 LMXztOlajxgslunrQ07nPkdKHGi5PyFB1IZTacyRUkcspFqlmbPy9O7DsyyyblPI4T
	 HrgM8C/wUx1kFyyVhVRY4HhmDtyCHZCxciAHLVhMWtIhvilJqqUjj/+N3u0VGkpRxd
	 hOMwCksO124Ob8W0wSr4rhR2FUlLRbPAL511XinNcfkakV8SIs0U+11fCLEb8tXVWY
	 lE99RLIGv4On99DZBlAwmVUDvvcjBMyq4Yypp9CI8Z4gn9Qwx4F7rWo7hzC6KG6HPu
	 a8m33PbKF920Q==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb050acc3so30984905e9.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 08:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796264; x=1728401064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfyD3J08rpFUiSXRGVfyNTQZMlD+U8b9QEj2MDOV6RI=;
        b=EjIFIlYXGqsQ0ZYa4f65eoqc0pQnY2e7n9S36wce7BqCCvbjWDKXOY3Ci/ng0eYpsh
         Ha+pZex1xDbXcCX3vVS3neXsrIeEpWnhEEKyF1A53x6ZhZa8I24RqyA3oclJT6sF7ewb
         pUiopenII/5Gq+eu90YC98JJ1M1Z4Vz5iCPyFB2sJj+4KE3BpgSU1zDQRDk1TvrV3Att
         4He+z9wFwy6H+RTxwK9f3TN0HttUPvEvQjKrZw7tVH63ipKNINt4xnIYC2/LM3Jnv2fA
         qOFXJePBCxVgCv3g8bxjGRZ9iWaQrgceUp0FOH7ns0ZVcbkfcntC+e3oxsRPRITcwjVC
         QJug==
X-Forwarded-Encrypted: i=1; AJvYcCWsWRwzrBCRm6jznW8oDv7difvS5iJbfIzU6jD0K4x5zk4Zj3/xrPyZgTCL3K8wAD5j1FwrHQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSLY5Tu1qp9LYTsH0MCeqTTFTN8UtH3z2zxJwjw51eimu4mjq
	0lhSdOnNzv8n1JanXed1LEbiOYRdDycxnrG/5rS8W0jG8G7YQRV6VMHMqk+CwgLMLkW/7j4DLDX
	46SJ89+H3s0zRv8IWxfO1V6CAEPX6hctoaXzp3R/3lKx9ZDMKP4szUjNcUqUPqU66GJb2PQ==
X-Received: by 2002:a05:600c:4686:b0:42f:6878:a68c with SMTP id 5b1f17b1804b1-42f7136168cmr23360695e9.13.1727796264174;
        Tue, 01 Oct 2024 08:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyHrSnHUcpAuWIVTs8rbNU+pK4oUSWrI04JLpfK1vnvT+GLbyBxh3h1bUViQwuHwGkJjXDwg==
X-Received: by 2002:a05:600c:4686:b0:42f:6878:a68c with SMTP id 5b1f17b1804b1-42f7136168cmr23360415e9.13.1727796263594;
        Tue, 01 Oct 2024 08:24:23 -0700 (PDT)
Received: from [192.168.103.101] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cdddd86c7sm9461654f8f.26.2024.10.01.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:24:23 -0700 (PDT)
Message-ID: <811ea10e-3bf1-45a5-a407-c09ec5756b48@canonical.com>
Date: Tue, 1 Oct 2024 17:24:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
 <3c2ff70d-a580-4bba-b6e2-1b66b0a98c5d@ghiti.fr>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <3c2ff70d-a580-4bba-b6e2-1b66b0a98c5d@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.10.24 15:51, Alexandre Ghiti wrote:
> Hi Heinrich,
> 
> On 29/09/2024 16:02, Heinrich Schuchardt wrote:
>> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
>> EFI binary does not rely on pages that are both executable and
>> writable.
>>
>> The flag is used by some distro versions of GRUB to decide if the EFI
>> binary may be executed.
>>
>> As the Linux kernel neither has RWX sections nor needs RWX pages for
>> relocation we should set the flag.
>>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/kernel/efi-header.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi- 
>> header.S
>> index 515b2dfbca75..c5f17c2710b5 100644
>> --- a/arch/riscv/kernel/efi-header.S
>> +++ b/arch/riscv/kernel/efi-header.S
>> @@ -64,7 +64,7 @@ extra_header_fields:
>>       .long    efi_header_end - _start            // SizeOfHeaders
>>       .long    0                    // CheckSum
>>       .short    IMAGE_SUBSYSTEM_EFI_APPLICATION        // Subsystem
>> -    .short    0                    // DllCharacteristics
>> +    .short    IMAGE_DLL_CHARACTERISTICS_NX_COMPAT    // 
>> DllCharacteristics
>>       .quad    0                    // SizeOfStackReserve
>>       .quad    0                    // SizeOfStackCommit
>>       .quad    0                    // SizeOfHeapReserve
> 
> 
> I don't understand if this fixes something or not: what could go wrong 
> if we don't do this?
> 
> Thanks,
> 
> Alex
> 


Hello Alexandre,

https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/uefi-ca-memory-mitigation-requirements
describes Microsoft's effort to improve security by avoiding memory 
pages that are both executable and writable.

IMAGE_DLL_CHARACTERISTICS_NX_COMPAT is an assertion by the EFI binary 
that it does not use RWX pages. It may use the 
EFI_MEMORY_ATTRIBUTE_PROTOCOL to set whether a page is writable or 
executable (but not both).

When using secure boot, compliant firmware will not allow loading a 
binary if the flag is not set.

Best regards

Heinrich

