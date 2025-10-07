Return-Path: <stable+bounces-183557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241CBC2B5B
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 22:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A5E1887537
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F9B23D290;
	Tue,  7 Oct 2025 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vpy3OQSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA628399;
	Tue,  7 Oct 2025 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870562; cv=none; b=gQHlEarW7cLlMd9MVTCtBsqHDrZogHEyI2fNWefk448oQGEjbaItBUJHGphzazhXRWq1cOgVYGQUb4Wtst7C3rl2oIIFwBSAU63B/pdg2Km4dz+A+kFqSpoYW3kTLD4zW93vaH5PsCrG+jv0fsj4LEU6y5OrIRZpIGOskRTe/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870562; c=relaxed/simple;
	bh=Gg93q9CWxU5Fuu6tdVUBKMJqQ0HTtVaIEb6Cg6dpU9s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SHYR2zpc5/YZmPcYKg4xq0+U7UzslH9tD3IqY6KH6Js0DA2Ykjs+aqu/8mhjBj5p9jmMITvktoRPWitK06PhwkIzRkkbKhsIbzpMXUu5xM45njEuzqfGQHsBT5e1L/gMOvrnGP3ABhG3t7ayZyHxUPWW6nitwbzoJwnCq34uWLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vpy3OQSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24D4C4CEF1;
	Tue,  7 Oct 2025 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759870561;
	bh=Gg93q9CWxU5Fuu6tdVUBKMJqQ0HTtVaIEb6Cg6dpU9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vpy3OQSPxKsYHofaY5nTubfqbeqCcI02CR2QjQABytRZminMP/SlUK8Lg0Yy5Rk1t
	 nMiGpw5x0NaHJU4Go+SY3vkeu+6DN8Cn0B4yKwuZUBgyXWkb3Iqa0a++tobdurFO0E
	 JVfOHj0NBLGpUSlj+d3VbUWwq2a0dxVBkpi7QCiU=
Date: Tue, 7 Oct 2025 13:56:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Finn Thain
 <fthain@linux-m68k.org>, Lance Yang <lance.yang@linux.dev>,
 amaindex@outlook.com, anna.schumaker@oracle.com, boqun.feng@gmail.com,
 ioworker0@gmail.com, joel.granados@kernel.org, jstultz@google.com,
 leonylgao@tencent.com, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, longman@redhat.com, mhiramat@kernel.org,
 mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi,
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 tfiga@chromium.org, will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] hung_task: fix warnings caused by unaligned lock
 pointers
Message-Id: <20251007135600.6fc4a031c60b1384dffaead1@linux-foundation.org>
In-Reply-To: <inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
References: <20250909145243.17119-1-lance.yang@linux.dev>
	<yqjkjxg25gh4bdtftsdngj5suturft2b4hjbfxwe6hehbg4ctq@6i55py3jaiov>
	<99410857-0e72-23e4-c60f-dea96427b85a@linux-m68k.org>
	<CAMuHMdVYiSLOk-zVopXV8i7OZdO7PAK7stZSJNJDMw=ZEqtktA@mail.gmail.com>
	<inscijwnnydibdwwrkggvgxjtimajr5haixff77dbd7cxvvwc7@2t7l7oegsxcp>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Getting back to the $Subject at hand, are people OK with proceeding
with Lance's original fix?


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


