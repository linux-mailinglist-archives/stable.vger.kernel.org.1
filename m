Return-Path: <stable+bounces-109444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15229A15D73
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 15:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1966E7A0636
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223618DF73;
	Sat, 18 Jan 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ/OA7ai"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588462B9A8;
	Sat, 18 Jan 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737211731; cv=none; b=YCgoYnIv6UfEVdwE/q21UtM9SWfC0GJTV6vEIeN/Cqk+4eYJdn8lkY7XA2DJ4EmpyBQgzITt+qjAFhP8wBDAVorD/nxDN5ROfGXwPyF/cjNcHolUJu4MwZx987nydUPhRhcA5zkwy1jA0EryMpIwbg3gcH9MZpHEzxDFWPWhWek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737211731; c=relaxed/simple;
	bh=WXStXyFZaWcEiVZmhppARBN00/359dcGtrrkG7tTYHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSv60HySj1JFeLUMTzLtYUWRAdD9UNu1TDYM9MVTZQclQdQRuNVNi8fa8X8+LeI6Kh7T653wU4XbdeHzng/f9vzVbdJPHuPoEPrTZD8tb1MOOGyaI1H5ClHsDlZjC0Zu0LIw2bEQB1J3mtdsuonBe/OMoT1yAJ03IXhM/65CHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ/OA7ai; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166360285dso60729345ad.1;
        Sat, 18 Jan 2025 06:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737211729; x=1737816529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ5Pm7uJSWgiHbsmoxlvZ3LbzzSHeTzbUZ13dlbartc=;
        b=BZ/OA7aijCRlYeA9zZirIxdSMwegbLVu6QZo3Fm7svam6frPW4V+RWyO3y+CdqNs/E
         iFuvXKRLnW29wYqQ1xWrlfh5FL9R7S34BjHCxxvO+8/FietchXnKst8vtrkxFuMSfKkh
         tyhVd457Jbq7YPF4+XPpFUoAhIuGaN9+LdZxoOD/xzCfKq8yed+EQCZehQYGPsIt9/hc
         nVB/lgGc9EXidY7Lj7YXQPaNLIxlen7cBmZ2HT0fDT/WNckGdxchhqKYXmnJjkP6BHxx
         B2Ma+ZuYY4rBS3LZD4JmTXIxAzetAiKrD7BjbuSuQnG9SIVuC1B/RteTYKpx+cY4868E
         RIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737211729; x=1737816529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ5Pm7uJSWgiHbsmoxlvZ3LbzzSHeTzbUZ13dlbartc=;
        b=AFoog4l5Tz2Iefeh3qfNSTUBBae66rfWIavSRFB74moceRsd3bImjP1EpBr1sWRSZd
         LEpZWuV0U0tsSepsIm/H4Un3pjYEhNDK0x+Uz6MJ2COJ4+Ylm5upaueEhN1gBlr6s5wE
         2xF1oHTb+WjhpmzTE5f7O5gHZ4WuB4EngR1yRZBRYt92bqcCGcjvANukPG4lnSk0YxI+
         WuLHKwLelpC4sGMN+0G5Tm4BB2tokL857rdv0nnB4ncCDLBYei5p9D45VdlRiZyH0vtZ
         5rMcTUFUk7CRo5FpqCCT3MWh+PAUCUnYfTJFfKN+/Eazwe3CAkmX5OggX6KR9lvahn8r
         KQtw==
X-Forwarded-Encrypted: i=1; AJvYcCVQcNKaKEHh95ZXmcWr+UbQXQ55p42/v2qLyodGcX6CE3QJHe8v6zfEHxhBNVyHXyGOk3V5NR8jNTATZRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKTogwdmL4ceLRHcEH61+lJc4ulrZ/eLXS4asQ4vVmSUcxYvt
	z3Wn9Xj3Tf9ciUMmkCJepcdgFForZCVm1H43Kte6+i6PQCr90/f6
X-Gm-Gg: ASbGncvmgnG2T6ALniS2dP5Ea2YYspEFxxVL2qvBl05sc1O7NpF3ddaiJv4jcL61aHC
	zXDQGiSPDeNu+QMSWdxkdwMLKF/OwkdkfHollLG7ZnmHx1NPbYGIjj58CoWiXnmq0it9Num04ki
	mygqiXvmBjoFpM8yTcJbnAF38iQtyweWR0++XL/lwOcVJKZTo+24jnnVHYPIEvF1c2ljrq6twhj
	weZ+zrEe+VQjDt1i4IjMU+7OrwQ6X4a9jcSltLYwraJGMLaN4TAUvS+o/ihkBU3M4VrQg2BFAr5
	ecKIjUEwHSFBFmEVrw==
X-Google-Smtp-Source: AGHT+IFnrsNOUiSzk4s4t7y52klnwjzMxfS985Z5YG9DDee9EIIJ78Nl4bVqPlnBpD32vnlbMarWvw==
X-Received: by 2002:a05:6a00:4fcb:b0:727:99a8:cd31 with SMTP id d2e1a72fcca58-72daf97b5d3mr10770196b3a.14.1737211729445;
        Sat, 18 Jan 2025 06:48:49 -0800 (PST)
Received: from [192.168.0.101] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba48bc5sm3922488b3a.133.2025.01.18.06.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2025 06:48:48 -0800 (PST)
Message-ID: <89307020-cc96-41e5-b0c9-998958b9844c@gmail.com>
Date: Sat, 18 Jan 2025 22:48:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/apple-aic: Only handle PMC interrupt as FIQ when
 configured to fire FIQ
To: Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250117170227.45243-1-towinchenmi@gmail.com>
 <aef452c6-1e12-4510-8fb9-1dc597cf69bf@app.fastmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <aef452c6-1e12-4510-8fb9-1dc597cf69bf@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Sven Peter 於 2025/1/18 夜晚8:24 寫道:
> Hi,
>
>
> On Fri, Jan 17, 2025, at 18:02, Nick Chan wrote:
>> The CPU PMU in Apple SoCs can be configured to fire its interrupt in one
>> of several ways, and since Apple A11 one of the method is FIQ. Only handle
>> the PMC interrupt as a FIQ when the CPU PMU has been configured to fire
>> FIQs.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: c7708816c944 ("irqchip/apple-aic: Wire PMU interrupts")
>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>> ---
>>  drivers/irqchip/irq-apple-aic.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-apple-aic.c 
>> b/drivers/irqchip/irq-apple-aic.c
>> index da5250f0155c..c3d435103d6d 100644
>> --- a/drivers/irqchip/irq-apple-aic.c
>> +++ b/drivers/irqchip/irq-apple-aic.c
>> @@ -577,7 +577,8 @@ static void __exception_irq_entry 
>> aic_handle_fiq(struct pt_regs *regs)
>>  						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
>>  	}
>>
>> -	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & PMCR0_IACT) {
>> +	if (read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) &
>> +	    (FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_FIQ) | PMCR0_IACT)) {
> That's a somewhat unusual way to use FIELD_PREP and I'm not sure the
> expression even does what you want. It's true when only PMCR0_IACT is set and
> your commit description mentions that you only when to handle these when
> FIQ have been configured. Am I missing something here?
On a closer look the condition will evaluate to true when imode is between 7 and 4 inclusive and
PMCR0_IACT  is set. The intended behavior is to have it evaluate to true when imode is 4 and
PMCR0_IACT is set. Will send a v2.
>
>
> Best,
>
>
> Sven


Nick Chan


