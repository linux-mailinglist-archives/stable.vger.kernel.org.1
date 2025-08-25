Return-Path: <stable+bounces-172838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A62EB33EC7
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 14:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77892189D9C9
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 12:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7444526B77D;
	Mon, 25 Aug 2025 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNW675k5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCB2ED164;
	Mon, 25 Aug 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123641; cv=none; b=eTlWTQrplDnAT70Mx6hoXP2JZ3vsY0+0YIZTwehMWi2H5VZJh6LKrtDEUFERapoVbHaBrWsh/ERRQs4/7+eXX6p8rUjQkuikVvq8XdlvAlbCE9kZyvimDdvq3UQY73xzRURE3rx9W/XJJLlXGLw9gHFSfZJBeah4nO4Bjs5JVyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123641; c=relaxed/simple;
	bh=h5t0F8ZOG4T1UfpMkMbsS1DiLtg8HyKR+2yVoEcpq6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiT4kzCq1dSTsF5iiuOUpJVbsWbxdWPk/2EWF/bjUddtyegjEwHiNgLL4RMrZeGIzR4yIA9PJQqtaNWMTwoaVXxJniwZWlRSWcDdb3oU/fv5MOFR0XUelSaedUb45Tai8ffldSpRhqw5dNIGvNigzwoZ+DRPLI4h9jXaT8O5UR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNW675k5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c7aa4ce85dso923572f8f.3;
        Mon, 25 Aug 2025 05:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756123637; x=1756728437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mX6ZyNPbUTtrcs9lMZu6//5EKcjRnkQut+eqn8r6GFM=;
        b=CNW675k5W4d8yTIuohYwfyld2S7eyHutY1pVvJwUfbdctQ3IftvmJrcI6W+77yV8og
         KSVTG9IP3uFHlzJkMeHm1QCKsH+akwXMocUgTlKLyxney7Gs68MFRmRno88j463gPPFD
         NHY1CpOBcNdU0GaiMZftj0KJNNMKARKT1M6fAfRmr9RLBl2DTl1ZqykbKDpHyvWssabY
         jZb+8bjY5f6dYWhfRcu2yYq2uZDL2HmhWS0Ay9DNC1c7MwmX8OylutgcqhopWkvYIpcU
         pCTjlgYO67qs3A9qcpm/JXN9DOm9E2luqwgEQhlRvWZNyGbGc+6ZHfK+9lS0hSZsNd8q
         09YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756123637; x=1756728437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX6ZyNPbUTtrcs9lMZu6//5EKcjRnkQut+eqn8r6GFM=;
        b=HVcTo3s1Dqe1XqnoFEp0bUaoPw2oxWwXV5dK0FyqalELuFPPKro/lVspU0BZGzAgyc
         j+DsRey9EIfCc1/MePxqD2HBZEgdSs6DSMEw01CF3eUualJF598PzRxkrqcgtYrFqgVE
         XRJGBZ5rw5a2tSDOFXtDupusV1npFA0Zz9oshyOds1c1EWaXTzX3iXnuT+V3xrtXaH2R
         lzAvTduClP2cxo/hE4+ziTQdW256UKVA/0y1+c3278STL/2TORC2OTdJAKoykwkmGeHX
         cR4SO0ckvNi8uTUPcRCgotv8GtFySeG0vlTMcDE95M5I3JKUosBel3LI1ajfuCvUWMUP
         f0ng==
X-Forwarded-Encrypted: i=1; AJvYcCVRrr3kalI9W8395UvzNIvIBlr1VB0W/47pspmss9tKjBl9ksR7+fmEaNaS+xkLvOvj9mg2TuXF@vger.kernel.org, AJvYcCXDew4YCIBG+LXvfK55kHXJ01pM09k0939aozZvIRlb4dyxYFSTJUYgB5p3L4E2U5JZ5g9MWslr0vg4qjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKEnovlaYzg1fDg8q0TRjxgFz2wCYZn72912FO4uTVukesZsZr
	nCZNRUGAUtOEh1HprfWM5KiAmuA1S2enYjGOA1gEEKeP7Hjw9SlhsJrf
