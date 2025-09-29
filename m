Return-Path: <stable+bounces-181930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD4BA9A3D
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EFF1C53C5
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9BA2FF677;
	Mon, 29 Sep 2025 14:40:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C63090C9
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156819; cv=none; b=fqOPkbmhLhO0iBGp72FkqFioLwnuY+A2o3Fr3vsoupIhTyAUBkotoxblCsZaP9NzL2BsOBGeo6zAX7BkkjpvPgCsJopz9Aoy3mpnUcXCk89qp1WQcbunkt4xJkjoTZJo50RnI7n5RW1NTzWjU+L5wQ9aG5Zd4/HyKU/BwWsapyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156819; c=relaxed/simple;
	bh=Vx65F82mVIZNZxe4bkcuWBGK9QheVv9ymW5Mp4kxpPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8dBLtPw/AelXkU2I12YhfdzGGbZnTRpjqTyoHjf538jdOqOK2GMIwaBx+cGcM6f5UT4VRMPkqYy+WtrqHq/OVuN+76R9RwiZoH00tJZ7DT5g9t4pxVAqKmn+D9OQ/C5c/MLfQ0Bn8EvltUXZjomf1ZzGPjt31/GnIzsWam7epE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso8509744a12.0
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 07:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759156815; x=1759761615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvFjznroqzFUOXsLEPiseH1v02F6mpBvJnWjh/fc570=;
        b=vshLsbj+s7XubBBQrtohsxCulOz/7xxjsggfJI/PVj4M6/hvxR7HqF2d5DXmiMrqQ/
         IINbG+xYnRPby4SfKIcRLvqM4EFrgHXqRywjvGBe5PcW/L84Vgy5XOu+7adddGtFpRAc
         GLSItXy79EucLYDZ7ptUVnwP2QhCb/hEfFIdUXe1aHAKb0YGCjJ7d3VdxVV/BJI58Fx6
         /+vrUrVU5K/gm6ILBACgnn1CTN4DFJwhGwcvo44BGzyU+/FJHVJ3xnwydI//Rq6P4nMm
         Cp03hyOdhTS5KanAQxYzdClk3ClxiyVJCmDTVqrfHyRpgvmShBHPGnSJrK3Bkr8YvgSR
         WmZg==
X-Forwarded-Encrypted: i=1; AJvYcCU0rUw4gR2VlgWn82N3QAaFL1HA3hisM4y6oBsce84kLSBYHFyxZlw4PfGQDEzuISd12+9Tz9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylteMmeqG8BsayRndMbVXYEk0KhynDMwtR/B2IU/jSwWQYliVU
	mzZzlBRXCVu27iO8nrgeC/yrwdX3oGasVDWzWw1wfZ9U5wzvrqUWEuSh
X-Gm-Gg: ASbGncsWlpSxCdzfLpehZWncsus/PTeJtvP8LlG1G8a40Padx8Uh8ju2/Z/1yv1xzKu
	bURCy0+HTidrKBy+k+bO5GF9fnBfGmfeHysv7uPrjYeIPd8edk8CkgrMXsSAeOXQhq5Ri3l6fHb
	O0IkvahvUtwX2+5KfJ6z+DVJH7TJBXfFZPk4AYFDVq0rHsS5SRixAFZTP0Ys1FKWwxZVM8hZyTJ
	bdBDNWysgTx52/b18iKCTwkxfKIUBllssCpGG+fqdtnB8i5OyQ4r0Jl12DlNIbRdEHpoUQspQRs
	sylmavIJ/EGGirec5RT/zQxpBl9gJqtXKgQsTFSN07iXmmXoAoIzCFYEW9kMTT6lkZakzMC6UPG
	gHa6sA68GRnsVNAQDvASqta4=
X-Google-Smtp-Source: AGHT+IHbZP5Sc9LmRevMUeUkY+gYIieaF0HX4TI6xI5A/0J/URStj2rfgjvSCWUg/riLdMA2Brr80g==
X-Received: by 2002:a05:6402:4556:b0:633:d0b7:d6ce with SMTP id 4fb4d7f45d1cf-6349f9f0134mr12493050a12.15.1759156814415;
        Mon, 29 Sep 2025 07:40:14 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a362993esm7945828a12.4.2025.09.29.07.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:40:13 -0700 (PDT)
Date: Mon, 29 Sep 2025 07:40:11 -0700
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Gu Bowen <gubowen5@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Waiman Long <llong@redhat.com>, stable@vger.kernel.org, 
	linux-mm@kvack.org, Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
Message-ID: <afbwnxlj4rxncrqc2bi7maljsy4vi3xq3a4ads7plvpww4in6n@r6d4yyebofdv>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
 <5ohuscufoavyezhy6n5blotk4hovyd2e23pfqylrfwhpu45nby@jxwe6jmkwdzb>
 <aNVSsmY86yi-cV_e@arm.com>
 <kuq7guzalpqj5bxe2vt6s3kirrq4sg5ozwcim6ewnzpxhuxm4l@yfgb44nbcisz>
 <84ikh1l5dh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84ikh1l5dh.fsf@jogness.linutronix.de>

On Mon, Sep 29, 2025 at 04:13:06PM +0206, John Ogness wrote:
> On 2025-09-26, Breno Leitao <leitao@debian.org> wrote:
> > My concern is when printk() is called with kmemleak_lock held(). Something as:
> >
> > raw_spin_lock_irqsave(&kmemleak_lock, flags);
> >    -> printk()
> >
> > This is instant deadlock when netconsole is enabled. Given that
> > netconsole tries to allocate memory when flushing. Similarly to commit
> > 47b0f6d8f0d2be ("mm/kmemleak: avoid deadlock by moving pr_warn()
> > outside kmemleak_lock").
> 
> Yes, it is a known problem that a caller must not hold any locks that
> are used during console printing. Locking the serial port lock
> (uart_port->lock) and calling printk() also leads to deadlock if that
> port is registered as a serial console.
> 
> This is properly fixed by converting to the new nbcon console API, which
> netconsole is currently working on. But until then something like Breno
> is suggesting will provide a functional workaround.
> 
> Note that printk_deferred_enter/exit() require migration to be
> disabled. If kmemleak_lock() is not always being called in such a
> context, it cannot enable deferring.
> 
> One option is to enable deferring after taking the lock:
> 
> 	void kmemleak_lock(unsigned long *flags) {
> 		raw_spin_lock_irqsave(&kmemleak_lock, flags);
> 		printk_deferred_enter();
> 	}
> 
> printk() always defers in NMI context, so there is no risk if an NMI
> jumped in between locking and deferring and then called printk().
> 
> > The hack above would guarantee that  all printks() inside kmemleak_lock
> > critical area to be deferred, and not executed inline.
> 
> Yes, although I think netconsole is the only console that tries to
> allocate memory. So if this hack is used, it should at least be wrapped
> by an ifdef CONFIG_NETCONSOLE.
> 
> Although it would be preferable if netconsole did not need to allocate
> memory for flushing.

Most (all?) of the allocation is in the skb, where alloc_skb() is done.

In fact, netconsole maintains a pool of 32 skbs that is used when
alloc_skb() fails. And I see cases when that is exhausted (when OOM
causes a lot of messages to be flushed).

If we want to make alloc_skb() out of the TX path, then we probably need
a bigger (configurable?) pool of SKBs.


