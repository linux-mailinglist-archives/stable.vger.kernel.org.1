Return-Path: <stable+bounces-104454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED39F45BB
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A91197A2F0C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700061DB92E;
	Tue, 17 Dec 2024 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFb+VDzt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE11DA628;
	Tue, 17 Dec 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423096; cv=none; b=GFBfv0Z59I2rvqZ2uXpBvJgzcGOrRrGcS12zqTbqE2BlTUi8RhVUQXCgOEca/07DQnfVGG+udedSikzOCsnXDtGGrDukw1X47fHI/UloyZeWgKu6w8vL6AJNiY8TDmfntj8j1PqqeZiqB83jVHYf6JP0RGXwv5je+ofX5WwlHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423096; c=relaxed/simple;
	bh=oMPsSsMtuHF6Sh2Y44I1DioR2rSUg1qpJqogpglXFjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HrxSfTv1h/9N4ObczuGvC7KpMxILCSlWhN/L9I7bl8NVyL8BOJYMqvYPDKVvKWo89s+meflrWL0M8KgPKt9TLN3ZN/E0eWV1JkJ40jOM8G8Wo5b+a/SCtOV3nJ+yIsO3YiMvkxyIcosvutD5WZLQL5fgm/DfpXcLKXphlEzF9J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFb+VDzt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so4498400a91.2;
        Tue, 17 Dec 2024 00:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734423094; x=1735027894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wUWghKGKutv9AS8ORNp90vLzxXWKSu+IMtDpkU6/IbY=;
        b=eFb+VDzt444yLbDZ3JDj3KvfcZ7sRyOza59q+YmKxz87xMrVL/ulAOR04LqsdfR9Ce
         /6kni03bY+gcd0+VKdILSu5z6TUmWYYqLUzF4oS/yQD7mENHWKucjh2PfY3FO6dg7dP2
         F31JljXfZx9uYh6LovyvToddoafkmqvqbnZjSiERNy0l7EccfM5aZXEqnEPKZtNUwAAY
         Q7l34hV7OTLGh6Mb9wo/S6QVMNJWTnPnwjPB2al7cQe2fj8FhsKur+xwGi1PkGv82F2s
         rLssm5qp9ROHHjnEQ12fyXq9R9KHkLIl1v/j617SjGvgbM09GI4ob1icGXlAHsbBRAUo
         ukbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423094; x=1735027894;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUWghKGKutv9AS8ORNp90vLzxXWKSu+IMtDpkU6/IbY=;
        b=DZI6S4IkjJvTEAO9R747CcbEL/8I0wcOuhyAhZcnwNIU5jZDyR86N3E/VZTbnZmKHO
         hC0O13d5hrXnQZz3W6ytLENmNQlBOJwcO4Hghdo9ZswlotaLI81/0vU9HMnZMcl4wTyB
         QuE/vpW6XLLe1qe0aACZc8GB1Sd6bXnx4iPZn9ren4aRg2hy/ZuGwd6ZwzG4A9pVZs9O
         y41uQFZEnqHx+Cp/3h5cyckrTyNVdSWZKNCeM/Fj90t7+1+zldgyYMwQCCWHvI7MA+Wt
         NqLRDC1VrmbhaqGOFpVKrPYOhATdxyecf6AszBhR6uXIX/nrbEhIGuZyhTJquUioDecQ
         nrWA==
X-Forwarded-Encrypted: i=1; AJvYcCVYQsK7JdJCXkqZ2xmBybwApF9Qb18bnAh/QIyYEgbo/oghqq7of/tJ6qj/9iXDVfxX23js@vger.kernel.org, AJvYcCW8yh9kIqAvcs7KUA8oJeYUeOar/HFV7U87pEs0HxLCCAUNmIMIO3qJ81czW7vV9uNeyUA+OxIEeQvM1UI=@vger.kernel.org, AJvYcCWYJWndmOql8dWD7jg1fKsLX0JjXYB6kxCKDCPkARDahRpXNZk+2MiMP3uG27uhjxC5LkwZMqre@vger.kernel.org
X-Gm-Message-State: AOJu0YxGdBxCNCNxPDe+q9t5rD2AKjrwzgRgnHDq07FcHBUg4Qr9Mllk
	e8c5o5BTwahwQZZ1r7iMJeyshJ/EfMheJcGFeHSxC6FxmbaqlpUFbhs4fH3znZEz64PW6ytZ/dF
	ECe50dZ7jxgqiZ1VABVTl3VfJnlE=
