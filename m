Return-Path: <stable+bounces-223134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I9hL1yVqGkLvwAAu9opvQ
	(envelope-from <stable+bounces-223134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 21:26:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5429A207962
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 21:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CB9B3021428
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 20:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ABF37B020;
	Wed,  4 Mar 2026 20:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdUgBjwd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06F2D8DA8
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655962; cv=none; b=ubVNyCfYyt5BICUKmD56wcqH8jGL9BbpNhr0TcXuXdm/+CKxU9S65HkJ/jLMAwejx89zWOk3eqHBjzcqcsNfrPQkZNkk3EryKyX/SHildMcYupskjJ/nsEfpOvn92OVdcuCQANqzAfIu5l3hq6N1OgV7SglbkYTsUHtuvDcXZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655962; c=relaxed/simple;
	bh=GvXVPVXfNIe+CvOHIGzMcEueP9gCjUo1o44+J4HtVY8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SE6KyvMXpnrUx6KNpntBHSRfN+qtR+EDo8t05WDkXouiot1GBiM2YeTQBeMsMGD2JuEVcWiZGdZbHSyL6dzkG/RW/95jADDLhfS5wtdUBsaaudX3PruY9dTC9KhEPljX5CxXmXyXxMHaJFBaCvsW2dX8/G9rLTJLeKBt0WoyC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdUgBjwd; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-124a95b6f61so84343693c88.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772655959; x=1773260759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ru2fi8pBmtRYgWThXjBxb7JS0ywhBDnYnk/WMB56o0I=;
        b=AdUgBjwdQ+P9uy+QaN3dY45FAhU82Ti7JfRZTru5DpuS7EmmGFmUGRCOzec/mPErs3
         /1NxAuPZt1VNSibwV7CCFVw2/F+8Ed/5vC99a6n1T67YysuRMWstr1+lwbTQJockjFmt
         VdQhkMOM4D8FpNV/qsHqIm50UwT25aQ6tcP0y7Xmaq0gVO2jxZcP7IO0p23gXrupLCti
         ie8GCCEShYZFdwLn9QXFMClCVQsmphWz2vApWmQjbn9gWT97+XniRDoEmtUY/oBdNu1V
         JvaYN0chRAVbMiZpSjbHbAXae6Q7RepzaUZzPptmjn49iTecv1Q0AVQsLUa4NbutQQro
         My1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772655959; x=1773260759;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ru2fi8pBmtRYgWThXjBxb7JS0ywhBDnYnk/WMB56o0I=;
        b=VemvQpuEeH9qyaBixKhNdidOoXuAlOe9euA4lf3JUfMGn1Ltxd98DhsVFzodjkQofK
         ErD9aWYKuWKoPsy06177Ox+FCrJqhhFKDTJSpCattCN4ZGh6DUHLwU8ijprn+fy2o4Z/
         ePBODEF6THVQPdnBjnVnei3IT4/IOuHB8Y9376b+6VxrUQ4wqSBWsgPGBy0BRjiyLtgT
         +Au5NKjkyvgSEBCSfOLsdPp5sthQh9LEEQT6csaYWOxWWFOYyOuTUYPydKf3j6pxeI9B
         jMmF1CybuGyLxtu/t7qHLoe3NeaOEn+brSP/QLOTRvoNEXjuusqWmWSHxEL2M8euypEZ
         evFQ==
X-Gm-Message-State: AOJu0YzWAWN5n4RSSyv2phrQXm4k5oTnkkvEwXNlrzlPRMFtVQJyM7OX
	ZMju2NC7xh5S4PChU8qwRIvM7NznTCwl7jXNOg+rZdrHnIJqPX0agqJWJ9ltG4pUwMRZgh2CIz7
	xvi5Q4+u7ZPPbQjtx84UtoRC0CtxxLRLZZ2tkSPzUfFU7tXMwA/equmor1p3jgGu12rnljlEDaS
	jmtDzZW5SFZQNJxiy7jAv7XGnAiEkkjIXK8Gcys6//3ujMMKs=
X-Received: from dlbeg17.prod.google.com ([2002:a05:7022:f91:b0:127:7897:14d])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:403:b0:119:e56b:c75b with SMTP id a92af1059eb24-128b70d5becmr1467757c88.32.1772655958946;
 Wed, 04 Mar 2026 12:25:58 -0800 (PST)
Date: Wed,  4 Mar 2026 12:25:52 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304202553.422006-1-wusamuel@google.com>
Subject: [PATCH 6.6.y] sched/fair: Fix pelt clock sync when entering idle
From: Samuel Wu <wusamuel@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, jstultz@google.com, 
	qyousef@google.com, vincent.guittot@linaro.com, 
	Vincent Guittot <vincent.guittot@linaro.org>, Samuel Wu <wusamuel@google.com>, 
	Alex Hoh <Alex.Hoh@mediatek.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5429A207962
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223134-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,infradead.org:email,msgid.link:url,mediatek.com:email]
X-Rspamd-Action: no action

From: Vincent Guittot <vincent.guittot@linaro.org>

[ Upstream commit 98c88dc8a1ace642d9021b103b28cba7b51e3abc ]

Samuel and Alex reported regressions of the util_avg of RT rq with
commit 17e3e88ed0b6 ("sched/fair: Fix pelt lost idle time detection").
It happens that fair is updating and syncing the pelt clock with task one
when pick_next_task_fair() fails to pick a task but before the prev
scheduling class got a chance to update its pelt signals.

Move update_idle_rq_clock_pelt() in set_next_task_idle() which is called
after prev class has been called.

Fixes: 17e3e88ed0b6 ("sched/fair: Fix pelt lost idle time detection")
Reported-by: Samuel Wu <wusamuel@google.com>
Closes: https://lore.kernel.org/all/CAG2KctpO6VKS6GN4QWDji0t92_gNBJ7HjjXrE+6H+RwRXt=iLg@mail.gmail.com/
Reported-by: Alex Hoh <Alex.Hoh@mediatek.com>
Closes: https://lore.kernel.org/all/8cf19bf0e0054dcfed70e9935029201694f1bb5a.camel@mediatek.com/
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Samuel Wu <wusamuel@google.com>
Tested-by: Alex Hoh <Alex.Hoh@mediatek.com>
Link: https://patch.msgid.link/20260121163317.505635-1-vincent.guittot@linaro.org
(cherry picked from commit 98c88dc8a1ace642d9021b103b28cba7b51e3abc)
[ wusamuel: Did not include line 'exec_start = rq_clock_task()', which
is not present in 6.6.y but found in mainline ]
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/sched/fair.c | 6 ------
 kernel/sched/idle.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index de205ecc1474..cdf49a04fd58 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8557,12 +8557,6 @@ done: __maybe_unused;
 			goto again;
 	}
 
-	/*
-	 * rq is about to be idle, check if we need to update the
-	 * lost_idle_time of clock_pelt
-	 */
-	update_idle_rq_clock_pelt(rq);
-
 	return NULL;
 }
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 565f8374ddbb..038fbad93655 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -414,6 +414,12 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
+
+	/*
+	 * rq is about to be idle, check if we need to update the
+	 * lost_idle_time of clock_pelt
+	 */
+	update_idle_rq_clock_pelt(rq);
 }
 
 #ifdef CONFIG_SMP
-- 
2.53.0.473.g4a7958ca14-goog


