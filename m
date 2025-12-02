Return-Path: <stable+bounces-198127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E577DC9C91F
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 19:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 733CA4E3752
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0E52D2382;
	Tue,  2 Dec 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atzu8olw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102A2C237E
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699294; cv=none; b=qkobIXaLdoi3waHdUfFNthVui8U+FKnwyVG+YcXL1PSw+3wKHEGkbh1jtrtANi5GUj+X2KVZd5T3+KZaBMj7xblNFYfQztT/qDpB/S7EQ2aQVU2iZ18wWFZ0gsGQIy+ergr4CiicXNI1S3AkEzceGGpXBDOpWYxmyUsUg4hcUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699294; c=relaxed/simple;
	bh=Zadw4f8Rb9R9ongw9fXvygXWeldIJXphoIWzHsB5tXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qdl5yCjm4QmTzfBcV/VMvQS5hFqz1Yia0oMZnjZXJrxBpQZ5TW02otnK7N5Uyd6dz68/vj86d6y7ww0oQkAoyyXEmBuMr/AyqsUvXxvGFvdNShyQ0mLRH0XCEfsmjA4B00ZTMtjKB/SDyB8jYGCE8O4m904uZ9LRgiDKtQDdzNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atzu8olw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297dc3e299bso55626895ad.1
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764699292; x=1765304092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNcow+v6Zimw2i/FJx4QwkUgA7xtuYBe8HXCgELidKM=;
        b=Atzu8olwcYVxC395SB7X16ZME7Egzqci92Q0+IU69zlLzdUsJ1WujF6+cx7Aft7cYJ
         tTBfM9b3psamPgS3IUctDB1xye8TWw+q4AzXVnr0QdDwhjCSx2XLa/os3kzN8MnJ15ny
         Dfe4RwCQtblQuQXd/QP8HAA1TSAF7gAGcK5yw+W0aiCeEzXUIFROabUp3RJKL5ckQDDf
         W5petLCfmgoNwM7Xf8M4WGMYmogkGaEsn1hVJmFjOHtVOdDDU5CDSQ2fmNArEI2VC5hG
         iKeZo9HYkCcMx4srKanFw7NcQkos6NgQ3xU54QYLVxGaTkSJDQ/WCbafM2RGxx6xUhJL
         0jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764699292; x=1765304092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNcow+v6Zimw2i/FJx4QwkUgA7xtuYBe8HXCgELidKM=;
        b=SDLno5Xg1f7+u5MN5wVhYNTh6sE97Y4PsFo06d7CDZFRyxByUKDwG/+jayPdzgx6Wk
         mao2kSj560X6ULMm+LIzyZKxPWtgYGuI4v6QhKvTn0HD+nZp+atlebFM+kJgFR4bjtUh
         8r6bpRRPBHFwFBCHklxP+EvkmaNg4b9pVoI+sjwPHvmB95ORV02TKAlpDycAKjliJRYh
         0pm6B0nI1/BS3sOwXyjphw4NG+dkbSBuUHAFDQkWiTuPqsmGcScu+SwS4x4IOU6rfoKe
         2aKoFslNzMoTTMIVR6vzDxZyXculpgb4C3bzJZ6rTa58ngJ2L1/8X05ylgBiKcU/moJy
         zFyg==
X-Forwarded-Encrypted: i=1; AJvYcCVakOZr27fH0fIkZQwo0X35Hyd1Q2wLHca+ihmszon2LcRBcq9b3R25+AEDgQvhNLi+S9+iiq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAGRnB6viNKDwnCBx7Ab+oDi/aAO2ue+t8tTPOl3vbxUgvzcQu
	avjqyZtLdWtC6OgCrdkTXR7kqpQlm52f8T/vYc00o0l6IgmLa0nzM/WK
X-Gm-Gg: ASbGncvEYc4LT/kb/O38RD4lXN58NSr/gAgRhc4iScb8pCBFvywb5Ax5eq668BS/U1p
	LfWmalxkIYMfmpv/T914VS8wF5BQQxk1fnIpeCaPKpIBsXEL/7FemYRiETbcbkz7F4KcSmApeRf
	tqELojHhrDhA7ZgPqI5HCrZYQ5+HHvogRC3/ZbjpYW9EAc4nEsc/sifqTREMgJ8UAOv6V4/VrLk
	pKzNoKnwy37N3RNHABKS1EOotwoIiqxBwvx9qNL8Gtf4J+L09+dRC5Zlm37mZqw3ctYtXlJ/5vX
	XmB4Dg9PMPCfQlsqlSUI4wGQ3w7RLR4mzkWVMdqZ900xYBNw8B2ExPva5MEka31aBjG6jzP2ikK
	gMJVHnr6S8WnTDzZLHzjpPCxCZGgPjs92K+rDECTosuH16hFCbFqJqzjmAdl3CBvn4ookHGzBZ0
	FTcTzAb/eJ52oZV3Q+1EWAWOXhAm+5Qdx8sZvFsw==
X-Google-Smtp-Source: AGHT+IHIsTw3gXnMmKVOvzDDcZQGs3jHRBbAwWl9PHSMB/MnRWehAbvLjOjpCgewlPbVBIfe2VtAAg==
X-Received: by 2002:a17:903:4b4b:b0:298:35c:c313 with SMTP id d9443c01a7336-29bab30b2c3mr346606255ad.61.1764699291725;
        Tue, 02 Dec 2025 10:14:51 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce44389bsm162812255ad.32.2025.12.02.10.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 10:14:50 -0800 (PST)
Message-ID: <d771b28c-bd03-433c-b1f9-695e1333756c@gmail.com>
Date: Tue, 2 Dec 2025 10:14:48 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/182] 5.4.302-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251202152903.637577865@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251202152903.637577865@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/25 07:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.302 release.
> There are 182 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Dec 2025 15:28:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.302-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

