Return-Path: <stable+bounces-239099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFsDBRNO5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:02:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D442EE0A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68893320831F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671544CAD3;
	Mon, 20 Apr 2026 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAgknYtY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FEC44CAC2;
	Mon, 20 Apr 2026 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691815; cv=none; b=BIMceYuXjbvrrFGQrDHFPdVtkV01dYhvWulGBZBjDPcfDOotiEXA1whHdhN0OxDzn/ZeJsvyOU2Nh7s1G8nSkLuARnKfmuZ8LTtz2/zVN14fLzVjeDEj5yif6x6ljSA59lk42MhUGZt6KNmQxIc/dUoj5S3/dn4aiU17N3NidUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691815; c=relaxed/simple;
	bh=+9tLxTbJEvLfYKwLP48Py/JtNZ4I5NlgVQExqjeMhLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFnQpP3Ag6qE4WoJxNT/tYw6LaQyXd+pftk0qC/w9HRp0HoGKMbO1h2xxV0sLP52eflphMgh3Imm/nn//nGyR8A7a9LwL7p1ZHTHePD7PK4vs/0JiEA2MPFyJk1PQ4cY0NeagtzwCucyQvFcfuTKlLXvOa1JlrLuu2h6muzLT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAgknYtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDACC19425;
	Mon, 20 Apr 2026 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691815;
	bh=+9tLxTbJEvLfYKwLP48Py/JtNZ4I5NlgVQExqjeMhLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mAgknYtYDousKKY6q3CaNdIp3cT8u5VXkE5zQNvhdFPH1/xV6K+0fWPieEni+qAPb
	 40SD0p/Lj0+F4DRhP83ZJ8ZvIY9F8MvG3rdLUkpeBiUtzEqNGwzhxEPvbTwZgLw8Yh
	 yOWTwZozIxVJU00GxuFPUMDZFsxUktR7yIau3ii7i38Rqpzok65ZUMbwyFjQ7YQSBx
	 yfUmpgPtxTufNajBEuyiQC95edZdyl6Dv3ifWy6vosNwEVf62BzASGSuemli1N3+lS
	 E0Fa9giH5b4ajuVO/qBgNeEAyd8DU67e1Fg7/QlYZCvrfzcrVQrLAiB8djVVu+cUdu
	 C2G0h83nknucw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] sched/deadline: Use revised wakeup rule for dl_server
Date: Mon, 20 Apr 2026 09:20:05 -0400
Message-ID: <20260420132314.1023554-211-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239099-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 901D442EE0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 14a857056466be9d3d907a94e92a704ac1be149b ]

John noted that commit 115135422562 ("sched/deadline: Fix 'stuck' dl_server")
unfixed the issue from commit a3a70caf7906 ("sched/deadline: Fix dl_server
behaviour").

The issue in commit 115135422562 was for wakeups of the server after the
deadline; in which case you *have* to start a new period. The case for
a3a70caf7906 is wakeups before the deadline.

Now, because the server is effectively running a least-laxity policy, it means
that any wakeup during the runnable phase means dl_entity_overflow() will be
true. This means we need to adjust the runtime to allow it to still run until
the existing deadline expires.

Use the revised wakeup rule for dl_defer entities.

Fixes: 115135422562 ("sched/deadline: Fix 'stuck' dl_server")
Reported-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: John Stultz <jstultz@google.com>
Link: https://patch.msgid.link/20260404102244.GB22575@noisy.programming.kicks-ass.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72499cf2a1db5..d5052f238adf7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1036,7 +1036,7 @@ static void update_dl_entity(struct sched_dl_entity *dl_se)
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, rq_clock(rq))) {
 
-		if (unlikely(!dl_is_implicit(dl_se) &&
+		if (unlikely((!dl_is_implicit(dl_se) || dl_se->dl_defer) &&
 			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 			     !is_dl_boosted(dl_se))) {
 			update_dl_revised_wakeup(dl_se, rq);
-- 
2.53.0


