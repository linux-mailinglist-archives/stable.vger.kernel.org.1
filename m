Return-Path: <stable+bounces-163303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16131B09662
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 23:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCDD5A108A
	for <lists+stable@lfdr.de>; Thu, 17 Jul 2025 21:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3BA1F8677;
	Thu, 17 Jul 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTjd4VKQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8717E0;
	Thu, 17 Jul 2025 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752788090; cv=none; b=cv/CyF8pZ5Ws6J+Y/dRSy7bT92rchr5w4LFFkfA2NJW0LDHkQMSBeRD2Y//KZRlKUC267WE+D7Q5f+YHuPtDJA0UMg/VUE/VWog1hY5HdLAd63Nx3pSeuBpkh3Rq+vE8SW4GESykpRiFjnlmZwml1m9zCnm2y4hcS5OloTqZ+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752788090; c=relaxed/simple;
	bh=RZ5LCj78Lyclzd69cYMhCDdSFiwmonnYvLEWvFmsqc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHAN/SoWlL0CKZF85tksZ7J1dwckRAii2J0B3gpOFvR2HE+Nii/V4hcgKLzooyTipaq4bvPahLcZmqOYLaTt7vCYfg3XpfrgCGHbE7d+mH1+tTZxiwIa3s+e5GP+BCncv0UK0tVyoagrDMRYRmLMyYmAlDOQzmW6leI80SxIQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTjd4VKQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45555e3317aso9101595e9.3;
        Thu, 17 Jul 2025 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752788087; x=1753392887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kUb9sx3TgEhRQfOmqwV/GlUdwT7le0YBTWtsC9eCWk=;
        b=WTjd4VKQGtvEGEpKeLQOVngDALhqe4kgiu3MkM3LZOpdySH4vXUmgAVjSq61RLvLIU
         ny9yvqJ4ZWZmAUuPAlGZQp5gBzWr1uAnmNFiq4uy4O/v/yN2wl6dSQOr7LsQYmTIUOfO
         KjsC7E+05Yc9MdNTUu6ExdWd/2ckzgUaJQRFDN14N3Ep9rnavLm2TvvAoo+qEWIYFvHZ
         50a6n5Lu81WhkZ6Bs/TFZGcr9TvBPJBjPhv7Cy8ha5fT6NcGLOiBiXkpf922UJ92p//y
         EqfQP1Rzg/+UcvXe+SsgYl+IFzLgxDCKIPp3fo8rSu8gCQ+NJiMkc2AhCinVmC/9tvRC
         IYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752788087; x=1753392887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kUb9sx3TgEhRQfOmqwV/GlUdwT7le0YBTWtsC9eCWk=;
        b=QUxszR0NapdDshDbT5KzmWE+NEBnFT1RRNLXXI9/wyFJrIS6ZDoiPwAtl4x9k/eKKl
         fGD2B6FTCm63Zb9o5Y9q99sCpBxSJPIFoRKFqdhTjNStJSN1SiO1Zl3a/2fQ4jN7PLlo
         uIip1tLXiFuV+vxwHeUuiZakJT3bsoORYFpWOWTa6+/aW/jzhRr1rqkN2ulYy3kx/cJv
         3h6cyzcT1iiuk2Zb+EAWurAzPi7CbZqb0Gqdhl0RTigoxwxRjtlaeLeCvy0lRXkPpAvS
         tbVa/8wmkJ82ZHDJek9Y6Azjq9Kk4nFe/Fe83e7oPVQfC6o32m9ICNKBOB5DMNrUFqCP
         M7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVng9dOixb2ZJ91dI9kFzE7AX6LphCt+3ue5oaIv6oIoTd8++092jMTxS2I1EVLr5Ocu4NGLDj/@vger.kernel.org, AJvYcCXpCcEbcJR3U6njG8TtG3XTwGZO/A1AN/MfkoAmFaB3TH+UkAxSh1GdvVlxL97Yxg12IlOYJnH+VrTOLMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QVQMavgCOHoykEL2Eq5esPlFzEe6CIx+WvhJG1hikn9xgbBN
	h0zQUpitcuk6MBjhzv+gPf/pJu6NHiOARSw4uqg+0Tbf+tjVT1byeyMG
