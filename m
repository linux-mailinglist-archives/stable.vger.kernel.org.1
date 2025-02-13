Return-Path: <stable+bounces-116331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF2AA34EFA
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 21:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480787A4D2A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 20:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2C324A06F;
	Thu, 13 Feb 2025 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJyt9pTc"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE800200100;
	Thu, 13 Feb 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477047; cv=none; b=YXo6VapyN0SSAB6NVNE5hE3cwnrmvy13w2dFYArnKwJ3GjFGI8Q8SvXijg/FgaEvBt4Nm6Swau815v048EQ+HwL7VutgTIAmiTRNhkJMFZQXjfdmdeQSivN3+WmT6pK0c46uhDSaYGLEgj2H81/Kg9mhaaOZGpN5E5ii8w0kuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477047; c=relaxed/simple;
	bh=raBgMzdHvZYFnLe/MOr5SS00UMiRRXq1g0Pg9ZUBHao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsPpFfqgLcs69q+7jkDa2WrAgvJcBeYGHftHWjgo3Y7LynsELAZEV7f23ABuuSoOEaTvlA6pqPq8XF0+qi4cMRDaLRvcVet4wYf3H/sO+xVU8lq9y+BrT1ByD01nk45YfsSXYJpNf2d8CUmRu7bF9Bl9SwPf1uWl2GtNy5OyTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJyt9pTc; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fca61c7e4aso441501eaf.0;
        Thu, 13 Feb 2025 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477045; x=1740081845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bSYf1ZaaN8s9q3zV1/0JPduMcrRw1Gr3g+Qgt0nTVG8=;
        b=DJyt9pTcx29KJtHiGHyOObKOG2YCa3gKhmKBpICHJnyP8sqnqV/r/XVI++47pq3s+g
         gmDuzOFsEJtTLqyM+qD9nYwL5LUdWzbunSuJGzDDWoIn0/IlUK0H01WOR+QRZ0bOLv0g
         jLOFLdZc1043WsJgdI21ss7h19fLgfEto6m6RnqFFRGy5jYFSm6sjC5L3FoDGxWVSjC7
         YcMLFotURfdmWI7e+4w+F7vHoiLaqpetJc/4tcH9iiyI7Dimzrw/MOufmXvqVBV0sRuh
         ohKVgT7tYV2l5jKSQvFImoYhb9gpdc2YieG0dfY0Xjw5LLV+gIctl/tDurUbG05BOVZt
         FCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477045; x=1740081845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSYf1ZaaN8s9q3zV1/0JPduMcrRw1Gr3g+Qgt0nTVG8=;
        b=OsfLz877ATF1qzyc02rQpzzaD02wu6QUY1p8yeLezgPXkpQYVmbojauoUgiWrUNz4g
         tiPb6qoXxW5cs1De09z7yY/JZBI8oO9BgyyJ0FWxOK8DyWXFeXx1vI14AyIYlpsckde1
         plzCbIS2JMAQw3t5bDpm4QIIgnPKr4lTwnuIyMEUyj2KAu+QI2UUHR46cxi35/jP3A7q
         XTOa1AW09sLbhUdOd3c2JZI6c4dUAYWyAJdSxeDgQ8sxBAHAOOehBR8ojbPUyTNsXQ0G
         gwtRDERJJuJSeTbg8JDVVlktBUxZQihIPgCRhR8RmW92IjZ0e2pp+4/B08uyhQv3fMKx
         O3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRrnYMkVBD+FU8QUgVRXLA7DaWlDuI67X1DvGKznQjvPpM21rlT74/mDlWuGPYhTqZ7FL79+hj@vger.kernel.org, AJvYcCWg7fkWTsKbePOLez3zVkpw/7jDJzK3jsuPJZGFfTMiu+WPT7tEJuHcEmwGhKMTVOh/xWRn0yBFulqlk94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwITk7N2zu6coQm3B9iKfheuicYVB6o632uggjqwRE6sZ6z5X7l
	0DtzHcVztOKeBqSkMUAIQBKVyRJSFR10YUPM9ZS/+mCvyw48i0jw
X-Gm-Gg: ASbGncusSaFjMGbOxOQQphjfPKnlFdN9x9SoUbRJbdOpJ94YBVti8LAGMRt2/UYwecG
	Gfw6TYCRr5iB4YTbpbPImQhqwaSGu1aA8VQOIVdcW58jJWoCRj9FipNvzuSZkfWgKKP6y6WroGi
	lABbhnOHUkSRcxmpDYpNDdeDpZd3TFn8TxrAN2ljlDFZL5hIJN+ZcAQV9eftck0TVIqKEDXA2lY
	xcfU1UH849jRt7y7i26VS6Y5pupfKbT6pFGXcPDbm3+YrRB8CvS5CuP2WCUIKVs7I/Qi/IVwxPq
	yKpETcYyMK1ER0hTBRcgpZjzMeg3UbPAS0LzbnnUJRY=
X-Google-Smtp-Source: AGHT+IFR4uxJVSa0DFwHRw9uvDylKzafe26K/soTWpR1h4ANO8M2A8750RxcXEDq86fH370Gq8fTXg==
X-Received: by 2002:a05:6820:260d:b0:5fc:b418:8cd1 with SMTP id 006d021491bc7-5fcb4188d23mr1777116eaf.6.1739477044612;
        Thu, 13 Feb 2025 12:04:04 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb16a8de3sm817670eaf.14.2025.02.13.12.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 12:04:03 -0800 (PST)
Message-ID: <af611f69-4844-475d-84fd-f1c781dda73c@gmail.com>
Date: Thu, 13 Feb 2025 12:04:00 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250213142440.609878115@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/25 06:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.3 release.
> There are 443 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.3-rc1.gz
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

