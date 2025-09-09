Return-Path: <stable+bounces-179108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71008B5030A
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 18:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1093AA86F
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 16:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA592EB85E;
	Tue,  9 Sep 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KEttwVdH"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7275F19DF5F;
	Tue,  9 Sep 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436411; cv=none; b=m3Cb0jhLyuxXTxFtYt1N/mOgUDG2fYpEYP75ooFtsYG/PHARp0cJSY3P1d+u9zFV19XTvgK4bfHF5NTcU0lPCzXTOpliLdudtjYE/AFlDwhFPd/ji+cW5RAVcJ8D51SmI1tOPnEjP5+Z5/IK5/Pho5iM/1b4PkRiY9XDdbc7bnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436411; c=relaxed/simple;
	bh=QgIYeufilVMaZPW5PjHtCNwEpEe12k2ooZbak7yW2W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7LxB6Xn+rRmH4bfSKnZ5oJm3a4gE0dXefCpFYYuRQ5tK8hPcWMxrmHaTPomjEnMuwdIMYM8COj8j3OwDPKEHf/Q0hKgo5Sbr69heW72wKhjxhusU5DZt+L5JC8BUN9zdRb63uZeHItsqgaqqTiklkuP8lTwtRJMpF2GKoM5sgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KEttwVdH; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 9 Sep 2025 12:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757436407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j+qxWL9ciWsFKbxGdri5NqQLUVz4iV2qrMUc7/7Rqno=;
	b=KEttwVdHN4u1Rqaqy0n/0ljJ7PEg2qSm7rX8XchH8aMt6ei99Cwj16DB6hzinK48vvdfgO
	rr+xPZagp55x/QS4un+1+0+QT+dFDSpjrIDTwt4Vup8bNfLDHIeYqaFRRceBmysFnqaU3Y
	1TyO+vlQZLYzi6Vt58cpKn1dvC6PHw4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, amaindex@outlook.com, 
	anna.schumaker@oracle.com, boqun.feng@gmail.com, fthain@linux-m68k.org, 
	geert@linux-m68k.org, ioworker0@gmail.com, joel.granados@kernel.org, 
	jstultz@google.com, leonylgao@tencent.com, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org, mingo@redhat.com, 
	mingzhe.yang@ly.com, oak@helsinkinet.fi, peterz@infradead.org, rostedt@goodmis.org, 
	senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-ID: <yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
References: <20250909145243.17119-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909145243.17119-1-lance.yang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 10:52:43PM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The blocker tracking mechanism assumes that lock pointers are at least
> 4-byte aligned to use their lower bits for type encoding.
> 
> However, as reported by Eero Tamminen, some architectures like m68k
> only guarantee 2-byte alignment of 32-bit values. This breaks the
> assumption and causes two related WARN_ON_ONCE checks to trigger.

Isn't m68k the only architecture that's weird like this?

> To fix this, the runtime checks are adjusted to silently ignore any lock
> that is not 4-byte aligned, effectively disabling the feature in such
> cases and avoiding the related warnings.
> 
> Thanks to Geert Uytterhoeven for bisecting!
> 
> Reported-by: Eero Tamminen <oak@helsinkinet.fi>
> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
> v1 -> v2:
>  - Pick RB from Masami - thanks!
>  - Update the changelog and comments
>  - https://lore.kernel.org/lkml/20250823050036.7748-1-lance.yang@linux.dev/
> 
>  include/linux/hung_task.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> index 34e615c76ca5..c4403eeb7144 100644
> --- a/include/linux/hung_task.h
> +++ b/include/linux/hung_task.h
> @@ -20,6 +20,10 @@
>   * always zero. So we can use these bits to encode the specific blocking
>   * type.
>   *
> + * Note that on architectures where this is not guaranteed, or for any
> + * unaligned lock, this tracking mechanism is silently skipped for that
> + * lock.
> + *
>   * Type encoding:
>   * 00 - Blocked on mutex			(BLOCKER_TYPE_MUTEX)
>   * 01 - Blocked on semaphore			(BLOCKER_TYPE_SEM)
> @@ -45,7 +49,7 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
>  	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
>  	 * without writing anything.
>  	 */
> -	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
> +	if (lock_ptr & BLOCKER_TYPE_MASK)
>  		return;
>  
>  	WRITE_ONCE(current->blocker, lock_ptr | type);
> @@ -53,8 +57,6 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
>  
>  static inline void hung_task_clear_blocker(void)
>  {
> -	WARN_ON_ONCE(!READ_ONCE(current->blocker));
> -
>  	WRITE_ONCE(current->blocker, 0UL);
>  }
>  
> -- 
> 2.49.0
> 

