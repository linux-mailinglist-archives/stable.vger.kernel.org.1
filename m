Return-Path: <stable+bounces-132879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B7CA90C16
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 21:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B555A30BB
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75208224230;
	Wed, 16 Apr 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFZkJa/R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ZLfOZk8"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0722222B0;
	Wed, 16 Apr 2025 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830999; cv=none; b=NZH4q9vcvBjvwHbgTPAV6+2E+hTr1Kj0BKYIz0gW6th4H6YfZ/JyUTAd/Z7L89Yk/CHn1dUQOvAUtULHFVqeZIcU3qwAr445Ps10NQiiujkpwsDJnl1bvjl/8IQlZVtPa3llfzaX859CUTKFJDqEPu1jkVVTO/L//P0hOwlzLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830999; c=relaxed/simple;
	bh=y8EOh2IdpQ87rvbk7rRX/EubUhmNFfJVyiYaxHETmIc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ed3KhQQFQsW0a4duUGeP1snsDX8kY8Ojl5Zcpfrk6gYlXfY0yzXmt+vwftW8oNOIdB7cQ2iPGLwFVaL+HRw/bkejhjBb7GKepmJjxapiqyn1nNRR3Au0EchBeROvOWqHStxgwf94jOf/DsVi6fXCPuVvK04mU1EYMkqpHvIf79M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFZkJa/R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ZLfOZk8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 19:16:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744830995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhAbYJ1PgRLBViX+3M7BU4iyIZEx4zWLuUMil1spSoA=;
	b=KFZkJa/Ru350YaFaUbC6xAEeKYugb48wdMfiHmyjfPrGaNCWM8UT4dv9d482ojktbgpKjB
	vdwvd9GGXZrmuyCOrqw9lmuxKB7MqjdNTix+eaRu9VHwxN1vCwx+uWLB00m2k7rPudCANr
	NTGrU3XyhIEmhmYmOi3BHOYHRr4oXgtwzZSUA3qeR9ZEx9KfeZy0fUCshlIDH3ERdKp8/F
	IQWhOztlCg5QBmPlClfWlTo+EeSNqRoMj8rV6xvGFpH3hvz4Ox+yxXtup/yXl9hI7nonvc
	hpR+2sVpScQXj9mB4pDTNzUgOR9hQfXWwjASBEnWqJOkyJUgEBmLw8w4ChM2xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744830995;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dhAbYJ1PgRLBViX+3M7BU4iyIZEx4zWLuUMil1spSoA=;
	b=4ZLfOZk8j3NxDKqGszV1MJrjsDosAaCsGixs1+NUlIwhuXvASr3mX3s+D1V5RGmbZZ2X3U
	IhM7yTeqaXVLcEBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Adhere to place_entity() constraints
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mike Galbraith <efault@gmx.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <c216eb4ef0e0e0029c600aefc69d56681cee5581.camel@gmx.de>
References: <c216eb4ef0e0e0029c600aefc69d56681cee5581.camel@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174483098990.31282.10026690550502878428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c70fc32f44431bb30f9025ce753ba8be25acbba3
Gitweb:        https://git.kernel.org/tip/c70fc32f44431bb30f9025ce753ba8be25acbba3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 28 Jan 2025 15:39:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Apr 2025 21:09:12 +02:00

sched/fair: Adhere to place_entity() constraints

Mike reports that commit 6d71a9c61604 ("sched/fair: Fix EEVDF entity
placement bug causing scheduling lag") relies on commit 4423af84b297
("sched/fair: optimize the PLACE_LAG when se->vlag is zero") to not
trip a WARN in place_entity().

What happens is that the lag of the very last entity is 0 per
definition -- the average of one element matches the value of that
element. Therefore place_entity() will match the condition skipping
the lag adjustment:

  if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {

Without the 'se->vlag' condition -- it will attempt to adjust the zero
lag even though we're inserting into an empty tree.

Notably, we should have failed the 'cfs_rq->nr_queued' condition, but
don't because they didn't get updated.

Additionally, move update_load_add() after placement() as is
consistent with other place_entity() users -- this change is
non-functional, place_entity() does not use cfs_rq->load.

Fixes: 6d71a9c61604 ("sched/fair: Fix EEVDF entity placement bug causing scheduling lag")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/c216eb4ef0e0e0029c600aefc69d56681cee5581.camel@gmx.de
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e1bd9e..eb5a257 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3795,6 +3795,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		update_entity_lag(cfs_rq, se);
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;
+		cfs_rq->nr_queued--;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
@@ -3821,10 +3822,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
-		update_load_add(&cfs_rq->load, se->load.weight);
 		place_entity(cfs_rq, se, 0);
+		update_load_add(&cfs_rq->load, se->load.weight);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
+		cfs_rq->nr_queued++;
 
 		/*
 		 * The entity's vruntime has been adjusted, so let's check

