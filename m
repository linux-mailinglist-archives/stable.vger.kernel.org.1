Return-Path: <stable+bounces-219923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJz2CthDoWkirwQAu9opvQ
	(envelope-from <stable+bounces-219923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:12:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A11B3AB5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5000C30733AC
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFBA35FF50;
	Fri, 27 Feb 2026 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AABwEHOr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nmlu/Pub"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01397334C14
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176340; cv=none; b=nqHw5XVb1PU3oZpoVQd1RNsbMNidoaDMiZ6vu0WKnflewIGUJ+al8bblii+03xsN9aPhBd0rUXoaKBjntM15qkaNBi1HpIcP9Yl2O2k7TcL4YXSgP18uBTwisPaRSsCk8EPEa6FRDme8LWMYgMwhZiStOR2Jyu+JUn1NQjYp/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176340; c=relaxed/simple;
	bh=TEgX++/V9rBlVxSck+4dcySTD/oPMgXeFBHbFJ4LG9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSZl65FL4Quf88ieWO07O3fDv5ncdXq32r8B/UF1oS4wWysUeO+rpHq0k8V6e6wT9TVKQx+uXbRfYX78g2yF79lzDbOyrKC+6JJ2+Ik4oCnwtnILAB+lN2OT4AAfJiedSxgCptrEul5dclKvLW+J8RAlMXdvS/OOlnw/3zZntec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AABwEHOr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nmlu/Pub; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 27 Feb 2026 08:12:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772176337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8JDlWG5fAmG61ZYpuuMFjxAnNICkKJM5E1jtk+dNO1c=;
	b=AABwEHOr4C6BFPBay/nkl074GZCsy1THrytYtr9Rm8CF7uiencbxwV4ah8DsfriGsJXSnA
	FS/ux1kIXb1yETf3yeP/GZQmEK7dXh31NQL5quTFSgV5x7EH+MafXUTXqQ33q1ZWCTA78v
	9A9ovKcSOahnjryS3rGPRZJSHLznBQksXdJIsA1k+ck3pSvaRZNbHCEikueQMn918frkf4
	f3kB9QV7yZdWk7uyxDF6D989fugswIEqa9fX2Lei+spFxUTF6fteLmtLs4EyuOkBsnmYcn
	0MgV76ioEtiouOI5VF42JM7OnVvOTijIIesAkPNRewXUCEWCxEct0mnh4IsnAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772176337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8JDlWG5fAmG61ZYpuuMFjxAnNICkKJM5E1jtk+dNO1c=;
	b=nmlu/PubCUzbYVxodCFBU8pUO1JuiP1Iaz339fCACBI87+u/l8y0OmyUBeAtiDxWYmViFX
	yPaKGf4y1Y52ueDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org, pshete@nvidia.com
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Patch "soc/tegra: pmc: Fix unsafe generic_handle_irq() call" has
 been added to the 6.19-stable tree
Message-ID: <20260227071216.6dYMGnMj@linutronix.de>
References: <20260227025419.2745361-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227025419.2745361-1-sashal@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219923-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,goodmis.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A96A11B3AB5
X-Rspamd-Action: no action

On 2026-02-26 21:54:18 [-0500], Sasha Levin wrote:
> Author: Prathamesh Shete <pshete@nvidia.com>
> Date:   Thu Jan 8 05:01:03 2026 +0000
> 
>     soc/tegra: pmc: Fix unsafe generic_handle_irq() call
>     
>     [ Upstream commit e6d96073af681780820c94079b978474a8a44413 ]
>     
>     Currently, when resuming from system suspend on Tegra platforms,
>     the following warning is observed:
>     
>     WARNING: CPU: 0 PID: 14459 at kernel/irq/irqdesc.c:666
>     Call trace:
>      handle_irq_desc+0x20/0x58 (P)
>      tegra186_pmc_wake_syscore_resume+0xe4/0x15c
>      syscore_resume+0x3c/0xb8
>      suspend_devices_and_enter+0x510/0x540
>      pm_suspend+0x16c/0x1d8
>     
>     The warning occurs because generic_handle_irq() is being called from
>     a non-interrupt context which is considered as unsafe.
>     
>     Fix this warning by deferring generic_handle_irq() call to an IRQ work
>     which gets executed in hard IRQ context where generic_handle_irq()
>     can be called safely.
>     
>     When PREEMPT_RT kernels are used, regular IRQ work (initialized with
>     init_irq_work) is deferred to run in per-CPU kthreads in preemptible
>     context rather than hard IRQ context. Hence, use the IRQ_WORK_INIT_HARD
>     variant so that with PREEMPT_RT kernels, the IRQ work is processed in
>     hardirq context instead of being deferred to a thread which is required
>     for calling generic_handle_irq().
>     
>     On non-PREEMPT_RT kernels, both init_irq_work() and IRQ_WORK_INIT_HARD()
>     execute in IRQ context, so this change has no functional impact for
>     standard kernel configurations.

sorry for not noticing this earlier: Instead of irq_work() and all this,
I would suggest to revert this and simply switch to
generic_handle_irq_safe() instead.

Sebastian