X-Gm-Gg: ASbGncsb9zBc6mOeOEaQC0c7An7ECXJdBmFiJJc+jx0rgV1+3LfXMePrdj+7m+Qx92Y
	p7ajzNcIY1zH8mHnCTvpkyzKYx1gVMsKf3Q8YVaR/fWOTUY7Pj730Qd+Comagd6gEHwD1BqIBe/
	kbe0dHsAmc1UUORLNsYq8aHt/hEqoHPy0JOZgaggAp/wQcwe3tp0j+8v9ctAgrr6Qr1pQ+3fQAs
	yCpG3F+tFXct17TGuix9JPM6NDABBUbYwdvWC7oLHnDtlXppj2zqcX8Z3QVSv7n7zp791Rzantp
	0VIOf1HQwpchk0ZisdJfukpwlZ022UGWXJxR4VDI7ZOoshlY0bkDl7gSYcbVAvgbF1ggMnHYAan
	OLaGL+NsyZL1Otb1kc+jye2pGLqRXgNHS/0kltmO3Y85ALc8GFx4dtt1sgYoedJ5KLY9LIrI=
X-Google-Smtp-Source: AGHT+IHm8FDJfA/A0rgo1t7ybSLh0izLhUn28eqZq/uWQgZMWeQ+vwxuuQPRIAX7Jj/iGvhRFd4OIQ==
X-Received: by 2002:a05:600d:1b:b0:456:3b21:ad1e with SMTP id 5b1f17b1804b1-4563b21b300mr5349835e9.17.1752788086660;
        Thu, 17 Jul 2025 14:34:46 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9298sm21746316f8f.44.2025.07.17.14.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 14:34:46 -0700 (PDT)
Date: Thu, 17 Jul 2025 22:34:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, sashal@kernel.org,
 linux-kernel@vger.kernel.org, frederic@kernel.org, david@redhat.com,
 viro@zeniv.linux.org.uk, paulmck@kernel.org, stable@vger.kernel.org, Tejun
 Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, "Luis R .
 Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v2] kernel/fork: Increase minimum number of allowed
 threads
Message-ID: <20250717223432.2a74e870@pumpkin>
In-Reply-To: <48e6e92d-6b6a-4850-9396-f3afa327ca3a@kernel.org>
References: <20250711230829.214773-1-hauke@hauke-m.de>
	<48e6e92d-6b6a-4850-9396-f3afa327ca3a@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 07:26:59 +0200
Jiri Slaby <jirislaby@kernel.org> wrote:

> Cc wqueue & umode helper folks
> 
> On 12. 07. 25, 1:08, Hauke Mehrtens wrote:
> > A modern Linux system creates much more than 20 threads at bootup.
> > When I booted up OpenWrt in qemu the system sometimes failed to boot up
> > when it wanted to create the 419th thread. The VM had 128MB RAM and the
> > calculation in set_max_threads() calculated that max_threads should be
> > set to 419. When the system booted up it tried to notify the user space
> > about every device it created because CONFIG_UEVENT_HELPER was set and
> > used. I counted 1299 calls to call_usermodehelper_setup(), all of
> > them try to create a new thread and call the userspace hotplug script in
> > it.
> > 
> > This fixes bootup of Linux on systems with low memory.
> > 
> > I saw the problem with qemu 10.0.2 using these commands:
> > qemu-system-aarch64 -machine virt -cpu cortex-a57 -nographic
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> > ---
> >   kernel/fork.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 7966c9a1c163..388299525f3c 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -115,7 +115,7 @@
> >   /*
> >    * Minimum number of threads to boot the kernel
> >    */
> > -#define MIN_THREADS 20
> > +#define MIN_THREADS 600  
> 
> As David noted, this is not the proper fix. It appears that usermode 
> helper should use limited thread pool. I.e. instead of 
> system_unbound_wq, alloc_workqueue("", WQ_UNBOUND, max_active) with 
> max_active set to max_threads divided by some arbitrary constant (3? 4?)?

Or maybe just 1 ?
I'd guess all the threads either block in the same place or just block
each other??

	David

> 
> regards,


