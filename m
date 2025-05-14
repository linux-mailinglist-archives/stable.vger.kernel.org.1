Return-Path: <stable+bounces-144449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52EFAB7748
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6A7863325
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001011DE3D6;
	Wed, 14 May 2025 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3A3fZrG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE79171C9;
	Wed, 14 May 2025 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255641; cv=none; b=mR9/+pEH9/ZZaMIFji6HS7YZPhT7T5kqd8sagdciqRXyZKnEDbiHJijXcJ5b2woS/xZCdz+sViP9/vMcyFz35IWSPeu5yf0TqAi3ZR5SlApAE1dUZFaOrWmrxzq+yddwM+6EpSMlqAi5Z+GPjhjgx/BoynKA2pUSPS74ZH4y44U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255641; c=relaxed/simple;
	bh=8s4k0AuPpCeYnVbTJcNtLPjbu2CtKFkPiZBd7kxJuH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TerMbFb6/0b8wupwx4gt3a1S/tdHdJccoIbSEh/BnB3vyftABvSSAuu8iayrZq1HZMU3I8nEt6ZmfHlx4glRX2ku82cgCNxbhoekNCkTRF1NGC8LLtRmgdvLoxCol+wFSP65gPIr0URJ+RpRvlSHRoTnAC59oHDl8r/L7JgyK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3A3fZrG; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30df7c98462so278969a91.3;
        Wed, 14 May 2025 13:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747255638; x=1747860438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yqZtoMhgtAkMYZTJ9JntJG1rUnS0RQTY7ZMyliu0Sq0=;
        b=a3A3fZrGl8WpBfucqex992kCm/3B5Qsc4m2ubr6uJro1oX3g65sJhcZHU1qfiHth2X
         IGCYIgAr5OUy5vlyr79ioc/8HGfuoU4IANFPe55a5SzW7gHIILAPQdEC6TWS1AXwmYJd
         AmR+G8V3JKR/qr6L+EzsL6uvrK6lVqowe1B63+yEfQSfC7reHe8CTIdrJfn8BuyX/Xyi
         N1aneDrJ9FiMF0A2LTzEEyFy+PJ73zW7IYorrSGCGQc8D1CCNB0EubjlHOvHKnpvVI4P
         5xuFQc6R9yhOu2FEIsBgaFI5JfVUfe4ZEBSsBco4TaPPizMgZcC0RgxrtnwqIK6UNIW8
         cxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747255638; x=1747860438;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqZtoMhgtAkMYZTJ9JntJG1rUnS0RQTY7ZMyliu0Sq0=;
        b=ZJhRWPZ2Tr0a4xbBNKiVQrISg6xKWU4jRD432Qt2dUIx4MMFGNBrgujNCLa32NVQ1c
         /Hsb61uvc1HYVQZg9lPMlAYhrPrcS9NmYgv+NGeQUvMzK9+2wt/kOuJU/IOoeYnrA2K/
         MXKd9UyKLEwRtOiT8vnypXKYW3HA4JXSpeYp8YJNBym+fkrEGoRhWqLF+kAWOUv5IjZo
         99Xc5ZZ9eEOe1AcIs6u+Ilv45SfIczVMKi9icBR9gefyALeI+9aco1p1MDbJt6f+LLfh
         aM3m9j1PMPGYzMHkTZf7bcuuIln8O4bxajEc9KeEb2j3hd5Lxw3yszTr8DyuYPgpOLnt
         axLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbyfSk7sELYQcQDXcrlNXgCvXFD+noA8qjxioyVFl7DcThY5xFgYER49DyyL/KXRMpBh/IJk/tLsBsBJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrdGKEIw8OhY3FfUfnlHg/t4XIGGNSjDziDLIHYKrhLgHoZvT
	LCpim1guoUEoWUFja46CbX1K2UwvMLaanJqgROnqQ3l6jKnw4pdL
X-Gm-Gg: ASbGncuC3dzfzp/AfRGznsPZV98hfkvmQuzANhgY/SGZku8SYURaUHPFWD3jxoE3l3e
	HrjJz8nz30Ci8OI4YYgfW3vRd0+0Rc/a1vS4mMhelhEkFCItFIGOv0ZQnz23kTYxvlHjZfkwdrg
	xtf02f2kOWtVShviuQaZJPBNvktfrCpA1JkhgueIy5WrC6fY99cZpIfW3pYyYTANBuJKM2EAn98
	vv1hS9UNKu1RCvUbeLLmGi8r3QqFSuN4yAKcXsQJaeUCkD4g73UKLk5iP6wXt2nIkm6n7EFuLPg
	JLMNoj1VvV46qrEpIphtBiX1PmDHw0JvbRHPEU27BccHkvLdMZ0hjTqbGxC7CUhuoTXl3xGXZh/
	X7PFD1yMn0QBY5fl1oUKag6YpK+pzvwfUZi4=
X-Google-Smtp-Source: AGHT+IG9j6gSupit9bAat/jSXs7+pnKLnNEXVkwPrPgcaQAFYHuXV4S74wJV5w2etXtHakVW5rorbA==
X-Received: by 2002:a17:90b:1a89:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-30e2e65e6e3mr6039908a91.26.1747255638286;
        Wed, 14 May 2025 13:47:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e3345e60esm2017829a91.28.2025.05.14.13.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 13:47:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <54e21b79-a7bd-4e35-ae0f-268daeda5557@roeck-us.net>
Date: Wed, 14 May 2025 13:47:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/113] 6.6.91-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Darren Kenny <darren.kenny@oracle.com>
References: <20250514125617.240903002@linuxfoundation.org>
 <861004b4-e036-4306-b129-252b9cb983c7@oracle.com>
 <2025051440-sturdily-dragging-3843@gregkh>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2025051440-sturdily-dragging-3843@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/14/25 13:05, Greg Kroah-Hartman wrote:
> On Thu, May 15, 2025 at 12:29:40AM +0530, Harshit Mogalapalli wrote:
>> Hi Greg,
>> On 14/05/25 18:34, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.6.91 release.
>>> There are 113 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 16 May 2025 12:55:38 +0000.
>>> Anything received after that time might be too late.
>>
>> ld: vmlinux.o: in function `patch_retpoline':
>> alternative.c:(.text+0x3b6f1): undefined reference to `module_alloc'
>> make[2]: *** [scripts/Makefile.vmlinux:37: vmlinux] Error 1
>>
>> We see this build error in 6.6.91-rc2 tag.
> 
> What is odd about your .config?  Have a link to it?  I can't duplicate
> it here on my builds.
> 

Start with allnoconfig and add configuration flags until CONFIG_MITIGATION_ITS
is enabled while CONFIG_MODULES is still disabled. Adding

CONFIG_64BIT=y
CONFIG_CPU_MITIGATIONS=y
CONFIG_RETHUNK=y

followed by "make olddefconfig" should do.

Guenter


