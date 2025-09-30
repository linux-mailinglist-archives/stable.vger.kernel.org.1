Return-Path: <stable+bounces-182863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E7BAE5AA
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D5194501F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 18:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFD124C077;
	Tue, 30 Sep 2025 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClYQCZ3G"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F13185B67
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258294; cv=none; b=qRPYs7BucckVLUhcCnXaYgvK24LyNVIXiojoSlpovSvqjcw541NPMWN8GAZFVfo3+67ENdxPZ7qGaACqcSpKAFYYQjrIOKv6l5knzdlg07KsC66eIZL0vYa8ktb1b8+tg+T70tP1cx0SFm8YKQxYsDN6NE80cFgl0inNZ4/xAkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258294; c=relaxed/simple;
	bh=dYdnX8ie+JZ5tjHIeJUYzVzetNEwv4GKCyotFs/b7is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsrGklKzeqNHLijP2IZhKO6e+fzJIUbD0jCahiWuBIlx/2ovgxAHhIDxSZ1nI89o14uuNHacNsj2RmSGei9FUzkD+hNL3Ity+w49pOfLBcyFQOjF+6LhZlHPUpJBTDYeQDMHYnxDFQXVtlxutDsSJlPEnUIaa8tRnvnZ0yD4G5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClYQCZ3G; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32e715cbad3so7408701a91.3
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759258292; x=1759863092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve1C6vWoOmZ19F9zqw9yKxDVhyGQuev6ZjtgPA7WGW0=;
        b=ClYQCZ3GOKhgfd0fxt+sXykWn7UGBZ8MMK4UuuOpPO5gsSUcqDfJfOeFpJE66WqpeH
         XapUjyMvhA3y0Gmsk1JY2cdFTzcxeJXqxFMx/Ugkc8WTftsnt8wBkrPqADol/tT+EHQE
         m4VwX+WhwJUx04BYyDfH0NAWjwT6hlpbAU73yCJChwe9/Esv/N5GV31Zl5Nms80VTBm6
         85h/O5LQSAGGBh3GvT/3JyKaVM/RlLvkQKb0xFhuXxAegtZzG3IX8dvKY4Z5p6a8QZta
         nCrn14vLLjO5SDtosNmpXjNFzrUByXycUc8dQpVPKNbd2/ojLlDnR7UTAnw/tazK27Sg
         2TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258292; x=1759863092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve1C6vWoOmZ19F9zqw9yKxDVhyGQuev6ZjtgPA7WGW0=;
        b=AYrvL6zYNAPOxlu8XqER8eUAfrDuIfqItButMUunr7++AqMnMM2UUg+mHkryHfi92j
         F56h5vrFQEeq05jfJgbzTT5m/WeuFU21cJqWIYLLZ2X6wIj7+biWWY43miL4BzXMcIFj
         6QWdAdjFDIZpwQE8epMLMeYfRkqg77l3bBII94Eitfpwou+mbbrbfeVwTP9CpcKvdaFy
         XrdGM9UvMYrBRsKbG0KGLx8x0OFLKwyFGjS7K0qlwO30ounHWEJbq5/e1jqyB0DKTn76
         RbVqjG05juH3pdgmpRrK2NW0XdbKKTX5OcrBQ/5fvf6yYsL1njxEskEfovIkzeW85Zu0
         YssA==
X-Forwarded-Encrypted: i=1; AJvYcCXVHJtKxjT25FNB1yjfmXuRrQV8WABjdY5eQ0RMNEZJxJARMKkEQ9EgVjfY2A5mrq6AFq95fWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ws8QmXbYKD1NdehiZCuATea97BdCsHXH+fKrJ3sQGpJHS8uo
	lwaS0LglJPwRyTGlUjMuEGuZIgHAvNLbd2Shd1+86xTG6tRoXGottMsO
X-Gm-Gg: ASbGncujKr1ILcvyM7V0Ja6d9lsRrDyMJK9HTIP+5HPKdDvD13+Vx84Um68hbd37KIr
	9feBO7810mwuPtVAbXtyR4eKFauWNt9/E6kno/BK0w9SnGi7pHe9eZhHB+OgtgUgXuqej0HUcf+
	i+ZjjYJ++QwR4nZVqABPjl43xv597x+XkQYqEfX3MmOjK1a8KQaZvb2JFdj1narETRZa/m50oJg
	KFsO65HIzBL8TNF2QUTjU4Gb5uXmCmQj8QIgbguq9cD0OtV7BPJA5YXIbN8aHHahPXXViXyFBLT
	Z+QnAcRfIo6az/SyAVdq3ax8HZr6ta1p/VxbZuqlKYUSTimf88m4V0ZHG9zsrUNbPVZ82GLM//x
	7xcE6lpmw+FJQkEcWeIUZZjz6qrIj3UXhDh8Kyj+TRKKk9wZOrUHXbQHjsd8PgadnmHb9XQhoMQ
	==
X-Google-Smtp-Source: AGHT+IGzLc1/Ztb09xi04tvvcSj9Kk8hLB6B/Dp5tfeybrmtI9NtITB9D3tx2zgrXWtztj/sQ3lA8A==
X-Received: by 2002:a17:90b:3e87:b0:32e:6fae:ba53 with SMTP id 98e67ed59e1d1-339a6e265fcmr637049a91.8.1759258292367;
        Tue, 30 Sep 2025 11:51:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a7039cf7sm248164a91.27.2025.09.30.11.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:51:31 -0700 (PDT)
Message-ID: <4478eb84-a8e4-4b3f-8cfd-192fa0b8e3cc@gmail.com>
Date: Tue, 30 Sep 2025 11:51:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.852512002@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.50-rc1.gz
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

