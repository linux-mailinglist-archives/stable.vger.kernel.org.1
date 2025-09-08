Return-Path: <stable+bounces-178827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17D1B48218
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 03:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F40617C590
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 01:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC2A38F80;
	Mon,  8 Sep 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBU9hbky"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A5182D0;
	Mon,  8 Sep 2025 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757295034; cv=none; b=AFSd6NX21dyMu0WaJkNyU1XQsSCtYrJV76+viDGQprF3rUCn5YfScZHNWd95xnxOxSs/cSFbIuEho6xdYA0mKauaVQyUc3g9jQqdbhpZ42UVNKTrMFKnq4wEoDWwdVi4DxIQGpxdXlisyPSlUWX74mH3ET5N3XfsK34vfQVfA5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757295034; c=relaxed/simple;
	bh=+r+VDS1uRI6+rE2CCW4N+M/6eOfpP9xIfWnkMDLE6aE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F55uD8T0470y+iDuqpmveYMI9wEmcwC1Ee/oa5vSZo6gquDOWlzIiQydVL+CJtOk9vd/ziI/z2lUIV+IF1uq9TQHKEi1ewMKkRA8S+4qQMZvgtTUuIh4SJcbu/yBd+CTiTygdVYzo0fV9EPtPHUcXAZobrroUInAd59TkmGpEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBU9hbky; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE0727A008A;
	Sun,  7 Sep 2025 21:30:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Sun, 07 Sep 2025 21:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757295029; x=1757381429; bh=wEBs3WfXN4PxE82/tOwGaATws6G1sN9QWLb
	NmZPFQV8=; b=FBU9hbkyX3+X4e3Pb/hlVpAuk4ZRetL7iHuESomBbB98g29OQ/t
	pLkGOsO7d6ziFgJy0iIFMMn/JFryhAZgnvAeQ8JBM6NFEUxw5C/OKKOz/ph2xSOl
	RWJrLaIpdIUj3XN42K6tiuSPvf1eTvsa7tMVoQ+7PJrIFkQINLvkx3SZTqcQ5+x3
	Gm+BQYVa9LgTjPrZXiXi9rOJ0NZwnaScmHtUcYFryCaqwCD+MsyR9Mj22fM+5nl1
	HP3xDXsbH3Pmqem4pLUFc2BSctssLh7D2brA4X/FQTqLhxd5HKWYqAxDMcP059sN
	N+TG0Xlqb91M5uotzN2bLQL+Y34Q2tX11MQ==
X-ME-Sender: <xms:tDG-aFE_4oW0lX0h87hJtr-zccoBWrCN2CBe7b78jhiK9ywa52PyGA>
    <xme:tDG-aE_rY2TpniiTpazLxzaqUt1MDU-RhE7midlS8FNnI-eYM71X9WAhce7jmed-5
    bMY8N2O_DCsCEAEiE8>
X-ME-Received: <xmr:tDG-aNLgaQQ4HENELyuymr85Oy1wQYIfMKBhT2RKXgHJqieu9KnmK1qQ1KtehsfFuKOme5qPteEDVzCwFhAX67T_eni7kpFtXp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfvhhgr
    ihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueevvdegledvveehvddvkeeffefgvdeiieejvdejveffhefguefhheeftdetuddt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdho
    rhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhgrnhgtvgdrhigrnh
    hgsehlihhnuhigrdguvghvpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehk
    rdhorhhgpdhrtghpthhtohepmhhhihhrrghmrghtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehorghksehhvghlshhinhhkihhnvghtrdhfihdprhgtphhtthhopeifihhllhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:tDG-aKthsCfnDqQkhsJo95bIXhJ1pn43bVadk-Udy1xoI4YUb6SsXg>
    <xmx:tDG-aMAeSSkOqFAm48bE-mPzwJAVn0yu70AVTmSrsZRRfhRZDqH5aQ>
    <xmx:tDG-aKPQaJLJotfxngvkSMv36hkAx9O5DYfgkADrj48oiMQ8XwIpww>
    <xmx:tDG-aMBIzGKCmiCHQz8Qhv32SVozQm0icvQL_m0mK0JbQ0v59Se0Mw>
    <xmx:tTG-aPuKUGDnhmaE9za8Q51aausTMrzTtzEB9yJ91sAcbcNbyh1psDSi>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:30:25 -0400 (EDT)
