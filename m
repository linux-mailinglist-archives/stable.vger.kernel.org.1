Return-Path: <stable+bounces-172915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA5B352F1
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 07:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15B91B20D1B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 05:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109242D5C6A;
	Tue, 26 Aug 2025 05:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJBc691d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD692169AD2;
	Tue, 26 Aug 2025 05:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756184542; cv=none; b=Mn1VABwfqyGsY10PuZalp+mtdz+NS0jQk1vIN6Y1B9IPgFiFHcumkKGfa2g6B1aFU1TsLTPoSe8bygBVWKY6erBgKdKUBWj9SrqoclIAORV7y0A9vNovotShawjH8UxEP+OBJBMkS0USzr1RxHF9i1mMCxgRmEoWgxluFIbZ2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756184542; c=relaxed/simple;
	bh=Hxhmy6RB+z8kvpV21B5aHmme1C4i2b3SIeG6Tj7bea8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=EuM4WNsVkr2gAn9BaCNQVsG3qSoSZqOV8rqBgamTRcxV5xWJZd44/PAeHvXDhl7VF5fK0Pm8AmQvAmgI4XOPwMfmGNXiob/gqZ7nSk5Th9bEP8z+0mesisdnYeEUP4PlBiVoHV75zeahybKrJmqMLeXBb5HEInEmHQNN74R6xPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJBc691d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6A7C4CEF1;
	Tue, 26 Aug 2025 05:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756184542;
	bh=Hxhmy6RB+z8kvpV21B5aHmme1C4i2b3SIeG6Tj7bea8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iJBc691doB/lOoG3QXMSL0Kkm5wIm77UE4/tBUj6mbBEzuKrwvhoOB61w3DARzrc+
	 GNhGzisWqh00iuLzxkwPnCfqu34MHl9wc66TDe9vo5pGmC628FPLErvU00Hb7Pr9MZ
	 vOTvytXybQZ3WZVOOhc5XN4IGzQrBy7CwtlBykGNvRcRtMwkNDqxrg73g77fbO/XII
	 GKsesAR1zJALHF4uM2FaIIPnXDiBDyOxum9r/eIXRPVqh9Nkj/jlVXX+sG0iYtJu0D
	 Iagj8aOabUdrygII2S7hyvI8rjiCV5yEM+ji5EdkXL00LISyC9UPQCCpO5XT+Ogt/I
	 nkcN6MCCnOnEw==
Date: Tue, 26 Aug 2025 14:02:17 +0900
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
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
Message-Id: <20250826140217.7f566d2b404ac5ece8b36fa3@kernel.org>
In-Reply-To: <20250823074048.92498-1-lance.yang@linux.dev>
References: <f79735e1-1625-4746-98ce-a3c40123c5af@linux.dev>
	<20250823074048.92498-1-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Lence,

On Sat, 23 Aug 2025 15:40:48 +0800
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
> To fix this, enforce a minimum of 4-byte alignment on the core lock
> structures supported by the blocker tracking mechanism. This ensures the
> algorithm's alignment assumption now holds true on all architectures.
> 
> This patch adds __aligned(4) to the definitions of "struct mutex",
> "struct semaphore", and "struct rw_semaphore", resolving the warnings.

Instead of putting the type flags in the blocker address (pointer),
can't we record the type information outside? It is hard to enforce
the alignment to the locks, because it is embedded in the data
structure. Instead, it is better to record the type as blocker_type
in current task_struct.

Thank you,

> 
> Thanks to Geert for bisecting!
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
> Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>  include/linux/mutex_types.h | 2 +-
>  include/linux/rwsem.h       | 2 +-
>  include/linux/semaphore.h   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
> index fdf7f515fde8..de798bfbc4c7 100644
> --- a/include/linux/mutex_types.h
> +++ b/include/linux/mutex_types.h
> @@ -51,7 +51,7 @@ struct mutex {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map	dep_map;
>  #endif
> -};
> +} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
>  
>  #else /* !CONFIG_PREEMPT_RT */
>  /*
> diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
> index f1aaf676a874..f6ecf4a4710d 100644
> --- a/include/linux/rwsem.h
> +++ b/include/linux/rwsem.h
> @@ -64,7 +64,7 @@ struct rw_semaphore {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map	dep_map;
>  #endif
> -};
> +} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
>  
>  #define RWSEM_UNLOCKED_VALUE		0UL
>  #define RWSEM_WRITER_LOCKED		(1UL << 0)
> diff --git a/include/linux/semaphore.h b/include/linux/semaphore.h
> index 89706157e622..ac9b9c87bfb7 100644
> --- a/include/linux/semaphore.h
> +++ b/include/linux/semaphore.h
> @@ -20,7 +20,7 @@ struct semaphore {
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>  	unsigned long		last_holder;
>  #endif
> -};
> +} __aligned(4); /* For hung_task blocker tracking, which encodes type in LSBs */
>  
>  #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
>  #define __LAST_HOLDER_SEMAPHORE_INITIALIZER				\
> -- 
> 2.49.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

