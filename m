Return-Path: <stable+bounces-166637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7871B1B775
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 17:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15DB17B75F
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 15:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E927279DB2;
	Tue,  5 Aug 2025 15:27:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B562777F9;
	Tue,  5 Aug 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407630; cv=none; b=WJ+7TjbgMKgoIAsQvA4dZ1Ewb+cyQnRkpD2lkjyTw/tmSnTYAAmnXEv7waNh5gfpdYOYFI/2N8PXGQp2D7kR+UhMIVKlW+dUvtWwdi/iNqLVUTt1VipKu9CgP/ACxv9pXTXTN8XfJoYz3lGqn0GiFc7+k19PpDD/MD2OySk1oU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407630; c=relaxed/simple;
	bh=lbWIMGmXSfPP8qxW81xC9fWF8J70sLsBiiZS09J+PqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/dKltzKLdsZjb6TdeuVM62cHmKydoBmrJbd/cx8iqjqN2R+9XXaayPsjYUAhLT6krFx6waJgYO0ZEk33MAwdPMSKeVJXwqgIlnmRbRREFl+gLWQ6UI2MUII1oTezEalG3+e+73o/exwE+iFO1UMT912enFVmj4OzUonV9K/EgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76624ecc7efso535153b3a.0;
        Tue, 05 Aug 2025 08:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754407628; x=1755012428;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pr6DrCEDv+a0jbLHVvBac89tThXy65vIV2bUWnsRig=;
        b=r8a24T3kf7Rauef88rUFmmFNdhW3EbzKFK4gK5YldTb019Cn0pvRN1npJ9XoWXAaxI
         hKIFrH0RsUljAKn5euSdamn6fpXej7XqiUFEJxs3llpzDJhvblYFxub4dcoSlmYhlZwg
         U1zWZT6TRxxQs33t5P8mA42MXgTzZgLiT+sys9137+7XMb/PBYL2Fwh78IGY3WfoKFeK
         cXGqES75StKyWtjnhd8DsR9kGb/3zDfr7Je2CTILCIrahM4bh4dIh8sGAbT0pOSK8xcC
         GqdoAZqGCJdf/gHZlDIdcw2uixYQinlKN4sdyv5m9Nbhhs2u6HzRaCaClfbaGrYBcXEA
         QnDg==
X-Forwarded-Encrypted: i=1; AJvYcCVXKtYaqN5hYWmuCD/scUiL8+z16sV8+1O1uBXARlSvfByCL7cIQSVGSdYB1xcjd229CllfU8bYsFsp@vger.kernel.org, AJvYcCW49rEQW0lGEqTvtWLydWkISWQMX1WBZJdsOPCC7IZpoV1B0LdaCOIRvTyZoSWQU3BzwNqA5IOi@vger.kernel.org, AJvYcCW5tclj9NLJ2VZUKcJEIJ7R/w15eQpTrN2GRyrdNsUWOuw62qdi03tVvcx+w15aQVitBqN2ddQ7+kZXMVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8YO1BoWjuZSF5KoYlj0DTEr2mjFb/26NKwBkZZvH4duoooJo4
	aLy+2PLXoMpYD7IKAeX/KhUcks05lIGY41x/mgCn/9EEcx6F5RtRCRtK
X-Gm-Gg: ASbGncs9wrWp4gW7f8GFZ6jvJTAeipwUWpCOnM7Slcw4V58sd8sL1RMe86cqHaw5BLr
	P/vG54+tVFr1/mE+iSSDcpx89ySStC9X8M7hxAhGy+11knKx5rAr7QKY9Ez/77rMR3iO66gJ5qp
	0YO6DWQIlOWi97xBFK2l0h4QWqpmJZVJOaUdgZr0D3S21YPevTJOJNUmvOr5ZmA9rVXuXqJr3JY
	lcuaPXjyVfJ15PqtyL1bh2aFBcZuNIiG9lL7tfO7uOl3CSvXv8cIVUyJruBo5htDU2li+nyynTZ
	X/AJDs1Gu8TyyHeBx3B0EFw1u4aKVSBLIHu5D7V4voANN/Fi/j5ptQrL6gAEj1wXlKM7qddH/6p
	QOWMV6LREdGhS5JhC7Pa09CTHoZ6KNWjv
