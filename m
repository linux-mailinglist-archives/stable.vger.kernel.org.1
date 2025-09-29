Return-Path: <stable+bounces-181918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0A4BA979F
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 16:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3195418840BF
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 14:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B0305047;
	Mon, 29 Sep 2025 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wzXOP37T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WBQ0BWA"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0F3A8F7
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154830; cv=none; b=koRo4YnxebuZ2exdxx6L3EezvK5yLtUwB2mAHl5swNuWZ41HpdIDPmCStG1WK/VODJZhfjx/XB5EXMKjwyRiV8RA7kax07dLZ/4iClaR3lA1BQ/xd6Cjxvg2MqQpNC+xRomtIXqnsMfseXDI2PNnsF1Qb7O/kUp8BkcQgSl7efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154830; c=relaxed/simple;
	bh=k09H819Yz08WdwIvqL3f4Ih6SrQVnt0AgnB8iTi+zTQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=twqr8I8oJTg5Byj7WgmPFPWGVj+cmjuHCrQHH/LT6VhwN6FqH7dWmrn3SK78uvcKpVSwcgHNx7CEXoE9njx0xdJ641HjmrymCdZzinJp8ZrpErV9MCf4OklbsnsQUBM0HPBQKY+yNxG2RprWavNVX9yHV9R9GIb9mek/qT93ytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wzXOP37T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WBQ0BWA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759154826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/ZQBksK/vNkdoVwSxAFBvpe4YW8mrnRjmUNwte1ccs=;
	b=wzXOP37Tb5Od5TiIWOn+tDZoxR122ufvbygx6LtGdEaJWqEZVkk0NXibrblSVfpMaUH2rv
	IYGgH11IrwFvWzq9iDiOPlLIY1mCSkEUIX+m880OZr5nbXryBpmFurf+NC3DgV8eiaeOCa
	S5610KUDr6XPj2/hhuC6J6zGdHqr19MGqDiQ6PLOnk+/vCbpWquInhdB2CquwbVXCQ6Lns
	eBUgaG6inZzqRg7Uy1dmirV2EK55cKGsQnApt4U/YzFqYYLLYA5yVkAeOU1teQioKjuLrb
	LAsuR7cjcJqpVaO/3yiIBWG5skjSicjiEqWqrWvJ6Y5jfd4wh6WWyKJmGlElDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759154826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/ZQBksK/vNkdoVwSxAFBvpe4YW8mrnRjmUNwte1ccs=;
	b=0WBQ0BWAPvC/enmx3D+7szZZztUPRedP3Lbhfx/v3Qap1uQrtorI4F/cIVkmkQPDR9/0VI
	LeN9lSaSuhm70bCw==
To: Breno Leitao <leitao@debian.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Gu Bowen <gubowen5@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Waiman Long <llong@redhat.com>,
 stable@vger.kernel.org, linux-mm@kvack.org, Lu Jialin
 <lujialin4@huawei.com>
Subject: Re: [PATCH v5] mm: Fix possible deadlock in kmemleak
In-Reply-To: <kuq7guzalpqj5bxe2vt6s3kirrq4sg5ozwcim6ewnzpxhuxm4l@yfgb44nbcisz>
References: <20250822073541.1886469-1-gubowen5@huawei.com>
 <5ohuscufoavyezhy6n5blotk4hovyd2e23pfqylrfwhpu45nby@jxwe6jmkwdzb>
 <aNVSsmY86yi-cV_e@arm.com>
 <kuq7guzalpqj5bxe2vt6s3kirrq4sg5ozwcim6ewnzpxhuxm4l@yfgb44nbcisz>
Date: Mon, 29 Sep 2025 16:13:06 +0206
Message-ID: <84ikh1l5dh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-26, Breno Leitao <leitao@debian.org> wrote:
> My concern is when printk() is called with kmemleak_lock held(). Something as:
>
> raw_spin_lock_irqsave(&kmemleak_lock, flags);
>    -> printk()
>
> This is instant deadlock when netconsole is enabled. Given that
> netconsole tries to allocate memory when flushing. Similarly to commit
> 47b0f6d8f0d2be ("mm/kmemleak: avoid deadlock by moving pr_warn()
> outside kmemleak_lock").

Yes, it is a known problem that a caller must not hold any locks that
are used during console printing. Locking the serial port lock
(uart_port->lock) and calling printk() also leads to deadlock if that
port is registered as a serial console.

This is properly fixed by converting to the new nbcon console API, which
netconsole is currently working on. But until then something like Breno
is suggesting will provide a functional workaround.

Note that printk_deferred_enter/exit() require migration to be
disabled. If kmemleak_lock() is not always being called in such a
context, it cannot enable deferring.

One option is to enable deferring after taking the lock:

	void kmemleak_lock(unsigned long *flags) {
		raw_spin_lock_irqsave(&kmemleak_lock, flags);
		printk_deferred_enter();
	}

printk() always defers in NMI context, so there is no risk if an NMI
jumped in between locking and deferring and then called printk().

> The hack above would guarantee that  all printks() inside kmemleak_lock
> critical area to be deferred, and not executed inline.

Yes, although I think netconsole is the only console that tries to
allocate memory. So if this hack is used, it should at least be wrapped
by an ifdef CONFIG_NETCONSOLE.

Although it would be preferable if netconsole did not need to allocate
memory for flushing.

John Ogness

