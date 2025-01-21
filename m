Return-Path: <stable+bounces-110080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B26A18864
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 00:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFF416A877
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 23:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E9F1EF0BC;
	Tue, 21 Jan 2025 23:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Seu6z95Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983C383A2
	for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502289; cv=none; b=Rhv5E7R4d72oiBFE+V5Lw4lYhuXt0v9/NsyBtkp0Bg8NoTxSmcsrZBuhItPH0MBOK2nlm+4JEU2s6rQzSgHsFMTdING5BUD9bpdGmh77rypeDKQHWHAfc7xpphWBJHoH08pl/cQGNvRt5Mbs6agKZU2XwnAdcdO+giuyBfuZLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502289; c=relaxed/simple;
	bh=PZCkdhLbFzcGNdyXRq6qE/0V4KvBw/aACw6pkE9Gzzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR5nKDDfaf5j1Jumqujx2CFG3Gv2tsxKGPYSuEeT5Y530TSZR6CyEjAFS4z89Pm3jrlL1lUvoqKazxW6UBK+n7e0vNBaIvCCmicVnYME8dkDtK7HTGh6fJPOBAKliJG5Ld2i1abqYxGwOpvQKe2sWt5Xb7GCISurxyHnLgeHsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Seu6z95Z; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a8f1c97ef1so20346075ab.2
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 15:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1737502286; x=1738107086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ie05JvFG75EEIuwtxZdLJFA1NpAu8+JaX3Lya3Hz0D0=;
        b=Seu6z95ZyWWkC2ftkqr7gHZ1RZCUn+KlnItVsJZBlts3KuDAZR28FDZ/q5HnT1eX39
         5iFk2WQTPiyUDNmoGQQr072QAqqp9V9sjSXj/sHNOEXNZhKInHDa/R5kXo56OVVlmIs8
         jFU8n7PC72JgkeMHa9e+MdiqlUZqgTSM323vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737502286; x=1738107086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ie05JvFG75EEIuwtxZdLJFA1NpAu8+JaX3Lya3Hz0D0=;
        b=diDL+fMmzsLCSXr3qgcJ62Fh7sDcS0jBjz+APnar0cvqiHkJ/7t0MWSS6gDOWFeXd/
         r7uaGyzXRQa45g3YMv0oKNUm2Gtv2kMaX70iWXvw03ZsRVwPfJ6F4OCvhpq97myDi1O+
         P7h2wlOr2mc4V7o6mh66bhozoOihjQQTzb+/7S8Lr4O8jucDRxkQJjUnWGcxfoT1WBWS
         p/1KG3skKGHpPwUjy+qxgARHRjoovc/4t3T3NQT5Rl0xauS8fyvetgQ+bSyxuJ3lY02J
         6xSTgFSkmdt0cGCfreACNFA8p53qFLjvaNVbBDa7lP/URER7vK8S8GQWDlFTpTNLBXCw
         dX3A==
X-Forwarded-Encrypted: i=1; AJvYcCUFOFnj/f8lWWhK93NyrPHZel8RIJS5nm/GclHP64LHipN8vQJJQTcig3UiYjVJJG5g6L9bkeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0o71cfDW7hGjU5dsjC/Qbk8Y2G/e/x31dPccTONeFR/BlEpAp
	Q+4sf/jAi4LDIcnTj7c9Gr1KjhCjHSXx2VgsTF8hWPkCCL+MmZZUmRsGB1dvq++hGA/lWlXG0/y
	N
X-Gm-Gg: ASbGncvJW/8F4WkE3muxNkV0HhDRV4gHvNt6fQXFLML0N4V2/fL0xOGj1hl+DlN+4I6
	7geG526PVjTNGhoLBWyUO6cs4EX7BPxDUJ8Hi21uEyjLGNNJMaSIQZ4xmAzOopDtbK2EFo2wEUm
	HpUhxjAEvSzOvaUfxL/p8RSwFn9cqTKDJSo1PJp/ldxvc8ld9K4+z/AagWWVBufgdk4aSVdZwo3
	RTYauGnnGhvLDqYy7QfFPMbrLfibpAB5KwVZp7aopcBFl3EhDrK10fpf2KdzpAP8ok/Mcx7EVuu
	hJ5x
X-Google-Smtp-Source: AGHT+IHoTgvGp1m+EC4hRvJ+BehRy9B6ZzJHn6KpVe/1HpKtMMZWpKSYLq5eddJ+i8flNB4nHUwVMw==
X-Received: by 2002:a05:6e02:221d:b0:3ce:78e5:d36d with SMTP id e9e14a558f8ab-3cf744199c7mr176151485ab.12.1737502286056;
        Tue, 21 Jan 2025 15:31:26 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cf71a9e48asm31867645ab.24.2025.01.21.15.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2025 15:31:25 -0800 (PST)
Message-ID: <196b55b0-9494-417d-8845-9a739fd77c09@linuxfoundation.org>
Date: Tue, 21 Jan 2025 16:31:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/122] 6.12.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/25 10:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.11 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Jan 2025 17:45:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

