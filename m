Return-Path: <stable+bounces-172913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB90B352DD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 06:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142551A83B45
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 04:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909B2E091E;
	Tue, 26 Aug 2025 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGOU2HDD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F12D23B6;
	Tue, 26 Aug 2025 04:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756183794; cv=none; b=igaSJPwC4b8EMJZh+xzVQigtMBYrnGODS3xj8usMeMKLn/APloLfBF0ubEL/XKOwcM9ZHuwgAJpV6biZXLthvLqtrBZM1RjjAgt73ItMwE5kvybS1Cc3iqPbkqXmmTxtIFHGTriAh0Py6Km0jGeQHJ35iH3PWkmogT1c5UYar8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756183794; c=relaxed/simple;
	bh=mrTYfgAhz8yJIWYyD+ab7SDQCpNIYQe9Kn5DqAcQJpU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nj+fFi6FFCBkLCFfesav5dc/THiAkAhwqpbT+Rgq8lzNnqOoMqiimz1U9Bi6ILo5IQL435YN3lNnfPC+5QvN25Shf7NpxFUsPZDuQp5rzJDFuJdv81Vygc+ST9pLRgXQWC0VlqnPNAdRefbFbttGcMOX2yoRdL7wVO28Wmi4cEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGOU2HDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EB9C4CEF1;
	Tue, 26 Aug 2025 04:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756183793;
	bh=mrTYfgAhz8yJIWYyD+ab7SDQCpNIYQe9Kn5DqAcQJpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AGOU2HDDCy6d14h/txWFuiD0IdaXRysDk6Dbpw4n4li24LSI+9kVsYYI1nxI4n4m6
	 SbuIYsohrM1cYPTeY/HyYGVBpxZuBnMPh/BUsP56TuQTZgo7W9pHSOGaeiPOcj3os6
	 O3BhEqhgjZmfLYkLGPpLZnzdWyMmWNEj1Q98oDoLOki0iyRwGWUiR9+3dIULnXei5X
	 v6UNkUvGrXvCuJj2pNMX2kUI45+OTM6H6K25uUOj1YET7MGRoLDs5v5qE3GrsNkc2N
	 m6qaVKhaVtOdx8/lMiVSQDQrzqsrxCC2pssxUTaNj7NnU4sakQD8nLdNDr/0HHhjAc
	 Lr/FVDTwVp1zA==
Date: Tue, 26 Aug 2025 13:49:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, fthain@linux-m68k.org, geert@linux-m68k.org,
 senozhatsky@chromium.org, amaindex@outlook.com, anna.schumaker@oracle.com,
 boqun.feng@gmail.com, ioworker0@gmail.com, joel.granados@kernel.org,
 jstultz@google.com, kent.overstreet@linux.dev, leonylgao@tencent.com,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 longman@redhat.com, mingo@redhat.com, mingzhe.yang@ly.com,
 oak@helsinkinet.fi, peterz@infradead.org, rostedt@goodmis.org,
 tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-Id: <20250826134948.4f5f5aa74849e7f56f106c83@kernel.org>
In-Reply-To: <20250823050036.7748-1-lance.yang@linux.dev>
References: <f79735e1-1625-4746-98ce-a3c40123c5af@linux.dev>
	<20250823050036.7748-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Aug 2025 13:00:36 +0800
Lance Yang <lance.yang@linux.dev> wrote:

> From: Lance Yang <lance.yang@linux.dev>
> 
> The blocker tracking mechanism assumes that lock pointers are at least
> 4-byte aligned to use their lower bits for type encoding.
> 
> However, as reported by Geert Uytterhoeven, some architectures like m68k
> only guarantee 2-byte alignment of 32-bit values. This breaks the
> assumption and causes two related WARN_ON_ONCE checks to trigger.
> 
> To fix this, the runtime checks are adjusted. The first WARN_ON_ONCE in
> hung_task_set_blocker() is changed to a simple 'if' that returns silently
> for unaligned pointers. The second, now-invalid WARN_ON_ONCE in
> hung_task_clear_blocker() is then removed.
> 
> Thanks to Geert for bisecting!
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>

Looks good to me. I think we can just ignore it for
this debugging option.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
>  include/linux/hung_task.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
> index 34e615c76ca5..69640f266a69 100644
> --- a/include/linux/hung_task.h
> +++ b/include/linux/hung_task.h
> @@ -20,6 +20,10 @@
>   * always zero. So we can use these bits to encode the specific blocking
>   * type.
>   *
> + * Note that on architectures like m68k with only 2-byte alignment, the
> + * blocker tracking mechanism gracefully does nothing for any lock that is
> + * not 4-byte aligned.
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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

