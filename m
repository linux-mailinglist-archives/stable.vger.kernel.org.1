Return-Path: <stable+bounces-58188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5112929959
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 20:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F04C281337
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 18:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCF057C8E;
	Sun,  7 Jul 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BVLl0olF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pte65TeL"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D316F2E0;
	Sun,  7 Jul 2024 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720377575; cv=none; b=Mt1pzvEU+eJs4Rb82P8JTLV2u9c8CtChQPH/GioT/mi4ahkVsnpLlYjg+MIq0G3XL1P2ZOLY+u0UEuTEioejjFXUXZ0d6Afvwgk6AS0lvEc9+I9k/AVMt1bgchRNoDQ8h7lilRbH82RmqeS2bHSG5N8JZISKs04R7X01w1Cu3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720377575; c=relaxed/simple;
	bh=GvtyekW3cPtgMryxGojlHzw6d60XNdyQNpLAwvJFYCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Trq7ZcXszCduITEqKjbgV9hBNDd1WxL3tZZ3cm6eyV7rzmFWWBA/Nl3UHzL6fVkxUyCuWfzkU+X/36TMyoEl4E3dHlPD/XCrCqFKIhtsyMxGDBw8jLI9H/vX8M8w85V8gv10+G2h8xtahM3EvaUne74QR9aqOJw24UWBYraTkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BVLl0olF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pte65TeL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720377572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvnkGbIJ9LI7seSBE7vWaAv++oO2Ma6c/yEoKk5eGss=;
	b=BVLl0olFwyM4DlgzdlxxKXuIh6v3+fuPF3sY/qLCTy9CAxCDUWgUpi+nBgFdU7nmZbyQNK
	CBG8PeZPIpjXTB0+6zBhvxKlcb7EwLInlXnFT0kNqVEyxS1WMDvzo6yokryEw1mFwg68sE
	JRkN/jwzuMjMrhEscgaEnFvxAV3SFfDmEvJFApW7MfOxxxOfQHs990Ajqxmhj9tBoAJMDA
	GyzdtDbnBhp5MAiZZ/DpiWzi68dzxcykPu05pRfQHz5K5cyihJPmgipOCxrZ8Vdopo76ev
	8Bv53XUb7PN+niJiVxRhsFWP2KShEAYNG0hht5GIhseegbcbDiTyar0P1aWKWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720377572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HvnkGbIJ9LI7seSBE7vWaAv++oO2Ma6c/yEoKk5eGss=;
	b=Pte65TeL3YedPESL1FUXkQ2ZZMonCYOrSp1INe9vGmxtLtsqc0F9jeq520zTO9fGGdU5Iv
	9XnhsUJ3/HxDMQBg==
To: Pete Swain <swine@google.com>, linux-kernel@vger.kernel.org
Cc: Pete Swain <swine@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] FIXUP: genirq: defuse spurious-irq timebomb
In-Reply-To: <20240615044307.359980-1-swine@google.com>
References: <20240615044307.359980-1-swine@google.com>
Date: Sun, 07 Jul 2024 20:39:31 +0200
Message-ID: <87jzhxvyfw.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pete!

On Fri, Jun 14 2024 at 21:42, Pete Swain wrote:
> The flapping-irq detector still has a timebomb.
>
> A pathological workload, or test script,
> can arm the spurious-irq timebomb described in
>   4f27c00bf80f ("Improve behaviour of spurious IRQ detect")
>
> This leads to irqs being moved the much slower polled mode,
> despite the actual unhandled-irq rate being well under the
> 99.9k/100k threshold that the code appears to check.
>
> How?
>   - Queued completion handler, like nvme, servicing events
>     as they appear in the queue, even if the irq corresponding
>     to the event has not yet been seen.
>
>   - queues frequently empty, so seeing "spurious" irqs
>     whenever the last events of a threaded handler's
>       while (events_queued()) process_them();
>     ends with those events' irqs posted while thread was scanning.
>     In this case the while() has consumed last event(s),
>     so next handler says IRQ_NONE.
>
>   - In each run of "unhandled" irqs, exactly one IRQ_NONE response
>     is promoted from IRQ_NONE to IRQ_HANDLED, by note_interrupt()'s
>     SPURIOUS_DEFERRED logic.
>
>   - Any 2+ unhandled-irq runs will increment irqs_unhandled.
>     The time_after() check in note_interrupt() resets irqs_unhandled
>     to 1 after an idle period, but if irqs are never spaced more
>     than HZ/10 apart, irqs_unhandled keeps growing.
>
>   - During processing of long completion queues, the non-threaded
>     handlers will return IRQ_WAKE_THREAD, for potentially thousands
>     of per-event irqs. These bypass note_interrupt()'s irq_count++ logic,
>     so do not count as handled, and do not invoke the flapping-irq
>     logic.
>
>   - When the _counted_ irq_count reaches the 100k threshold,
>     it's possible for irqs_unhandled > 99.9k to force a move
>     to polling mode, even though many millions of _WAKE_THREAD
>     irqs have been handled without being counted.
>
> Solution: include IRQ_WAKE_THREAD events in irq_count.
> Only when IRQ_NONE responses outweigh (IRQ_HANDLED + IRQ_WAKE_THREAD)
> by the old 99:1 ratio will an irq be moved to polling mode.

Nice detective work. Though I'm not entirely sure whether that's the
correct approach as it might misjudge the situation where
IRQ_WAKE_THREAD is issued but the thread does not make progress at all.

Let me think about it some more.

Thanks,

        tglx

