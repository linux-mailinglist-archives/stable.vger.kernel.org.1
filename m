Return-Path: <stable+bounces-166880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D727B1EDDA
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 19:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B191AA851C
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959EB1DE4EC;
	Fri,  8 Aug 2025 17:35:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D319D065;
	Fri,  8 Aug 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674557; cv=none; b=EYxAAPEpzaXmUAGuISMX7cRFTYOAXil0+T43GmJWV6gSlmo5F68Vn/JB0Nx+pVzjR3onLNE1xUIawJ5Sl/QVBjxd17l4XGEDS4SAASx9BzacDHuYXNtillZ9JPx1WMTkjgRLynB5jcIvJymXYWwETWlb/KifneKN3azpqjPV23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674557; c=relaxed/simple;
	bh=UjKufUcDVuFCnbrLs4c4ZVltA4RZDogjR2wEue1jEZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dn4RtTjEbBZCrZClkHHTKPAK9wSXCdcpRnwdgP2GB3u2Q2J70ZAWFHFvrjxfgXtmezHAM8UShZb33Z7nIwyrKGHgXP3T7EGJ0QmxBgEFp4jHOICLJUhhDCZ1PQDIL1ZsVmoYPusonVVstHCxy5kgwyar3nZyjhhuQdZfjzs8owU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76624ecc7efso302344b3a.0;
        Fri, 08 Aug 2025 10:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754674555; x=1755279355;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWQx0Bz2e4dgqP38uiBm8lwh1j15JZqgNFOPKY08noI=;
        b=rRck1110TAxHpQI6zy/D4eUFEET+qjULFP0kn942o431wWHIJ7dp8Zi4zbmE2QxlSU
         xhJJEUOoVUBSQyvw8lk2PLX2TbBRRDnH+P3/ElL0DKEuy6ZrM64LCpp5iIfIXwo+m4bE
         mh1TF9R3ZS9nQ5HVIyigccrXeh/fcT7BwArnzdRJONIO/4uIcJVUbzENmrCVWhqN3yEM
         tbGn5KfjXDZn1pcanjdZSVZ7ptpKUgAa9CTvPOvTZOe6A+ZW+I+BGQ3U6myQpTIYodjZ
         NH8JMBTexCfLzn3LPgyhyRsiTT5idjOkaSWYCic9yfqk2U4JvpD/Yjb9IoEw1nyhbPrf
         dzLw==
X-Forwarded-Encrypted: i=1; AJvYcCVdxMZp0Cfh+NOK4hPNvi1NPYRicyDF1X4J+xDHauSprwQknThAGN/0F384ReZVUOQt0Zpqb0znLrTF@vger.kernel.org, AJvYcCXgCAXOg9+5yGsleoaeaq6yQcviP0sbg7KwxxFE2y1XQnoFUAS9HU84mYzR4DMocCRA2SbwUOj7@vger.kernel.org, AJvYcCXrRxLmrdupEAUY0yAWTPGt8OhWmGOO+lDteo/9QZQ6u8zgCvz3z11wpLsrG9mrg/ylVHQGcvQlP26/fN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tUotMmgMz2ZhwJBVbf3EhuAZi6njF96XFy2zhV4MFhTyC+ea
	jkaa6I/AYeG7zVDfRXDZECnaAS7NSG8Ag33o7XA3b5QcqK5BZ/TTcSihYK3xxoE6
X-Gm-Gg: ASbGncu3d53Sy/De5zuKRqwqAGT/ES/78iTDdN8vQ8O9GSm+RLYis2cqsUTNKet60D+
	6d7O8yr/5w6zkmbcRajCxHZ9B1kMlzO8cAhdRJ3XIDPwq+hnUgpvlnCsAkHH933cNZ4dm+fGN4Z
	0NgYKuBK/ola5mjoPRybVk+c2pl5oC6LL47WVb88wEMMBNwuyWlD6GVYBr+xawJQvMRemm17ysg
	JYwwxyor+HKkPZpM35Gawa95a67w+ZY1fRCAnfBOfwvX0E7eObAs5m7G9Xfmz1598SD78piUKh4
	OUuZsGq5t4VadMeSOYJo+MD7fQ5Dtkfn8Cna/isvOb/xauFqmGDPKjIvcB4jQvpkYhh/jLnAjKT
	iK5MGK44WJpUUuguUdO3Su03sfpA+52nP
