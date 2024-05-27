Return-Path: <stable+bounces-47297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 391908D0D6B
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8433B21358
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B64615FCFC;
	Mon, 27 May 2024 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bf6MTXjV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814A262BE;
	Mon, 27 May 2024 19:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838178; cv=none; b=OKIEPzOsj5fgLQhhU8yBdpQ1ekUox52lG/bE0ViGnws6zQEiDqG9gKDme+05eZImATkAxbX0qe4J1OnKkc47kc6OyQ5KEUvafedpOqtiSg8FxENlbAMHgNVjxkWlY1YYXWxy4higGShBQiJ7HNlh2huxcwyQGS+g5n5jPCwokoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838178; c=relaxed/simple;
	bh=B8HFlyJgUG4AEznR897tMlvNNxbYosQ79EIMa3D1W/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvMdY9E3VUfIdzNQygEFqpRTOWvKzk7gUdcVvVQUU0DOnaAtqwEa5VhrQOouzPwYPSgCDb6y/qslxMayghbdW7rvb3W25ssEZCGXHdVnMxhHokWfxr0JAGI6ZLKRk4ZjdzcA8m4vYP/dzdT64bAtHuwG2SkfR3ksVN808lYU9Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bf6MTXjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92993C2BBFC;
	Mon, 27 May 2024 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838177;
	bh=B8HFlyJgUG4AEznR897tMlvNNxbYosQ79EIMa3D1W/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bf6MTXjVVYWTcd4d3i3UF4FXRwSSa134sQ4wXNGKM8NB1KcULmykGY19PQskHjg2m
	 MmjjMckb4rcx3bYQ/93+S8v0DRn52CrUoZ2kF4lSkpC0wJm+O5yxI0J0pdukLCvCnF
	 2WCl/XrCDO9dc4Joy5TeH/C+tt3XI+nX9+wPMMF4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Schmitz <schmitzmic@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 295/493] m68k: Fix spinlock race in kernel thread creation
Date: Mon, 27 May 2024 20:54:57 +0200
Message-ID: <20240527185639.955365274@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Schmitz <schmitzmic@gmail.com>

[ Upstream commit da89ce46f02470ef08f0f580755d14d547da59ed ]

Context switching does take care to retain the correct lock owner across
the switch from 'prev' to 'next' tasks.  This does rely on interrupts
remaining disabled for the entire duration of the switch.

This condition is guaranteed for normal process creation and context
switching between already running processes, because both 'prev' and
'next' already have interrupts disabled in their saved copies of the
status register.

The situation is different for newly created kernel threads.  The status
register is set to PS_S in copy_thread(), which does leave the IPL at 0.
Upon restoring the 'next' thread's status register in switch_to() aka
resume(), interrupts then become enabled prematurely.  resume() then
returns via ret_from_kernel_thread() and schedule_tail() where run queue
lock is released (see finish_task_switch() and finish_lock_switch()).

A timer interrupt calling scheduler_tick() before the lock is released
in finish_task_switch() will find the lock already taken, with the
current task as lock owner.  This causes a spinlock recursion warning as
reported by Guenter Roeck.

As far as I can ascertain, this race has been opened in commit
533e6903bea0 ("m68k: split ret_from_fork(), simplify kernel_thread()")
but I haven't done a detailed study of kernel history so it may well
predate that commit.

Interrupts cannot be disabled in the saved status register copy for
kernel threads (init will complain about interrupts disabled when
finally starting user space).  Disable interrupts temporarily when
switching the tasks' register sets in resume().

Note that a simple oriw 0x700,%sr after restoring sr is not enough here
- this leaves enough of a race for the 'spinlock recursion' warning to
still be observed.

Tested on ARAnyM and qemu (Quadra 800 emulation).

Fixes: 533e6903bea0 ("m68k: split ret_from_fork(), simplify kernel_thread()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/07811b26-677c-4d05-aeb4-996cd880b789@roeck-us.net
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20240411033631.16335-1-schmitzmic@gmail.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/m68k/kernel/entry.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 3bcdd32a6b366..338b474910f74 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -430,7 +430,9 @@ resume:
 	movec	%a0,%dfc
 
 	/* restore status register */
-	movew	%a1@(TASK_THREAD+THREAD_SR),%sr
+	movew	%a1@(TASK_THREAD+THREAD_SR),%d0
+	oriw	#0x0700,%d0
+	movew	%d0,%sr
 
 	rts
 
-- 
2.43.0




