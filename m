Return-Path: <stable+bounces-108256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54632A0A1F3
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 09:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37737188E62A
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FB317B506;
	Sat, 11 Jan 2025 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/VjPBu6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0RLWQen"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E1155316;
	Sat, 11 Jan 2025 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736583053; cv=none; b=hZCeKdbEFz/y8Rh1nRZ2Cg9tudK3P/BZaeiAJLISDDCQnI5X4iI9Fgg2/ckp/JfOczsPnRWp7kS4DcL8NsK13klj63FnMxPxsMjZOOHvHvDG4nHZubuMq42PwEkCaboUUnwr6p8hOpTcjdJC6g1v7j+ME7N6YsRdIVGzne7+7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736583053; c=relaxed/simple;
	bh=IeQj/164SGrmH9lzgL8p5lsNgKqMm7GxQlCG6lh3BS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QynySB2FVOiIB/E9JD4qxcHokHoOpR3vOHu1jDJtTveEVihibyfAAQcLiXJLkhiyzcRTWwgp+3IXiWu+e+eAV1roe/InUigUJQmtMhaT2yuRRpOy6gP9mAVmf3fjHSYmfF53OnMrCFm+9gxArhKiqhCOYnxrkf4YrultjsD2T6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/VjPBu6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0RLWQen; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736583049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeQj/164SGrmH9lzgL8p5lsNgKqMm7GxQlCG6lh3BS4=;
	b=n/VjPBu6RVxY/jd7/8ahukh+XhN8jl0TOU60fQm0lvgPHNpL5UGHyPLCU4qiDpVuz/P/fM
	Baq+YHYooJezQqzqekMCLlKMDROe+sbMilyNnTxxRQaZT1GlIgmmFOssoQKMCxCgPeHpdu
	C2TRtQU+y06mrOz5qDqZFIakhhG8EK6oniyYfefyQ0Qj6ibsdOBPmw0o736XKaWL83RMUG
	MMwg4rR7lsDvJ6EI0tIRjarpIGlnEZct3TDYkfCnEKtNiJxJu0ae1kOpHaD5Bwb/ZlRo4x
	zX5UlKMToWVyF+B/iGJphUlhJm6CItkUEGU2CD4aRwBKTLDFYZYOU2fBcpdItA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736583049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IeQj/164SGrmH9lzgL8p5lsNgKqMm7GxQlCG6lh3BS4=;
	b=U0RLWQenj5Pis/8c/yvegsbHfJFijpGnoXgqcP3V+STKLFb6zDGjAw6m+UkuSPoY2qE5Qj
	/wyWXytrTVwfqOBA==
To: Sean Anderson <sean.anderson@linux.dev>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
 linux-serial@vger.kernel.org
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Michal
 Simek <michal.simek@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Sean
 Anderson <sean.anderson@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] tty: xilinx_uartps: split sysrq handling
In-Reply-To: <20250110213822.2107462-1-sean.anderson@linux.dev>
References: <20250110213822.2107462-1-sean.anderson@linux.dev>
Date: Sat, 11 Jan 2025 09:16:49 +0106
Message-ID: <841px9u5x2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-01-10, Sean Anderson <sean.anderson@linux.dev> wrote:
> Fix this by splitting sysrq handling into two parts. We use the prepare
> helper under the port lock and defer handling until we release the lock.

Note that this fix is only necessary because this console driver is
using the legacy console API. For the NBCON API it is allowed to call
printk() while holding the port lock.

But since code already exists to allow deferring the sysrq execution
until the port lock is not held, this patch is probably a good idea
anyway because it can reduce port lock contention. AFAIK there are no
sysrq actions that require port lock synchronization.

Acked-by: John Ogness <john.ogness@linutronix.de>

