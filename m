Return-Path: <stable+bounces-220180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONx0Nccso2me+AQAu9opvQ
	(envelope-from <stable+bounces-220180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2791C5491
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F91F32A3D3B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E780E4BC020;
	Sat, 28 Feb 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGtHXMF2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99384BC015;
	Sat, 28 Feb 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300087; cv=none; b=t16QyI4J8h4AzWrbPL1PrKwxwYoUQL8SPckV+Eg3ihBrHmUMLSh5qZNVLRI/8Kh4AzdHnNGzqkjvgibHIa563wNZiIA6nh2omTTXpLgG8qrN37VhuMPiLK+d43XsqoBKojoP7CcKVgSvqAAQW4hKAe2GMirhVQKwNmjcZMoJI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300087; c=relaxed/simple;
	bh=kvUMyJMY36JwN472Kvu7Uo2pNYLuOdV0dgpV5Exx4wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJL1IFc1yAylqM7iwjzZJSRZELQsyJ4nE/NewgkSoadOCj4MCuN1eAqu8JjPj7C3835xg7NJJCid7zB7qDdH4QjkPYJh/rgOdtNIoI5xbYtTHLSg0A9WBL38jjQGu2hFFT7MJl3qqB2BiCCfwdX+m3QMl618HqepxiXKbJW4VrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGtHXMF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC517C19424;
	Sat, 28 Feb 2026 17:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300087;
	bh=kvUMyJMY36JwN472Kvu7Uo2pNYLuOdV0dgpV5Exx4wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kGtHXMF2OmMk+11Y9LjlvuAXgCJ2nEWMvV6ob7qq0tq+cp0jAUciiynKtGVa6nEFD
	 gbDqZtJyOsN52eBtgICW69vAsPpFhDiZ/2iOgElwDnE5+EhZgg2JGBLpxf0YHCcq0+
	 nclgSRMUaxSsKzj3xQH5AWycAefMJ0Gd/Xx3G4VlqsLG65O4Wo6rBrwMZzrjzSKdaa
	 Z0B03dCeU1Pv4U28ZybH7d0AW+Ni9D5fj/3m/Dh5mlD2MMiikfkC+TV4o9Oi+ZbO12
	 FxZtW49aLUOh1EM/mhFGYsREBuc+5DjdrP4ukx+GjvQ368mKTf0VaRrMhhFhCbUVkE
	 eoqY+Z0X84CgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>,
	Rosalie Fang <rosaliefang@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 102/844] perf/core: Fix slow perf_event_task_exit() with LBR callstacks
Date: Sat, 28 Feb 2026 12:20:15 -0500
Message-ID: <20260228173244.1509663-103-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220180-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email]
X-Rspamd-Queue-Id: 7B2791C5491
X-Rspamd-Action: no action

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 4960626f956d63dce57f099016c2ecbe637a8229 ]

I got a report that a task is stuck in perf_event_exit_task() waiting
for global_ctx_data_rwsem.  On large systems with lots threads, it'd
have performance issues when it grabs the lock to iterate all threads
in the system to allocate the context data.

And it'd block task exit path which is problematic especially under
memory pressure.

  perf_event_open
    perf_event_alloc
      attach_perf_ctx_data
        attach_global_ctx_data
          percpu_down_write (global_ctx_data_rwsem)
            for_each_process_thread
              alloc_task_ctx_data
                                               do_exit
                                                 perf_event_exit_task
                                                   percpu_down_read (global_ctx_data_rwsem)

It should not hold the global_ctx_data_rwsem on the exit path.  Let's
skip allocation for exiting tasks and free the data carefully.

Reported-by: Rosalie Fang <rosaliefang@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260112165157.1919624-1-namhyung@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8cca800946248..69c56cad88a89 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5280,9 +5280,20 @@ attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
 		return -ENOMEM;
 
 	for (;;) {
-		if (try_cmpxchg((struct perf_ctx_data **)&task->perf_ctx_data, &old, cd)) {
+		if (try_cmpxchg(&task->perf_ctx_data, &old, cd)) {
 			if (old)
 				perf_free_ctx_data_rcu(old);
+			/*
+			 * Above try_cmpxchg() pairs with try_cmpxchg() from
+			 * detach_task_ctx_data() such that
+			 * if we race with perf_event_exit_task(), we must
+			 * observe PF_EXITING.
+			 */
+			if (task->flags & PF_EXITING) {
+				/* detach_task_ctx_data() may free it already */
+				if (try_cmpxchg(&task->perf_ctx_data, &cd, NULL))
+					perf_free_ctx_data_rcu(cd);
+			}
 			return 0;
 		}
 
@@ -5328,6 +5339,8 @@ attach_global_ctx_data(struct kmem_cache *ctx_cache)
 	/* Allocate everything */
 	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
+			if (p->flags & PF_EXITING)
+				continue;
 			cd = rcu_dereference(p->perf_ctx_data);
 			if (cd && !cd->global) {
 				cd->global = 1;
@@ -14294,8 +14307,11 @@ void perf_event_exit_task(struct task_struct *task)
 
 	/*
 	 * Detach the perf_ctx_data for the system-wide event.
+	 *
+	 * Done without holding global_ctx_data_rwsem; typically
+	 * attach_global_ctx_data() will skip over this task, but otherwise
+	 * attach_task_ctx_data() will observe PF_EXITING.
 	 */
-	guard(percpu_read)(&global_ctx_data_rwsem);
 	detach_task_ctx_data(task);
 }
 
-- 
2.51.0


