Return-Path: <stable+bounces-208366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8A8D1FBA3
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 16:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E62E305570F
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5874399031;
	Wed, 14 Jan 2026 15:21:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282939524D
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404104; cv=none; b=bX2JyKBU2Lci4s5lnZcF6bpDI0wpZqadR+0LtXo9vxn+79hRtxkP++oaaJPGDEQmDcSTYSWWDg5Eu8F9zRanBajkp9YXWpbt6tAOM19Rt6+km+ePaDcQ9gIygPfaLG0TgKQ4olQJYgAHq4BknGBR9IvgPUJPIL2Mt1Q0hi0G9N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404104; c=relaxed/simple;
	bh=5g2VVetjqrKQeMPIx+Kj58kM566p9+vF50d4mJ7hOK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcc7CmySlxecdtWWq3YVa1nknwqH2s3IM6i3bnl0VJZ8FtYoYttJcey8rKvNZpsQ4wXP1lizG96khZGbppL5+TteOzZ/+FbhbvdqJkUB7xVj+K9xzL60eh0a5VgVOS00ajrVLYP435UwyzlBEc4D7cekOg2XIm2W27W5g1eLohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45a815c1cfdso2210936b6e.0
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 07:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404095; x=1769008895;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI9Phsj/nSMNdFp89o7zHIAUGa2rQCyWo79deKjR47o=;
        b=WFjpRswL5F5gdUfieo0xItsKQ5fpx8ZVt+2Ld5u4LxG8fJpt1ibKbosq5hbrJ2SnCk
         exsCUtOtptr5EIA8XYfD8hFEU5wql1RZvswHQrHn02RI8l7wc61LaJ3xmTm10tUEBMv2
         lNdH0ZiEjaouByK6k+BwDLgSvG0keudr3SMMqmsG1yrAVdKlmVaG5zZ4rg2WIkovbIao
         cus/poD/XW78UYRvscVMpwYmuWekArx2BCUrWGq9WQ70fC5uchvvXqUQW/WXRpf+6Wwa
         kyGUL5XBO42Kwq9PuT5jEZoMCOVH4MN36ABvRipXnQIfpY5YxN9fsMoZArXL497pS3Xc
         cnfw==
X-Forwarded-Encrypted: i=1; AJvYcCUweZqPPi9QL1RYXg94Dd9AdOF1uhDIfJ2qKGgjgiQ+xw+DA2VOLao/l4nQ11+GKUwxBOuFgso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4SNtCR6Vy51DhFfrQd6s2nlPE3deIQKrFxWnqI1H90dxpCdE
	MJhoHYGI8TlBptZ3BhMHw4PlxGyh6VNLoAGIZ520ed9JxGh4TznpvRCC
X-Gm-Gg: AY/fxX5F8hG3gdrScWR3d25/Zmivi0eZ2cZ6N6E6/paWwJZUQgmxRu8HBZt1xX9y3vR
	jPVfbr1X64lbg348x6SElktqzrdZwbEGDPCLTF8rEZCrxMTr9YmdZi7Eev7rwoEa36IvjYJELLC
	QSeQWVIPk9803Fep73aKTdOxKKkV7hnT9+x/rNH1rVQM1EralhI7HtByLN8G68VmZjuetEDrhIY
	JKF3b+FbFK/HN3f8rhgb6vvGWEIkKbRVlHaLmKHvH8FLiZmggIB0YHH+Nq0bcziPSm05mM5Dra/
	0eCv9uSLFYQ/6D8eKuYe1U2kyZjrrt03J9JIFodnAmUw2WV8Xzx5bf3pfXBmjSfVNe2jctGVW6S
	pGl29hxRTxHW8MqKZk9Vdbc4UNeoaR+FatAH/i3slqFSoO01yb/RY3qmtF+NNZbyqdIa/v1TQ9X
	bO/Vs1AFDCdozV
X-Received: by 2002:a05:6808:528e:b0:45a:5584:9bf5 with SMTP id 5614622812f47-45c714331e3mr1702212b6e.4.1768404095351;
        Wed, 14 Jan 2026 07:21:35 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e288bc7sm11600518b6e.12.2026.01.14.07.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:21:34 -0800 (PST)
