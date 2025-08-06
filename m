Return-Path: <stable+bounces-166712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F091B1C8D2
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 17:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2289D4E35DA
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D434292B53;
	Wed,  6 Aug 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f5UiBCN4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gz7U0UH3"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DAB2951D0
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494498; cv=none; b=fb10CKpty9AyCQbJxfhd5+5n7sJ/0JsUQkJsbpu2sIkifYck0WgqiyVIfomAEOk+G46N/EF176fisBwmr0C+KT2T+ex+NKW4pZqWp1ltMZZI/fSJDAWAASiAMO5t1STomLToBrjRwhvxpL5Jj/n2Ghu7mIiKGmvsLKj93EKtEyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494498; c=relaxed/simple;
	bh=e5bqL+C1lB2gxjk4VidGTrYArtRzrLSSNZ3AMQRXl8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+72i3dp63i/jL+ImS/5Ui4+A/mTIBdx7WwAv0Ky6d7wRgR1GIhajXXFpMmxi6BKIXejRuxq5eN6I/sjZ0grakFlW+SxKogY9Rk/Lk3FnbAKOhr3xujbm/rmwCMq/mg3BKsKiAMe0PuJXD2Jq+IUpZNytk/OP0ik3sjxBP95tT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f5UiBCN4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gz7U0UH3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754494494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IGF3vGHoaV5az/qlqBIi9OrCnbX/sgelHE61GcLMXw=;
	b=f5UiBCN4kJ1HFb25h6Vx7h06v5L5ZvrJzxTpOLbwmhrNc1MaPso/s6ShfglUvmMxI6TwN0
	SW5LtbRIajAIeYh91s5H8GzyaxSk370RnKmxER8I7lxJB1Loq1N+t0dZjqXKzDf/m9sH0M
	GI2C8cc0V//XB+6BVOZ6oH3qfOJTte+z83pGI4N4SrwfUR9luIns9x2D6A4YC1Z1nmw4DN
	MSgQKzsofh/u51W427BMan5xO0hRuGZNy5ZJMIVorybIWZFgEDK+6+4nB01mu9I5O2LBQq
	pJjGuMHOG3cATRWPzhAj5ezzyUYkC9O1QB80VXAWCO/6VOoJmgT3M4V4NOx2yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754494494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IGF3vGHoaV5az/qlqBIi9OrCnbX/sgelHE61GcLMXw=;
	b=gz7U0UH3TfuIQPgHoA1kb6pQvMSO5JbdTOEPwixJDow34ugYEJ3hxx8YvpBtdboIdvFU7h
	s0JaK3Ju7uvlS8CQ==
To: Waiman Long <llong@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Gu Bowen <gubowen5@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-mm@kvack.org, Lu Jialin <lujialin4@huawei.com>, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
In-Reply-To: <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
References: <20250730094914.566582-1-gubowen5@huawei.com>
 <20250801153303.cee42dcfc94c63fb5026bba0@linux-foundation.org>
 <5ca375cd-4a20-4807-b897-68b289626550@redhat.com>
Date: Wed, 06 Aug 2025 17:40:53 +0206
Message-ID: <84h5yko44i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-08-01, Waiman Long <llong@redhat.com> wrote:
>>> kmemleak_scan_thread() invokes scan_block() which may invoke a nomal
>>> printk() to print warning message. This can cause a deadlock in the
>>> scenario reported below:
>>>
>>>         CPU0                    CPU1
>>>         ----                    ----
>>>    lock(kmemleak_lock);
>>>                                 lock(&port->lock);
>>>                                 lock(kmemleak_lock);
>>>    lock(console_owner);
>>>
>>> To solve this problem, switch to printk_safe mode before printing warning
>>> message, this will redirect all printk()-s to a special per-CPU buffer,
>>> which will be flushed later from a safe context (irq work), and this
>>> deadlock problem can be avoided.

printk no longer works like this. There are no special per-CPU
buffers. As correctly pointed out by Longman, the proper interface is
printk_deferred_enter()/printk_deferred_exit().

With the deferred interface, the printk message is still immediately
stored in the printk ringbuffer (which is lockless) and only the console
printing itself is deferred.

John Ogness

