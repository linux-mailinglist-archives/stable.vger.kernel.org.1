Return-Path: <stable+bounces-27095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29C8754D4
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F12F1F250CD
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408C112FF8F;
	Thu,  7 Mar 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d7YsNYct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742B12FF6D
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831180; cv=none; b=YgnCiDVZm3fmndAnViJ53rAV4gCNO+S1X0fkzkF5AlUHK02u8RdyeT+kOneG+rBB3So5UHRnaaQ4sfAhyF3rMWInnW4iwIgZX5MjldB8tinO7c9/6mE2a/VkhHC3q7eWNf2ZIvPxSP2YczhafozE1rWrVbbTol3Wk/o6ScPhPF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831180; c=relaxed/simple;
	bh=pnS+sAcajTYzsM/6j4dWe0iCom8D53yfQgg7WlaHm2Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rMugXNoIO6e0X6JVkz4nbsTCo8Sdz9Erd0Y7IvGsE98yHNpsnn+7SMhwluELUczPvR1THjdQlx875+NOJuczElbTbOZXEq8x61W794/iTE6erkB36/pgtjz2cV/69wL5tLc6HDWeBhBTmOWcrRq+UTYw0Sbi8UqvODJdrWviUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d7YsNYct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F1F4C433C7;
	Thu,  7 Mar 2024 17:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709831179;
	bh=pnS+sAcajTYzsM/6j4dWe0iCom8D53yfQgg7WlaHm2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d7YsNYctsm0kwbIzwjNCVNvjSWxBVAJ6n2hLneQuQXJQQGk6RGLSKxQmrwph/ggVy
	 tuHGjBhuGYzi18QRd7nB8OOA/6itR6+tgLCHp8PJn8vhNI4pFh4NlGxvifom+YG1oX
	 AdwiisWwIq+XPA/Lj6tbFZWykVKmZViQrkjVVa54=
Date: Thu, 7 Mar 2024 09:06:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: yuzhao@google.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: mglru: Fix soft lockup attributed to scanning
 folios
Message-Id: <20240307090618.50da28040e1263f8af39046f@linux-foundation.org>
In-Reply-To: <20240307031952.2123-1-laoar.shao@gmail.com>
References: <20240307031952.2123-1-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 11:19:52 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:

> After we enabled mglru on our 384C1536GB production servers, we
> encountered frequent soft lockups attributed to scanning folios.
> 
> The soft lockup as follows,
>
> ...
>
> There were a total of 22 tasks waiting for this spinlock
> (RDI: ffff99d2b6ff9050):
> 
>  crash> foreach RU bt | grep -B 8  queued_spin_lock_slowpath |  grep "RDI: ffff99d2b6ff9050" | wc -l
>  22

If we're holding the lock for this long then there's a possibility of
getting hit by the NMI watchdog also.

> Additionally, two other threads were also engaged in scanning folios, one
> with 19 waiters and the other with 15 waiters.
> 
> To address this issue under heavy reclaim conditions, we introduced a
> hotfix version of the fix, incorporating cond_resched() in scan_folios().
> Following the application of this hotfix to our servers, the soft lockup
> issue ceased.
> 
> ...
>
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4367,6 +4367,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>  
>  			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
>  				break;
> +
> +			spin_unlock_irq(&lruvec->lru_lock);
> +			cond_resched();
> +			spin_lock_irq(&lruvec->lru_lock);
>  		}

Presumably wrapping this with `if (need_resched())' will save some work.

This lock is held for a reason.  I'd like to see an analysis of why
this change is safe.

