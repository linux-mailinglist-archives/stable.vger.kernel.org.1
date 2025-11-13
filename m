Return-Path: <stable+bounces-194708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69B1C58EBF
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 17:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634AE3ACC69
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361935A952;
	Thu, 13 Nov 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtOW03LV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EEA36998C
	for <stable@vger.kernel.org>; Thu, 13 Nov 2025 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051924; cv=none; b=vDHlo7KSw2qH2KZBCOxEjUAeKTrJu/ehqpk3yaZp2J4moFyH4dvAWOBtC9f1dyRjAlUp7z0b8gXhHrqNS60jXgDGLpz39FwQLjeA1Fz/KGqYp8geAXFyBQ6fOY27lvI+/9xHBNRDkHZmKKMeCJnntFH6hMwZthkSDKI3IKhVvlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051924; c=relaxed/simple;
	bh=7JmJjlOLM7YF/aoEOfnmZDsS7mYHbiyo63BRjbVcVU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmRcrKgZ2SUKa+hX2jW8WaE4bGcP/6RlJZA8aWzJA4TrgU84Oo3Nh/bBXnU/O2PYdPOQuBN7yQrvQuZDj+SnC+ASe+oOxLqnnj2VT/YeixeRIkIIl3oFzaKIL3zXk1Mk1F2rm+nysQ16rXgrQD+M2EpXSErVADmX6tfmk007B+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZtOW03LV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763051921;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=xe+X3mdag6fV8h/+NMdsDvwRa8jS9KrFnwPQstc7Xho=;
	b=ZtOW03LVHVvM+zYveeFTPKQa5ZoVyCV2wzVcht8gy4XG5xlbr2eMNz7DlOkqmHlZ1Ovqdv
	/eplVHs3VB1tlUCgwJFh4jHFOObGSeY1bgRiP6tVtYrSMK94HzBM+uGuezS60witYQEIeJ
	OmZgi0CbijkFtPCpsqaBUvg1zMh6ors=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-xtmH_0HjM_iy2Ln-1pnZYA-1; Thu,
 13 Nov 2025 11:38:38 -0500
X-MC-Unique: xtmH_0HjM_iy2Ln-1pnZYA-1
X-Mimecast-MFC-AGG-ID: xtmH_0HjM_iy2Ln-1pnZYA_1763051916
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C04318AB423;
	Thu, 13 Nov 2025 16:38:36 +0000 (UTC)
Received: from localhost (unknown [10.22.88.185])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA15819560B9;
	Thu, 13 Nov 2025 16:38:35 +0000 (UTC)
Date: Thu, 13 Nov 2025 11:38:33 -0500
From: Derek Barbosa <debarbos@redhat.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sherry Sun <sherry.sun@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH printk v2 2/2] printk: Avoid scheduling irq_work on
 suspend
Message-ID: <jvn24vsnd2utypz33k33n3ol3ihh44tcyhcbtjhfxnepuvb7hn@qhcikbtwioyk>
Reply-To: debarbos@redhat.com
References: <20251113160351.113031-1-john.ogness@linutronix.de>
 <20251113160351.113031-3-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113160351.113031-3-john.ogness@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Nov 13, 2025 at 05:09:48PM +0106, John Ogness wrote:

> ---
>  @sherry.sun: This patch is essentially the same as v1, but since
>  two WARN_ON_ONCE() were added, I decided not to use your
>  Tested-by. It would be great if you could test again with this
>  series.
> 
>  kernel/printk/internal.h |  8 +++---
>  kernel/printk/nbcon.c    |  7 +++++
>  kernel/printk/printk.c   | 58 +++++++++++++++++++++++++++++-----------
>  3 files changed, 55 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 73f315fd97a3e..730d14f6cbc58 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1276,6 +1276,13 @@ void nbcon_kthreads_wake(void)
>  	if (!printk_kthreads_running)
>  		return;
>  
> +	/*
> +	 * It is not allowed to call this function when console irq_work
> +	 * is blocked.
> +	 */
> +	if (WARN_ON_ONCE(console_irqwork_blocked))
> +		return;
> +

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dc89239cf1b58..b1c0d35cf3caa 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -462,6 +462,9 @@ bool have_boot_console;
>  /* See printk_legacy_allow_panic_sync() for details. */
>  bool legacy_allow_panic_sync;
>  
> +/* Avoid using irq_work when suspending. */
> +bool console_irqwork_blocked;
> +
>  #ifdef CONFIG_PRINTK
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  static DECLARE_WAIT_QUEUE_HEAD(legacy_wait);
> @@ -2426,7 +2429,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	if (ft.legacy_offload)
>  		defer_console_output();
> -	else
> +	else if (!console_irqwork_blocked)
>  		wake_up_klogd();
>  
>  	return printed_len;
> @@ -2730,10 +2733,20 @@ void console_suspend_all(void)
>  {
>  	struct console *con;
>  
> +	if (console_suspend_enabled)
> +		pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
> +
> +	/*
> +	 * Flush any console backlog and then avoid queueing irq_work until
> +	 * console_resume_all(). Until then deferred printing is no longer
> +	 * triggered, NBCON consoles transition to atomic flushing, and
> +	 * any klogd waiters are not triggered.
> +	 */
> +	pr_flush(1000, true);
> +	console_irqwork_blocked = true;
> +

Thanks for this. I have recently have been seeing the same issue with a large-CPU
workstation system in which the serial console been locking up entry/exit of S4
Hibernation sleep state at different intervals.

I am still running tests on the V1 of the series to determine reproducibility,
but I will try to get this version tested in a timely manner as well.

I did, however, test the proto-patch at [0]. The original issue was reproducible
with this patch applied. Avoiding klogd waking in vprintk_emit() and the
addition of the check in nbcon.c (new in this series) opposed to aborting
callers outright seems more airtight.


[0] https://github.com/Linutronix/linux/commit/ae173249d9028ef159fba040bdab260d80dda43f
-- 
Derek <debarbos@redhat.com>


