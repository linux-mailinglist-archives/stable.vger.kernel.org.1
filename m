Return-Path: <stable+bounces-134594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C385CA938AC
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF2B920DF9
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947601B040D;
	Fri, 18 Apr 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bKvBv8Ro"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269673451
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986618; cv=none; b=irIIFWkKJXFF2KF9Az5wImqM8oiqdiMoiHnY60VocCDndvuAb2vw2RxnuWYfoONjjtoh14Ci3yDjmfpKUE32QztdL4TKcdSdcySIQLKO2+vKt7AK+DYgtnGYe/T6eFGPNBpLKcGA3jL1Q1Q3u0+41YaAhhZ16ukEIrAPTZOniG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986618; c=relaxed/simple;
	bh=y52Pjz1ACjSiMzj5j6qOs9QaWh8OcxZGdCpc07HXUtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=haEwKekjQFtnCuSvn/3tMYMWvLItcrOjvfjRNBAsKk6Aw4pVFlaE4uEPbAsGShqZ4uIjIr5G++keUyPM1iOj8NIAXWdGWuaFOs7jCFP7xkxbGU7e5lAS87l3SJM6bXRGmFhzKwwWHPVqHL3CcxcYmj4W2vpgfXwpefHOnScFn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bKvBv8Ro; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d81cba18e1so12554835ab.3
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 07:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1744986615; x=1745591415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+DrJFQCA6EQjbNVUXpVraYRT/z+CCrEaV+7erS4l+0=;
        b=bKvBv8RoDxsg7PjmYQz/TMw7P/bQyasg9UMYWVqAmxnx2MhP5570brtU0IDfwNzC/8
         PAc4RkbNus82EBvxEp4PbJL2FZEtH7ZUaeK/TX0U4DJeDETfJAiduXoYUNHV+2GOVP/m
         g98BdNvw12Q5nFZ5eAt95+FxLv5BpzNUP8D+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744986615; x=1745591415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+DrJFQCA6EQjbNVUXpVraYRT/z+CCrEaV+7erS4l+0=;
        b=g6POmxNo5fqL+z1hh1j/+rRchJ1W56pvXnOQlUKNHRu3Y0pjqdbzBNS9+oEYuD98m5
         sUfk6ZVyPCb9ZunFHhxxyuU0qmZuXC9St9Fn7JUAGkmopLtNp70/YvMQ/k1axYssRbwK
         FZ/GElQ61w+msZpGIrVQ4AU0xedpO3mAgMM4c3ll6tQ7GgIBPbcI2xfKfdddumpvtO3O
         98ScRLqvdzY/yCXfyF/d1PFJ8JySFeG5nWfCVK6XJOnhW/kcK/PeUbSEgUIjJEeRJ36t
         cGYNWWXdnHHm3mUSehLZYFivO/G3OogE3C/RilbsOxY6Yu5ARo0dCX40C5g91Fj/h1zq
         74EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX7stsC+gaVjDYue1vg/4qLgyaYFjtr2AC5+hCLSvQcO06IrbDVUUmcJrOxO2aVTEX6HrE/Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjLrqnn/6FCi4jzBPQeD8hg9Sm40o6mS6q7TmkVZ7oAkghvTjn
	o8+QypszwyQJc2ETcJSI8Lq4etQ66WqzXE9Lx/knNT1ZdzyTxb61v9L1fhKmZ+Y=
X-Gm-Gg: ASbGncuxZmGQFR9xjOuQk0Ki1ElXT17O2eVJMWInverdulsHdfhZ5Mme3VuzcgZNJP4
	Xz9BrXgkX/ry3Gw+s2Yhjw3F/yf+M1SY+Q5WpFfYO1b+BzBUGMnXgBSumhobtVkU8lx2gDX2l+n
	g2FOxdg0/wcnR/HyXQcFRQfE2eFUMIfD3xl4QB59rKFW/lrKXJAYMq2Pu/GWJFgQerO3S8c2YMJ
	GPI/KiL8eHtpdIj4/OLLiQj5nFNamZIjGO7glYevAtYVeebGIELYdsBqi1RyPsUjGA9TA7NULh6
	uq038JWr8qLV0gq64hyOmZJDU+mFCjjElSTQJrE2IEU6228sQKY=
X-Google-Smtp-Source: AGHT+IFA83L5hUxqqmTbet129g/fiwMMso0nEIQL+ThEQwkZJZTSp9HJ7jI3SU4GxtqStPvfy/7M+A==
X-Received: by 2002:a05:6e02:308d:b0:3d8:1bd0:9a79 with SMTP id e9e14a558f8ab-3d88ee75ff8mr39030005ab.21.1744986614675;
        Fri, 18 Apr 2025 07:30:14 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a39335efsm469087173.79.2025.04.18.07.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 07:30:14 -0700 (PDT)
Message-ID: <634ce469-983d-4153-ac62-0dd7c3876d45@linuxfoundation.org>
Date: Fri, 18 Apr 2025 08:30:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/449] 6.14.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/25 11:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.3 release.
> There are 449 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 19 Apr 2025 17:49:48 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.14.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.14.y
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

