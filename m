Return-Path: <stable+bounces-27484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C05879AC3
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED3E284CBD
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753D1386AE;
	Tue, 12 Mar 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="W+TkKQkE"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81670137C24
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265214; cv=none; b=sFW0GnUrfcv+lYiAmiNSkseqWQFfMFTjO/LFhuH7JkL+EFS+/KeHmAZF45rk1gw0JGbjVCK71YBF4tBLErQqFGfvdY8pRTsZhgtN7LId0AwKUQuT5ACMprHpEAnt0qJE8VM58ltJilHwRWdeSu3JxXg6Jt76ny1b3sy16dqXLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265214; c=relaxed/simple;
	bh=JuEmybPeAFM2LXxM+nRHiwifY+hWL0Xv8pXcFAmrED0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPM0olSHyqpLPVMBIUELjDB3j8q7ZItPKnihIBt2Y4NL31LgdriA7igtghVZZR95CKjW8OFIcP5y+ZPqpbmvlLlDzXUEDUqr73fpCv+bAkDWVpa3MD9d/N5WXyLQFMsPFc0qIG7eCK2R/d5jVXSTKrvnqp+5D7r7gORuv+WCsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=W+TkKQkE; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4d35666c4bcso41445e0c.0
        for <stable@vger.kernel.org>; Tue, 12 Mar 2024 10:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710265211; x=1710870011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpw2E4SJc0M22jdFp92JFgYe9UBmYMEBdWoo4cjNNVw=;
        b=W+TkKQkEpb4Zao7wbb1+ptCv8+DxRgNs96EbQF5pnz/Pc6z5D33oRxC7TFLehvC+bN
         aWaB9clofrKyENEW/60uHOKEY1XLPuOd9LnzWlZAODLh8flucAbCEy+rsPpOo0M2qwjr
         D+8g88+XPDURVFqQvWtzICvkx47p1ZRNJ6kBWkmhUcHw99TRgOvUCrJrx3WFDzDHIAVA
         fj7aEflJ7gGJk9eDCRT/1AdPo25In50/x/+49ZQy07rpbLva+kyM0YFjCrxA/2+nNkF+
         w/wO+V5CbWOAE+sVMAkWZ1OZhFMma0DK1kwQdq7YLBf1ZN1f9GQpdp+5VvlP07S+vH9b
         lHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710265211; x=1710870011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpw2E4SJc0M22jdFp92JFgYe9UBmYMEBdWoo4cjNNVw=;
        b=NGDMcjyWFsjpdm5h8HFcp8Dl7EvQGwQsP9Haptbx2OL7H1HJrKMtG7Qizk6WDFehks
         hz+hLCnm7XrFML2mbZPL0SB5BroaANJrtzemGGnFF7MRC8PV+heZTHq6IircTilpXudm
         ZWw/d1tOc7CIgZZt539Fuhoshf6gINL87byu5gxIU+5EG6GL4MIBFswwqQKEyAdlTYlD
         vtXnzXbYv3hMgW9vM4zilc+BHwasmEAi8lnQF/MJ5KmOuNkJkuRjBdgRQA+oB+dYfxRi
         0BlXGqY981k/Uiy1IUUwaL2Uyu9Vur1aG6P37wJmeOWGs1o9RsKnTSVKX9HuZSjM063K
         AL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWN6TQudJIuXlvBQ5Uw2Kzca2FYF4Unp2s725YhzsHy5uCGuFN3cewQTwRdDh0+DzkwcsqQUGOYAq054PQTYnjr+cnszvid
X-Gm-Message-State: AOJu0YxnOLCAujw03Z4X+Ewa8vXM6Du1TcneC7kwrloOKHQzkNhOxW7J
	kJE/VJIWYWqbjPytv4+JJ4RR3pvNkXfL4VZ2bS2mX6GBuDkpgTaaes0y8kly9xc=
X-Google-Smtp-Source: AGHT+IEd4hdtpXCmBTFIuQSY5VdumAtaZdC3rn4gdZrVXmnlmWQRxKpf+oJQ07k7pUQvySNuNaMayA==
X-Received: by 2002:a1f:7d07:0:b0:4d3:4aad:1b9c with SMTP id y7-20020a1f7d07000000b004d34aad1b9cmr911341vkc.0.1710265211052;
        Tue, 12 Mar 2024 10:40:11 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id j6-20020a0cc346000000b0068f6e1c3582sm3790897qvi.146.2024.03.12.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 10:40:10 -0700 (PDT)
Message-ID: <f9cc5817-234e-4612-acbb-29977e0da760@sifive.com>
Date: Tue, 12 Mar 2024 12:40:09 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] clocksource: timer-riscv: Clear timer interrupt on
 timer initialization
Content-Language: en-US
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: atishp@rivosinc.com, Anup Patel <apatel@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ley Foon Tan <lftan.linux@gmail.com>, stable@vger.kernel.org
References: <20240306172330.255844-1-leyfoon.tan@starfivetech.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240306172330.255844-1-leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-06 11:23 AM, Ley Foon Tan wrote:
> In the RISC-V specification, the stimecmp register doesn't have a default
> value. To prevent the timer interrupt from being triggered during timer
> initialization, clear the timer interrupt by writing stimecmp with a
> maximum value.
> 
> Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> 
> ---
> v3:
> Resolved comment from Samuel Holland.
> - Function riscv_clock_event_stop() needs to be called before
>   clockevents_config_and_register(), move riscv_clock_event_stop().
> 
> v2:
> Resolved comments from Anup.
> - Moved riscv_clock_event_stop() to riscv_timer_starting_cpu().
> - Added Fixes tag
> ---
>  drivers/clocksource/timer-riscv.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Tested-by: Samuel Holland <samuel.holland@sifive.com>


