Return-Path: <stable+bounces-272952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u3PXAe2yT2rbmwIAu9opvQ
	(envelope-from <stable+bounces-272952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:40:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 715A5732619
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 16:40:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=theori.io header.s=google header.b=Q374bovC;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272952-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272952-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B471D30F0276
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3D372EE0;
	Thu,  9 Jul 2026 14:31:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC5386C39
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 14:31:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607463; cv=none; b=s2KTFlb7vsvRzGKndbPXQqXTCUpV+AXSOpRLI2jE8/GzHswD9NGu6DmU74PADFXPu/QntID/AZ8w/b7JXGMulxdSpsvg/vqHGxGkxC9TmnWC564iMpOUEOR/qqVkGAHj5DWVbmq3JAh0epTh731OzDZdwEvJyId01P/amFIhQXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607463; c=relaxed/simple;
	bh=D1fvNbWJq1nLxdtzh96UTvXxrstj/gniXjlroYPkK4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HPcyDOUIEBbvrRved59gTTtyqTIrbywzKcJjdfFaZRUrHd3shOHQJdPtHpWkba8uAydgarxuI+H0GhVFO8HPwoxN7scW5CkLlCVFytXPfqdy80JdW9Jwfy6+xVZ4MDpdfh/LfhrK4MUa+8MMikTm5x43cThbYXTXYNgiL/FGFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=Q374bovC; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso2315844a91.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1783607462; x=1784212262; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p+ei05RjfHBetZdQUsfTUdmM59Mc8F5BV6C3xY70MZE=;
        b=Q374bovComolrT+JFvGtYGlpI7gdOhgMRxEIVizwng4E6umksEcY4OUZhcdx911PHz
         DqT4QtD3V0MxTUUaAFjotn7tuZlcu7aF7iJI52DN6wlgFDLh/EEgZnzmRHwqLDk+OPIj
         dVSUFdMpXM+k77U9FqF+oOxmwVRqDewommNfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607462; x=1784212262;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+ei05RjfHBetZdQUsfTUdmM59Mc8F5BV6C3xY70MZE=;
        b=lcza5Cxij5RV4sC0KqSpbksGoUlIMCKvKmu80cfCbPi06LUeear3Gl3yc8NuX39bYM
         NG4WvCzoarUPti+8M1Vad5s5YlOkfTrDRNvAh+aI3AzyuLue28FqfZrDsBY3DJ6fcrsa
         3mlO4hUVYnqoAyrUQuknwaIv8HNbwqLjsATrc6rhw76SreCWBHhflL2Zf/1odE8Q/3WF
         DjqrdEtuwCSllzplEbft00Nvwew1p68JKMhCjCs/lqb0LuzHQ2PWFo2uwyjaS23vZohp
         eORLi0uKPSiAjFrpTw4cPL+iDgijYrKXgLGoB2cPFzSRTDx15yYs1km99tNpVuPbxID1
         2agw==
X-Gm-Message-State: AOJu0YzfFCSHDenhNZFy7aF/BXOO4GLSfUzTqgXaumyZxoYTUcHLyah3
	xbbfLP1gYigS6VDDL6cprAdVAhaQo3kbz+sYmRWIkEfzY/R7ad95A89gPHzo/xBdlZ+W3VxBHa8
	LVI5L
X-Gm-Gg: AfdE7cnGGEKogZUI10VthrWIRlMf/uWRswVOK14TKIVlYvCOn5kMuL3HyVYnyPtT3CP
	PVFsZNKiQ7CatclfNAkJx+cll9GAO59JPkVwyez1K1vgwBQgnQ9VtV7hemDF3UnyIDh77Hl/LDi
	vZWvqT8IcRCL7hcTSfc/xmqgcuJZ/s178L+fdUHpupkGKnCyP3Bn3ztyHpf3zLyLoCEWPqEPBA0
	4ZbPnOwfLsItZOncO5kQQfdJi9+OrbQh3f4r+kDhsr6lRXzGWlERyzmCfOKp8YUEnBlLZW0HxHZ
	8q57Tcen/usWo97Ss6ECtR0qk1E2KkZhfJFKLe+u/eyjIsmA52FjvQiRmhHZFpAyFW9fYuAn47q
	7yb9HTwIe5O+ZxUmWw7wWaYyihiRUdKOgPnHAtsuHXMTgedDNKpMFSpgkYF5Lt8C0RZGFfYf+9h
	dsMF4D07GPQNmpQRx7Q46aiVa5WSP0WQd+trFVVywsBhZ2N0ZlYatmr04kfo4qwBkR6VU=
X-Received: by 2002:a17:90b:4d8d:b0:381:85c0:1d9d with SMTP id 98e67ed59e1d1-38942f7356emr7821127a91.27.1783607461693;
        Thu, 09 Jul 2026 07:31:01 -0700 (PDT)
Received: from Taeyangs-MacBook-Pro.local ([59.6.107.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-388fe18189dsm1578223a91.2.2026.07.09.07.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:31:01 -0700 (PDT)
Date: Thu, 9 Jul 2026 23:30:55 +0900
From: Taeyang Lee <0wn@theori.io>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 6.1.y] perf/core: Detach event groups during remove_on_exec
Message-ID: <ak-wn3UG8TES8Lrq@Taeyangs-MacBook-Pro.local>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:peterz@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[theori.io];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272952-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[0wn@theori.io,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[theori.io:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[theori.io:from_mime,theori.io:email,theori.io:dkim,infradead.org:email,Taeyangs-MacBook-Pro.local:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 715A5732619

[ Upstream commit 037a3c43edfb597665dd34457cd22b14692f2ba3 ]

perf_event_remove_on_exec() removes events by calling
perf_event_exit_event(). For top-level events, this removes the event from
the context with DETACH_EXIT only.

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
event. This preserves the existing task-exit and revoke behavior, while
ensuring surviving siblings are ungrouped before the removed event leaves
the context.

Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/ai65GgZcC0LAlWLG@Taeyangs-MacBook-Pro.local
---
 kernel/events/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 146b37e97832..1478bad56e40 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4334,7 +4334,8 @@ static void perf_event_enable_on_exec(int ctxn)
 
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
-				  struct perf_event_context *ctx);
+				  struct perf_event_context *ctx,
+				  unsigned long detach_flags);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4365,7 +4366,7 @@ static void perf_event_remove_on_exec(int ctxn)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx);
+		perf_event_exit_event(event, ctx, DETACH_GROUP);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -13055,10 +13056,11 @@ static void sync_child_event(struct perf_event *child_event)
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
@@ -13073,7 +13075,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Do destroy all inherited groups, we don't care about those
 		 * and being thorough is better.
 		 */
-		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
 	}
 
@@ -13158,7 +13160,7 @@ static void perf_event_exit_task_context(struct task_struct *child, int ctxn)
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx);
+		perf_event_exit_event(child_event, child_ctx, 0);
 
 	mutex_unlock(&child_ctx->mutex);
 
-- 
2.50.1 (Apple Git-155)


