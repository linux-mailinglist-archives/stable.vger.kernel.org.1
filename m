Return-Path: <stable+bounces-77720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D914D9865BF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 19:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800321F2475D
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CEC43AB3;
	Wed, 25 Sep 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VhUrhWCT"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B512E71
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285778; cv=none; b=ml/c3M/RLeOoKZH7PWgb8jcZ0bilZYXoYdG2kkvxFI14JhI/FrbU6i0hFes8v2R0xM30YlnTupTBIl0N0LmiIYQ4VaEtlvtPjE712Klc39HgUDYOHDkzsxw9UaHbsQqzYwiytXcdEd+Z0bA3KUG7EyyA1i5LScyRwilXGTc1bB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285778; c=relaxed/simple;
	bh=tpzUgWz2F4mh6PpBfMDRRiZjLxD7p+XPhcH/CTIw3go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPyPcO207RGaj+YU+q95MPnDxFmwEeJHR91RN4r0cmzlGYlIR+szaAtrW2agW4vDBYJh8641024CMNJOJjnwODhHlIKqg6V9bW5MfkI92oLrKf2yOYUlEpaJRCEN0ppGe/fLCPXkjnkI+aNdkQOINvGy/x4dSe4ODroXNXCxrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VhUrhWCT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8323dddfca2so3576839f.2
        for <stable@vger.kernel.org>; Wed, 25 Sep 2024 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727285775; x=1727890575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBtv36cM1822wM9xp5T2UEmjM1+Gj32dDwzLC/bT2Qc=;
        b=VhUrhWCTtNTOgQrRn0EwIJCE4CfTjJYO9zUDgF612gltQYmRod5Clpoc17eoTGH0pG
         hSM2ryjGuO9Wy2O5lKJhWriPE7da5uPO+XAQL785d5/MwY0qrWlaJF+EzceTnE2gbHA7
         f4d+qBc+YRepspEL42jadVTkZQCcg3Wn+STpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285775; x=1727890575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBtv36cM1822wM9xp5T2UEmjM1+Gj32dDwzLC/bT2Qc=;
        b=qa3vg+6GW8POEVDluesj2Xr7dw8fP69SpO3kLAsSJu2e79diS05ZCx73dpC7ThMmcG
         tJX68XDhN2FBBE14PM3e6gqEKP++X9ZB77sfC82lJdV+miW5aZQuMMAB7frJm7Osif+A
         6pl6fbkqsQ7kaKm3KnH6SQ12LWo6GhIVmR3yGmiWCTzYzOs63PlQKFL8HawHpwZeFp66
         JmrFTcy/d9kGCfMKDxt58zo0Eqhm+I4xtc5voYpJlX77Z0mLV/Y+findR5Tu50u22QLJ
         RaeTewXAl2s70XRtlRGAvv7ZONxt10LT7fFp8pB+eqEyUIaoaBicm8qaVplOEzMK5ZRX
         eKDg==
X-Forwarded-Encrypted: i=1; AJvYcCWdy8dPUBhdVY/Ve9o/OBq8amzNkzbuKoHTsSkv71LbGn/vk0N1+1b+DpngvBm37b4rJsrBopQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKOJN9ECXtUO8vgmqFI4v7EQJinflEbgmT3sOmTgzEFeyn0xUF
	OMNJaXURJhPcXmwXsvc0O377YAHPdRiMm2YogTPhZ17UFbvs2cA4oaAkGXDFpX0=
X-Google-Smtp-Source: AGHT+IFNGSvmKTORYz8kN49AijuoTSu5i4fVW5IkrvopPpqCzy2DV+redPl3qq3vMh4nn+MjYo5E1A==
X-Received: by 2002:a05:6602:2b0a:b0:832:13ce:1fa3 with SMTP id ca18e2360f4ac-83247d1f11bmr530003639f.8.1727285775165;
        Wed, 25 Sep 2024 10:36:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d40f1bbc5csm1187281173.85.2024.09.25.10.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:36:14 -0700 (PDT)
Message-ID: <0aeb151b-9f68-4db0-89ef-337868515d85@linuxfoundation.org>
Date: Wed, 25 Sep 2024 11:36:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] selftests: breakpoints: Fix a typo of function name
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 stable@vger.kernel.org
Cc: mhiramat@kernel.org, keescook@chromium.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240913172852.3690929-1-samasth.norway.ananda@oracle.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240913172852.3690929-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/13/24 11:28, Samasth Norway Ananda wrote:
> From: Masami Hiramatsu <mhiramat@kernel.org>

This from looks odd. You don't need that.

> 
> commit 5b06eeae52c02dd0d9bc8488275a1207d410870b upstream.

Upstream commit 5b06eeae52c0
("selftests: breakpoints: Fix a typo of function name")

You can mention you are backporting and the details below.
Do check stable-kernel-rules.rst for details

> 
> Since commit 5821ba969511 ("selftests: Add test plan API to kselftest.h
> and adjust callers") accidentally introduced 'a' typo in the front of
> run_test() function, breakpoint_test_arm64.c became not able to be
> compiled.
> 
> Remove the 'a' from arun_test().
> 
> Fixes: 5821ba969511 ("selftests: Add test plan API to kselftest.h and adjust callers")
> Reported-by: Jun Takahashi <takahashi.jun_s@aa.socionext.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> [Samasth: bp to 5.4.y]
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>   tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> index 58ed5eeab7094..ad41ea69001bc 100644
> --- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> +++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> @@ -109,7 +109,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
>   	return false;
>   }
>   
> -static bool arun_test(int wr_size, int wp_size, int wr, int wp)
> +static bool run_test(int wr_size, int wp_size, int wr, int wp)
>   {
>   	int status;
>   	siginfo_t siginfo;

thanks,
-- Shuah