Date: Wed, 14 Jan 2026 07:21:33 -0800
From: Breno Leitao <leitao@debian.org>
To: Chris Mason <clm@meta.com>
Cc: Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kfence: add reboot notifier to disable KFENCE on
 shutdown
Message-ID: <p7gi44yt26bpjbjkvuhd54tqp3vn7z6wq346gmvazg5t3kir4p@gdf64eax44rm>
References: <20251127-kfence-v2-1-daeccb5ef9aa@debian.org>
 <20260113140234.677117-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113140234.677117-1-clm@meta.com>

Hello Chris,

On Tue, Jan 13, 2026 at 06:02:27AM -0800, Chris Mason wrote:
> On Thu, 27 Nov 2025 06:51:54 -0800 Breno Leitao <leitao@debian.org> wrote:
> > @@ -820,6 +821,25 @@ static struct notifier_block kfence_check_canary_notifier = {
> >  static struct delayed_work kfence_timer;
> >
> >  #ifdef CONFIG_KFENCE_STATIC_KEYS
> > +static int kfence_reboot_callback(struct notifier_block *nb,
> > +				  unsigned long action, void *data)
> > +{
> > +	/*
> > +	 * Disable kfence to avoid static keys IPI synchronization during
> > +	 * late shutdown/kexec
> > +	 */
> > +	WRITE_ONCE(kfence_enabled, false);
> > +	/* Cancel any pending timer work */
> > +	cancel_delayed_work_sync(&kfence_timer);
>                    ^^^^^^^^^^^^^^^
> 
> Can cancel_delayed_work_sync() deadlock here?
> 
> If toggle_allocation_gate() is currently executing and blocked inside
> wait_event_idle() (waiting for kfence_allocation_gate > 0), then
> cancel_delayed_work_sync() will block forever waiting for the work to
> complete.
> 
> The wait_event_idle() condition depends only on allocations occurring
> to increment kfence_allocation_gate - setting kfence_enabled to false
> does not wake up this wait. During shutdown when allocations may have
> stopped, the work item could remain blocked indefinitely, causing the
> reboot notifier to hang.
> 
> The call chain is:
>   kfence_reboot_callback()
>     -> cancel_delayed_work_sync(&kfence_timer)
>        -> __flush_work()
>           -> wait_for_completion(&barr.done)
>              // waits forever because...
> 
>   toggle_allocation_gate() [currently running]
>     -> wait_event_idle(allocation_wait, kfence_allocation_gate > 0)
>        // never wakes up if no allocations happen

This is spot on, I think this is a real case if the following happen:


1) toggle_allocation_gate() passed beyond kfence_enabled and is waiting
   for kfence_allocation_gate to be > 0.
   a) kfence_allocation_gate is increased on allocation time

2) There is no more kernel allocation, thus, kfence_allocation_gate is
   not incremented

3) cancel_delayed_work_sync() is for kfence_allocation_gate > 0, but
   given there is no more allocation, this will never happen.

> Would it be safer to use cancel_delayed_work() (non-sync) here.

In this case toggle_allocation_gate() task will continue to be idle,
waiting for to be kfence_allocation_gate > 0 forever, but it will not
block the notifiers, unless we wake them up.

Is this a problem?

Maybe a more robust solution would include:

1) s/cancel_delayed_work_sync()/cancel_delayed_work().
  - This would unblock the notifier

or/and some of the followings

2) Return from wait_event_idle() if kfence_enabled got disabled.
  - Remove the waiters once kfence got disabled
  - Cons: kfence_allocation_gate will continue to be negative

3) Wake up everyone in the allocation_wait() list
  - This might not be necessary if we got 2, since they will wake
    themselves once kfence_enabled got to 0
  - Cons: kfence_allocation_gate will continue to be negative

4) bump kfence_allocation_gate > 1 on the notifier
  - Avoid kfence allocation completely after it got disabled.
  - Cons: it is unclear if we I cant set kfence_allocation_gate = 1 from
    the notifier.


Thanks for the report, 
--breno

