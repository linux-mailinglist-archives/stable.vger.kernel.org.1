Return-Path: <stable+bounces-115544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A40A3449F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1F61893F64
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E526B0A5;
	Thu, 13 Feb 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iUm2UMjx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58926B083;
	Thu, 13 Feb 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458420; cv=none; b=WHP0D7sLCONu+kWv2tRrfjFdYh0uC3Z33++jU1F7nRjUqJGCfUcGQUYb+6BVUN5GriuLWBxA+R6WZfLZqnjR2zJXMbyrspq1OqZAWa/0+oaj48mobb7+HESNGRM7ZjS2U7slZF6roCrHVBvzvJZEVqela2228BI5EC/fvvBbOSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458420; c=relaxed/simple;
	bh=aAwrVDvSFpjFnJjyBdgGlVLCC2tb3vwp2dmjP6IgMVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxMZCKafxXXwQsU/HIUIvlTjKCwqpqO5PL62+afh3wJWmKCG5mQVviFXCOnAIwHWb17IIB3iKZ2Uf9AeT2oTs+lWnEA5JQYXy2ENzNDZuKn1OE71bbPZ2lRdtMolJ7PqjQWAMfOGoYc1esLz3RR7wclz70oX4vElpzH/jsHn+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iUm2UMjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFABC4CED1;
	Thu, 13 Feb 2025 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739458420;
	bh=aAwrVDvSFpjFnJjyBdgGlVLCC2tb3vwp2dmjP6IgMVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUm2UMjxS+qympQAESVK3GEGn+5BRkDDfG+Bkv8NaufCFvNRXaWcSUxJFDuKzUCpR
	 pezdrWLzGO6A1kza9FMWcjIgPT62qGq+Ow23gJ6Mx6APkhnQ6CG+AgSqcIzzR9TRbG
	 2iTJhRLmk0RJ8DpFDoz5HxIxIfrgQ87lYIYSpqnM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Fleming <mfleming@cloudflare.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 6.12 394/422] timers/migration: Fix off-by-one root mis-connection
Date: Thu, 13 Feb 2025 15:29:03 +0100
Message-ID: <20250213142451.751396434@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142436.408121546@linuxfoundation.org>
References: <20250213142436.408121546@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <frederic@kernel.org>

commit 868c9037df626b3c245ee26a290a03ae1f9f58d3 upstream.

Before attaching a new root to the old root, the children counter of the
new root is checked to verify that only the upcoming CPU's top group have
been connected to it. However since the recently added commit b729cc1ec21a
("timers/migration: Fix another race between hotplug and idle entry/exit")
this check is not valid anymore because the old root is pre-accounted
as a child to the new root. Therefore after connecting the upcoming
CPU's top group to the new root, the children count to be expected must
be 2 and not 1 anymore.

This omission results in the old root to not be connected to the new
root. Then eventually the system may run with more than one top level,
which defeats the purpose of a single idle migrator.

Also the old root is pre-accounted but not connected upon the new root
creation. But it can be connected to the new root later on. Therefore
the old root may be accounted twice to the new root. The propagation of
such overcommit can end up creating a double final top-level root with a
groupmask incorrectly initialized. Although harmless given that the final
top level roots will never have a parent to walk up to, this oddity
opportunistically reported the core issue:

  WARNING: CPU: 8 PID: 0 at kernel/time/timer_migration.c:543 tmigr_requires_handle_remote
  CPU: 8 UID: 0 PID: 0 Comm: swapper/8
  RIP: 0010:tmigr_requires_handle_remote
  Call Trace:
   <IRQ>
   ? tmigr_requires_handle_remote
   ? hrtimer_run_queues
   update_process_times
   tick_periodic
   tick_handle_periodic
   __sysvec_apic_timer_interrupt
   sysvec_apic_timer_interrupt
  </IRQ>

Fix the problem by taking the old root into account in the children count
of the new root so the connection is not omitted.

Also warn when more than one top level group exists to better detect
similar issues in the future.

Fixes: b729cc1ec21a ("timers/migration: Fix another race between hotplug and idle entry/exit")
Reported-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250205160220.39467-1-frederic@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/time/timer_migration.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1668,6 +1668,9 @@ static int tmigr_setup_groups(unsigned i
 
 	} while (i < tmigr_hierarchy_levels);
 
+	/* Assert single root */
+	WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top]));
+
 	while (i > 0) {
 		group = stack[--i];
 
@@ -1709,7 +1712,12 @@ static int tmigr_setup_groups(unsigned i
 		WARN_ON_ONCE(top == 0);
 
 		lvllist = &tmigr_level_list[top];
-		if (group->num_children == 1 && list_is_singular(lvllist)) {
+
+		/*
+		 * Newly created root level should have accounted the upcoming
+		 * CPU's child group and pre-accounted the old root.
+		 */
+		if (group->num_children == 2 && list_is_singular(lvllist)) {
 			/*
 			 * The target CPU must never do the prepare work, except
 			 * on early boot when the boot CPU is the target. Otherwise



