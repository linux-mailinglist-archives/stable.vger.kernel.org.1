Return-Path: <stable+bounces-23837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C37868AAC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 504E2B24B13
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959005644D;
	Tue, 27 Feb 2024 08:19:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF554F8A
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709021958; cv=none; b=XKtm9UqYKSs45XRjPzi+a2iat/EKMy0x9h/ALx383ExbhMv9oMInWQbBXc5cHChzLOtSLIUMavzxVZ9JL514ig9Ih+mI0JF/ps4xQ1cQDkWF3yDgXgvXahoTh0w30OZqII4iMUpFEkHf+R+ndCOCuAO8Rs+muvQjeTDTZ8tTO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709021958; c=relaxed/simple;
	bh=Xtw848IN/V9nWRRcW5eDAh4uQrrgNgqJvU/VxTlDiK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgvdaMylxAOjzO26l0CyeEb0ap2nTMf0E6a3a73l7TyiGxgohqomX6eBwErWCRUCuj0SsreGNsUwak/Xe3DLSmNn9dWIfETSri/Qzs/4p7QIX/3ypGNC0rPiK78AB+YX71fP4ydgRyL1T9yBZsSBtLlFwOHmAJlVMRNtk1Ya5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a9c1921dso7238925e9.0
        for <stable@vger.kernel.org>; Tue, 27 Feb 2024 00:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709021955; x=1709626755;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwIOEiN6hiPZmIR34Xf2w1vaI5HkpUu1NGOwZDAXABo=;
        b=N+zI/CVKZ5jcMgH6IJNdBaU2w1thnp10M9Er80nNqzuIqKHAev9LFYwX7HFzc+XmS2
         WscWLC4yndMkVxn2B7bVjl4vq6plDYY83zrjKm57ihdyYTcATuqaVmpmOHz6Ji7UUn9X
         eQKA6c03v/LJyTbw8RSSejhIFqaYkSYXdogUC/uXPa2hHseIwXTLpdGqH2oImX0ht2Ix
         8TnVj2+cURZN75/Rbfj3yP4lCjyTEXmxeZxnw4Gpag9hdtHyazHY425F23BJ33z7HCx6
         qHFS9BZEMA/TU1Gw2jnchdeFYKP+MY7TZhdNyIJuC35U2/Ir9kF9wB+B2975jtHUU1eP
         OwpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSYrz/vdNFUi8dgasw0+sAeGg98KmHSbPbPTdxoggPT/H6MVMWk/p9hRcoRzWQrBzFkf/eJM3uC4rZsltu3F2rr/hm6kB/
X-Gm-Message-State: AOJu0Yw2Nd65JpNxLXMwq5YInrBhiS3/x0joWYbSxx1uui2duV7MdKcz
	QfD1sjmIUyApPf34MiosXvzgXee/0J35qvQFzp73NFRa/YeWMZ3K
X-Google-Smtp-Source: AGHT+IF962OugPeMawM9yQsehzpzlI7+g6Z8ITFZk5nvSn2JvCub3RpgKEIBmPaPTjan8JDVu+SyFg==
X-Received: by 2002:a05:600c:4fcb:b0:412:78c8:b31e with SMTP id o11-20020a05600c4fcb00b0041278c8b31emr7733347wmq.2.1709021955050;
        Tue, 27 Feb 2024 00:19:15 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id s15-20020a05600c45cf00b0041273fc463csm14429095wmo.17.2024.02.27.00.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:19:14 -0800 (PST)
Message-ID: <5a289118-f6d2-4471-b833-1565fd51cbdd@kernel.org>
Date: Tue, 27 Feb 2024 09:19:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 1/6] x86/bugs: Add asm helpers for executing VERW
Content-Language: en-US
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, stable@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Alyssa Milburn <alyssa.milburn@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>
 <20240226-delay-verw-backport-6-1-y-v1-1-b3a2c5b9b0cb@linux.intel.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240226-delay-verw-backport-6-1-y-v1-1-b3a2c5b9b0cb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 02. 24, 9:00, Pawan Gupta wrote:
> commit baf8361e54550a48a7087b603313ad013cc13386 upstream.
...
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -194,6 +194,17 @@
>   #endif
>   .endm
>   
> +/*
> + * Macro to execute VERW instruction that mitigate transient data sampling
> + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> + *
> + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> + */
> +.macro CLEAR_CPU_BUFFERS
> +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF

The same here. Except 6.1 (I didn't check stable-6.1) does not have:
commit 270a69c4485d7d07516d058bcc0473c90ee22185
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Feb 8 18:10:52 2023 +0100

     x86/alternative: Support relocations in alternatives

yet. You likely need to backport that too.

regards,
-- 
js
suse labs


