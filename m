Return-Path: <stable+bounces-121270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C823A54FB5
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D9F18937C1
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B782101A1;
	Thu,  6 Mar 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FAQtqUfX"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF520F071
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276473; cv=none; b=WwnPseTFzzXPE3oL+plEZUZM+KNuXV86nEzkx4zoTR2p+m3+WZY0ACxDKfcyo5D24UUK+fuUQDFib9IW3Q7LJ2XutxryiwDh/OHTExU47MHxlqorWAn6UpNvC+tQ6Lo5f4L0LLupQOBW1UpN1BDkjmu+4uJY1dJyoNku5oRHsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276473; c=relaxed/simple;
	bh=Y8K5cESscjaF6rF5kbITcV9M+zFFDeiGbZwejQ8hVoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnjupB3OGDBQbSmoI+CtZNR1p+m44s/nxjKmjDTOLn6jnU+WEBi1IcPZ8HQ0C4Ik6j0sIPqQlbg+lIxG60fYC29Zu0/JGT3Y+Fys2KYpC/LAXfltUA43Kj3yxyzXNiNSIb8l+m2NvQJim4JdKEndpj501G/OcxBXF0an9fNiVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FAQtqUfX; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85ae9566c08so24030039f.0
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 07:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741276471; x=1741881271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UvOdZWrfaIf7exFCH9L/y4MUUS5qf5A06Ts9Vfm5eLw=;
        b=FAQtqUfX90XrY3tB3vnruqTPFNgMJDFtuN3F5CSktNqdryJVXPkosyLy5cuI+t0mus
         3MLFlZnRsp17dfjhrogQUCRCdobkuKPkaLbaoqlSt6cYK0Xs6eznZlJ0cg1GabkZVcDt
         cwDDpAsfe9BTDkBtj2pmziO31+oUV4c1q4apk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276471; x=1741881271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UvOdZWrfaIf7exFCH9L/y4MUUS5qf5A06Ts9Vfm5eLw=;
        b=hRbOaTs5DccfJH0k5QvAiUJZAjkCIvVtLIfua49vPz2iF4Q2NBm24q2C91+YYAktmR
         hrg2yky7aS/VFiW5Pg9nX89DSm914DUJ4kVjF1mY0Kmodrxb4P0H9vyj8qRsdQpQGJyj
         uUo2eMJvRo6YYB99A/d+IJtmHqYiY9Vj6vwZkXkZFqLRIf33j+Usu1CBmRq2AiKF/lGw
         vqGwqXCVbuwgYy/ZAXX7AzC0fd/IB97YcDTgKmLLLBlmXA3jAiosNSY9rSBbbVR91nYb
         xgOMOldMY7MUzVlVvlkpxlvVb/88/yC8ryZfcwcgqTgDpBOhPXMdqwbPin9sOzucRgvh
         gM+g==
X-Forwarded-Encrypted: i=1; AJvYcCXg4MdS8YST5OLS6LPJrWJOJ4IlM9NTdkJLHxLunyrsldxJDIT96q85yXg0RdHIiEWG/PRUTkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotWCW7Fp8ihoWPDI4HtYQfdjSgeBjL+6zr38TkXuTtVmdY081
	gjlMw8vwKTw9pQZxjd5ynG6TYBp+8qyZHoIDb/ph42JdlVzGlAHGWAv0oRYt6M4=
X-Gm-Gg: ASbGnctT0zYxPy0ADleP8EC9L/ahfLybMviWmBgMXMB23wFZPxW5B7iXbeMxK5rOvA+
	ZQ9f5h+amD9CVS4uqlQzdbHLYfgiIxPFjnwcNJkc+2rNPPj84DWGE0MKq/aOyLf5JwKJUY7lLyB
	E0ZIgCoVD3zI1V1YC4yal078hIj+Ichrkf/kvQqwFHQKSxSHpbw1kAT13K2TvZMxz+xw9xKVg9q
	mQAr6saqppoLDCA+lO83fBF8sPLKF+qvt8JR+TGh3iWOppwrZ9FDtuFXMmASDesu6yuMGv6mVFK
	SS3lRVXvjPNClFw7e15KDfGhybl5pu0UAIY6DYCBNhgzrGQlpxbCLxQ=
X-Google-Smtp-Source: AGHT+IHLDBt53t7ndm1iVGlgIfmFiG3NsTwS5qxb6ssEp7txk9g51NwIcfyHhH9X4AvTQef18vir2w==
X-Received: by 2002:a05:6e02:144a:b0:3d1:79a1:5b85 with SMTP id e9e14a558f8ab-3d42b9a3c18mr86895115ab.21.1741276470750;
        Thu, 06 Mar 2025 07:54:30 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e15550sm398211173.39.2025.03.06.07.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 07:54:30 -0800 (PST)
Message-ID: <11011f63-e614-4a23-8d9e-7aa1387ec65b@linuxfoundation.org>
Date: Thu, 6 Mar 2025 08:54:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/150] 6.12.18-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.18-rc1.gz
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

