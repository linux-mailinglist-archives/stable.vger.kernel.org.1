Return-Path: <stable+bounces-272953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9myrMOe1T2p9nAIAu9opvQ
	(envelope-from <stable+bounces-272953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:53:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628C7327F4
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:53:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=theori.io header.s=google header.b=KAqDR++D;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272953-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272953-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1494132722DC
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B733469E0;
	Thu,  9 Jul 2026 14:31:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE130EF9A
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:31:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607512; cv=none; b=NG3duBm4pKctlL75xqf7sA48kN2x0poJliuHXLwZkZdQDvX7+ooFfjkDuvZd2zdMD7OCJl8Y+gIyMM+tdSt6D7gsfbAx2YTsncpbpXX8BENAUFawzCJmBSTYssO/n3Z/uzfvA3xB32DXYQe3k84A44AWLYNNZUFfk7chk1goAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607512; c=relaxed/simple;
	bh=05On3p09EqxlpRu9mXKpq/j8NsBvXvLIUGnDTBf8fmw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hKDbkOnWvyioydsbSLUaetBLnERHJEEHRoRtSDsIHHaR0VZLIHYAwDiEuTR9QYbLasoKqULCf84nlDh7v7Pu7kWlSvGgqiKu6lsDu9M0UM/XMqbACJvNaAWQxQ0x/reKg9hMWeb6U475YFAKmBD8F5h0oh/NhYmhQPUUNlKcbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=KAqDR++D; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso27990735ad.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1783607511; x=1784212311; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9p1GxuqzZY4yFNQHKq4itBNy6uWcDh709N3m52puSmk=;
        b=KAqDR++Dp/XjgOoIWFOLi7NoaN8Vrs+O1H5lMAWGyGlJlZOKzOGIfFxFI2H/ws3ZDS
         hGSiHEVAgEBCMg1uyDe7s7hb/Lz7cCuy3umcIjkd7wCU8megExZiAWSuZpwFupkADTDo
         RA1ksYE83KVCZqRox4x0XXg3DK01YYBJeBZGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607511; x=1784212311;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9p1GxuqzZY4yFNQHKq4itBNy6uWcDh709N3m52puSmk=;
        b=Bc3jSe+r1mDxT5VXcOZvjaJuYYepGVsi4mYzgain3yHvisT19UVPFBKb58K2Bgp2YW
         ppIoGLgJTAVDcr+TpwgFhUUDLZr4vy7tn+nFGj4MY8nqibQsM6Ir3pS3y39hfHcPyYpL
         AnFjOnecrzwlZ95sAHmwXTyTciblH/fKsqTBra0gScNKXjHEBwLpwTh2rvuOkojoUxbs
         tdMbauUfInBYEa4tQcWSnw4Oec9UzryFVcDikgYAzCFZ6XwyxCJAKR6SNu9MdoJSmUhf
         QaadujGccQKpZO2xvzdva11gHt3dgaplAZuTTJyzpb8VGsgaVkLjS/tKg9z1YE7krZXk
         UUKQ==
X-Gm-Message-State: AOJu0YxUA/EyKVsty64+YExee4NQbKgbTI3xoTdd39F7u0yhKeRnKyec
	VmFOjlXdf/vVMPqVJMFiqClazmIqaMMV1GqDPU7C7dsRZrzvo1DNDmKnmCxvH5H38vZDAHSZOTk
	jj6i5
X-Gm-Gg: AfdE7cmwgJL2ChKpURN4qdWLVaKqwcKS77JhbIYtNeQzgJs2MdjsVz/KmAszd6XzP9F
	dcZCwa7PKZYU1uieCkp+U/1a/Hid8bz1+pDHK6puDsCjS4QVUPT+UMO/vpkG2sBRHsGAW14IzPm
	G03k+iMJaJGytIUpD8oHz2K8PlgLnV2qALwBOmn0QSha0ESQ/HV+ZFmWjtyGW4KgtfgUhq+Xlxs
	yeaNaeNX9JlkJqCr5cl2RIx12pq8G3+JnuuAzDgJHmXFmprzk6loNwa3YyYMEcd1aN5h2YsljP3
	zBkPEgSk1tBsxCM0azdMa1Uf77HypPimB2gT+uoFnDEhwvp0z3BJ3rtgP8tB258McqJtH1V0/FQ
	xvPp93xR5Xb6jPSO13663OCIMA5dBSN0uWlptFQX6028QQJ150QDVTiCdPJkQNB6e4rJyllP2YH
	+PO2Qw9Irfe+8lvshkxOZxT37Ku9oszNvOC0b4RgvB103M2e/gvhNipITY1bQRvXSVmXg=
X-Received: by 2002:a17:902:c94e:b0:2c2:7baf:139f with SMTP id d9443c01a7336-2ccea4290b5mr84988685ad.30.1783607510769;
        Thu, 09 Jul 2026 07:31:50 -0700 (PDT)
Received: from Taeyangs-MacBook-Pro.local ([59.6.107.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e40sm45109965ad.75.2026.07.09.07.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:31:50 -0700 (PDT)
Date: Thu, 9 Jul 2026 23:31:45 +0900
From: Taeyang Lee <0wn@theori.io>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5.15.y] perf/core: Detach event groups during remove_on_exec
Message-ID: <ak-w0bfUlZQPbOvZ@Taeyangs-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[theori.io:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:peterz@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[theori.io];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272953-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[0wn@theori.io,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[theori.io:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[0wn@theori.io,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,theori.io:from_mime,theori.io:email,theori.io:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Taeyangs-MacBook-Pro.local:mid,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1628C7327F4

[ Upstream commit 037a3c43edfb597665dd34457cd22b14692f2ba3 ]

perf_event_remove_on_exec() removes events by calling
perf_event_exit_event(). For top-level events, this removes the event from
the context without DETACH_GROUP.

This can leave inconsistent group state when a removed event is a group
leader and the group contains siblings without remove_on_exec. If the group
was active, the surviving siblings can remain active and attached to the
removed leader's sibling list, but are no longer represented by a valid
group leader on the PMU context active lists.

A later close of the removed leader uses DETACH_GROUP and can promote the
still-active siblings from this stale group state. The next schedule-in can
then add an already-linked active_list entry again, corrupting the PMU
context active list.

With DEBUG_LIST enabled, this is caught as a list_add double-add in
merge_sched_in().

Fix this by detaching group relationships when remove_on_exec removes an
event. This preserves the existing task-exit behavior, while ensuring
surviving siblings are ungrouped before the removed event leaves the context.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.local
---
 kernel/events/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 156221bd5661..9b01cfeb3a06 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4422,7 +4422,8 @@ static void perf_event_enable_on_exec(int ctxn)
 
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
-				  struct perf_event_context *ctx);
+				  struct perf_event_context *ctx,
+				  unsigned long detach_flags);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4454,7 +4455,7 @@ static void perf_event_remove_on_exec(int ctxn)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx);
+		perf_event_exit_event(event, ctx, DETACH_GROUP);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -13024,10 +13025,11 @@ static void sync_child_event(struct perf_event *child_event)
 }
 
 static void
-perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
+perf_event_exit_event(struct perf_event *event,
+		      struct perf_event_context *ctx,
+		      unsigned long detach_flags)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = 0;
 
 	if (parent_event) {
 		/*
@@ -13042,7 +13044,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Do destroy all inherited groups, we don't care about those
 		 * and being thorough is better.
 		 */
-		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
 	}
 
@@ -13127,7 +13129,7 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx);
+		perf_event_exit_event(child_event, child_ctx, 0);
 
 	mutex_unlock(&child_ctx->mutex);
 
-- 
2.53.0


