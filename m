Return-Path: <stable+bounces-165808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F33B19049
	for <lists+stable@lfdr.de>; Sun,  3 Aug 2025 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1AAC3A57B1
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB1D18DB01;
	Sat,  2 Aug 2025 22:01:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008B19AD90;
	Sat,  2 Aug 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754172108; cv=none; b=oLG1TvlroDnS3ZQV1AFJnieUt8jOCCLepoiH0um+mi3BXlBSvqUiito7fzhK8u8jhrv5fi9qMb6uyTQXYdukIawy+sdtXAo1EV3m67fvLSWb+Lor/fEdKENcnFfxsTz7uYyakjV0XuBWtxc6GimCqyogn+ek6Tn8xtgNbV44hUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754172108; c=relaxed/simple;
	bh=h9dGsWgUYDzbbkTsgtBfXOsJHPWKtsMwDEyJ1+wQ6/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEbmiIB796ZggjEmMu9Uy10Az/kAunCMTpynzzy1aUO8jiI1GxSb5lROAVO8hOphjajmsNrjZg2errMhYo8i4Dfqhiw4zGjb1BdlC2lCfDMVYDpAFA5CA919XfoShp/e3CqnOAZK3IlKyaoRVlC/Q5EaroVCVug+r+gz/5HLuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3f4ae9a367so424864a12.3;
        Sat, 02 Aug 2025 15:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754172106; x=1754776906;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6iKlbJNv1rMzXvKJJrDKnOLYsLImNj0w08vdZLLiFg=;
        b=qll5kcPnhrpyZOBejklzpM3/l1VfwGR1tzLixYz4Ki7rfxNctmTF3bzHs6lJ71FuzZ
         GfUFZxXU4DuxiX0xBLE67E2KMUl+Y1c3yq+NfMeDQR0LtLG+GG96BEWTSnnTtgYx76l/
         V3KZP2+2EkloWST4p4r4lmx8CRDCTzioGEKYevDoLldOOhpFFU3EaavYhL09tJWdd0uf
         ibcUQYwjAPTN537ZVCeBl5Z9YZ30L9pIkFMKuSAfQl5rBxhyfiE49ma1cSYh/2HMmg5U
         zXIozmyyHXU1yWYTgv1rfeYZRXWqDWAU697BbhQIsDe/HD4RRNlGLd47CaXU754pWdek
         rw3A==
X-Forwarded-Encrypted: i=1; AJvYcCU429AFF8NZQeYU5fpyfCbL1jl2GLyu2G3TSjknBk6YqhpBhHKe/k1mug4jNmFzpuENdilH3nS2gqMIz+M=@vger.kernel.org, AJvYcCVGH46vBC9/SzV7BLMcMMPrkOafAm53XjaqgWdyr/1F8K9NuEzMOZFWvSwZipu1grBHHTM4fcpJ@vger.kernel.org, AJvYcCVe3iGfX5s/mI1ovL7oWNB9EigGZVXXSTVCvrZPF4K82IDhBZ8NrTbc7KPYyAreqDAmp9HQgI9kdcNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxD1319Sn30wE17tLXT5+b1KH+IyGwuImxCWOFIfmZfaGmhDWFC
	3gpbAiPfNk4LU5I6uWTJ2kK/GxZJ4XjwhPq0c1bxaUqTN1kz6+m8QRg7
X-Gm-Gg: ASbGncvp2F8L7za4lUiphujzfyi03eHW/DwDEfPJ5ksUkrlKfef2QONO9OlExOWnBw8
	0zc5quOpoek/MUetFecuWbEr5/wH+2G3jicwfaOPSDy7Uo8dvoVTnyRepyQpNvLIjn6CcEIKxYe
	d7PCbwn2EGQBSpxh1VSJFQt0k3c4zPrTqh+l0Tybcfjbbn+Jc4/Ayd1rycWrIrKVUdGmV+XRaSF
	fstvU1YHhPG4Zh7UPNTv0aMzxmYaH6FrHUYVUw9aQDD3xi8gqWfX+SkOtj9NRvNXPz7YdbPIt+v
	fza7zU2LLail7yiLxggkQMHja7Pr/6OfM8vIh+QFuRebgpTlSSrOm1562UOAMei88CdTvUmrMXb
	VJZ78GXGpaeyvpx5yIgdCVGNchoQjzzWQ
X-Google-Smtp-Source: AGHT+IHvFcjEaG3YxGtNa9QhNQdWOb0uhOSD/6FpInnGumGJtTNEwHNQrEi6gQ/F60yhksDGX4hFmQ==
X-Received: by 2002:a05:6a00:4b52:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-76bec2f5dd1mr2171800b3a.1.1754172106326;
        Sat, 02 Aug 2025 15:01:46 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcfb6sm7056787b3a.79.2025.08.02.15.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 15:01:45 -0700 (PDT)
Message-ID: <4a505533-b725-4e3f-94db-3d261937ea25@kzalloc.com>
Date: Sun, 3 Aug 2025 07:01:40 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path
 on PREEMPT_RT
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Byungchul Park <byungchul@sk.com>,
 max.byungchul.park@gmail.com, "ppbuk5246 @ gmail . com"
 <ppbuk5246@gmail.com>, linux-kernel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 stable@vger.kernel.org, kasan-dev@googlegroups.com,
 syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20250802142647.139186-3-ysk@kzalloc.com>
 <2025080212-expediter-sinless-4d9c@gregkh>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <2025080212-expediter-sinless-4d9c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

On 8/3/25 6:30 오전, Greg Kroah-Hartman wrote:
> On Sat, Aug 02, 2025 at 02:26:49PM +0000, Yunseong Kim wrote:
>> The KCOV subsystem currently utilizes standard spinlock_t and local_lock_t
>> for synchronization. In PREEMPT_RT configurations, these locks can be
>> implemented via rtmutexes and may therefore sleep. This behavior is
>> problematic as kcov locks are sometimes used in atomic contexts or protect
>> data accessed during critical instrumentation paths where sleeping is not
>> permissible.
>>
>> Address these issues to make kcov PREEMPT_RT friendly:
>>
>> 1. Convert kcov->lock and kcov_remote_lock from spinlock_t to
>>    raw_spinlock_t. This ensures they remain true, non-sleeping
>>    spinlocks even on PREEMPT_RT kernels.
>>
>> 2. Refactor the KCOV_REMOTE_ENABLE path to move memory allocations
>>    out of the critical section. All necessary struct kcov_remote
>>    structures are now pre-allocated individually in kcov_ioctl()
>>    using GFP_KERNEL (allowing sleep) before acquiring the raw
>>    spinlocks.
>>
>> 3. Modify the ioctl handling logic to utilize these pre-allocated
>>    structures within the critical section. kcov_remote_add() is
>>    modified to accept a pre-allocated structure instead of allocating
>>    one internally.
>>
>> 4. Remove the local_lock_t protection for kcov_percpu_data in
>>    kcov_remote_start/stop(). Since local_lock_t can also sleep under
>>    RT, and the required protection is against local interrupts when
>>    accessing per-CPU data, it is replaced with explicit
>>    local_irq_save/restore().
> 
> why isn't this 4 different patches?

Thank you for your feedback on the patch. I’ll split it into four separate
patches for v3 to improve clarity.

Best regards,
Yunseong Kim

