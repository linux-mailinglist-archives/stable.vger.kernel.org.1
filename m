Return-Path: <stable+bounces-128338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA62A7C1BC
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 18:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593491795EC
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661F2080F6;
	Fri,  4 Apr 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/kXM6+V"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22F20C004;
	Fri,  4 Apr 2025 16:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785255; cv=none; b=Gzfs+gXnEcyaGGnZd7oE/bwDOZlw2bsk4uEyx9ZazwM9HhQ8ItWeZb5vjyzURHALB/Ncfriyao6FPJZZvQl2KXCZXFVRLQ6BYx5FVfSOu1xd0BP2fUiYDAf2W3lgWetvwrJ3MpHzXP+F8d1j5z1MOlPwCYgdRDjQBouL+Te4zi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785255; c=relaxed/simple;
	bh=9Iz38orDDWGWK2AIO290K6VwdNwDkNahYRb4oLv4U2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/oyBqxY6k8jeVDb/d/MgnRadpYVUZgSvdlSouxU0CJbZUfB4TpR//Yr4Cjv8j4+ZwQywoww+3Hpco5vcO5yr+I1dlf0xNkK90ZvO5eEoBJs10xJCg5ohv8Lac58iQMj9TBxDibesmUI+X4Jv0g4FpI1hTrHsHz7evcIF3f0DJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/kXM6+V; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c0b4a038fso1473262a34.0;
        Fri, 04 Apr 2025 09:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743785253; x=1744390053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4qHFlUEgPfk8I50kLbzLY6Bfpxn+xaMagBJlQnZG6l0=;
        b=O/kXM6+VCY7OfpkwJUs+dAp7P42QlYG8OEvl3igkiQo3CIri4LITHG0yDuOLf3SXxz
         HvoXxv42uF8kMeltwg/JAIldl3+OauFR7NzPyiKTM+NMDv/p22REZeSab3sr9PGhTb+m
         YHXy6HLHMXgN8Gqj7HiThNtwWXs0QTHIvfSYPIU7v2kmdaYv0cS6cRVExVx7tfJ/jTWj
         Z/hwOXlVFZcxaeL7bZDlbl+PtoOCrNreewQC+DhSC49Rk3YV+Y6G5iDM2zB3239Zsrx2
         hJZKlXIGKaoefFA/N5VqeUn7lee8QMxHZc+XhpNtXN/u9p3NgwFKGxIWl617IvaJI8Uq
         AERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785253; x=1744390053;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qHFlUEgPfk8I50kLbzLY6Bfpxn+xaMagBJlQnZG6l0=;
        b=Q7pJHUsZk6nr7MwH2sfg87OK5gv113MsQaeBwK+B3tAxVlMYOIJHv51WqKnnEhs8mf
         qgvP4bZUh4IgTmlrVqCmi3sT3+CqdkHQjaouXgDIKIypjqit3McEZo6/Pgh7Uu+mnzIG
         3LgJ98GNpF3E18O296WdQctcowg0aNZ2c//tlu6YbKJeGnwSPDZWWw854IOzOc2zKAWz
         FZvQWQOaKVT4/o6WjtvG/8B7lw6EIZP0ibCPVmcBYwejNQZgl5wA56Go9xxWaRlTmG1P
         EWLbn8ZRh3iSwWZYHkmtmcfAVi4VkF2SZrCunzN5Or401SxA64rJGvm5whMPyg3sWbo/
         vlSg==
X-Forwarded-Encrypted: i=1; AJvYcCUhUxsgYmRajWV+jt5+lCON/K7NgcZMuo9pD4v81F/eS7md/d+dhteJMSJ36HSZyyxoddzwsoT4d1zUxeg=@vger.kernel.org, AJvYcCXIfgR1Fi1tnrGf3Vwv0RjYSXAOpsw3zzi5XYvIE21P3jtT2t/eZUTrybeM2tDtJPC/eCCPg9KY@vger.kernel.org
X-Gm-Message-State: AOJu0YxoaN/SB2oFOlclMXE6lcuGNqITzG1DU3XswrsSxayEEn7zZ62Z
	ubBUpq8dSULwYwScPdS84wBgwiXv6PwBc201XF8VyVo5cfAjeKlX
X-Gm-Gg: ASbGncv90BzcYka4yAIqmwe7vYd0Redg8+Z5W52hNf46tyKDqFhiwwNmSbZZt+6Z0Lv
	tzk1V3NpXRJNuOlkeu3q7PXyYJheUJUzt3ztudeQGfOFx44Qd2hkyMm0vOXq2Vkm1DQMhaz8Ooi
	h8ro/pCQquG1qVF6ovhXhyjBmchPbaQewGTYx18Ym7WcFTorDda46wAHdAwRCijVd4Yg1hOAgBT
	gWZxrwkvIFKqE6sill2vULGRYnGy9vJW61XS/qVg1hA46PV3eGBJkB49LZZcj8tUaLEhU16p4o9
	JZ1EInZ5S2pmvpmnWD/4UULE8aM2leNctp3Sy7ee6i6pdD/nRaOFOYbs2SZfcXbyDCteVzFr
X-Google-Smtp-Source: AGHT+IFCDH1WQvthzsuCflHZaq+IszPEDGqFQeCGyzAal9s00Vvb1OROP01ro5EUqCKz7yjuxRvDLw==
X-Received: by 2002:a05:6830:d84:b0:72a:48d4:290b with SMTP id 46e09a7af769-72e3686ffb6mr2691302a34.26.1743785253004;
        Fri, 04 Apr 2025 09:47:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e3043cc8esm726012a34.0.2025.04.04.09.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:47:32 -0700 (PDT)
Message-ID: <2725cea1-4bb2-4adf-a43a-8edffb5a3fb8@gmail.com>
Date: Fri, 4 Apr 2025 09:47:30 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 00/23] 6.13.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250403151622.273788569@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250403151622.273788569@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 08:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.10 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Apr 2025 15:16:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
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

