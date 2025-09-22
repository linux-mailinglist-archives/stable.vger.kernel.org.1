Return-Path: <stable+bounces-181414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0209B93809
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 00:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E606519C0666
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 22:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A19306494;
	Mon, 22 Sep 2025 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqcj3OJA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6332F8BF4
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581015; cv=none; b=fbNuGuOyfSczUY9QxbLMK3wfQ4rgcW9ZCTgVa9pMFSglNdVXWqIlaE2C5fo6xkPc4RR1DGTgl61QZlGTdkwUr1c7WxsZXKqXQnCkY8YYMgWmFCZ3B4e4dmcF88ED4yzOxldKuRvZSs9bpFLXIdenSln3v1p+vD8n0rYe6AYaey8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581015; c=relaxed/simple;
	bh=uk8zDoALOJGCpc6J5qC/9xvOmqzcv8BXgnYFvenDJm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbTp1AmV9QgZoBIUpbGEUoMLdJeHLjCx5S4gMiMZshUaU24JuQB0iqtbDcBTU5BdACIWa9703AhKIFUTNDhmL2E8h4vZFs5x7i9cEMItIEh9toc0uXcI73f8hZp0OlLLEqE13niccZjj1/K9HTlbGbDpEOR5cAo7Atz3XzIeXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqcj3OJA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2680cf68265so36719255ad.2
        for <stable@vger.kernel.org>; Mon, 22 Sep 2025 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758581013; x=1759185813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgCSsQENa288XITw/HVlbMVFXGjqWN4OmK4n73b9eYI=;
        b=Lqcj3OJAxTa5MR4CYygCLtvGJLI+XOAPj2P4Lf8F4XhQXQLZ+RZFFUMvKY0R+u0moA
         BvL0n4Wo3kJ/9Cm2nFCN44z74Of+sw5com8pxjzACbnPGLLp8b8dEsZIDSvWmTigfXhI
         qNMHaeAp3bypzy0UBES4Mcwclo769bTmDZA+UU7tHP/wik7u5r8bBKwpchXMfCD68M4V
         5Dox0Mbg/n1gXBSZjULdDEQeD4TPq+ZCqbQa9cwiJK3Fey6V8gfTjUOntHLT7bIW1N49
         IMNh3pRBZPi61JuO9EArHkkjph0TxtCcHoOf6iknwYabY9yA13YBkB6i2Fyq9sw1kE8P
         EfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581013; x=1759185813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgCSsQENa288XITw/HVlbMVFXGjqWN4OmK4n73b9eYI=;
        b=LKXe8GtkfNmmJMTgYjh3p7a3bqNAMiBIY0AbcmxNIrvosezGxUs+PubnEDOx+IbQzT
         DSDlHvB0La+nYNmg1cqrPoPRVJtxKoLIjPt9MG2iAQRi6FsqnRZGxSPdQf13tUxGCE/N
         DrD1cR+f+JBQEWDJ8QX92OAz6cketcFZBVXTp9EwrW9Fjg2Kv09SDwXiTTAw1I9TE0nL
         5ADaXHiN34Jy4mscIIO9fJDOK6r7rSCs24uT7vv6IiA7EwqJ5mflkxvhNKs/sDxh02M0
         mfJeOmOUgb3o47eHLX0jrrcqGZQW05noWHzQbsovbc2bvdFOFCtgu4WudthrRDQwDod6
         603w==
X-Forwarded-Encrypted: i=1; AJvYcCXjhC8q2m80K0zSBvsbr/b23Cxyl7GXtZhaGdwp30HFGXX6tLB86YpOmYv3QMcM/dGSCxe+ho0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaoObHoJMc/Ik35u1jC1aK6Ixfpev5ZrhKAIl3IbnzoNaxcAcB
	6nm8kO70d51Ag7/8jKA2nXCczJeuNZcBRsHmGM7HpyrJr1GsB3ZHTmoP
X-Gm-Gg: ASbGncsJ5XtG8QtRWJTEie/wjEotNGbOte+2XqcT+jH6sDil3aieK9DaRsy7CpDP0Tr
	UY8xzhKUxSU5wfZ2OtZa3LT/zBha6JaXOp5ElWeEQhsNp4jdCxRLfOrV21n27PWIEhK+gthYn88
	nfR3ecH5HZlxduDHwC7j1uvblIMYE+DOaQDtJj3P2ErvSQ58Yw0ornu+JCpUn4NCMUbqgc9O5UF
	HsvoTVaAlyXmLxpXnxkmjMK0PoO+K8UH9JSOA1PICc/PWhHloj5IZeR08VqG7h9hDYnC4bkPehG
	VGFynjtQ50835p1v9fmJfFx/CcNC9h9a1ULlQpKNuNn+XoE2r+42dzUx58L27EokvMNtWMBLKZL
	ei2UBxdVj+QLh3MUFcJqpCPXVVrjGGR9D0pXRpSglVzVX5TJkLPvH632pp+f0FvlJA8jKWo4ITt
	R5AHVZ6wo+
X-Google-Smtp-Source: AGHT+IHIp1qkMddrTINGGwbaE3hOjo0maJ+lSPzxbZ8279E8GS9DPPZ7W4x8rQ3ZYqAY/VwbhzNeaQ==
X-Received: by 2002:a17:903:1248:b0:269:8072:5bda with SMTP id d9443c01a7336-27cc71212demr6761385ad.54.1758581013388;
        Mon, 22 Sep 2025 15:43:33 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085e6dcsm14314305a91.29.2025.09.22.15.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:43:32 -0700 (PDT)
Message-ID: <96c99d72-6231-40b1-abcd-1d4f968fe904@gmail.com>
Date: Mon, 22 Sep 2025 15:43:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192403.524848428@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


