Return-Path: <stable+bounces-95992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38F9E0028
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226DA163655
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B8620A5F1;
	Mon,  2 Dec 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d/NE3xh4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L61ekjXh"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3C209F59;
	Mon,  2 Dec 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138095; cv=none; b=E/NQIrjZw7VDj5V+HuTdRSCatPcZwnSjtvQmf01LL4wxW7qprXM4J77GZkjUqqQbBCCImr0PDGTJ21SG0nyvoHeie0qj/fDn92XY291vrfojdhMDpg7TgU8OF48fRS3Sj8fyz6UALwKEt21WRFbHiTkErXCYfECauLAKVfHEYLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138095; c=relaxed/simple;
	bh=V62em5H/34Oo3SVQBtNzc5AU4WFh+wT/ZGeUsM1Tyi8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G5u5RKZFeKcfHFEc68xtlvSWS06g7J6iBJU7SVbnNdt7qRVM3paY+rIkmDKhiim9Wk1G6j8tcX8PJXzG0cQc4UzMPgSNrN0iUCgS9/IJzOnpcescIB/JIcKD7apdKj4qkAPEuClsYV2/tLtiBceJLQ8Wczw0Kezs8zA5EQO5ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d/NE3xh4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L61ekjXh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cl/Wn6QrssvrdyHG8pwYU3rq9vhIyV6DTCxQrLsB2nI=;
	b=d/NE3xh4dXm+0I87rJCKIbG/4sTAtFcVpjUR3+dz1N2N6dqbie7y4mgA/S/CSvQEJs98+q
	Nydh06LwDjE2IWn0ttxn+bWWtta3W7BkZ7YlTknAKUqht+3qx437Yig+IhaJFcNn8d32Ls
	JQO/V8f9HOP02kdZsm2dXpdYvHEMeKvvfjLJBOk/ph94/EzqxRhBKF2iL9BnDwoG9DxutN
	W3+sYoh2JxbD5514oDx/EEy5V+NVMnP9/DmHCxatGn/Gn9rsOtIzWdP6cMyN69as2d4N/e
	GZ1qit8HOtW2d1BrA0+7IuAUASp3Cn04mLl7ty06bwrSpbv8gKvXXCfDbJDlyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138092;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cl/Wn6QrssvrdyHG8pwYU3rq9vhIyV6DTCxQrLsB2nI=;
	b=L61ekjXhsm6JiU/kwWj2G44c3SVrXkzEg7xK8U1PUkWM4Gf5CPqiGBdw10VEttrrsBKIPp
	IM9bQCzoXBu4xdAQ==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix replenish_dl_new_period
 dl_server condition
Cc: Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241127063740.8278-1-juri.lelli@redhat.com>
References: <20241127063740.8278-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313809175.412.2278722733257226756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     22368fe1f9bbf39db2b5b52859589883273e80ce
Gitweb:        https://git.kernel.org/tip/22368fe1f9bbf39db2b5b52859589883273e80ce
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Wed, 27 Nov 2024 07:37:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:27 +01:00

sched/deadline: Fix replenish_dl_new_period dl_server condition

The condition in replenish_dl_new_period() that checks if a reservation
(dl_server) is deferred and is not handling a starvation case is
obviously wrong.

Fix it.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20241127063740.8278-1-juri.lelli@redhat.com
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d9d5a70..206691d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -781,7 +781,7 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	 * If it is a deferred reservation, and the server
 	 * is not handling an starvation case, defer it.
 	 */
-	if (dl_se->dl_defer & !dl_se->dl_defer_running) {
+	if (dl_se->dl_defer && !dl_se->dl_defer_running) {
 		dl_se->dl_throttled = 1;
 		dl_se->dl_defer_armed = 1;
 	}

