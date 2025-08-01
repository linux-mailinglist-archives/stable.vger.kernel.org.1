Return-Path: <stable+bounces-165787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA8B189A9
	for <lists+stable@lfdr.de>; Sat,  2 Aug 2025 01:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53116622076
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 23:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5623C4E7;
	Fri,  1 Aug 2025 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euXxB757"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669852376FC
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 23:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092349; cv=none; b=lzbyW3HDy4iovoHEPjAWViSooQayfhJqP99TCN0zvDPj40vHfiq4gGbkn87HjB+aQcQDrb3rzt1/RByhY9ISv2q4ZMUWQnuWkVhL+dmx9I6wNoh8pI+zwjO5HPyXFKrbYDjWEqOK9r9FWLGbNeMzE1iuKEqPrYK11ga52WowWUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092349; c=relaxed/simple;
	bh=s9NmpPegCbHYz7FI1LwZFdpgkaCwgzBm+glcuL6J55c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CS8xZYCsqIEpvOwoFQ0x+YglynOs8m8KGnNqvWeSpI2BUUfbpBC4+AYQtUDx5PJpv7S8EYQsB8yRlI1H6e8wJa3/NnW/Zs2B5oBYvKTKcEj1azAekt0Z7OU/tf8zDHILxIzJrlfLt5sHp1XJThsepBp6e/tFuP3WKaHeQPh5P2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euXxB757; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAB2C4CEE7;
	Fri,  1 Aug 2025 23:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754092349;
	bh=s9NmpPegCbHYz7FI1LwZFdpgkaCwgzBm+glcuL6J55c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=euXxB757LCc3Gz0rChui3y8YBRmFXeu4DE9U9hoqjRAoThMBdFJOKE0KPoMUtwS1R
	 mgWS+MHLoTdPYCXxrM9yGzMjiBpDiOcwt7g1qn3aHgeEPt80JErqj9jWoe/MRv13iC
	 GLmDaz0uYVzoUG0bolBN4QsURWSw7a4EBhLL+xk0=
Date: Fri, 1 Aug 2025 16:52:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gu Bowen <gubowen5@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, <stable@vger.kernel.org>,
 <linux-mm@kvack.org>, Lu Jialin <lujialin4@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, <stable@vger.kernel.org>, <linux-mm@kvack.org>,
 Lu Jialin <lujialin4@huawei.com>, Waiman Long <longman@redhat.com>, Breno
 Leitao <leitao@debian.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] mm: Fix possible deadlock in console_trylock_spinning
Message-Id: <20250801165228.6c2a009c0fe439ddc438217e@linux-foundation.org>
In-Reply-To: <20250730094914.566582-1-gubowen5@huawei.com>
References: <20250730094914.566582-1-gubowen5@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 17:49:14 +0800 Gu Bowen <gubowen5@huawei.com> wrote:

> kmemleak_scan_thread() invokes scan_block() which may invoke a nomal
> printk() to print warning message. This can cause a deadlock in the
> scenario reported below:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(kmemleak_lock);
>                                lock(&port->lock);
>                                lock(kmemleak_lock);
>   lock(console_owner);
> 
> To solve this problem, switch to printk_safe mode before printing warning
> message, this will redirect all printk()-s to a special per-CPU buffer,
> which will be flushed later from a safe context (irq work), and this
> deadlock problem can be avoided.
> 
> Our syztester report the following lockdep error:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.10.0-22221-gca646a51dd00 #16 Not tainted
> ------------------------------------------------------
> 
> ...
>
> Chain exists of:
>   console_owner --> &port->lock --> kmemleak_lock
> 
> Cc: stable@vger.kernel.org # 5.10
> Signed-off-by: Gu Bowen <gubowen5@huawei.com>
> ---
>  mm/kmemleak.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 4801751cb6b6..d322897a1de1 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -390,9 +390,11 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
>  		else if (object->pointer == ptr || alias)
>  			return object;
>  		else {
> +			__printk_safe_enter();
>  			kmemleak_warn("Found object by alias at 0x%08lx\n",
>  				      ptr);
>  			dump_object_info(object);
> +			__printk_safe_exit();
>  			break;
>  		}
>  	}

umm,

--- a/mm/kmemleak.c~a
+++ a/mm/kmemleak.c
@@ -103,6 +103,8 @@
 #include <linux/kmemleak.h>
 #include <linux/memory_hotplug.h>
 
+#include "../kernel/printk/internal.h"		/* __printk_safe_enter */
+
 /*
  * Kmemleak configuration and common defines.
  */


I'm not sure we're allowed to do that.  Is there an official way?