X-Gm-Gg: ASbGncsm9aC6h42XbDR7Ciif2/AoujkpHpAcAy2pSVgu7XCcBsxi5arqNs+QUbQK5zl
	9q1rWyNR9qUD4TB4nzBpw7UIeP6N7rQknvhhK5OI=
X-Google-Smtp-Source: AGHT+IGmuWNT7jSdWN0td2tGQ5Oh7L9TtJ+KpxekqzfgvK1XHiG4fspxCvHqe6se6hBBthUsz5Go+FHiPThWSgs9pJU=
X-Received: by 2002:a17:90b:2f0e:b0:2ea:4c8d:c7a2 with SMTP id
 98e67ed59e1d1-2f2900a6efdmr25314265a91.24.1734423093841; Tue, 17 Dec 2024
 00:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024121411-multiple-activist-51a1@gregkh> <20241216-comic-handling-3bcf108cc465@wendy>
In-Reply-To: <20241216-comic-handling-3bcf108cc465@wendy>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Tue, 17 Dec 2024 16:11:21 +0800
Message-ID: <CALm+0cVd=yhCTXm4j+OcqiBQwwC=bf2ja7iQ87ypBb7KD2qbjA@mail.gmail.com>
Subject: Re: Linux 6.1.120
To: Conor Dooley <conor.dooley@microchip.com>, Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	stable@vger.kernel.org, lwn@lwn.net, jslaby@suse.cz, 
	rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Dec 14, 2024 at 09:53:13PM +0100, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 6.1.120 kernel.
> >
> > All users of the 6.1 kernel series must upgrade.
> >
> > The updated 6.1.y git tree can be found at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
> > and can be browsed at the normal kernel.org git web browser:
> >       https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> >
> > thanks,
> >
> > greg k-h
> >
> > ------------
>
> > Zqiang (1):
> >       rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()
>
> I was AFK last week so I missed reporting this, but on riscv this patch
> causes:
> [    0.145463] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:274
> [    0.155273] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
> [    0.164160] preempt_count: 1, expected: 0
> [    0.168716] RCU nest depth: 0, expected: 0
> [    0.173370] 1 lock held by swapper/0/1:
> [    0.177726]  #0: ffffffff81494d78 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x2e/0x374
> [    0.188768] irq event stamp: 718
> [    0.192439] hardirqs last  enabled at (717): [<ffffffff8098df90>] _raw_spin_unlock_irqrestore+0x34/0x5e
> [    0.203098] hardirqs last disabled at (718): [<ffffffff8098de32>] _raw_spin_lock_irqsave+0x24/0x60
> [    0.213254] softirqs last  enabled at (0): [<ffffffff800105d2>] copy_process+0x50c/0xdac
> [    0.222445] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.229551] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.119-00350-g224fd631c41b #1
> [    0.238330] Hardware name: Microchip PolarFire-SoC Icicle Kit (DT)
> [    0.245329] Call Trace:
> [    0.248113] [<ffffffff8000678c>] show_stack+0x2c/0x38
> [    0.253868] [<ffffffff80984e66>] dump_stack_lvl+0x5e/0x80
> [    0.260022] [<ffffffff80984e9c>] dump_stack+0x14/0x20
> [    0.265768] [<ffffffff800499b0>] __might_resched+0x200/0x20a
> [    0.272217] [<ffffffff80049784>] __might_sleep+0x3c/0x68
> [    0.278258] [<ffffffff802022aa>] __kmem_cache_alloc_node+0x64/0x240
> [    0.285385] [<ffffffff801b1760>] __kmalloc+0xc0/0x180
> [    0.291140] [<ffffffff8008c752>] cblist_init_generic+0x84/0x374
> [    0.297857] [<ffffffff80a0b212>] rcu_spawn_tasks_kthread+0x1c/0x72
> [    0.304888] [<ffffffff80a0b0e8>] rcu_init_tasks_generic+0x20/0x12e
> [    0.311902] [<ffffffff80a00eb8>] kernel_init_freeable+0x56/0xa8
> [    0.318638] [<ffffffff80985c10>] kernel_init+0x1a/0x18e
> [    0.324574] [<ffffffff80004124>] ret_from_exception+0x0/0x1a
>

Hello, Xiangyu

For v6.1.x kernels, the cblist_init_generic() is invoke in init task context,
rtp->rtpcp_array is allocated use GFP_KERENL and in the critical section
holding rcu_tasks.cbs_gbl_lock spinlock.  so might_resched() trigger warnings.
You should perform the operation of allocating rtpcp_array memory outside
the spinlock.
Are you willing to resend the patch?


Thanks
Zqiang


> Reverting it fixed the problem.
>
> Cheers,
> Conor.