Date: Mon, 8 Sep 2025 11:30:29 +1000 (AEST)
From: Finn Thain <fthain@linux-m68k.org>
To: Peter Zijlstra <peterz@infradead.org>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Lance Yang <lance.yang@linux.dev>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, Eero Tamminen <oak@helsinkinet.fi>, 
    Will Deacon <will@kernel.org>, stable@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atomic: Specify natural alignment for atomic_t
In-Reply-To: <20250901094032.GL4068168@noisy.programming.kicks-ass.net>
Message-ID: <ed1e0896-fd85-5101-e136-e4a5a37ca5ff@linux-m68k.org>
References: <7d9554bfe2412ed9427bf71ce38a376e06eb9ec4.1756087385.git.fthain@linux-m68k.org> <20250825071247.GO3245006@noisy.programming.kicks-ass.net> <58dac4d0-2811-182a-e2c1-4edfe4759759@linux-m68k.org> <20250825114136.GX3245006@noisy.programming.kicks-ass.net>
 <9453560f-2240-ab6f-84f1-0bb99d118998@linux-m68k.org> <20250827115447.GR3289052@noisy.programming.kicks-ass.net> <10b5aaae-5947-53a9-88bb-802daafd83d4@linux-m68k.org> <20250901093600.GF4067720@noisy.programming.kicks-ass.net>
 <20250901094032.GL4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii


On Mon, 1 Sep 2025, Peter Zijlstra wrote:

> On Mon, Sep 01, 2025 at 11:36:00AM +0200, Peter Zijlstra wrote:
> 
> > Something like the completely untested below should do I suppose.
> > 
> > ---
> > diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
> > index 711a1f0d1a73..e39cdfe5a59e 100644
> > --- a/include/linux/instrumented.h
> > +++ b/include/linux/instrumented.h
> > @@ -67,6 +67,7 @@ static __always_inline void instrument_atomic_read(const volatile void *v, size_
> >  {
> >  	kasan_check_read(v, size);
> >  	kcsan_check_atomic_read(v, size);
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
> >  }
> >  
> >  /**
> > @@ -81,6 +82,7 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
> >  {
> >  	kasan_check_write(v, size);
> >  	kcsan_check_atomic_write(v, size);
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
> >  }
> >  
> >  /**
> > @@ -95,6 +97,7 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
> >  {
> >  	kasan_check_write(v, size);
> >  	kcsan_check_atomic_read_write(v, size);
> > +	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ATOMIC) && ((unsigned long)v & 3));
> >  }
> >  
> >  /**
> 
> Arguably, that should've been something like:
> 
> 	((unsigned long)v & (size-1))
> 
> I suppose.
> 

I've been testing this patch and these new WARN_ON splats have revealed 
some issues.

To start with, I overlooked atomic64_t in my patch. But aligning that 
isn't sufficient in some cases: we have kmem caches of structs containing 
atomic64_t members, where kmem_cache_create() is used with a default 
alignment of 4, for example, the struct inode cache in fs/proc/inode.c. So 
I changed the above CONFIG_DEBUG_ATOMIC test to
(unsigned long)v & (sizeof(long) - 1).

Another issue I encountered was atomic operations used on non-atomic 
types. The try_cmpxchg() in task_work_add() triggers the 
CONFIG_DEBUG_ATOMIC misalignment WARN because of the 850 byte offset of 
task_works into struct task_struct. I got around this by adding 
__aligned(sizeof(long)) to task_works, but maybe 
__aligned(sizeof(atomic_t)) would be better (?)

Another example of this problem (i.e. atomic operation used with 
non-atomic type) appears in wait_task_zombie() in kernel/exit.c, where 
cmpxchg() is used on exit_state, found at offset 418 in struct 
task_struct. I prevented this by adding __aligned(sizeof(long)) to 
exit_state. I'm not sure what the right patch is.

A different problem shows up in spi_setup_transport_attrs() where 
spi_dv_mutex() is used to coerce starget_data into struct 
spi_transport_attrs, which happens to contain some atomic storage. 
starget_data is found at the end of the dynamically allocated struct 
scsi_target (not an uncommon pattern). So starget_data ends up at offset 
290, and struct spi_transport_attrs is also misaligned, as is dv_mutex. To 
get around this, I changed the definition of struct scsi_target:

--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -370,7 +370,7 @@ struct scsi_target {
        char                    scsi_level;
        enum scsi_target_state  state;
        void                    *hostdata; /* available to low-level driver */
-       unsigned long           starget_data[]; /* for the transport */
+       atomic64_t              starget_data[]; /* for the transport */
        /* starget_data must be the last element!!!! */
 } __attribute__((aligned(sizeof(unsigned long))));

