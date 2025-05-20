Return-Path: <stable+bounces-145698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D42ABE325
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 20:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD777A5F55
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396D527FD50;
	Tue, 20 May 2025 18:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKBqaRcw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4427D771;
	Tue, 20 May 2025 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766914; cv=none; b=hU+8NyX8x3fAHpOwcs2Zifq2gSAWD5V+zQjxDsaiXGYSZf1asR80Otf9rPrhji0u/D4c5KZfHR2zlsn2TfBbx/4xFLYzXE/asFzPJKQGY0oWX0aoPS0UfDsw8DOFiM3LvxeR+VrBcNNlUPpPADvJJ+WcRx6V5vMe1mOHkp/Gbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766914; c=relaxed/simple;
	bh=eWhmDY+JzhMTlbfmEF/OGgFA8INkcIC+ByVMvWRgrZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yup3DZy1pu10+1fPldJuGOVKGZ26A+SeGmvr4s+Q9n1W6HenWd/uO+m+nihfFZVYiIdbYqLktZwOM4G7CK1RWhV9OmxGBHNGDoa7N5fNPNZapuwCDAVlxmMkxzVx2q/4U6xMq8jz9A8jadki06+vChgSJEFLdGd1Zg1nbfaCi2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKBqaRcw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30e8feb1830so3722382a91.0;
        Tue, 20 May 2025 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747766910; x=1748371710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=exMlkAQN+jyrfEO32kiys6EMj6zlpuy/OgwNus9hUYc=;
        b=RKBqaRcwKKHSNAQgLjWqyjbP5gPs8jzxF/MzWObIzS4fiCmyfabZtOzwd0piGZXlYc
         kLX72dtBOo/Bsl8kQ8uCqHG66pgxAcDngjH5o7ReT0oQcy5UK1j1mlpq501vyFS4Qpcu
         K5AkOHqEfnO6lvWz8w8mJ1xU+ekk4p7PUXw3RK2ecH6xy/ImlEkgLs8AFGJCmV0sWuv4
         bGEpf9goV9n7fypogUrlZKYmb4R/3UtYzp/yXhWl5oqAjlNYkYuT2MeDz3c1xsWgS97m
         +AekwHv6UIEdAaaEiCL4P/k3aPkyU+XJHIfvvQ9871MY8aM4VcpbpQ/OdjYZIpUx5BGL
         t2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747766910; x=1748371710;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exMlkAQN+jyrfEO32kiys6EMj6zlpuy/OgwNus9hUYc=;
        b=og1Q36gq2Lra08h7AH1BePBmPUQTrPZZqzuT2f4blPUz6Jkn54WZv3T6FM+vdS9LV7
         812EHmM5xxsaEkrZpO9KfEKisbo78KmzCshXuu+bS843PpOyTB92iEFIZa2rltFEvf/i
         CuoT1rF6hI9Q7sQFfL444ZO1qaPngMENDmCg0Sb99x2G30rnxVKKjJeY9kX16z7K5l3P
         z18llKLW2iUtjaWj/qAp7XmuRDtCJOvVIKTQfjHmacR66o+Xmkmb6Pys98YGxQjXb1Za
         h6ClXbh93dxM8KFmBvrjEctZogNBaeGTJP3LhxqWH1ynIiGvjTwP0J+beMHTCD8D3dPF
         I8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXBy8cuDP8YwIxQvwiXITva66kjE6RbgJ6M5ufLj0DXL50qojV2+PP8zZzZb+mXJ2eI1J/NQ9lv@vger.kernel.org, AJvYcCXrB06XakNxSx7j1Mfw9zd87eDXWruQGuDnjAYtFWaD2V9soub5A2ex8lz3yKSiMSapLfCLeXx9lQDlvSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+wx0csjZoOiud43svbJiwuxyt1JC6GCVSyLUiRvSzMj6k0LAl
	kkIGpGBdog4Ca2t+ZkmJtxri6qhKYwOJtIZmMokVE+qvuXHL/Vt6lDU9
X-Gm-Gg: ASbGncvIT1KSZYJVQjEXB2gvPl8m19qaXsT5m/pgWRDpVJJCCnKfp25Qp/35+xhaBcr
	YSsf9Nska6K9PWtAKH4IeAvp3dEV4ZfpUANJkh0/V/O98KCkTKKyrRT30qNuUyIXJAg+6cotGpn
	1zjNCefZGCjWMPUql9vKFRpQ9D4VSnQFyBMywlyGct/hhDpjLL4Cue2QLKouLpG3srPyvVJNhov
	bomjYj6qd5Mci/guSTiP2wVYewACCPpEfx97+OuiYs5X4rdHpQIaTPcpbCS86Yt7u9gkEdoG0Oe
	KqsxH0s9QX0kRufq5VAbX0d7sx3v1F3c070cuDhQRELEMNTk/azW8Xkakw/3bi/oH5KEmL5YxUW
	cVROpoD7qsEviXA==
X-Google-Smtp-Source: AGHT+IG6I1PUmZYO94K/10yCwbz28YB+rLraQhTmPlhL1JjGl7LdacLjtbaQ6Q2m2SjKi97glIc1sg==
X-Received: by 2002:a17:90a:c105:b0:305:2d68:8d39 with SMTP id 98e67ed59e1d1-30e7d5221efmr31915083a91.12.1747766910401;
        Tue, 20 May 2025 11:48:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365e5dc6sm2047020a91.40.2025.05.20.11.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 11:48:29 -0700 (PDT)
Message-ID: <419b017b-37f8-4f9b-b914-95ab4d76b334@gmail.com>
Date: Tue, 20 May 2025 11:48:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/143] 6.12.30-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250520125810.036375422@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 06:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.30 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 22 May 2025 12:57:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.30-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

