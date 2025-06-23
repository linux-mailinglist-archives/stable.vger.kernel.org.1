Return-Path: <stable+bounces-156166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D3AE4E28
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8617A17D01E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BEE1EFF9F;
	Mon, 23 Jun 2025 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeMEzGHn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F6A3C26;
	Mon, 23 Jun 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750710662; cv=none; b=K95oHh+JxXhztr7xLEEA1AgmS5bgVS8nXHEKO6v40L0pMGXROcF1sf4oCD+mjB43XDu3ar61qPJ89kiBQ5aQ62fZ3XoaZotdzAnPgrGApFRm7NMMH4PvMc2r0W+Tl4ioP4pxfdcxRpsSG1GK2/6ihzoGeYIo8cbFYpb805+3Ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750710662; c=relaxed/simple;
	bh=Yr0uDDaYWVuJTb0Gu/o6MZ4n4mr1c0btuqzbaHxC3Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aCwGS8/Ft4liaB66sgVft1VY4PIqWMN3Tjilnfq+w136FYnyaLnYkwKHF3uxOZVGBBuTkZdXdeTSuYNgFgGdHTvSvS9xS02EuS1ZVdBemFIQDZqEJp6OXEMK9/w7NZrb7v61fJSLWu9SoQlOrvhP0Q/g5Yt2zK2yH4fT6sqdTHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeMEzGHn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237311f5a54so45860835ad.2;
        Mon, 23 Jun 2025 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750710660; x=1751315460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ayWLqMZSDTtWa6i+XfG/Qrqdj0vKbKDEHjxi0h2ptk=;
        b=EeMEzGHnm5BTNlW3oI0igi2svVHhdbsXvks7esIR4mz9Vzrr3eL/KK2M6VUeriBxzG
         a2GPmQ/u/6o3lrMmAFBW+oGdrXbiNs6o8x9A2rffdwHQAg1P+3GFFMv6oW2WswzttV2P
         AjcQ7G2bbKaZnNhTNltqUCfpMyAwJuaziB29dzJz9rR8tewyp2+F1tifTrE9zC8V4o9D
         XZmiVpk9MPusMwyhMpeJaPr7KiqG2GaCQanmIXf9Bg/TExUvtG2AiH1hqhKVRllRbxVp
         juymhvo6Rju5RtIp5WIh8zDzzBeE78SOmA78hrX/SV5hYOoLHAh63dkmdLBbFv+62kFk
         iseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710660; x=1751315460;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ayWLqMZSDTtWa6i+XfG/Qrqdj0vKbKDEHjxi0h2ptk=;
        b=I3YeOiL8dxjjpnxC50lvVB9pQ4WIMiBSC6aDxh1UZi6JJvG4EgkkL5f5lfg36dmbxp
         OcY6bR3T25ohBSn37INR7l0vrJhlDxQ9WNE1Lmr71V0oWdCc87BsIswRbev/0PmSwkmS
         DqPnvZJL8ZTMOtGEfyWT2Ny/aHmaZOywMuKOjovHcmcbcFrE++naXJc8FrLZIkRN3q1F
         6NWKeC1hASviYfSQXf/hfuRsZSBgBwFVfQA8FjhXg4mtKPshD2kvmL2WQK6/ikmx9dfp
         1K8qP4S8df97iFoEy4NOpzc7Zr9jXKRd+T6I/Ag+pYkKTwYpXa8cx25mdsLii1eAYptV
         7Enw==
X-Forwarded-Encrypted: i=1; AJvYcCUZLAKsJO9XKhsKf9L48jdYvdPHFq1Cc65WP7IEybpYhX+WYQt2jLVQi6zNka0NVsSWgfEZvgko@vger.kernel.org, AJvYcCV1+/XywmsEe97sFA9P+KOsvSlO/ZOFCRKgV7ZdWNuafqx3tKNPfNgLWCwaqlhcWxZRZAZ/TwcK6/exVVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywthc9f4nIvGPAoIoIYOwBFTU3BxNBkcrGqRoMQBpCYQFUkg8r+
	HqGTcJBG3GyvcjwILIrLKotnPUemI9WFslSleDq7zKqBAdus2scaPdl+ipXorpjH
X-Gm-Gg: ASbGncuk/wlxSU92DEWDUc7/s7rQcryHwdI9LrDjso0HvO/cqjo8uGrxq2E7IatJuGc
	+qnLP0GAX0I/Kbb2LI5kZ2cSqZtpgcWe9tlQZlkpUrjSSlfq2cM+dzrIBgTdltK7C2atovir9Qb
	fEQouKfDfeY4jjaMp6kxkAeFbHFISnen7yz/CqE7pakcv/+iiq6mwr62SQWeevfb12kcfS6k13M
	3zM/jvS22eoE0dK4i7clIrWIpoiE7XtxOyNBUyLc+6PIMonBSNiuGN99SxV0skcjgxuf/uLSGfw
	4jgkQxMe4eHh63aL8U77JDRUC87akvdLcVVStlh8+/Y5zKdKhylUc9w0mwwOWtt40POdk2PQs0J
	vyy9s5QFMV3fY3Q==
X-Google-Smtp-Source: AGHT+IFfeEmO8VTrLWnfE+bK+xc8yt8MRFMyv0mJNLLnIOdN8rK3x2pKD3mz79gtbUADGgHjE9Tybw==
X-Received: by 2002:a17:90b:3d4d:b0:311:d670:a10d with SMTP id 98e67ed59e1d1-3159d8d96f1mr17441006a91.26.1750710660201;
        Mon, 23 Jun 2025 13:31:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8608efasm90073835ad.133.2025.06.23.13.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 13:30:59 -0700 (PDT)
Message-ID: <16fd9ccb-e4e1-4836-aa00-6caf11752f30@gmail.com>
Date: Mon, 23 Jun 2025 13:30:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/355] 5.10.239-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130626.716971725@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 06:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.239 release.
> There are 355 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jun 2025 13:05:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.239-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

