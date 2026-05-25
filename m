Return-Path: <stable+bounces-254219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONqUDTG7FGo2PwcAu9opvQ
	(envelope-from <stable+bounces-254219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:12:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA39D5CED2E
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 23:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13F5330067BF
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 21:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB6738E5C5;
	Mon, 25 May 2026 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LT5nHIVC"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDA8380FFB
	for <stable@vger.kernel.org>; Mon, 25 May 2026 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779743534; cv=none; b=AhHTfLfPJM+IkGQDc/Zb6IYtYZvl2yd/zZ6ym0VVJKvaqFgUR21QuJHGVTtqar8dJKL9UH5A26MDMHu3i3Lw7UuUBXsBv6lmoOjCR8sN6qj3y3+wR421tFQtg+8vY3njCIihcTbttd9mPCjJaMcp/ZStC9p8MNWLTtJC+hM30i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779743534; c=relaxed/simple;
	bh=c6T2J9DdMETqvNYoT439/Xr2GoYTghZ4p+Xgq3iMJUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urhQdIdhRU9h0pIMCmTZQyA16ocDioGoTxA22FykYQdCZ11xHkgNtRW/c/rrvXOHKxCQj0Su6IVEHgCr9EkvAdGIIpjWlUcFoEs6RXJezosnDbxVe9rUEHS0QriBDynfcT/FFwysMUHDMEBnMbX6YpzreFa5svTQbnhZeyDZ8Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=LT5nHIVC; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gPT930Ylhz9v7f;
	Mon, 25 May 2026 23:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779743527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SdHZ1/QZV4K86ONnhgJYT2EUyqkKekvpILnNH56rFM=;
	b=LT5nHIVCcqsQQUUmSfv2UnXADjTeUVCJ8L9DFa9/zND+76gbuWwDfnxOqy2fJ8enCeiRhb
	TX172oi56ipWnkTJFUq8OFuQuaOzyJWdE0JsbhRZAEX+i23MzSgBBuyPVyS9Wgl3Q1b7h4
	kxt4Gl6MlZyCBQi5WW0JszgcaR8EqCSrvbO6pKmuDemEGQ7eO2Ybb79Tn0Oi0sK6oLlsSs
	33L0qOOHzCPfybaxphCVy4WdKFy58qY2pdr7D9JQ/w7LTRI6R/SQKWWF7T5PpTccaqMLp9
	Me9+nQ4XbgwmrHl0IvN2n6OOoTfUlpbeVo1JfZjUd138w8+6n/uE7xamDZfqKg==
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	regressions@lists.linux.dev,
	Mike Galbraith <efault@gmx.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 6.12.y v2 3/5] sched/deadline: Always stop dl-server before changing parameters
Date: Mon, 25 May 2026 23:11:15 +0200
Message-ID: <20260525211117.630141-4-lbckmnn@mailbox.org>
In-Reply-To: <20260525211117.630141-1-lbckmnn@mailbox.org>
References: <https://lore.kernel.org/stable/20260522213120.1205100-1-lbckmnn@mailbox.org/>
 <20260525211117.630141-1-lbckmnn@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: swekwpyatuoa9ioapz3xe651747ddtrq
X-MBO-RS-ID: 84add5a6cc2d7addb78
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmx.de,infradead.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254219-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lbckmnn@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,mailbox.org:mid,mailbox.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: CA39D5CED2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Juri Lelli <juri.lelli@redhat.com>

commit bb4700adc3abec34c0a38b64f66258e4e233fc16 upstream.

Commit cccb45d7c4295 ("sched/deadline: Less agressive dl_server
handling") reduced dl-server overhead by delaying disabling servers only
after there are no fair task around for a whole period, which means that
deadline entities are not dequeued right away on a server stop event.
However, the delay opens up a window in which a request for changing
server parameters can break per-runqueue running_bw tracking, as
reported by Yuri.

Close the problematic window by unconditionally calling dl_server_stop()
before applying the new parameters (ensuring deadline entities go
through an actual dequeue).

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20250721-upstream-fix-dlserver-lessaggressive-b4-v1-1-4ebc10c87e40@redhat.com
Signed-off-by: Lukas Beckmann <lbckmnn@mailbox.org>
---
 kernel/sched/debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 7d14e9fa53ac..564ea17ae405 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -378,10 +378,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_queued) {
-			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
-		}
+		update_rq_clock(rq);
+		dl_server_stop(&rq->fair_server);
 
 		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 
-- 
2.54.0