X-Google-Smtp-Source: AGHT+IEsKFfKhbmomJLvjN9Tv+WNDm8mFlc7vYZxJMukrVF3+0b0N+h3Y50ODx8JttQHR39Cg6w5ow==
X-Received: by 2002:a05:6a00:856:b0:747:ae55:12e with SMTP id d2e1a72fcca58-76bec2ee69amr7829469b3a.1.1754407627955;
        Tue, 05 Aug 2025 08:27:07 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce929aesm13090519b3a.49.2025.08.05.08.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:27:07 -0700 (PDT)
Message-ID: <ddd14f62-b6c9-4984-84be-6c999ea92e30@kzalloc.com>
Date: Wed, 6 Aug 2025 00:27:01 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] kcov, usb: Fix invalid context sleep in softirq
 path on PREEMPT_RT
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
 <20250804122405.3e9d83ed@gandalf.local.home>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250804122405.3e9d83ed@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steve,

You're absolutely right to ask for clarification, and I now realize that
I didn’t explain the background clearly enough in my cover letter.

On 8/5/25 1:24 오전, Steven Rostedt wrote:
> On Sun,  3 Aug 2025 07:20:41 +0000
> Yunseong Kim <ysk@kzalloc.com> wrote:
> 
>> This patch series resolves a sleeping function called from invalid context
>> bug that occurs when fuzzing USB with syzkaller on a PREEMPT_RT kernel.
>>
>> The regression was introduced by the interaction of two separate patches:
>> one that made kcov's internal locks sleep on PREEMPT_RT for better latency
> 
> Just so I fully understand this change. It is basically reverting the
> "better latency" changes? That is, with KCOV anyone running with PREEMPT_RT
> can expect non deterministic latency behavior?

The regression results from the interaction of two changes — and in my original
description, I inaccurately characterized one of them as being 
"for better latency." That was misleading.

The first change d5d2c51 replaced spin_lock_irqsave() with local_lock_irqsave()
in KCOV to ensure compatibility with PREEMPT_RT. This avoided using a
potentially sleeping lock with interrupts disabled.
At the time, as Sebastian noted:

 "There is no compelling reason to change the lock type to raw_spin_lock_t...
  Changing it would require to move memory allocation and deallocation outside
  of the locked section."

However, the situation changed after another patch 8fea0c8 converted the USB
HCD tasklet to a BH workqueue. As a result, usb_giveback_urb_bh() began running
with interrupts enabled, and the KCOV remote coverage collection section in
this path became re-entrant. To prevent nested coverage sections — which KCOV
doesn’t support — kcov_remote_start_usb_softirq() was updated to explicitly
disable interrupts during coverage collection f85d39d.

This combination — using a local_lock (which can sleep on RT) alongside
local_irq_save() — inadvertently created a scenario where a sleeping lock was
acquired in atomic context, triggering a kernel BUG on PREEMPT_RT.

So while the original KCOV locking change didn't require raw spinlocks at
the time, it became effectively incompatible with the USB softirq use case once
that path began relying on interrupt disabling for correctness. In this sense,
the "no compelling reason" eventually turned into a "necessary compromise."

To clarify: this patch series doesn't revert the previous change entirely.
It keeps the local_lock behavior for task context (where it's safe and
appropriate), but ensures atomic safety in interrupt/softirq contexts by
using raw spinlocks selectively where needed.

> This should be fully documented. I assume this will not be a problem as
> kcov is more for debugging and should not be enabled in production.
> 
> -- Steve
> 

Thanks again for raising this — I’ll make sure the changelog documents this
interaction more clearly.

Best regards,
Yunseong Kim

