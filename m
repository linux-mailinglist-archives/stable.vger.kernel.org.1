Return-Path: <stable+bounces-62462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F334993F2D4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227281C21CA4
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C591459E9;
	Mon, 29 Jul 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nMbfU+v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6+Ki79Vp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02E144D1D;
	Mon, 29 Jul 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249249; cv=none; b=Q0YdNNhzLvHc9B/e+4Q3vFrPUyBGxuVIIBfCCjPQStq/MLE7QTOfjDKsYm3yl/QLiQ0GeYBfXbo5fTj7+sWFrv0WGqeYlYGqrSwIAxFSS5OFqxEkFNSwwKZbCpEaxsdVEVhChfLplYkhOtAgIQ34A+Ci7nrBBFlWCYqhZUj/0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249249; c=relaxed/simple;
	bh=x3BOmj98U2Hr4W8bJtFsD8RY9/ZXiPmuDUB92D0dRcY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UhPv+gn3aNEtn7boe9c3qxKvYqV0ipSQTTaOUGqjtlRHU0jihBG+4Z7AYNbesocYNObcM4wKX0MYBvFA66OcjFF1dKME83VH7UWz8E+GwtMdWNMiheJg1lS3KpGfK+kc7ofI9CCSKu5VjQAId/J7onOhxMGmEesvn/Ztrt3nqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nMbfU+v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6+Ki79Vp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UezuLar63I7qBCpZdF7fVz8BCAotXGuEgkXIpn1X6r8=;
	b=0nMbfU+vbWyhnK/ULnW+Bf4LAn7w2IzeyjHsJUq2/2QUIQosjgAje21qnH2RJmAN1HLsZK
	Iq3jsICEVYaNIlvrGcSDANoCViCjAcIlVTVY0MEgivDhQzcfDN2EjheNyDq3SrrrxXcgns
	GBgy7IwWdXJBhWEua1IkXlAoFG5KRO9LVrRIlPvE2Y3CYqSVcXh5NnjFoTKepE+sZ9PTN5
	AlUkfl2gvfFXKx8+XsBAaTX05SoZqZC66AXC5fQ+LBjf0p7TMlCXxDQYIZP3IxKb9d2r83
	CKZb0c6vbvVh2auLk4OnOUE11iKqX3NLFviPrxz7S7D8xBbqqJ9tnmAiZbDELA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UezuLar63I7qBCpZdF7fVz8BCAotXGuEgkXIpn1X6r8=;
	b=6+Ki79VpQqR2RZbNfpimwKGxUw7/y3FMN/aBH+A8KfboT00ac9X8h5eg/egEKPHWRdoHmH
	L4qdHvnpYI1pCgCw==
From: "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Add clearing of ->dl_server in
 put_prev_task_balance()
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <d184d554434bedbad0581cb34656582d78655150.1716811044.git.bristot@kernel.org>
References:
 <d184d554434bedbad0581cb34656582d78655150.1716811044.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924542.2215.183295537428039900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c245910049d04fbfa85bb2f5acd591c24e9907c7
Gitweb:        https://git.kernel.org/tip/c245910049d04fbfa85bb2f5acd591c24e9907c7
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Mon, 27 May 2024 14:06:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:35 +02:00

sched/core: Add clearing of ->dl_server in put_prev_task_balance()

Paths using put_prev_task_balance() need to do a pick shortly
after. Make sure they also clear the ->dl_server on prev as a
part of that.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Signed-off-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/d184d554434bedbad0581cb34656582d78655150.1716811044.git.bristot@kernel.org
---
 kernel/sched/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0a71050..e61da3b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5801,6 +5801,14 @@ static void put_prev_task_balance(struct rq *rq, struct task_struct *prev,
 #endif
 
 	put_prev_task(rq, prev);
+
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->dl_server.
+	 */
+	if (prev->dl_server)
+		prev->dl_server = NULL;
 }
 
 /*
@@ -5844,14 +5852,6 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
-	/*
-	 * We've updated @prev and no longer need the server link, clear it.
-	 * Must be done before ->pick_next_task() because that can (re)set
-	 * ->dl_server.
-	 */
-	if (prev->dl_server)
-		prev->dl_server = NULL;
-
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)

