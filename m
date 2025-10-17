Return-Path: <stable+bounces-187712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E2BEBEB2
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6B21AA7172
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1252D661E;
	Fri, 17 Oct 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O1NEeKcH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D972223710;
	Fri, 17 Oct 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739943; cv=none; b=RVujIWTiPgXoVPJAK/o5Vted4JAQ6k6YoI2c0Q2/Xj3cIjjF8TMTKTbIvfU3Y9fNAbRUSbtu+CN3ZZRRftjQgKveB6vSa3JSYpcnbHsLwzW74IRBB3ZMRH3jW7CNjmN7qwuqDospcC+GrCNqFA+oK3I4C5G6IbhgofdQ2mayHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739943; c=relaxed/simple;
	bh=k4Sg/hQ/2BWpUMz53dR91PC5f7JnvT42mqbpOY9GPAI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M1Z7DTs2txL6Um7mSFSEmatSsbnIK6WZ/fzvB5xf+C/J+1/+WY4VEwutiZrjFueh8XqUrizOxaVwLXqLllChgN8x8CidU7BZqL7ciRjOzqP4Ry9DdsWuMHqMDT8gQEJx1MIzg1PChfKlHyYLSolaK8IS6B5ZShwdapwnXh65Kus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O1NEeKcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1324C4CEE7;
	Fri, 17 Oct 2025 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760739942;
	bh=k4Sg/hQ/2BWpUMz53dR91PC5f7JnvT42mqbpOY9GPAI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O1NEeKcH2gjSj4QFAo9ajlC82L5xanfcfyNbFqoPWykwK6w2OEB7c5YCxanyS35+F
	 AGscfqihu1tJ08Hqo5+rImBk/cjzQZAfJ79kc05DZ3PfFKgrHkmtn4Z9m658hK81rP
	 JkEjDEFgUE4j0eQdb5RMhmz+VSg/twDMGykBD5yM=
Date: Fri, 17 Oct 2025 15:25:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yi Yang <yiyang13@huawei.com>
Cc: Alexey Dobriyan <adobriyan@sw.ru>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, <lujialin4@huawei.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH stable] notifiers: Add oops check in
 blocking_notifier_call_chain()
Message-Id: <20251017152542.33202c28377ec9b86713ff4a@linux-foundation.org>
In-Reply-To: <20251017061740.59843-1-yiyang13@huawei.com>
References: <20251017061740.59843-1-yiyang13@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 06:17:40 +0000 Yi Yang <yiyang13@huawei.com> wrote:

> In hrtimer_interrupt(), interrupts are disabled when acquiring a spinlock,
> which subsequently triggers an oops. During the oops call chain,
> blocking_notifier_call_chain() invokes _cond_resched, ultimately leading
> to a hard lockup.
> 
> Call Stack:
> hrtimer_interrupt//raw_spin_lock_irqsave
> __hrtimer_run_queues
> page_fault
> do_page_fault
> bad_area_nosemaphore
> no_context
> oops_end
> bust_spinlocks
> unblank_screen
> do_unblank_screen
> fbcon_blank
> fb_notifier_call_chain
> blocking_notifier_call_chain
> down_read
> _cond_resched

Seems this trace is upside-down relative to what we usually see.

Is the unaltered dmesg output available?

> If the system is in an oops state, use down_read_trylock instead of a
> blocking lock acquisition. If the trylock fails, skip executing the
> notifier callbacks to avoid potential deadlocks or unsafe operations
> during the oops handling process.
> 
> ...
>
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -384,9 +384,18 @@ int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
>  	 * is, we re-check the list after having taken the lock anyway:
>  	 */
>  	if (rcu_access_pointer(nh->head)) {
> -		down_read(&nh->rwsem);
> -		ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
> -		up_read(&nh->rwsem);
> +		if (!oops_in_progress) {
> +			down_read(&nh->rwsem);
> +			ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
> +			up_read(&nh->rwsem);
> +		} else {
> +			if (down_read_trylock(&nh->rwsem)) {
> +				ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
> +				up_read(&nh->rwsem);
> +			} else {
> +				ret = NOTIFY_BAD;
> +			}
> +		}
>  	}
>  	return ret;

Am I correct in believing that fb_notifier_call_chain() is only ever
called if defined(CONFIG_GUMSTIX_AM200EPD)?

I wonder what that call is for, and if we can simply remove it.

