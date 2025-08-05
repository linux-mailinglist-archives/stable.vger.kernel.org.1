Return-Path: <stable+bounces-166638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4D9B1B789
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 17:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFDE62392F
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076461CDFCA;
	Tue,  5 Aug 2025 15:33:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B483CD1;
	Tue,  5 Aug 2025 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408002; cv=none; b=XFwVEOk5qb756Qo7CfEWDIuTikJlayFgsXiMcT+wfbNHhxNFsddVfHnbfq3x+gxSHKucv3lLCmFUzLiQkP4wed7xseJJ4G+nI5fwwoX0doJcFN1pNlcs+cBzTcs3879cBgtfXQksSKhbxKqzew3mRdaVH6XBKF+CfvDx9jnJsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408002; c=relaxed/simple;
	bh=eaNb6v/jyYYmzGGznooW2Go7ynSoEs7m74+LhzyQ2KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lffa4zL8p+ATKdyf/5aVmUo55rkHFHAzFiEIBv6jtaj/Ol0ZHM3q9ObP5gfjzSlOgEOc4nOEGudDqRi9YArGVqG+7f/WTr/odjH9bRfzyZk42Bq9gm0lAcgXXk+jziXcpcMQZKBCDj1l1yUOKYPfz0YgXM4zjBGjIQKzYwushxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76624ecc7efso535891b3a.0;
        Tue, 05 Aug 2025 08:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408001; x=1755012801;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yel2b+4RblLJvMRHPT+ucYyrlWej/tApR3MO/sdfls=;
        b=UyDNsRViOEprQ5MxcsNB8mqV/tpl8+NHXg0LfZ6iHeYtggJIXP+elxV2/IPaT2AiVJ
         P+acbYTHCx/c8RiwM6fj7QNcxx/mjK2ga5DYU6bCiFZGsXiL1AVFLxc5wqF0ZKowEzt3
         jjyzQ2/kV1fxCAJI0B5agXquIRQGcSVgEfdG5JGYLN0VdPQGAuLQL9HnjgLM1EBlVh8g
         1gIoXwB1k1QgvfCJGjZrZsU6Wzt/tcg9Tf6n6yra8V/VWZeX8acG58MMoCKsI1yrn3ZG
         TbEbnQkWYN6A0omI0CX8d9tqLkLQRHnS8L8gEyssO98Z7UZrrn/M4+pvajc6TUynk5i5
         a7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7VY5VaUovoIRbxvIo/q5lMMxcQmXfUiDd1cG7phtILoe2Mv/XcANSbv+/LOJ5TiGB1Yy+K6S4IIjh@vger.kernel.org, AJvYcCVmWlOWKO1SraZzogZiUkQxEjoitT+T8LgyVnocg6L05ciEgTR0JiLmGk/bfRM5aD9NxK7vAL4S@vger.kernel.org, AJvYcCXJ2u/I3jy2vKdtv9+ktwIbLlVihACTzNNwnrjHqRCZ64+GINpMirfS+tetYvwGf16bvLyubAmIsQxCqJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UC1f6LgE7LsLNodogp1Kn8XE1Dkr+6kn1H+8iV83hQ8sOfEJ
	uJLb63B+LJIdA96K0D2Fa9oayEGCC7nT+i63vc5AFAMUvsfZYy9yDBvO
X-Gm-Gg: ASbGncuxPNTVmGRDb09hCowHondFKuT7/yrdw7ewJfW9clPGqyV5mfs2nLD1xpqWfzu
	zTIZQ3nOjLomiWrRirXanNsWQE2Sa0GOCMOcCEPckPvVgbOhRMtKrCjfcLCZ1IiNSal1HhJkSfX
	rFldvDuIEuh8EybSCQ9pzeOTsAWmVmWE4bh9KaLV1kjRqkzUijLimxVMlUdKEHAwgDmQo9YhEx5
	SqSRcJxGHFIZou3eItiloNZ6e2SLOumerkhIipyBHvyR0Wc0Vc6Ep5zhzshbYkgAItOcwDroHEM
	0KLjS78tOZ3P6RyQwCwaWu72BzV8GGv9sbtkxC6nHieDxivCeM/OHEvMUGdYr1iufc0qJ+55euH
	MC3mmHwmW8xX/jsIOLCK+PGisHXnWeR0m1H6HnHxv3RI=
