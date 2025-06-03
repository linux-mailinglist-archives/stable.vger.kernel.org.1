Return-Path: <stable+bounces-150736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC82ACCBCF
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4DE16A360
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234EF1A256E;
	Tue,  3 Jun 2025 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHSISCRh"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9F1A3172
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970778; cv=none; b=ektmEVf+1wNiaYEgZ5SjOrE9exAOpVIFpMWnVxXnilQOzobxENmOn66VPHsu1Jo0dNkvAAxryd54b1MUTwkmxplXbpSvkYCTH1CbQ0bcwDlzzj79P+/30xQUV+EA8jYkwio9a+EGYh45F6fbWE/5jQ7PU1wZDmdHc+hCkboANLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970778; c=relaxed/simple;
	bh=SI1mAy6K4lm5YNnUqqJj/WtqEcaaqnPOHPfCDszHvUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIDpGvBNwpGkyJbqx9MXsbBYuRyCCXNiwnU6hgskvFEsM7tcg3Bx+L9qRkoUO54N5Q+3lsqqGLJj/SiCp0GPB/VGuhHeHKcelmJvMV/kAHber5FkXJj/vN+qrPu9SceUt2f/5lfl4AOPBeqK9Er3ehLrrVNmF3VPkeXrFma3t6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHSISCRh; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3dc7830a386so18569495ab.1
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748970776; x=1749575576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxipSsAkichQGT02oXY7CtjNAbrB7m+GC/cvW2mwdPc=;
        b=SHSISCRh1dbcY7v6lsttTaqbGekRx9j4ftmV6VH4pglxdATjJX8kJPmMvrZ43X1iRd
         Qjyc9znX1bij7aZd5DVP2Y5KN6/uKmCDNOVfIe46d3p7LArWn+MskF6jRZUewqm3chQ1
         Ukn1l0SNvCsTlczSUfLPR+bGeWfH/lf6405Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970776; x=1749575576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxipSsAkichQGT02oXY7CtjNAbrB7m+GC/cvW2mwdPc=;
        b=FschPjqQJ968/+6VErYEhw7MzzLVoLNRd29JBcyajM1t+CKtwm2wvPs8it5WuQFZfU
         X0S5v5E+cDzsxL/T9X1CGcJB6Z5dNelE1toUOOdjUYjGQg3pTdNDbY9oFuvLWOkDTY1q
         kYFNphfl3UHNNmhaNE3weOIyQSwZEUra46mjDhdkoJQHbzV40wnFCoo8q/iYbSUj3aUz
         XG//hjkbKy6XsEIrId8H86tlbywcS7V1ie9G+z/qkL34WKVwEnG+H+GHOKbpAcPWRnRL
         c0hdtd6SLBL1f9cxbtO/TscZ82n7Ic1onbwectKsy1nH/D/ch8lwwX9ft4L4DMJbKhZS
         CKew==
X-Forwarded-Encrypted: i=1; AJvYcCX983Cs3kmljeujowgXwBeFeFoCGorasO1H2M3OHVGPTH2aDu86vUa4vd6OkMAhM8Y+Nt/A/Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNRhZNu8y5ZACbvrAtmBlUTybzlgjADuysoIRMkSDBUI/EQqD
	g2Cg6zqSW1foYGKMZMfcAZGOFMSOuFRVt+jkqZh/5t8cvEUm0cCg5DRpWkbo32+Y4oQ=
X-Gm-Gg: ASbGncupxKREGnIB7cJHUl6kAO4c6P7TlTouL5eWPRE14KF3PrijmgnWpvdltACbXOP
	JTA5fCkeesPj7OFLuLeSv71Mx2Gj2A5JH8aeWEHZwDeQ+OFSZBUWhjTX80Lfq0Pa31SJiQ/hBcl
	ZoOmb3aBc+jEnubS4XdsElhXhLrxGe6R6A0iY03YJ78npmFta6ESfTEENEIfgQRg1pMyepueUw4
	1PoQepJhnr9miFbpC4M198lLkGm86jFQwMr0RxlZQwoUv+zLqKCihjZwFANQYFUzVe6sln9JLqL
	qa6/z0bEnjY3hJa/aN39wIt1AF/9DTIhkDpW3V2CQ8bhiV2ljC/XwJ3+pn3MzZnYXTnosMNu
X-Google-Smtp-Source: AGHT+IESXIfXyJ7aYiQmXE3EiJ7rnApNSIGacwWXavrUtkBPmHYuCguUJ/DRscPqaTB80ts933EkpA==
X-Received: by 2002:a05:6e02:2704:b0:3dd:8663:d19e with SMTP id e9e14a558f8ab-3dda3370d40mr111673775ab.10.1748970775694;
        Tue, 03 Jun 2025 10:12:55 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7f22536sm2408814173.134.2025.06.03.10.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:12:55 -0700 (PDT)
Message-ID: <4517feb0-04a7-4413-ada4-582602abbbdd@linuxfoundation.org>
Date: Tue, 3 Jun 2025 11:12:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/207] 5.15.185-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250602134258.769974467@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.185 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.185-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

