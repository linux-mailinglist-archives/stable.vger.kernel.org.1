Return-Path: <stable+bounces-71362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A1961CFB
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 05:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3A4D1F25D63
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 03:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDCB13D8B0;
	Wed, 28 Aug 2024 03:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy7scJ1J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B144C68;
	Wed, 28 Aug 2024 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815195; cv=none; b=l5WMH0JKPQfVsJl5xlT6MNrEUXrp6/4A60JbWAM4CaXhAiO2f8xNTIvhtw17PfpPBMqVlXStCgrUY06cPX4ioVejm+ny+HaTykHtxFpyDAFxSB3IFZTQL5kGI7xgNIdgqVYl7l6e34ZCpxLn9qqgFxhBKEp5w58nLjJ81f/cymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815195; c=relaxed/simple;
	bh=lvv1wuuCZlZuBufuO7kLv7qnu+Q78HrXbePoyAPS9wA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GZvPdeZXodW8ZVtQCg/yJfeir9c7n/vBppy0ti/RT0SG7KzDRowvcAgLEiDfVS5ZCCZ77ep7+vBXzv+3F7v0z+wpgAfbhn8xRpZWjQp9GM2Ii+87TeWqjzYs7UXY/WGnmjRCKnbLpoZvA+7SaEB7HVEbsg3agHps4hNARiqTBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cy7scJ1J; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71430e7eaf8so4992449b3a.1;
        Tue, 27 Aug 2024 20:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724815193; x=1725419993; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDm6/4kaYEwyIVMuVCKMTvyUYuOxVix/X+abE1xyWMc=;
        b=cy7scJ1JFeuU7rurXnqqXbQdBJXb4DNgjsZbQQDngOq8Nydottc55h3NVQNUXqrYOG
         uP118GqnsbvOEzYb/4XZSl6SVzTR9lwOoHyZrZX7oaama3yWTNe8so/RshPd1tcBgGdG
         0dscQzbvvH5S8eBHrxgLj+jcGA0km+i+x39K0XOJgkbeE+hp/h3sNNP/Q/h4BppvaPsl
         0mJTGeGS5zXQzd/iezoKOVRtWaJ45qXJD4Jqp3fAUsMSeDhUINq9B/2+ZT4UY9Qbafvf
         FQHWhXUvCHsEK5xA9a66pdObTA/vPyBW++5Y2YP+9bTThgcxOTiALlV9ERqYBVOiLttw
         y0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815193; x=1725419993;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDm6/4kaYEwyIVMuVCKMTvyUYuOxVix/X+abE1xyWMc=;
        b=eMQbfjMM0erSnAxld46N4cN0cWAIcC1OMBlAr4tqJ2MXuZrVZk9SxKgOGA2ufT3pcl
         NxcYZd77chshQ6JUXTBIAfGkHPR6agT+HhbD4HrmyGckyA/zZCx1mBy0RkxZGmN+Cdjr
         JrYI9PcYI8fxKLgkNo0C773SYy/QG1aLuYIdJjgIpcANF8TMqCnONLgASTFETefi+1IZ
         LWQiPtU4oo2r/ggxAGmZBID4FOk3h8Y32gNXFjB5kJ67QJT57mSROIQ8SMWiX7n2ODpc
         tuRqzgr0jroMl2KmeP1t4r5HrFDmYJ5eMnWd7ajmZPmXs+GuKiuExvI6ndww3BzaUU86
         GnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5GesO5cSEUnryHr4Ouv/Bg3i3a6ky6Ue6DFG6tRFPTndOrGOpO2iZVKK4g2cyxYsHrpnPYLccRtnY9zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnc7fQ6NnaXToFc6eHx4VkKF7bhKVaGUwdWHnMOhoYiH5IeqYj
	oaRKrt5f6lynJdkMTXz+YULZUPfo6wLoRAvrW5xAVx0b2PehC8pj