X-Google-Smtp-Source: AGHT+IHULNJQv9btYgDl6fxqXCuB+doWn0u6Jk2OHizCXQnUCeNbkYhIJotgEaqwCog6LsLyr7rQFA==
X-Received: by 2002:a05:6a21:684:b0:232:b78b:cdc5 with SMTP id adf61e73a8af0-23df91ae1c8mr8645872637.7.1754408000588;
        Tue, 05 Aug 2025 08:33:20 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm6454802b3a.123.2025.08.05.08.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:33:19 -0700 (PDT)
Message-ID: <d08de0fa-9dfd-4fc4-b9c0-ff181df8d459@kzalloc.com>
Date: Wed, 6 Aug 2025 00:33:14 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kcov: Use raw_spinlock_t for kcov->lock and
 kcov_remote_lock
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
 <20250803072044.572733-4-ysk@kzalloc.com>
 <20250804122758.620f934a@gandalf.local.home>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250804122758.620f934a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steve,

Thanks for the review and the suggestion.

On 8/5/25 1:27 오전, Steven Rostedt wrote:
> On Sun,  3 Aug 2025 07:20:43 +0000
> Yunseong Kim <ysk@kzalloc.com> wrote:
> 
>> The locks kcov->lock and kcov_remote_lock can be acquired from
>> atomic contexts, such as instrumentation hooks invoked from interrupt
>> handlers.
>>
>> On PREEMPT_RT-enabled kernels, spinlock_t is typically implemented
> 
> On PREEMPT_RT is implemented as a sleeping lock. You don't need to say
> "typically".

You're right — the phrase "typically implemented as a sleeping lock" was
inaccurate. On PREEMPT_RT, spinlock_t is implemented as a sleeping lock, and
I'll make sure to correct that wording in the next version.

>> as a sleeping lock (e.g., mapped to an rt_mutex). Acquiring such a
>> lock in atomic context, where sleeping is not allowed, can lead to
>> system hangs or crashes.
>>
>> To avoid this, convert both locks to raw_spinlock_t, which always
>> provides non-sleeping spinlock semantics regardless of preemption model.
>>
>> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
>> ---
>>  kernel/kcov.c | 58 +++++++++++++++++++++++++--------------------------
>>  1 file changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/kernel/kcov.c b/kernel/kcov.c
>> index 187ba1b80bda..7d9b53385d81 100644
>> --- a/kernel/kcov.c
>> +++ b/kernel/kcov.c
>> @@ -54,7 +54,7 @@ struct kcov {
>>  	 */
>>  	refcount_t		refcount;
>>  	/* The lock protects mode, size, area and t. */
>> -	spinlock_t		lock;
>> +	raw_spinlock_t		lock;
>>  	enum kcov_mode		mode;
>>  	/* Size of arena (in long's). */
>>  	unsigned int		size;
>> @@ -84,7 +84,7 @@ struct kcov_remote {
>>  	struct hlist_node	hnode;
>>  };
>>  
>> -static DEFINE_SPINLOCK(kcov_remote_lock);
>> +static DEFINE_RAW_SPINLOCK(kcov_remote_lock);
>>  static DEFINE_HASHTABLE(kcov_remote_map, 4);
>>  static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
>>  
>> @@ -406,7 +406,7 @@ static void kcov_remote_reset(struct kcov *kcov)
>>  	struct hlist_node *tmp;
>>  	unsigned long flags;
>>  
>> -	spin_lock_irqsave(&kcov_remote_lock, flags);
>> +	raw_spin_lock_irqsave(&kcov_remote_lock, flags);
> 
> Not related to these patches, but have you thought about converting some of
> these locks over to the "guard()" infrastructure provided by cleanup.h?

Also, I appreciate your note about the guard() infrastructure from cleanup.h.
I'll look into whether it's applicable in this context, and plan to adopt it
where appropriate in the next iteration of the series.

>>  	hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
>>  		if (remote->kcov != kcov)
>>  			continue;
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thanks again for the feedback and for the Reviewed-by tag!

Best regards,
Yunseong Kim


