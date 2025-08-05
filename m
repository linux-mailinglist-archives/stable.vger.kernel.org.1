Return-Path: <stable+bounces-166640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88047B1B7B9
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 17:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E9043A42A6
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2BF277CA4;
	Tue,  5 Aug 2025 15:41:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1895819343B;
	Tue,  5 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408505; cv=none; b=W1OeAh+YILqmAVJh/GvXIiutTsIL4wMjpWdzwy9XlUPxipAw48SajEyq/WclZzN+GnVpJoW42e6aXN94QzidgZ2B8YhgfJ/3MmfLUYIO/nbqV36XZvlQWjb6EYjGEEy451HlSPhXU0o4uEz6N8aqM3CuFg8rPgGjEU/1eP763us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408505; c=relaxed/simple;
	bh=/yt3tHivUm51dHtkqDd0wR7z1y68m/D477BZ2GLOUAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/yFf7ryks1VyR+kvKgiMlS1r7OVecGnEUeP7lR95OEUoAPzTSBCDrqC++X4/PDbslPxWW9h35n00D9mpC7RULKr/AW92S9S87XnQbfieAC1Nfx+s+villZLMOPM6go4D+qc536+x9JBD7wdGUFZS4Q04O0TD+vM/sovTSUvlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76b81161f45so378435b3a.3;
        Tue, 05 Aug 2025 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408502; x=1755013302;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZMGhYD5OE1ylPdIIJZi93rO6zltU7tB53w2SBZXO9s=;
        b=dmOkeEvG2t9gGIPhTK6fzFv5m0DKpssw4PmpTXDGFfKs25yxCKb0yUC0f+/FpG2H8I
         7ezfEmiOHSLPe7P2RKvRL6iAoiSMxVwId5qJ2cTdqZTh4xjwD90rw1R3NaKHV1/zxoMk
         wmMEkDtRtXUeIkWs7EoH7HjaeBXq8rD5/Yd5ZyZ8rFIJUDcb/381wqbTC2lU/McOsMAX
         hev1rm51rs/jTdupf3acRnohRfzq0+QCNtMZBhsP7HhRnwXtjEDjozKJ1Xg8XhJ8r7hM
         HWi47+Y9IFZjux7MerZPC6uCBH955W94oYq+kp6u6A7W9TS6x2gQKB2cftixJAIJvgIJ
         2ywQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5uVPpHqjHiiJrstuNfBj5xD9Vri/uWPBWx3037qSTSQYthSWLqJ0kZ11U3NRy0wYrNVgktK3V@vger.kernel.org, AJvYcCVHqss7j/RC/6nEYZzjUenYaMA98KnpbfxIDvtkIY1dh0F8iusXU/wfScd/cM0qW9S7XHCDabv6mjn5@vger.kernel.org, AJvYcCVlGLa/D04oR48Igv+B+lhEL3S9766TJy0VYQxb5wIoN2zF8SFcCImzzLzlH4IPjt+ZLZe1UYqeWaiSISg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73MBumMGBkZo7zUt0meRok3b04YfKlG1sYr7XEbfvNS/++am6
	Hc93SVNrVqgbQxK5vREIpbHRGOPIT0MG92gIydeSGgAi/D1E5eKqfsVi
X-Gm-Gg: ASbGncsKMlkGZalXfLux9OOM3l/r2dz1LcncrtR5oAdoOkgjLSaTRmHvbJXFNhie2rf
	2hlPM8N9GdscIR1kNQowY20F/67cLKXLRGgI6RvEMivoBWzVE9R6NuBEO7M8YoWmEC4avCFijuZ
	20ET8hXbjq3l4wN/HBK2O+TRBLxA4NQoIGlGvmMuDKNOE+rZIrTKAXzjPJmXx73QdDHHJkvWWCp
	+mOBT1gVM+btnjG1nRQO4SbMVbfXG8pWxcPz05DBzX/ix610aYVwcoOT5PWF6FRkEv3sFuDnjpy
	NJ9WvJD8wxJ5YNJKNhPOd3fmPsNUc4uTsICUui9IGkwY2advzGUoDQMfhJq2t2PYrQ12D024C8f
	jx4yRx6OJhB43z0CXgFv1EqqUg1Gt2FiP
