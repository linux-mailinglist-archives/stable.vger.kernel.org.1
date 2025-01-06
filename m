Return-Path: <stable+bounces-107761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0045A03132
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 21:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567273A44C5
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E291DDC36;
	Mon,  6 Jan 2025 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF0+4Onc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7A1D619D;
	Mon,  6 Jan 2025 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736194420; cv=none; b=F9sWxPXlMHMX3dFTLI3iBRBrPtqjOblYHmIfwNKzfOqYdoxOT7uzlM68vWXmnrDlSZL8o/rouKFmO9FUgl/wkPSqIKYkdCb4F2qma0ZBUzQnn1jQ1MM08EVIWaBLLevPrqUhdxw2VkEiHWRMYmVCVKZwLkst8dCMhZFMO8RcR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736194420; c=relaxed/simple;
	bh=pacammo0HmgwREbZ1llTIvIRXBANgom6uS4A1yUhW9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI2IU1/NtJ1Z+6nL+OUo0i97S6nxQLfNc04HuOoHfsFYyTfbVeJaOZinSof09R4adz2IChiwMTxVkXUOOC6JC2RNVJN3QIO0T/RKVmOIUGObhE7As8kfbi1nbjSPqSul++4xwGK2VykFOCqWSh2dRfsA1ICzOcROhQ49nrVYfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF0+4Onc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166360285dso216293305ad.1;
        Mon, 06 Jan 2025 12:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736194418; x=1736799218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zMfl5wajtwnH2/i0QYRNyn6Hi8mJPmAongVpEHF0klg=;
        b=PF0+4Onc4Fyg4D07h5n6/6HqP3bbPENXVv+NbGu33nuOYukiE9mBva58hcnfoAUI4y
         EsoJgVjCPAxFUZOAsXVVJ+toIU3DgZbhyL2pyzlrMSaExY/GxOShy/gf/SB0QPn8QEGF
         i8DVjDCYR9l3nnHRcOhyW8m1nONQINuUA1nxnSFeLEABcwyUFc4NHME5N69wjBADVEBM
         QLo7CXdhea5AiSBTt4VkPZiKDZw35MSfOivReVTNT7Ucu8RQ0V7HbO3krMXhQagKHA2m
         mnObiItAb1L7EPq416dEfMFSGhlqi65rdNJ9CEMMaD8D4ghR8ly3lbUUeWMXJ5B6pnUJ
         cmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736194418; x=1736799218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMfl5wajtwnH2/i0QYRNyn6Hi8mJPmAongVpEHF0klg=;
        b=wAQnytQhEsq6wBkGkJiq9SXoVwBKTjVsNkKyousLzRGx8EB/d1hPnJYsKmEVfWPx2v
         UE3AZ3JbHdQaSbuVzZEdLvektAvdNt9Yb/uyLr6ecOGuP/MZdmHbomwBFQanMylFA0xa
         N6uOrc6IFd5KY3hwXcPDCFm2/AXuLB2GxEvwfeon5gDMGV7euLrgtph3d6PDKyjvxfa+
         aOfQgYidO/ziagQKiYwny7a+J/hvfBDoY34ycFgHjbOPksyqumbnRtusjDjiuij2YRGl
         U6Nxt5ebZaE/ZLrm5sijvQzEihPX1+xJP6oS8uytEQu3Lezapi3QJ/dccAhuUJRVLRx/
         HuNA==
X-Forwarded-Encrypted: i=1; AJvYcCUokK5En+kBBI0l5f1md0u1EAdR912/DjNBDEUysaw9WY+UhZfS7qRBsuwjN++QM2rghw+nIQ4J@vger.kernel.org, AJvYcCVtA9oWDRUdZKdPzRRKMYWoGIyi835F+9Cm6OlmJzo5H7viy+OOd/mazcY1aLDM6c8EhfnvDPRJ+h2eXlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypvXv+JpHl1UL7n+Lprk6Yk69N0nVKMLoatTfhwdokl62UGWP4
	QnTr81G/+x0Z4qp/tiRYuWJudiL/Fud7Y/GFhQpnCLCwRMFK97s4
X-Gm-Gg: ASbGncvrHjKOdGNxjjC5JWpX6UAGTHQl4Sr06Vyc29MtMJWnebGbDySkjP6lVavRu4R
	4eU3rlawjdjeZnRy7wKYgH63UM7Lso7OLt/IRPVinaq33jhx/lYcAWpkt8xBLCmKlixgddatttg
	3cTD81UFlDUBbCC2L/kKBeSzhznae8ZtUAMVOaMrNXS6WTb74X1rH9BSJBpUxhu7LL8tCijuiPh
	4cWUhfegZ6nvbx7Csiek9pDro2rCWTELPxhxPSQ2Ke2dTUa6kRgmp0Qv/mojLuGOBrTGo4gk3Zr
	vXYofBEg
X-Google-Smtp-Source: AGHT+IG4Y2tk6ZkTUpCR7Ca4HckovEkC6uyjMuWkg7+S5e4PNNnew8rXZYNp6DAx68tc77u21aEdGQ==
X-Received: by 2002:a05:6a20:c88f:b0:1e1:dd97:7881 with SMTP id adf61e73a8af0-1e5e05ab1c7mr88751600637.23.1736194418084;
        Mon, 06 Jan 2025 12:13:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad834cecsm31787135b3a.70.2025.01.06.12.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 12:13:37 -0800 (PST)
Message-ID: <9c16ba71-5732-4020-ba2c-b676240c0d8b@gmail.com>
Date: Mon, 6 Jan 2025 12:13:35 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/222] 6.6.70-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250106151150.585603565@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/25 07:13, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.70 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Jan 2025 15:11:04 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.70-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