This patch works because starget_data is never accessed except where it is 
being cast as some other type. But there's probably a reason for the 
'long' here that I don't know about... maybe I should use atomic_long_t 
or atomic_t.

I found a few structures in the VFS layer with a misaligned lock, which I 
patched my way around. There's still a WARN splat from down_write() for 
semaphores somewhere in the VFS and TTY layers, but I was unable to track 
down the relevant memory allocations:

[   59.500000] ------------[ cut here ]------------
[   59.500000] WARNING: CPU: 0 PID: 329 at ./include/linux/instrumented.h:101 rwsem_down_write_slowpath+0x26a/0x4ca
[   59.500000] Modules linked in:
[   59.500000] CPU: 0 UID: 0 PID: 329 Comm: (udev-worker) Not tainted 6.16.0-multi-00009-g2b4218de16c4 #1 NONE 
[   59.500000] Stack from 01e4be64:
[   59.500000]         01e4be64 005b83e3 005b83e3 005aa650 00000065 00000009 01e4be88 00007398
[   59.500000]         005b83e3 01e4be98 000353a0 005aa41f 01e3024c 01e4bed0 00002594 005aa650
[   59.500000]         00000065 00507f2a 00000009 00000000 00000000 00000000 00000002 00000002
[   59.500000]         00000000 00000000 01e3024c 01e4bf40 00507f2a 005aa650 00000065 00000009
[   59.500000]         00000000 00000000 00000000 00141ef8 0013e360 fffffffe 0aba9500 01e3024c
[   59.500000]         01e4bfa0 00f981b0 00000001 01e4bf2a 01e30254 01e4bf2a 00070000 00020000
[   59.500000] Call Trace: [<00007398>] dump_stack+0x10/0x16
[   59.500000]  [<000353a0>] __warn+0xd0/0xf8
[   59.500000]  [<00002594>] warn_slowpath_fmt+0x54/0x62
[   59.500000]  [<00507f2a>] rwsem_down_write_slowpath+0x26a/0x4ca
[   59.500000]  [<00507f2a>] rwsem_down_write_slowpath+0x26a/0x4ca
[   59.500000]  [<00141ef8>] iput+0x0/0x1fe
[   59.500000]  [<0013e360>] dput+0x0/0x160
[   59.500000]  [<00070000>] defer_console_output+0x28/0x34
[   59.500000]  [<00020000>] _FP_CALL_TOP+0x25c2/0xd512
[   59.500000]  [<000101e4>] ikbd_mouse_y0_bot+0x4/0x1c
[   59.500000]  [<0000ffff>] atari_keyb_init+0xf7/0x17a
[   59.500000]  [<005081c2>] down_write+0x38/0xf6
[   59.500000]  [<0013733a>] do_unlinkat+0xc8/0x264
[   59.500000]  [<0013755e>] sys_unlink+0x1c/0x20
[   59.500000]  [<0000876a>] syscall+0x8/0xc
[   59.500000]  [<0000c048>] die_if_kernel.part.0+0x2c/0x40
[   59.500000] 
[   59.500000] ---[ end trace 0000000000000000 ]---

All of my testing was done on m68k. It would be interesting to try this on 
some other 32-bit architecture that tolerates misaligned accesses. More 
misaligned 64-bit atomics would be unsurprising.

The patches for these experiments may be found at, 
https://github.com/fthain/linux/tree/atomic_t