X-Google-Smtp-Source: AGHT+IGfVl1ea8AUcfTPqFwGJwVmNGBWGoGwyWKPj4G+UWJHWkqCmbzR7KEypHCaHjfwbMseBlx5MQ==
X-Received: by 2002:a05:6a00:2d85:b0:755:2c5d:482c with SMTP id d2e1a72fcca58-76c46135279mr2391297b3a.4.1754674554720;
        Fri, 08 Aug 2025 10:35:54 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8de34sm20851670b3a.30.2025.08.08.10.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 10:35:54 -0700 (PDT)
Message-ID: <ee26e7b2-80dd-49b1-bca2-61e460f73c2d@kzalloc.com>
Date: Sat, 9 Aug 2025 02:35:48 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Byungchul Park <byungchul@sk.com>,
 max.byungchul.park@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>,
 Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
 kasan-dev@googlegroups.com, syzkaller@googlegroups.com,
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Austin Kim <austindh.kim@gmail.com>
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <20250808163345.PPfA_T3F@linutronix.de>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250808163345.PPfA_T3F@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

I was waiting for your review — thanks!

On 8/9/25 1:33 오전, Sebastian Andrzej Siewior wrote:
> On 2025-07-25 20:14:01 [+0000], Yunseong Kim wrote:
>> When fuzzing USB with syzkaller on a PREEMPT_RT enabled kernel, following
>> bug is triggered in the ksoftirqd context.
>>
> …
>> This issue was introduced by commit
>> f85d39dd7ed8 ("kcov, usb: disable interrupts in kcov_remote_start_usb_softirq").
>>
>> However, this creates a conflict on PREEMPT_RT kernels. The local_irq_save()
>> call establishes an atomic context where sleeping is forbidden. Inside this
>> context, kcov_remote_start() is called, which on PREEMPT_RT uses sleeping
>> locks (spinlock_t and local_lock_t are mapped to rt_mutex). This results in
>> a sleeping function called from invalid context.
>>
>> On PREEMPT_RT, interrupt handlers are threaded, so the re-entrancy scenario
>> is already safely handled by the existing local_lock_t and the global
>> kcov_remote_lock within kcov_remote_start(). Therefore, the outer
>> local_irq_save() is not necessary.
>>
>> This preserves the intended re-entrancy protection for non-RT kernels while
>> resolving the locking violation on PREEMPT_RT kernels.
>>
>> After making this modification and testing it, syzkaller fuzzing the
>> PREEMPT_RT kernel is now running without stopping on latest announced
>> Real-time Linux.
> 
> This looks oddly familiar because I removed the irq-disable bits while
> adding local-locks.
> 
> Commit f85d39dd7ed8 looks wrong not that it shouldn't disable
> interrupts. The statement in the added comment
> 
> | + * 2. Disables interrupts for the duration of the coverage collection section.
> | + *    This allows avoiding nested remote coverage collection sections in the
> | + *    softirq context (a softirq might occur during the execution of a work in
> | + *    the BH workqueue, which runs with in_serving_softirq() > 0).
> 
> is wrong. Softirqs are never nesting. While the BH workqueue is
> running another softirq does not occur. The softirq is raised (again)
> and will be handled _after_ BH workqueue is done. So this is already
> serialised.
> 
> The issue is __usb_hcd_giveback_urb() always invokes
> kcov_remote_start_usb_softirq(). __usb_hcd_giveback_urb() itself is
> invoked from BH context (for the majority of HCDs) and from hardirq
> context for the root-HUB. This gets us to the scenario that that we are
> in the give-back path in softirq context and then invoke the function
> once again in hardirq context.
> 
> I have no idea how kcov works but reverting the original commit and
> avoiding the false nesting due to hardirq context should do the trick,
> an untested patch follows.
> 
> This isn't any different than the tasklet handling that was used before
> so I am not sure why it is now a problem.

Thank you for the detailed analysis and the patch. Your explanation about
the real re-entrancy issue being "softirq vs. hardirq" and the faulty
premise in the original commit makes perfect sense.

> Could someone maybe test this?

As you requested, I have tested your patch on my setup.

