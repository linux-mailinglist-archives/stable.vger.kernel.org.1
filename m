Return-Path: <stable+bounces-53798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBA90E70A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5B4B20E87
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18980026;
	Wed, 19 Jun 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXHbokv9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFDD7EEFD
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789308; cv=none; b=dLMqxQgO1Q3WaAlhtNAOMNrpJ8TBtmxPWxBSsxO/b7Y1bbqByxVImsSXH0lKi45twOVnNpnXoH7qae90oXkvNAK3G0a7k46A1ADr0D+PRwRTBUaQJuRMGJJ91Z6nPdWytvpqSerhYLwUGUr67/+/m83H6pU81EIrjlStybij8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789308; c=relaxed/simple;
	bh=WufxOsxR/bUrhyOCBsQoIi+3GMc3jHQidh5GMUPn48I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZymJJ+X87KEKVJEBTv5Yclnk6rCXOsX3/a6+RsL4uvXiVa44UOtp9iIALrB749I/I9PewKOTwoXhShzxi2/jE0LQnOo5Nggw+HQdxBwZKjnlxazk9nx4qfKuIA+nW/32UGbDjzwtsVsyBsPXWRsqM9QCh4JvI4spFrXdak7eGK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXHbokv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1C3C4AF1A;
	Wed, 19 Jun 2024 09:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718789308;
	bh=WufxOsxR/bUrhyOCBsQoIi+3GMc3jHQidh5GMUPn48I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXHbokv9hHKBEINlK7fBxr437HVEsbXm2xNKwjVwRJrjTzNGePrKqUJsOnGAkorR+
	 i9Vy8tbcrA+G2Q/N+Zch9qZEX4Q9Jod3fuVgljb4J2F2UY2GsrTQQvlmI8nl1oHOeM
	 xdNDAU/RlQsdTMB2/Goz/GClogUr4KaLsc5WG+48=
Date: Wed, 19 Jun 2024 11:28:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oleg@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y and earlier] tick/nohz_full: Don't abuse
 smp_call_function_single() in tick_setup_device()
Message-ID: <2024061917-sheet-galvanize-56e6@gregkh>
References: <2024061706-smudgy-gumball-93c0@gregkh>
 <87ed8vs3y9.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed8vs3y9.ffs@tglx>

On Mon, Jun 17, 2024 at 10:35:10PM +0200, Thomas Gleixner wrote:
> 
> From: Oleg Nesterov <oleg@redhat.com>
> 
> commit 07c54cc5988f19c9642fd463c2dbdac7fc52f777 upstream.
> 
> After the recent commit 5097cbcb38e6 ("sched/isolation: Prevent boot crash
> when the boot CPU is nohz_full") the kernel no longer crashes, but there is
> another problem.
> 
> In this case tick_setup_device() calls tick_take_do_timer_from_boot() to
> update tick_do_timer_cpu and this triggers the WARN_ON_ONCE(irqs_disabled)
> in smp_call_function_single().
> 
> Kill tick_take_do_timer_from_boot() and just use WRITE_ONCE(), the new
> comment explains why this is safe (thanks Thomas!).
> 
> Fixes: 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full")
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20240528122019.GA28794@redhat.com
> Link: https://lore.kernel.org/all/20240522151742.GA10400@redhat.com
> ---
> Backport to v6.6.y and earlier

Now queued up, thanks.

greg k-h

