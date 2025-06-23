Return-Path: <stable+bounces-158199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E11AE577F
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E3A1B68290
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6488C224AED;
	Mon, 23 Jun 2025 22:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbIDIFGz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58422577C;
	Mon, 23 Jun 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718361; cv=none; b=lOL9SmVkeOILLzquxkdBEROJjCJjH5NAb86uAb+of+NyOTx28cfHFApdc+H7QSoTefEmdlAJDliYTQ6mZ5HgLCp3VNtqLhzhs/nYYoiAYekVSf2EofjQbqXNox8Q02zRCcAo0TG1Kc3XbHMbyfuZ7atInEJhDWt7sFG5zG5dvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718361; c=relaxed/simple;
	bh=0rVNs7RhKAYqM4PKyTZ9ZFLKPRVUBby6U5PdZIouJ9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDRHPWRK5cedGIDUK57OlvLKxEjzcpO228k2/kxf6Y8Cg4q7dlsx3EWVbLEXLSzfhDisXbSbmnqbl0Q/eaCo/32bk9oqpURdU9P0o8eqrRPbF/0iyc1rEEpmrO3uU7MRNEDO9u2Ck/jlyn57yBmJBZIpHgjsQf9DjZtt9mQxgmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbIDIFGz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so4974225a12.0;
        Mon, 23 Jun 2025 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750718358; x=1751323158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eVldHq4DjbfdVyoY5+6ghjIA8lubME6n79s3SZ+DPi4=;
        b=gbIDIFGzWjkiYmlV56P7KDXYsLMHxFaIJUO9QtnABrBNKE3anEi+wkD/foG51v1zte
         eRZYlWlL7pHct9+stSjRrm1rUb1qqPPveudhQcO43NmYVSKb5/bynQBt6UvBNqmegtmo
         M/OH+7dl+F+YaEU4XWtoS81nOPqwddidCuufIhRCFKQTUU3p3aMQMKKcyXZZ9OWiy7Ww
         vsa6HrRITRn39Q6RyA3fvxcVP5QesX8kRqzPlw11Kk8uo19aUAdeE0YSYbCJCUGRH5JU
         OICJ+YU0eXKJC/i8T0A2b+30Sow686pOKuVLHRZewy+hsjgAog1EL3GlwIFgiJgsCTa5
         9aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750718358; x=1751323158;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVldHq4DjbfdVyoY5+6ghjIA8lubME6n79s3SZ+DPi4=;
        b=lHP4n42MPy5DphJF/9ncr88IZv3UN0bqbf//83D6r64WHcQzpJgq6VgQ2ziZyJn4x6
         r4ZqMG/HyrmjNMsfUywT1z3aPe1Sg7r9i33eRHOBJCXt9mCdOeLUEqMF2FIY6Nduo7gF
         WQ32q+HA64ztH7pkTXwpDr2s6PClVJBZ9G18vBNs8hocPimLECc8A3D5AKK7rE+W61Ki
         fKIvJ+oVncSbVL+KkntWNqoftsu6SqRvfPWihWcW4O6Nxat4jlUoxAV1lqZJi3HGECQs
         ogxaHqKSZ9cNuqBNFH0TUuI/nvHs8X/mOtrz6+KI02lMMDAdQvZQGGCPgp3uGyPifu6T
         EA6g==
X-Forwarded-Encrypted: i=1; AJvYcCWcVqpO7nLO7L9lELTcIA5/h0Es7XUKWxHN13aaJfVmO3OQYdiKy9bimrDYlGlf3fpmwFPbFwNqlncQV54=@vger.kernel.org, AJvYcCX32azvo0d1laj0WmQYP3uXFPP5jc+Vctb4PFiIZZAU0k0u2sHBD60gGqHXhzZ5WI1Hanmc+kaj@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtKlNbdpiwoPF6WYg/SiE4KzFbjoY9ZIjAVH/Yu/wNJyz0ENY
	aVPTOs5vZXBZYdd2POzXy9eGYjRPUdOAyo3/dr2HI6kYa62y/qEojzm+
X-Gm-Gg: ASbGncvvc/bK1uCWlgccxD6pYRpxHEHPBLNo0MmyWGGT85EttpBr4YwPlakZ6Pidgbg
	JX89dDWNswhskhQzCGzZRICopi5nUhSEFLCDfRyT9kdwNnV63hUYruhRZJBJ+hmW6Of4DKmmOUg
	ccJZdwjE9qzWnb5u2VjmMkxrc5kKNXAN40EIR8MZAi4Ugjmsnq4onuGJK/S3fB4TEICCPZseiPM
	RaDyRSTL8d8CgZHxBMtFk/Fpjc0hIaawg6+Idfc3Kx6keVbH5xVFlVrqVShGRHgLsYywEJ6E/Bg
	OnRv8PQOjYkOJ1eVKC/141THG8JqGAFN8aDvo+pmLPm79YTSopGJQ8OKIeSGhmqbPq/Q0iUcZCH
	kfObQQDBLMUUjdQ==
X-Google-Smtp-Source: AGHT+IHYN94A5/Fx/LxUvjM2tcOJlcPKNTiO6c8jVRWWoWyAPBuJXHPcEAuCtVUOpPBBQS+38+Ho9Q==
X-Received: by 2002:a17:903:1aa8:b0:235:ec11:f0ee with SMTP id d9443c01a7336-237d98cf47dmr187500535ad.14.1750718357998;
        Mon, 23 Jun 2025 15:39:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86adeeesm93889435ad.196.2025.06.23.15.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 15:39:17 -0700 (PDT)
Message-ID: <b9ed6a3e-026d-4e06-a1a1-feba6c6a8ce6@gmail.com>
Date: Mon, 23 Jun 2025 15:39:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/592] 6.15.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250623130700.210182694@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 05:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.4 release.
> There are 592 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jun 2025 13:05:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

