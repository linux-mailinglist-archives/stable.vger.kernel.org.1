Return-Path: <stable+bounces-114393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A4FA2D6B6
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 15:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 123CA3A505D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09024816E;
	Sat,  8 Feb 2025 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKtWT1jG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iifu4vKi"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20591B4F02;
	Sat,  8 Feb 2025 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739026307; cv=none; b=KXdE4dhbMmCE9+DsQXz+wUHdYOSS6my+atisaQME6QIEDLi9J/28gIkkmxazaPi5a3ieJ4AodgXa3agS+WByQujsaSBYVd6NK0RsKNMwM+mdoU4Gyz0M94QQiJPEPwxmzDU47JWexej86iA5EToAthygdAGbuZitr13TH1iboPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739026307; c=relaxed/simple;
	bh=ht22R3+ZnZ+yBurQyHZdZ8pB4y4b5dzqaCEHfSSQ/t8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ptQ5UOoc2ZbEpd1A1ziJht2JMXSWENH8+jAXzPDW/Ut3Jh0LhUVdxB3R6EMt8vryKT5WxJ/5cSy+a6WuuV9nXWEJ/p7HjW1nsCxC+YD3ONhV+A2dk2IyN767YxZE8BFqf3ovFdPWdVOMG8E+Su8pdkNGXUMyTC/KRxxvxGx9c2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKtWT1jG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iifu4vKi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Feb 2025 14:51:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739026298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPF7beo2CSEA4OCRIRH5C/hs0qSpYn30Ezbs7pcb8G0=;
	b=wKtWT1jGFqqoCO9VdM8QDr0e8KcjAm/jHWq04mUTi0bvyqBydWEuVI0z0xRjAtJjrMUTi5
	R0THeIcrvum8AuwCZjRbn5F06SirgYST9mJItm/XtkntTXBmLB3skAWkRK+ddZx20P8KCJ
	dTQEwAXh/EFXfEdReVGkn5Aslx02syanKOIwLfHAOd0zUA90jtzVNAm8llk3zMXSM/Nu7G
	+oEx/NeA0Pg8K/zsT9hOhU6LxlTv18BsvngX3oynwOj7RybfgVEXD4XfBL5DyfRGS5lVyl
	L7tR4aubaGIcosDS/wnUfWLd0sezaMlA4AXeJu4rQT3TfwLNdYolmHJFozI2/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739026298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPF7beo2CSEA4OCRIRH5C/hs0qSpYn30Ezbs7pcb8G0=;
	b=iifu4vKiYU7rdYWklD9/tYOV3rSMO8bZEO/6dqp1uKzLicP1AoO9gVXfrCD26EVhY/QX5m
	op0coz15Bv3akUBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Adhere to place_entity() constraints
Cc: Mike Galbraith <efault@gmx.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250128143949.GD7145@noisy.programming.kicks-ass.net>
References: <20250128143949.GD7145@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173902629450.10177.17446372607519992642.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     55294004b122c997591d9de8446f5a4c60402805
Gitweb:        https://git.kernel.org/tip/55294004b122c997591d9de8446f5a4c60402805
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 28 Jan 2025 15:39:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 08 Feb 2025 15:43:12 +01:00

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
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20250128143949.GD7145@noisy.programming.kicks-ass.net
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f4e4d3e..d0b10e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3782,6 +3782,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		update_entity_lag(cfs_rq, se);
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;
+		cfs_rq->nr_queued--;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
@@ -3808,10 +3809,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
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

