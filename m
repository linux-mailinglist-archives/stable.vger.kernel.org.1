Return-Path: <stable+bounces-144281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F5AB604E
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 02:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA89860E1A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 00:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144A612C499;
	Wed, 14 May 2025 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="q+dREfjf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DEF9478;
	Wed, 14 May 2025 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747184195; cv=none; b=pX+ZvgtWEQa41XH8CWqimj5ra2sfDSGNgU3QiDfLj/xIbngS8QOW6lmq7QEG7lGFKIJoYME0uSC425T1DINxOVv3in2Rhwve9Jqw61G9TZ14wvtn3dv6or0LVOQB1asEzZmE49m3m/sbow8ue/S1OlE8CUZgoa0v9b89kWn6FLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747184195; c=relaxed/simple;
	bh=5c62wOnQoIN2NBL/NFAZ1guCzR5VoFPHv8AgbDUOjPs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Q9zArbnqGKBs9/Lnyvv4AtM4fCP/BtAHlozZuvFyOiWO+9H14Z/I4MzqRMkupSjiN8wuZiy9u0b3yMRCL/41DKiGh0/Wg5YEr1fuCjziVuyGFCfIOiGTlqeRtYDtXpNBJVB+CyJ5Rb8HZ7YI3fb/oCFniUZMtOaQWWhalGvqHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q+dREfjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1EFC4CEE4;
	Wed, 14 May 2025 00:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747184193;
	bh=5c62wOnQoIN2NBL/NFAZ1guCzR5VoFPHv8AgbDUOjPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+dREfjf+Nh7sa72RzFbwMvYBaAl8f1gBUEIzHFn1hArsGKg53HIKsRgZNYVrYIJH
	 GroTtpf7DqS2vS9v4xKV7jVTEm/oUFTDQ0FI2VqxVxmU32gIDi7gDETBZ8dzFRsHbs
	 TH4xQ9/33Ag6ysd8Ki4QLPsrAPQRsFxLcHCOks/w=
Date: Tue, 13 May 2025 17:56:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev,
 osalvador@suse.de, kernel-dev@igalia.com, stable@vger.kernel.org, Hugh
 Dickins <hughd@google.com>, Florent Revest <revest@google.com>, Gavin Shan
 <gshan@redhat.com>, Byungchul Park <byungchul@sk.com>
Subject: Re: [PATCH] mm/hugetlb: fix a deadlock with pagecache_folio and
 hugetlb_fault_mutex_table
Message-Id: <20250513175633.85f4e19f4232a68ab04c8e41@linux-foundation.org>
In-Reply-To: <20250513093448.592150-1-gavinguo@igalia.com>
References: <20250513093448.592150-1-gavinguo@igalia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 17:34:48 +0800 Gavin Guo <gavinguo@igalia.com> wrote:

> The patch fixes a deadlock which can be triggered by an internal
> syzkaller [1] reproducer and captured by bpftrace script [2] and its log
> [3] in this scenario:
> 
> Process 1                              Process 2
> ---				       ---
> hugetlb_fault
>   mutex_lock(B) // take B
>   filemap_lock_hugetlb_folio
>     filemap_lock_folio
>       __filemap_get_folio
>         folio_lock(A) // take A
>   hugetlb_wp
>     mutex_unlock(B) // release B
>     ...                                hugetlb_fault
>     ...                                  mutex_lock(B) // take B
>                                          filemap_lock_hugetlb_folio
>                                            filemap_lock_folio
>                                              __filemap_get_folio
>                                                folio_lock(A) // blocked
>     unmap_ref_private
>     ...
>     mutex_lock(B) // retake and blocked
> 
> This is a ABBA deadlock involving two locks:
> - Lock A: pagecache_folio lock
> - Lock B: hugetlb_fault_mutex_table lock

Nostalgia.  A decade or three ago many of us spent much of our lives
staring at ABBA deadlocks.  Then came lockdep and after a few more
years, it all stopped.  I've long hoped that lockdep would gain a
solution to custom locks such as folio_wait_bit_common(), but not yet.

Byungchul, please take a look.  Would DEPT
(https://lkml.kernel.org/r/20250513100730.12664-1-byungchul@sk.com)
have warned us about this?

>
> ...
>
> The deadlock occurs between two processes as follows:
>
> ...
> 
> Fixes: 40549ba8f8e0 ("hugetlb: use new vma_lock for pmd sharing synchronization")
> Cc: <stable@vger.kernel.org>

It's been there for three years so I assume we aren't in a hurry.

The fix looks a bit nasty, sorry.  Perhaps designed for a minimal patch
footprint?  That's good for a backportable fixup, but a more broadly
architected solution may be needed going forward.

I'll queue it for 6.16-rc1 with a cc:stable, so this should be
presented to the -stable trees 3-4 weeks from now.


