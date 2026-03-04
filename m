Return-Path: <stable+bounces-223135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAoPK2GVqGkLvwAAu9opvQ
	(envelope-from <stable+bounces-223135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 21:26:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1600D207969
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3830300BDBF
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 20:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AE371873;
	Wed,  4 Mar 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbwyTci/"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C032D8DA8
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772655965; cv=none; b=YcaBT6hM9t1kUHd9O6leBtO0VzGJ+NHjZYdH0utBquTxSZxfgbGvDC9FcdVt+xuclDIzcRjJCOotjAxc3FymmFT3fTptIqr11L75K40VvS8N1d4r9W79La9TJHBzo23ul9rz/FMT5dYqmIPj4i4iaGV1sHd2rj8hMQ9AyVR50ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772655965; c=relaxed/simple;
	bh=+ItbB7NDyrIV2taj54G4JuoELcuuQS3QkcHXJgRLNnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkiTHuJQz4QYF7lRZvFoBIUZ8bbem92SGTjZM82MDhf3w4SfgPGqD9oF4ZHSjVW7Q4ueCjpnUOKnfNi//tO9jEfIhefuCYSjC6eQbjBn0T0fdYM2eJXzyh7J6RgPP7mLmyyNlPL/ObMi7mKmNNHjlBdLLMKy1swRpzY3ZaIe4bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbwyTci/; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2be07cafe1cso52553498eec.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 12:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772655963; x=1773260763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVKrtXTgYHIR6AJbdUS5WD5LzV68UFDB3oM3B6ETWfQ=;
        b=mbwyTci/qVmNJFPH+T8rBn7D+IYmJe0k6z8k6rITQ3ACHQ9KJaZB4hWr5XKChSU9Rc
         4J8ELgH2+v46Um4vpS1pk7kNOIXD+s0iVG4kjN78UHxSAVeip3B96AJj4qTOd8LayjRq
         P8oZocT8auvDUAyQkoNJs/EiTHT3v7AURELAXFAfJjxeDYV/PD7vHSmqJGGRFcKK6yVy
         CGufd0PTAJNVIbB6iCQpqgJsFeu5jKpASZh0RnDIR98SS6na+4sikZIt056dhsiVEA62
         2JfTwrlRxmodmRlvgb6whNE6oOAbI+fHFGhg7uMln4Luk/c5ebK71231UMw/5opFig+a
         Vpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772655963; x=1773260763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVKrtXTgYHIR6AJbdUS5WD5LzV68UFDB3oM3B6ETWfQ=;
        b=gS0TqIA8ALjS40Vo5SbJjSXb9dNgs9l5xAn027sEDSSfywbuHY9J0demdsDXmYDDJu
         c6oPiXQWphN+XccIfyjdlO4oRfO1o3Nu0gN621QYja60gr55VGl0d6o4PjCICeUGE5AQ
         f5aPmctudxa1zgkbUQfaEqfeqvDrQHUqI2mpI06+hNMjEop8RYX/YHTU52CzX2/69HY0
         M1EE/+m9KZZ+N7/P2NAmtfo+PBUViJCytr5j1rmsUwdaKjrG6feZAorN+Ml6rLxAOv5J
         x/P2RXwj3eeGhtRujDc6DicaEFot07zlziXa6KQD/btiIdolSceIiOe69pKsy8V5boav
         rl3A==
X-Gm-Message-State: AOJu0Yyuj1amqmKdCB2gKk5IJ/vV1pWLnBfHyrCjjhhT7VrcRJFLLQtv
	N4SNmFEtxrJiSb+9h4vX51mWPj6pOHrvpSHsU7Ofg0Ww3wWpnHSsscyYsa8BD1cGtlm/XI+wM3r
	rv8LxcidTqi9KY6EP2D2w1130xYjlXS3g7aMQsrJWqKSgEXGJ2iypFkKlYFR9+02guQJ+q3Mqbh
	F1hFc1pRu/y1MObJelKEGRjnwbN21JM0Y2SWh98oHuYCOZDr4=
X-Received: from dybsl12.prod.google.com ([2002:a05:7301:730c:b0:2bd:fcea:a76f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:2f88:b0:2bd:c8d3:a084 with SMTP id 5a478bee46e88-2be30fd21cemr1345457eec.12.1772655962619;
 Wed, 04 Mar 2026 12:26:02 -0800 (PST)
Date: Wed,  4 Mar 2026 12:25:53 -0800
In-Reply-To: <20260304202553.422006-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304202553.422006-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304202553.422006-2-wusamuel@google.com>
Subject: [PATCH 6.1.y] sched/fair: Fix pelt clock sync when entering idle
From: Samuel Wu <wusamuel@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, jstultz@google.com, 
	qyousef@google.com, vincent.guittot@linaro.com, 
	Vincent Guittot <vincent.guittot@linaro.org>, Samuel Wu <wusamuel@google.com>, 
	Alex Hoh <Alex.Hoh@mediatek.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1600D207969
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223135-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,infradead.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email,msgid.link:url]
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
is not present in 6.1.y but found in mainline ]
Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/sched/fair.c | 6 ------
 kernel/sched/idle.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9f7c9083e9bf..376d835ca7b4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7924,12 +7924,6 @@ done: __maybe_unused;
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
index 200a0fac03b8..6e76dc83a345 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -435,6 +435,12 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
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


