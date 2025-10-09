Return-Path: <stable+bounces-183654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 326B5BC7586
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 06:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DAA6234AF60
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 04:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91735221FB6;
	Thu,  9 Oct 2025 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nIUztAZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F716DEB1;
	Thu,  9 Oct 2025 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759982695; cv=none; b=IXfYhgfxTvxkDk7OvfldplWoXhEnQ14RpnncMXvfScWat7zTgy17KLCMjq6JjB4EZTHVTkNlngB39Gz9ArxdI8KkBxZAL0Sm2Siwq6lhxZ26m7VMaXjn7mlNtrKOk+xihn9gYCrlvdYi+q9xHy01SF6wz3NZOlXfQohqPuGnkuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759982695; c=relaxed/simple;
	bh=DCmW1Fy9ep6190H7tU2v5kS2XIm6raDoEW/DHR1Vjjg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KdE1WJBk36n/yT4PvjBh5dESXRzhg/mUxf0BMtahDSBJrVVAYyXXtHuJhULdseufK3BgIj/6L7hxsHMi9SKvyvnDEGIbtQwyoOuK+NiZSAv3y4WG3btaT+PCa6f+M4xUk1cNcSuvbmB4Vz3SVtS42yiaRo6yk4epKrMt3psuJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nIUztAZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35D1C4CEE7;
	Thu,  9 Oct 2025 04:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759982694;
	bh=DCmW1Fy9ep6190H7tU2v5kS2XIm6raDoEW/DHR1Vjjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nIUztAZJruIzIDci75GQZX+SEixhge4TpK1eNqOb/hlvMQJFOaZTX2zEx1gcgBklJ
	 oEzDbhGwzqUsxOaZE6o64JYS4LapPFhGlquXTm5JJNaZB3G3vqHEBvJGh9agHawsud
	 f46csRYJjvknKBzXG25HGsS1kJoMjo7iE+A8M1l0=
Date: Wed, 8 Oct 2025 21:04:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eero Tamminen
 <oak@helsinkinet.fi>, Kent Overstreet <kent.overstreet@linux.dev>,
 amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com,
 ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com,
 leonylgao@tencent.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org,
 mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org,
 rostedt@goodmis.org, Finn Thain <fthain@linux-m68k.org>,
 senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-Id: <20251008210453.71ba81a635fc99ce9262be7e@linux-foundation.org>
In-Reply-To: <3e0b7551-698f-4ef6-919b-ff4cbe3aa11c@linux.dev>
References: <20250909145243.17119-1-lance.yang@linux.dev>
	<yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
	<99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
	<CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
	<inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
	<20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
	<b43ce4a0-c2b5-53f2-e374-ea195227182d@linux-m68k.org>
	<56784853-b653-4587-b850-b03359306366@linux.dev>
	<693a62e0-a2b5-113b-d5d9-ffb7f2521d6c@linux-m68k.org>
	<23b67f9d-20ff-4302-810c-bf2d77c52c63@linux.dev>
	<2bd2c4a8-456e-426a-aece-6d21afe80643@linux.dev>
	<ba00388c-1d5b-4d95-054d-a6f09af41e7b@linux-m68k.org>
	<3fa8182f-0195-43ee-b163-f908a9e2cba3@linux.dev>
	<ad7cb710-0d5a-93b1-fa4d-efb236760495@linux-m68k.org>
	<3e0b7551-698f-4ef6-919b-ff4cbe3aa11c@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 10:01:18 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> I think we fundamentally disagree on whether this fix for known
> false-positive warnings is needed for -stable.

Having the kernel send scary warnings to our users is really bad
behavior.  And if we don't fix it, people will keep reporting it.

And removing a WARN_ON is a perfectly good way of fixing it.  The
kernel has 19,000 WARNs, probably seven of which are useful :(




From: Lance Yang <lance.yang@linux.dev>
Subject: hung_task: fix warnings caused by unaligned lock pointers
Date: Tue, 9 Sep 2025 22:52:43 +0800

From: Lance Yang <lance.yang@linux.dev>

The blocker tracking mechanism assumes that lock pointers are at least
4-byte aligned to use their lower bits for type encoding.

However, as reported by Eero Tamminen, some architectures like m68k
only guarantee 2-byte alignment of 32-bit values. This breaks the
assumption and causes two related WARN_ON_ONCE checks to trigger.

To fix this, the runtime checks are adjusted to silently ignore any lock
that is not 4-byte aligned, effectively disabling the feature in such
cases and avoiding the related warnings.

Thanks to Geert Uytterhoeven for bisecting!

Link: https://lkml.kernel.org/r/20250909145243.17119-1-lance.yang@linux.dev
Fixes: e711faaafbe5 ("hung_task: replace blocker_mutex with encoded blocker")
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reported-by: Eero Tamminen <oak@helsinkinet.fi>
Closes: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Mingzhe Yang <mingzhe.yang@ly.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Yongliang Gao <leonylgao@tencent.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/hung_task.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/include/linux/hung_task.h~hung_task-fix-warnings-caused-by-unaligned-lock-pointers
+++ a/include/linux/hung_task.h
@@ -20,6 +20,10 @@
  * always zero. So we can use these bits to encode the specific blocking
  * type.
  *
+ * Note that on architectures where this is not guaranteed, or for any
+ * unaligned lock, this tracking mechanism is silently skipped for that
+ * lock.
+ *
  * Type encoding:
  * 00 - Blocked on mutex			(BLOCKER_TYPE_MUTEX)
  * 01 - Blocked on semaphore			(BLOCKER_TYPE_SEM)
@@ -45,7 +49,7 @@ static inline void hung_task_set_blocker
 	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
 	 * without writing anything.
 	 */
-	if (WARN_ON_ONCE(lock_ptr & BLOCKER_TYPE_MASK))
+	if (lock_ptr & BLOCKER_TYPE_MASK)
 		return;
 
 	WRITE_ONCE(current->blocker, lock_ptr | type);
@@ -53,8 +57,6 @@ static inline void hung_task_set_blocker
 
 static inline void hung_task_clear_blocker(void)
 {
-	WARN_ON_ONCE(!READ_ONCE(current->blocker));
-
 	WRITE_ONCE(current->blocker, 0UL);
 }
 
_


