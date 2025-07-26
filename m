Return-Path: <stable+bounces-164830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF951B12A54
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EC4543A89
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCC4242D83;
	Sat, 26 Jul 2025 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfXFPJlk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qu5Vv5Bx"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4576200132;
	Sat, 26 Jul 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753531196; cv=none; b=CI/d+PmhB5/J3QgH8KRihhjbfWG88SOAdzzKOkiDDDEo2jpWX8ONKSWprWNCxPqJkPlhCwn08qpVCxtD5BZMguMoVj3RFTQc9I9fGw0ZZyM4voFLXL7/qBzn8/Mtqnbl52H09sF282qUVe8ZdgJ/yUwqaC54eyJcl3HxnPt+h8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753531196; c=relaxed/simple;
	bh=e9ZHZi0F7JWdfqhdsjEBHsC+0Dy6+SkPdlpSOOJLwAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XHRIkrbeOiuL5KG0tkj1pttiM9eQDi9VsQcPzhaVkd3JnA4ehMmJk+FgPa4VHRLvsZkX9/B+Js1kshR2z5Um416RykbZ7ZhmZ2Ru8NIz7br621EuKuV/NKgMgrFEkGNNAbi85Fxk9XSTsv+Sot5NOrJ11arhc0K3e/qMUHTPm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cfXFPJlk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qu5Vv5Bx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753531186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QLD/9vDRaxK7wnQrPT92N/0V2GDCn8DkNHpJH1+2ME=;
	b=cfXFPJlk7jB/sMHf6ZzDQyfd2LIVeZJ8I39wANs0u8oRGHvKkhXz63gqfP5A9GLa9RYZAa
	4fYMkwBOiGcsUXbJBP/pgEeDnytTcDNGF8h2suAm3yrWHKn4tdceaXafe63n2Syci7gMEX
	ffGS7892X7j/53z/zCvrGplQs3bXIMdiSnHSIA1Vp1JK5l7D3ZfZ35t1wE3jpMnq6DJYPv
	Kwv9Rjfl/39lN5SSh+JcxFIjWrjYURjpFQCZfrU5kEXB/91aWoNIrnvQPz0hzYUfVTSOrz
	2LAw0ny6JKitQOHUZ0/NMQv+Eq8X2eql0qPc6RspX8DkyIBzDlh+szANN35KwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753531186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6QLD/9vDRaxK7wnQrPT92N/0V2GDCn8DkNHpJH1+2ME=;
	b=qu5Vv5Bxsuj0Aow+4si+jm72q35U4cUB5T/nEFzyJ41GvUFYqpf5F11Dqu+CwRuAtgKsyi
	jWZkC7WdLCz3pCBg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>
Cc: Yunseong Kim <ysk@kzalloc.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Byungchul Park
 <byungchul@sk.com>, max.byungchul.park@gmail.com, Yeoreum Yun
 <yeoreum.yun@arm.com>, Michelle Jin <shjy180909@gmail.com>,
 linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, stable@vger.kernel.org,
 kasan-dev@googlegroups.com, syzkaller@googlegroups.com,
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] kcov, usb: Fix invalid context sleep in softirq path on
 PREEMPT_RT
In-Reply-To: <2025072614-molehill-sequel-3aff@gregkh>
References: <20250725201400.1078395-2-ysk@kzalloc.com>
 <2025072615-espresso-grandson-d510@gregkh>
 <77c582ad-471e-49b1-98f8-0addf2ca2bbb@I-love.SAKURA.ne.jp>
 <2025072614-molehill-sequel-3aff@gregkh>
Date: Sat, 26 Jul 2025 13:59:45 +0200
Message-ID: <87ldobp3gu.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 26 2025 at 09:59, Greg Kroah-Hartman wrote:
> On Sat, Jul 26, 2025 at 04:44:42PM +0900, Tetsuo Handa wrote:
>> static void __usb_hcd_giveback_urb(struct urb *urb)
>> {
>>   (...snipped...)
>>   kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum) {
>>     if (in_serving_softirq()) {
>>       local_irq_save(flags); // calling local_irq_save() is wrong if CONFIG_PREEMPT_RT=y
>>       kcov_remote_start_usb(id) {
>>         kcov_remote_start(id) {
>>           kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_USB, id)) {
>>             (...snipped...)
>>             local_lock_irqsave(&kcov_percpu_data.lock, flags) {
>>               __local_lock_irqsave(lock, flags) {
>>                 #ifndef CONFIG_PREEMPT_RT
>>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L125
>>                 #else
>>                   https://elixir.bootlin.com/linux/v6.16-rc7/source/include/linux/local_lock_internal.h#L235 // not calling local_irq_save(flags)
>>                 #endif

Right, it does not invoke local_irq_save(flags), but it takes the
underlying lock, which means it prevents reentrance.

> Ok, but then how does the big comment section for
> kcov_remote_start_usb_softirq() work, where it explicitly states:
>
>  * 2. Disables interrupts for the duration of the coverage collection section.
>  *    This allows avoiding nested remote coverage collection sections in the
>  *    softirq context (a softirq might occur during the execution of a work in
>  *    the BH workqueue, which runs with in_serving_softirq() > 0).
>  *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
>  *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
>  *    the middle of its remote coverage collection section, and the interrupt
>  *    handler might invoke __usb_hcd_giveback_urb() again.
>
>
> You are removing half of this function entirely, which feels very wrong
> to me as any sort of solution, as you have just said that all of that
> documentation entry is now not needed.

I'm not so sure because kcov_percpu_data.lock is only held within
kcov_remote_start() and kcov_remote_stop(), but the above comment
suggests that the whole section needs to be serialized.

Though I'm not a KCOV wizard and might be completely wrong here.

If the whole section is required to be serialized, then this need
another local lock in kcov_percpu_data to work correctly on RT.

Thanks,

        tglx