I can check that your patch resolves the issue. I have been running
the syzkaller for several hours, and the "sleeping function called
from invalid context" bug is no longer triggered.

> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1636,7 +1636,6 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>  	struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
>  	struct usb_anchor *anchor = urb->anchor;
>  	int status = urb->unlinked;
> -	unsigned long flags;
>  
>  	urb->hcpriv = NULL;
>  	if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
> @@ -1654,14 +1653,13 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
>  	/* pass ownership to the completion handler */
>  	urb->status = status;
>  	/*
> -	 * Only collect coverage in the softirq context and disable interrupts
> -	 * to avoid scenarios with nested remote coverage collection sections
> -	 * that KCOV does not support.
> -	 * See the comment next to kcov_remote_start_usb_softirq() for details.
> +	 * This function can be called in task context inside another remote
> +	 * coverage collection section, but kcov doesn't support that kind of
> +	 * recursion yet. Only collect coverage in softirq context for now.
>  	 */
> -	flags = kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
> +	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
>  	urb->complete(urb);
> -	kcov_remote_stop_softirq(flags);
> +	kcov_remote_stop_softirq();
>  
>  	usb_anchor_resume_wakeups(anchor);
>  	atomic_dec(&urb->use_count);
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 75a2fb8b16c32..0143358874b07 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -57,47 +57,21 @@ static inline void kcov_remote_start_usb(u64 id)
>  
>  /*
>   * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
> - * workaround for KCOV's lack of nested remote coverage sections support.
> - *
> - * Adding support is tracked in https://bugzilla.kernel.org/show_bug.cgi?id=210337.
> - *
> - * kcov_remote_start_usb_softirq():
> - *
> - * 1. Only collects coverage when called in the softirq context. This allows
> - *    avoiding nested remote coverage collection sections in the task context.
> - *    For example, USB/IP calls usb_hcd_giveback_urb() in the task context
> - *    within an existing remote coverage collection section. Thus, KCOV should
> - *    not attempt to start collecting coverage within the coverage collection
> - *    section in __usb_hcd_giveback_urb() in this case.
> - *
> - * 2. Disables interrupts for the duration of the coverage collection section.
> - *    This allows avoiding nested remote coverage collection sections in the
> - *    softirq context (a softirq might occur during the execution of a work in
> - *    the BH workqueue, which runs with in_serving_softirq() > 0).
> - *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
> - *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
> - *    the middle of its remote coverage collection section, and the interrupt
> - *    handler might invoke __usb_hcd_giveback_urb() again.
> + * work around for kcov's lack of nested remote coverage sections support in
> + * task context. Adding support for nested sections is tracked in:
> + * https://bugzilla.kernel.org/show_bug.cgi?id=210337
>   */
>  
> -static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
> +static inline void kcov_remote_start_usb_softirq(u64 id)
>  {
> -	unsigned long flags = 0;
> -
> -	if (in_serving_softirq()) {
> -		local_irq_save(flags);
> +	if (in_serving_softirq() && !in_hardirq())
>  		kcov_remote_start_usb(id);
> -	}
> -
> -	return flags;
>  }
>  
> -static inline void kcov_remote_stop_softirq(unsigned long flags)
> +static inline void kcov_remote_stop_softirq(void)
>  {
> -	if (in_serving_softirq()) {
> +	if (in_serving_softirq() && !in_hardirq())
>  		kcov_remote_stop();
> -		local_irq_restore(flags);
> -	}
>  }
>  
>  #ifdef CONFIG_64BIT
> @@ -131,11 +105,8 @@ static inline u64 kcov_common_handle(void)
>  }
>  static inline void kcov_remote_start_common(u64 id) {}
>  static inline void kcov_remote_start_usb(u64 id) {}
> -static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
> -{
> -	return 0;
> -}
> -static inline void kcov_remote_stop_softirq(unsigned long flags) {}
> +static inline void kcov_remote_start_usb_softirq(u64 id) {}
> +static inline void kcov_remote_stop_softirq(void) {}
>  
>  #endif /* CONFIG_KCOV */
>  #endif /* _LINUX_KCOV_H */


I really impressed your "How to Not Break PREEMPT_RT" talk at LPC 22.


Tested-by: Yunseong Kim <ysk@kzalloc.com>


Thanks,

Yunseong Kim

