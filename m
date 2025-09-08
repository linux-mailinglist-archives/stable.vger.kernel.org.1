Return-Path: <stable+bounces-178980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF71B49CE2
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555023BB302
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BF62F0C6C;
	Mon,  8 Sep 2025 22:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpHirkak"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F82EB87F
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370938; cv=none; b=N5L1YEdVaUpXCCIG+eoMY7zdAZbclRFcSIjLloCUgyI/tOgxnVYUYYdlAJl/bldCr1eXqHdHLWIeHxNF6xWJKJRELaOcPvw7YADbJvf6A2cbvMjGFyw97HHqz/RHjZ9zOOo1+68rCh2PB+WvzP6DVgKgUjYHhyk3TcitEWU3KIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370938; c=relaxed/simple;
	bh=jokPdzy+QFXUQhnXK24Nqj86DGGIIehQPhNMfk587v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJ8yfvtEFgEH4K3VsA+YhIuT7Mf81JNyn4AaL74uJxaES+VJOEUkV9SPgpfO7BKSpN34Zf4qpZouZhGowJly8poCkK+ypSQYeKrlep5p3La7AVgOedsh4/OgjNBFhsmSY8e6c3F6M+7W41sR0fMR3RELszYY/K2snojrx37PwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpHirkak; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-88c347db574so40770539f.0
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1757370935; x=1757975735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bjV+b3hh2hO3TSHHe7wU0vMi5wwisl90Tr3zOtLYr0=;
        b=NpHirkak2Q5dLEaisU0foSDso301k3+q0qjpu/W8/T5qxPTJLoo9n/SehqiMFieuHG
         ORpzJoIeVYrpQ2g/SBIdDzC0MymBva0ogcHUszr/1WFcuGmcVDGUIk3rX9G2GvTKGJ/b
         /pQftPq99rG6u7umG+SuiAS4GNkADoNQeexMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370935; x=1757975735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bjV+b3hh2hO3TSHHe7wU0vMi5wwisl90Tr3zOtLYr0=;
        b=nirnlVyhY2DboGoGDMov1noKMfD9/H78vWOih6Y/y/bkAWS94apHqpitWySB+Cs+Wg
         cKKDAvPTc2Ta9GYVi/7SpumQhPS48NuwxVZBDJVKsln2lzGJVvmMkQkCyh5lUDhwmd1W
         WORpG2RcuEwmLFpD3MDzdso+hMsnK+rlrnhXI8qUJ9KLQYTA79geonWWXj98T44X46H0
         U7mWXyp7AW0DYsAyRZudcQW/OhfjeQ5xbwbGgAcxRV6Me+hplhg207AEzTETDJhHLR1b
         yDzbrNqJzLi8yir7tKk6LrfKQojz4cwjs5VilqO9nsATIYGqejC13zJegQb5NgEYLfoe
         DPPA==
X-Forwarded-Encrypted: i=1; AJvYcCUeygu4cR1Q6Zb27uUG39ge5u5D0G0OgcpCwarTyG/Fb5kJHSb+hn3YIePLwAPR1+4u06R4CrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAFQkHDlo2hpQRO24xGGxPd2igVSkJ6WjhVH3QJvgFZbsMrNf
	PCZkQu00hHNVuMGChGMbwdDxlSPEYShvP497szi8pratN15DGJKjdwPwUpHdJ93Xn/Y=
X-Gm-Gg: ASbGnctREjyoNbG3Teo53YI0vFobFe7RAOSwcA+2aVJLXeUQhMSGelNEHDEYooX5KXN
	krsGJumhU3bO13aZMqVu1a+cS/eTEWojTsTNJSOaACJ/Rs2/sbe/qoNcSrc/LlY/q4K7O2fZDno
	M3J1r4eBHqiqx+uRV+TUrmJJCNtNPmc6/a/yryKgx5ZdI+q3QIJhrajRhX7Cqa847XfuwgvC2Nb
	hvPnV2gbWKayaLMBhGfrJDHuWOMVQNFjNDE1jIApmnvqKwrSmkXHs0CGvxg3HPujv7n/da5P79N
	Zmvru+jYe/at5nvWkK0zUncDjalU997IPtsMpyrwS95Ey/fwd4TFz6E/NSploFXKIdNjgNGqAw8
	xOwO5BHrRSlDA3gMH2DYXOiMi5U9jqEp9+Vo=
X-Google-Smtp-Source: AGHT+IFkKB76IaSWWVxO1VqoPC1DAvppF9S5WYqdz/wBv8g28ZnA54hUe3zUoEpuXFiSeVDiy/Dncg==
X-Received: by 2002:a05:6e02:164f:b0:3f3:82da:29f2 with SMTP id e9e14a558f8ab-3fd877813e7mr117569685ab.24.1757370935586;
        Mon, 08 Sep 2025 15:35:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3de24e723sm112127645ab.7.2025.09.08.15.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 15:35:35 -0700 (PDT)
Message-ID: <76c82c3c-9d76-4f74-ad44-a6ecad0e6590@linuxfoundation.org>
Date: Mon, 8 Sep 2025 16:35:34 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/25 13:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

