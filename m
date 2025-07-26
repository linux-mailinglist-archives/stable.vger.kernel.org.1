Return-Path: <stable+bounces-164827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655A1B129AF
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 09:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A7189D872
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 08:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D5621A424;
	Sat, 26 Jul 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fVrDNwtE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E120297B;
	Sat, 26 Jul 2025 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753516778; cv=none; b=VtcjY+cK0wWyIAN9dTyzrbXylX9bG5U+6a+QHeXYpjEOVuzgKPe3DMjQW8PLvqF6lLA31WqHvM4lN0PqREF61r5VnpwqyzjpNC/h+7qyFcCKV3iOiI/Zynqj71m4282ACrOYGkfHNo5SAuMucTervnKoSKHukyySppjKkRExNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753516778; c=relaxed/simple;
	bh=+7OwWL8HsXou9HcpeVyEaPMNSqLGr7byrMdBXyWRVmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5S+CFg9cHLo6ORZhP5sN4ZCtnSj1NZiOcZOI7gaK3pmUD0lmt6MEeC2yjdzA1zkz9uhxEfTBeuI+IEH1B8eJhhbWLlzO/MxKocQNO0Y/X/dVrdhZA4tC2bSxp1WVB7vsQSMh+RNn2TTlNAVcyMl6edKukxJPjwf/JUUOEinq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVrDNwtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950F5C4CEED;
	Sat, 26 Jul 2025 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753516778;
	bh=+7OwWL8HsXou9HcpeVyEaPMNSqLGr7byrMdBXyWRVmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fVrDNwtEpWOUgHeNDV+Xg2hA5El/kRUrHYLdGGzc7I5nJofIA7pzN76Ck9iwADQCH
	 l/4GGwF2wahiVWxevK+E87qJLNRhdSBbmAOBOpat2+QDHD/+aD5ibm8mvyRONVDNTB
	 5U3v+XRi4fpKsuCDkY/IbHsF7RT41HkxjgzG/JOg=
Date: Sat, 26 Jul 2025 09:59:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Yunseong Kim <ysk@kzalloc.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Michelle Jin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org, kasan-dev@googlegroups.com,
	syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
Message-ID: <2025072614-molehill-sequel-3aff@gregkh>
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <2025072615-espresso-grandson-d510@gregkh>
 <77c582ad-471e-49b1-98f8-0addf2ca2bbb@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77c582ad-471e-49b1-98f8-0addf2ca2bbb@I-love.SAKURA.ne.jp>

On Sat, Jul 26, 2025 at 04:44:42PM +0900, Tetsuo Handa wrote:
> On 2025/07/26 15:36, Greg Kroah-Hartman wrote:
> > Why is this only a USB thing?  What is unique about it to trigger this
> > issue?
> 
> I couldn't catch your question. But the answer could be that
> 
>   __usb_hcd_giveback_urb() is a function which is a USB thing
> 
> and
> 
>   kcov_remote_start_usb_softirq() is calling local_irq_save() despite CONFIG_PREEMPT_RT=y
> 
> as shown below.
> 
> 
> 
> static void __usb_hcd_giveback_urb(struct urb *urb)
> {
>   (...snipped...)
>   kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum) {
>     if (in_serving_softirq()) {
>       local_irq_save(flags); // calling local_irq_save() is wrong if CONFIG_PREEMPT_RT=y
>       kcov_remote_start_usb(id) {
>         kcov_remote_start(id) {
>           kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id)) {
>             (...snipped...)
>             local_lock_irqsave(&kcov_percpu_data.lock, flags) {
>               __local_lock_irqsave(lock, flags) {
>                 #ifndef CONFIG_PREEMPT_RT
>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L125
>                 #else
>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L235 // not calling local_irq_save(flags)
>                 #endif
>               }
>             }
>             (...snipped...)
>             spin_lock(&kcov_remote_lock) {
>               #ifndef CONFIG_PREEMPT_RT
>                 https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/spinlock.h#L351
>               #else
>                 https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/spinlock_rt.h#L42 // mapped to rt_mutex which might sleep
>               #endif
>             }
>             (...snipped...)
>           }
>         }
>       }
>     }
>   }
>   (...snipped...)
> }
> 

Ok, but then how does the big comment section for
kcov_remote_start_usb_softirq() work, where it explicitly states:

 * 2. Disables interrupts for the duration of the coverage collection section.
 *    This allows avoiding nested remote coverage collection sections in the
 *    softirq context (a softirq might occur during the execution of a work in
 *    the BH workqueue, which runs with in_serving_softirq() > 0).
 *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
 *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
 *    the middle of its remote coverage collection section, and the interrupt
 *    handler might invoke __usb_hcd_giveback_urb() again.


You are removing half of this function entirely, which feels very wrong
to me as any sort of solution, as you have just said that all of that
documentation entry is now not needed.

Are you sure this is ok?

thanks,

greg k-h