X-Gm-Gg: ASbGncu/tPaOhJwlirLTnHqLWHlVX9aZIeo1ZZdIX3iRMHuiwZMhM4lXAvzKrqi4lqR
	ojy/zLAlw/dIOpHgQQu36VKVa78rerZfkvVLoB8BE9f61646c89aHkIAgU+7rlFzKqpPBtbn4O1
	3vFZvh4La5rw3+ugz3ovFfqwrzMRwhCEba5QquNlAQDycfYp8BF3MjJCtTru3tWo1HeZM9Ngh4c
	X7OOnktK088Sk045WEahvigGPytDg1g0kYCRBIhvVtqQhrVGSKyeRbVeiVVIXuDcI6swvoZrVVH
	JTQWHwtXw8azGENWWvvvMC50l5PhuXo7sNz7fxorgc4WBJsAHysVbV5jw0+Y7d1lpnfu7q56sTx
	LMYHjtcCs5C+WvjdrCcpOm0dh05wiHruzWcRnUAT3dc+bMc0gYnNEfDEOPfHS/mwW
X-Google-Smtp-Source: AGHT+IGeHwM+hA/mxAmVkchgVF32pBoquHDVMxwsrm1PZwKBjfQEV8lVUD0pWP7jEQEySlDA0Z3+rQ==
X-Received: by 2002:a5d:5f8d:0:b0:3c7:44eb:dd7f with SMTP id ffacd0b85a97d-3c744ebe1f7mr5834987f8f.18.1756123637228;
        Mon, 25 Aug 2025 05:07:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7119c4200sm11243925f8f.53.2025.08.25.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 05:07:16 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:07:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Finn Thain <fthain@linux-m68k.org>, akpm@linux-foundation.org,
 geert@linux-m68k.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
 oak@helsinkinet.fi, peterz@infradead.org, stable@vger.kernel.org,
 will@kernel.org, Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
Message-ID: <20250825130715.3a1141ed@pumpkin>
In-Reply-To: <4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org>
	<20250825032743.80641-1-ioworker0@gmail.com>
	<c8851682-25f1-f594-e30f-5b62e019d37b@linux-m68k.org>
	<96ae7afc-c882-4c3d-9dea-3e2ae2789caf@linux.dev>
	<5a44c60b-650a-1f8a-d5cb-abf9f0716817@linux-m68k.org>
	<4e7e7292-338d-4a57-84ec-ae7427f6ad7c@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 15:46:42 +0800
Lance Yang <lance.yang@linux.dev> wrote:

> On 2025/8/25 14:17, Finn Thain wrote:
> > 
> > On Mon, 25 Aug 2025, Lance Yang wrote:
> >   
> >>
> >> What if we squash the runtime check fix into your patch?  
> > 
> > Did my patch not solve the problem?  
> 
> Hmm... it should solve the problem for natural alignment, which is a
> critical fix.
> 
> But it cannot solve the problem of forced misalignment from drivers using
> #pragma pack(1). The runtime warning will still trigger in those cases.
> 
> I built a simple test module on a kernel with your patch applied:
> 
> ```
> #include <linux/module.h>
> #include <linux/init.h>
> 
> struct __attribute__((packed)) test_container {
>      char padding[49];
>      struct mutex io_lock;
> };
> 
> static int __init alignment_init(void)
> {
>      struct test_container cont;
>      pr_info("io_lock address offset mod 4: %lu\n", (unsigned long)&cont.io_lock % 4);

Doesn't that give a compilation warning from 'taking the address of a packed member'?
Ignore that at your peril.

More problematic is that, IIRC, m68k kmalloc() allocates 16bit aligned memory.
This has broken other things in the past.
I doubt that increasing the alignment to 32bits would make much difference
to the kernel memory footprint.

	David


>      return 0;
> }
> 
> static void __exit alignment_exit(void)
> {
>      pr_info("Module unloaded\n");
> }
> 
> module_init(alignment_init);
> module_exit(alignment_exit);
> MODULE_LICENSE("GPL");
> MODULE_AUTHOR("x");
> MODULE_DESCRIPTION("x");
> ```
> 
> Result from dmesg:
> [Mon Aug 25 15:44:50 2025] io_lock address offset mod 4: 1
> 
> As we can see, a packed struct can still force the entire mutex object
> to an unaligned address. With an address like this, the WARN_ON_ONCE
> can still be triggered.
> 
> That's why I proposed squashing the runtime check fix into your patch.
> Then it can be cleanly backported to stop all the spurious warnings at
> once.
> 
> I hope this clarifies things.
> 
> 