X-Google-Smtp-Source: AGHT+IFETrileTavzFogHlt3kpqW55YEJWqCTgysYCKWqbIjAeVGDBoRxanDjUE4RC0hSx+nzDcEEA==
X-Received: by 2002:a17:903:28c6:b0:240:63bd:2701 with SMTP id d9443c01a7336-24246f64718mr63253245ad.6.1754408502230;
        Tue, 05 Aug 2025 08:41:42 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769fasm135540565ad.107.2025.08.05.08.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:41:41 -0700 (PDT)
Message-ID: <78384abd-7fae-492d-947e-c3311f952d87@kzalloc.com>
Date: Wed, 6 Aug 2025 00:41:36 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kcov: Replace per-CPU local_lock with
 local_irq_save/restore
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
 Yeoreum Yun <yeoreum.yun@arm.com>, ppbuk5246@gmail.com,
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250803072044.572733-2-ysk@kzalloc.com>
 <20250803072044.572733-6-ysk@kzalloc.com>
 <20250804123756.7678cb3d@gandalf.local.home>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250804123756.7678cb3d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steve,

Thanks for the detailed feedback and suggestions.

On 8/5/25 1:37 오전, Steven Rostedt wrote:
> On Sun,  3 Aug 2025 07:20:45 +0000
> Yunseong Kim <ysk@kzalloc.com> wrote:
> 
>> Commit f85d39dd7ed8 ("kcov, usb: disable interrupts in
>> kcov_remote_start_usb_softirq") introduced a local_irq_save() in the
>> kcov_remote_start_usb_softirq() wrapper, placing kcov_remote_start() in
>> atomic context.
>>
>> The previous patch addressed this by converting the global
> 
> Don't ever use the phrase "The previous patch" in a change log. These get
> added to git and it's very hard to find any order of one patch to another.
> When doing a git blame 5 years from now, "The previous patch" will be
> meaningless.

I agree that using phrases like "The previous patch" in changelogs is not a
good practice, especially considering future maintenance and git blame
scenarios.

>> kcov_remote_lock to a non-sleeping raw_spinlock_t. However, per-CPU
>> data in kcov_remote_start() and kcov_remote_stop() remains protected
>> by kcov_percpu_data.lock, which is a local_lock_t.
> 
> Instead, you should say something like:
> 
>   As kcov_remote_start() is now in atomic context, the kcov_remote lock was
>   converted to a non-sleeping raw_spinlock. However, per-cpu ...

I’ll revise the commit messages in the next iteration to explicitly
describe the context.

>> On PREEMPT_RT kernels, local_lock_t is implemented as a sleeping lock.
>> Acquiring it from atomic context triggers warnings or crashes due to
>> invalid sleeping behavior.
>>
>> The original use of local_lock_t assumed that kcov_remote_start() would
>> never be called in atomic context. Now that this assumption no longer
>> holds, replace it with local_irq_save() and local_irq_restore(), which are
>> safe in all contexts and compatible with the use of raw_spinlock_t.
> 
> Hmm, if the local_lock_t() is called inside of the taking of the
> raw_spinlock_t, then this patch should probably be first. Why introduce a
> different bug when fixing another one?

Regarding the patch ordering and the potential for introducing new bugs if the
local_lock_t conversions come after the raw_spinlock conversion, that’s a very
good point. I’ll review the patch sequence carefully to ensure the fixes apply
cleanly without regressions.

> Then the change log of this and the previous patch can both just mention
> being called from atomic context.
> 
> This change log would probably then say, "in order to convert the kcov locks
> to raw_spinlocks, the local_lock_irqsave()s need to be converted over to
> local_irq_save()".
> 
> -- Steve

Also, I will update the changelog to clearly state.

Thanks again for your thorough review and guidance!

Best regards,
Yunseong Kim

