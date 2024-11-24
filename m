Return-Path: <stable+bounces-94896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335C19D73AA
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3105BB3B075
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588B1AAE17;
	Sun, 24 Nov 2024 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPMsCNqT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17318C00B
	for <stable@vger.kernel.org>; Sun, 24 Nov 2024 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732454071; cv=none; b=UW13edT8ivf3MOd81vnWoHFhPv3Z5aXNtyHjyd/n+jfGMZ5mAqUywp/f3mqqUzuE2eC1JHL+ieGgFjew3nDsaLxbLHg8nqhxu3GYgFDkwtpmbfAbJxykKkOUQeNjNIC2MseDX17vvkeKBd1+3Xgf+JQz7FLIUOG2kJg+vRUvVIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732454071; c=relaxed/simple;
	bh=aaf6mgxiFIZ4KUt3qR5b9Zp2zfPeoHch/KAwVeYdx5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdG+ymDYVKy/8jbit8clO9Orllh/X+OjeDeWQ+jLcb1qA5QLxwfaI3qe6ZjM4vQ1li8mtLSUMkbZE1QkeCoEPSc0mV992GmRIWalok1eWck474On499+ZrAS1tNUT4nFGHSzZl52o7dwFXLOm0aOICC4zn+iQC6ECUPKXy39ZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aPMsCNqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732454068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQYCp4g/idPG8DYRDVHAD0jqFgBNqHKqLtG7vbr7Lm8=;
	b=aPMsCNqTEF00j2n3nq2nkDM8NXlAn4rObML0LSIut+i0AGFLJAffBNuZZDQh9B9p+50Sc9
	A5IMz8i3G0GUBAVbrjDtBNUobTF42/P0YRH3fOTYf6jJ9XPsLwJuCOH/ldfLPpp45Av5d2
	C6LcL86HHKeSb346h3SPU7SZqrk8HsA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-c-_t-oEQNh-5KC7aPSDk0Q-1; Sun,
 24 Nov 2024 08:14:24 -0500
X-MC-Unique: c-_t-oEQNh-5KC7aPSDk0Q-1
X-Mimecast-MFC-AGG-ID: c-_t-oEQNh-5KC7aPSDk0Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 631761956089;
	Sun, 24 Nov 2024 13:14:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 993331955F43;
	Sun, 24 Nov 2024 13:14:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 24 Nov 2024 14:14:02 +0100 (CET)
Date: Sun, 24 Nov 2024 14:13:57 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 1/5] uprobes: sanitiize xol_free_insn_slot()
Message-ID: <20241124131357.GA28360@redhat.com>
References: <20241124124623.3337983-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124124623.3337983-1-sashal@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Sasha,

but why do you think it makes sense to backport these "uprobes" cleanups?

Oleg.

On 11/24, Sasha Levin wrote:
>
> From: Oleg Nesterov <oleg@redhat.com>
>
> [ Upstream commit c7b4133c48445dde789ed30b19ccb0448c7593f7 ]
>
> 1. Clear utask->xol_vaddr unconditionally, even if this addr is not valid,
>    xol_free_insn_slot() should never return with utask->xol_vaddr != NULL.
>
> 2. Add a comment to explain why do we need to validate slot_addr.
>
> 3. Simplify the validation above. We can simply check offset < PAGE_SIZE,
>    unsigned underflows are fine, it should work if slot_addr < area->vaddr.
>
> 4. Kill the unnecessary "slot_nr >= UINSNS_PER_PAGE" check, slot_nr must
>    be valid if offset < PAGE_SIZE.
>
> The next patches will cleanup this function even more.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/r/20240929144235.GA9471@redhat.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/events/uprobes.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4b52cb2ae6d62..cc605df73d72f 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1683,8 +1683,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>  static void xol_free_insn_slot(struct task_struct *tsk)
>  {
>  	struct xol_area *area;
> -	unsigned long vma_end;
>  	unsigned long slot_addr;
> +	unsigned long offset;
>
>  	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
>  		return;
> @@ -1693,24 +1693,21 @@ static void xol_free_insn_slot(struct task_struct *tsk)
>  	if (unlikely(!slot_addr))
>  		return;
>
> +	tsk->utask->xol_vaddr = 0;
>  	area = tsk->mm->uprobes_state.xol_area;
> -	vma_end = area->vaddr + PAGE_SIZE;
> -	if (area->vaddr <= slot_addr && slot_addr < vma_end) {
> -		unsigned long offset;
> -		int slot_nr;
> -
> -		offset = slot_addr - area->vaddr;
> -		slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
> -		if (slot_nr >= UINSNS_PER_PAGE)
> -			return;
> +	offset = slot_addr - area->vaddr;
> +	/*
> +	 * slot_addr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
> +	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
> +	 */
> +	if (offset < PAGE_SIZE) {
> +		int slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
>
>  		clear_bit(slot_nr, area->bitmap);
>  		atomic_dec(&area->slot_count);
>  		smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
>  		if (waitqueue_active(&area->wq))
>  			wake_up(&area->wq);
> -
> -		tsk->utask->xol_vaddr = 0;
>  	}
>  }
>
> --
> 2.43.0
>


