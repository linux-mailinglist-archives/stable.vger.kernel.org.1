Return-Path: <stable+bounces-119408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7FA42BA2
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E181179723
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3337266576;
	Mon, 24 Feb 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mUc4jY4r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sltbqph7"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B81266572;
	Mon, 24 Feb 2025 18:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740422203; cv=none; b=cnTj4hMiw/2P5ykqDu8JjGK1bZ9H1Dsb0mvBJef6gLA6fFZeBfUesBkUnWk3ig241FJ/0F+wRUbggwH9Zv3vvO8C5Q0I553PmgdScq9GS0WwwAeza72MckCq8L2DUftSbTBcQkVmyWuVjeObfChEbj6WnzD3Ka5n1gvKNklBoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740422203; c=relaxed/simple;
	bh=0OOQOk1ZnJvAAWZOrlMhlnGqbC5S/BxglUYn7c+m+7Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lxbDxFU8SETGxi6GuAb/H+bMNtSt+2DdIDIVRLBf/EgoHZHepqDaOcsJlcI2YcZzV8VquOQw9PJuiVb+XlYxmp2T6HnzKR0TOpBgpUWTEZlFF+M4Xj6OlFoy+Z19GKPEGxlC0pLIOCxThNSDzfSxv9J+cNgDSxM28V+WWX+3YRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mUc4jY4r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sltbqph7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 18:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740422199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YdY6dX/V8XAG25x3F3g6c2bm9h3Ih0E7bzan2RKkkM=;
	b=mUc4jY4rZlEve/sGKYtuYEhibivr3XdOykuoMj05jRIRK3wkBARqJ3CPRc3HEobFCakiYn
	luyU8js7FzbbI95WSeOqt3xgNINA3r+b5vVi4qCU97S6NT94fhjpHmpqtxb/6MxzS35LNJ
	rJkWRcOliZxAgni1rKqE+gYK1oXMm+TIW+5xJJakU8IdrSbpR0YSKaFzkXZ9VcsUmVqCI6
	lAkUiBkWv+KAmElAYbfIVXrdajonsBEzWo+UjUVvP0g8FzFQXJO25FoFo11pTdLhgl/MAs
	cqVIZhIzjTO1DLMvjobZWjfjFa4/nhaYnU3mWWi2QtVvmSYsUwvtu1RZlOakbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740422199;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3YdY6dX/V8XAG25x3F3g6c2bm9h3Ih0E7bzan2RKkkM=;
	b=Sltbqph7mWmNONlnPt6QCI6u6ZVmesTz+yVNmKLcLKlX8hJOnxXpctVMgFYkUkM6JeQswS
	kwnLxgmJFJ56k4Cg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Add RCU read lock protection to
 perf_iterate_ctx()
Cc: Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org>
References: <20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174042219873.10177.3901726341080483847.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0fe8813baf4b2e865d3b2c735ce1a15b86002c74
Gitweb:        https://git.kernel.org/tip/0fe8813baf4b2e865d3b2c735ce1a15b86002c74
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Fri, 17 Jan 2025 06:41:07 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2025 19:17:04 +01:00

perf/core: Add RCU read lock protection to perf_iterate_ctx()

The perf_iterate_ctx() function performs RCU list traversal but
currently lacks RCU read lock protection. This causes lockdep warnings
when running perf probe with unshare(1) under CONFIG_PROVE_RCU_LIST=y:

	WARNING: suspicious RCU usage
	kernel/events/core.c:8168 RCU-list traversed in non-reader section!!

	 Call Trace:
	  lockdep_rcu_suspicious
	  ? perf_event_addr_filters_apply
	  perf_iterate_ctx
	  perf_event_exec
	  begin_new_exec
	  ? load_elf_phdrs
	  load_elf_binary
	  ? lock_acquire
	  ? find_held_lock
	  ? bprm_execve
	  bprm_execve
	  do_execveat_common.isra.0
	  __x64_sys_execve
	  do_syscall_64
	  entry_SYSCALL_64_after_hwframe

This protection was previously present but was removed in commit
bd2756811766 ("perf: Rewrite core context handling"). Add back the
necessary rcu_read_lock()/rcu_read_unlock() pair around
perf_iterate_ctx() call in perf_event_exec().

[ mingo: Use scoped_guard() as suggested by Peter ]

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index bcb09e0..7dabbca 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8321,7 +8321,8 @@ void perf_event_exec(void)
 
 	perf_event_enable_on_exec(ctx);
 	perf_event_remove_on_exec(ctx);
-	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
+	scoped_guard(rcu)
+		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
 
 	perf_unpin_context(ctx);
 	put_ctx(ctx);