X-Google-Smtp-Source: AGHT+IH7U6Ym8EVJNn0TzIcpESz0eZ0goOZOElDkcUFly8uYuSzZ/P3XPGdhnJvtMWiChsyDbFgJ2g==
X-Received: by 2002:a05:6a21:4610:b0:1c3:ff33:277e with SMTP id adf61e73a8af0-1cc89e20eb2mr13633304637.32.1724815193127;
        Tue, 27 Aug 2024 20:19:53 -0700 (PDT)
Received: from localhost ([1.146.81.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446415efsm338934a91.47.2024.08.27.20.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 20:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Aug 2024 13:19:46 +1000
Message-Id: <D3R7YDW8U4QJ.1ZC4SPQN5SY1G@gmail.com>
Subject: Re: [PATCH] powerpc/qspinlock: Fix deadlock in MCS queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nysal Jan K.A." <nysal@linux.ibm.com>, "Michael Ellerman"
 <mpe@ellerman.id.au>
Cc: <stable@vger.kernel.org>, "Geetika Moolchandani"
 <geetika@linux.ibm.com>, "Vaishnavi Bhat" <vaish123@in.ibm.com>, "Jijo
 Varghese" <vargjijo@in.ibm.com>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Naveen N Rao" <naveen@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240826081251.744325-1-nysal@linux.ibm.com>
In-Reply-To: <20240826081251.744325-1-nysal@linux.ibm.com>

Hey Nysal,

This is really good debugging, and a nice write up.

On Mon Aug 26, 2024 at 6:12 PM AEST, Nysal Jan K.A. wrote:
> If an interrupt occurs in queued_spin_lock_slowpath() after we increment
> qnodesp->count and before node->lock is initialized, another CPU might
> see stale lock values in get_tail_qnode(). If the stale lock value happen=
s
> to match the lock on that CPU, then we write to the "next" pointer of
> the wrong qnode. This causes a deadlock as the former CPU, once it become=
s
> the head of the MCS queue, will spin indefinitely until it's "next" point=
er
> is set by its successor in the queue. This results in lockups similar to
> the following.
>
>    watchdog: CPU 15 Hard LOCKUP
>    ......
>    NIP [c0000000000b78f4] queued_spin_lock_slowpath+0x1184/0x1490
>    LR [c000000001037c5c] _raw_spin_lock+0x6c/0x90
>    Call Trace:
>     0xc000002cfffa3bf0 (unreliable)
>     _raw_spin_lock+0x6c/0x90
>     raw_spin_rq_lock_nested.part.135+0x4c/0xd0
>     sched_ttwu_pending+0x60/0x1f0
>     __flush_smp_call_function_queue+0x1dc/0x670
>     smp_ipi_demux_relaxed+0xa4/0x100
>     xive_muxed_ipi_action+0x20/0x40
>     __handle_irq_event_percpu+0x80/0x240
>     handle_irq_event_percpu+0x2c/0x80
>     handle_percpu_irq+0x84/0xd0
>     generic_handle_irq+0x54/0x80
>     __do_irq+0xac/0x210
>     __do_IRQ+0x74/0xd0
>     0x0
>     do_IRQ+0x8c/0x170
>     hardware_interrupt_common_virt+0x29c/0x2a0
>    --- interrupt: 500 at queued_spin_lock_slowpath+0x4b8/0x1490
>    ......
>    NIP [c0000000000b6c28] queued_spin_lock_slowpath+0x4b8/0x1490
>    LR [c000000001037c5c] _raw_spin_lock+0x6c/0x90
>    --- interrupt: 500
>     0xc0000029c1a41d00 (unreliable)
>     _raw_spin_lock+0x6c/0x90
>     futex_wake+0x100/0x260
>     do_futex+0x21c/0x2a0
>     sys_futex+0x98/0x270
>     system_call_exception+0x14c/0x2f0
>     system_call_vectored_common+0x15c/0x2ec
>
> The following code flow illustrates how the deadlock occurs:
>
>         CPU0                                   CPU1
>         ----                                   ----
>   spin_lock_irqsave(A)                          |
>   spin_unlock_irqrestore(A)                     |
>     spin_lock(B)                                |
>          |                                      |
>          =E2=96=BC                                      |
>    id =3D qnodesp->count++;                       |
>   (Note that nodes[0].lock =3D=3D A)                |
>          |                                      |
>          =E2=96=BC                                      |
>       Interrupt                                 |
>   (happens before "nodes[0].lock =3D B")          |
>          |                                      |
>          =E2=96=BC                                      |
>   spin_lock_irqsave(A)                          |
>          |                                      |
>          =E2=96=BC                                      |
>    id =3D qnodesp->count++                        |
>    nodes[1].lock =3D A                            |
>          |                                      |
>          =E2=96=BC                                      |
>   Tail of MCS queue                             |
>          |                             spin_lock_irqsave(A)
>          =E2=96=BC                                      |
>   Head of MCS queue                             =E2=96=BC
>          |                             CPU0 is previous tail
>          =E2=96=BC                                      |
>    Spin indefinitely                            =E2=96=BC
>   (until "nodes[1].next !=3D NULL")      prev =3D get_tail_qnode(A, CPU0)
>                                                 |
>                                                 =E2=96=BC
>                                        prev =3D=3D &qnodes[CPU0].nodes[0]
>                                      (as qnodes[CPU0].nodes[0].lock =3D=
=3D A)
>                                                 |
>                                                 =E2=96=BC
>                                        WRITE_ONCE(prev->next, node)
>                                                 |
>                                                 =E2=96=BC
>                                         Spin indefinitely
>                                      (until nodes[0].locked =3D=3D 1)

I can follow your scenario, and agree it is a bug.

Generic qspinlock code does not have a similar path because it encodes
idx with the CPU in the spinlock word. The powerpc qspinlocks removed
that to save some bits in the word (to support more CPUs).

What probably makes it really difficult to hit is that I think both
locks A and B need contention from other sources to push them into
queueing slow path. I guess that's omitted for brevity in the flow
above, which is fine.

> Thanks to Saket Kumar Bhaskar for help with recreating the issue
>
> Fixes: 84990b169557 ("powerpc/qspinlock: add mcs queueing for contended w=
aiters")
> Cc: stable@vger.kernel.org # v6.2+
> Reported-by: Geetika Moolchandani <geetika@linux.ibm.com>
> Reported-by: Vaishnavi Bhat <vaish123@in.ibm.com>
> Reported-by: Jijo Varghese <vargjijo@in.ibm.com>
> Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
> ---
>  arch/powerpc/lib/qspinlock.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/lib/qspinlock.c b/arch/powerpc/lib/qspinlock.c
> index 5de4dd549f6e..59861c665cef 100644
> --- a/arch/powerpc/lib/qspinlock.c
> +++ b/arch/powerpc/lib/qspinlock.c
> @@ -697,6 +697,12 @@ static __always_inline void queued_spin_lock_mcs_que=
ue(struct qspinlock *lock, b
>  	}
> =20
>  release:
> +	/*
> +	 * Clear the lock, as another CPU might see stale values if an
> +	 * interrupt occurs after we increment qnodesp->count but before
> +	 * node->lock is initialized
> +	 */
> +	node->lock =3D NULL;
>  	qnodesp->count--; /* release the node */

AFAIKS this fix works.

There is one complication which is those two stores could be swapped by
the compiler. So we could take an IRQ here that sees the node has been
freed, but node->lock has not yet been cleared. Basically equivalent to
the problem solved by the barrier() on the count++ side.

This reordering would not cause a problem in your scenario AFAIKS
because when the lock call returns, node->lock *will* be cleared so it
can not cause a problem later.

Still, should we put a barrier() between these just to make things a
bit cleaner? I.e., when count is decremented, we definitely won't do
any other stores to node. Otherwise,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

